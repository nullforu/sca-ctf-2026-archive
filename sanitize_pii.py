#!/usr/bin/env python3

from __future__ import annotations

import argparse
import bcrypt
import copy
import gzip
import io
import json
import os
import re
import tarfile
import tempfile
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any


EMAIL = re.compile(r"(?i)(?<![A-Z0-9.*_%+-])[A-Z0-9.*_%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}(?![A-Z0-9.*_%+-])")
MASKED_EMAIL = re.compile(r"^[^*@]\*{8}[^*@](?:_\d+)?@[^@]+$", re.I)
IP = re.compile(r"(?<![\d.])(?:25[0-5]|2[0-4]\d|1?\d?\d)(?:\.(?:25[0-5]|2[0-4]\d|1?\d?\d)){3}(?![\d.])")
BCRYPT = re.compile(r"\$2[aby]\$\d{2}\$[./A-Za-z0-9]{53}")
AWS_KEY = re.compile(r"\b(?:AKIA|ASIA)[A-Z0-9]{16}\b")
JWT = re.compile(r"\beyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\b")
PHONE = re.compile(r"(?<!\d)(?:\+?82[- ]?10|01[016789])[- ]?\d{3,4}[- ]?\d{4}(?!\d)")
RRN = re.compile(r"(?<!\d)(?:\d{6}|\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01]))[- ]?[1-4]\d{6}(?!\d)")
QUERY_SECRET = re.compile(r"(?i)([?&](?:code|state|access_token|id_token|token)=)[^&\s\"\\]+")
BEARER = re.compile(r"(?i)\bBearer\s+[^\s,}\]]+")
ASSIGNMENT = re.compile(
    r"(?ix)(?P<prefix>[\"']?[a-z0-9_-]*(?:password|passwd|secret|token|authorization|cookie|access[_-]?key|api[_-]?key|streamurl)[a-z0-9_-]*[\"']?\s*[:=]\s*)(?P<value>\"(?:\\.|[^\"])*\"|'(?:\\.|[^'])*'|[^,\s}\]]+)"
)


def is_secret_key(key: str) -> bool:
    key = key.lower()
    return any(part in key for part in ("password", "passwd", "secret", "token", "authorization", "cookie", "accesskey", "access_key", "apikey", "api_key", "streamurl"))


def is_text(data: bytes) -> str | None:
    if b"\x00" in data:
        return None
    try:
        return data.decode("utf-8")
    except UnicodeDecodeError:
        return None


def atomic_write(path: Path, data: bytes) -> None:
    with tempfile.NamedTemporaryFile(dir=path.parent, prefix=f".{path.name}.", delete=False) as temp:
        temp.write(data)
        temp_path = temp.name
    os.replace(temp_path, path)


def tar_inventory(data: bytes) -> list[tuple[str, bytes]]:
    with tarfile.open(fileobj=io.BytesIO(data), mode="r:*") as archive:
        return [(item.name, item.type) for item in archive.getmembers()]


def json_shape(value: Any) -> Any:
    if isinstance(value, dict):
        return {key: json_shape(item) for key, item in value.items()}
    if isinstance(value, list):
        return [json_shape(value[0])] if value else []
    return type(value).__name__


class Sanitizer:
    def __init__(self, root: Path) -> None:
        self.root = root.resolve()
        self.email_map: dict[str, str] = {}
        self.name_map: dict[str, str] = {}
        self.team_map: dict[str, str] = {}
        self.demo_hash = bcrypt.hashpw(b"example-password", bcrypt.gensalt(rounds=12)).decode("ascii")

    def mask_email(self, value: str, used: defaultdict[str, int]) -> str:
        local, domain = value.rsplit("@", 1)
        base = f"{local[0]}********{local[-1]}@{domain.lower()}"
        used[base] += 1
        return base if used[base] == 1 else base.replace("@", f"_{used[base]}@", 1)

    @staticmethod
    def mask_display(value: str, used: defaultdict[str, int]) -> str:
        if not value or value == r"\N":
            return value
        if re.search(r"[가-힣]", value):
            masked = "*" if len(value) == 1 else f"{value[0]}{'*' * max(1, len(value) - 2)}{value[-1]}"
        else:
            masked = "*" if len(value) == 1 else f"{value[0]}***{value[-1]}"
        used[masked] += 1
        return masked if used[masked] == 1 else f"{masked}_{used[masked]}"

    @staticmethod
    def mask_ip(value: str) -> str:
        fields = value.split(".")
        return f"{fields[0]}.***.***.{fields[3]}"

    def collect_archive_text(self, data: bytes, texts: list[str]) -> None:
        with tarfile.open(fileobj=io.BytesIO(data), mode="r:*") as archive:
            for item in archive.getmembers():
                if not item.isfile():
                    continue
                file = archive.extractfile(item)
                payload = file.read() if file else b""
                if item.name.endswith((".tar.gz", ".tgz", ".tar")):
                    self.collect_archive_text(payload, texts)
                elif (text := is_text(payload)) is not None:
                    texts.append(text)

    def collect_maps(self) -> None:
        emails: set[str] = set()
        names: set[str] = set()
        teams: set[str] = set()
        texts: list[str] = []
        for path in self.root.rglob("*"):
            if not path.is_file() or path.name == Path(__file__).name:
                continue
            if path.name.endswith((".tar.gz", ".tgz")):
                self.collect_archive_text(path.read_bytes(), texts)
            elif path.suffix == ".gz":
                texts.append(gzip.decompress(path.read_bytes()).decode("utf-8"))
            elif (text := is_text(path.read_bytes())) is not None:
                texts.append(text)
        for text in texts:
            emails.update(EMAIL.findall(text))

        play = self.root / "play_data.json"
        if play.exists():
            for user in json.loads(play.read_text()).get("users", []):
                names.add(user.get("username", ""))
                teams.add(user.get("team_name", ""))
        dump = self.root / "archive/db/app_db-20260719T094536Z.sql.gz"
        if dump.exists():
            active: str | None = None
            for line in gzip.decompress(dump.read_bytes()).decode("utf-8").splitlines():
                header = re.match(r"COPY public\.([a-z_]+) \(([^)]+)\) FROM stdin;", line)
                if header:
                    active = header.group(1)
                    continue
                if line == r"\.":
                    active = None
                    continue
                fields = line.split("\t")
                if active == "users" and len(fields) >= 3:
                    names.add(fields[2])
                elif active == "teams" and len(fields) >= 2:
                    teams.add(fields[1])
                elif active == "discord_connections" and len(fields) >= 5:
                    names.update(item for item in fields[3:5] if item != r"\N")

        email_used: defaultdict[str, int] = defaultdict(int)
        name_used: defaultdict[str, int] = defaultdict(int)
        team_used: defaultdict[str, int] = defaultdict(int)
        self.email_map = {item: self.mask_email(item, email_used) for item in sorted((item for item in emails if "*" not in item), key=str.lower)}
        self.name_map = {item: self.mask_display(item, name_used) for item in sorted(filter(None, names), key=lambda item: (-len(item), item))}
        self.team_map = {item: self.mask_display(item, team_used) for item in sorted(filter(None, teams), key=lambda item: (-len(item), item))}

    def mask_log_text(self, text: str) -> str:
        text = EMAIL.sub(lambda match: match.group(0) if "*" in match.group(0) else self.email_map[match.group(0)], text)
        text = IP.sub(lambda match: self.mask_ip(match.group(0)), text)
        text = AWS_KEY.sub("[REDACTED_AWS_ACCESS_KEY]", text)
        text = JWT.sub("[REDACTED_JWT]", text)
        # Bare digit sequences in telemetry frequently resemble Korean RRN/phone
        # formats. Only redact those values when their structured field identifies
        # them as PII (handled in transform_json below).
        text = QUERY_SECRET.sub(lambda match: f"{match.group(1)}[REDACTED]", text)
        text = BEARER.sub("Bearer [REDACTED]", text)
        def redact(match: re.Match[str]) -> str:
            value = match.group("value")
            if value.startswith('"'):
                value = '"[REDACTED]"'
            elif value.startswith("'"):
                value = "'[REDACTED]'"
            else:
                value = "[REDACTED]"
            return match.group("prefix") + value
        return ASSIGNMENT.sub(redact, text)

    def transform_json(self, value: Any, key: str | None = None) -> Any:
        if isinstance(value, dict):
            return {name: self.transform_json(item, name) for name, item in value.items()}
        if isinstance(value, list):
            return [self.transform_json(item, key) for item in value]
        if not isinstance(value, str):
            return value
        lowered = (key or "").lower()
        if is_secret_key(lowered) or lowered in {
            "phone", "phone_number", "mobile", "mobile_number", "tel",
            "telephone", "rrn", "resident_registration_number",
        }:
            return "[REDACTED]"
        if lowered in {"discord_user_id", "principalid", "eventid", "sessionid"}:
            return "[REDACTED_ID]"
        if lowered in {"username", "user_name", "discord_username", "discord_global_name"}:
            return self.name_map.get(value, self.mask_display(value, defaultdict(int)))
        if lowered == "team_name":
            return self.team_map.get(value, self.mask_display(value, defaultdict(int)))
        if lowered == "email":
            return value if "*" in value else self.email_map[value]
        return self.mask_log_text(value)

    def transform_sql(self, text: str) -> str:
        lines = text.splitlines(keepends=True)
        output: list[str] = []
        table: str | None = None
        columns: list[str] = []
        for line in lines:
            header = re.match(r"COPY public\.([a-z_]+) \(([^)]+)\) FROM stdin;", line)
            if header:
                table = header.group(1)
                columns = [item.strip() for item in header.group(2).split(",")]
                output.append(line)
                continue
            if table and line == "\\.\n":
                table, columns = None, []
                output.append(line)
                continue
            if table:
                values = line.rstrip("\n").split("\t")
                if len(values) == len(columns):
                    for index, column in enumerate(columns):
                        if values[index] == r"\N":
                            continue
                        if column == "email":
                            values[index] = values[index] if "*" in values[index] else self.email_map[values[index]]
                        elif column in {"username", "discord_username", "discord_global_name"}:
                            values[index] = self.name_map.get(values[index], self.mask_display(values[index], defaultdict(int)))
                        elif table == "teams" and column == "name":
                            values[index] = self.team_map.get(values[index], self.mask_display(values[index], defaultdict(int)))
                        elif column == "discord_user_id":
                            values[index] = "[REDACTED_ID]"
                        elif column == "password_hash":
                            values[index] = self.demo_hash
                        elif column in {"used_by_ip", "external_ip"}:
                            values[index] = IP.sub(lambda match: self.mask_ip(match.group(0)), values[index])
                    line = "\t".join(values) + "\n"
            output.append(line)
        result = BCRYPT.sub(self.demo_hash, "".join(output))
        note = f"-- PII masking: bcrypt hashes below were replaced with this valid hash for example-password: {self.demo_hash}\n"
        return result if result.startswith("-- PII masking:") else note + result

    def transform_tar(self, data: bytes) -> bytes:
        result = io.BytesIO()
        with tarfile.open(fileobj=io.BytesIO(data), mode="r:*") as source, tarfile.open(fileobj=result, mode="w:gz") as target:
            for item in source.getmembers():
                copied = copy.copy(item)
                if not item.isfile():
                    target.addfile(copied)
                    continue
                file = source.extractfile(item)
                payload = file.read() if file else b""
                if item.name.endswith((".tar.gz", ".tgz", ".tar")):
                    payload = self.transform_tar(payload)
                elif item.name.endswith(".json") and (text := is_text(payload)) is not None:
                    payload = (json.dumps(self.transform_json(json.loads(text)), ensure_ascii=False, indent=2) + "\n").encode("utf-8")
                elif (text := is_text(payload)) is not None:
                    payload = self.mask_log_text(text).encode("utf-8")
                copied.size = len(payload)
                target.addfile(copied, io.BytesIO(payload))
        return result.getvalue()

    def apply(self) -> None:
        self.collect_maps()
        before_tar = {path: tar_inventory(path.read_bytes()) for path in self.root.rglob("*.tar.gz")}
        before_json = {path: json_shape(json.loads(path.read_text())) for path in self.root.rglob("*.json")}
        dump = self.root / "archive/db/app_db-20260719T094536Z.sql.gz"
        before_sql = gzip.decompress(dump.read_bytes()).decode("utf-8") if dump.exists() else ""
        ddl_headers = re.findall(r"(?:CREATE TABLE public\.[\s\S]*?\n\);|COPY public\.[^\n]+)", before_sql)
        for path in sorted(self.root.rglob("*")):
            if not path.is_file() or path.name == Path(__file__).name:
                continue
            print(f"processing={path.relative_to(self.root)}", flush=True)
            original = path.read_bytes()
            if path.name.endswith((".tar.gz", ".tgz")):
                updated = self.transform_tar(original)
            elif path.suffix == ".gz":
                text = gzip.decompress(original).decode("utf-8")
                if path.name.endswith(".jsonl.gz"):
                    updated_text = "\n".join(
                        json.dumps(self.transform_json(json.loads(line)), ensure_ascii=False)
                        for line in text.splitlines() if line.strip()
                    ) + "\n"
                else:
                    updated_text = self.transform_sql(text) if path.name.endswith(".sql.gz") else self.mask_log_text(text)
                updated = gzip.compress(updated_text.encode("utf-8"), mtime=0)
            elif path.suffix == ".json":
                updated = (json.dumps(self.transform_json(json.loads(original.decode("utf-8"))), ensure_ascii=False, indent=2) + "\n").encode("utf-8")
            elif (text := is_text(original)) is not None:
                updated = self.mask_log_text(text).encode("utf-8")
            else:
                continue
            if updated != original:
                atomic_write(path, updated)
        for path, shape in before_json.items():
            if json_shape(json.loads(path.read_text())) != shape:
                raise RuntimeError(f"JSON structure changed: {path}")
        for path, inventory in before_tar.items():
            if tar_inventory(path.read_bytes()) != inventory:
                raise RuntimeError(f"tar member inventory changed: {path}")
        after_sql = gzip.decompress(dump.read_bytes()).decode("utf-8") if dump.exists() else ""
        if re.findall(r"(?:CREATE TABLE public\.[\s\S]*?\n\);|COPY public\.[^\n]+)", after_sql) != ddl_headers:
            raise RuntimeError("SQL DDL or COPY headers changed")

    def mask_top_level_team_names(self) -> int:
        """Mask only the participant-team catalogue, not arbitrary `name` fields."""
        path = self.root / "play_data.json"
        payload = json.loads(path.read_text())
        teams = payload.get("teams", [])
        originals = [entry.get("name", "") for entry in teams if entry.get("name")]
        used: defaultdict[str, int] = defaultdict(int)
        mapping = {
            value: self.mask_display(value, used)
            for value in sorted(set(originals), key=lambda item: (-len(item), item))
        }
        changed = 0
        for entry in teams:
            value = entry.get("name")
            if value in mapping and entry["name"] != mapping[value]:
                entry["name"] = mapping[value]
                changed += 1
        atomic_write(path, (json.dumps(payload, ensure_ascii=False, indent=2) + "\n").encode("utf-8"))
        return changed


def verify(root: Path) -> Counter[str]:
    findings: Counter[str] = Counter()
    def inspect(data: bytes) -> None:
        if (text := is_text(data)) is None:
            return
        for address in EMAIL.findall(text):
            if not MASKED_EMAIL.fullmatch(address):
                findings["unmasked_email"] += 1
        findings["unmasked_ip"] += len(IP.findall(text))
        findings["aws_key"] += len(AWS_KEY.findall(text))
    def inspect_tar(data: bytes) -> None:
        with tarfile.open(fileobj=io.BytesIO(data), mode="r:*") as archive:
            for item in archive.getmembers():
                if item.isfile():
                    file = archive.extractfile(item)
                    payload = file.read() if file else b""
                    if item.name.endswith((".tar.gz", ".tgz", ".tar")):
                        inspect_tar(payload)
                    else:
                        inspect(payload)
                        if item.name.endswith(".json"):
                            json.loads(payload.decode("utf-8"))
    for path in root.rglob("*"):
        if not path.is_file() or path.name == Path(__file__).name:
            continue
        if path.name.endswith((".tar.gz", ".tgz")):
            inspect_tar(path.read_bytes())
        elif path.suffix == ".gz":
            data = gzip.decompress(path.read_bytes())
            inspect(data)
            if path.name.endswith(".jsonl.gz"):
                for line in data.decode("utf-8").splitlines():
                    if line.strip():
                        json.loads(line)
        else:
            data = path.read_bytes()
            inspect(data)
            if path.suffix == ".json":
                json.loads(data.decode("utf-8"))
    return findings


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("root", nargs="?", type=Path, default=".")
    parser.add_argument("--verify-only", action="store_true")
    parser.add_argument("--mask-team-names-only", action="store_true")
    args = parser.parse_args()
    root = args.root.resolve()
    if args.mask_team_names_only:
        print(f"team_names_masked={Sanitizer(root).mask_top_level_team_names()}")
    elif not args.verify_only:
        Sanitizer(root).apply()
    findings = verify(root)
    for key in ("unmasked_email", "unmasked_ip", "aws_key", "phone", "rrn"):
        print(f"{key}={findings[key]}")
    if any(findings[key] for key in ("unmasked_email", "aws_key")):
        raise SystemExit("verification failed")


if __name__ == "__main__":
    main()
