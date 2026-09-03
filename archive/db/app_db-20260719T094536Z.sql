-- PII masking: bcrypt hashes below were replaced with this valid hash for example-password: $2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe
--
-- PostgreSQL database dump
--

\restrict CsFZfWVI9zD7EIphbrr28j13VrL3f9GidcikL8WqsQ5yuZFia6YyHtF2ANPQ3Ru

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_configs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_configs (
    key character varying NOT NULL,
    value character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: challenges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.challenges (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description character varying NOT NULL,
    points bigint DEFAULT 0 NOT NULL,
    minimum_points bigint DEFAULT 0 NOT NULL,
    category character varying NOT NULL,
    flag_hash character varying NOT NULL,
    previous_challenge_id bigint,
    file_key character varying,
    file_name character varying,
    file_uploaded_at timestamp with time zone,
    vm_enabled boolean DEFAULT false NOT NULL,
    vm_spec character varying,
    is_active boolean NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.challenges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.challenges_id_seq OWNED BY public.challenges.id;


--
-- Name: discord_connections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discord_connections (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    discord_user_id character varying NOT NULL,
    discord_username character varying,
    discord_global_name character varying,
    discord_avatar character varying,
    role_status character varying DEFAULT 'CONNECTED'::character varying NOT NULL,
    connected_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    verified_at timestamp with time zone,
    revoked_at timestamp with time zone,
    last_synced_at timestamp with time zone,
    last_error character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: discord_connections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discord_connections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discord_connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discord_connections_id_seq OWNED BY public.discord_connections.id;


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.divisions (
    id bigint NOT NULL,
    name character varying NOT NULL,
    discord_role_id character varying,
    discord_announce_channel_id character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: divisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.divisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: divisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.divisions_id_seq OWNED BY public.divisions.id;


--
-- Name: registration_key_uses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registration_key_uses (
    id bigint NOT NULL,
    registration_key_id bigint NOT NULL,
    used_by bigint NOT NULL,
    used_by_ip character varying NOT NULL,
    used_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: registration_key_uses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registration_key_uses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_key_uses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registration_key_uses_id_seq OWNED BY public.registration_key_uses.id;


--
-- Name: registration_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registration_keys (
    id bigint NOT NULL,
    code character varying NOT NULL,
    created_by bigint NOT NULL,
    team_id bigint NOT NULL,
    max_uses bigint DEFAULT 1 NOT NULL,
    used_count bigint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: registration_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registration_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registration_keys_id_seq OWNED BY public.registration_keys.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    challenge_id bigint NOT NULL,
    correct boolean DEFAULT false NOT NULL,
    is_first_blood boolean DEFAULT false NOT NULL,
    submitted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying NOT NULL,
    division_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying NOT NULL,
    username character varying NOT NULL,
    password_hash character varying NOT NULL,
    role character varying NOT NULL,
    team_id bigint NOT NULL,
    blocked_reason character varying,
    blocked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vms (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    challenge_id bigint NOT NULL,
    vm_id character varying NOT NULL,
    status character varying NOT NULL,
    node_name character varying,
    external_ip character varying,
    ports jsonb,
    ttl_expires_at timestamp with time zone,
    last_error character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: vms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vms_id_seq OWNED BY public.vms.id;


--
-- Name: challenges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenges ALTER COLUMN id SET DEFAULT nextval('public.challenges_id_seq'::regclass);


--
-- Name: discord_connections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discord_connections ALTER COLUMN id SET DEFAULT nextval('public.discord_connections_id_seq'::regclass);


--
-- Name: divisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.divisions ALTER COLUMN id SET DEFAULT nextval('public.divisions_id_seq'::regclass);


--
-- Name: registration_key_uses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_key_uses ALTER COLUMN id SET DEFAULT nextval('public.registration_key_uses_id_seq'::regclass);


--
-- Name: registration_keys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_keys ALTER COLUMN id SET DEFAULT nextval('public.registration_keys_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vms ALTER COLUMN id SET DEFAULT nextval('public.vms_id_seq'::regclass);


--
-- Data for Name: app_configs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.app_configs (key, value, updated_at) FROM stdin;
header_description	Capture The Flag	2026-07-17 11:13:35.896679+00
ctf_end_at	2026-07-19T18:00:00+09:00	2026-07-18 05:43:26.37947+00
header_title	SCA CTF	2026-07-18 05:46:05.27713+00
title	SCA CTF 2026	2026-07-18 05:46:11.461572+00
description	Welcome to SCA CTF 2026!	2026-07-18 05:46:28.611584+00
ctf_start_at		2026-07-19 00:00:18.273598+00
\.


--
-- Data for Name: challenges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.challenges (id, title, description, points, minimum_points, category, flag_hash, previous_challenge_id, file_key, file_name, file_uploaded_at, vm_enabled, vm_spec, is_active, created_at) FROM stdin;
5	Quarantine Journal	SCA 오이데 맛테루요~\n\n---\n\n- 제공 파일 MD5 = `23f4bb49838ce22025a8b912008dc613`	1000	100	Reversing	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	fd539e68-de26-4e5f-97cf-906a5ee8eb3f.zip	QuarantineJournal.zip	2026-07-17 03:38:19.519646+00	f	\N	t	2026-07-17 03:38:19.134818+00
1	Metric Forge - Web	Metric Forge는 고객 성공(Customer Success, CS) 팀이 고객 계정을 분류, 관리 및 분석하며 CRM으로 잔달할 데이터를 구축하는 데 사용하는 매출 분석/운영/관리 도구입니다.\n\n이 서비스는 최근 레거시한 API를 제거하고 개선된 API를 구축하였으며, 이러한 API에 대해 `x` 접두사를 붙이며 이를 소개하고 문서화하는 작업을 진행했습니다.\n\n그러한 과정에서 일부 레거시한 API가 남게되었고, 이러한 API 중 일부에 대해 취약점이 보고되었다고 합니다.\n\nProfessional Vulnerability Research인 당신은 이러한 취약점을 Exploit하여 Flag를 획득해야 합니다. Flag는 `SCA{...}` 형식입니다.\n\n> - 본 문제는 트래픽 Outbound를 허용하지 않습니다.\n> - VM을 실행할때 시간이 오래 걸릴 수 있습니다. 1~2분 정도 기다려주세요.\n\n---\n\n- 제공 파일 MD5: `73905c17d48d8fb2c54546d564bd8957`\n	1000	100	Web	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	eaa111ba-6dc1-4dab-a938-0d788a243772.zip	metric_forge_web_for_user.zip	2026-07-17 03:28:39.985893+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: metricforge\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - container_port: 80\n      protocol: tcp\n  readiness_probe:\n    protocol: http\n    path: /\n    port: 80\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  volumes:\n    - name: runtime-state\n      ephemeral_storage: 64Mi\n  containers:\n    - name: db\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-metric_forge_db\n      args: []\n      env:\n        - MARIADB_DATABASE=appdb\n        - MARIADB_USER=metricforge\n        - MARIADB_PASSWORD=ME2qBLSxzC1uGwgKiCAw\n        - MARIADB_ROOT_PASSWORD=giAmZFJICuVrZugya79V\n      workDir: ""\n      volume_mounts:\n        - name: runtime-state\n          mount_path: /var/www/html\n      resource:\n        cpu: 500m\n        memory: 128Mi\n        ephemeral_storage: 512Mi\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-metric_forge_web\n      args:\n        - sh\n        - -c\n        - for i in $(seq 1 90); do php -r '$s=@fsockopen("127.0.0.1",3306,$e,$es,1); if($s){fclose($s); exit(0);} exit(1);' && break; sleep 2; done; exec /entrypoint.sh\n      env:\n        - DB_HOST=127.0.0.1\n        - DB_PORT=3306\n        - DB_ROOT_USER=root\n        - DB_ROOT_PASSWORD=giAmZFJICuVrZugya79V\n        - DB_NAME=appdb\n        - DB_USER=metricforge\n        - DB_PASSWORD=ME2qBLSxzC1uGwgKiCAw\n      workDir: ""\n      volume_mounts:\n        - name: runtime-state\n          mount_path: /var/www/html\n      resource:\n        cpu: 500m\n        memory: 128Mi\n        ephemeral_storage: 512Mi	t	2026-07-17 03:28:39.663575+00
2	Is this an HTTP server?	HTTP 서버가 맞을까요? 코드는 또 왜 이렇죠? 🤔\n\n개발자는 아주 간단한 JSON Validator라고 하네요.\n\n---\n\n- 제공 파일 MD5 = `c87fb3836f76076358d42a74456ed391`	1000	100	Web	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	d584e69f-2916-462c-8d85-2a0ae6f3189a.zip	is_this_an_http_server_for_user.zip	2026-07-17 03:30:10.529503+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: requirepp\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 1337\n      protocol: tcp\n  readiness_probe:\n    protocol: tcp\n    port: 1337\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-is_this_an_http_server:latest\n      args: []\n      env: []\n      workDir: ""\n      resource:\n        cpu: 500m\n        memory: 128Mi	t	2026-07-17 03:30:10.208368+00
6	Dolphin Drop	테트리스?\n\n---\n\n- 제공 파일 MD5 = `f6bcc6e1d5a437c5898623ca71a1f385`	1000	100	Reversing	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	f1f5e260-8e6c-4b9e-8aad-e0c05f8cb876.zip	DolphinDrop.zip	2026-07-18 10:18:06.753549+00	f	\N	t	2026-07-17 03:38:54.285094+00
8	Матрёшка	다음은 뭘까요?\n\n---\n\n- 제공 파일 MD5 = `5c6fe0f24aa3ef5cd01bdbbc771fcbf0`	1000	100	Reversing	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	0b8ac644-ebf9-4bae-9e6a-dea4ecd8d7a5.zip	for_user.zip	2026-07-17 03:41:05.908359+00	f	\N	t	2026-07-17 03:41:05.482789+00
7	Did you hear that?	- 문제 파일: [https://drive.google.com/file/d/1BlUct6csBXnXV8B6jdtNkbFPq0GvLTtG/view](https://drive.google.com/file/d/1BlUct6csBXnXV8B6jdtNkbFPq0GvLTtG/view)\n- 제공 파일 MD5 = `f741bab5f3114a799ea22161ab77e873`	1000	100	Reversing	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	f	\N	t	2026-07-17 03:40:12.614921+00
4	CAT Market	귀여운 고양이들을 구매하세요!\n\n고양이 마켓에서는 상품을 구매할 수도 있고, 마음이 바뀌면 거래를 취소할 수도 있습니다.\n\n- 본 문제는 소스코드를 공개하지 않는 블랙박스 문제입니다.\n- 봇은 30초마다 초기화되며 VM 재생성을 하지 않아도 다시 시도하시면 페이로드 정상 동작합니다. 	1000	100	Web	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: cat_market\nspec:\n  egress: true\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 8000\n      protocol: tcp\n  readiness_probe:\n    protocol: http\n    path: /\n    port: 8000\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-cat_market:v5\n      args: []\n      env: []\n      workDir: ""\n      resource:\n        cpu: 1000m\n        memory: 1024Mi	t	2026-07-17 03:37:33.121685+00
16	Metric Forge - Cloud	Metric Forge는 고객 매출 운영 데이터를 분류하고 분석하여 비즈니스 인사이트를 제공했던 SaaS(Software as a Service) 서비스였습니다.\n얼마 전 보안 사고 이후 서비스는 정리되어 공개 데모만 남았지만, 사고 당시 급하게 구축한 복구 파이프라인의 권한 일부가 아직 회수되지 않았다는 제보가 접수되었습니다.\n\n침해 사고 조사관의 입장에서, 공개적으로 접근 가능한 환경에서 경로를 찾아 아래의 규칙에 맞는 Flag를 완성해야 합니다.\n\n### Flag 형식\n\n```\nSCA{SHA256(A_B_C_D)}\n= SCA{SHA256(<16진수 12자>_ami-<16진수 17자>_<16진수 16자>_<16진수 16자>)}\n```\n\n- `A` — 취약한 동작이 처음 도입된 Git 커밋 해시의 앞 12자리. 소문자 16진수 12자.\n- `B` — 올바른 복구 AMI의 ID. `ami-` 접두사를 포함하며, (하이픈 포함)\n- `C` — 유효한 DSSE Envelope의 `payload`(Base64)를 디코딩한 바이트열의 SHA256 해시(소문자 16진수)의 앞 16자.\n- `D` — 최종 복구 권한으로 읽어낸 시드 값을 키로 삼아 계산하는 증명값으로, 소문자 16진수 16자임.\n해당 시드를 HMAC 키로 하고 메시지 `A|B|C|metricforge.swua.kr`(앞의 A·B·C를 플래그에 쓰는\n값 그대로 두고, 도메인까지 파이프 `|`로 이어 붙인 문자열. B는 `ami-` 접두사를 포함)를 HMAC-SHA256으로\n계산한 16진수 Digest의 앞 16자임.\n\n### 주소\n\n- http://metricforge.swua.kr (HTTPS를 사용하지 않음)\n\n> 본 문제는 AWS 계정과 Github 계정을 요구하며, 풀이자의 부주의로 인해 발생하는 비용은 전적으로 풀이자에게 책임이 있습니다. AWS 계정과 Github 계정은 반드시 본인 소유의 계정을 사용하시기 바랍니다.	1000	100	Cloud	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	f	\N	t	2026-07-17 03:55:08.531243+00
17	Sanity Check	대회 참가 계정과 디스코드 계정을 연동하면 플래그를 확인할 수 있습니다.\n\nprofile에서 계정 연동을 완료한 뒤 디스코드 서버에서 플래그를 찾아 제출하세요.\n	1	1	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	f	\N	t	2026-07-17 06:09:12.485081+00
15	airgap_courier	Someone sent us a short recording from an old camera. At first glance, it looks like nothing more than a flickering screen. But they insisted it was important. Can you figure out why?\n\n---\n\n- 제공 파일 MD5 = `825f5d09bd5078b57ac4dfa95737eeff`	1000	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	ceb8cab8-aff8-426e-aede-5aba5971b6d3.zip	airgap_courier_player.zip	2026-07-18 10:34:31.903918+00	f	\N	t	2026-07-17 03:47:11.321916+00
14	Offbeat	플래그 형식은 다음과 같습니다.\n\n```\nSCA{복호화된_문자열}\n```\n\n플래그에 포함된 ` `은 `_`로 변환합니다.\n\n모든 복호화된 문자열은 소문자입니다.\n\n???: 필터링 없이 건너뛴 칸을 순서대로 그대로 읽기 \n???: 첫 `41 * 41`개를 받침 획수 홀짝\n\n---\n\n- 제공 파일 MD5 = `399eb1b50a458e0831a98bfbea0c48d4`	1000	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	c965fe78-1e46-4eb2-9a53-344eb9e59325.zip	Offbeat.zip	2026-07-17 03:46:37.58932+00	f	\N	t	2026-07-17 03:46:37.269213+00
11	pixring	A tiny terminal image viewer for PNGs and JPEGs. Preview your pictures, restore your workspace, and keep the ring going.\n\n---\n\n- 제공 파일 MD5 = `55e02af869959479c0923e0083aeb145`	1000	100	Pwnable	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	3eecffa7-4b30-4d59-85ae-47d5fbd48f95.zip	pixring_public.zip	2026-07-18 10:27:00.67062+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: pixring\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 31340\n      protocol: tcp\n  readiness_probe:\n    protocol: tcp\n    port: 31340\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-pixring:v4\n      args: []\n      env: []\n      work_dir: ""\n      security_opt:\n      - seccomp=unconfined\n      resource:\n        cpu: 1000m\n        memory: 1024Mi	t	2026-07-17 03:44:09.238731+00
10	captiond	Queue your captions, review them, discard the bad ones, and shut down the service when you're done.\n\n---\n\n- 제공 파일 MD5 = `7f16180c687008d6f5e458e764796352`	1000	100	Pwnable	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	c82c7f55-8538-43c2-b622-5ef57a02b576.zip	captiond_for_user.zip	2026-07-19 02:45:31.664276+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: captiond\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 31337\n      protocol: tcp\n  readiness_probe:\n    protocol: tcp\n    port: 31337\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-captiond:v3\n      args: []\n      env: []\n      workDir: ""\n      resource:\n        cpu: 500m\n        memory: 128Mi\n      security_opt: ["no-new-privileges:false"]	t	2026-07-17 03:43:05.259674+00
12	profile_migration	A legacy service for preparing profile migration drafts.\n\n---\n\n- 제공 파일 MD5 = `9ae5963a891346a5e38405374bf61d75`	1000	100	Pwnable	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	58f8ae85-258c-4b2c-b452-353687945b0e.zip	profile_migration_for_user.zip	2026-07-18 10:27:28.643226+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: profile_migration\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 31337\n      protocol: tcp\n  readiness_probe:\n    protocol: tcp\n    port: 31337\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-profile_migration:v3\n      args: []\n      env: []\n      workDir: ""\n      resource:\n        cpu: 1000m\n        memory: 1024Mi	t	2026-07-17 03:44:53.487947+00
18	FAULTLINE	everything is working as intended\n\n---\n\n- 제공 파일 MD5 = `19eb43fa003f05fe52090e882b444fcf`	1000	100	Reversing	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	5d91fcce-3b1c-4867-8914-1391986c2133.zip	FAULTLINE.zip	2026-07-18 10:21:26.508598+00	f	\N	t	2026-07-18 10:21:26.175723+00
26	Challenge 07 — Dreamy, Hypnotic, Surreal, Ethereal	스카이워크 인근에서 발견된 쪽지에는 다음과 같은 문장이 적혀 있었다.\n\n> **I love this SPOT🎶**\n\n![image](http://cdn.sca-ctf.com/7.webp)\n\n또한 고세명의 러닝 기록을 시간대별로 분석한 결과, 이동 경로에서 하나의 문자열을 확인할 수 있었다.\n\n수사팀은 러닝 경로에서 확인한 문자열은 고세명이 애용하는 아이디일 가능성이 높다고 판단하여, 그의 계정을 찾아냈다. \n\n그의 프로필 계정은 다음과 같다,\n\nhttps://open.spotify.com/user/31vommhzulnotnzilibj4xhw2bhm\n\n하지만 계정에는 한 때 유행했던 추억의 노래들만 들어있을 뿐, 별 다른 특이사항을 찾지 못했다.\n\n### Your Task\n\n고세명이 남긴 힌트를 찾아라.\n\n### Answer Format\n\n- 정답은 `SCA{answer}` 형식을 사용한다.	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	24	93471237-22e8-42f9-8f53-8b0ff49447be.zip	7.webp.zip	2026-07-18 12:32:49.287077+00	f	\N	t	2026-07-18 11:00:55.476687+00
19	find_the_easteregg	[https://www.youtube.com/watch?v=lOrU0MH0bMk](https://www.youtube.com/watch?v=lOrU0MH0bMk) * 10	1	1	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	f	\N	t	2026-07-18 10:41:40.239065+00
23	Challenge 04 — Remember me..	### 문제 본문\n\n이전 단계에서 고세명이 사용한 것으로 추정되는 X 계정의 아이디를 확보한 수사팀은 해당 프로필에 접근했다.\n\n하지만 계정에는 외부 브이로그 사이트 하나 밖에 남아있지 않았다. \n\n수사팀은 고세명이 도주 직전 자신의 브이로그를 급하게 정리한 것으로 판단했다.\n\n### Your Task\n\n고세명의 계정 사이트를 파헤쳐서 비밀을 알아내자.\n\n### Answer Format\n\n`SCA{FLAG}`	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	22	\N	\N	\N	f	\N	t	2026-07-18 10:58:51.483439+00
22	Challenge 03 — Shooting Star	고세명의 영상에서 확인된 장소에 도착한 수사팀은 즉시 주변을 수색했다. 그러나 현장에는 마약은 물론, 물건을 보관하거나 전달한 흔적조차 남아 있지 않았다. 고세명 또는 공범이 수사팀보다 먼저 현장을 정리한 것으로 보였다.\n\n별다른 성과 없이 수사가 지연되던 중, 감시 중이던 SNS에 짧은 게시물 하나가 올라왔다.\n\n> **별보단 새가 보기 힘들긴 하지~**\n> \n\n게시물은 얼마 지나지 않아 삭제되었고, 이를 작성한 계정 역시 곧 사라졌다.\n\n수사팀은 이 문장이 고세명이 사용 중인 다른 소셜 미디어 플랫폼을 암시한다고 판단했다. 또한 고세명은 자신이 추적당하고 있다는 사실을 이미 인지한 것으로 보인다.\n\n앞서 확보한 사건 파일의 인적사항과 게시물에 남겨진 표현을 분석하여, 고세명이 사용 중인 계정의 아이디를 찾아내야 한다.\n\n그도 한국인인 만큼, 아이디를 만드는 방식 역시 우리에게 익숙한 방식과 크게 다르지 않았을 것이다.\n\n### Your Task\n\n고세명이 사용 중인 것으로 추정되는 계정 의 USER ID를 확인하라.\n\n### Answer Format\n\n- 정답은 `SCA{USERID}` 형식을 사용한다.\n\n```\nEXAMPLE: SCA{44196397}\n```	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	21	\N	\N	\N	f	\N	t	2026-07-18 10:57:27.122651+00
24	Challenge 05 — The Other Walk	Wayback Machine을 통해 고세명의 브이로그 과거 기록을 복원한 수사팀은 현재 페이지에서는 삭제된 사진 한 장과 메시지를 발견했다.\n\n사진에는 실제 구조물을 축소해 만든 것으로 보이는 모형이 담겨 있었으며, 그 아래에는 다음과 같은 문장이 적혀 있었다.\n\n> **나 원래는 여기 숨기려 했는데, 이름이 헷갈리는 곳이 있더라? ㅋㅋ\n다음은 거기로 와.**\n> \n\n수사팀은 이 사진이 물건이 숨겨진 장소를 직접 보여주는 것이 아니라, 고세명이 다음 목적지를 전달하기 위해 남긴 단서라고 판단했다.\n\n사진 속 대상의 이름을 확인하고, 고세명이 말한 **“이름이 헷갈리는 곳”**이 어디를 의미하는지 추론해야 한다.\n\n### Your Task\n\n사진과 메시지를 분석하여 고세명이 다음 목적지로 지목한 장소의 명칭을 확인하라.\n\n사진에 나타난 대상의 이름이 아니라, 고세명이 **“거기로 와”**라고 지칭한 다음 장소를 제출해야 한다.\n\n### Answer Format\n\n- 정답은 `SCA{answer}` 형식을 사용한다.\n- 장소명은 한글로 작성한다.\n- 장소의 명칭은 구글 지도를 기반으로 작성한다.\n- 띄어쓰기가 있는 경우 `_`로 대체한다.\n\n`SCA{PLACE_NAME}`	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	23	\N	\N	\N	f	\N	t	2026-07-18 10:59:23.104819+00
13	Visualization of sound	CQ CQ...\n\n---\n\n- 문제 파일 : [https://drive.google.com/file/d/1XwyOZ21YNfdZgWbrX-Xgnqhl7hOK79_U/view](https://drive.google.com/file/d/1XwyOZ21YNfdZgWbrX-Xgnqhl7hOK79_U/view)\n- 서브 링크1: [https://drive.google.com/file/d/1eND5c0-R4D-wJP3TNKYRo8qw1FV83mtU/view](https://drive.google.com/file/d/1eND5c0-R4D-wJP3TNKYRo8qw1FV83mtU/view) \n- 서브 링크2: [https://drive.google.com/file/d/1LQFr7e0jCxlF2BsRAhBHKZPP4rBslLR7/view](https://drive.google.com/file/d/1LQFr7e0jCxlF2BsRAhBHKZPP4rBslLR7/view)\n- 서브 링크3: [https://drive.google.com/file/d/1LUQJGBNOdMHgMLYmP9H_NM5yeKvk0_SG/view](https://drive.google.com/file/d/1LUQJGBNOdMHgMLYmP9H_NM5yeKvk0_SG/view)\n- 서브 링크4: [https://drive.google.com/file/d/13G9O6h_vAOR9NEvkTKSchJadovjCm0Er/view](https://drive.google.com/file/d/13G9O6h_vAOR9NEvkTKSchJadovjCm0Er/view)\n\n- 제공 파일 MD5 = `260d55a9a640454487cdc140e44677cc`	1000	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	\N	\N	\N	f	\N	t	2026-07-17 03:45:43.069855+00
27	Challenge 08 — Life is CTF	Spotify 플레이리스트에서 `COME_TO_UNIV`라는 메시지를 확인한 수사팀은 고세명의 최근 동선과 이동 가능 범위를 분석했다.\n\n수사팀은 인근 대학 가운데 **포항대학교**를 우선 수색했다. 교내 CCTV 기록을 확인한 결과, 고세명으로 추정되는 인물이 한 사물함에 무언가를 넣고 현장을 떠나는 모습이 포착되었다.\n\n수사팀은 즉시 해당 사물함을 개방했다. 내부에는 짧은 메모가 적힌 쪽지 한 장이 남아 있었다.\n\n이 쪽지가 고세명의 마지막 도주 위치를 뜻한다고 판단했다.\n\n그의 마지막 위치를 위도 경도 소수 5번째 자리까지 정밀하게 추적하라.\n\n![image](http://cdn.sca-ctf.com/8.webp)\n\n정답 양식:\n\n`SCA{XX.XXXXX, XX.XXXXX}`	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	26	5ba3da48-39d5-4121-8f4a-d26ab5f7e4dd.zip	8.webp.zip	2026-07-18 12:32:54.217933+00	f	\N	t	2026-07-18 11:02:01.288307+00
25	Challenge 06 — Re::cord	고세명이 말한 다음 목적지가 스카이워크라고 판단한 수사팀은 즉시 현장으로 이동하여 주변을 수색했다.\n\n그러나 현장에서도 마약이나 전달 물품은 발견되지 않았다. 대신 구조물 인근에서 누군가 남긴 것으로 보이는 짧은 문구가 발견되었다.\n\n> **I love this “spot.”.**\n> \n\n수사팀은 따옴표로 강조된 `spot`이 단순히 장소를 의미하는 것은 아니라고 판단했다.\n\n추가 조사 과정에서 고세명이 스카이워크로 이동하기 직전 공개 러닝 애플리케이션에 활동 기록을 남긴 사실도 확인되었다. 기록상 이동 거리와 시간에는 특별한 점이 없어 보였지만, 그의 움직임에는 이해하기 어려운 급격한 방향 전환과 반복적인 이동이 포함되어 있었다.\n\n첨부된 러닝 활동 기록을 분석하여 고세명이 숨겨 둔 문자열을 확인하라.\n\n### Your Task\n\n러닝 파일을 분석하라\n\n### Answer Format\n\n- 이동 경로에서 확인한 문자열을 제출한다.\n- 정답은 `SCA{answer}` 형식을 사용한다.\n- 영문 대·소문자와 숫자를 정확히 구분한다.\n- 띄어쓰기는 무시한다.\n\n`SCA{DECODEDSTRING}`	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	24	47acc817-08b1-4b5b-ae7b-6aacf902833e.zip	skywalk_running_record_coastal_v3.gpx.zip	2026-07-19 01:19:43.016664+00	f	\N	t	2026-07-18 11:00:07.066349+00
21	Challenge 02 — Coastal Dead Drop	고세명의 신원을 확인한 수사팀은 그가 운영하던 것으로 추정되는 INSTAGRAM 채널을 추적하기 시작했다.\n\n채널에 게시된 기록 대부분은 삭제되어 있었지만, 도주 당일 업로드된 짧은 영상 하나가 확보되었다. 영상에는 바다와 해안 산책로, 주변 시설물, 그리고 수평선 너머의 도시 경관 일부가 담겨 있었다. 게시물에는 위치 정보가 표시되어 있지 않았으며, 영상과 함께 다음과 같은 짧은 메시지만 남아 있었다.\n\n> 물건은 약속한 곳에 두었다. 확인하면 게시물을 지운다.\n> \n\n수사팀은 이 영상이 단순한 여행 기록이 아니라, 고세명이 공범에게 마약의 은닉 위치를 알리기 위해 게시한 것이라고 판단했다.\n\n영상이 촬영된 장소를 확인할 수 있다면 고세명이 제주도를 빠져나온 뒤 처음으로 도착했거나 경유한 지역을 특정할 수 있다. 이는 이후 이동 경로를 재구성하기 위한 첫 번째 단서가 될 것이다.\n\n### Your Task\n\n첨부된 영상을 분석하여 다음 정보를 확인하라\n\n- 영상에 등장하는 해수욕장의 공식 명칭\n\n### Answer Format\n\n- 정답은 `SCA{answer}` 형식을 사용한다.\n- 띄어쓰기는 무시한다\n- 장소는 공식 명칭을 기준으로 작성한다.\n- 정답 형식은 다음과 같다.\n\n`SCA{해수욕장명}`\n\n예시:\n\n`SCA{광안리해수욕장}`\n\n### 첨부 파일\n\n- http://cdn.sca-ctf.com/video.mp4\n	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	20	550fc271-ba23-41ac-9973-1f535d97bcc8.zip	video.mp4.zip	2026-07-18 16:15:36.093188+00	f	\N	t	2026-07-18 10:56:39.63639+00
20	Casefile: Track down the criminal	이 문제는 총 8문항, 각 100점씩 총 800점으로 책정되어 있으며\n\n이전의 문제를 해결하면 뒤의 문제가 열리는 **스토리 연계형** 문제입니다. \n\n각 팀들의 실시간 문제 풀이 상황. 즉 수사 상황에 따라 SIDE QUEST 혹은 동료의 실마리가 해금 될 수 있습니다.\n\n만약 제한시간인 CTF의 종료시간 내에 8번 퀘스트를 해결해 용의자를 검거하는 팀이 생기지 않는다면, 현상금인 First Blood Bounty는 참여 팀 중 문제를 한 문제 이상 푼 팀에게 랜덤으로 주어집니다.\n\n마약 밀매 조직과 연계된 것으로 추정되는 용의자 **고세명**이 수사망을 피해 제주도를 벗어났다.\n\n수사팀은 제주항에서 용의자를 검거하려 했으나, 고세명은 정규 여객선의 예약 기록만 남긴 채 실제로는 다른 경로를 이용해 도주한 것으로 추정된다. 현재 수사팀은 본격적인 이동 경로 추적에 앞서, 확보된 사건 기록을 검토하고 용의자의 기본 인적사항을 다시 확인하고자 한다.\n\n당신의 첫 번째 임무는 첨부된 **사건 파일 PDF**를 분석하여 용의자의 신원을 확인하는 것이다.\n\n### Your Task\n\n첨부된 PDF를 검토하여 다음 정보를 확인하라.\n\n- 용의자의 이름\n- 출생연도\n- 출생지역\n\n### Answer Format\n\n- 정답은 `SCA{answer}` 형식을 사용한다.\n- 각 정보는 `_`로 구분한다.\n- 정답 형식은 다음과 같다.\n\n`이름_출생연도_출생지역`\n\n예시:\n\n`SCA{홍길동_2006_삼척시}`	100	100	Misc	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	f8ebc56b-702e-4cf9-9a76-84f08293a498.zip	CASE_FILE.zip	2026-07-19 00:10:13.17272+00	f	\N	t	2026-07-18 10:49:29.373445+00
9	root_manager_revenge	Our old root manager had one job: keep the flag safe.\n\nAfter the last incident, we removed every dangerous feature from the file manager.\nNo reading files. No printing secrets. We even locked it down with seccomp.\nJust create, delete, write, and leave a review.\n\nSurely nothing can go wrong this time.\n\n---\n\n- 제공 파일 MD5 = `a016b2679e2ebbe5e857ed685a00f651`	1000	100	Pwnable	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	\N	ba421f63-ee0f-40ec-b73e-1f470c3cc672.zip	root_manager_revenge_for_user.zip	2026-07-18 10:22:23.579543+00	t	apiVersion: sandboxd.o/v1\nkind: Sandbox\nid: root_manager_revenge\nspec:\n  egress: false\n  ttl_seconds: 3600\n  ports:\n    - host_port: 0\n      container_port: 31337\n      protocol: tcp\n  readiness_probe:\n    protocol: tcp\n    port: 31337\n    initial_delay_seconds: 10\n    period_seconds: 5\n    timeout_seconds: 1\n    success_threshold: 1\n    failure_threshold: 30\n  containers:\n    - name: app\n      image: 769953010889.dkr.ecr.ap-northeast-2.amazonaws.com/sca-ctf-chall-root_manager_revenge:v3\n      args: []\n      env: []\n      work_dir: ""\n      cap_drop:\n        - ALL\n      cap_add:\n        - CHOWN\n        - SETGID\n        - SETUID\n        - SYS_PTRACE\n      security_opt:\n        - no-new-privileges:true\n      read_only: true\n      tmpfs:\n        - mount_path: /run\n          options: rw,nosuid,nodev,noexec,mode=0755\n        - mount_path: /tmp\n          options: rw,nosuid,nodev,exec,mode=1777\n      resource:\n        cpu: 1000m\n        memory: 1024Mi	t	2026-07-17 03:42:23.831222+00
\.


--
-- Data for Name: discord_connections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.discord_connections (id, user_id, discord_user_id, discord_username, discord_global_name, discord_avatar, role_status, connected_at, verified_at, revoked_at, last_synced_at, last_error, created_at, updated_at) FROM stdin;
23	48	[REDACTED_ID]	s***2	\N	89b843c1a41219a453f26d35c8c0d2b8	VERIFIED	2026-07-18 22:33:36.356849+00	2026-07-18 22:33:36.361167+00	\N	2026-07-18 22:33:36.361167+00	\N	2026-07-18 22:33:36.358078+00	2026-07-18 22:33:36.361167+00
2	9	[REDACTED_ID]	y***4	y***g	a5caf4d9a8bcbeb2b4ef6b4a7f18722b	VERIFIED	2026-07-18 11:03:43.221556+00	2026-07-18 11:03:43.225458+00	\N	2026-07-18 11:03:43.225458+00	\N	2026-07-18 11:03:43.222114+00	2026-07-18 11:03:43.225458+00
3	24	[REDACTED_ID]	d***6	서*기	\N	VERIFIED	2026-07-18 11:20:53.89314+00	2026-07-18 11:20:53.89609+00	\N	2026-07-18 11:20:53.89609+00	\N	2026-07-18 11:20:53.892292+00	2026-07-18 11:20:53.89609+00
4	36	[REDACTED_ID]	m***8	D***l	499297c12000ddf9c07c46b6be74f790	VERIFIED	2026-07-18 11:28:49.455581+00	2026-07-18 11:28:49.459609+00	\N	2026-07-18 11:28:49.459609+00	\N	2026-07-18 11:28:49.455033+00	2026-07-18 11:28:49.459609+00
5	37	[REDACTED_ID]	p***8	p***s	08a54d0ca64a73d16c401f49c800b372	VERIFIED	2026-07-18 11:29:57.836751+00	2026-07-18 11:29:57.842421+00	\N	2026-07-18 11:29:57.842421+00	\N	2026-07-18 11:29:57.836353+00	2026-07-18 11:29:57.842421+00
6	40	[REDACTED_ID]	i***t	김*럿	714d8f8443469f8e52944a1d08657a93	VERIFIED	2026-07-18 11:35:49.500136+00	2026-07-18 11:35:49.502987+00	\N	2026-07-18 11:35:49.502987+00	\N	2026-07-18 11:35:49.499267+00	2026-07-18 11:35:49.502987+00
7	31	[REDACTED_ID]	c***6	:***|	737d960a59d6addf5e1a12ea62dfb81e	VERIFIED	2026-07-18 11:52:45.861184+00	2026-07-18 11:52:45.865105+00	\N	2026-07-18 11:52:45.865105+00	\N	2026-07-18 11:52:45.860857+00	2026-07-18 11:52:45.865105+00
8	50	[REDACTED_ID]	n***4	n***4	33c497e32ed90c32501cfd4985bee382	VERIFIED	2026-07-18 11:54:13.711266+00	2026-07-18 11:54:13.714842+00	\N	2026-07-18 11:54:13.714842+00	\N	2026-07-18 11:54:13.710859+00	2026-07-18 11:54:13.714842+00
9	43	[REDACTED_ID]	y***2_4	y***2_4	ebcb2d528d002a9583863e78808e652a	VERIFIED	2026-07-18 12:13:18.637488+00	2026-07-18 12:13:18.64279+00	\N	2026-07-18 12:13:18.64279+00	\N	2026-07-18 12:13:18.637049+00	2026-07-18 12:13:18.64279+00
10	64	[REDACTED_ID]	5***n	\N	54e592e7b6a17a7fe0e14fee6776b1f9	VERIFIED	2026-07-18 12:18:26.61434+00	2026-07-18 12:18:26.619903+00	\N	2026-07-18 12:18:26.619903+00	\N	2026-07-18 12:18:26.613592+00	2026-07-18 12:18:26.619903+00
11	7	[REDACTED_ID]	h***5	혜*성	87a51a938db30c1260330e1e4c6cbe31	VERIFIED	2026-07-18 12:35:35.316332+00	2026-07-18 12:35:35.319475+00	\N	2026-07-18 12:35:35.319475+00	\N	2026-07-18 12:35:35.314605+00	2026-07-18 12:35:35.319475+00
12	79	[REDACTED_ID]	t***g	명*종	\N	VERIFIED	2026-07-18 13:12:58.641954+00	2026-07-18 13:12:58.645568+00	\N	2026-07-18 13:12:58.645568+00	\N	2026-07-18 13:12:58.639455+00	2026-07-18 13:12:58.645568+00
14	94	[REDACTED_ID]	_***f	S***y	628ca44a9089c2bec4b5f667d00706b6	VERIFIED	2026-07-18 14:26:23.288211+00	2026-07-18 14:26:23.291385+00	\N	2026-07-18 14:26:23.291385+00	\N	2026-07-18 14:26:23.286288+00	2026-07-18 14:26:23.291385+00
15	110	[REDACTED_ID]	h***9	♤***$	2c4a5d9eca2c0d02c6bcea451397f3a0	VERIFIED	2026-07-18 15:59:15.820367+00	2026-07-18 15:59:15.824292+00	\N	2026-07-18 15:59:15.824292+00	\N	2026-07-18 15:59:16.012728+00	2026-07-18 15:59:15.824292+00
16	112	[REDACTED_ID]	i***e	n***e	9d98dcea0fa98ec851710d74e6336158	VERIFIED	2026-07-18 16:13:50.732028+00	2026-07-18 16:13:50.735177+00	\N	2026-07-18 16:13:50.735177+00	\N	2026-07-18 16:13:50.73374+00	2026-07-18 16:13:50.735177+00
17	114	[REDACTED_ID]	l***r	L***e	dab9fbb959fa6f13e94b6a200ae9a218	VERIFIED	2026-07-18 16:21:02.021614+00	2026-07-18 16:21:02.024679+00	\N	2026-07-18 16:21:02.024679+00	\N	2026-07-18 16:21:02.023266+00	2026-07-18 16:21:02.024679+00
18	117	[REDACTED_ID]	g***9	€***n	2d7d950a9b7a813964b2d0ba4b6cedcd	VERIFIED	2026-07-18 16:36:49.545658+00	2026-07-18 16:36:49.548405+00	\N	2026-07-18 16:36:49.548405+00	\N	2026-07-18 16:36:49.54641+00	2026-07-18 16:36:49.548405+00
19	116	[REDACTED_ID]	i***2_3	m***5	3e03634ac9e8a045d446ee74d02c0e59	VERIFIED	2026-07-18 16:44:56.46189+00	2026-07-18 16:44:56.464577+00	\N	2026-07-18 16:44:56.464577+00	\N	2026-07-18 16:44:56.462859+00	2026-07-18 16:44:56.464577+00
24	12	[REDACTED_ID]	m***d	m***d	66b913bc8b09e57984b83e184b35b0b8	VERIFIED	2026-07-18 23:28:14.582244+00	2026-07-18 23:28:14.585695+00	\N	2026-07-18 23:28:14.585695+00	\N	2026-07-18 23:28:14.58318+00	2026-07-18 23:28:14.585695+00
21	38	[REDACTED_ID]	k***n	k***2_4	34fbf4ca7ee788f2d9d971a889c984b7	VERIFIED	2026-07-18 16:52:13.931458+00	2026-07-18 16:52:13.939718+00	\N	2026-07-18 16:52:13.939718+00	\N	2026-07-18 16:52:13.932859+00	2026-07-18 16:52:13.939718+00
22	111	[REDACTED_ID]	c***9	c***9	628c7fc62f0c0a56f7a063275c8fdadd	VERIFIED	2026-07-18 20:06:06.189645+00	2026-07-18 20:06:06.192382+00	\N	2026-07-18 20:06:06.192382+00	\N	2026-07-18 20:06:06.190755+00	2026-07-18 20:06:06.192382+00
25	104	[REDACTED_ID]	g***4	훈*이	69480973f0d67b22bc1a417af80816b9	VERIFIED	2026-07-18 23:43:21.116916+00	2026-07-18 23:43:21.11963+00	\N	2026-07-18 23:43:21.11963+00	\N	2026-07-18 23:43:21.117372+00	2026-07-18 23:43:21.11963+00
26	77	[REDACTED_ID]	j***n	g***1	1a634a3941baa9183414a04296c9f3fa	VERIFIED	2026-07-18 23:47:45.562501+00	2026-07-18 23:47:45.565733+00	\N	2026-07-18 23:47:45.565733+00	\N	2026-07-18 23:47:45.563185+00	2026-07-18 23:47:45.565733+00
27	35	[REDACTED_ID]	_***i	손*별	d0799eb91c464600cb2b742d0d28d36e	VERIFIED	2026-07-18 23:50:45.525933+00	2026-07-18 23:50:45.529103+00	\N	2026-07-18 23:50:45.529103+00	\N	2026-07-18 23:50:45.526614+00	2026-07-18 23:50:45.529103+00
28	91	[REDACTED_ID]	c***7	최*훈	\N	VERIFIED	2026-07-18 23:59:13.976243+00	2026-07-18 23:59:13.979933+00	\N	2026-07-18 23:59:13.979933+00	\N	2026-07-18 23:59:13.977083+00	2026-07-18 23:59:13.979933+00
29	90	[REDACTED_ID]	d***s	0****몽	24412b0ef2e6ff64cea15b31a41fe3e2	VERIFIED	2026-07-18 23:59:53.573922+00	2026-07-18 23:59:53.577358+00	\N	2026-07-18 23:59:53.577358+00	\N	2026-07-18 23:59:53.57476+00	2026-07-18 23:59:53.577358+00
30	22	[REDACTED_ID]	m***9	M***W	bf3328e48084bfe561c38f337ad494a4	VERIFIED	2026-07-19 00:00:23.420991+00	2026-07-19 00:00:23.424212+00	\N	2026-07-19 00:00:23.424212+00	\N	2026-07-19 00:00:23.421847+00	2026-07-19 00:00:23.424212+00
31	85	[REDACTED_ID]	r***b	R***b	390d8d8a17d511fc417f0b36abe008b0	VERIFIED	2026-07-19 00:00:33.583262+00	2026-07-19 00:00:33.585905+00	\N	2026-07-19 00:00:33.585905+00	\N	2026-07-19 00:00:33.583536+00	2026-07-19 00:00:33.585905+00
32	82	[REDACTED_ID]	c***e	C***e	6af17201120d902dfceea2584e5d83e5	VERIFIED	2026-07-19 00:01:09.85634+00	2026-07-19 00:01:09.860118+00	\N	2026-07-19 00:01:09.860118+00	\N	2026-07-19 00:01:09.857064+00	2026-07-19 00:01:09.860118+00
33	46	[REDACTED_ID]	k***6	K***e	e0a24086991911bbf59fdde9eb2a9e22	VERIFIED	2026-07-19 00:01:34.579941+00	2026-07-19 00:01:34.582878+00	\N	2026-07-19 00:01:34.582878+00	\N	2026-07-19 00:01:34.580269+00	2026-07-19 00:01:34.582878+00
34	93	[REDACTED_ID]	c***n	C***n	446863411bdaa7abd834710122c793c0	VERIFIED	2026-07-19 00:01:47.965933+00	2026-07-19 00:01:47.968522+00	\N	2026-07-19 00:01:47.968522+00	\N	2026-07-19 00:01:47.966179+00	2026-07-19 00:01:47.968522+00
35	134	[REDACTED_ID]	k***4	4***j	abe25265a76d1998f22d462a623aad20	VERIFIED	2026-07-19 00:02:27.512432+00	2026-07-19 00:02:27.515275+00	\N	2026-07-19 00:02:27.515275+00	\N	2026-07-19 00:02:27.512704+00	2026-07-19 00:02:27.515275+00
36	105	[REDACTED_ID]	s***o	준*우	9c506eb5f3253a5602824d715586298b	VERIFIED	2026-07-19 00:02:57.349936+00	2026-07-19 00:02:57.354002+00	\N	2026-07-19 00:02:57.354002+00	\N	2026-07-19 00:02:57.350633+00	2026-07-19 00:02:57.354002+00
37	13	[REDACTED_ID]	a***e	반*진	fb727d6986c15dacc5204e6719600b26	VERIFIED	2026-07-19 00:03:20.993202+00	2026-07-19 00:03:20.996337+00	\N	2026-07-19 00:03:20.996337+00	\N	2026-07-19 00:03:20.993536+00	2026-07-19 00:03:20.996337+00
38	128	[REDACTED_ID]	j***7	J***n	aeedbf450b6a0e9a5165125b3d04c610	VERIFIED	2026-07-19 00:03:44.456871+00	2026-07-19 00:03:44.460286+00	\N	2026-07-19 00:03:44.460286+00	\N	2026-07-19 00:03:44.457183+00	2026-07-19 00:03:44.460286+00
39	11	[REDACTED_ID]	j***9	김*서	a_96ae3feb41e2e0d5c8b900b10fe4277e	VERIFIED	2026-07-19 00:03:55.670756+00	2026-07-19 00:03:55.673456+00	\N	2026-07-19 00:03:55.673456+00	\N	2026-07-19 00:03:55.670982+00	2026-07-19 00:03:55.673456+00
40	127	[REDACTED_ID]	p***1	p***1	\N	VERIFIED	2026-07-19 00:04:02.738242+00	2026-07-19 00:04:02.740882+00	\N	2026-07-19 00:04:02.740882+00	\N	2026-07-19 00:04:02.738479+00	2026-07-19 00:04:02.740882+00
41	133	[REDACTED_ID]	u***9	u***n	aa42cae86b2e7443b5f5d5f4aa5b3a66	VERIFIED	2026-07-19 00:04:14.163399+00	2026-07-19 00:04:14.166217+00	\N	2026-07-19 00:04:14.166217+00	\N	2026-07-19 00:04:14.163682+00	2026-07-19 00:04:14.166217+00
42	65	[REDACTED_ID]	h***c	H***c	a_a0efe7b41a7606a1e3d1fc1c2f34bc9c	VERIFIED	2026-07-19 00:04:22.953885+00	2026-07-19 00:04:22.957434+00	\N	2026-07-19 00:04:22.957434+00	\N	2026-07-19 00:04:22.954577+00	2026-07-19 00:04:22.957434+00
43	21	[REDACTED_ID]	a***m	a***i	fcdc93d7ea5d49f2b9d031e2a77dd643	VERIFIED	2026-07-19 00:04:55.00297+00	2026-07-19 00:04:55.006464+00	\N	2026-07-19 00:04:55.006464+00	\N	2026-07-19 00:04:55.003373+00	2026-07-19 00:04:55.006464+00
44	136	[REDACTED_ID]	s***9_2	소*은	\N	VERIFIED	2026-07-19 00:05:22.711914+00	2026-07-19 00:05:22.715853+00	\N	2026-07-19 00:05:22.715853+00	\N	2026-07-19 00:05:22.712542+00	2026-07-19 00:05:22.715853+00
45	92	[REDACTED_ID]	a***g	아*카	af97c5ef0da229067234d291df6905b9	VERIFIED	2026-07-19 00:05:37.612769+00	2026-07-19 00:05:37.615517+00	\N	2026-07-19 00:05:37.615517+00	\N	2026-07-19 00:05:37.613106+00	2026-07-19 00:05:37.615517+00
46	102	[REDACTED_ID]	4***r	정*민	2fa2e84d3b673c8634fcb980b808de57	VERIFIED	2026-07-19 00:05:55.05512+00	2026-07-19 00:05:55.058243+00	\N	2026-07-19 00:05:55.058243+00	\N	2026-07-19 00:05:55.055367+00	2026-07-19 00:05:55.058243+00
47	32	[REDACTED_ID]	d***1	D***1	378bc2b3f9bef2077139a7616807cdd6	VERIFIED	2026-07-19 00:06:30.571175+00	2026-07-19 00:06:30.574007+00	\N	2026-07-19 00:06:30.574007+00	\N	2026-07-19 00:06:30.571491+00	2026-07-19 00:06:30.574007+00
49	96	[REDACTED_ID]	s***5_2	신*원	3cf3fbaa6eb6fe458748420623d3ffa0	VERIFIED	2026-07-19 00:06:47.020715+00	2026-07-19 00:06:47.024772+00	\N	2026-07-19 00:06:47.024772+00	\N	2026-07-19 00:06:47.021375+00	2026-07-19 00:06:47.024772+00
50	60	[REDACTED_ID]	d***8	d***t	4084d666f7ae3ef7cc8be05183122e60	VERIFIED	2026-07-19 00:06:53.206587+00	2026-07-19 00:06:53.209643+00	\N	2026-07-19 00:06:53.209643+00	\N	2026-07-19 00:06:53.206783+00	2026-07-19 00:06:53.209643+00
95	28	[REDACTED_ID]	j***6	j***r	f01e54963888a821cd12d01d07b9aae5	VERIFIED	2026-07-19 04:26:57.981014+00	2026-07-19 04:27:09.477734+00	\N	2026-07-19 04:27:09.477734+00	\N	2026-07-19 04:26:57.981588+00	2026-07-19 04:27:09.477734+00
53	57	[REDACTED_ID]	g***a	정*환	\N	VERIFIED	2026-07-19 00:08:25.834038+00	2026-07-19 00:08:25.837588+00	\N	2026-07-19 00:08:25.837588+00	\N	2026-07-19 00:08:25.834671+00	2026-07-19 00:08:25.837588+00
54	51	[REDACTED_ID]	h***6	T***s	7814410e82ef6d4d5a43378f0656afec	VERIFIED	2026-07-19 00:08:45.018916+00	2026-07-19 00:08:45.025414+00	\N	2026-07-19 00:08:45.025414+00	\N	2026-07-19 00:08:45.01963+00	2026-07-19 00:08:45.025414+00
55	71	[REDACTED_ID]	k***5	m***0	\N	VERIFIED	2026-07-19 00:08:45.159272+00	2026-07-19 00:08:45.162836+00	\N	2026-07-19 00:08:45.162836+00	\N	2026-07-19 00:08:45.159508+00	2026-07-19 00:08:45.162836+00
56	29	[REDACTED_ID]	l***h	\N	41ed5d3dbc590375e8e23478fa42858d	VERIFIED	2026-07-19 00:09:04.087004+00	2026-07-19 00:09:04.090695+00	\N	2026-07-19 00:09:04.090695+00	\N	2026-07-19 00:09:04.087628+00	2026-07-19 00:09:04.090695+00
57	4	[REDACTED_ID]	b***i	b***3	b021e17698720ccbd920065284ef2399	VERIFIED	2026-07-19 00:09:07.667118+00	2026-07-19 00:09:07.670977+00	\N	2026-07-19 00:09:07.670977+00	\N	2026-07-19 00:09:07.66776+00	2026-07-19 00:09:07.670977+00
58	139	[REDACTED_ID]	h***5	h***3	67afef56b783d38ede776eeab8963c97	VERIFIED	2026-07-19 00:09:07.933289+00	2026-07-19 00:09:07.936124+00	\N	2026-07-19 00:09:07.936124+00	\N	2026-07-19 00:09:07.933473+00	2026-07-19 00:09:07.936124+00
59	27	[REDACTED_ID]	_***3	최*웅	\N	VERIFIED	2026-07-19 00:09:36.84424+00	2026-07-19 00:09:36.847185+00	\N	2026-07-19 00:09:36.847185+00	\N	2026-07-19 00:09:36.844411+00	2026-07-19 00:09:36.847185+00
60	8	[REDACTED_ID]	h***4	W***3	15027d495fe2a7c15904c4bc58085483	VERIFIED	2026-07-19 00:09:51.022299+00	2026-07-19 00:09:51.025373+00	\N	2026-07-19 00:09:51.025373+00	\N	2026-07-19 00:09:51.022472+00	2026-07-19 00:09:51.025373+00
61	84	[REDACTED_ID]	s***i	s***i	de78544660176221c1606310c632839c	VERIFIED	2026-07-19 00:10:06.16199+00	2026-07-19 00:10:06.16468+00	\N	2026-07-19 00:10:06.16468+00	\N	2026-07-19 00:10:06.16216+00	2026-07-19 00:10:06.16468+00
62	52	[REDACTED_ID]	k***g	g***k	6c5996770c985bcd6e5b68131ff2ba04	VERIFIED	2026-07-19 00:10:28.536378+00	2026-07-19 00:10:28.539985+00	\N	2026-07-19 00:10:28.539985+00	\N	2026-07-19 00:10:28.537006+00	2026-07-19 00:10:28.539985+00
63	88	[REDACTED_ID]	o***d	서*연	88627cbdd6053bb86f6f0ba5d3313f9b	VERIFIED	2026-07-19 00:11:17.241602+00	2026-07-19 00:11:17.244299+00	\N	2026-07-19 00:11:17.244299+00	\N	2026-07-19 00:11:17.241786+00	2026-07-19 00:11:17.244299+00
64	67	[REDACTED_ID]	g***n	한*우	\N	VERIFIED	2026-07-19 00:11:33.110044+00	2026-07-19 00:11:33.113775+00	\N	2026-07-19 00:11:33.113775+00	\N	2026-07-19 00:11:33.110745+00	2026-07-19 00:11:33.113775+00
65	138	[REDACTED_ID]	y***8	!***a	470f3f5b9303f5f25b55acf8dc44524d	VERIFIED	2026-07-19 00:13:17.513251+00	2026-07-19 00:13:17.517231+00	\N	2026-07-19 00:13:17.517231+00	\N	2026-07-19 00:13:17.513873+00	2026-07-19 00:13:17.517231+00
66	126	[REDACTED_ID]	d***2	d***p	958677cad0a1f4ad42170deaf9777f89	VERIFIED	2026-07-19 00:15:19.049711+00	2026-07-19 00:15:19.053419+00	\N	2026-07-19 00:15:19.053419+00	\N	2026-07-19 00:15:19.050303+00	2026-07-19 00:15:19.053419+00
67	109	[REDACTED_ID]	s***j	s***g	bd9b440a93fca1fe6be72d0e08cae83c	VERIFIED	2026-07-19 00:19:05.069369+00	2026-07-19 00:19:05.072446+00	\N	2026-07-19 00:19:05.072446+00	\N	2026-07-19 00:19:05.069453+00	2026-07-19 00:19:05.072446+00
68	76	[REDACTED_ID]	7***7	박*현	43c414ba21b9047bae858d1112e64bfe	VERIFIED	2026-07-19 00:20:35.736369+00	2026-07-19 00:20:35.740028+00	\N	2026-07-19 00:20:35.740028+00	\N	2026-07-19 00:20:35.736929+00	2026-07-19 00:20:35.740028+00
69	33	[REDACTED_ID]	b***0	p***2_4	\N	VERIFIED	2026-07-19 00:23:54.137293+00	2026-07-19 00:23:54.140407+00	\N	2026-07-19 00:23:54.140407+00	\N	2026-07-19 00:23:54.137403+00	2026-07-19 00:23:54.140407+00
70	137	[REDACTED_ID]	k***e	C***E	9c20b398645a32dfa04ac42703a78707	VERIFIED	2026-07-19 00:24:08.138967+00	2026-07-19 00:24:08.142882+00	\N	2026-07-19 00:24:08.142882+00	\N	2026-07-19 00:24:08.139574+00	2026-07-19 00:24:08.142882+00
71	119	[REDACTED_ID]	w***_	w***e	dc7d0af73eb971b0bdf6606b5dfbb6c3	VERIFIED	2026-07-19 00:24:17.189239+00	2026-07-19 00:24:17.19206+00	\N	2026-07-19 00:24:17.19206+00	\N	2026-07-19 00:24:17.189405+00	2026-07-19 00:24:17.19206+00
72	16	[REDACTED_ID]	j***2	M***M	aa68b0107547496abb2e46d91abc3c58	VERIFIED	2026-07-19 00:25:20.533549+00	2026-07-19 00:25:20.537318+00	\N	2026-07-19 00:25:20.537318+00	\N	2026-07-19 00:25:20.534124+00	2026-07-19 00:25:20.537318+00
73	113	[REDACTED_ID]	d***m	김*원	\N	VERIFIED	2026-07-19 00:25:42.210029+00	2026-07-19 00:25:42.214397+00	\N	2026-07-19 00:25:42.214397+00	\N	2026-07-19 00:25:42.210587+00	2026-07-19 00:25:42.214397+00
74	69	[REDACTED_ID]	k***y	k***l	3799c4100f539183f3069e6065c56440	VERIFIED	2026-07-19 00:31:43.57064+00	2026-07-19 00:31:43.575144+00	\N	2026-07-19 00:31:43.575144+00	\N	2026-07-19 00:31:43.571127+00	2026-07-19 00:31:43.575144+00
75	44	[REDACTED_ID]	r***2	\N	\N	VERIFIED	2026-07-19 00:33:34.746553+00	2026-07-19 00:33:34.749804+00	\N	2026-07-19 00:33:34.749804+00	\N	2026-07-19 00:33:34.746634+00	2026-07-19 00:33:34.749804+00
78	80	[REDACTED_ID]	k***0	강*영	7231d97f891ff38408a6fe39beb43081	VERIFIED	2026-07-19 00:37:05.614071+00	2026-07-19 00:37:05.617758+00	\N	2026-07-19 00:37:05.617758+00	\N	2026-07-19 00:37:05.614521+00	2026-07-19 00:37:05.617758+00
79	101	[REDACTED_ID]	c***_	C***s	\N	VERIFIED	2026-07-19 00:49:03.870204+00	2026-07-19 00:49:03.873081+00	\N	2026-07-19 00:49:03.873081+00	\N	2026-07-19 00:49:03.870164+00	2026-07-19 00:49:03.873081+00
80	144	[REDACTED_ID]	h***g	김*성	b0791f60c451e7d81b21214157aae4e8	VERIFIED	2026-07-19 00:50:40.243873+00	2026-07-19 00:50:40.246827+00	\N	2026-07-19 00:50:40.246827+00	\N	2026-07-19 00:50:40.243839+00	2026-07-19 00:50:40.246827+00
81	34	[REDACTED_ID]	p***r	p***a	0d581d0c623d0eb6ed052ed11288a106	VERIFIED	2026-07-19 00:59:43.420278+00	2026-07-19 00:59:43.423657+00	\N	2026-07-19 00:59:43.423657+00	\N	2026-07-19 00:59:43.420159+00	2026-07-19 00:59:43.423657+00
82	73	[REDACTED_ID]	t***h	박*기	5159abe86dfe5968dfe60853bbe48ad8	VERIFIED	2026-07-19 01:02:49.118536+00	2026-07-19 01:02:49.122187+00	\N	2026-07-19 01:02:49.122187+00	\N	2026-07-19 01:02:49.118895+00	2026-07-19 01:02:49.122187+00
83	147	[REDACTED_ID]	l***0	\N	80b63f735dc4f290ac9e425cb3d955a8	VERIFIED	2026-07-19 01:07:12.913515+00	2026-07-19 01:07:12.916485+00	\N	2026-07-19 01:07:12.916485+00	\N	2026-07-19 01:07:12.913469+00	2026-07-19 01:07:12.916485+00
85	148	[REDACTED_ID]	b***2_3	b***b	f8565175653c9ac7a256cd9d81deb9b7	VERIFIED	2026-07-19 01:30:44.891313+00	2026-07-19 01:30:44.894203+00	\N	2026-07-19 01:30:44.894203+00	\N	2026-07-19 01:30:44.891241+00	2026-07-19 01:30:44.894203+00
86	129	[REDACTED_ID]	s***4	*	128a389e66be582f21930541af4fc260	VERIFIED	2026-07-19 01:33:48.452225+00	2026-07-19 01:33:48.45582+00	\N	2026-07-19 01:33:48.45582+00	\N	2026-07-19 01:33:48.452617+00	2026-07-19 01:33:48.45582+00
87	149	[REDACTED_ID]	n***n	주*안	9e145a057956f78f5896196941af2a34	VERIFIED	2026-07-19 01:38:40.342597+00	2026-07-19 01:38:40.346708+00	\N	2026-07-19 01:38:40.346708+00	\N	2026-07-19 01:38:40.342994+00	2026-07-19 01:38:40.346708+00
88	78	[REDACTED_ID]	z***2	한*연	\N	VERIFIED	2026-07-19 01:47:27.254612+00	2026-07-19 01:47:27.258419+00	\N	2026-07-19 01:47:27.258419+00	\N	2026-07-19 01:47:27.25501+00	2026-07-19 01:47:27.258419+00
89	75	[REDACTED_ID]	y***3	예*현	\N	VERIFIED	2026-07-19 01:48:00.435901+00	2026-07-19 01:48:00.43991+00	\N	2026-07-19 01:48:00.43991+00	\N	2026-07-19 01:48:00.436345+00	2026-07-19 01:48:00.43991+00
90	54	[REDACTED_ID]	y***n	Y***s	f91fe5f018420e54dda510cad368777d	VERIFIED	2026-07-19 01:55:20.497532+00	2026-07-19 01:55:20.501574+00	\N	2026-07-19 01:55:20.501574+00	\N	2026-07-19 01:55:20.497833+00	2026-07-19 01:55:20.501574+00
91	131	[REDACTED_ID]	i***y	i***y	b184efb426ebe0dd7f351b8f1cc3a687	VERIFIED	2026-07-19 03:03:46.643946+00	2026-07-19 03:03:46.647139+00	\N	2026-07-19 03:03:46.647139+00	\N	2026-07-19 03:03:46.643918+00	2026-07-19 03:03:46.647139+00
92	97	[REDACTED_ID]	y***k	H***R	760ea6468155bbb0dde93415285ab329	VERIFIED	2026-07-19 03:30:12.01539+00	2026-07-19 03:30:12.023789+00	\N	2026-07-19 03:30:12.023789+00	\N	2026-07-19 03:30:12.015955+00	2026-07-19 03:30:12.023789+00
93	155	[REDACTED_ID]	k***d	연*정	1b624931fda1a559be0b693aff13421d	VERIFIED	2026-07-19 03:53:41.392864+00	2026-07-19 03:53:41.396943+00	\N	2026-07-19 03:53:41.396943+00	\N	2026-07-19 03:53:41.393371+00	2026-07-19 03:53:41.396943+00
94	26	[REDACTED_ID]	s***t	S***t	4f7812ba6807875ce7f7c078f2a4944f	VERIFIED	2026-07-19 04:12:04.843136+00	2026-07-19 04:12:04.846646+00	\N	2026-07-19 04:12:04.846646+00	\N	2026-07-19 04:12:04.843693+00	2026-07-19 04:12:04.846646+00
96	106	[REDACTED_ID]	c***8	6************수	\N	VERIFIED	2026-07-19 05:11:33.606134+00	2026-07-19 05:11:33.608814+00	\N	2026-07-19 05:11:33.608814+00	\N	2026-07-19 05:11:33.606342+00	2026-07-19 05:11:33.608814+00
97	20	[REDACTED_ID]	s***0_2	s***6	ef96682d03d2d677d7338d6b3be15a23	VERIFIED	2026-07-19 05:12:52.731014+00	2026-07-19 05:12:52.733915+00	\N	2026-07-19 05:12:52.733915+00	\N	2026-07-19 05:12:52.731265+00	2026-07-19 05:12:52.733915+00
98	156	[REDACTED_ID]	h***a	헤*어	3a1722b9ac66dc7b650bdff8cf856c0b	VERIFIED	2026-07-19 05:53:14.421387+00	2026-07-19 05:53:14.424157+00	\N	2026-07-19 05:53:14.424157+00	\N	2026-07-19 05:53:14.421618+00	2026-07-19 05:53:14.424157+00
99	23	[REDACTED_ID]	s***3_2	스*택	1489aa09e59a3e36dcd5408a86f393a7	VERIFIED	2026-07-19 07:17:14.438755+00	2026-07-19 07:17:14.442959+00	\N	2026-07-19 07:17:14.442959+00	\N	2026-07-19 07:17:14.43933+00	2026-07-19 07:17:14.442959+00
100	145	[REDACTED_ID]	y***i	윤*태	c381a93ddf68bd9accaf4321ff8dba9b	VERIFIED	2026-07-19 09:02:20.476663+00	2026-07-19 09:02:20.479494+00	\N	2026-07-19 09:02:20.479494+00	\N	2026-07-19 09:02:20.476866+00	2026-07-19 09:02:20.479494+00
\.


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.divisions (id, name, discord_role_id, discord_announce_channel_id, created_at) FROM stdin;
1	Admin	\N	\N	2026-07-17 11:13:35.606663+00
2	일반부	1522845546929459331	1522218332806447225	2026-07-17 13:12:12.680507+00
3	청소년부	1522845589564555284	1522845701782900816	2026-07-17 13:12:44.998694+00
\.


--
-- Data for Name: registration_key_uses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.registration_key_uses (id, registration_key_id, used_by, used_by_ip, used_at) FROM stdin;
1	105	2	115.***.***.49	2026-07-18 06:05:00.42354+00
2	33	3	112.***.***.156	2026-07-18 11:01:30.259514+00
3	42	4	118.***.***.150	2026-07-18 11:01:49.855326+00
4	11	5	118.***.***.170	2026-07-18 11:02:00.448881+00
5	71	6	118.***.***.191	2026-07-18 11:02:08.853028+00
6	82	7	14.***.***.41	2026-07-18 11:02:27.272198+00
7	90	8	211.***.***.122	2026-07-18 11:02:54.289675+00
8	58	9	27.***.***.120	2026-07-18 11:02:58.955476+00
9	43	10	210.***.***.93	2026-07-18 11:03:35.791564+00
10	43	11	112.***.***.234	2026-07-18 11:04:34.684689+00
11	15	12	222.***.***.57	2026-07-18 11:04:57.356612+00
12	2	13	211.***.***.149	2026-07-18 11:05:13.462948+00
13	51	14	182.***.***.158	2026-07-18 11:05:14.535114+00
14	51	15	211.***.***.218	2026-07-18 11:06:33.694016+00
15	95	16	1.***.***.162	2026-07-18 11:06:47.559446+00
16	74	17	180.***.***.215	2026-07-18 11:07:47.94261+00
17	78	18	121.***.***.142	2026-07-18 11:08:02.532322+00
18	55	19	106.***.***.228	2026-07-18 11:09:08.059711+00
19	5	20	222.***.***.227	2026-07-18 11:10:09.651448+00
20	5	21	222.***.***.227	2026-07-18 11:10:12.143567+00
21	102	22	106.***.***.109	2026-07-18 11:12:34.608612+00
22	98	23	124.***.***.81	2026-07-18 11:15:42.463246+00
23	100	24	180.***.***.87	2026-07-18 11:19:01.326256+00
24	72	25	211.***.***.81	2026-07-18 11:19:39.770759+00
25	21	26	118.***.***.142	2026-07-18 11:19:44.737451+00
26	22	27	14.***.***.202	2026-07-18 11:20:36.531798+00
27	45	28	116.***.***.211	2026-07-18 11:20:44.134836+00
28	83	29	1.***.***.211	2026-07-18 11:21:15.624985+00
29	89	30	119.***.***.145	2026-07-18 11:23:20.022845+00
30	96	31	119.***.***.218	2026-07-18 11:23:30.345976+00
31	11	32	221.***.***.49	2026-07-18 11:25:03.775766+00
32	62	33	106.***.***.233	2026-07-18 11:25:15.884647+00
33	83	34	218.***.***.35	2026-07-18 11:25:56.698401+00
34	96	35	211.***.***.12	2026-07-18 11:27:17.100712+00
35	21	36	119.***.***.144	2026-07-18 11:27:50.043499+00
36	85	37	210.***.***.40	2026-07-18 11:29:06.299519+00
37	76	38	182.***.***.92	2026-07-18 11:31:36.733657+00
38	25	39	1.***.***.100	2026-07-18 11:33:32.538537+00
39	86	40	14.***.***.141	2026-07-18 11:34:39.812368+00
40	29	41	3.***.***.207	2026-07-18 11:38:40.144033+00
41	54	42	106.***.***.246	2026-07-18 11:38:42.298323+00
42	16	43	112.***.***.124	2026-07-18 11:40:08.191689+00
43	68	44	219.***.***.145	2026-07-18 11:40:57.830721+00
44	68	45	1.***.***.248	2026-07-18 11:42:19.104994+00
45	79	46	89.***.***.158	2026-07-18 11:43:08.128939+00
46	95	47	114.***.***.207	2026-07-18 11:43:34.070784+00
47	80	48	39.***.***.49	2026-07-18 11:44:26.594551+00
48	63	49	180.***.***.24	2026-07-18 11:46:56.864427+00
49	64	50	116.***.***.130	2026-07-18 11:48:18.366528+00
50	84	51	1.***.***.118	2026-07-18 11:48:30.144896+00
51	53	52	106.***.***.31	2026-07-18 11:49:37.0956+00
52	42	53	125.***.***.4	2026-07-18 11:50:24.379162+00
53	28	54	112.***.***.218	2026-07-18 11:51:25.07044+00
54	53	55	116.***.***.245	2026-07-18 11:51:58.516068+00
55	64	56	121.***.***.110	2026-07-18 11:53:02.408738+00
56	37	57	14.***.***.168	2026-07-18 11:57:20.290422+00
57	77	58	183.***.***.83	2026-07-18 12:02:50.587288+00
58	55	59	112.***.***.200	2026-07-18 12:07:52.372682+00
59	92	60	110.***.***.198	2026-07-18 12:08:16.370413+00
60	16	61	110.***.***.197	2026-07-18 12:10:36.430667+00
61	44	62	58.***.***.91	2026-07-18 12:13:27.561971+00
62	94	63	219.***.***.31	2026-07-18 12:13:55.038046+00
63	17	64	49.***.***.28	2026-07-18 12:17:13.545816+00
64	58	65	118.***.***.84	2026-07-18 12:23:22.460373+00
65	98	66	58.***.***.67	2026-07-18 12:25:15.371917+00
66	74	67	210.***.***.216	2026-07-18 12:28:40.639125+00
67	12	68	106.***.***.109	2026-07-18 12:29:41.921729+00
68	67	69	27.***.***.198	2026-07-18 12:35:48.250903+00
69	39	70	106.***.***.170	2026-07-18 12:49:19.070469+00
70	90	71	211.***.***.214	2026-07-18 12:49:54.676594+00
71	2	72	123.***.***.64	2026-07-18 12:50:03.503267+00
72	32	73	223.***.***.33	2026-07-18 12:50:14.800992+00
73	4	74	1.***.***.105	2026-07-18 12:51:12.106027+00
74	65	75	163.***.***.141	2026-07-18 13:04:27.65281+00
75	49	76	112.***.***.10	2026-07-18 13:07:28.019956+00
76	85	77	211.***.***.198	2026-07-18 13:07:44.594161+00
77	65	78	125.***.***.92	2026-07-18 13:08:10.761377+00
78	27	79	220.***.***.81	2026-07-18 13:11:37.468912+00
79	57	80	118.***.***.161	2026-07-18 13:13:15.274067+00
80	7	81	211.***.***.169	2026-07-18 13:17:30.096542+00
81	29	82	182.***.***.116	2026-07-18 13:18:36.427161+00
82	17	83	121.***.***.210	2026-07-18 13:18:38.518302+00
83	7	84	121.***.***.210	2026-07-18 13:22:13.054138+00
84	8	85	39.***.***.13	2026-07-18 13:23:59.991829+00
85	99	86	182.***.***.83	2026-07-18 13:30:26.860693+00
86	100	87	14.***.***.105	2026-07-18 13:42:19.074533+00
87	40	88	59.***.***.186	2026-07-18 13:43:00.975469+00
88	27	89	2001:4430:d0ac:3892::a26:c853	2026-07-18 13:44:48.031923+00
89	75	90	117.***.***.165	2026-07-18 13:47:36.333874+00
90	46	91	175.***.***.17	2026-07-18 13:58:12.109844+00
91	26	92	180.***.***.209	2026-07-18 14:02:54.886511+00
92	103	93	58.***.***.49	2026-07-18 14:12:23.263393+00
93	78	94	182.***.***.79	2026-07-18 14:15:57.649638+00
94	79	95	2001:2d8:e3e3:8f0a:716e:3412:64ad:7f23	2026-07-18 14:18:45.116604+00
95	87	96	2001:2d8:805c:50b7:39d1:f270:cc50:754a	2026-07-18 14:20:15.717369+00
96	70	97	14.***.***.113	2026-07-18 14:21:40.782788+00
97	38	98	183.***.***.67	2026-07-18 14:32:34.874675+00
98	40	99	211.***.***.69	2026-07-18 14:33:08.080028+00
99	97	100	113.***.***.31	2026-07-18 14:39:52.326027+00
100	35	101	112.***.***.151	2026-07-18 14:45:48.394845+00
101	86	102	106.***.***.222	2026-07-18 14:50:48.881147+00
102	81	103	2a09:bac1:3f00:518::20b:60	2026-07-18 14:51:53.504301+00
103	87	104	59.***.***.179	2026-07-18 14:55:42.895486+00
104	8	105	220.***.***.121	2026-07-18 15:28:21.226799+00
105	50	106	2001:4430:40d0:d20c::1be6:c0ad	2026-07-18 15:37:48.73507+00
106	50	107	175.***.***.34	2026-07-18 15:40:04.032408+00
107	3	108	175.***.***.205	2026-07-18 15:48:30.036035+00
108	38	109	2406:5900:1001:2984:b918:c085:d2c3:b110	2026-07-18 15:50:37.565342+00
109	12	110	58.***.***.233	2026-07-18 15:57:50.403051+00
110	56	111	220.***.***.81	2026-07-18 16:08:22.892341+00
111	82	112	175.***.***.64	2026-07-18 16:10:00.896946+00
112	25	113	222.***.***.163	2026-07-18 16:18:49.607222+00
113	89	114	45.***.***.201	2026-07-18 16:20:11.283547+00
114	28	115	49.***.***.193	2026-07-18 16:23:50.879503+00
115	76	116	124.***.***.177	2026-07-18 16:33:10.427135+00
116	81	117	2a09:bac5:472e:155::22:107	2026-07-18 16:36:14.339935+00
117	10	118	118.***.***.19	2026-07-18 16:48:00.403977+00
118	59	119	2406:5900:1004:fdd2:6431:9cfd:ca00:8127	2026-07-18 16:53:31.640596+00
119	6	120	221.***.***.206	2026-07-18 17:06:20.83938+00
120	15	121	2406:5900:7055:f4da:53c9:ba0d:17e6:4e52	2026-07-18 17:32:28.772988+00
121	66	122	49.***.***.52	2026-07-18 17:46:51.189788+00
122	72	123	175.***.***.104	2026-07-18 17:54:07.787153+00
123	31	124	106.***.***.112	2026-07-18 22:40:21.069368+00
124	20	125	61.***.***.249	2026-07-18 22:47:59.634063+00
125	20	126	2a02:26f7:c3c4:4000:e800::e	2026-07-18 23:12:25.896269+00
126	91	127	123.***.***.188	2026-07-18 23:22:06.301486+00
127	91	128	2a09:bac5:4729:1482::20b:89	2026-07-18 23:31:53.657318+00
128	31	129	14.***.***.140	2026-07-18 23:50:40.389394+00
129	47	130	39.***.***.106	2026-07-18 23:51:41.247642+00
130	48	131	203.***.***.237	2026-07-18 23:53:30.589705+00
131	62	132	118.***.***.30	2026-07-18 23:54:35.745163+00
132	44	133	123.***.***.70	2026-07-18 23:55:49.621037+00
133	97	134	49.***.***.207	2026-07-18 23:56:39.935776+00
134	34	135	2001:2d8:f184:36e8:19e4:3b4c:1586:eee7	2026-07-18 23:58:35.956214+00
135	69	136	183.***.***.76	2026-07-19 00:03:21.87571+00
136	80	137	14.***.***.113	2026-07-19 00:06:50.847517+00
137	88	138	2001:e60:879f:89e6:6563:c746:477d:907f	2026-07-19 00:07:29.174836+00
138	106	139	182.***.***.158	2026-07-19 00:08:19.668438+00
139	88	140	2001:2d8:6bc8:88ab:7d69:8069:3bd0:7925	2026-07-19 00:09:44.275107+00
140	107	141	175.***.***.182	2026-07-19 00:16:33.678207+00
141	107	142	1.***.***.140	2026-07-19 00:16:53.960891+00
142	108	143	175.***.***.182	2026-07-19 00:16:54.093593+00
143	30	144	119.***.***.64	2026-07-19 00:30:38.801726+00
144	48	145	117.***.***.57	2026-07-19 00:34:14.916174+00
145	10	146	118.***.***.175	2026-07-19 00:35:23.756087+00
146	84	147	112.***.***.6	2026-07-19 00:45:53.913536+00
147	23	148	110.***.***.166	2026-07-19 01:08:38.105641+00
148	93	149	180.***.***.68	2026-07-19 01:10:43.311032+00
149	41	150	121.***.***.158	2026-07-19 01:18:22.755761+00
150	104	151	183.***.***.47	2026-07-19 01:46:16.937056+00
151	23	152	58.***.***.107	2026-07-19 02:15:07.65902+00
152	73	153	220.***.***.49	2026-07-19 02:17:15.771777+00
153	66	154	116.***.***.59	2026-07-19 03:16:28.404085+00
154	1	155	1.***.***.166	2026-07-19 03:52:25.633316+00
155	13	156	121.***.***.89	2026-07-19 05:38:44.354975+00
\.


--
-- Data for Name: registration_keys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.registration_keys (id, code, created_by, team_id, max_uses, used_count, created_at) FROM stdin;
9	9ZV2X945BCPR3DM2	1	10	2	0	2026-07-17 13:15:49.239349+00
14	QX6GVG443VV9ACQU	1	15	2	0	2026-07-17 13:16:23.251119+00
18	K3GSPLX7255RWT8N	1	19	2	0	2026-07-17 13:16:38.739763+00
19	XVJ424GWG2CU7JRE	1	20	2	0	2026-07-17 13:16:43.515274+00
24	VNER5SGMJ68J3TJK	1	25	2	0	2026-07-17 13:17:40.223736+00
36	A4T5QGZ8TNYXVZGK	1	37	2	0	2026-07-17 13:18:31.60915+00
52	ZEK5J78XUQH6JDBG	1	53	2	0	2026-07-17 13:19:35.726196+00
60	77YCWLE94KQ4VWWA	1	61	2	0	2026-07-17 13:20:05.036766+00
61	RUEQV7HDZGUHK62G	1	62	2	0	2026-07-17 13:20:07.665665+00
76	QWMQNYQBJ7W7M4HZ	1	77	2	2	2026-07-17 13:20:56.513735+00
21	XRE7FB8MYAHJL6DG	1	22	2	2	2026-07-17 13:17:29.884925+00
71	UAVAD97NHUGN9LSB	1	72	2	1	2026-07-17 13:20:43.394378+00
74	NJTVD52FG4MKY6M7	1	75	2	2	2026-07-17 13:20:51.457635+00
1	Z9TFUXAWHTQH3XJ2	1	2	2	1	2026-07-17 13:13:25.018905+00
43	SR3CWGXQ8NTHEZH3	1	44	2	2	2026-07-17 13:18:56.707903+00
32	TR2H2U5LMKEVFUG7	1	33	2	1	2026-07-17 13:18:18.659534+00
56	EK2J65RTN5DNXHYX	1	57	2	1	2026-07-17 13:19:49.084865+00
51	45T3T7LZKQKCYD23	1	52	2	2	2026-07-17 13:19:31.21836+00
79	HUTYP4R2Q44XQG3Q	1	80	2	2	2026-07-17 13:21:13.032099+00
16	GUQVQZSDT7V285NR	1	17	2	2	2026-07-17 13:16:30.108916+00
47	837NUNENH5YDV2LF	1	48	2	1	2026-07-17 13:19:17.448128+00
5	AXCM7CFEMGZ5ANAE	1	6	2	2	2026-07-17 13:14:44.572492+00
81	DB75GDX8KYJ2HGTC	1	82	2	2	2026-07-17 13:21:17.912962+00
22	MK5T6WP5L97Y2U8H	1	23	2	1	2026-07-17 13:17:32.812887+00
45	2YU2PU6FXFMP6NVL	1	46	2	1	2026-07-17 13:19:06.888541+00
11	S8JRFAJWHWHRF6TV	1	12	2	2	2026-07-17 13:16:15.157186+00
28	5HSKBMK7VHTUUN2Z	1	29	2	2	2026-07-17 13:17:52.093103+00
17	GNAZ2SDTDH5HHWC9	1	18	2	2	2026-07-17 13:16:34.325376+00
54	2F3EBBTLA288UG6A	1	55	2	1	2026-07-17 13:19:40.967257+00
34	3WSR9XSLPKJ2PL8T	1	35	2	1	2026-07-17 13:18:24.410775+00
70	V4UKG7M53CLA47DP	1	71	2	1	2026-07-17 13:20:40.53376+00
68	2MZS9BC223BHE9P4	1	69	2	2	2026-07-17 13:20:34.486305+00
30	79LRQKNT8TGLF58X	1	31	2	1	2026-07-17 13:18:12.379782+00
63	Z3KAGPCGPVHK4ME5	1	64	2	1	2026-07-17 13:20:13.526242+00
37	UJBCU5BKZD2Z362E	1	38	2	1	2026-07-17 13:18:39.978356+00
64	FEDA2J9LS2MA77TS	1	65	2	2	2026-07-17 13:20:16.26233+00
42	XHJ8DCPBJZEX8XW3	1	43	2	2	2026-07-17 13:18:53.759576+00
53	WUXFQWXDHBCKQKJ7	1	54	2	2	2026-07-17 13:19:38.158457+00
77	SLV7HBR67FJXPDLE	1	78	2	1	2026-07-17 13:20:59.06671+00
55	ZEBPAHSDKRRU86ME	1	56	2	2	2026-07-17 13:19:43.390159+00
3	X2U3T4BBBLKTCVQS	1	4	2	1	2026-07-17 13:14:35.342268+00
58	VEP77K63B4KE3UU9	1	59	2	2	2026-07-17 13:19:59.57711+00
67	A78N4GPXXN7HR5QK	1	68	2	1	2026-07-17 13:20:30.943245+00
39	CZFY6LTESSYL5LZK	1	40	2	1	2026-07-17 13:18:45.919376+00
2	7PBBPAB4VUEEGGY6	1	3	2	2	2026-07-17 13:14:30.421683+00
4	6LCLVL5XUNA3DLZW	1	5	2	1	2026-07-17 13:14:39.542199+00
75	MHMEPZ5KM6G8RE75	1	76	2	1	2026-07-17 13:20:54.102862+00
49	ED2ECYH5YD6MLEYH	1	50	2	1	2026-07-17 13:19:25.276762+00
65	TWYU63NB6DXEV4D3	1	66	2	2	2026-07-17 13:20:19.324404+00
57	QW9RUMYU8TAMELN2	1	58	2	1	2026-07-17 13:19:56.985167+00
29	6D9JAESRXHFXP6AM	1	30	2	2	2026-07-17 13:17:56.112082+00
35	Y95A3KEL4T4X2BCY	1	36	2	1	2026-07-17 13:18:28.440457+00
27	3SQBPM52UL96WNWY	1	28	2	2	2026-07-17 13:17:49.263492+00
46	KXK7UKZXFXWFSNJ8	1	47	2	1	2026-07-17 13:19:14.537101+00
26	437C7VH5YPJFXEKH	1	27	2	1	2026-07-17 13:17:46.619546+00
78	VG5GL5TS3KPNNYXB	1	79	2	2	2026-07-17 13:21:09.311985+00
12	LPP6ZTLUGPRZRKGG	1	13	2	2	2026-07-17 13:16:18.019402+00
40	Q4P4996V59GLXKP4	1	41	2	2	2026-07-17 13:18:48.629935+00
73	3GQ2827H9QFLSHB5	1	74	2	1	2026-07-17 13:20:48.812303+00
8	PCBTLQFD9BTL9UCP	1	9	2	2	2026-07-17 13:15:46.399044+00
50	52YKSUCYFUAKUXKT	1	51	2	2	2026-07-17 13:19:28.097143+00
38	YQMQBBMAVAWTZGNC	1	39	2	2	2026-07-17 13:18:43.269981+00
25	BE79DGFNYPQC86SX	1	26	2	2	2026-07-17 13:17:43.512389+00
59	XG37MCD6GWCHEBHR	1	60	2	1	2026-07-17 13:20:02.392193+00
6	AQTQ95GBSXUVEMJY	1	7	2	1	2026-07-17 13:15:23.218356+00
15	LH7PSCD45NGZNVJQ	1	16	2	2	2026-07-17 13:16:26.766876+00
72	PE7TGHRRL66FTXGM	1	73	2	2	2026-07-17 13:20:45.957144+00
31	D8Y2GNWX8TRZJYLA	1	32	2	2	2026-07-17 13:18:15.742011+00
20	ULXJ9SNK4KCL7UDZ	1	21	2	2	2026-07-17 13:17:26.23363+00
41	FF57ZESUT298LNJN	1	42	2	1	2026-07-17 13:18:51.169386+00
44	HU5Q4FJMS3GRR5BV	1	45	2	2	2026-07-17 13:18:59.90895+00
69	GJQSBJ59CDBN3UJ7	1	70	2	1	2026-07-17 13:20:37.593105+00
80	9QKDNYUZL4RPB2VW	1	81	2	2	2026-07-17 13:21:15.461094+00
48	YG38D7D5583966AE	1	49	2	2	2026-07-17 13:19:22.109693+00
23	UYD54GSUSG9SFXWW	1	24	2	2	2026-07-17 13:17:36.263665+00
66	CZA65A3FV6JFVWZT	1	67	2	2	2026-07-17 13:20:21.915142+00
13	J27GDYUSFBY7PRML	1	14	2	1	2026-07-17 13:16:20.477624+00
101	D4VP2B7S2X4QQUKT	1	102	2	0	2026-07-17 13:22:15.667999+00
105	QANRY4M2LMRGW5T8	1	106	99	1	2026-07-18 05:47:35.407812+00
33	7PQYD34Y4RSBQVY3	1	34	2	1	2026-07-17 13:18:21.331959+00
104	D9D9EFYTD9DBQUMB	1	105	2	1	2026-07-17 13:22:25.060408+00
102	PARVMRFKJ3MUZDDX	1	103	2	1	2026-07-17 13:22:18.749633+00
83	NMPRU4Q6GA5QMWD8	1	84	2	2	2026-07-17 13:21:23.383515+00
96	YNNSKNWG9SPPFNVG	1	97	2	2	2026-07-17 13:22:01.597779+00
95	NPSJ4K5GD2E9688Y	1	96	2	2	2026-07-17 13:21:58.950707+00
92	QEUU8K5NQQDE53ZW	1	93	2	1	2026-07-17 13:21:49.788518+00
94	C9DCGT5HTYL8PH97	1	95	2	1	2026-07-17 13:21:56.59025+00
98	Y8RRYF4XFNXAPAXR	1	99	2	2	2026-07-17 13:22:07.219789+00
90	KP86445FD2T85NLY	1	91	2	2	2026-07-17 13:21:44.448959+00
85	YZ9GGDKFRL5UTJZ4	1	86	2	2	2026-07-17 13:21:30.014986+00
7	PH36XB9GS8Q2XB58	1	8	2	2	2026-07-17 13:15:43.467506+00
99	RH43BY4JK3AX8ASA	1	100	2	1	2026-07-17 13:22:10.401532+00
100	3LFLYHR32XGP7F94	1	101	2	2	2026-07-17 13:22:13.078876+00
103	78XCKDHTZ5UHTMBA	1	104	2	1	2026-07-17 13:22:21.938948+00
86	YYYL7EJLEB5MTJNR	1	87	2	2	2026-07-17 13:21:33.36027+00
87	AJ2CAEHVUX23N3D5	1	88	2	2	2026-07-17 13:21:36.262269+00
82	TZQCLGES7G9F8TJ2	1	83	2	2	2026-07-17 13:21:20.69159+00
89	D6TYL9JPJA82TQZT	1	90	2	2	2026-07-17 13:21:41.681062+00
91	UXGTN3ERKZTE3DSV	1	92	2	2	2026-07-17 13:21:47.110258+00
62	VSB23U5E7A4RE8FD	1	63	2	2	2026-07-17 13:20:10.916649+00
97	FFLZZWZBSXE5KUNN	1	98	2	2	2026-07-17 13:22:04.575172+00
106	DJM6YPW3US6QRVEA	1	52	1	1	2026-07-18 23:59:33.335778+00
88	A4UU5MP5Y7RZ7GLX	1	89	2	2	2026-07-17 13:21:38.9303+00
107	AQVR3YPNSEGK7A6C	1	107	199	2	2026-07-19 00:15:03.52814+00
108	FZZ4ZRKWXKTW7C3S	1	108	1999	1	2026-07-19 00:15:12.666844+00
10	XWRFBHVYBAGXN49H	1	11	2	2	2026-07-17 13:15:53.189191+00
84	VS2FSM8TNJ6VXQL6	1	85	2	2	2026-07-17 13:21:27.080744+00
93	WMXFP6JYA7QVAQ5A	1	94	2	1	2026-07-17 13:21:53.892296+00
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.submissions (id, user_id, challenge_id, correct, is_first_blood, submitted_at) FROM stdin;
1	40	17	t	t	2026-07-19 00:00:13.466494+00
2	48	20	f	f	2026-07-19 00:00:15.324973+00
3	117	17	t	f	2026-07-19 00:00:16.131212+00
4	48	17	t	f	2026-07-19 00:00:20.716844+00
5	24	17	t	f	2026-07-19 00:00:31.395677+00
6	7	17	t	f	2026-07-19 00:00:35.679949+00
7	22	17	t	f	2026-07-19 00:00:44.880601+00
8	85	17	f	f	2026-07-19 00:00:46.963687+00
9	85	17	t	t	2026-07-19 00:00:55.239245+00
10	114	17	t	f	2026-07-19 00:01:01.525962+00
11	38	17	t	f	2026-07-19 00:01:13.423948+00
12	12	17	t	f	2026-07-19 00:01:27.394363+00
13	37	17	t	f	2026-07-19 00:01:43.742941+00
14	82	17	t	f	2026-07-19 00:01:46.263539+00
15	79	17	t	f	2026-07-19 00:01:54.958146+00
16	90	17	t	f	2026-07-19 00:02:03.865221+00
17	40	19	f	f	2026-07-19 00:02:05.638043+00
18	91	17	t	f	2026-07-19 00:02:16.656261+00
19	40	19	f	f	2026-07-19 00:02:25.567123+00
20	93	17	t	f	2026-07-19 00:02:29.882622+00
21	46	17	t	f	2026-07-19 00:02:42.087808+00
22	94	17	t	f	2026-07-19 00:02:49.516547+00
23	134	17	f	f	2026-07-19 00:03:07.019699+00
24	134	17	t	f	2026-07-19 00:03:13.612629+00
25	13	17	t	f	2026-07-19 00:03:54.321124+00
26	11	17	t	f	2026-07-19 00:04:29.52211+00
27	128	17	t	f	2026-07-19 00:04:48.23614+00
28	73	2	f	f	2026-07-19 00:05:11.826082+00
29	65	17	t	f	2026-07-19 00:05:11.926335+00
30	50	17	t	f	2026-07-19 00:05:15.787633+00
31	40	19	t	t	2026-07-19 00:05:37.092439+00
32	21	17	t	f	2026-07-19 00:05:41.07789+00
33	82	19	f	f	2026-07-19 00:05:54.128407+00
34	92	17	t	f	2026-07-19 00:05:54.249615+00
35	111	17	t	f	2026-07-19 00:05:57.202744+00
36	82	19	f	f	2026-07-19 00:06:18.704088+00
37	110	17	t	f	2026-07-19 00:06:39.509577+00
38	36	17	t	f	2026-07-19 00:07:17.111139+00
39	32	17	t	f	2026-07-19 00:07:28.118181+00
40	60	17	t	f	2026-07-19 00:07:31.08252+00
41	96	17	t	f	2026-07-19 00:07:33.687009+00
42	68	7	t	t	2026-07-19 00:07:42.436417+00
43	134	19	f	f	2026-07-19 00:07:47.282318+00
44	134	19	f	f	2026-07-19 00:07:54.483493+00
45	136	17	t	f	2026-07-19 00:07:59.69849+00
46	25	17	t	f	2026-07-19 00:08:02.464304+00
47	121	19	f	f	2026-07-19 00:08:10.761853+00
48	52	17	t	f	2026-07-19 00:08:29.379484+00
49	134	19	f	f	2026-07-19 00:09:06.290946+00
50	15	19	t	t	2026-07-19 00:09:17.349826+00
51	133	17	t	f	2026-07-19 00:09:19.469147+00
52	51	17	t	f	2026-07-19 00:09:21.009756+00
53	139	17	t	f	2026-07-19 00:09:30.032332+00
54	57	17	t	f	2026-07-19 00:09:36.260085+00
55	71	17	t	f	2026-07-19 00:09:53.113823+00
56	51	19	f	f	2026-07-19 00:09:56.930889+00
57	21	6	t	t	2026-07-19 00:09:57.8109+00
58	92	1	t	t	2026-07-19 00:10:00.531445+00
59	27	17	t	f	2026-07-19 00:10:02.925775+00
60	4	17	t	f	2026-07-19 00:10:10.226989+00
61	38	7	t	f	2026-07-19 00:10:12.767942+00
62	60	19	f	f	2026-07-19 00:10:29.035721+00
63	93	7	t	t	2026-07-19 00:10:40.117314+00
64	117	19	f	f	2026-07-19 00:11:00.02205+00
65	84	17	t	f	2026-07-19 00:11:13.668677+00
66	51	20	f	f	2026-07-19 00:11:24.47227+00
67	51	20	t	t	2026-07-19 00:11:27.478567+00
68	76	1	t	f	2026-07-19 00:11:35.673767+00
69	60	19	f	f	2026-07-19 00:11:47.112523+00
70	88	17	t	f	2026-07-19 00:11:50.34763+00
71	67	17	t	f	2026-07-19 00:11:57.137688+00
72	12	19	f	f	2026-07-19 00:12:01.3498+00
73	12	19	f	f	2026-07-19 00:12:06.971077+00
74	121	19	f	f	2026-07-19 00:12:16.501449+00
75	85	7	t	f	2026-07-19 00:12:20.618243+00
76	133	7	t	f	2026-07-19 00:12:40.94668+00
77	7	6	f	f	2026-07-19 00:12:43.4607+00
78	40	20	f	f	2026-07-19 00:12:44.732966+00
79	7	7	t	f	2026-07-19 00:12:50.851843+00
80	62	20	t	t	2026-07-19 00:12:53.930495+00
81	94	20	t	f	2026-07-19 00:12:57.332613+00
82	62	19	f	f	2026-07-19 00:13:09.316709+00
83	93	20	t	f	2026-07-19 00:13:46.236359+00
84	110	19	f	f	2026-07-19 00:13:46.597637+00
85	139	20	t	f	2026-07-19 00:13:48.197365+00
86	67	20	t	f	2026-07-19 00:13:49.110657+00
87	40	20	t	f	2026-07-19 00:13:50.650606+00
88	51	21	f	f	2026-07-19 00:13:56.808311+00
89	37	7	t	f	2026-07-19 00:13:57.641505+00
90	4	19	f	f	2026-07-19 00:14:00.216874+00
91	51	21	f	f	2026-07-19 00:14:02.673483+00
92	138	17	t	f	2026-07-19 00:14:03.193766+00
93	51	21	f	f	2026-07-19 00:14:09.713921+00
94	38	20	t	f	2026-07-19 00:14:11.530692+00
95	112	20	t	f	2026-07-19 00:14:13.299818+00
96	29	19	f	f	2026-07-19 00:14:15.184818+00
97	51	21	f	f	2026-07-19 00:14:15.940886+00
98	29	19	f	f	2026-07-19 00:14:19.216102+00
99	51	21	f	f	2026-07-19 00:14:27.503915+00
100	15	6	t	f	2026-07-19 00:14:32.742253+00
101	137	20	t	f	2026-07-19 00:14:33.135966+00
102	30	20	t	f	2026-07-19 00:14:41.759918+00
103	76	6	t	f	2026-07-19 00:14:41.877949+00
104	4	19	f	f	2026-07-19 00:14:43.891228+00
105	68	19	t	f	2026-07-19 00:14:46.363041+00
106	29	19	f	f	2026-07-19 00:14:46.992351+00
107	4	19	f	f	2026-07-19 00:14:48.855636+00
108	38	21	f	f	2026-07-19 00:14:56.213365+00
109	81	7	t	f	2026-07-19 00:14:56.415386+00
110	87	20	t	f	2026-07-19 00:14:56.991718+00
111	21	20	t	f	2026-07-19 00:14:59.062462+00
112	52	20	t	f	2026-07-19 00:15:00.625254+00
113	29	6	f	f	2026-07-19 00:15:10.294597+00
114	21	7	t	f	2026-07-19 00:15:17.353377+00
115	94	6	f	f	2026-07-19 00:15:20.230119+00
116	35	17	t	f	2026-07-19 00:15:20.610243+00
117	76	11	t	t	2026-07-19 00:15:21.347973+00
118	19	6	f	f	2026-07-19 00:15:26.60886+00
119	38	21	f	f	2026-07-19 00:15:35.722739+00
120	37	20	t	f	2026-07-19 00:15:36.033342+00
121	26	20	t	f	2026-07-19 00:15:36.996386+00
122	19	7	t	f	2026-07-19 00:15:37.967642+00
126	17	6	t	f	2026-07-19 00:15:44.612175+00
129	94	6	f	f	2026-07-19 00:15:51.829729+00
132	12	6	f	f	2026-07-19 00:15:57.695876+00
140	138	20	t	f	2026-07-19 00:16:33.180498+00
144	13	19	f	f	2026-07-19 00:17:10.198527+00
145	105	20	f	f	2026-07-19 00:17:16.177418+00
150	88	20	t	f	2026-07-19 00:17:32.551508+00
151	18	6	t	f	2026-07-19 00:17:32.958261+00
152	92	7	t	f	2026-07-19 00:17:35.334993+00
157	105	20	f	f	2026-07-19 00:18:04.265343+00
158	95	20	t	f	2026-07-19 00:18:06.250303+00
164	92	20	t	f	2026-07-19 00:18:40.319013+00
166	137	7	t	f	2026-07-19 00:18:45.050493+00
1230	77	26	f	f	2026-07-19 01:24:17.757079+00
1231	139	27	t	f	2026-07-19 01:24:19.099885+00
1238	7	14	f	f	2026-07-19 01:25:02.786879+00
1240	77	26	f	f	2026-07-19 01:25:08.443983+00
1243	103	21	f	f	2026-07-19 01:25:24.323357+00
1246	22	27	t	t	2026-07-19 01:25:32.218686+00
1247	60	22	t	f	2026-07-19 01:25:40.361266+00
1250	95	4	t	t	2026-07-19 01:25:52.943056+00
1251	16	6	f	f	2026-07-19 01:25:55.288137+00
1252	29	20	t	f	2026-07-19 01:25:55.547382+00
1623	21	5	t	f	2026-07-19 01:53:19.820888+00
1628	17	5	t	f	2026-07-19 01:53:42.524369+00
1632	116	4	f	f	2026-07-19 01:54:02.131378+00
1642	65	26	f	f	2026-07-19 01:54:50.487075+00
1646	4	22	f	f	2026-07-19 01:55:08.546239+00
1652	32	14	f	f	2026-07-19 01:55:39.463043+00
1661	54	17	t	f	2026-07-19 01:56:05.201156+00
1662	112	14	f	f	2026-07-19 01:56:18.553197+00
1664	81	2	t	f	2026-07-19 01:56:27.031121+00
1666	8	14	f	f	2026-07-19 01:56:38.614384+00
1668	89	24	f	f	2026-07-19 01:56:49.401095+00
1678	85	21	f	f	2026-07-19 01:57:59.372561+00
1681	136	21	f	f	2026-07-19 01:58:31.771325+00
1682	136	21	f	f	2026-07-19 01:58:35.136304+00
1686	148	21	f	f	2026-07-19 01:59:04.409308+00
1688	95	24	f	f	2026-07-19 01:59:07.134483+00
1690	89	14	f	f	2026-07-19 01:59:15.156696+00
1691	4	22	t	f	2026-07-19 01:59:17.317398+00
1700	11	22	f	f	2026-07-19 01:59:43.422611+00
1701	88	21	f	f	2026-07-19 01:59:43.495093+00
1702	11	22	f	f	2026-07-19 01:59:45.803041+00
1712	47	14	f	f	2026-07-19 02:01:03.793912+00
1714	8	14	t	f	2026-07-19 02:01:16.189503+00
1718	133	22	f	f	2026-07-19 02:01:47.909902+00
1719	11	22	t	f	2026-07-19 02:01:50.733764+00
1722	18	4	f	f	2026-07-19 02:02:05.04909+00
1724	85	21	f	f	2026-07-19 02:02:22.828871+00
1725	89	14	f	f	2026-07-19 02:02:33.79998+00
1732	149	20	t	f	2026-07-19 02:03:16.054694+00
1733	106	23	t	f	2026-07-19 02:03:20.005797+00
1734	50	24	f	f	2026-07-19 02:03:20.295506+00
1735	133	22	f	f	2026-07-19 02:03:22.491957+00
1736	119	11	t	f	2026-07-19 02:03:23.463654+00
1737	50	24	f	f	2026-07-19 02:03:24.914475+00
1738	133	22	f	f	2026-07-19 02:03:25.393044+00
1739	94	26	f	f	2026-07-19 02:03:30.9802+00
1740	94	26	t	f	2026-07-19 02:03:35.738856+00
1747	32	22	f	f	2026-07-19 02:04:01.458844+00
2195	44	22	f	f	2026-07-19 02:44:34.192681+00
2196	113	6	t	f	2026-07-19 02:44:42.360251+00
2197	67	23	t	f	2026-07-19 02:44:45.597203+00
2198	105	13	t	f	2026-07-19 02:44:48.742475+00
2199	53	13	f	f	2026-07-19 02:44:52.692594+00
2200	148	21	f	f	2026-07-19 02:44:53.087244+00
2203	81	16	t	f	2026-07-19 02:45:44.692726+00
2214	101	22	t	f	2026-07-19 02:48:41.114781+00
2251	101	24	f	f	2026-07-19 02:54:46.660538+00
2257	119	26	f	f	2026-07-19 02:56:04.999127+00
2260	44	22	f	f	2026-07-19 02:56:16.562789+00
2262	44	22	f	f	2026-07-19 02:57:18.871637+00
2263	73	20	t	f	2026-07-19 02:57:21.984321+00
2278	85	16	f	f	2026-07-19 02:59:44.241173+00
2703	39	14	f	f	2026-07-19 03:49:50.373713+00
2708	77	5	f	f	2026-07-19 03:50:06.400946+00
2710	77	5	f	f	2026-07-19 03:50:11.580812+00
2711	6	6	t	f	2026-07-19 03:50:44.633654+00
2719	24	25	f	f	2026-07-19 03:53:13.472853+00
2720	39	15	t	f	2026-07-19 03:53:13.50853+00
2721	24	25	f	f	2026-07-19 03:53:15.12814+00
2723	121	26	f	f	2026-07-19 03:54:00.513776+00
2725	152	21	t	f	2026-07-19 03:54:56.860819+00
2728	119	18	f	f	2026-07-19 03:55:38.762967+00
2729	6	23	t	f	2026-07-19 03:56:37.738431+00
2733	119	26	f	f	2026-07-19 03:57:40.034033+00
2771	97	19	f	f	2026-07-19 04:03:03.556981+00
2780	75	22	f	f	2026-07-19 04:04:39.076013+00
2781	145	21	f	f	2026-07-19 04:04:53.41229+00
2783	145	21	f	f	2026-07-19 04:05:15.652937+00
2791	75	22	f	f	2026-07-19 04:07:22.019605+00
2792	75	22	f	f	2026-07-19 04:07:30.685113+00
2795	119	27	t	f	2026-07-19 04:07:57.9007+00
2796	39	19	f	f	2026-07-19 04:07:59.2074+00
2797	148	19	f	f	2026-07-19 04:08:06.742695+00
2803	75	22	f	f	2026-07-19 04:08:33.8613+00
2805	75	22	f	f	2026-07-19 04:09:20.189923+00
2810	69	16	t	f	2026-07-19 04:10:38.152951+00
2815	152	22	t	f	2026-07-19 04:11:32.056018+00
2819	4	26	t	f	2026-07-19 04:12:11.815605+00
2823	26	4	f	f	2026-07-19 04:13:02.965835+00
2824	113	22	f	f	2026-07-19 04:13:08.94213+00
2829	89	16	f	f	2026-07-19 04:13:26.017112+00
2846	148	24	f	f	2026-07-19 04:15:36.512635+00
3141	65	26	f	f	2026-07-19 05:02:31.68255+00
3142	8	22	f	f	2026-07-19 05:02:42.024132+00
3148	4	12	t	f	2026-07-19 05:04:39.168563+00
3150	103	4	f	f	2026-07-19 05:05:27.359352+00
3151	133	4	t	f	2026-07-19 05:05:41.357762+00
3152	6	26	f	f	2026-07-19 05:05:46.576602+00
3155	8	22	f	f	2026-07-19 05:06:16.489632+00
3156	5	18	t	f	2026-07-19 05:06:18.356366+00
3157	8	22	f	f	2026-07-19 05:06:24.581281+00
3164	72	19	t	f	2026-07-19 05:08:29.122951+00
3173	106	17	t	f	2026-07-19 05:12:01.967541+00
3508	109	21	f	f	2026-07-19 06:21:11.184731+00
3530	36	14	f	f	2026-07-19 06:24:49.451617+00
123	46	19	f	f	2026-07-19 00:15:40.718199+00
124	94	7	t	f	2026-07-19 00:15:42.24851+00
125	112	21	f	f	2026-07-19 00:15:44.087785+00
128	126	17	t	f	2026-07-19 00:15:50.684827+00
131	93	21	f	f	2026-07-19 00:15:57.64466+00
133	18	19	f	f	2026-07-19 00:16:00.823397+00
135	12	6	f	f	2026-07-19 00:16:25.81947+00
136	22	20	t	f	2026-07-19 00:16:29.199199+00
138	84	19	f	f	2026-07-19 00:16:30.272052+00
139	121	19	f	f	2026-07-19 00:16:32.967251+00
141	139	21	f	f	2026-07-19 00:16:43.956332+00
147	111	6	t	f	2026-07-19 00:17:22.784312+00
148	38	6	t	f	2026-07-19 00:17:25.834415+00
149	71	20	f	f	2026-07-19 00:17:26.692545+00
160	81	6	f	f	2026-07-19 00:18:22.142058+00
1232	27	16	f	f	2026-07-19 01:24:20.381326+00
1245	136	21	f	f	2026-07-19 01:25:29.496326+00
1624	51	14	t	f	2026-07-19 01:53:33.883246+00
1631	105	21	f	f	2026-07-19 01:53:56.491971+00
1633	85	21	f	f	2026-07-19 01:54:16.35711+00
1634	85	21	f	f	2026-07-19 01:54:18.628878+00
1636	77	5	f	f	2026-07-19 01:54:33.505538+00
1640	89	24	f	f	2026-07-19 01:54:43.456761+00
1641	44	21	f	f	2026-07-19 01:54:47.322372+00
1645	32	14	f	f	2026-07-19 01:54:59.433137+00
1647	44	21	f	f	2026-07-19 01:55:08.927358+00
1650	104	1	t	f	2026-07-19 01:55:34.891567+00
1651	32	14	f	f	2026-07-19 01:55:38.350071+00
1653	32	14	f	f	2026-07-19 01:55:40.705877+00
1655	85	21	f	f	2026-07-19 01:55:48.01709+00
1656	85	21	f	f	2026-07-19 01:55:50.557244+00
1660	89	24	f	f	2026-07-19 01:56:01.037043+00
2201	75	21	f	f	2026-07-19 02:45:03.076149+00
2202	78	21	f	f	2026-07-19 02:45:23.764694+00
2212	82	22	f	f	2026-07-19 02:47:39.515444+00
2215	144	14	f	f	2026-07-19 02:48:41.713965+00
2226	46	14	f	f	2026-07-19 02:50:55.763068+00
2227	125	14	f	f	2026-07-19 02:51:43.284977+00
2229	67	25	f	f	2026-07-19 02:51:57.146681+00
2265	119	19	f	f	2026-07-19 02:57:22.915365+00
2704	113	21	t	f	2026-07-19 03:49:52.433423+00
2705	39	14	f	f	2026-07-19 03:49:56.258488+00
2706	39	14	f	f	2026-07-19 03:49:57.611051+00
2707	94	19	f	f	2026-07-19 03:49:58.703459+00
2709	39	14	t	f	2026-07-19 03:50:09.19055+00
2714	106	27	f	f	2026-07-19 03:51:36.449169+00
2717	79	5	t	f	2026-07-19 03:52:17.510672+00
2772	100	14	f	f	2026-07-19 04:03:10.763723+00
2773	97	20	t	f	2026-07-19 04:03:40.715101+00
2776	75	22	f	f	2026-07-19 04:04:00.475053+00
2785	145	21	f	f	2026-07-19 04:05:45.224443+00
2786	121	26	f	f	2026-07-19 04:05:57.433597+00
2787	101	19	f	f	2026-07-19 04:06:04.731688+00
2788	119	27	f	f	2026-07-19 04:06:34.039301+00
2799	66	19	f	f	2026-07-19 04:08:14.968015+00
2801	44	24	f	f	2026-07-19 04:08:27.043098+00
2804	65	26	f	f	2026-07-19 04:09:03.554696+00
2812	38	19	f	f	2026-07-19 04:11:03.166281+00
2813	38	19	f	f	2026-07-19 04:11:13.343538+00
2821	75	22	f	f	2026-07-19 04:12:29.982518+00
2822	72	18	t	f	2026-07-19 04:12:43.861657+00
2827	145	21	f	f	2026-07-19 04:13:17.287872+00
2830	44	24	f	f	2026-07-19 04:13:32.721318+00
2832	44	24	f	f	2026-07-19 04:13:35.341307+00
2839	44	24	f	f	2026-07-19 04:14:10.6134+00
2841	72	24	t	f	2026-07-19 04:14:16.262278+00
2852	106	19	f	f	2026-07-19 04:16:46.298497+00
2863	72	25	t	f	2026-07-19 04:18:46.213241+00
2866	65	26	f	f	2026-07-19 04:19:22.033066+00
2870	119	19	f	f	2026-07-19 04:19:53.817788+00
2873	119	19	f	f	2026-07-19 04:20:20.417491+00
2878	121	27	f	f	2026-07-19 04:22:11.360592+00
2880	149	6	t	f	2026-07-19 04:22:50.49508+00
2885	4	19	f	f	2026-07-19 04:23:49.665222+00
3144	60	19	f	f	2026-07-19 05:03:03.876418+00
3145	15	5	t	f	2026-07-19 05:03:08.653743+00
3149	6	26	f	f	2026-07-19 05:05:18.195251+00
3161	13	19	f	f	2026-07-19 05:07:16.330118+00
3162	79	19	t	f	2026-07-19 05:07:24.544978+00
3167	155	1	f	f	2026-07-19 05:09:55.03342+00
3170	71	22	f	f	2026-07-19 05:10:46.872165+00
3172	133	26	f	f	2026-07-19 05:10:59.670025+00
3174	133	26	f	f	2026-07-19 05:12:13.291248+00
3175	18	19	f	f	2026-07-19 05:12:55.349775+00
3176	54	9	t	f	2026-07-19 05:13:16.034014+00
3183	18	19	f	f	2026-07-19 05:16:29.076049+00
3184	106	16	t	f	2026-07-19 05:16:29.968679+00
3199	18	19	f	f	2026-07-19 05:18:41.560251+00
3200	115	21	t	f	2026-07-19 05:18:45.523496+00
3201	22	12	t	f	2026-07-19 05:18:48.228597+00
3219	26	14	f	f	2026-07-19 05:21:33.953173+00
3220	78	24	t	f	2026-07-19 05:21:34.310681+00
3222	115	22	f	f	2026-07-19 05:21:35.9982+00
3224	106	19	f	f	2026-07-19 05:21:44.725008+00
3229	115	22	f	f	2026-07-19 05:22:24.34015+00
3235	109	21	f	f	2026-07-19 05:23:16.801911+00
3236	18	19	f	f	2026-07-19 05:23:16.844874+00
3509	32	22	f	f	2026-07-19 06:21:46.582815+00
3510	32	22	f	f	2026-07-19 06:21:49.396623+00
3511	32	22	f	f	2026-07-19 06:21:51.893754+00
3512	32	22	f	f	2026-07-19 06:21:53.177733+00
3513	32	22	f	f	2026-07-19 06:21:57.271224+00
3515	32	22	f	f	2026-07-19 06:22:01.483644+00
3517	32	22	f	f	2026-07-19 06:22:07.97632+00
3518	32	22	f	f	2026-07-19 06:22:09.634281+00
3520	18	19	f	f	2026-07-19 06:22:39.559031+00
3522	24	19	f	f	2026-07-19 06:22:43.83335+00
3525	18	19	f	f	2026-07-19 06:23:19.934725+00
3532	82	14	f	f	2026-07-19 06:25:11.070287+00
3539	131	22	f	f	2026-07-19 06:25:56.145867+00
3540	40	23	t	f	2026-07-19 06:26:05.077903+00
3546	137	14	f	f	2026-07-19 06:27:18.501617+00
3547	18	19	f	f	2026-07-19 06:27:24.885215+00
3548	68	1	t	f	2026-07-19 06:27:30.624546+00
3550	149	8	t	f	2026-07-19 06:27:50.226393+00
3552	40	15	t	f	2026-07-19 06:28:20.29164+00
3553	75	25	f	f	2026-07-19 06:28:23.416367+00
3554	75	25	f	f	2026-07-19 06:28:27.026563+00
3560	32	22	f	f	2026-07-19 06:29:12.53015+00
3563	32	22	f	f	2026-07-19 06:29:19.625482+00
127	15	1	t	f	2026-07-19 00:15:49.682582+00
130	46	7	t	f	2026-07-19 00:15:52.451794+00
137	136	20	t	f	2026-07-19 00:16:29.543925+00
143	76	7	t	f	2026-07-19 00:17:00.615324+00
153	52	21	t	t	2026-07-19 00:17:37.21062+00
154	95	20	f	f	2026-07-19 00:18:02.310619+00
155	139	21	f	f	2026-07-19 00:18:03.75207+00
156	18	19	f	f	2026-07-19 00:18:03.807859+00
169	81	6	t	f	2026-07-19 00:18:51.449364+00
1233	79	10	t	f	2026-07-19 01:24:34.938857+00
1235	139	25	t	t	2026-07-19 01:24:37.344546+00
1236	27	16	f	f	2026-07-19 01:24:40.317264+00
1237	119	16	t	f	2026-07-19 01:24:52.506533+00
1239	50	21	t	f	2026-07-19 01:25:08.355991+00
1244	91	21	f	f	2026-07-19 01:25:25.000768+00
1248	144	11	t	f	2026-07-19 01:25:43.00378+00
1249	16	5	f	f	2026-07-19 01:25:49.976067+00
1253	9	4	f	f	2026-07-19 01:25:56.366571+00
1254	126	14	f	f	2026-07-19 01:25:59.214596+00
1255	16	7	f	f	2026-07-19 01:25:59.800528+00
1256	38	22	f	f	2026-07-19 01:26:01.89407+00
1671	148	16	t	f	2026-07-19 01:57:09.753256+00
1672	16	6	f	f	2026-07-19 01:57:09.962296+00
1674	4	22	f	f	2026-07-19 01:57:17.397076+00
1675	129	19	f	f	2026-07-19 01:57:38.596211+00
1677	60	27	t	f	2026-07-19 01:57:52.3345+00
1680	133	22	f	f	2026-07-19 01:58:29.312193+00
1683	149	19	f	f	2026-07-19 01:58:40.0207+00
1684	133	22	f	f	2026-07-19 01:58:47.075888+00
1685	88	21	f	f	2026-07-19 01:59:02.986208+00
1687	104	14	f	f	2026-07-19 01:59:04.837368+00
1689	85	21	f	f	2026-07-19 01:59:14.466635+00
1692	125	19	f	f	2026-07-19 01:59:25.227711+00
1695	67	21	f	f	2026-07-19 01:59:30.580825+00
1696	125	19	t	f	2026-07-19 01:59:31.873065+00
1697	78	20	t	f	2026-07-19 01:59:31.995487+00
1710	7	14	f	f	2026-07-19 02:00:57.840957+00
1715	85	21	f	f	2026-07-19 02:01:20.501194+00
1716	88	21	f	f	2026-07-19 02:01:34.479027+00
1720	94	26	f	f	2026-07-19 02:02:01.486366+00
1721	11	23	t	f	2026-07-19 02:02:01.561437+00
1723	79	13	t	f	2026-07-19 02:02:07.28431+00
1741	106	13	t	f	2026-07-19 02:03:47.310088+00
1742	25	24	f	f	2026-07-19 02:03:48.434252+00
1743	119	25	t	f	2026-07-19 02:03:49.623347+00
1744	4	8	t	f	2026-07-19 02:03:50.320536+00
1745	71	22	f	f	2026-07-19 02:03:51.082435+00
2209	125	14	f	f	2026-07-19 02:47:22.095127+00
2210	7	19	t	f	2026-07-19 02:47:28.156042+00
2216	92	14	f	f	2026-07-19 02:48:42.103656+00
2217	149	21	f	f	2026-07-19 02:48:43.51054+00
2219	81	19	f	f	2026-07-19 02:49:07.205712+00
2220	101	23	t	f	2026-07-19 02:49:55.644902+00
2228	67	25	f	f	2026-07-19 02:51:52.207522+00
2230	67	25	f	f	2026-07-19 02:51:58.909935+00
2231	148	14	f	f	2026-07-19 02:52:03.26291+00
2233	106	19	f	f	2026-07-19 02:52:26.382487+00
2244	95	16	t	f	2026-07-19 02:53:48.78818+00
2245	129	22	f	f	2026-07-19 02:53:53.638543+00
2253	25	25	t	f	2026-07-19 02:55:13.382413+00
2254	106	14	t	f	2026-07-19 02:55:35.879156+00
2261	44	22	f	f	2026-07-19 02:57:05.066039+00
2267	53	16	t	f	2026-07-19 02:57:37.773872+00
2268	152	14	f	f	2026-07-19 02:57:39.875466+00
2275	89	14	f	f	2026-07-19 02:58:20.852067+00
2293	17	26	t	f	2026-07-19 03:01:37.979803+00
2296	8	5	t	f	2026-07-19 03:01:58.45577+00
2297	149	21	f	f	2026-07-19 03:02:03.290966+00
2298	89	14	f	f	2026-07-19 03:02:05.158713+00
2299	72	10	t	f	2026-07-19 03:02:05.924149+00
2304	129	22	f	f	2026-07-19 03:02:57.961793+00
2305	131	21	f	f	2026-07-19 03:03:13.263215+00
2308	44	22	f	f	2026-07-19 03:03:36.544358+00
2309	95	14	f	f	2026-07-19 03:03:38.219094+00
2311	129	22	f	f	2026-07-19 03:03:38.961842+00
2313	95	14	f	f	2026-07-19 03:03:42.000441+00
2314	6	11	t	f	2026-07-19 03:03:44.033357+00
2315	44	22	f	f	2026-07-19 03:03:59.424694+00
2319	44	22	f	f	2026-07-19 03:04:32.476522+00
2321	67	18	t	f	2026-07-19 03:05:30.017407+00
2327	37	9	t	f	2026-07-19 03:06:51.918374+00
2345	38	24	f	f	2026-07-19 03:07:41.932673+00
2346	101	25	f	f	2026-07-19 03:07:46.204934+00
2347	38	24	f	f	2026-07-19 03:07:47.344878+00
2349	10	19	f	f	2026-07-19 03:08:10.277358+00
2350	44	22	f	f	2026-07-19 03:08:12.377256+00
2713	106	27	f	f	2026-07-19 03:51:30.638055+00
2715	106	27	f	f	2026-07-19 03:52:10.020109+00
2716	106	27	f	f	2026-07-19 03:52:13.707394+00
2774	75	22	f	f	2026-07-19 04:03:55.371586+00
2775	100	14	f	f	2026-07-19 04:03:58.416606+00
2777	106	27	t	f	2026-07-19 04:04:07.395532+00
2778	72	23	t	f	2026-07-19 04:04:19.496272+00
2855	54	14	f	f	2026-07-19 04:17:20.465301+00
2856	113	8	t	f	2026-07-19 04:17:44.731935+00
2859	107	19	f	f	2026-07-19 04:18:31.924414+00
2860	66	15	t	f	2026-07-19 04:18:33.741444+00
2862	107	19	f	f	2026-07-19 04:18:40.676691+00
2864	100	19	f	f	2026-07-19 04:18:49.012319+00
2865	152	24	t	f	2026-07-19 04:18:56.416555+00
2867	100	19	f	f	2026-07-19 04:19:44.970482+00
2877	126	12	t	f	2026-07-19 04:22:02.531731+00
2879	6	25	t	f	2026-07-19 04:22:22.935265+00
2881	121	27	f	f	2026-07-19 04:22:52.877979+00
3177	115	21	f	f	2026-07-19 05:14:48.013774+00
3185	126	4	t	f	2026-07-19 05:16:47.986844+00
3194	18	19	f	f	2026-07-19 05:17:42.519271+00
3196	34	13	t	f	2026-07-19 05:17:47.623861+00
3197	34	5	t	f	2026-07-19 05:18:04.926426+00
3198	18	19	f	f	2026-07-19 05:18:31.020404+00
3203	155	1	t	f	2026-07-19 05:18:55.861595+00
3207	67	4	f	f	2026-07-19 05:19:52.800886+00
3209	152	19	f	f	2026-07-19 05:20:23.604252+00
3211	109	21	f	f	2026-07-19 05:20:48.867596+00
3213	18	19	f	f	2026-07-19 05:21:01.648403+00
3215	29	22	f	f	2026-07-19 05:21:15.391262+00
3217	109	21	f	f	2026-07-19 05:21:31.72135+00
3227	65	26	f	f	2026-07-19 05:22:10.635288+00
3231	65	26	f	f	2026-07-19 05:22:30.70413+00
3232	18	19	f	f	2026-07-19 05:22:55.775486+00
134	12	6	f	f	2026-07-19 00:16:20.08952+00
142	93	6	t	t	2026-07-19 00:16:54.181294+00
146	88	20	f	f	2026-07-19 00:17:20.787365+00
159	92	6	t	f	2026-07-19 00:18:21.601927+00
161	105	20	t	f	2026-07-19 00:18:24.335892+00
162	84	19	f	f	2026-07-19 00:18:24.414339+00
163	65	20	t	f	2026-07-19 00:18:27.628781+00
165	112	6	f	f	2026-07-19 00:18:41.177123+00
167	51	1	t	t	2026-07-19 00:18:46.263568+00
168	112	6	f	f	2026-07-19 00:18:48.58204+00
170	60	1	t	f	2026-07-19 00:18:54.999608+00
171	71	6	t	f	2026-07-19 00:19:03.820371+00
172	112	21	t	t	2026-07-19 00:19:04.343543+00
173	111	7	t	f	2026-07-19 00:19:16.539874+00
174	12	6	t	f	2026-07-19 00:19:19.791139+00
175	8	2	t	t	2026-07-19 00:19:23.117502+00
176	54	2	t	t	2026-07-19 00:19:25.28324+00
177	51	6	f	f	2026-07-19 00:19:25.888297+00
178	111	20	t	f	2026-07-19 00:19:38.283217+00
179	109	17	t	f	2026-07-19 00:19:41.417805+00
180	51	6	f	f	2026-07-19 00:19:41.839435+00
181	84	19	f	f	2026-07-19 00:19:44.701793+00
182	15	2	t	f	2026-07-19 00:20:01.490719+00
183	95	19	f	f	2026-07-19 00:20:06.832243+00
184	102	11	t	t	2026-07-19 00:20:08.720939+00
185	95	19	f	f	2026-07-19 00:20:12.581017+00
186	94	21	f	f	2026-07-19 00:20:16.041378+00
187	17	7	t	f	2026-07-19 00:20:16.863689+00
188	21	21	f	f	2026-07-19 00:20:23.626398+00
189	22	7	f	f	2026-07-19 00:20:39.946842+00
190	51	6	t	f	2026-07-19 00:20:43.076314+00
191	104	20	f	f	2026-07-19 00:20:46.659349+00
192	111	2	t	f	2026-07-19 00:20:47.557492+00
193	22	7	t	f	2026-07-19 00:20:48.095891+00
194	104	20	t	f	2026-07-19 00:20:54.114312+00
195	76	17	t	f	2026-07-19 00:20:54.426004+00
196	20	21	f	f	2026-07-19 00:21:01.480492+00
197	71	20	t	f	2026-07-19 00:21:14.523393+00
198	35	20	t	f	2026-07-19 00:21:31.641327+00
199	106	19	f	f	2026-07-19 00:21:38.891952+00
200	117	6	t	f	2026-07-19 00:21:46.58724+00
201	22	21	f	f	2026-07-19 00:21:54.191073+00
202	9	8	f	f	2026-07-19 00:22:06.268796+00
203	134	20	t	f	2026-07-19 00:22:07.908162+00
204	9	7	t	f	2026-07-19 00:22:11.061503+00
205	111	1	t	f	2026-07-19 00:22:12.090118+00
206	84	19	f	f	2026-07-19 00:22:17.23485+00
207	19	6	f	f	2026-07-19 00:22:19.649394+00
208	121	20	t	f	2026-07-19 00:22:20.710291+00
209	138	19	f	f	2026-07-19 00:22:21.667151+00
210	13	19	f	f	2026-07-19 00:22:27.854704+00
211	94	21	f	f	2026-07-19 00:22:29.179218+00
212	138	19	f	f	2026-07-19 00:22:29.232274+00
213	84	19	f	f	2026-07-19 00:22:29.290467+00
214	17	21	f	f	2026-07-19 00:22:29.472689+00
215	93	21	f	f	2026-07-19 00:22:30.549058+00
216	19	6	f	f	2026-07-19 00:22:32.938382+00
217	94	21	f	f	2026-07-19 00:22:39.1043+00
218	27	6	f	f	2026-07-19 00:22:44.480364+00
219	19	6	f	f	2026-07-19 00:22:46.748213+00
220	94	21	f	f	2026-07-19 00:22:51.889116+00
221	27	6	f	f	2026-07-19 00:22:57.024724+00
222	94	21	f	f	2026-07-19 00:22:59.995605+00
223	35	21	f	f	2026-07-19 00:23:03.557419+00
224	88	21	f	f	2026-07-19 00:23:05.838328+00
225	30	21	t	f	2026-07-19 00:23:11.236892+00
226	29	7	t	f	2026-07-19 00:23:11.419284+00
227	27	6	f	f	2026-07-19 00:23:23.085527+00
228	88	21	f	f	2026-07-19 00:23:27.359519+00
229	27	6	f	f	2026-07-19 00:23:28.452786+00
230	19	6	t	f	2026-07-19 00:23:30.405421+00
231	133	11	t	f	2026-07-19 00:23:30.693069+00
232	138	2	t	f	2026-07-19 00:23:36.980183+00
233	37	21	f	f	2026-07-19 00:23:39.635656+00
234	139	21	f	f	2026-07-19 00:23:54.347695+00
235	139	21	f	f	2026-07-19 00:24:01.362665+00
236	9	1	t	f	2026-07-19 00:24:02.21116+00
237	65	19	t	f	2026-07-19 00:24:07.128263+00
238	4	7	t	f	2026-07-19 00:24:12.657294+00
239	38	21	f	f	2026-07-19 00:24:14.055793+00
240	27	6	f	f	2026-07-19 00:24:16.869081+00
241	29	1	f	f	2026-07-19 00:24:21.991967+00
242	81	20	t	f	2026-07-19 00:24:23.528485+00
243	77	21	t	f	2026-07-19 00:24:31.659804+00
244	4	6	f	f	2026-07-19 00:24:33.999715+00
245	139	21	f	f	2026-07-19 00:24:34.856335+00
246	54	7	t	f	2026-07-19 00:24:37.64731+00
247	33	17	t	f	2026-07-19 00:24:37.84695+00
248	121	19	f	f	2026-07-19 00:24:39.91906+00
249	67	21	f	f	2026-07-19 00:24:40.696126+00
250	133	6	t	f	2026-07-19 00:24:41.947984+00
251	18	19	f	f	2026-07-19 00:24:42.442409+00
252	112	2	t	f	2026-07-19 00:24:44.589962+00
253	8	21	f	f	2026-07-19 00:24:45.293359+00
254	104	1	f	f	2026-07-19 00:24:45.535526+00
255	138	7	t	f	2026-07-19 00:24:47.198818+00
256	9	6	f	f	2026-07-19 00:24:49.087911+00
257	104	1	f	f	2026-07-19 00:24:51.049692+00
258	9	6	f	f	2026-07-19 00:24:53.676472+00
259	4	6	f	f	2026-07-19 00:24:54.883063+00
260	104	21	f	f	2026-07-19 00:24:59.362025+00
261	93	21	f	f	2026-07-19 00:24:59.37609+00
262	139	21	f	f	2026-07-19 00:24:59.601778+00
263	22	21	t	f	2026-07-19 00:25:01.048649+00
264	67	19	f	f	2026-07-19 00:25:02.808093+00
265	104	21	f	f	2026-07-19 00:25:04.147182+00
266	104	21	f	f	2026-07-19 00:25:08.482783+00
267	27	6	f	f	2026-07-19 00:25:10.27515+00
268	67	19	f	f	2026-07-19 00:25:11.129563+00
269	12	7	t	f	2026-07-19 00:25:14.016507+00
270	104	21	f	f	2026-07-19 00:25:14.077326+00
271	94	21	f	f	2026-07-19 00:25:15.418114+00
272	119	17	t	f	2026-07-19 00:25:16.217015+00
273	94	21	f	f	2026-07-19 00:25:23.012312+00
274	29	1	f	f	2026-07-19 00:25:27.653752+00
275	94	21	f	f	2026-07-19 00:25:29.104928+00
276	22	6	t	f	2026-07-19 00:25:33.0438+00
277	92	2	t	f	2026-07-19 00:25:36.338572+00
278	94	21	f	f	2026-07-19 00:25:40.548737+00
279	62	2	f	f	2026-07-19 00:25:42.702252+00
280	94	21	f	f	2026-07-19 00:25:49.054197+00
282	62	1	f	f	2026-07-19 00:25:50.397217+00
285	65	2	t	f	2026-07-19 00:25:56.853644+00
287	62	2	f	f	2026-07-19 00:25:58.465967+00
288	62	1	f	f	2026-07-19 00:26:01.854481+00
1234	144	15	t	f	2026-07-19 01:24:35.7521+00
1241	46	14	f	f	2026-07-19 01:25:10.432544+00
1242	37	13	t	f	2026-07-19 01:25:17.098163+00
1703	4	23	t	f	2026-07-19 01:59:54.952822+00
1704	69	24	f	f	2026-07-19 01:59:58.074136+00
1713	47	14	f	f	2026-07-19 02:01:09.478639+00
1728	92	25	t	f	2026-07-19 02:02:58.932072+00
1746	17	21	t	f	2026-07-19 02:03:58.752288+00
1748	25	24	f	f	2026-07-19 02:04:01.989444+00
2232	67	25	f	f	2026-07-19 02:52:13.528622+00
2234	17	25	f	f	2026-07-19 02:52:30.682976+00
2242	8	18	f	f	2026-07-19 02:53:25.869581+00
2243	81	19	f	f	2026-07-19 02:53:43.38315+00
2246	144	14	f	f	2026-07-19 02:53:56.815366+00
2247	89	19	f	f	2026-07-19 02:54:00.151785+00
2255	44	22	f	f	2026-07-19 02:55:53.858136+00
2269	131	1	t	f	2026-07-19 02:57:43.005049+00
2288	51	18	f	f	2026-07-19 03:00:53.378766+00
2310	44	22	f	f	2026-07-19 03:03:38.595638+00
2316	44	22	f	f	2026-07-19 03:04:02.828004+00
2317	44	22	f	f	2026-07-19 03:04:20.83435+00
2318	44	22	f	f	2026-07-19 03:04:27.683862+00
2718	26	15	t	f	2026-07-19 03:53:01.472124+00
2779	75	22	f	f	2026-07-19 04:04:36.114616+00
2789	148	22	f	f	2026-07-19 04:06:54.649728+00
2798	148	19	f	f	2026-07-19 04:08:10.622537+00
2806	121	26	f	f	2026-07-19 04:09:26.26119+00
2807	97	19	f	f	2026-07-19 04:09:59.151255+00
2808	100	14	f	f	2026-07-19 04:10:06.400523+00
2809	44	24	f	f	2026-07-19 04:10:11.692378+00
2814	4	26	f	f	2026-07-19 04:11:26.908076+00
2816	100	14	f	f	2026-07-19 04:11:44.608068+00
2817	152	23	t	f	2026-07-19 04:11:46.949176+00
2818	48	18	t	f	2026-07-19 04:11:50.478385+00
2835	6	2	t	f	2026-07-19 04:13:48.543695+00
2836	145	21	f	f	2026-07-19 04:13:50.7642+00
2838	145	21	f	f	2026-07-19 04:14:05.147822+00
2842	44	24	t	f	2026-07-19 04:14:42.067709+00
2843	148	24	f	f	2026-07-19 04:14:55.271213+00
2844	148	24	f	f	2026-07-19 04:14:59.717833+00
2853	148	24	f	f	2026-07-19 04:16:57.577951+00
2857	75	22	f	f	2026-07-19 04:18:27.961301+00
2869	100	19	f	f	2026-07-19 04:19:53.151819+00
2872	119	19	f	f	2026-07-19 04:20:13.829945+00
2876	121	27	f	f	2026-07-19 04:21:39.907615+00
2883	107	19	f	f	2026-07-19 04:23:38.618194+00
2884	4	19	f	f	2026-07-19 04:23:39.120456+00
2886	121	27	t	f	2026-07-19 04:24:02.605976+00
2887	53	27	f	f	2026-07-19 04:24:26.764676+00
3186	60	11	t	f	2026-07-19 05:16:53.184554+00
3187	18	19	f	f	2026-07-19 05:16:59.903095+00
3188	18	19	f	f	2026-07-19 05:17:13.450939+00
3189	34	5	f	f	2026-07-19 05:17:14.457967+00
3202	103	4	f	f	2026-07-19 05:18:50.797244+00
3204	103	4	f	f	2026-07-19 05:19:03.761808+00
3206	152	26	f	f	2026-07-19 05:19:47.883783+00
3218	115	22	f	f	2026-07-19 05:21:33.089412+00
3221	109	21	f	f	2026-07-19 05:21:35.715271+00
3225	65	26	f	f	2026-07-19 05:21:58.632736+00
3226	106	19	f	f	2026-07-19 05:22:03.227415+00
3233	113	18	t	f	2026-07-19 05:22:56.107173+00
3234	8	22	f	f	2026-07-19 05:23:02.843428+00
3239	8	22	f	f	2026-07-19 05:24:06.844041+00
3240	131	21	f	f	2026-07-19 05:24:10.267906+00
3242	145	21	f	f	2026-07-19 05:24:42.288466+00
3245	18	19	f	f	2026-07-19 05:25:29.330314+00
3246	27	13	t	f	2026-07-19 05:25:29.985584+00
3247	18	19	f	f	2026-07-19 05:25:42.52761+00
3249	39	11	t	f	2026-07-19 05:25:50.525012+00
3254	106	19	f	f	2026-07-19 05:26:22.291061+00
3256	18	19	f	f	2026-07-19 05:26:36.816645+00
3257	106	19	f	f	2026-07-19 05:26:42.737712+00
3258	106	19	f	f	2026-07-19 05:26:53.717025+00
3267	62	26	f	f	2026-07-19 05:30:46.842545+00
3269	115	22	f	f	2026-07-19 05:31:29.71831+00
3274	115	22	f	f	2026-07-19 05:31:51.398108+00
3280	115	22	f	f	2026-07-19 05:32:49.636402+00
3286	54	15	t	f	2026-07-19 05:33:51.808766+00
3288	115	22	f	f	2026-07-19 05:34:07.412774+00
3289	115	22	f	f	2026-07-19 05:34:13.607196+00
3290	115	22	f	f	2026-07-19 05:34:19.027489+00
3514	32	22	f	f	2026-07-19 06:21:59.077055+00
3516	32	22	f	f	2026-07-19 06:22:02.649751+00
3519	54	12	t	f	2026-07-19 06:22:28.773092+00
3521	24	19	f	f	2026-07-19 06:22:40.328828+00
3526	152	19	f	f	2026-07-19 06:24:11.672842+00
3527	154	21	f	f	2026-07-19 06:24:30.58744+00
3531	4	19	t	f	2026-07-19 06:25:09.971569+00
3534	32	22	f	f	2026-07-19 06:25:20.934372+00
3535	32	22	f	f	2026-07-19 06:25:23.917988+00
3536	40	22	t	f	2026-07-19 06:25:38.456235+00
3541	131	22	f	f	2026-07-19 06:26:26.332475+00
3543	131	22	f	f	2026-07-19 06:26:35.141216+00
3549	137	14	f	f	2026-07-19 06:27:48.484278+00
3555	75	25	f	f	2026-07-19 06:28:34.084235+00
3557	147	19	t	f	2026-07-19 06:28:51.731542+00
3558	121	4	f	f	2026-07-19 06:28:54.388316+00
3559	32	22	f	f	2026-07-19 06:28:55.371815+00
3561	32	22	f	f	2026-07-19 06:29:15.379063+00
3566	32	22	f	f	2026-07-19 06:29:30.612639+00
3571	39	27	t	f	2026-07-19 06:31:04.980961+00
3573	75	25	t	f	2026-07-19 06:31:12.521438+00
3574	5	16	t	f	2026-07-19 06:31:57.914819+00
3583	51	18	f	f	2026-07-19 06:33:41.874024+00
3585	107	19	f	f	2026-07-19 06:33:46.625125+00
3588	67	4	t	f	2026-07-19 06:34:27.817423+00
3589	26	18	t	f	2026-07-19 06:35:15.823599+00
3610	154	21	f	f	2026-07-19 06:37:37.621425+00
3611	62	5	f	f	2026-07-19 06:37:45.01076+00
3626	107	19	f	f	2026-07-19 06:40:53.621593+00
3738	36	14	f	f	2026-07-19 07:03:11.747781+00
3759	154	19	f	f	2026-07-19 07:10:03.667822+00
3764	120	21	f	f	2026-07-19 07:11:01.615162+00
3860	154	27	f	f	2026-07-19 07:41:14.578246+00
3863	154	27	f	f	2026-07-19 07:41:28.656631+00
281	127	1	t	f	2026-07-19 00:25:50.214598+00
283	4	1	t	f	2026-07-19 00:25:52.809784+00
284	40	21	t	f	2026-07-19 00:25:55.079639+00
1257	16	8	f	f	2026-07-19 01:26:03.688899+00
1259	9	5	f	f	2026-07-19 01:26:06.02018+00
1262	65	12	t	f	2026-07-19 01:26:23.074952+00
1263	134	6	t	f	2026-07-19 01:26:30.343126+00
1328	148	17	t	f	2026-07-19 01:31:22.727497+00
1335	57	21	f	f	2026-07-19 01:31:50.457517+00
1342	101	8	t	f	2026-07-19 01:32:48.271599+00
1345	128	21	f	f	2026-07-19 01:33:00.79938+00
1346	44	21	f	f	2026-07-19 01:33:01.042022+00
1347	111	18	t	t	2026-07-19 01:33:01.762514+00
1354	148	21	f	f	2026-07-19 01:34:00.368584+00
1356	36	8	t	f	2026-07-19 01:34:10.265925+00
1357	81	27	f	f	2026-07-19 01:34:11.094423+00
1358	81	27	f	f	2026-07-19 01:34:15.513857+00
1359	22	25	t	f	2026-07-19 01:34:20.201044+00
1705	89	24	f	f	2026-07-19 02:00:21.882248+00
1706	69	24	f	f	2026-07-19 02:00:27.252551+00
1708	136	21	f	f	2026-07-19 02:00:34.863831+00
1709	110	15	t	f	2026-07-19 02:00:35.208332+00
1717	47	14	f	f	2026-07-19 02:01:42.603537+00
1726	94	26	f	f	2026-07-19 02:02:35.497518+00
1727	92	19	f	f	2026-07-19 02:02:44.56687+00
1729	11	24	f	f	2026-07-19 02:02:59.138155+00
1730	119	13	f	f	2026-07-19 02:03:03.121309+00
1731	50	24	f	f	2026-07-19 02:03:13.16353+00
2306	44	22	f	f	2026-07-19 03:03:21.131972+00
2307	95	14	f	f	2026-07-19 03:03:23.184638+00
2322	113	7	t	f	2026-07-19 03:05:41.178488+00
2330	32	22	f	f	2026-07-19 03:06:55.746563+00
2331	121	16	t	f	2026-07-19 03:06:56.113143+00
2332	32	22	f	f	2026-07-19 03:06:58.702329+00
2337	133	5	f	f	2026-07-19 03:07:12.583435+00
2339	112	16	t	f	2026-07-19 03:07:18.167096+00
2341	10	19	f	f	2026-07-19 03:07:29.372216+00
2342	82	22	f	f	2026-07-19 03:07:32.451824+00
2343	44	22	f	f	2026-07-19 03:07:34.319987+00
2352	152	14	f	f	2026-07-19 03:08:24.583678+00
2353	92	14	f	f	2026-07-19 03:08:24.910721+00
2722	89	16	f	f	2026-07-19 03:53:42.464765+00
2730	87	26	t	f	2026-07-19 03:56:49.935713+00
2732	113	2	t	f	2026-07-19 03:57:21.919448+00
2737	131	17	t	f	2026-07-19 03:58:05.402129+00
2743	66	21	t	f	2026-07-19 03:59:56.0465+00
2753	51	18	f	f	2026-07-19 04:00:56.741144+00
2754	51	5	t	f	2026-07-19 04:01:02.548616+00
2755	27	22	f	f	2026-07-19 04:01:03.838645+00
2757	97	15	t	f	2026-07-19 04:01:09.944568+00
2759	27	22	f	f	2026-07-19 04:01:25.831914+00
2761	27	22	f	f	2026-07-19 04:01:42.879666+00
2762	119	19	f	f	2026-07-19 04:02:14.9109+00
2763	75	22	f	f	2026-07-19 04:02:24.750589+00
2764	145	11	t	f	2026-07-19 04:02:33.005049+00
2765	97	20	f	f	2026-07-19 04:02:33.368573+00
2782	145	21	f	f	2026-07-19 04:05:12.072452+00
2784	5	6	t	f	2026-07-19 04:05:18.914391+00
2790	89	16	f	f	2026-07-19 04:07:02.803385+00
2793	18	19	f	f	2026-07-19 04:07:44.712846+00
2794	5	7	t	f	2026-07-19 04:07:48.238231+00
2800	85	19	f	f	2026-07-19 04:08:26.079474+00
2802	66	19	f	f	2026-07-19 04:08:28.100288+00
2811	121	26	t	f	2026-07-19 04:10:49.613615+00
2820	53	27	f	f	2026-07-19 04:12:27.062794+00
2825	53	27	f	f	2026-07-19 04:13:13.433468+00
2826	113	22	f	f	2026-07-19 04:13:17.053534+00
2828	145	21	f	f	2026-07-19 04:13:19.633811+00
2831	44	24	f	f	2026-07-19 04:13:33.722871+00
2833	67	10	t	f	2026-07-19 04:13:36.315838+00
2834	145	21	f	f	2026-07-19 04:13:41.036149+00
2837	145	21	f	f	2026-07-19 04:13:57.312644+00
2840	44	24	f	f	2026-07-19 04:14:15.288071+00
2845	152	24	f	f	2026-07-19 04:15:16.992567+00
2847	38	19	f	f	2026-07-19 04:15:44.665196+00
2848	38	19	f	f	2026-07-19 04:15:55.762947+00
2849	38	19	f	f	2026-07-19 04:16:00.452784+00
2850	145	21	f	f	2026-07-19 04:16:06.171212+00
2851	75	22	f	f	2026-07-19 04:16:41.032531+00
2854	148	24	f	f	2026-07-19 04:17:02.833983+00
3214	109	21	f	f	2026-07-19 05:21:05.223413+00
3216	78	24	f	f	2026-07-19 05:21:25.087463+00
3223	22	16	t	f	2026-07-19 05:21:40.210352+00
3523	109	21	f	f	2026-07-19 06:23:12.415597+00
3524	24	19	f	f	2026-07-19 06:23:13.558302+00
3528	39	27	f	f	2026-07-19 06:24:36.274262+00
3529	154	21	f	f	2026-07-19 06:24:43.945859+00
3537	131	22	f	f	2026-07-19 06:25:51.043555+00
3538	39	27	f	f	2026-07-19 06:25:53.499188+00
3569	154	19	f	f	2026-07-19 06:30:16.08833+00
3572	87	19	t	f	2026-07-19 06:31:06.958534+00
3575	5	11	t	f	2026-07-19 06:32:26.725212+00
3576	154	21	f	f	2026-07-19 06:32:35.350011+00
3577	154	21	f	f	2026-07-19 06:32:45.923764+00
3579	154	21	f	f	2026-07-19 06:32:57.580377+00
3580	101	12	t	f	2026-07-19 06:33:27.797166+00
3581	107	19	f	f	2026-07-19 06:33:28.039641+00
3594	155	2	t	f	2026-07-19 06:35:59.935521+00
3595	26	14	f	f	2026-07-19 06:36:08.578047+00
3597	152	27	f	f	2026-07-19 06:36:18.175112+00
3599	154	21	f	f	2026-07-19 06:36:20.860479+00
3605	75	26	t	f	2026-07-19 06:36:51.93883+00
3606	32	22	f	f	2026-07-19 06:37:00.583129+00
3607	32	22	f	f	2026-07-19 06:37:03.477874+00
3612	62	5	f	f	2026-07-19 06:37:57.375632+00
3615	107	19	f	f	2026-07-19 06:38:19.491954+00
3624	107	19	f	f	2026-07-19 06:40:35.748774+00
3625	109	21	f	f	2026-07-19 06:40:49.718002+00
3741	115	22	f	f	2026-07-19 07:05:37.132867+00
3748	120	21	f	f	2026-07-19 07:06:44.496467+00
3749	120	21	f	f	2026-07-19 07:06:58.655514+00
3754	154	24	f	f	2026-07-19 07:08:15.938625+00
3756	149	22	f	f	2026-07-19 07:08:46.937659+00
3758	129	19	f	f	2026-07-19 07:09:28.319025+00
3781	115	24	f	f	2026-07-19 07:16:00.668095+00
3864	152	19	f	f	2026-07-19 07:41:53.974331+00
3875	129	19	f	f	2026-07-19 07:43:30.368376+00
3881	129	19	f	f	2026-07-19 07:45:36.906316+00
3882	32	14	f	f	2026-07-19 07:45:45.725493+00
3884	19	21	f	f	2026-07-19 07:46:09.450106+00
286	27	7	t	f	2026-07-19 00:25:57.764635+00
290	4	6	f	f	2026-07-19 00:26:09.319588+00
291	9	6	t	f	2026-07-19 00:26:10.070629+00
292	13	20	f	f	2026-07-19 00:26:10.293201+00
1258	26	4	f	f	2026-07-19 01:26:05.248773+00
1260	85	21	f	f	2026-07-19 01:26:17.001406+00
1320	44	21	f	f	2026-07-19 01:30:09.66606+00
1321	16	6	f	f	2026-07-19 01:30:17.518115+00
1322	121	22	f	f	2026-07-19 01:30:26.882768+00
1749	32	22	f	f	2026-07-19 02:04:13.796184+00
1751	11	24	f	f	2026-07-19 02:04:21.955915+00
1753	32	22	f	f	2026-07-19 02:04:23.758014+00
1754	32	22	f	f	2026-07-19 02:04:25.84569+00
1763	101	21	f	f	2026-07-19 02:04:59.091532+00
1765	105	21	t	f	2026-07-19 02:05:09.991101+00
1768	15	14	f	f	2026-07-19 02:05:47.118088+00
1769	38	19	f	f	2026-07-19 02:05:47.79941+00
1773	104	19	f	f	2026-07-19 02:06:21.615633+00
1778	22	14	f	f	2026-07-19 02:07:21.491706+00
1779	22	14	f	f	2026-07-19 02:07:25.30045+00
1781	47	14	f	f	2026-07-19 02:07:29.863759+00
1786	54	10	t	f	2026-07-19 02:08:02.051109+00
1787	92	11	t	f	2026-07-19 02:08:05.254374+00
1789	105	22	f	f	2026-07-19 02:08:10.733216+00
1796	104	19	f	f	2026-07-19 02:09:16.326894+00
1798	112	14	t	f	2026-07-19 02:09:26.259861+00
1799	104	19	f	f	2026-07-19 02:09:26.612999+00
1802	32	14	f	f	2026-07-19 02:09:35.48557+00
1803	106	1	t	f	2026-07-19 02:09:37.974013+00
1806	89	25	f	f	2026-07-19 02:10:32.694866+00
1813	15	14	f	f	2026-07-19 02:11:50.148156+00
1884	88	21	f	f	2026-07-19 02:17:33.554902+00
1885	92	19	f	f	2026-07-19 02:17:36.61767+00
2323	38	24	f	f	2026-07-19 03:05:58.207094+00
2324	92	14	f	f	2026-07-19 03:05:59.654464+00
2325	44	22	f	f	2026-07-19 03:06:32.990226+00
2326	32	22	f	f	2026-07-19 03:06:45.722169+00
2328	32	22	f	f	2026-07-19 03:06:52.682319+00
2329	101	10	t	f	2026-07-19 03:06:53.61751+00
2333	32	22	f	f	2026-07-19 03:07:00.62776+00
2334	32	22	f	f	2026-07-19 03:07:02.841482+00
2335	32	22	f	f	2026-07-19 03:07:04.04711+00
2336	133	18	f	f	2026-07-19 03:07:07.716944+00
2338	44	22	f	f	2026-07-19 03:07:13.716903+00
2724	65	26	f	f	2026-07-19 03:54:44.101179+00
2734	72	22	f	f	2026-07-19 03:57:42.837357+00
2736	121	26	f	f	2026-07-19 03:57:52.799593+00
2738	81	19	f	f	2026-07-19 03:58:16.828774+00
2740	100	14	f	f	2026-07-19 03:59:31.079853+00
2741	100	14	f	f	2026-07-19 03:59:36.004904+00
2742	119	26	f	f	2026-07-19 03:59:51.72974+00
2858	75	22	f	f	2026-07-19 04:18:31.12431+00
2861	75	22	f	f	2026-07-19 04:18:34.154794+00
2868	13	26	t	f	2026-07-19 04:19:52.126736+00
2871	119	19	f	f	2026-07-19 04:20:04.797155+00
2874	100	19	f	f	2026-07-19 04:20:40.317038+00
2875	119	5	f	f	2026-07-19 04:20:43.364651+00
2882	4	19	f	f	2026-07-19 04:23:28.263344+00
3237	18	19	f	f	2026-07-19 05:23:33.141663+00
3238	85	19	f	f	2026-07-19 05:23:58.126671+00
3241	18	19	f	f	2026-07-19 05:24:28.080169+00
3243	106	19	f	f	2026-07-19 05:24:58.061225+00
3244	131	21	t	f	2026-07-19 05:25:04.914358+00
3248	8	22	f	f	2026-07-19 05:25:42.90995+00
3251	39	25	t	f	2026-07-19 05:26:02.097738+00
3253	62	26	f	f	2026-07-19 05:26:10.65303+00
3255	18	19	f	f	2026-07-19 05:26:24.61062+00
3260	18	19	f	f	2026-07-19 05:28:17.686766+00
3261	18	19	f	f	2026-07-19 05:29:00.111606+00
3262	32	13	f	f	2026-07-19 05:30:07.498892+00
3273	115	22	f	f	2026-07-19 05:31:46.157577+00
3276	5	2	t	f	2026-07-19 05:31:59.693265+00
3277	29	22	f	f	2026-07-19 05:32:04.739235+00
3291	115	22	f	f	2026-07-19 05:34:25.373213+00
3533	40	8	t	f	2026-07-19 06:25:14.925843+00
3542	11	19	f	f	2026-07-19 06:26:30.487867+00
3544	11	19	t	f	2026-07-19 06:26:36.921064+00
3545	75	25	f	f	2026-07-19 06:26:59.833676+00
3551	75	25	f	f	2026-07-19 06:28:11.756275+00
3562	32	22	f	f	2026-07-19 06:29:17.452001+00
3742	115	22	t	f	2026-07-19 07:05:41.172267+00
3745	24	5	f	f	2026-07-19 07:06:24.704347+00
3750	121	4	f	f	2026-07-19 07:07:22.882544+00
3752	149	22	f	f	2026-07-19 07:07:39.889116+00
3755	154	24	f	f	2026-07-19 07:08:45.969246+00
3757	149	22	f	f	2026-07-19 07:08:56.809427+00
3760	32	27	f	f	2026-07-19 07:10:33.28625+00
3865	53	5	f	f	2026-07-19 07:42:08.123677+00
3867	124	22	f	f	2026-07-19 07:42:20.759859+00
3868	32	14	f	f	2026-07-19 07:42:21.414889+00
3870	129	19	f	f	2026-07-19 07:42:25.498786+00
3873	19	21	f	f	2026-07-19 07:43:14.427412+00
3874	115	27	f	f	2026-07-19 07:43:22.089019+00
3877	32	19	f	f	2026-07-19 07:43:39.370765+00
3878	107	19	f	f	2026-07-19 07:44:32.062896+00
3885	107	19	f	f	2026-07-19 07:46:23.770673+00
3887	129	19	f	f	2026-07-19 07:46:31.327507+00
3888	129	19	f	f	2026-07-19 07:47:02.927769+00
3892	155	7	t	f	2026-07-19 07:47:38.664285+00
3904	124	22	f	f	2026-07-19 07:50:08.525778+00
3915	129	19	f	f	2026-07-19 07:51:44.026985+00
3917	129	19	f	f	2026-07-19 07:51:58.976164+00
3918	19	19	f	f	2026-07-19 07:51:59.616717+00
3919	19	19	f	f	2026-07-19 07:52:04.725146+00
3922	19	19	f	f	2026-07-19 07:52:45.115325+00
3923	19	19	f	f	2026-07-19 07:52:50.223422+00
3927	154	27	f	f	2026-07-19 07:53:24.575382+00
3935	103	21	f	f	2026-07-19 07:56:47.724681+00
3938	103	21	f	f	2026-07-19 07:57:23.077928+00
3939	106	19	f	f	2026-07-19 07:57:27.541648+00
3940	103	21	f	f	2026-07-19 07:57:52.252565+00
3941	19	21	f	f	2026-07-19 07:58:13.417659+00
3942	103	21	f	f	2026-07-19 07:58:13.526286+00
3943	103	21	f	f	2026-07-19 07:58:39.013904+00
3947	121	4	f	f	2026-07-19 07:59:17.393254+00
3950	103	21	f	f	2026-07-19 07:59:58.792415+00
3951	103	21	f	f	2026-07-19 08:00:20.864837+00
3952	103	21	f	f	2026-07-19 08:00:55.343279+00
3953	46	26	f	f	2026-07-19 08:00:57.339643+00
3954	46	26	f	f	2026-07-19 08:01:14.721061+00
289	92	21	t	f	2026-07-19 00:26:08.220093+00
293	21	21	t	f	2026-07-19 00:26:14.838891+00
294	137	6	t	f	2026-07-19 00:26:15.942847+00
295	27	2	t	f	2026-07-19 00:26:17.063836+00
296	15	7	t	f	2026-07-19 00:26:17.515346+00
297	13	20	t	f	2026-07-19 00:26:23.197759+00
298	134	21	f	f	2026-07-19 00:26:23.480933+00
299	104	6	t	f	2026-07-19 00:26:24.036721+00
300	88	21	f	f	2026-07-19 00:26:25.361798+00
301	50	20	t	f	2026-07-19 00:26:32.017506+00
302	134	21	f	f	2026-07-19 00:26:32.982394+00
303	21	1	t	f	2026-07-19 00:26:34.917372+00
304	24	7	t	f	2026-07-19 00:26:37.304481+00
305	27	6	f	f	2026-07-19 00:26:38.093305+00
306	76	20	t	f	2026-07-19 00:26:48.371358+00
307	27	6	f	f	2026-07-19 00:26:48.507079+00
308	37	6	t	f	2026-07-19 00:26:49.26362+00
309	4	19	f	f	2026-07-19 00:26:53.008545+00
310	41	20	t	f	2026-07-19 00:26:56.002774+00
311	18	19	f	f	2026-07-19 00:26:58.612964+00
312	111	21	t	f	2026-07-19 00:27:01.649355+00
313	104	7	t	f	2026-07-19 00:27:13.332447+00
314	54	6	f	f	2026-07-19 00:27:17.393744+00
315	112	1	t	f	2026-07-19 00:27:23.904874+00
316	17	21	f	f	2026-07-19 00:27:41.220811+00
317	81	8	f	f	2026-07-19 00:27:43.023265+00
318	81	21	t	f	2026-07-19 00:27:49.541177+00
319	48	19	f	f	2026-07-19 00:27:56.481243+00
320	117	19	f	f	2026-07-19 00:27:58.462213+00
321	48	19	f	f	2026-07-19 00:28:00.716944+00
322	112	22	t	t	2026-07-19 00:28:02.440867+00
323	113	17	t	f	2026-07-19 00:28:08.04573+00
324	18	19	f	f	2026-07-19 00:28:11.246599+00
325	4	6	t	f	2026-07-19 00:28:12.022309+00
326	26	21	t	f	2026-07-19 00:28:19.840366+00
327	48	1	t	f	2026-07-19 00:28:26.034405+00
328	13	2	t	f	2026-07-19 00:28:29.110536+00
329	138	21	f	f	2026-07-19 00:28:31.422742+00
330	119	20	t	f	2026-07-19 00:28:38.153566+00
331	112	23	t	t	2026-07-19 00:28:38.186944+00
332	33	20	t	f	2026-07-19 00:28:47.614648+00
333	71	7	t	f	2026-07-19 00:28:50.709385+00
334	85	6	t	f	2026-07-19 00:28:52.999403+00
335	8	21	f	f	2026-07-19 00:28:58.838923+00
336	54	6	f	f	2026-07-19 00:29:10.180805+00
337	138	1	t	f	2026-07-19 00:29:11.904458+00
338	79	6	t	f	2026-07-19 00:29:20.666399+00
339	18	19	f	f	2026-07-19 00:29:22.697936+00
340	139	21	f	f	2026-07-19 00:29:24.619588+00
341	51	7	t	f	2026-07-19 00:29:24.773302+00
342	112	6	f	f	2026-07-19 00:29:30.276708+00
343	139	21	f	f	2026-07-19 00:29:31.448517+00
344	139	21	f	f	2026-07-19 00:29:37.265064+00
345	128	11	t	f	2026-07-19 00:29:38.820794+00
346	31	7	t	f	2026-07-19 00:29:39.050236+00
347	47	20	t	f	2026-07-19 00:29:42.495211+00
348	139	21	f	f	2026-07-19 00:29:43.883021+00
349	139	21	f	f	2026-07-19 00:29:50.168178+00
350	36	6	f	f	2026-07-19 00:29:54.143915+00
351	139	21	f	f	2026-07-19 00:29:56.878629+00
352	104	21	f	f	2026-07-19 00:30:14.851582+00
353	29	19	f	f	2026-07-19 00:30:17.577925+00
354	92	22	t	t	2026-07-19 00:30:21.232658+00
355	104	21	f	f	2026-07-19 00:30:22.561394+00
356	54	6	t	f	2026-07-19 00:30:31.912772+00
357	76	21	f	f	2026-07-19 00:30:37.13027+00
358	50	6	f	f	2026-07-19 00:30:38.480076+00
359	18	19	f	f	2026-07-19 00:30:38.527375+00
360	18	8	t	t	2026-07-19 00:30:39.536971+00
361	29	19	t	f	2026-07-19 00:30:42.550739+00
362	50	6	f	f	2026-07-19 00:30:45.932857+00
363	67	11	t	f	2026-07-19 00:30:48.980605+00
364	50	6	f	f	2026-07-19 00:30:56.527888+00
365	29	1	t	f	2026-07-19 00:31:02.47114+00
366	134	21	f	f	2026-07-19 00:31:06.251898+00
367	13	1	t	f	2026-07-19 00:31:10.490525+00
368	35	21	f	f	2026-07-19 00:31:18.929106+00
369	22	22	t	f	2026-07-19 00:31:25.656376+00
370	8	1	t	f	2026-07-19 00:31:35.506188+00
371	62	19	f	f	2026-07-19 00:31:38.109741+00
372	76	19	f	f	2026-07-19 00:31:38.527938+00
373	60	20	f	f	2026-07-19 00:31:40.008783+00
374	50	6	f	f	2026-07-19 00:31:43.863597+00
375	106	19	f	f	2026-07-19 00:31:48.553241+00
376	36	6	f	f	2026-07-19 00:31:48.580362+00
377	76	19	f	f	2026-07-19 00:31:49.416593+00
378	38	21	f	f	2026-07-19 00:31:49.733082+00
379	60	2	t	f	2026-07-19 00:31:55.039591+00
380	38	21	f	f	2026-07-19 00:31:55.201016+00
381	88	21	f	f	2026-07-19 00:31:56.796483+00
382	128	7	f	f	2026-07-19 00:31:58.501486+00
383	18	19	f	f	2026-07-19 00:32:10.353389+00
384	138	21	f	f	2026-07-19 00:32:16.781262+00
385	22	23	t	f	2026-07-19 00:32:19.421594+00
386	138	21	f	f	2026-07-19 00:32:19.842938+00
387	69	17	t	f	2026-07-19 00:32:22.707204+00
388	138	21	f	f	2026-07-19 00:32:23.157136+00
389	138	21	f	f	2026-07-19 00:32:28.118904+00
390	138	21	t	f	2026-07-19 00:32:32.865515+00
391	129	20	t	f	2026-07-19 00:32:34.201396+00
392	92	23	t	t	2026-07-19 00:32:37.751024+00
393	79	7	t	f	2026-07-19 00:33:00.071702+00
394	60	20	t	f	2026-07-19 00:33:16.532605+00
395	94	21	f	f	2026-07-19 00:33:19.279133+00
396	20	11	t	f	2026-07-19 00:33:22.592598+00
397	94	21	f	f	2026-07-19 00:33:25.767846+00
398	85	1	t	f	2026-07-19 00:33:26.819432+00
399	139	21	f	f	2026-07-19 00:33:27.345488+00
400	139	21	f	f	2026-07-19 00:33:32.515493+00
401	94	21	f	f	2026-07-19 00:33:34.927612+00
402	117	7	t	f	2026-07-19 00:33:35.977087+00
403	21	13	t	t	2026-07-19 00:33:36.227787+00
404	139	21	f	f	2026-07-19 00:33:37.350228+00
405	139	21	f	f	2026-07-19 00:33:42.481962+00
406	12	21	f	f	2026-07-19 00:33:43.445739+00
407	94	21	f	f	2026-07-19 00:33:44.361095+00
408	133	8	t	t	2026-07-19 00:33:44.733262+00
409	139	21	f	f	2026-07-19 00:33:50.850945+00
410	112	24	f	f	2026-07-19 00:33:50.965333+00
411	112	24	f	f	2026-07-19 00:33:52.839515+00
412	114	6	t	f	2026-07-19 00:33:54.155278+00
413	18	19	f	f	2026-07-19 00:33:56.190805+00
414	36	6	f	f	2026-07-19 00:33:57.347363+00
423	88	21	f	f	2026-07-19 00:34:25.163249+00
425	18	19	f	f	2026-07-19 00:34:32.061089+00
431	8	8	t	f	2026-07-19 00:35:02.718612+00
1261	25	24	f	f	2026-07-19 01:26:18.858659+00
1264	60	23	t	f	2026-07-19 01:26:32.241825+00
1265	38	22	t	f	2026-07-19 01:26:35.052129+00
1279	109	19	f	f	2026-07-19 01:27:17.499434+00
1280	111	25	t	f	2026-07-19 01:27:18.319511+00
1286	112	27	f	f	2026-07-19 01:27:33.338229+00
1308	67	13	f	f	2026-07-19 01:29:17.932698+00
1309	92	27	f	f	2026-07-19 01:29:20.286789+00
1337	136	21	f	f	2026-07-19 01:32:13.926454+00
1341	119	23	t	f	2026-07-19 01:32:35.651454+00
1343	94	19	f	f	2026-07-19 01:32:52.965453+00
1350	87	14	t	f	2026-07-19 01:33:34.758637+00
1351	89	22	f	f	2026-07-19 01:33:54.273916+00
1352	116	2	t	f	2026-07-19 01:33:56.563141+00
1365	60	24	f	f	2026-07-19 01:34:50.69671+00
1368	54	5	f	f	2026-07-19 01:35:10.760979+00
1750	32	22	f	f	2026-07-19 02:04:20.663631+00
1756	32	22	f	f	2026-07-19 02:04:32.487169+00
1758	32	22	f	f	2026-07-19 02:04:34.453943+00
1759	89	24	f	f	2026-07-19 02:04:36.950442+00
1760	11	24	f	f	2026-07-19 02:04:40.145448+00
1762	26	1	t	f	2026-07-19 02:04:58.328427+00
1770	38	19	f	f	2026-07-19 02:05:53.039408+00
1775	145	15	t	f	2026-07-19 02:06:38.428866+00
1791	22	14	t	f	2026-07-19 02:08:37.855863+00
1792	11	24	t	f	2026-07-19 02:08:42.351108+00
1794	119	26	f	f	2026-07-19 02:09:04.281726+00
1795	101	14	t	f	2026-07-19 02:09:11.72958+00
1805	133	23	t	f	2026-07-19 02:09:57.505668+00
1809	27	8	f	f	2026-07-19 02:10:54.111155+00
1810	103	21	f	f	2026-07-19 02:10:55.796603+00
1811	27	8	f	f	2026-07-19 02:11:15.871524+00
1814	79	25	t	f	2026-07-19 02:11:58.900196+00
1817	25	25	f	f	2026-07-19 02:12:10.488876+00
1818	105	22	f	f	2026-07-19 02:12:14.221434+00
1821	4	24	f	f	2026-07-19 02:12:25.758808+00
1826	103	14	f	f	2026-07-19 02:12:39.949187+00
1831	85	23	t	f	2026-07-19 02:13:07.377341+00
1832	25	25	f	f	2026-07-19 02:13:08.293537+00
1833	103	21	f	f	2026-07-19 02:13:11.974464+00
1836	112	19	f	f	2026-07-19 02:13:20.317836+00
1846	133	24	f	f	2026-07-19 02:13:48.690459+00
1847	133	24	f	f	2026-07-19 02:13:51.207572+00
1849	25	25	f	f	2026-07-19 02:14:12.249769+00
1855	95	25	t	f	2026-07-19 02:15:00.598142+00
1865	51	22	f	f	2026-07-19 02:15:29.733637+00
1866	127	19	f	f	2026-07-19 02:15:30.762312+00
1867	103	21	f	f	2026-07-19 02:15:33.6459+00
1870	4	24	f	f	2026-07-19 02:15:51.114503+00
1871	105	24	f	f	2026-07-19 02:16:00.362493+00
1872	126	14	f	f	2026-07-19 02:16:09.145697+00
1873	105	24	f	f	2026-07-19 02:16:13.816466+00
1874	125	24	t	f	2026-07-19 02:16:17.506059+00
1875	4	24	f	f	2026-07-19 02:16:18.418611+00
1876	4	24	f	f	2026-07-19 02:16:20.776754+00
2354	101	25	f	f	2026-07-19 03:08:26.966744+00
2355	17	27	f	f	2026-07-19 03:08:29.239028+00
2357	17	27	t	f	2026-07-19 03:08:32.918466+00
2360	45	19	f	f	2026-07-19 03:09:26.681581+00
2362	38	24	f	f	2026-07-19 03:10:11.622297+00
2363	26	4	f	f	2026-07-19 03:10:39.384291+00
2364	53	14	f	f	2026-07-19 03:10:58.951829+00
2378	27	16	f	f	2026-07-19 03:13:10.793351+00
2381	62	26	f	f	2026-07-19 03:13:35.917804+00
2397	88	21	f	f	2026-07-19 03:14:34.385509+00
2399	104	4	f	f	2026-07-19 03:14:51.746309+00
2403	27	16	f	f	2026-07-19 03:15:41.507249+00
2412	101	26	f	f	2026-07-19 03:16:24.1255+00
2413	124	19	f	f	2026-07-19 03:16:29.640608+00
2415	125	14	f	f	2026-07-19 03:16:41.397578+00
2424	124	19	f	f	2026-07-19 03:17:43.952031+00
2431	88	21	f	f	2026-07-19 03:18:08.065915+00
2435	88	21	f	f	2026-07-19 03:18:14.822502+00
2440	121	22	f	f	2026-07-19 03:19:02.592638+00
2451	124	14	f	f	2026-07-19 03:20:13.237659+00
2453	124	14	f	f	2026-07-19 03:20:27.963406+00
2454	73	21	f	f	2026-07-19 03:20:28.617257+00
2457	73	21	f	f	2026-07-19 03:20:40.302457+00
2459	67	25	t	f	2026-07-19 03:20:56.837816+00
2726	66	20	t	f	2026-07-19 03:55:01.365994+00
2727	87	25	t	f	2026-07-19 03:55:19.47117+00
2731	38	27	t	f	2026-07-19 03:56:53.073729+00
2744	100	14	f	f	2026-07-19 04:00:09.178375+00
2745	119	26	f	f	2026-07-19 04:00:12.660731+00
2746	72	22	t	f	2026-07-19 04:00:14.950153+00
2747	6	24	t	f	2026-07-19 04:00:16.775015+00
2766	27	1	t	f	2026-07-19 04:02:40.889001+00
2767	53	5	f	f	2026-07-19 04:02:43.18565+00
2768	100	14	f	f	2026-07-19 04:02:44.012707+00
2888	53	27	f	f	2026-07-19 04:24:31.692522+00
2889	13	27	f	f	2026-07-19 04:24:34.44872+00
2890	152	9	t	f	2026-07-19 04:24:35.143566+00
3263	62	26	f	f	2026-07-19 05:30:22.641614+00
3264	62	26	f	f	2026-07-19 05:30:28.271194+00
3265	62	26	f	f	2026-07-19 05:30:38.029962+00
3266	62	26	f	f	2026-07-19 05:30:45.183706+00
3270	115	22	f	f	2026-07-19 05:31:36.885583+00
3272	115	22	f	f	2026-07-19 05:31:41.208353+00
3275	115	22	f	f	2026-07-19 05:31:56.443925+00
3284	115	22	f	f	2026-07-19 05:33:10.236781+00
3556	152	26	t	f	2026-07-19 06:28:37.115828+00
3751	149	22	f	f	2026-07-19 07:07:35.736681+00
3753	36	14	f	f	2026-07-19 07:07:45.576393+00
3761	32	27	f	f	2026-07-19 07:10:43.900449+00
3762	120	21	f	f	2026-07-19 07:10:45.410861+00
3763	120	21	f	f	2026-07-19 07:10:51.367797+00
3770	115	24	f	f	2026-07-19 07:13:34.379584+00
3774	115	24	f	f	2026-07-19 07:13:52.253032+00
3777	32	27	f	f	2026-07-19 07:14:26.117168+00
3797	115	24	t	f	2026-07-19 07:21:04.491801+00
3813	32	14	f	f	2026-07-19 07:29:36.42594+00
3814	32	14	f	f	2026-07-19 07:29:43.99957+00
3833	155	21	f	f	2026-07-19 07:33:40.99461+00
3836	29	11	t	f	2026-07-19 07:35:04.690042+00
415	112	24	f	f	2026-07-19 00:33:58.468343+00
417	112	24	f	f	2026-07-19 00:34:01.10963+00
1266	94	22	f	f	2026-07-19 01:26:42.489954+00
1268	38	23	t	f	2026-07-19 01:26:45.807854+00
1277	136	21	f	f	2026-07-19 01:27:14.143469+00
1278	91	21	f	f	2026-07-19 01:27:14.836907+00
1281	85	21	f	f	2026-07-19 01:27:20.039524+00
1282	101	21	f	f	2026-07-19 01:27:20.955447+00
1284	103	21	f	f	2026-07-19 01:27:30.392477+00
1287	94	22	t	f	2026-07-19 01:27:38.392471+00
1289	112	27	t	f	2026-07-19 01:27:41.984237+00
1290	57	20	t	f	2026-07-19 01:27:55.975301+00
1291	94	23	t	f	2026-07-19 01:28:04.267998+00
1293	22	25	f	f	2026-07-19 01:28:07.430852+00
1294	16	6	f	f	2026-07-19 01:28:26.769086+00
1296	85	10	t	f	2026-07-19 01:28:35.125463+00
1298	80	22	f	f	2026-07-19 01:28:39.172109+00
1301	119	22	t	f	2026-07-19 01:28:49.567927+00
1311	67	16	t	f	2026-07-19 01:29:31.162976+00
1316	4	14	f	f	2026-07-19 01:30:01.999212+00
1317	16	6	f	f	2026-07-19 01:30:02.944091+00
1324	29	21	t	f	2026-07-19 01:30:45.536446+00
1325	92	27	f	f	2026-07-19 01:30:53.211374+00
1752	25	24	f	f	2026-07-19 02:04:22.631813+00
1755	32	22	f	f	2026-07-19 02:04:28.167846+00
1764	89	24	t	f	2026-07-19 02:05:01.751942+00
1766	148	14	f	f	2026-07-19 02:05:16.231419+00
1767	38	19	f	f	2026-07-19 02:05:35.866562+00
1774	104	19	f	f	2026-07-19 02:06:29.611804+00
1776	133	22	f	f	2026-07-19 02:06:48.397177+00
1782	38	19	f	f	2026-07-19 02:07:37.239536+00
1783	89	26	t	f	2026-07-19 02:07:38.376446+00
1784	32	14	f	f	2026-07-19 02:07:44.233806+00
2356	18	10	t	f	2026-07-19 03:08:29.549799+00
2361	91	15	t	f	2026-07-19 03:09:26.796891+00
2371	113	19	f	f	2026-07-19 03:11:59.756034+00
2372	147	9	t	f	2026-07-19 03:12:11.772796+00
2377	44	22	t	f	2026-07-19 03:13:08.264324+00
2379	44	23	t	f	2026-07-19 03:13:22.177031+00
2383	38	24	t	f	2026-07-19 03:13:42.750564+00
2384	32	22	f	f	2026-07-19 03:13:44.068122+00
2433	73	21	f	f	2026-07-19 03:18:12.187299+00
2434	45	19	f	f	2026-07-19 03:18:13.209613+00
2449	4	19	f	f	2026-07-19 03:19:58.718822+00
2450	4	19	f	f	2026-07-19 03:20:06.842141+00
2455	73	21	f	f	2026-07-19 03:20:34.272178+00
2458	88	21	f	f	2026-07-19 03:20:42.460369+00
2460	62	26	f	f	2026-07-19 03:21:02.139713+00
2461	62	26	f	f	2026-07-19 03:21:18.514932+00
2462	62	26	f	f	2026-07-19 03:21:21.569428+00
2464	62	26	f	f	2026-07-19 03:21:26.475394+00
2466	62	26	f	f	2026-07-19 03:21:31.394167+00
2468	24	24	f	f	2026-07-19 03:21:36.312741+00
2735	4	19	f	f	2026-07-19 03:57:47.929961+00
2739	92	14	t	f	2026-07-19 03:58:36.303113+00
2748	119	26	t	f	2026-07-19 04:00:25.672325+00
2749	51	18	f	f	2026-07-19 04:00:36.005585+00
2758	27	22	f	f	2026-07-19 04:01:18.507175+00
2769	53	5	f	f	2026-07-19 04:02:47.898517+00
2770	97	20	f	f	2026-07-19 04:02:48.034104+00
2891	65	18	f	f	2026-07-19 04:24:51.497879+00
2894	65	18	f	f	2026-07-19 04:25:07.179379+00
2900	152	25	t	f	2026-07-19 04:25:26.768791+00
2904	145	21	f	f	2026-07-19 04:25:34.188237+00
2906	65	5	f	f	2026-07-19 04:25:38.103101+00
2909	15	12	t	f	2026-07-19 04:26:00.687221+00
2911	65	26	f	f	2026-07-19 04:26:07.992453+00
2915	101	16	t	f	2026-07-19 04:26:40.424925+00
2919	107	19	f	f	2026-07-19 04:27:24.040545+00
2921	28	17	t	f	2026-07-19 04:27:29.983257+00
2922	6	26	f	f	2026-07-19 04:27:37.243197+00
2927	107	19	f	f	2026-07-19 04:28:24.457189+00
2952	53	27	f	f	2026-07-19 04:32:41.303245+00
2961	109	21	f	f	2026-07-19 04:34:50.434595+00
2962	18	19	f	f	2026-07-19 04:34:59.383685+00
2965	75	22	f	f	2026-07-19 04:35:16.194061+00
2966	94	19	f	f	2026-07-19 04:35:24.61052+00
2967	109	21	f	f	2026-07-19 04:35:28.008351+00
2970	124	22	f	f	2026-07-19 04:35:34.799306+00
2975	72	19	f	f	2026-07-19 04:36:04.202258+00
2979	48	22	t	f	2026-07-19 04:36:32.503842+00
2981	66	14	f	f	2026-07-19 04:36:44.335191+00
2982	101	19	f	f	2026-07-19 04:37:02.773735+00
2984	80	14	f	f	2026-07-19 04:37:06.275796+00
2985	65	26	f	f	2026-07-19 04:37:09.266497+00
2986	27	22	f	f	2026-07-19 04:37:10.337694+00
2988	27	22	f	f	2026-07-19 04:37:20.25067+00
2989	48	23	t	f	2026-07-19 04:37:21.10042+00
2990	152	26	f	f	2026-07-19 04:37:23.249447+00
2991	75	22	f	f	2026-07-19 04:37:35.321402+00
2992	44	27	t	f	2026-07-19 04:37:36.441985+00
2998	87	27	t	f	2026-07-19 04:38:27.407493+00
2999	27	22	f	f	2026-07-19 04:38:32.717865+00
3000	51	18	f	f	2026-07-19 04:38:42.856763+00
3001	75	22	f	f	2026-07-19 04:38:44.033703+00
3004	80	7	t	f	2026-07-19 04:39:24.021013+00
3010	139	4	t	f	2026-07-19 04:40:09.405389+00
3011	39	23	t	f	2026-07-19 04:40:45.824769+00
3017	119	19	f	f	2026-07-19 04:41:22.191287+00
3018	75	22	f	f	2026-07-19 04:41:47.529709+00
3026	154	19	f	f	2026-07-19 04:42:29.642183+00
3036	27	22	f	f	2026-07-19 04:44:22.461219+00
3037	39	13	f	f	2026-07-19 04:44:32.946633+00
3038	148	19	f	f	2026-07-19 04:44:35.208314+00
3039	148	19	f	f	2026-07-19 04:44:37.762063+00
3040	148	19	f	f	2026-07-19 04:44:40.957054+00
3041	6	26	f	f	2026-07-19 04:44:45.013095+00
3046	8	22	f	f	2026-07-19 04:46:02.586206+00
3047	154	20	t	f	2026-07-19 04:46:10.161866+00
3051	65	26	f	f	2026-07-19 04:46:57.810976+00
3058	129	22	f	f	2026-07-19 04:48:07.321168+00
3069	129	22	f	f	2026-07-19 04:50:41.657729+00
3076	51	22	f	f	2026-07-19 04:51:24.153567+00
3268	115	22	f	f	2026-07-19 05:31:22.359554+00
3271	26	14	f	f	2026-07-19 05:31:38.500538+00
3278	115	22	f	f	2026-07-19 05:32:07.383573+00
3279	115	22	f	f	2026-07-19 05:32:32.43274+00
3281	115	22	f	f	2026-07-19 05:32:53.522665+00
3282	39	26	f	f	2026-07-19 05:32:58.793564+00
3283	115	22	f	f	2026-07-19 05:33:05.987702+00
416	50	11	t	f	2026-07-19 00:33:59.608873+00
420	81	22	f	f	2026-07-19 00:34:19.090207+00
429	112	24	f	f	2026-07-19 00:34:57.481906+00
1267	62	21	f	f	2026-07-19 01:26:45.697192+00
1269	16	5	f	f	2026-07-19 01:26:48.2392+00
1270	111	19	f	f	2026-07-19 01:26:48.356002+00
1271	117	19	f	f	2026-07-19 01:26:52.487857+00
1272	16	6	f	f	2026-07-19 01:26:52.540107+00
1273	117	19	f	f	2026-07-19 01:27:06.60951+00
1274	117	19	f	f	2026-07-19 01:27:08.066657+00
1283	91	21	t	f	2026-07-19 01:27:24.223691+00
1285	7	14	f	f	2026-07-19 01:27:31.69843+00
1288	16	6	f	f	2026-07-19 01:27:41.107929+00
1292	148	20	t	f	2026-07-19 01:28:04.61818+00
1295	103	4	f	f	2026-07-19 01:28:27.402121+00
1297	32	22	f	f	2026-07-19 01:28:36.282991+00
1299	112	5	t	t	2026-07-19 01:28:40.509578+00
1300	103	21	f	f	2026-07-19 01:28:40.955183+00
1303	80	22	t	f	2026-07-19 01:29:00.121955+00
1304	32	22	f	f	2026-07-19 01:29:00.359057+00
1305	148	1	t	f	2026-07-19 01:29:05.568971+00
1312	85	21	f	f	2026-07-19 01:29:40.804541+00
1313	21	25	t	f	2026-07-19 01:29:41.332173+00
1315	85	21	f	f	2026-07-19 01:29:44.926571+00
1326	105	21	f	f	2026-07-19 01:31:10.322496+00
1329	111	19	f	f	2026-07-19 01:31:26.152823+00
1330	51	14	f	f	2026-07-19 01:31:39.623441+00
1331	112	25	t	t	2026-07-19 01:31:41.670298+00
1332	148	6	f	f	2026-07-19 01:31:41.68559+00
1334	148	7	t	f	2026-07-19 01:31:48.923383+00
1338	72	13	t	f	2026-07-19 01:32:19.658498+00
1340	17	2	t	f	2026-07-19 01:32:23.588994+00
1344	128	21	f	f	2026-07-19 01:32:54.10277+00
1348	44	21	f	f	2026-07-19 01:33:02.248094+00
1349	128	21	f	f	2026-07-19 01:33:04.776175+00
1353	148	21	f	f	2026-07-19 01:33:56.893444+00
1360	81	27	f	f	2026-07-19 01:34:23.367119+00
1361	62	21	f	f	2026-07-19 01:34:29.374834+00
1363	92	27	f	f	2026-07-19 01:34:33.051131+00
1757	50	24	f	f	2026-07-19 02:04:32.664419+00
1761	26	1	f	f	2026-07-19 02:04:53.014148+00
1771	93	21	f	f	2026-07-19 02:05:56.361276+00
1772	25	24	t	f	2026-07-19 02:05:57.264833+00
1777	18	18	f	f	2026-07-19 02:07:08.795413+00
1780	38	19	f	f	2026-07-19 02:07:29.850668+00
1785	62	22	t	f	2026-07-19 02:07:54.677457+00
1790	89	14	f	f	2026-07-19 02:08:26.661813+00
1797	37	16	t	f	2026-07-19 02:09:25.128266+00
1800	106	1	f	f	2026-07-19 02:09:30.556032+00
1801	32	14	f	f	2026-07-19 02:09:31.618821+00
1812	38	12	t	f	2026-07-19 02:11:39.156214+00
1819	106	18	t	f	2026-07-19 02:12:14.798273+00
1830	25	25	f	f	2026-07-19 02:12:56.117099+00
1834	112	19	f	f	2026-07-19 02:13:15.491591+00
1840	133	24	f	f	2026-07-19 02:13:31.080697+00
1845	89	27	t	f	2026-07-19 02:13:44.154122+00
1848	101	2	t	f	2026-07-19 02:14:08.561326+00
1854	119	26	f	f	2026-07-19 02:14:51.959597+00
1856	103	21	f	f	2026-07-19 02:15:01.861307+00
1857	89	14	f	f	2026-07-19 02:15:05.173442+00
1859	103	21	f	f	2026-07-19 02:15:17.829265+00
1881	88	21	f	f	2026-07-19 02:17:22.23749+00
1887	44	21	f	f	2026-07-19 02:17:46.417918+00
1888	25	25	f	f	2026-07-19 02:17:46.680898+00
2358	101	25	f	f	2026-07-19 03:09:09.798888+00
2369	53	14	t	f	2026-07-19 03:11:55.041161+00
2373	113	19	f	f	2026-07-19 03:12:12.326354+00
2374	113	19	f	f	2026-07-19 03:12:17.489301+00
2375	78	21	f	f	2026-07-19 03:12:28.912146+00
2382	32	22	f	f	2026-07-19 03:13:40.768771+00
2750	100	14	f	f	2026-07-19 04:00:38.128571+00
2751	51	18	f	f	2026-07-19 04:00:40.617956+00
2752	38	19	f	f	2026-07-19 04:00:48.565288+00
2892	53	27	f	f	2026-07-19 04:24:54.558678+00
2895	85	19	f	f	2026-07-19 04:25:12.373829+00
2896	65	18	f	f	2026-07-19 04:25:13.379399+00
2898	65	5	f	f	2026-07-19 04:25:23.99619+00
2899	107	19	f	f	2026-07-19 04:25:25.877254+00
2902	145	21	f	f	2026-07-19 04:25:31.642555+00
2903	87	16	t	f	2026-07-19 04:25:32.968141+00
2905	65	5	f	f	2026-07-19 04:25:34.972736+00
2907	65	5	f	f	2026-07-19 04:25:44.134595+00
2908	32	8	t	f	2026-07-19 04:25:45.618832+00
2910	65	26	f	f	2026-07-19 04:26:05.52713+00
2912	39	22	t	f	2026-07-19 04:26:29.844412+00
2913	13	27	f	f	2026-07-19 04:26:30.820431+00
2914	27	22	f	f	2026-07-19 04:26:37.537004+00
3285	39	26	f	f	2026-07-19 05:33:21.724538+00
3287	115	22	f	f	2026-07-19 05:34:02.985343+00
3564	32	22	f	f	2026-07-19 06:29:26.019623+00
3565	32	22	f	f	2026-07-19 06:29:28.316987+00
3567	154	7	t	f	2026-07-19 06:29:45.810089+00
3570	154	19	f	f	2026-07-19 06:30:32.722282+00
3582	40	1	t	f	2026-07-19 06:33:28.186779+00
3584	51	18	f	f	2026-07-19 06:33:45.508195+00
3586	107	19	f	f	2026-07-19 06:33:54.128904+00
3587	154	15	t	f	2026-07-19 06:33:56.503631+00
3592	154	21	f	f	2026-07-19 06:35:52.163299+00
3593	32	22	f	f	2026-07-19 06:35:57.878434+00
3596	152	27	f	f	2026-07-19 06:36:13.977761+00
3598	155	14	t	f	2026-07-19 06:36:18.67117+00
3604	78	26	f	f	2026-07-19 06:36:42.863237+00
3613	18	19	f	f	2026-07-19 06:37:59.859704+00
3614	107	19	f	f	2026-07-19 06:38:03.004584+00
3616	154	21	t	f	2026-07-19 06:38:27.931934+00
3617	101	9	t	f	2026-07-19 06:38:39.683505+00
3619	19	8	t	f	2026-07-19 06:39:24.641794+00
3620	149	21	t	f	2026-07-19 06:39:38.818817+00
3621	18	19	f	f	2026-07-19 06:40:05.518886+00
3622	107	19	f	f	2026-07-19 06:40:27.338444+00
3623	107	19	f	f	2026-07-19 06:40:30.684555+00
3627	18	19	f	f	2026-07-19 06:41:10.412975+00
3637	107	19	f	f	2026-07-19 06:43:35.465601+00
3638	36	19	f	f	2026-07-19 06:43:59.643295+00
3639	32	22	f	f	2026-07-19 06:44:17.1881+00
3642	32	22	f	f	2026-07-19 06:44:23.495851+00
3643	32	22	f	f	2026-07-19 06:44:24.657742+00
3651	62	5	f	f	2026-07-19 06:45:35.848912+00
3652	115	22	f	f	2026-07-19 06:45:48.840102+00
3653	107	19	f	f	2026-07-19 06:45:49.941153+00
418	38	21	f	f	2026-07-19 00:34:12.614975+00
419	105	2	t	f	2026-07-19 00:34:13.735934+00
421	20	2	t	f	2026-07-19 00:34:20.122081+00
422	112	24	f	f	2026-07-19 00:34:23.242655+00
424	16	17	t	f	2026-07-19 00:34:26.123488+00
426	38	21	f	f	2026-07-19 00:34:35.281768+00
432	4	19	f	f	2026-07-19 00:35:04.307726+00
433	18	19	f	f	2026-07-19 00:35:07.989453+00
1275	117	19	f	f	2026-07-19 01:27:09.512453+00
1276	117	19	f	f	2026-07-19 01:27:11.061605+00
1302	85	14	f	f	2026-07-19 01:29:00.046049+00
1306	21	12	t	f	2026-07-19 01:29:06.300573+00
1307	67	13	f	f	2026-07-19 01:29:12.085996+00
1310	80	23	t	f	2026-07-19 01:29:22.644291+00
1314	136	21	f	f	2026-07-19 01:29:41.727188+00
1318	16	6	f	f	2026-07-19 01:30:06.606719+00
1319	37	5	f	f	2026-07-19 01:30:06.733869+00
1323	65	26	f	f	2026-07-19 01:30:32.148527+00
1327	69	5	t	f	2026-07-19 01:31:20.557512+00
1333	25	24	f	f	2026-07-19 01:31:47.815023+00
1336	80	24	t	f	2026-07-19 01:32:05.811517+00
1339	148	21	f	f	2026-07-19 01:32:20.140221+00
1355	119	8	t	f	2026-07-19 01:34:03.08161+00
1788	69	26	t	f	2026-07-19 02:08:09.48923+00
1793	26	10	t	f	2026-07-19 02:08:59.008236+00
1804	88	21	f	f	2026-07-19 02:09:56.469481+00
1807	85	22	f	f	2026-07-19 02:10:44.405028+00
1808	69	25	t	f	2026-07-19 02:10:45.06667+00
1815	125	24	f	f	2026-07-19 02:12:01.709107+00
1816	4	24	f	f	2026-07-19 02:12:02.964733+00
1822	124	15	t	f	2026-07-19 02:12:28.729614+00
1823	85	22	f	f	2026-07-19 02:12:34.374674+00
1829	127	19	f	f	2026-07-19 02:12:51.454327+00
1835	125	24	f	f	2026-07-19 02:13:19.795153+00
1837	89	27	f	f	2026-07-19 02:13:23.839596+00
1838	127	19	f	f	2026-07-19 02:13:27.367462+00
1839	103	21	f	f	2026-07-19 02:13:28.893418+00
1841	89	27	f	f	2026-07-19 02:13:33.370717+00
1850	127	19	f	f	2026-07-19 02:14:24.241844+00
1851	127	19	f	f	2026-07-19 02:14:32.27485+00
1860	149	15	t	f	2026-07-19 02:15:18.451989+00
1861	133	24	f	f	2026-07-19 02:15:21.504782+00
1868	103	21	f	f	2026-07-19 02:15:43.737903+00
1877	4	24	f	f	2026-07-19 02:16:22.634186+00
1879	80	15	t	f	2026-07-19 02:16:49.854701+00
1882	51	22	f	f	2026-07-19 02:17:32.598346+00
1883	25	25	f	f	2026-07-19 02:17:33.440488+00
2359	101	25	t	f	2026-07-19 03:09:14.724117+00
2756	100	14	f	f	2026-07-19 04:01:09.854252+00
2760	121	26	f	f	2026-07-19 04:01:27.252607+00
2893	53	27	f	f	2026-07-19 04:24:57.735267+00
2928	65	26	f	f	2026-07-19 04:28:43.367016+00
2932	45	25	t	f	2026-07-19 04:29:40.323271+00
3292	115	22	f	f	2026-07-19 05:34:29.736403+00
3295	115	22	f	f	2026-07-19 05:34:40.86452+00
3297	115	22	f	f	2026-07-19 05:34:59.688717+00
3298	115	22	f	f	2026-07-19 05:35:04.719738+00
3302	115	22	f	f	2026-07-19 05:35:19.65756+00
3303	115	22	f	f	2026-07-19 05:35:24.205573+00
3304	5	9	t	f	2026-07-19 05:35:30.09245+00
3313	67	4	f	f	2026-07-19 05:37:18.075935+00
3316	155	6	f	f	2026-07-19 05:39:23.455873+00
3317	122	21	f	f	2026-07-19 05:39:23.84268+00
3318	154	19	f	f	2026-07-19 05:39:59.170274+00
3326	122	21	f	f	2026-07-19 05:40:57.675122+00
3331	122	21	f	f	2026-07-19 05:41:15.775025+00
3332	39	26	f	f	2026-07-19 05:41:19.808864+00
3333	133	26	f	f	2026-07-19 05:41:23.430502+00
3568	75	25	f	f	2026-07-19 06:29:59.690704+00
3578	154	21	f	f	2026-07-19 06:32:51.485221+00
3765	149	22	f	f	2026-07-19 07:11:13.055491+00
3767	149	22	f	f	2026-07-19 07:11:34.124183+00
3768	149	22	f	f	2026-07-19 07:11:38.246418+00
3769	103	5	f	f	2026-07-19 07:13:04.708917+00
3776	8	22	f	f	2026-07-19 07:14:14.494049+00
3778	40	14	f	f	2026-07-19 07:14:47.209209+00
3787	115	24	f	f	2026-07-19 07:19:51.8745+00
3790	115	24	f	f	2026-07-19 07:20:21.388156+00
3791	115	24	f	f	2026-07-19 07:20:24.387692+00
3793	106	19	f	f	2026-07-19 07:20:38.336777+00
3795	106	19	f	f	2026-07-19 07:20:55.630996+00
3803	120	19	f	f	2026-07-19 07:23:29.622412+00
3805	106	9	t	f	2026-07-19 07:23:49.835942+00
3806	120	11	t	f	2026-07-19 07:25:30.565495+00
3807	32	14	f	f	2026-07-19 07:26:14.708491+00
3809	32	14	f	f	2026-07-19 07:26:21.688807+00
3810	118	1	t	f	2026-07-19 07:27:36.856757+00
3815	115	25	f	f	2026-07-19 07:30:56.68282+00
3817	115	25	t	f	2026-07-19 07:31:01.27006+00
3818	82	13	t	f	2026-07-19 07:31:02.925059+00
3820	103	5	f	f	2026-07-19 07:31:53.825965+00
3823	15	18	f	f	2026-07-19 07:32:14.633093+00
3824	15	18	f	f	2026-07-19 07:32:20.004617+00
3826	26	14	f	f	2026-07-19 07:32:32.286285+00
3828	154	26	f	f	2026-07-19 07:32:56.190096+00
3829	115	26	t	f	2026-07-19 07:32:57.124347+00
3831	15	18	f	f	2026-07-19 07:33:06.71497+00
3835	82	14	f	f	2026-07-19 07:34:42.743198+00
3837	130	11	t	f	2026-07-19 07:35:12.97799+00
3838	154	26	f	f	2026-07-19 07:35:30.689618+00
3841	52	15	f	f	2026-07-19 07:35:48.066167+00
3842	52	15	f	f	2026-07-19 07:36:00.671293+00
3846	52	15	f	f	2026-07-19 07:36:48.60893+00
3848	107	19	f	f	2026-07-19 07:38:16.044236+00
3866	53	18	t	f	2026-07-19 07:42:11.148039+00
3869	32	14	f	f	2026-07-19 07:42:22.660582+00
3876	129	19	f	f	2026-07-19 07:43:39.241828+00
3880	129	19	f	f	2026-07-19 07:45:27.556366+00
3883	19	21	f	f	2026-07-19 07:46:02.012935+00
3893	115	27	t	f	2026-07-19 07:48:01.89132+00
3896	36	14	f	f	2026-07-19 07:48:31.384536+00
3901	124	22	f	f	2026-07-19 07:49:46.796816+00
3944	155	22	f	f	2026-07-19 07:58:49.781025+00
3949	103	21	f	f	2026-07-19 07:59:34.652797+00
3955	103	21	f	f	2026-07-19 08:01:30.713064+00
3956	32	14	t	f	2026-07-19 08:01:52.654844+00
3957	36	14	f	f	2026-07-19 08:02:06.24053+00
3958	36	14	f	f	2026-07-19 08:02:23.051473+00
3959	103	21	f	f	2026-07-19 08:02:32.553403+00
3960	103	21	f	f	2026-07-19 08:02:55.182278+00
427	50	6	t	f	2026-07-19 00:34:37.511028+00
428	26	11	t	f	2026-07-19 00:34:42.234213+00
430	44	17	t	f	2026-07-19 00:35:00.577178+00
434	94	21	f	f	2026-07-19 00:35:20.717715+00
435	4	19	f	f	2026-07-19 00:35:24.787169+00
436	93	2	t	f	2026-07-19 00:35:30.256557+00
437	8	21	f	f	2026-07-19 00:35:32.847213+00
438	18	19	f	f	2026-07-19 00:35:37.288358+00
439	62	19	t	f	2026-07-19 00:35:37.892939+00
440	121	19	f	f	2026-07-19 00:35:38.138479+00
441	92	24	t	t	2026-07-19 00:35:50.100681+00
442	76	19	f	f	2026-07-19 00:35:51.744421+00
443	81	22	f	f	2026-07-19 00:35:54.643917+00
444	51	2	t	f	2026-07-19 00:35:54.92157+00
445	76	19	f	f	2026-07-19 00:35:58.865732+00
446	4	19	f	f	2026-07-19 00:36:10.869488+00
447	4	19	f	f	2026-07-19 00:36:14.371165+00
448	92	8	t	f	2026-07-19 00:36:27.393233+00
449	38	10	t	t	2026-07-19 00:36:37.976865+00
450	79	19	f	f	2026-07-19 00:36:39.554704+00
451	110	11	t	f	2026-07-19 00:36:41.314012+00
452	22	24	f	f	2026-07-19 00:36:41.718314+00
453	36	6	f	f	2026-07-19 00:36:46.494114+00
454	117	19	f	f	2026-07-19 00:36:53.953523+00
455	19	17	t	f	2026-07-19 00:37:00.676989+00
456	117	19	f	f	2026-07-19 00:37:02.72179+00
457	117	19	f	f	2026-07-19 00:37:09.069842+00
458	95	19	f	f	2026-07-19 00:37:22.271488+00
459	80	17	t	f	2026-07-19 00:37:23.906518+00
460	76	21	t	f	2026-07-19 00:37:24.299621+00
461	87	6	t	f	2026-07-19 00:37:33.695339+00
462	22	24	f	f	2026-07-19 00:37:34.10948+00
463	25	20	t	f	2026-07-19 00:37:34.919522+00
464	106	20	t	f	2026-07-19 00:37:36.364959+00
465	94	21	f	f	2026-07-19 00:37:40.814977+00
466	18	13	t	t	2026-07-19 00:37:41.017525+00
467	62	13	t	f	2026-07-19 00:37:41.35203+00
468	111	11	t	f	2026-07-19 00:37:42.789276+00
469	48	21	f	f	2026-07-19 00:37:46.160976+00
470	22	24	f	f	2026-07-19 00:37:54.526709+00
471	4	11	t	f	2026-07-19 00:38:01.353626+00
472	89	20	t	f	2026-07-19 00:38:02.29133+00
473	48	2	t	f	2026-07-19 00:38:11.571819+00
474	18	11	t	f	2026-07-19 00:38:12.582057+00
475	119	7	t	f	2026-07-19 00:38:18.452378+00
476	67	21	f	f	2026-07-19 00:38:23.278038+00
477	67	21	f	f	2026-07-19 00:38:33.641241+00
478	65	11	t	f	2026-07-19 00:38:37.952916+00
479	77	22	t	f	2026-07-19 00:38:42.817323+00
480	27	6	t	f	2026-07-19 00:38:46.075382+00
481	121	21	t	f	2026-07-19 00:38:46.821144+00
482	69	20	t	f	2026-07-19 00:38:54.861406+00
483	36	7	t	f	2026-07-19 00:39:02.96236+00
484	138	6	t	f	2026-07-19 00:39:10.683715+00
485	85	11	t	f	2026-07-19 00:39:12.712085+00
486	125	20	t	f	2026-07-19 00:39:17.423867+00
487	112	24	t	t	2026-07-19 00:39:31.211011+00
488	127	19	f	f	2026-07-19 00:39:32.891704+00
489	95	6	t	f	2026-07-19 00:39:36.020911+00
490	129	11	f	f	2026-07-19 00:39:41.882527+00
491	127	19	f	f	2026-07-19 00:39:42.157301+00
492	77	2	t	f	2026-07-19 00:39:42.575091+00
493	48	15	t	t	2026-07-19 00:39:49.029578+00
494	81	22	t	f	2026-07-19 00:39:54.146077+00
495	21	22	t	f	2026-07-19 00:40:01.96503+00
496	95	8	f	f	2026-07-19 00:40:02.045475+00
497	95	8	t	f	2026-07-19 00:40:07.278092+00
498	81	23	t	f	2026-07-19 00:40:08.793459+00
499	88	21	f	f	2026-07-19 00:40:14.123159+00
500	88	21	f	f	2026-07-19 00:40:14.979519+00
501	35	21	f	f	2026-07-19 00:40:17.975665+00
502	17	8	t	f	2026-07-19 00:40:22.463745+00
503	137	8	t	f	2026-07-19 00:40:31.18856+00
504	116	1	t	f	2026-07-19 00:40:34.696828+00
505	139	15	t	t	2026-07-19 00:40:34.839548+00
506	22	24	t	f	2026-07-19 00:40:39.641295+00
507	77	23	t	f	2026-07-19 00:40:44.24655+00
508	94	5	f	f	2026-07-19 00:40:47.36376+00
509	94	21	f	f	2026-07-19 00:40:51.598193+00
510	21	8	t	f	2026-07-19 00:40:52.198519+00
511	125	19	f	f	2026-07-19 00:40:53.89844+00
512	125	19	f	f	2026-07-19 00:40:57.049912+00
513	9	8	t	f	2026-07-19 00:40:57.28436+00
514	127	7	t	f	2026-07-19 00:41:01.144334+00
515	62	16	t	t	2026-07-19 00:41:05.626081+00
516	85	10	f	f	2026-07-19 00:41:27.096276+00
517	99	2	t	f	2026-07-19 00:41:27.822944+00
518	36	6	t	f	2026-07-19 00:41:28.303698+00
519	139	21	f	f	2026-07-19 00:41:36.183642+00
520	139	21	f	f	2026-07-19 00:41:41.470671+00
521	76	13	t	f	2026-07-19 00:41:43.078943+00
522	124	21	f	f	2026-07-19 00:41:44.656775+00
523	139	21	f	f	2026-07-19 00:41:46.107238+00
524	21	15	t	f	2026-07-19 00:41:48.104319+00
525	139	21	f	f	2026-07-19 00:41:51.30999+00
526	85	10	f	f	2026-07-19 00:41:51.938051+00
527	139	21	t	f	2026-07-19 00:41:56.706251+00
528	80	20	f	f	2026-07-19 00:41:58.436085+00
529	85	8	t	f	2026-07-19 00:42:03.360089+00
530	15	13	f	f	2026-07-19 00:42:04.709533+00
531	131	5	f	f	2026-07-19 00:42:05.077025+00
532	80	20	t	f	2026-07-19 00:42:06.125599+00
533	60	15	t	f	2026-07-19 00:42:06.544596+00
534	89	21	f	f	2026-07-19 00:42:11.074459+00
535	37	8	t	f	2026-07-19 00:42:16.657267+00
536	131	7	t	f	2026-07-19 00:42:19.240483+00
537	94	21	f	f	2026-07-19 00:42:22.992649+00
538	94	21	f	f	2026-07-19 00:42:31.250082+00
539	121	1	t	f	2026-07-19 00:42:32.261366+00
540	8	15	t	f	2026-07-19 00:42:37.725632+00
541	94	21	f	f	2026-07-19 00:42:40.201968+00
542	12	11	t	f	2026-07-19 00:42:47.128854+00
543	119	6	t	f	2026-07-19 00:42:47.586841+00
544	16	21	f	f	2026-07-19 00:43:03.182118+00
545	8	21	f	f	2026-07-19 00:43:10.658448+00
546	103	4	f	f	2026-07-19 00:43:12.575234+00
547	21	23	t	f	2026-07-19 00:43:13.203513+00
548	103	4	f	f	2026-07-19 00:43:40.076732+00
549	62	1	f	f	2026-07-19 00:43:43.440744+00
550	62	2	t	f	2026-07-19 00:43:47.831115+00
551	60	21	f	f	2026-07-19 00:43:48.549177+00
552	67	19	f	f	2026-07-19 00:43:57.635256+00
553	51	19	f	f	2026-07-19 00:43:59.849192+00
565	13	19	f	f	2026-07-19 00:45:19.553668+00
575	62	1	t	f	2026-07-19 00:46:03.372675+00
577	47	2	t	f	2026-07-19 00:46:16.71739+00
578	94	21	f	f	2026-07-19 00:46:19.288095+00
1362	103	21	f	f	2026-07-19 01:34:32.191122+00
1366	69	11	t	f	2026-07-19 01:34:56.651792+00
1367	77	26	f	f	2026-07-19 01:35:09.805407+00
1820	4	24	f	f	2026-07-19 02:12:18.054508+00
1824	44	21	f	f	2026-07-19 02:12:36.004118+00
1825	4	24	f	f	2026-07-19 02:12:36.889222+00
1827	105	22	t	f	2026-07-19 02:12:46.098855+00
1828	4	24	f	f	2026-07-19 02:12:47.285254+00
1842	133	24	f	f	2026-07-19 02:13:33.973007+00
1843	127	19	f	f	2026-07-19 02:13:37.544901+00
1844	127	19	f	f	2026-07-19 02:13:40.763614+00
1852	103	21	f	f	2026-07-19 02:14:39.289612+00
1853	48	18	f	f	2026-07-19 02:14:46.024342+00
1858	103	21	f	f	2026-07-19 02:15:08.33585+00
1862	103	21	f	f	2026-07-19 02:15:24.035492+00
1863	51	22	f	f	2026-07-19 02:15:25.702027+00
1864	32	14	f	f	2026-07-19 02:15:28.172049+00
1869	126	14	f	f	2026-07-19 02:15:46.007064+00
1878	62	24	f	f	2026-07-19 02:16:47.095148+00
1880	72	18	f	f	2026-07-19 02:16:51.694881+00
1886	4	24	f	f	2026-07-19 02:17:44.066193+00
2365	53	14	f	f	2026-07-19 03:11:01.839019+00
2366	95	13	t	f	2026-07-19 03:11:08.744803+00
2367	101	19	f	f	2026-07-19 03:11:47.802134+00
2368	113	19	f	f	2026-07-19 03:11:48.126748+00
2370	101	19	f	f	2026-07-19 03:11:56.709432+00
2376	27	16	f	f	2026-07-19 03:12:39.918353+00
2380	26	12	t	f	2026-07-19 03:13:32.856372+00
2389	32	22	f	f	2026-07-19 03:14:03.265154+00
2391	32	22	f	f	2026-07-19 03:14:09.235791+00
2392	32	22	f	f	2026-07-19 03:14:11.39395+00
2394	32	22	f	f	2026-07-19 03:14:15.530954+00
2395	88	21	f	f	2026-07-19 03:14:33.01839+00
2396	113	1	t	f	2026-07-19 03:14:34.273943+00
2401	101	26	f	f	2026-07-19 03:15:13.457065+00
2404	45	19	f	f	2026-07-19 03:15:58.410997+00
2406	149	5	f	f	2026-07-19 03:16:04.838258+00
2410	92	10	t	f	2026-07-19 03:16:18.035142+00
2414	92	14	f	f	2026-07-19 03:16:34.680287+00
2417	75	21	f	f	2026-07-19 03:17:01.488146+00
2421	6	7	t	f	2026-07-19 03:17:21.465156+00
2422	18	9	t	f	2026-07-19 03:17:25.510066+00
2423	73	21	f	f	2026-07-19 03:17:37.659249+00
2427	44	24	f	f	2026-07-19 03:17:51.894284+00
2429	45	19	f	f	2026-07-19 03:18:01.448072+00
2430	44	24	f	f	2026-07-19 03:18:04.658021+00
2432	75	21	t	f	2026-07-19 03:18:09.192641+00
2436	73	21	f	f	2026-07-19 03:18:24.949305+00
2437	88	21	f	f	2026-07-19 03:18:30.886605+00
2439	85	19	f	f	2026-07-19 03:18:54.180581+00
2442	88	21	f	f	2026-07-19 03:19:21.765146+00
2444	88	21	f	f	2026-07-19 03:19:23.742964+00
2447	124	19	f	f	2026-07-19 03:19:28.988936+00
2448	121	22	t	f	2026-07-19 03:19:52.052106+00
2482	24	24	f	f	2026-07-19 03:23:38.933705+00
2897	65	5	f	f	2026-07-19 04:25:19.98294+00
2901	65	5	f	f	2026-07-19 04:25:29.481541+00
2916	75	22	f	f	2026-07-19 04:26:56.031402+00
2920	6	26	f	f	2026-07-19 04:27:24.593377+00
2923	72	27	f	f	2026-07-19 04:27:40.127189+00
2924	13	27	t	f	2026-07-19 04:27:51.886743+00
2925	107	19	f	f	2026-07-19 04:28:12.969926+00
2929	101	13	t	f	2026-07-19 04:29:03.676809+00
2934	75	22	f	f	2026-07-19 04:30:01.138784+00
2935	75	22	f	f	2026-07-19 04:30:09.683547+00
2936	155	17	t	f	2026-07-19 04:30:39.715705+00
2938	18	19	f	f	2026-07-19 04:30:45.720361+00
2939	18	19	f	f	2026-07-19 04:30:49.076138+00
2941	18	19	f	f	2026-07-19 04:30:55.450052+00
2997	80	8	t	f	2026-07-19 04:38:20.198591+00
3002	51	18	f	f	2026-07-19 04:38:47.073961+00
3003	109	21	f	f	2026-07-19 04:38:52.029241+00
3007	27	22	f	f	2026-07-19 04:39:48.349741+00
3014	152	12	t	f	2026-07-19 04:41:16.454512+00
3016	130	2	t	f	2026-07-19 04:41:18.669661+00
3031	17	4	f	f	2026-07-19 04:43:08.241537+00
3032	17	13	t	f	2026-07-19 04:43:15.43811+00
3033	129	22	f	f	2026-07-19 04:43:40.805027+00
3034	148	19	f	f	2026-07-19 04:44:01.389372+00
3035	129	22	f	f	2026-07-19 04:44:02.858647+00
3042	6	26	f	f	2026-07-19 04:44:59.199489+00
3048	27	22	f	f	2026-07-19 04:46:27.823237+00
3049	109	21	f	f	2026-07-19 04:46:29.489841+00
3050	65	26	f	f	2026-07-19 04:46:53.637721+00
3052	26	9	t	f	2026-07-19 04:47:00.92916+00
3053	65	26	f	f	2026-07-19 04:47:13.18781+00
3056	62	9	t	f	2026-07-19 04:47:57.658665+00
3059	129	22	f	f	2026-07-19 04:48:16.100759+00
3060	148	19	f	f	2026-07-19 04:48:17.812725+00
3067	137	19	f	f	2026-07-19 04:49:55.427779+00
3068	129	22	f	f	2026-07-19 04:50:33.179929+00
3078	24	9	t	f	2026-07-19 04:51:41.772353+00
3082	152	26	f	f	2026-07-19 04:52:33.92376+00
3084	51	23	t	f	2026-07-19 04:52:55.108458+00
3085	72	19	f	f	2026-07-19 04:53:08.514212+00
3293	115	22	f	f	2026-07-19 05:34:34.892076+00
3294	39	26	f	f	2026-07-19 05:34:40.292757+00
3296	115	22	f	f	2026-07-19 05:34:45.289348+00
3299	115	22	f	f	2026-07-19 05:35:09.654581+00
3300	115	22	f	f	2026-07-19 05:35:14.257044+00
3301	130	7	t	f	2026-07-19 05:35:14.449966+00
3314	122	21	f	f	2026-07-19 05:39:09.966227+00
3315	122	21	f	f	2026-07-19 05:39:17.09333+00
3320	115	22	f	f	2026-07-19 05:40:15.713861+00
3327	122	21	f	f	2026-07-19 05:41:03.186102+00
3328	149	14	f	f	2026-07-19 05:41:06.10117+00
3329	122	21	f	f	2026-07-19 05:41:10.759945+00
3330	133	26	f	f	2026-07-19 05:41:12.353037+00
3334	122	21	f	f	2026-07-19 05:41:25.495886+00
3335	149	14	f	f	2026-07-19 05:41:28.818182+00
3590	155	6	f	f	2026-07-19 06:35:35.254942+00
3591	155	6	f	f	2026-07-19 06:35:38.070818+00
3600	154	21	f	f	2026-07-19 06:36:27.320341+00
554	38	11	t	f	2026-07-19 00:44:01.634995+00
560	15	11	t	f	2026-07-19 00:44:29.693505+00
567	111	22	f	f	2026-07-19 00:45:25.995139+00
568	13	19	f	f	2026-07-19 00:45:26.506786+00
571	77	24	t	f	2026-07-19 00:45:45.15644+00
574	94	21	f	f	2026-07-19 00:46:01.816035+00
1364	81	27	t	f	2026-07-19 01:34:44.500119+00
1369	92	27	t	f	2026-07-19 01:35:11.264621+00
1370	136	21	f	f	2026-07-19 01:35:12.081002+00
1889	105	12	t	f	2026-07-19 02:17:53.680336+00
1890	92	19	f	f	2026-07-19 02:17:57.316363+00
1892	92	19	f	f	2026-07-19 02:17:59.323933+00
1901	133	24	f	f	2026-07-19 02:18:07.918857+00
1912	95	26	f	f	2026-07-19 02:18:58.090033+00
1913	51	22	f	f	2026-07-19 02:18:58.912501+00
1914	89	14	f	f	2026-07-19 02:19:12.120865+00
1921	148	14	f	f	2026-07-19 02:19:49.996968+00
1924	84	14	f	f	2026-07-19 02:20:36.273377+00
1927	44	21	f	f	2026-07-19 02:20:48.252807+00
1933	88	21	f	f	2026-07-19 02:22:02.33861+00
1938	88	21	f	f	2026-07-19 02:22:28.405201+00
1939	44	21	f	f	2026-07-19 02:22:42.715618+00
1941	88	21	f	f	2026-07-19 02:22:49.59979+00
1943	145	19	f	f	2026-07-19 02:22:55.351602+00
1953	45	21	f	f	2026-07-19 02:23:21.015231+00
1954	45	21	f	f	2026-07-19 02:23:25.191332+00
1960	32	22	f	f	2026-07-19 02:23:38.569115+00
1961	88	21	f	f	2026-07-19 02:23:40.152642+00
1962	32	22	f	f	2026-07-19 02:23:42.825725+00
1965	45	21	f	f	2026-07-19 02:23:48.986961+00
1966	45	21	f	f	2026-07-19 02:23:53.904394+00
1976	84	14	f	f	2026-07-19 02:24:18.967652+00
2007	89	14	f	f	2026-07-19 02:28:00.811655+00
2009	104	14	f	f	2026-07-19 02:28:03.521785+00
2017	32	22	f	f	2026-07-19 02:28:20.888241+00
2018	32	22	f	f	2026-07-19 02:28:23.554966+00
2020	119	19	f	f	2026-07-19 02:28:32.273312+00
2024	119	26	f	f	2026-07-19 02:28:52.971824+00
2026	32	22	f	f	2026-07-19 02:28:54.979746+00
2029	119	13	t	f	2026-07-19 02:29:08.47556+00
2030	44	21	t	f	2026-07-19 02:29:17.512547+00
2033	145	19	t	f	2026-07-19 02:29:25.377484+00
2385	67	25	f	f	2026-07-19 03:13:46.373067+00
2386	32	22	f	f	2026-07-19 03:13:58.191666+00
2387	32	22	f	f	2026-07-19 03:14:00.373808+00
2388	32	22	f	f	2026-07-19 03:14:01.955202+00
2393	32	22	f	f	2026-07-19 03:14:13.090685+00
2400	72	9	t	f	2026-07-19 03:15:02.488348+00
2405	124	19	f	f	2026-07-19 03:16:03.711731+00
2409	38	26	t	f	2026-07-19 03:16:14.238978+00
2418	101	19	f	f	2026-07-19 03:17:11.983002+00
2420	24	23	t	f	2026-07-19 03:17:20.898499+00
2428	73	21	f	f	2026-07-19 03:17:56.310615+00
2438	101	26	t	f	2026-07-19 03:18:37.290226+00
2441	88	21	f	f	2026-07-19 03:19:10.123273+00
2443	37	19	f	f	2026-07-19 03:19:22.578246+00
2445	124	19	f	f	2026-07-19 03:19:25.594313+00
2446	149	21	f	f	2026-07-19 03:19:26.927751+00
2452	44	24	f	f	2026-07-19 03:20:13.767348+00
2456	24	24	f	f	2026-07-19 03:20:38.151997+00
2463	73	21	t	f	2026-07-19 03:21:23.81656+00
2470	37	12	t	f	2026-07-19 03:21:53.299572+00
2917	109	20	t	f	2026-07-19 04:26:57.957508+00
2918	75	22	f	f	2026-07-19 04:27:01.9537+00
3305	24	19	f	f	2026-07-19 05:35:56.718357+00
3306	54	14	f	f	2026-07-19 05:36:01.484705+00
3307	54	14	f	f	2026-07-19 05:36:04.440704+00
3321	149	14	f	f	2026-07-19 05:40:30.416559+00
3322	149	14	f	f	2026-07-19 05:40:33.052449+00
3323	149	14	f	f	2026-07-19 05:40:48.96721+00
3325	122	21	f	f	2026-07-19 05:40:52.31372+00
3337	121	4	f	f	2026-07-19 05:42:49.213717+00
3338	115	22	f	f	2026-07-19 05:43:00.176273+00
3339	133	26	f	f	2026-07-19 05:43:06.341216+00
3344	62	26	f	f	2026-07-19 05:44:31.637222+00
3345	62	26	f	f	2026-07-19 05:44:50.881551+00
3346	48	5	f	f	2026-07-19 05:44:54.157182+00
3352	94	19	f	f	2026-07-19 05:45:38.431105+00
3358	155	6	f	f	2026-07-19 05:46:08.814883+00
3360	145	10	t	f	2026-07-19 05:46:22.436085+00
3362	5	22	f	f	2026-07-19 05:46:46.323214+00
3363	5	22	f	f	2026-07-19 05:46:50.289064+00
3365	65	26	f	f	2026-07-19 05:48:10.221588+00
3380	122	21	f	f	2026-07-19 05:51:46.607105+00
3381	122	21	f	f	2026-07-19 05:51:57.16974+00
3390	147	27	f	f	2026-07-19 05:53:19.763399+00
3391	156	17	t	f	2026-07-19 05:53:49.367633+00
3396	62	27	f	f	2026-07-19 05:54:31.03199+00
3398	122	21	f	f	2026-07-19 05:54:44.690795+00
3403	18	19	f	f	2026-07-19 05:55:07.398519+00
3404	154	19	f	f	2026-07-19 05:55:08.799355+00
3406	147	16	t	f	2026-07-19 05:55:35.915792+00
3411	154	19	f	f	2026-07-19 05:58:39.594135+00
3412	115	14	f	f	2026-07-19 05:58:47.5131+00
3413	39	13	t	f	2026-07-19 05:58:50.910147+00
3418	115	14	f	f	2026-07-19 06:00:26.631631+00
3419	156	7	t	f	2026-07-19 06:00:31.770586+00
3421	109	21	f	f	2026-07-19 06:00:58.081487+00
3422	115	14	f	f	2026-07-19 06:01:05.096093+00
3601	155	8	t	f	2026-07-19 06:36:28.925752+00
3602	18	19	f	f	2026-07-19 06:36:34.400739+00
3603	154	21	f	f	2026-07-19 06:36:41.201531+00
3618	152	27	t	f	2026-07-19 06:39:10.541379+00
3632	107	19	f	f	2026-07-19 06:42:24.391076+00
3633	82	14	f	f	2026-07-19 06:42:32.915578+00
3634	40	24	t	f	2026-07-19 06:43:10.002331+00
3636	107	19	f	f	2026-07-19 06:43:32.563585+00
3644	32	22	f	f	2026-07-19 06:44:36.102743+00
3645	32	22	f	f	2026-07-19 06:44:40.10467+00
3649	152	19	f	f	2026-07-19 06:44:57.413621+00
3650	36	19	f	f	2026-07-19 06:45:10.569931+00
3672	121	4	f	f	2026-07-19 06:46:56.556457+00
3673	149	22	f	f	2026-07-19 06:46:58.347382+00
3676	149	22	f	f	2026-07-19 06:47:17.456075+00
3677	32	23	t	f	2026-07-19 06:47:40.053815+00
3683	36	19	f	f	2026-07-19 06:49:40.651107+00
3697	137	14	t	f	2026-07-19 06:53:52.591341+00
3698	120	20	t	f	2026-07-19 06:53:58.686178+00
3699	5	19	f	f	2026-07-19 06:54:03.476165+00
3700	32	24	f	f	2026-07-19 06:54:05.348853+00
555	51	19	f	f	2026-07-19 00:44:09.557375+00
558	54	4	t	t	2026-07-19 00:44:19.717597+00
559	112	19	f	f	2026-07-19 00:44:25.512598+00
561	13	19	f	f	2026-07-19 00:44:42.378944+00
563	32	20	t	f	2026-07-19 00:45:11.601205+00
570	69	21	f	f	2026-07-19 00:45:41.524586+00
573	129	21	f	f	2026-07-19 00:45:55.963201+00
579	48	21	f	f	2026-07-19 00:46:20.328063+00
581	48	21	f	f	2026-07-19 00:46:25.666013+00
583	7	8	t	f	2026-07-19 00:46:29.24724+00
1371	25	24	f	f	2026-07-19 01:35:20.862049+00
1372	92	13	t	f	2026-07-19 01:35:35.907547+00
1377	113	19	f	f	2026-07-19 01:36:01.673882+00
1379	11	19	f	f	2026-07-19 01:36:14.326068+00
1380	22	2	t	f	2026-07-19 01:36:17.896317+00
1381	128	21	f	f	2026-07-19 01:36:20.587028+00
1384	148	2	t	f	2026-07-19 01:36:28.570222+00
1386	24	13	t	f	2026-07-19 01:36:36.890451+00
1387	80	6	f	f	2026-07-19 01:36:39.263745+00
1388	148	6	t	f	2026-07-19 01:36:45.67959+00
1397	44	21	f	f	2026-07-19 01:37:43.874426+00
1398	106	15	t	f	2026-07-19 01:37:45.035352+00
1400	80	6	t	f	2026-07-19 01:37:53.989588+00
1401	62	21	f	f	2026-07-19 01:37:56.158696+00
1405	62	21	f	f	2026-07-19 01:38:05.490825+00
1891	92	19	f	f	2026-07-19 02:17:58.327486+00
1893	92	19	f	f	2026-07-19 02:18:00.408369+00
1894	92	19	f	f	2026-07-19 02:18:01.351938+00
1895	92	19	f	f	2026-07-19 02:18:02.384669+00
1905	103	21	f	f	2026-07-19 02:18:32.609917+00
1908	105	24	t	f	2026-07-19 02:18:42.765078+00
1909	144	14	f	f	2026-07-19 02:18:47.001163+00
1910	41	14	f	f	2026-07-19 02:18:48.63759+00
1911	51	22	f	f	2026-07-19 02:18:57.007781+00
1918	4	24	f	f	2026-07-19 02:19:16.569312+00
1919	4	24	f	f	2026-07-19 02:19:19.175417+00
1925	104	14	f	f	2026-07-19 02:20:44.824191+00
1926	148	11	t	f	2026-07-19 02:20:47.619713+00
1928	17	14	t	f	2026-07-19 02:21:00.85351+00
1929	103	14	t	f	2026-07-19 02:21:19.911576+00
1930	22	16	f	f	2026-07-19 02:21:27.564112+00
1931	22	16	f	f	2026-07-19 02:21:56.446408+00
1936	88	21	f	f	2026-07-19 02:22:23.976452+00
1940	105	26	t	f	2026-07-19 02:22:46.972459+00
1942	88	21	f	f	2026-07-19 02:22:53.433228+00
1975	95	26	f	f	2026-07-19 02:24:17.142064+00
1984	85	25	f	f	2026-07-19 02:25:39.052962+00
1987	106	24	t	f	2026-07-19 02:26:26.761821+00
1988	105	27	f	f	2026-07-19 02:26:32.090196+00
1990	104	21	f	f	2026-07-19 02:26:34.002582+00
1995	131	19	f	f	2026-07-19 02:27:12.862196+00
1997	131	19	f	f	2026-07-19 02:27:13.996917+00
1999	131	19	f	f	2026-07-19 02:27:14.821786+00
2002	131	19	f	f	2026-07-19 02:27:16.018841+00
2003	131	19	f	f	2026-07-19 02:27:16.430772+00
2006	16	14	f	f	2026-07-19 02:27:56.286253+00
2008	16	19	f	f	2026-07-19 02:28:02.705815+00
2011	16	21	f	f	2026-07-19 02:28:07.879085+00
2012	7	10	t	t	2026-07-19 02:28:08.05325+00
2015	32	22	f	f	2026-07-19 02:28:14.017654+00
2016	32	22	f	f	2026-07-19 02:28:17.108354+00
2019	32	22	f	f	2026-07-19 02:28:26.51655+00
2022	32	22	f	f	2026-07-19 02:28:43.189611+00
2023	32	22	f	f	2026-07-19 02:28:45.004193+00
2027	105	25	t	f	2026-07-19 02:28:59.416264+00
2028	131	8	t	f	2026-07-19 02:28:59.856476+00
2031	32	22	f	f	2026-07-19 02:29:21.112258+00
2032	130	1	t	f	2026-07-19 02:29:22.921209+00
2390	87	22	t	f	2026-07-19 03:14:09.125913+00
2398	79	14	t	f	2026-07-19 03:14:41.561823+00
2402	101	26	f	f	2026-07-19 03:15:27.418657+00
2407	101	26	f	f	2026-07-19 03:16:13.05266+00
2408	149	5	f	f	2026-07-19 03:16:13.702579+00
2411	101	26	f	f	2026-07-19 03:16:22.740304+00
2416	75	21	f	f	2026-07-19 03:16:53.320308+00
2419	101	19	f	f	2026-07-19 03:17:20.52755+00
2425	13	21	f	f	2026-07-19 03:17:48.686392+00
2426	75	21	f	f	2026-07-19 03:17:49.522626+00
2471	101	27	f	f	2026-07-19 03:22:02.841639+00
2475	15	16	t	f	2026-07-19 03:22:25.885758+00
2478	152	14	f	f	2026-07-19 03:23:25.83022+00
2926	38	19	t	f	2026-07-19 04:28:22.238825+00
2933	75	22	f	f	2026-07-19 04:29:57.014923+00
2937	18	19	f	f	2026-07-19 04:30:40.257574+00
3028	17	4	f	f	2026-07-19 04:42:38.734109+00
3030	75	22	f	f	2026-07-19 04:43:02.259238+00
3044	152	26	f	f	2026-07-19 04:45:23.098247+00
3045	8	22	f	f	2026-07-19 04:45:51.240286+00
3308	24	4	t	f	2026-07-19 05:36:25.476138+00
3309	18	19	f	f	2026-07-19 05:36:57.366107+00
3310	67	4	f	f	2026-07-19 05:36:58.373579+00
3311	67	4	f	f	2026-07-19 05:37:07.376221+00
3312	67	4	f	f	2026-07-19 05:37:10.884203+00
3319	115	22	f	f	2026-07-19 05:40:08.661912+00
3324	122	21	f	f	2026-07-19 05:40:50.570162+00
3336	133	26	f	f	2026-07-19 05:41:29.664735+00
3343	62	26	f	f	2026-07-19 05:44:24.836094+00
3347	92	18	f	f	2026-07-19 05:45:02.077949+00
3353	133	26	t	f	2026-07-19 05:45:38.740052+00
3355	8	22	f	f	2026-07-19 05:45:50.329602+00
3359	39	26	f	f	2026-07-19 05:46:09.051232+00
3367	18	19	f	f	2026-07-19 05:49:04.378972+00
3375	156	15	t	f	2026-07-19 05:51:24.622421+00
3378	18	19	f	f	2026-07-19 05:51:31.711749+00
3388	122	21	f	f	2026-07-19 05:52:37.773528+00
3393	122	21	f	f	2026-07-19 05:54:26.696528+00
3394	154	19	f	f	2026-07-19 05:54:28.14918+00
3395	145	9	t	f	2026-07-19 05:54:29.163489+00
3405	62	27	f	f	2026-07-19 05:55:21.470232+00
3407	133	27	t	f	2026-07-19 05:56:25.80209+00
3409	18	19	f	f	2026-07-19 05:58:06.27883+00
3608	154	21	f	f	2026-07-19 06:37:11.202173+00
3609	154	21	f	f	2026-07-19 06:37:23.37167+00
3723	107	19	f	f	2026-07-19 06:59:37.202361+00
3727	32	26	f	f	2026-07-19 07:00:51.383789+00
3728	27	14	t	f	2026-07-19 07:00:55.958206+00
3729	32	25	t	f	2026-07-19 07:00:59.209006+00
3731	120	21	f	f	2026-07-19 07:01:16.367078+00
3766	149	22	f	f	2026-07-19 07:11:30.435904+00
3771	115	24	f	f	2026-07-19 07:13:37.251133+00
556	111	8	t	f	2026-07-19 00:44:12.583357+00
557	51	19	f	f	2026-07-19 00:44:13.161062+00
562	35	21	t	f	2026-07-19 00:45:02.259517+00
564	121	19	f	f	2026-07-19 00:45:16.649642+00
566	68	8	t	f	2026-07-19 00:45:20.840717+00
569	62	15	t	f	2026-07-19 00:45:31.693158+00
572	38	13	f	f	2026-07-19 00:45:50.65134+00
576	94	21	f	f	2026-07-19 00:46:10.639338+00
580	127	2	t	f	2026-07-19 00:46:24.128309+00
582	94	21	f	f	2026-07-19 00:46:26.529157+00
584	48	21	f	f	2026-07-19 00:46:30.470174+00
585	38	13	t	f	2026-07-19 00:46:32.741311+00
586	94	21	f	f	2026-07-19 00:46:36.050921+00
587	48	21	f	f	2026-07-19 00:46:37.837426+00
588	94	21	f	f	2026-07-19 00:46:44.196933+00
589	37	11	t	f	2026-07-19 00:46:49.237721+00
590	94	21	f	f	2026-07-19 00:46:52.18883+00
591	94	21	f	f	2026-07-19 00:46:55.193893+00
592	94	21	f	f	2026-07-19 00:47:02.128427+00
593	38	15	t	f	2026-07-19 00:47:04.159648+00
594	87	21	f	f	2026-07-19 00:47:06.416526+00
595	94	21	f	f	2026-07-19 00:47:08.506254+00
596	125	7	t	f	2026-07-19 00:47:08.947096+00
597	94	21	f	f	2026-07-19 00:47:18.93513+00
598	125	15	t	f	2026-07-19 00:47:23.912557+00
599	103	2	t	f	2026-07-19 00:47:26.707596+00
600	94	21	f	f	2026-07-19 00:47:26.747558+00
601	65	21	t	f	2026-07-19 00:47:28.96279+00
602	94	21	t	f	2026-07-19 00:47:32.835175+00
603	79	21	f	f	2026-07-19 00:47:33.013186+00
604	89	21	f	f	2026-07-19 00:47:33.820875+00
605	125	21	t	f	2026-07-19 00:47:37.562962+00
606	7	6	t	f	2026-07-19 00:47:41.06337+00
607	69	21	f	f	2026-07-19 00:47:41.541166+00
608	29	8	f	f	2026-07-19 00:47:46.085165+00
609	46	15	t	f	2026-07-19 00:47:46.540623+00
610	29	8	t	f	2026-07-19 00:47:50.90369+00
611	111	10	t	f	2026-07-19 00:47:55.613706+00
612	138	22	f	f	2026-07-19 00:47:56.190373+00
613	38	21	f	f	2026-07-19 00:47:57.493181+00
614	18	19	f	f	2026-07-19 00:47:59.465516+00
615	27	20	t	f	2026-07-19 00:48:02.64658+00
616	32	21	f	f	2026-07-19 00:48:02.767689+00
617	19	20	t	f	2026-07-19 00:48:11.169004+00
618	87	21	f	f	2026-07-19 00:48:23.460518+00
619	103	4	f	f	2026-07-19 00:48:34.089054+00
620	30	7	f	f	2026-07-19 00:48:34.326061+00
621	18	19	f	f	2026-07-19 00:48:39.566487+00
622	30	8	t	f	2026-07-19 00:48:44.2751+00
623	89	21	f	f	2026-07-19 00:48:45.62979+00
624	79	21	f	f	2026-07-19 00:48:53.377005+00
625	79	21	t	f	2026-07-19 00:49:00.943634+00
626	131	16	t	f	2026-07-19 00:49:05.496166+00
627	13	21	f	f	2026-07-19 00:49:07.839786+00
628	18	19	f	f	2026-07-19 00:49:15.714783+00
629	37	15	t	f	2026-07-19 00:49:17.825049+00
630	95	19	f	f	2026-07-19 00:49:22.912935+00
631	87	8	t	f	2026-07-19 00:49:28.827482+00
632	101	17	t	f	2026-07-19 00:49:35.450985+00
633	35	22	f	f	2026-07-19 00:49:38.691751+00
634	76	19	f	f	2026-07-19 00:49:43.533217+00
635	35	22	f	f	2026-07-19 00:49:46.864669+00
636	18	19	f	f	2026-07-19 00:49:51.865627+00
637	51	19	f	f	2026-07-19 00:50:01.67234+00
638	76	19	f	f	2026-07-19 00:50:03.305337+00
639	51	19	f	f	2026-07-19 00:50:04.56626+00
640	54	11	t	f	2026-07-19 00:50:04.709936+00
641	106	6	t	f	2026-07-19 00:50:10.908769+00
642	76	19	f	f	2026-07-19 00:50:11.518248+00
643	51	19	f	f	2026-07-19 00:50:13.095783+00
644	125	2	t	f	2026-07-19 00:50:14.650763+00
645	76	19	f	f	2026-07-19 00:50:17.724016+00
646	81	5	f	f	2026-07-19 00:50:18.335995+00
647	126	6	f	f	2026-07-19 00:50:18.590591+00
648	35	22	f	f	2026-07-19 00:50:20.018814+00
649	51	19	f	f	2026-07-19 00:50:20.59208+00
650	7	15	t	f	2026-07-19 00:50:21.211473+00
651	76	19	f	f	2026-07-19 00:50:22.368171+00
652	81	24	f	f	2026-07-19 00:50:23.851632+00
653	76	19	f	f	2026-07-19 00:50:24.264709+00
654	93	21	f	f	2026-07-19 00:50:25.927684+00
655	95	1	t	f	2026-07-19 00:50:28.802019+00
656	93	21	f	f	2026-07-19 00:50:29.693386+00
657	126	6	f	f	2026-07-19 00:50:35.200825+00
658	18	19	f	f	2026-07-19 00:50:39.411151+00
659	80	21	f	f	2026-07-19 00:50:41.433534+00
660	85	5	t	t	2026-07-19 00:50:42.431207+00
661	69	21	f	f	2026-07-19 00:51:07.120928+00
662	139	22	f	f	2026-07-19 00:51:14.452041+00
663	69	21	f	f	2026-07-19 00:51:26.586199+00
664	81	1	t	f	2026-07-19 00:51:28.41953+00
665	69	21	f	f	2026-07-19 00:51:29.723975+00
666	138	15	t	f	2026-07-19 00:51:31.537023+00
667	69	21	f	f	2026-07-19 00:51:32.591328+00
668	69	21	f	f	2026-07-19 00:51:36.139256+00
669	126	6	t	f	2026-07-19 00:51:37.059864+00
670	31	19	f	f	2026-07-19 00:51:43.850416+00
671	93	15	t	f	2026-07-19 00:51:44.320264+00
672	139	22	f	f	2026-07-19 00:51:48.649083+00
673	138	19	f	f	2026-07-19 00:51:53.715787+00
674	134	6	f	f	2026-07-19 00:51:57.86401+00
675	80	21	f	f	2026-07-19 00:52:00.578801+00
676	80	21	f	f	2026-07-19 00:52:05.115725+00
677	95	2	t	f	2026-07-19 00:52:07.571893+00
678	134	21	f	f	2026-07-19 00:52:10.071257+00
679	125	8	t	f	2026-07-19 00:52:15.384304+00
680	144	17	t	f	2026-07-19 00:52:22.815969+00
681	76	22	t	f	2026-07-19 00:52:24.559497+00
682	30	7	t	f	2026-07-19 00:52:25.739294+00
683	121	22	f	f	2026-07-19 00:52:28.015272+00
684	81	8	t	f	2026-07-19 00:52:33.694333+00
685	121	22	f	f	2026-07-19 00:52:40.719789+00
686	54	5	f	f	2026-07-19 00:52:41.500448+00
687	18	2	t	f	2026-07-19 00:52:44.567489+00
688	136	21	f	f	2026-07-19 00:52:44.972943+00
689	48	21	f	f	2026-07-19 00:52:47.780072+00
690	48	21	f	f	2026-07-19 00:52:51.755997+00
691	136	21	f	f	2026-07-19 00:52:52.350192+00
692	48	21	f	f	2026-07-19 00:52:58.860133+00
693	60	7	t	f	2026-07-19 00:52:59.058739+00
694	48	21	f	f	2026-07-19 00:53:04.264474+00
698	48	21	f	f	2026-07-19 00:53:19.88432+00
707	92	13	f	f	2026-07-19 00:53:45.084671+00
709	32	21	t	f	2026-07-19 00:53:55.685091+00
710	35	22	f	f	2026-07-19 00:53:58.349954+00
712	51	5	f	f	2026-07-19 00:53:59.193444+00
732	116	21	f	f	2026-07-19 00:55:18.716415+00
736	87	15	t	f	2026-07-19 00:55:26.855359+00
738	116	21	f	f	2026-07-19 00:55:33.470151+00
739	77	1	t	f	2026-07-19 00:55:34.908489+00
740	136	21	f	f	2026-07-19 00:55:37.771237+00
743	21	24	f	f	2026-07-19 00:55:51.759233+00
744	62	14	f	f	2026-07-19 00:55:53.189727+00
745	80	21	f	f	2026-07-19 00:55:53.608031+00
748	128	20	t	f	2026-07-19 00:55:56.581209+00
1373	21	18	f	f	2026-07-19 01:35:40.115935+00
1389	92	14	f	f	2026-07-19 01:37:06.343+00
1392	129	17	t	f	2026-07-19 01:37:22.750323+00
1393	111	19	f	f	2026-07-19 01:37:35.585485+00
1394	65	25	t	f	2026-07-19 01:37:37.570603+00
1396	128	21	f	f	2026-07-19 01:37:37.985387+00
1410	18	16	t	f	2026-07-19 01:38:13.912184+00
1411	24	21	f	f	2026-07-19 01:38:16.928669+00
1419	57	21	f	f	2026-07-19 01:39:18.809683+00
1422	57	21	f	f	2026-07-19 01:39:36.577208+00
1425	95	23	t	f	2026-07-19 01:39:58.647792+00
1428	89	14	f	f	2026-07-19 01:40:03.143887+00
1430	125	24	f	f	2026-07-19 01:40:10.374587+00
1431	101	21	f	f	2026-07-19 01:40:11.517745+00
1434	133	18	f	f	2026-07-19 01:40:29.756253+00
1436	57	21	f	f	2026-07-19 01:40:35.786646+00
1437	133	18	f	f	2026-07-19 01:40:40.721513+00
1439	103	15	f	f	2026-07-19 01:40:44.067739+00
1442	95	24	f	f	2026-07-19 01:40:56.336951+00
1443	24	21	f	f	2026-07-19 01:41:00.389824+00
1444	77	26	f	f	2026-07-19 01:41:04.559385+00
1449	80	25	t	f	2026-07-19 01:41:36.416004+00
1461	67	12	t	f	2026-07-19 01:42:29.934149+00
1462	104	2	t	f	2026-07-19 01:42:39.523383+00
1469	85	21	f	f	2026-07-19 01:42:54.544248+00
1470	18	12	t	t	2026-07-19 01:42:55.097688+00
1479	80	27	f	f	2026-07-19 01:43:26.71317+00
1487	125	5	t	f	2026-07-19 01:43:58.514139+00
1896	92	19	f	f	2026-07-19 02:18:03.353118+00
1897	133	24	f	f	2026-07-19 02:18:03.397349+00
1898	92	19	f	f	2026-07-19 02:18:04.33798+00
1900	92	19	f	f	2026-07-19 02:18:05.340224+00
1902	25	25	f	f	2026-07-19 02:18:14.221108+00
1903	41	14	f	f	2026-07-19 02:18:28.666326+00
1904	95	26	f	f	2026-07-19 02:18:30.481103+00
1917	51	22	f	f	2026-07-19 02:19:15.373383+00
1922	4	24	f	f	2026-07-19 02:19:51.343829+00
1944	88	21	f	f	2026-07-19 02:22:57.333988+00
1948	92	19	t	f	2026-07-19 02:23:10.21679+00
1949	38	24	f	f	2026-07-19 02:23:10.637354+00
1950	45	21	f	f	2026-07-19 02:23:12.149879+00
1951	45	21	f	f	2026-07-19 02:23:16.843646+00
1952	41	14	f	f	2026-07-19 02:23:19.187629+00
1959	45	21	f	f	2026-07-19 02:23:38.314061+00
1963	45	21	f	f	2026-07-19 02:23:44.52538+00
1964	32	22	f	f	2026-07-19 02:23:48.018776+00
1967	125	25	t	f	2026-07-19 02:23:59.142593+00
1968	131	21	f	f	2026-07-19 02:24:03.366892+00
1969	84	14	f	f	2026-07-19 02:24:05.327304+00
1970	80	14	f	f	2026-07-19 02:24:05.519382+00
1971	131	21	f	f	2026-07-19 02:24:07.92298+00
1972	80	14	f	f	2026-07-19 02:24:11.295613+00
1977	95	26	f	f	2026-07-19 02:24:41.94953+00
1980	69	27	f	f	2026-07-19 02:25:10.882668+00
1981	69	27	f	f	2026-07-19 02:25:13.426944+00
1985	85	25	f	f	2026-07-19 02:25:49.054947+00
1986	104	21	f	f	2026-07-19 02:26:02.829481+00
1991	4	25	t	f	2026-07-19 02:26:39.038111+00
2004	125	26	t	f	2026-07-19 02:27:25.89386+00
2014	32	22	f	f	2026-07-19 02:28:12.279067+00
2021	67	22	f	f	2026-07-19 02:28:38.361127+00
2025	16	14	f	f	2026-07-19 02:28:54.813725+00
2465	24	24	f	f	2026-07-19 03:21:26.958997+00
2467	24	24	f	f	2026-07-19 03:21:35.680786+00
2469	27	16	t	f	2026-07-19 03:21:44.276223+00
2472	101	27	f	f	2026-07-19 03:22:04.615404+00
2473	124	6	f	f	2026-07-19 03:22:09.874382+00
2474	124	6	f	f	2026-07-19 03:22:10.99642+00
2476	38	25	t	f	2026-07-19 03:22:37.890596+00
2479	41	2	t	f	2026-07-19 03:23:32.521099+00
2480	24	24	f	f	2026-07-19 03:23:33.278795+00
2930	107	19	f	f	2026-07-19 04:29:16.378388+00
2931	107	19	f	f	2026-07-19 04:29:21.64094+00
2940	18	19	f	f	2026-07-19 04:30:52.318603+00
2956	23	1	t	f	2026-07-19 04:34:02.574289+00
2957	13	19	f	f	2026-07-19 04:34:14.520059+00
2958	13	19	f	f	2026-07-19 04:34:17.860151+00
2959	18	19	f	f	2026-07-19 04:34:19.723675+00
2973	94	19	f	f	2026-07-19 04:35:49.398372+00
2974	34	16	t	f	2026-07-19 04:35:49.615215+00
2995	11	15	t	f	2026-07-19 04:38:05.918878+00
2996	69	19	f	f	2026-07-19 04:38:12.449534+00
3005	27	22	f	f	2026-07-19 04:39:24.04917+00
3012	51	18	f	f	2026-07-19 04:40:53.549718+00
3013	119	19	f	f	2026-07-19 04:41:14.388438+00
3015	65	26	f	f	2026-07-19 04:41:16.762014+00
3019	106	19	f	f	2026-07-19 04:42:02.410829+00
3020	130	6	f	f	2026-07-19 04:42:05.223124+00
3022	106	19	f	f	2026-07-19 04:42:07.207292+00
3024	154	19	f	f	2026-07-19 04:42:22.9566+00
3025	103	4	f	f	2026-07-19 04:42:23.10886+00
3054	129	22	f	f	2026-07-19 04:47:31.660404+00
3055	148	19	f	f	2026-07-19 04:47:49.360387+00
3057	27	22	f	f	2026-07-19 04:48:04.140327+00
3062	148	19	f	f	2026-07-19 04:48:19.66107+00
3064	71	22	f	f	2026-07-19 04:48:47.155332+00
3065	75	22	f	f	2026-07-19 04:49:20.369364+00
3066	66	14	f	f	2026-07-19 04:49:29.849023+00
3070	129	22	f	f	2026-07-19 04:50:50.247701+00
3071	51	22	f	f	2026-07-19 04:50:56.880616+00
3072	51	22	f	f	2026-07-19 04:51:02.978048+00
3075	13	19	f	f	2026-07-19 04:51:17.046743+00
3077	13	19	f	f	2026-07-19 04:51:36.272075+00
3080	147	13	t	f	2026-07-19 04:52:12.796317+00
3081	152	26	f	f	2026-07-19 04:52:32.053393+00
695	48	21	f	f	2026-07-19 00:53:12.443234+00
696	31	19	f	f	2026-07-19 00:53:15.150503+00
699	139	22	t	f	2026-07-19 00:53:21.524643+00
701	29	15	t	f	2026-07-19 00:53:25.720219+00
702	21	24	f	f	2026-07-19 00:53:27.636323+00
703	48	21	f	f	2026-07-19 00:53:28.860429+00
708	50	21	f	f	2026-07-19 00:53:48.281524+00
711	116	21	f	f	2026-07-19 00:53:58.948571+00
717	19	21	f	f	2026-07-19 00:54:37.389997+00
718	25	21	f	f	2026-07-19 00:54:41.63039+00
719	19	21	f	f	2026-07-19 00:54:42.043591+00
720	19	21	f	f	2026-07-19 00:54:43.443553+00
721	69	21	f	f	2026-07-19 00:54:47.349558+00
722	112	19	f	f	2026-07-19 00:54:49.711072+00
723	104	21	f	f	2026-07-19 00:54:58.808809+00
727	116	21	f	f	2026-07-19 00:55:09.441134+00
729	76	23	t	f	2026-07-19 00:55:13.292505+00
730	65	22	t	f	2026-07-19 00:55:14.528542+00
731	112	19	f	f	2026-07-19 00:55:17.879955+00
733	8	4	f	f	2026-07-19 00:55:18.85749+00
734	136	21	f	f	2026-07-19 00:55:20.292876+00
737	27	19	f	f	2026-07-19 00:55:27.533988+00
750	144	6	t	f	2026-07-19 00:55:57.773364+00
1374	21	18	f	f	2026-07-19 01:35:48.92626+00
1382	85	14	f	f	2026-07-19 01:36:21.763182+00
1383	60	24	f	f	2026-07-19 01:36:23.011668+00
1424	46	14	f	f	2026-07-19 01:39:52.489025+00
1435	44	21	f	f	2026-07-19 01:40:33.49674+00
1445	126	24	f	f	2026-07-19 01:41:11.165764+00
1446	15	10	t	f	2026-07-19 01:41:14.86741+00
1450	57	21	f	f	2026-07-19 01:41:38.947084+00
1452	136	21	f	f	2026-07-19 01:41:52.00666+00
1453	144	14	f	f	2026-07-19 01:41:53.815844+00
1458	77	26	t	f	2026-07-19 01:42:11.070896+00
1899	133	24	f	f	2026-07-19 02:18:05.322798+00
1906	25	25	f	f	2026-07-19 02:18:34.927948+00
1907	41	14	f	f	2026-07-19 02:18:38.848349+00
1915	95	26	f	f	2026-07-19 02:19:13.416388+00
1916	95	26	f	f	2026-07-19 02:19:14.677497+00
1920	4	24	f	f	2026-07-19 02:19:34.419683+00
1923	4	24	t	f	2026-07-19 02:20:06.224601+00
1932	145	14	t	f	2026-07-19 02:21:58.830014+00
1934	88	21	f	f	2026-07-19 02:22:15.509457+00
1935	88	21	f	f	2026-07-19 02:22:18.594842+00
1937	44	21	f	f	2026-07-19 02:22:25.485323+00
1945	88	21	f	f	2026-07-19 02:23:00.022065+00
1946	88	21	f	f	2026-07-19 02:23:03.560914+00
1947	88	21	f	f	2026-07-19 02:23:07.273143+00
1955	32	22	f	f	2026-07-19 02:23:29.039409+00
1956	45	21	f	f	2026-07-19 02:23:29.257473+00
1957	45	21	f	f	2026-07-19 02:23:33.666907+00
1958	38	19	f	f	2026-07-19 02:23:35.240652+00
1973	95	26	f	f	2026-07-19 02:24:13.057125+00
1974	4	14	f	f	2026-07-19 02:24:15.033248+00
1978	25	25	f	f	2026-07-19 02:25:00.956923+00
1979	133	24	t	f	2026-07-19 02:25:09.769507+00
1982	103	21	f	f	2026-07-19 02:25:22.308111+00
1983	21	9	t	t	2026-07-19 02:25:24.462395+00
1989	71	11	t	f	2026-07-19 02:26:32.694071+00
1992	54	20	f	f	2026-07-19 02:26:53.105125+00
1993	54	20	t	f	2026-07-19 02:27:06.037664+00
1994	131	19	f	f	2026-07-19 02:27:10.069713+00
1996	131	19	f	f	2026-07-19 02:27:13.527141+00
1998	131	19	f	f	2026-07-19 02:27:14.367667+00
2000	131	19	f	f	2026-07-19 02:27:15.215208+00
2001	131	19	f	f	2026-07-19 02:27:15.593843+00
2005	95	14	f	f	2026-07-19 02:27:54.405478+00
2010	25	26	t	f	2026-07-19 02:28:05.72684+00
2013	32	22	f	f	2026-07-19 02:28:09.779217+00
2034	21	19	f	f	2026-07-19 02:29:30.627813+00
2035	121	22	f	f	2026-07-19 02:29:30.676549+00
2477	24	24	f	f	2026-07-19 03:23:17.036542+00
2481	24	24	f	f	2026-07-19 03:23:36.322241+00
2483	152	14	f	f	2026-07-19 03:23:45.373867+00
2486	65	26	f	f	2026-07-19 03:24:16.882275+00
2488	100	16	f	f	2026-07-19 03:24:31.517559+00
2492	121	23	t	f	2026-07-19 03:24:52.31086+00
2493	38	16	t	f	2026-07-19 03:25:02.486103+00
2494	44	24	f	f	2026-07-19 03:25:03.2042+00
2502	94	19	f	f	2026-07-19 03:26:42.672608+00
2503	94	19	f	f	2026-07-19 03:26:46.372318+00
2509	73	22	f	f	2026-07-19 03:26:58.184379+00
2513	73	22	f	f	2026-07-19 03:27:18.316116+00
2514	73	22	f	f	2026-07-19 03:27:21.173699+00
2515	75	22	f	f	2026-07-19 03:27:35.831754+00
2516	75	22	f	f	2026-07-19 03:27:39.129556+00
2942	53	27	f	f	2026-07-19 04:31:05.904065+00
2943	54	14	f	f	2026-07-19 04:31:22.345907+00
2944	149	7	f	f	2026-07-19 04:31:30.686563+00
2945	149	7	f	f	2026-07-19 04:31:35.996788+00
2946	149	7	f	f	2026-07-19 04:31:47.647069+00
2947	44	26	t	f	2026-07-19 04:31:49.757169+00
2953	94	19	f	f	2026-07-19 04:32:47.475862+00
2954	94	19	f	f	2026-07-19 04:32:54.033915+00
2976	148	10	t	f	2026-07-19 04:36:16.864472+00
2977	149	7	t	f	2026-07-19 04:36:17.407082+00
3340	62	26	f	f	2026-07-19 05:44:09.616147+00
3341	5	22	f	f	2026-07-19 05:44:13.138797+00
3349	94	19	f	f	2026-07-19 05:45:27.203466+00
3354	8	22	f	f	2026-07-19 05:45:48.05719+00
3356	94	19	f	f	2026-07-19 05:45:52.369766+00
3357	155	6	f	f	2026-07-19 05:45:56.562707+00
3364	149	14	t	f	2026-07-19 05:47:02.034065+00
3366	133	27	f	f	2026-07-19 05:48:31.239008+00
3368	5	22	f	f	2026-07-19 05:49:34.522915+00
3369	39	26	f	f	2026-07-19 05:49:41.711111+00
3371	18	19	f	f	2026-07-19 05:50:10.428223+00
3374	147	27	f	f	2026-07-19 05:51:18.688409+00
3376	18	19	f	f	2026-07-19 05:51:24.721616+00
3377	18	19	f	f	2026-07-19 05:51:30.428309+00
3425	92	18	f	f	2026-07-19 06:01:18.2088+00
3426	45	6	f	f	2026-07-19 06:01:51.714303+00
3428	109	21	f	f	2026-07-19 06:02:33.972932+00
3430	115	14	f	f	2026-07-19 06:03:25.223684+00
3431	115	14	f	f	2026-07-19 06:03:32.118038+00
3432	115	14	f	f	2026-07-19 06:03:36.455339+00
3441	32	22	f	f	2026-07-19 06:04:33.233667+00
3442	18	19	f	f	2026-07-19 06:04:37.020284+00
3451	154	21	f	f	2026-07-19 06:05:52.780354+00
3459	32	22	f	f	2026-07-19 06:07:22.76914+00
697	48	21	f	f	2026-07-19 00:53:16.257325+00
700	48	21	f	f	2026-07-19 00:53:25.301182+00
713	71	21	f	f	2026-07-19 00:54:00.721778+00
714	46	21	f	f	2026-07-19 00:54:02.927383+00
715	35	22	f	f	2026-07-19 00:54:20.069164+00
724	121	22	f	f	2026-07-19 00:55:04.072934+00
725	144	7	t	f	2026-07-19 00:55:08.187139+00
726	104	15	t	f	2026-07-19 00:55:08.641037+00
728	19	11	t	f	2026-07-19 00:55:12.408782+00
735	116	21	f	f	2026-07-19 00:55:24.935758+00
741	26	2	t	f	2026-07-19 00:55:41.277904+00
742	109	5	f	f	2026-07-19 00:55:45.471983+00
746	18	19	f	f	2026-07-19 00:55:54.664625+00
1375	119	24	t	f	2026-07-19 01:35:51.625836+00
1376	25	24	f	f	2026-07-19 01:36:01.120683+00
1378	80	26	t	f	2026-07-19 01:36:07.999861+00
1385	7	14	f	f	2026-07-19 01:36:30.571695+00
1399	60	24	f	f	2026-07-19 01:37:48.755241+00
1402	79	22	t	f	2026-07-19 01:37:58.916977+00
1406	62	21	f	f	2026-07-19 01:38:08.413883+00
1412	51	21	f	f	2026-07-19 01:38:21.040975+00
1416	103	21	f	f	2026-07-19 01:38:47.665239+00
1420	95	22	t	f	2026-07-19 01:39:30.55497+00
1426	127	21	f	f	2026-07-19 01:40:00.844129+00
1427	89	14	f	f	2026-07-19 01:40:01.431258+00
1429	103	21	f	f	2026-07-19 01:40:06.089789+00
1432	103	21	f	f	2026-07-19 01:40:16.328654+00
1433	57	21	f	f	2026-07-19 01:40:27.13193+00
1438	8	4	f	f	2026-07-19 01:40:42.025548+00
1440	133	5	f	f	2026-07-19 01:40:46.264449+00
1441	8	4	f	f	2026-07-19 01:40:47.247474+00
1451	111	19	f	f	2026-07-19 01:41:40.556055+00
1454	134	14	f	f	2026-07-19 01:41:56.518923+00
1456	89	23	t	f	2026-07-19 01:42:02.616482+00
1463	44	21	f	f	2026-07-19 01:42:41.631677+00
1464	89	14	f	f	2026-07-19 01:42:44.884148+00
1465	144	21	f	f	2026-07-19 01:42:47.813425+00
1466	44	21	f	f	2026-07-19 01:42:51.640538+00
1467	85	21	f	f	2026-07-19 01:42:51.874939+00
1468	26	22	f	f	2026-07-19 01:42:53.167501+00
1489	92	14	f	f	2026-07-19 01:44:13.070942+00
1490	125	24	f	f	2026-07-19 01:44:14.40407+00
2036	119	5	f	f	2026-07-19 02:29:49.82107+00
2038	84	14	f	f	2026-07-19 02:29:55.690423+00
2041	119	5	f	f	2026-07-19 02:30:06.26126+00
2042	54	21	f	f	2026-07-19 02:30:09.50017+00
2045	32	22	f	f	2026-07-19 02:30:17.156448+00
2046	32	22	f	f	2026-07-19 02:30:24.475126+00
2047	54	21	f	f	2026-07-19 02:30:27.893226+00
2049	46	26	f	f	2026-07-19 02:30:30.953341+00
2060	69	13	t	f	2026-07-19 02:31:17.124309+00
2065	32	22	f	f	2026-07-19 02:31:38.004645+00
2066	16	14	f	f	2026-07-19 02:31:48.636556+00
2071	47	14	t	f	2026-07-19 02:32:01.349617+00
2083	11	26	t	f	2026-07-19 02:33:46.330241+00
2084	149	21	f	f	2026-07-19 02:33:58.319571+00
2089	105	27	f	f	2026-07-19 02:34:22.625424+00
2092	105	27	f	f	2026-07-19 02:34:25.019482+00
2093	149	21	f	f	2026-07-19 02:34:30.252642+00
2097	149	21	f	f	2026-07-19 02:34:47.356564+00
2098	34	13	f	f	2026-07-19 02:34:48.532073+00
2100	34	14	f	f	2026-07-19 02:34:51.901499+00
2101	34	22	f	f	2026-07-19 02:34:54.694591+00
2102	119	26	f	f	2026-07-19 02:34:55.575728+00
2103	149	21	f	f	2026-07-19 02:35:01.247265+00
2112	105	27	f	f	2026-07-19 02:35:56.047123+00
2113	145	21	f	f	2026-07-19 02:35:56.540061+00
2114	34	14	t	f	2026-07-19 02:35:57.423193+00
2115	148	21	f	f	2026-07-19 02:36:10.848208+00
2116	148	21	f	f	2026-07-19 02:36:31.691519+00
2119	148	21	f	f	2026-07-19 02:36:51.76837+00
2122	66	11	t	f	2026-07-19 02:36:57.497493+00
2123	145	21	f	f	2026-07-19 02:37:03.671394+00
2124	115	19	f	f	2026-07-19 02:37:08.264929+00
2129	105	27	f	f	2026-07-19 02:37:30.684044+00
2130	125	27	t	f	2026-07-19 02:37:53.408307+00
2131	139	14	t	f	2026-07-19 02:38:06.844597+00
2132	148	14	f	f	2026-07-19 02:38:07.631546+00
2133	115	19	f	f	2026-07-19 02:38:07.815405+00
2151	119	19	f	f	2026-07-19 02:39:50.807461+00
2152	4	19	f	f	2026-07-19 02:39:55.337248+00
2154	129	21	f	f	2026-07-19 02:40:04.397153+00
2160	25	27	f	f	2026-07-19 02:40:32.069658+00
2161	145	18	t	f	2026-07-19 02:40:33.13344+00
2162	27	8	t	f	2026-07-19 02:40:36.228529+00
2163	25	27	f	f	2026-07-19 02:40:36.96496+00
2164	25	27	f	f	2026-07-19 02:40:41.969838+00
2165	18	19	f	f	2026-07-19 02:40:55.308683+00
2166	25	27	t	f	2026-07-19 02:40:56.151696+00
2167	84	14	f	f	2026-07-19 02:41:15.829835+00
2168	84	14	f	f	2026-07-19 02:41:24.202775+00
2172	64	1	t	f	2026-07-19 02:41:45.474486+00
2484	15	9	t	f	2026-07-19 03:24:01.616275+00
2489	73	22	f	f	2026-07-19 03:24:38.818107+00
2490	101	27	f	f	2026-07-19 03:24:40.814707+00
2491	101	27	t	f	2026-07-19 03:24:42.972648+00
2496	44	24	f	f	2026-07-19 03:25:16.402908+00
2498	152	14	f	f	2026-07-19 03:25:58.216298+00
2499	44	24	f	f	2026-07-19 03:26:22.515186+00
2500	73	22	f	f	2026-07-19 03:26:35.148898+00
2507	75	22	f	f	2026-07-19 03:26:53.210383+00
2520	75	22	f	f	2026-07-19 03:27:59.749712+00
2523	75	22	f	f	2026-07-19 03:28:16.68624+00
2948	149	5	f	f	2026-07-19 04:31:58.605605+00
2949	75	22	f	f	2026-07-19 04:32:06.634742+00
2950	66	14	f	f	2026-07-19 04:32:10.202556+00
2951	86	19	t	f	2026-07-19 04:32:12.841621+00
2955	87	27	f	f	2026-07-19 04:33:27.892944+00
2960	22	9	t	f	2026-07-19 04:34:35.58861+00
2963	53	27	t	f	2026-07-19 04:35:04.611233+00
2964	109	21	f	f	2026-07-19 04:35:05.850861+00
2968	152	26	f	f	2026-07-19 04:35:30.575187+00
2969	124	22	f	f	2026-07-19 04:35:31.401558+00
2971	94	19	f	f	2026-07-19 04:35:38.138637+00
2972	65	26	f	f	2026-07-19 04:35:48.145892+00
2978	137	22	f	f	2026-07-19 04:36:21.781094+00
2980	78	22	f	f	2026-07-19 04:36:42.201011+00
2983	101	19	f	f	2026-07-19 04:37:03.698279+00
2987	149	14	f	f	2026-07-19 04:37:12.713701+00
2993	72	19	f	f	2026-07-19 04:37:44.886294+00
704	76	2	t	f	2026-07-19 00:53:34.388799+00
705	139	23	t	f	2026-07-19 00:53:35.084794+00
706	105	21	f	f	2026-07-19 00:53:35.449127+00
716	80	21	f	f	2026-07-19 00:54:29.635608+00
747	62	21	f	f	2026-07-19 00:55:56.450835+00
749	21	24	f	f	2026-07-19 00:55:57.716645+00
751	51	15	t	f	2026-07-19 00:56:03.884545+00
752	93	8	t	f	2026-07-19 00:56:08.804902+00
753	126	16	t	f	2026-07-19 00:56:23.191275+00
754	125	1	t	f	2026-07-19 00:56:24.449647+00
755	35	22	f	f	2026-07-19 00:56:26.986846+00
756	19	21	f	f	2026-07-19 00:56:30.917041+00
757	136	21	f	f	2026-07-19 00:56:38.447843+00
758	136	21	f	f	2026-07-19 00:56:50.584059+00
759	25	21	f	f	2026-07-19 00:57:08.262003+00
760	136	21	f	f	2026-07-19 00:57:10.300753+00
761	46	5	f	f	2026-07-19 00:57:14.678817+00
762	136	21	f	f	2026-07-19 00:57:15.021349+00
763	18	19	f	f	2026-07-19 00:57:16.844975+00
764	119	2	t	f	2026-07-19 00:57:17.90595+00
765	46	5	f	f	2026-07-19 00:57:19.224397+00
766	44	20	t	f	2026-07-19 00:57:19.351033+00
767	69	7	t	f	2026-07-19 00:57:31.335443+00
768	81	24	f	f	2026-07-19 00:57:44.335662+00
769	80	21	f	f	2026-07-19 00:57:44.796098+00
770	13	16	f	f	2026-07-19 00:57:47.729864+00
771	71	21	f	f	2026-07-19 00:57:52.692084+00
772	126	4	f	f	2026-07-19 00:57:53.68224+00
773	25	21	f	f	2026-07-19 00:58:01.441514+00
774	85	15	t	f	2026-07-19 00:58:06.200083+00
775	17	19	f	f	2026-07-19 00:58:08.03832+00
776	62	14	t	t	2026-07-19 00:58:12.344125+00
777	139	24	f	f	2026-07-19 00:58:16.503843+00
778	69	2	t	f	2026-07-19 00:58:28.926945+00
779	69	6	t	f	2026-07-19 00:58:43.052958+00
780	92	14	f	f	2026-07-19 00:58:46.328954+00
781	7	14	f	f	2026-07-19 00:58:51.90013+00
782	7	14	f	f	2026-07-19 00:58:55.577362+00
783	76	24	t	f	2026-07-19 00:58:58.158862+00
784	92	14	f	f	2026-07-19 00:59:00.172224+00
785	125	13	t	f	2026-07-19 00:59:04.291116+00
786	69	1	t	f	2026-07-19 00:59:05.784405+00
787	68	6	f	f	2026-07-19 00:59:07.912348+00
788	32	22	f	f	2026-07-19 00:59:10.299391+00
789	32	22	f	f	2026-07-19 00:59:14.439535+00
790	46	21	t	f	2026-07-19 00:59:15.64121+00
791	32	22	f	f	2026-07-19 00:59:17.512182+00
792	32	22	f	f	2026-07-19 00:59:20.083254+00
793	19	21	f	f	2026-07-19 00:59:20.906886+00
794	17	19	f	f	2026-07-19 00:59:24.972902+00
795	21	24	f	f	2026-07-19 00:59:27.026355+00
796	17	19	t	f	2026-07-19 00:59:28.897887+00
797	18	19	f	f	2026-07-19 00:59:34.953767+00
798	65	23	f	f	2026-07-19 00:59:37.096806+00
799	112	11	t	f	2026-07-19 00:59:40.374777+00
800	68	6	f	f	2026-07-19 00:59:40.840929+00
801	12	8	t	f	2026-07-19 00:59:49.448351+00
802	68	6	f	f	2026-07-19 00:59:51.40001+00
803	50	21	f	f	2026-07-19 00:59:53.544658+00
804	72	15	t	f	2026-07-19 00:59:56.23176+00
805	106	7	t	f	2026-07-19 01:00:08.894047+00
806	18	19	f	f	2026-07-19 01:00:11.166576+00
807	21	24	t	f	2026-07-19 01:00:12.914969+00
808	139	24	f	f	2026-07-19 01:00:15.449543+00
809	9	15	t	f	2026-07-19 01:00:15.556546+00
810	138	8	t	f	2026-07-19 01:00:17.32095+00
811	119	21	f	f	2026-07-19 01:00:22.203912+00
812	32	22	f	f	2026-07-19 01:00:26.571966+00
813	32	22	f	f	2026-07-19 01:00:30.078262+00
814	111	15	t	f	2026-07-19 01:00:30.734458+00
815	32	22	f	f	2026-07-19 01:00:33.891034+00
816	32	22	f	f	2026-07-19 01:00:38.299903+00
817	32	22	f	f	2026-07-19 01:00:41.611317+00
818	25	21	t	f	2026-07-19 01:00:45.042739+00
819	18	19	f	f	2026-07-19 01:00:46.500544+00
820	19	21	f	f	2026-07-19 01:00:48.86863+00
821	48	5	f	f	2026-07-19 01:00:51.001924+00
822	19	21	f	f	2026-07-19 01:00:53.208692+00
823	34	17	t	f	2026-07-19 01:00:55.36701+00
824	133	21	f	f	2026-07-19 01:00:55.641403+00
825	19	21	f	f	2026-07-19 01:00:57.853957+00
826	38	8	t	f	2026-07-19 01:00:58.497474+00
827	19	21	f	f	2026-07-19 01:01:01.064697+00
828	19	21	f	f	2026-07-19 01:01:04.476384+00
829	19	21	f	f	2026-07-19 01:01:12.75399+00
830	11	7	t	f	2026-07-19 01:01:12.935414+00
831	65	23	t	f	2026-07-19 01:01:16.206243+00
832	19	21	f	f	2026-07-19 01:01:17.170048+00
833	19	21	f	f	2026-07-19 01:01:21.14273+00
834	131	20	f	f	2026-07-19 01:01:21.574033+00
835	19	21	f	f	2026-07-19 01:01:23.736104+00
836	19	21	f	f	2026-07-19 01:01:27.392522+00
837	111	22	t	f	2026-07-19 01:01:29.968829+00
838	139	24	t	f	2026-07-19 01:01:31.647812+00
839	91	20	t	f	2026-07-19 01:01:31.763171+00
840	131	20	t	f	2026-07-19 01:01:32.683343+00
841	54	8	t	f	2026-07-19 01:01:33.135662+00
842	68	6	t	f	2026-07-19 01:01:35.748494+00
843	35	22	f	f	2026-07-19 01:01:42.730161+00
844	35	22	f	f	2026-07-19 01:01:45.762312+00
845	111	23	t	f	2026-07-19 01:01:57.813132+00
846	44	21	f	f	2026-07-19 01:02:00.103327+00
847	44	21	f	f	2026-07-19 01:02:02.404271+00
848	67	15	t	f	2026-07-19 01:02:08.497034+00
849	44	21	f	f	2026-07-19 01:02:13.833451+00
850	4	2	t	f	2026-07-19 01:02:13.931065+00
851	69	21	f	f	2026-07-19 01:02:15.009681+00
852	117	8	t	f	2026-07-19 01:02:17.371062+00
853	60	6	t	f	2026-07-19 01:02:19.811315+00
854	69	21	f	f	2026-07-19 01:02:22.437626+00
855	4	20	t	f	2026-07-19 01:02:33.178986+00
856	128	21	f	f	2026-07-19 01:02:39.63138+00
857	71	21	f	f	2026-07-19 01:02:46.703359+00
858	128	21	f	f	2026-07-19 01:02:49.000284+00
859	101	11	t	f	2026-07-19 01:02:51.091257+00
860	128	21	f	f	2026-07-19 01:02:58.927051+00
861	69	21	f	f	2026-07-19 01:03:01.723295+00
862	69	21	f	f	2026-07-19 01:03:07.51503+00
863	116	21	f	f	2026-07-19 01:03:08.197586+00
864	116	21	f	f	2026-07-19 01:03:14.455506+00
865	71	21	f	f	2026-07-19 01:03:17.606139+00
866	101	1	t	f	2026-07-19 01:03:18.059949+00
871	44	21	f	f	2026-07-19 01:03:40.996619+00
876	18	19	f	f	2026-07-19 01:03:58.822644+00
877	29	6	f	f	2026-07-19 01:04:04.520637+00
925	128	21	f	f	2026-07-19 01:06:18.848525+00
927	18	19	f	f	2026-07-19 01:06:24.403507+00
928	128	21	f	f	2026-07-19 01:06:26.445051+00
932	37	19	f	f	2026-07-19 01:06:44.814623+00
933	35	22	f	f	2026-07-19 01:06:47.2741+00
935	38	14	f	f	2026-07-19 01:07:03.931105+00
937	139	27	f	f	2026-07-19 01:07:09.112399+00
1390	111	19	f	f	2026-07-19 01:37:06.744398+00
1391	94	24	f	f	2026-07-19 01:37:19.232872+00
1395	44	21	f	f	2026-07-19 01:37:37.667799+00
1403	62	21	f	f	2026-07-19 01:38:02.146255+00
1404	128	21	f	f	2026-07-19 01:38:02.240783+00
1407	128	21	f	f	2026-07-19 01:38:10.401412+00
1408	82	21	t	f	2026-07-19 01:38:10.900804+00
1409	89	14	f	f	2026-07-19 01:38:12.543696+00
1423	125	24	f	f	2026-07-19 01:39:39.549846+00
1471	44	21	f	f	2026-07-19 01:42:55.19324+00
1472	81	25	t	f	2026-07-19 01:42:56.104294+00
1473	89	14	f	f	2026-07-19 01:42:56.15209+00
1474	110	12	t	f	2026-07-19 01:43:02.293274+00
1475	26	22	f	f	2026-07-19 01:43:03.459161+00
1476	65	26	f	f	2026-07-19 01:43:13.73216+00
1477	103	15	t	f	2026-07-19 01:43:21.446764+00
1481	24	21	f	f	2026-07-19 01:43:30.610698+00
1485	13	21	f	f	2026-07-19 01:43:52.963825+00
1486	77	25	t	f	2026-07-19 01:43:53.289743+00
1488	92	14	f	f	2026-07-19 01:44:00.348202+00
2037	119	5	f	f	2026-07-19 02:29:54.498744+00
2039	119	5	f	f	2026-07-19 02:30:03.475471+00
2040	54	21	f	f	2026-07-19 02:30:03.996294+00
2043	32	22	f	f	2026-07-19 02:30:12.155378+00
2044	119	5	f	f	2026-07-19 02:30:13.068626+00
2048	32	22	f	f	2026-07-19 02:30:29.086365+00
2050	54	21	f	f	2026-07-19 02:30:33.66703+00
2055	54	21	f	f	2026-07-19 02:30:43.53125+00
2058	16	14	f	f	2026-07-19 02:31:04.990825+00
2059	32	22	f	f	2026-07-19 02:31:10.880522+00
2070	16	14	f	f	2026-07-19 02:31:59.028685+00
2072	32	14	f	f	2026-07-19 02:32:06.482852+00
2085	147	12	t	f	2026-07-19 02:34:01.933528+00
2086	85	27	f	f	2026-07-19 02:34:02.805866+00
2088	103	21	f	f	2026-07-19 02:34:12.353236+00
2094	149	21	f	f	2026-07-19 02:34:38.201463+00
2095	94	27	f	f	2026-07-19 02:34:43.587938+00
2096	94	27	f	f	2026-07-19 02:34:46.250177+00
2485	44	24	f	f	2026-07-19 03:24:09.202864+00
2508	75	22	f	f	2026-07-19 03:26:57.587145+00
2512	152	14	t	f	2026-07-19 03:27:14.437201+00
2518	92	14	f	f	2026-07-19 03:27:55.004194+00
2519	81	14	f	f	2026-07-19 03:27:59.611316+00
2994	5	5	t	f	2026-07-19 04:37:46.588989+00
3006	89	16	t	f	2026-07-19 04:39:43.490626+00
3008	27	22	f	f	2026-07-19 04:40:00.265507+00
3009	27	22	f	f	2026-07-19 04:40:03.509439+00
3021	106	19	f	f	2026-07-19 04:42:05.410249+00
3023	130	7	f	f	2026-07-19 04:42:13.831109+00
3027	109	21	f	f	2026-07-19 04:42:31.499183+00
3029	154	19	f	f	2026-07-19 04:42:41.517376+00
3043	148	19	f	f	2026-07-19 04:45:22.85062+00
3061	27	22	f	f	2026-07-19 04:48:18.619278+00
3063	11	19	f	f	2026-07-19 04:48:46.885128+00
3073	53	5	f	f	2026-07-19 04:51:15.469979+00
3074	152	26	f	f	2026-07-19 04:51:15.776294+00
3079	6	8	t	f	2026-07-19 04:52:04.56227+00
3342	39	26	f	f	2026-07-19 05:44:14.638955+00
3348	92	18	f	f	2026-07-19 05:45:10.939796+00
3350	122	21	f	f	2026-07-19 05:45:28.203547+00
3351	51	26	t	f	2026-07-19 05:45:30.238224+00
3361	5	22	f	f	2026-07-19 05:46:42.824395+00
3372	18	19	f	f	2026-07-19 05:50:53.549453+00
3373	18	19	f	f	2026-07-19 05:50:55.416846+00
3382	122	21	f	f	2026-07-19 05:52:05.619475+00
3383	122	21	f	f	2026-07-19 05:52:07.305604+00
3397	145	12	t	f	2026-07-19 05:54:41.91834+00
3399	122	21	f	f	2026-07-19 05:54:51.738413+00
3400	122	21	f	f	2026-07-19 05:54:54.339127+00
3401	122	21	f	f	2026-07-19 05:54:59.131527+00
3402	62	27	f	f	2026-07-19 05:55:01.687041+00
3410	115	14	f	f	2026-07-19 05:58:38.195502+00
3414	115	14	f	f	2026-07-19 05:58:54.264181+00
3628	107	19	f	f	2026-07-19 06:41:30.356936+00
3629	40	2	t	f	2026-07-19 06:41:46.640841+00
3635	29	9	t	f	2026-07-19 06:43:26.813281+00
3640	32	22	f	f	2026-07-19 06:44:19.625225+00
3641	32	22	f	f	2026-07-19 06:44:22.294593+00
3656	115	22	f	f	2026-07-19 06:45:53.363628+00
3657	115	22	f	f	2026-07-19 06:45:56.616616+00
3659	115	22	f	f	2026-07-19 06:46:04.354075+00
3660	32	22	f	f	2026-07-19 06:46:04.556849+00
3661	115	22	f	f	2026-07-19 06:46:07.858391+00
3663	32	22	f	f	2026-07-19 06:46:09.122666+00
3666	115	22	f	f	2026-07-19 06:46:14.448191+00
3667	115	22	f	f	2026-07-19 06:46:17.749879+00
3678	78	27	f	f	2026-07-19 06:48:02.040741+00
3679	107	19	f	f	2026-07-19 06:49:04.608425+00
3680	24	5	f	f	2026-07-19 06:49:09.831354+00
3681	78	27	t	f	2026-07-19 06:49:15.032984+00
3684	107	19	f	f	2026-07-19 06:49:46.568836+00
3686	115	22	f	f	2026-07-19 06:50:13.261634+00
3688	107	19	f	f	2026-07-19 06:52:51.600436+00
3691	32	24	f	f	2026-07-19 06:53:10.95859+00
3692	32	24	f	f	2026-07-19 06:53:32.705093+00
3693	40	25	t	f	2026-07-19 06:53:35.319317+00
3694	107	19	f	f	2026-07-19 06:53:49.516841+00
3695	120	20	f	f	2026-07-19 06:53:51.174317+00
3714	40	26	t	f	2026-07-19 06:57:32.675432+00
3719	40	27	f	f	2026-07-19 06:59:03.319276+00
3720	115	22	f	f	2026-07-19 06:59:24.018004+00
3730	120	21	f	f	2026-07-19 07:01:12.98045+00
3733	121	4	f	f	2026-07-19 07:02:27.454117+00
3734	115	22	f	f	2026-07-19 07:02:28.436362+00
3772	115	24	f	f	2026-07-19 07:13:46.373893+00
3773	115	24	f	f	2026-07-19 07:13:48.091552+00
3775	8	22	f	f	2026-07-19 07:14:13.337582+00
3782	120	21	f	f	2026-07-19 07:16:23.083324+00
867	116	21	f	f	2026-07-19 01:03:21.212545+00
868	125	14	f	f	2026-07-19 01:03:23.038451+00
869	7	14	f	f	2026-07-19 01:03:27.321881+00
883	29	6	f	f	2026-07-19 01:04:12.942488+00
886	121	14	f	f	2026-07-19 01:04:22.5637+00
887	29	6	t	f	2026-07-19 01:04:25.108992+00
894	89	15	t	f	2026-07-19 01:04:41.653355+00
896	32	22	f	f	2026-07-19 01:04:49.480529+00
897	32	22	f	f	2026-07-19 01:04:53.500063+00
899	76	26	f	f	2026-07-19 01:04:59.435737+00
902	32	22	f	f	2026-07-19 01:05:04.1932+00
909	32	22	f	f	2026-07-19 01:05:19.632129+00
911	32	22	f	f	2026-07-19 01:05:21.818802+00
912	32	22	f	f	2026-07-19 01:05:24.970467+00
916	139	27	f	f	2026-07-19 01:05:37.555707+00
929	15	13	t	f	2026-07-19 01:06:42.188955+00
930	17	1	t	f	2026-07-19 01:06:42.859686+00
931	84	15	t	f	2026-07-19 01:06:44.02246+00
934	81	24	f	f	2026-07-19 01:06:52.835024+00
1413	125	24	f	f	2026-07-19 01:38:28.003742+00
1414	103	21	f	f	2026-07-19 01:38:33.064778+00
1415	65	13	t	f	2026-07-19 01:38:36.425519+00
1417	149	17	t	f	2026-07-19 01:38:58.857737+00
1418	125	24	f	f	2026-07-19 01:39:04.693004+00
1421	125	24	f	f	2026-07-19 01:39:31.080968+00
1447	136	21	f	f	2026-07-19 01:41:32.349988+00
1448	144	14	f	f	2026-07-19 01:41:34.228597+00
1455	111	19	t	f	2026-07-19 01:41:56.599745+00
1457	69	8	t	f	2026-07-19 01:42:07.109429+00
1459	101	21	f	f	2026-07-19 01:42:14.911691+00
1460	82	6	t	f	2026-07-19 01:42:17.45703+00
1478	46	14	f	f	2026-07-19 01:43:22.165303+00
1480	148	15	t	f	2026-07-19 01:43:28.059071+00
1482	80	27	f	f	2026-07-19 01:43:30.646952+00
1483	145	5	f	f	2026-07-19 01:43:33.240115+00
1484	121	4	f	f	2026-07-19 01:43:33.244496+00
2051	32	22	f	f	2026-07-19 02:30:35.816778+00
2052	47	14	f	f	2026-07-19 02:30:36.296127+00
2053	121	22	f	f	2026-07-19 02:30:36.489879+00
2054	84	14	f	f	2026-07-19 02:30:40.600075+00
2056	121	22	f	f	2026-07-19 02:30:44.904288+00
2057	115	16	t	f	2026-07-19 02:30:51.963344+00
2062	32	22	f	f	2026-07-19 02:31:26.978226+00
2069	125	27	f	f	2026-07-19 02:31:55.318384+00
2073	21	19	t	f	2026-07-19 02:32:16.235228+00
2074	84	14	f	f	2026-07-19 02:32:43.727035+00
2075	79	2	t	f	2026-07-19 02:32:50.63721+00
2076	32	22	f	f	2026-07-19 02:32:50.948737+00
2177	85	27	f	f	2026-07-19 02:42:22.643858+00
2185	133	12	t	f	2026-07-19 02:43:08.759233+00
2189	82	8	f	f	2026-07-19 02:43:56.954767+00
2487	8	4	f	f	2026-07-19 03:24:31.181366+00
2495	44	24	f	f	2026-07-19 03:25:05.334713+00
2497	44	24	f	f	2026-07-19 03:25:29.138613+00
2501	73	22	f	f	2026-07-19 03:26:39.172998+00
2504	73	22	f	f	2026-07-19 03:26:46.478524+00
2505	75	22	f	f	2026-07-19 03:26:47.424319+00
2506	73	22	f	f	2026-07-19 03:26:49.18536+00
2510	73	22	f	f	2026-07-19 03:27:01.604593+00
2511	73	22	f	f	2026-07-19 03:27:04.850647+00
2517	75	22	f	f	2026-07-19 03:27:42.527516+00
2522	75	22	f	f	2026-07-19 03:28:13.008101+00
3083	51	22	t	f	2026-07-19 04:52:42.376959+00
3370	98	21	f	f	2026-07-19 05:50:00.728528+00
3379	147	25	t	f	2026-07-19 05:51:39.32627+00
3384	122	21	f	f	2026-07-19 05:52:15.768336+00
3385	122	21	f	f	2026-07-19 05:52:22.83205+00
3386	122	21	f	f	2026-07-19 05:52:29.712478+00
3387	98	21	f	f	2026-07-19 05:52:37.651218+00
3389	122	21	f	f	2026-07-19 05:52:47.562074+00
3392	147	27	t	f	2026-07-19 05:53:58.259202+00
3408	18	19	f	f	2026-07-19 05:56:30.496336+00
3424	115	14	f	f	2026-07-19 06:01:16.762554+00
3465	155	6	f	f	2026-07-19 06:07:41.02117+00
3466	154	19	f	f	2026-07-19 06:07:50.413443+00
3467	154	19	f	f	2026-07-19 06:07:56.805803+00
3468	154	21	f	f	2026-07-19 06:08:15.524404+00
3470	44	15	t	f	2026-07-19 06:08:23.345314+00
3471	79	12	t	f	2026-07-19 06:08:25.467393+00
3476	109	21	f	f	2026-07-19 06:09:50.508055+00
3478	18	4	f	f	2026-07-19 06:10:48.908658+00
3480	32	22	f	f	2026-07-19 06:10:54.931662+00
3486	32	22	f	f	2026-07-19 06:12:44.772061+00
3487	32	22	f	f	2026-07-19 06:13:33.611723+00
3493	32	22	f	f	2026-07-19 06:15:50.791651+00
3494	32	22	f	f	2026-07-19 06:16:01.520779+00
3630	82	14	f	f	2026-07-19 06:42:02.902851+00
3631	107	19	f	f	2026-07-19 06:42:18.345713+00
3646	152	19	f	f	2026-07-19 06:44:49.175303+00
3647	36	19	f	f	2026-07-19 06:44:51.103503+00
3648	152	19	f	f	2026-07-19 06:44:53.99193+00
3668	115	22	f	f	2026-07-19 06:46:21.693525+00
3670	8	10	t	f	2026-07-19 06:46:50.016819+00
3671	32	22	t	f	2026-07-19 06:46:54.200875+00
3674	149	22	f	f	2026-07-19 06:47:00.405221+00
3675	149	22	f	f	2026-07-19 06:47:02.397337+00
3687	82	22	f	f	2026-07-19 06:52:19.946483+00
3705	32	24	f	f	2026-07-19 06:54:57.033199+00
3706	36	22	f	f	2026-07-19 06:55:25.498909+00
3707	107	19	f	f	2026-07-19 06:55:28.641995+00
3715	154	22	f	f	2026-07-19 06:57:39.791243+00
3724	116	4	f	f	2026-07-19 06:59:57.673391+00
3725	40	27	t	f	2026-07-19 07:00:05.939774+00
3726	154	23	t	f	2026-07-19 07:00:24.725741+00
3732	115	22	f	f	2026-07-19 07:02:02.302469+00
3779	28	19	f	f	2026-07-19 07:15:27.316846+00
3780	154	24	f	f	2026-07-19 07:15:45.692481+00
3788	115	24	f	f	2026-07-19 07:19:56.687709+00
3789	154	24	t	f	2026-07-19 07:19:57.32422+00
3796	32	27	f	f	2026-07-19 07:20:56.240587+00
3798	120	1	f	f	2026-07-19 07:21:24.768944+00
3819	154	25	t	f	2026-07-19 07:31:21.867735+00
3834	19	10	t	f	2026-07-19 07:34:04.610545+00
3843	107	19	f	f	2026-07-19 07:36:41.284633+00
3845	52	15	f	f	2026-07-19 07:36:45.379161+00
3850	129	19	f	f	2026-07-19 07:39:58.14639+00
3852	124	22	f	f	2026-07-19 07:40:07.597227+00
3853	129	19	f	f	2026-07-19 07:40:12.923912+00
3858	124	22	f	f	2026-07-19 07:40:39.092566+00
3859	154	27	f	f	2026-07-19 07:40:57.930249+00
870	35	22	f	f	2026-07-19 01:03:35.724362+00
874	44	21	f	f	2026-07-19 01:03:49.005364+00
875	139	26	t	t	2026-07-19 01:03:54.07343+00
1491	8	14	f	f	2026-07-19 01:44:18.698115+00
1494	80	27	f	f	2026-07-19 01:44:26.684027+00
1496	51	14	f	f	2026-07-19 01:44:31.05571+00
1500	113	19	f	f	2026-07-19 01:44:53.777849+00
1502	50	22	f	f	2026-07-19 01:45:04.325089+00
1503	144	21	t	f	2026-07-19 01:45:04.987001+00
1505	69	22	t	f	2026-07-19 01:45:27.190254+00
1509	69	23	t	f	2026-07-19 01:46:01.999233+00
1510	11	20	t	f	2026-07-19 01:46:03.740179+00
1515	4	22	f	f	2026-07-19 01:46:26.733433+00
1519	89	14	f	f	2026-07-19 01:47:24.713246+00
1523	144	14	f	f	2026-07-19 01:47:43.808124+00
1524	106	8	t	f	2026-07-19 01:47:45.390086+00
1525	148	21	f	f	2026-07-19 01:47:49.359846+00
1526	94	19	f	f	2026-07-19 01:47:50.888718+00
1528	22	11	t	f	2026-07-19 01:47:54.518559+00
1529	4	22	f	f	2026-07-19 01:48:00.245041+00
1530	24	21	f	f	2026-07-19 01:48:01.086108+00
1533	105	14	t	f	2026-07-19 01:48:20.415268+00
1534	57	21	f	f	2026-07-19 01:48:24.225902+00
1537	57	21	f	f	2026-07-19 01:48:40.173906+00
1538	127	21	f	f	2026-07-19 01:48:43.097521+00
1541	60	25	t	f	2026-07-19 01:48:55.079897+00
1554	127	21	f	f	2026-07-19 01:49:29.143333+00
1556	51	21	f	f	2026-07-19 01:49:32.495761+00
1557	57	21	f	f	2026-07-19 01:49:33.546754+00
1561	127	21	f	f	2026-07-19 01:49:38.585179+00
1563	148	21	f	f	2026-07-19 01:49:41.095755+00
1564	148	21	f	f	2026-07-19 01:49:45.138308+00
1565	89	24	f	f	2026-07-19 01:49:48.486757+00
1582	77	27	f	f	2026-07-19 01:50:47.654457+00
1597	89	14	f	f	2026-07-19 01:51:43.762628+00
1598	79	24	f	f	2026-07-19 01:51:43.994992+00
1599	106	22	t	f	2026-07-19 01:51:44.973903+00
1600	127	21	f	f	2026-07-19 01:51:45.54774+00
1601	79	24	f	f	2026-07-19 01:51:46.225003+00
1602	77	27	f	f	2026-07-19 01:51:46.372493+00
1606	89	14	f	f	2026-07-19 01:52:00.229865+00
2061	32	22	f	f	2026-07-19 02:31:21.255589+00
2063	32	22	f	f	2026-07-19 02:31:32.781282+00
2064	131	21	f	f	2026-07-19 02:31:35.695238+00
2067	125	27	f	f	2026-07-19 02:31:49.165098+00
2068	47	14	f	f	2026-07-19 02:31:49.54548+00
2077	11	25	t	f	2026-07-19 02:32:55.501254+00
2079	32	22	f	f	2026-07-19 02:32:56.977973+00
2081	32	22	f	f	2026-07-19 02:33:02.628598+00
2087	101	21	f	f	2026-07-19 02:34:10.71198+00
2521	65	18	f	f	2026-07-19 03:28:11.010387+00
3086	27	22	f	f	2026-07-19 04:53:13.303603+00
3088	94	19	f	f	2026-07-19 04:53:17.718154+00
3090	94	19	f	f	2026-07-19 04:53:32.722553+00
3091	152	19	f	f	2026-07-19 04:53:43.319537+00
3092	75	22	t	f	2026-07-19 04:53:58.923758+00
3415	122	21	f	f	2026-07-19 05:59:30.45741+00
3427	109	21	f	f	2026-07-19 06:02:20.70488+00
3444	156	20	t	f	2026-07-19 06:05:06.244283+00
3654	18	19	f	f	2026-07-19 06:45:50.308537+00
3655	78	27	f	f	2026-07-19 06:45:51.815675+00
3658	115	22	f	f	2026-07-19 06:45:59.739303+00
3662	121	4	f	f	2026-07-19 06:46:08.177683+00
3664	115	22	f	f	2026-07-19 06:46:11.409998+00
3665	107	19	f	f	2026-07-19 06:46:12.728093+00
3669	36	19	f	f	2026-07-19 06:46:42.071715+00
3682	124	6	t	f	2026-07-19 06:49:18.003171+00
3685	115	22	f	f	2026-07-19 06:50:10.124798+00
3689	107	19	f	f	2026-07-19 06:52:55.079805+00
3690	112	12	t	f	2026-07-19 06:52:58.363925+00
3696	107	19	f	f	2026-07-19 06:53:52.340591+00
3701	5	19	f	f	2026-07-19 06:54:17.322523+00
3702	107	19	f	f	2026-07-19 06:54:28.527007+00
3708	26	22	f	f	2026-07-19 06:55:30.943699+00
3709	32	24	f	f	2026-07-19 06:56:06.97537+00
3710	32	24	t	f	2026-07-19 06:56:10.395227+00
3711	107	19	f	f	2026-07-19 06:56:32.894067+00
3712	154	22	f	f	2026-07-19 06:56:41.249027+00
3713	103	10	f	f	2026-07-19 06:57:11.550843+00
3718	121	4	f	f	2026-07-19 06:58:36.052615+00
3783	28	20	t	f	2026-07-19 07:18:15.253629+00
3784	23	17	t	f	2026-07-19 07:18:15.371186+00
3785	115	24	f	f	2026-07-19 07:18:21.265276+00
3786	36	14	f	f	2026-07-19 07:18:36.420965+00
3792	32	27	f	f	2026-07-19 07:20:32.391823+00
3794	106	19	f	f	2026-07-19 07:20:43.872161+00
3799	120	1	t	f	2026-07-19 07:21:31.620642+00
3800	155	20	t	f	2026-07-19 07:21:52.157126+00
3801	32	27	t	f	2026-07-19 07:22:00.424964+00
3802	39	12	t	f	2026-07-19 07:22:17.078493+00
3804	120	19	f	f	2026-07-19 07:23:31.842277+00
3808	32	14	f	f	2026-07-19 07:26:18.490416+00
3811	79	18	t	f	2026-07-19 07:28:50.745835+00
3812	152	19	f	f	2026-07-19 07:28:51.301154+00
3816	115	25	f	f	2026-07-19 07:30:59.653877+00
3821	15	18	f	f	2026-07-19 07:32:00.252667+00
3822	15	18	f	f	2026-07-19 07:32:05.611482+00
3825	15	18	f	f	2026-07-19 07:32:23.992697+00
3827	40	14	t	f	2026-07-19 07:32:42.848475+00
3830	15	18	f	f	2026-07-19 07:33:06.035337+00
3832	154	26	f	f	2026-07-19 07:33:13.418833+00
3840	115	19	t	f	2026-07-19 07:35:40.062991+00
3847	78	7	t	f	2026-07-19 07:38:11.461652+00
3849	155	21	t	f	2026-07-19 07:38:55.304864+00
3895	129	19	f	f	2026-07-19 07:48:20.27318+00
3897	154	27	f	f	2026-07-19 07:48:40.799504+00
3899	124	22	f	f	2026-07-19 07:49:32.673661+00
3907	129	19	f	f	2026-07-19 07:50:37.332571+00
3908	107	19	f	f	2026-07-19 07:50:41.446001+00
3910	129	19	f	f	2026-07-19 07:50:51.842635+00
3912	129	19	f	f	2026-07-19 07:51:31.559178+00
3913	19	19	f	f	2026-07-19 07:51:37.279778+00
3914	129	19	f	f	2026-07-19 07:51:38.124317+00
3929	19	19	f	f	2026-07-19 07:54:06.713168+00
3931	32	19	f	f	2026-07-19 07:54:51.152873+00
3936	100	8	t	f	2026-07-19 07:57:03.289647+00
3937	106	19	f	f	2026-07-19 07:57:16.703524+00
3945	121	4	f	f	2026-07-19 07:59:10.808438+00
3946	103	21	f	f	2026-07-19 07:59:11.519411+00
3948	121	4	f	f	2026-07-19 07:59:23.210418+00
872	127	15	t	f	2026-07-19 01:03:47.004631+00
873	73	17	t	f	2026-07-19 01:03:47.121631+00
878	133	10	t	f	2026-07-19 01:04:05.052035+00
879	87	1	t	f	2026-07-19 01:04:05.260299+00
880	101	7	t	f	2026-07-19 01:04:06.735238+00
881	126	22	f	f	2026-07-19 01:04:08.683872+00
882	106	21	t	f	2026-07-19 01:04:09.297084+00
884	29	6	f	f	2026-07-19 01:04:15.462598+00
885	29	6	f	f	2026-07-19 01:04:19.060027+00
888	91	21	f	f	2026-07-19 01:04:25.533387+00
889	69	21	t	f	2026-07-19 01:04:29.870081+00
890	4	15	t	f	2026-07-19 01:04:32.061107+00
891	111	14	t	f	2026-07-19 01:04:32.442786+00
892	91	21	f	f	2026-07-19 01:04:34.926873+00
893	91	21	f	f	2026-07-19 01:04:38.245162+00
895	73	2	f	f	2026-07-19 01:04:41.980928+00
898	44	21	f	f	2026-07-19 01:04:57.504611+00
900	60	14	f	f	2026-07-19 01:05:00.100523+00
901	76	26	f	f	2026-07-19 01:05:03.49877+00
903	92	15	t	f	2026-07-19 01:05:04.800768+00
904	32	22	f	f	2026-07-19 01:05:07.550335+00
905	91	21	f	f	2026-07-19 01:05:08.069875+00
906	44	21	f	f	2026-07-19 01:05:10.723191+00
907	32	22	f	f	2026-07-19 01:05:13.957764+00
908	32	22	f	f	2026-07-19 01:05:16.481516+00
910	119	1	t	f	2026-07-19 01:05:20.223133+00
913	22	8	t	f	2026-07-19 01:05:30.285224+00
914	32	22	f	f	2026-07-19 01:05:32.404842+00
915	18	19	f	f	2026-07-19 01:05:34.614082+00
917	21	26	t	f	2026-07-19 01:05:38.960557+00
918	37	19	f	f	2026-07-19 01:05:42.386778+00
919	87	21	f	f	2026-07-19 01:05:45.200333+00
920	37	19	f	f	2026-07-19 01:05:46.519104+00
921	79	1	t	f	2026-07-19 01:05:51.992863+00
922	138	16	t	t	2026-07-19 01:05:55.325852+00
923	139	27	f	f	2026-07-19 01:06:10.137072+00
924	128	21	f	f	2026-07-19 01:06:13.115089+00
926	128	21	f	f	2026-07-19 01:06:22.171707+00
936	125	22	t	f	2026-07-19 01:07:08.581388+00
938	18	19	f	f	2026-07-19 01:07:17.213953+00
939	37	14	t	t	2026-07-19 01:07:26.306996+00
940	65	14	t	f	2026-07-19 01:07:29.28126+00
941	29	10	f	f	2026-07-19 01:07:35.133824+00
942	136	21	f	f	2026-07-19 01:07:38.987163+00
943	128	21	f	f	2026-07-19 01:07:43.97275+00
944	29	10	f	f	2026-07-19 01:07:44.520069+00
945	29	10	f	f	2026-07-19 01:07:48.08548+00
946	128	21	f	f	2026-07-19 01:07:49.750609+00
947	128	21	f	f	2026-07-19 01:07:55.511338+00
948	38	21	f	f	2026-07-19 01:07:56.4288+00
949	65	24	t	f	2026-07-19 01:08:01.528543+00
950	128	21	f	f	2026-07-19 01:08:04.361376+00
951	103	18	f	f	2026-07-19 01:08:10.439668+00
952	79	8	t	f	2026-07-19 01:08:11.497942+00
953	128	21	f	f	2026-07-19 01:08:13.699788+00
954	136	21	f	f	2026-07-19 01:08:17.539931+00
955	101	6	f	f	2026-07-19 01:08:17.648508+00
956	38	21	f	f	2026-07-19 01:08:24.184939+00
957	128	21	f	f	2026-07-19 01:08:27.351324+00
958	72	13	f	f	2026-07-19 01:08:28.173811+00
959	144	20	t	f	2026-07-19 01:08:30.6742+00
960	8	21	f	f	2026-07-19 01:08:30.950129+00
961	128	21	f	f	2026-07-19 01:08:32.14644+00
962	91	21	f	f	2026-07-19 01:08:34.999434+00
963	128	21	f	f	2026-07-19 01:08:36.197181+00
964	101	6	t	f	2026-07-19 01:08:36.556324+00
965	116	21	f	f	2026-07-19 01:08:36.814428+00
966	111	16	t	f	2026-07-19 01:08:37.140695+00
967	38	21	f	f	2026-07-19 01:08:39.560728+00
968	128	21	f	f	2026-07-19 01:08:40.860905+00
969	128	21	f	f	2026-07-19 01:08:45.400121+00
970	128	21	f	f	2026-07-19 01:08:48.977042+00
971	128	21	f	f	2026-07-19 01:08:53.258703+00
972	116	21	f	f	2026-07-19 01:08:53.953963+00
973	60	14	t	f	2026-07-19 01:08:56.487333+00
974	128	21	f	f	2026-07-19 01:08:57.50501+00
975	38	21	f	f	2026-07-19 01:08:57.595827+00
976	13	11	t	f	2026-07-19 01:08:59.803256+00
977	112	26	f	f	2026-07-19 01:09:01.261794+00
978	60	21	t	f	2026-07-19 01:09:06.922005+00
979	128	21	f	f	2026-07-19 01:09:08.810006+00
980	116	21	f	f	2026-07-19 01:09:09.950856+00
981	112	26	f	f	2026-07-19 01:09:14.509984+00
982	91	21	f	f	2026-07-19 01:09:14.912059+00
983	103	18	f	f	2026-07-19 01:09:17.514766+00
984	112	26	f	f	2026-07-19 01:09:19.197696+00
985	21	27	f	f	2026-07-19 01:09:22.287652+00
986	92	26	f	f	2026-07-19 01:09:23.044817+00
987	47	1	f	f	2026-07-19 01:09:24.000435+00
988	128	21	f	f	2026-07-19 01:09:24.160858+00
989	92	26	f	f	2026-07-19 01:09:30.251033+00
990	21	27	f	f	2026-07-19 01:09:32.559207+00
991	139	8	t	f	2026-07-19 01:09:33.286981+00
992	92	26	f	f	2026-07-19 01:09:36.859912+00
993	128	21	f	f	2026-07-19 01:09:39.667769+00
994	125	23	t	f	2026-07-19 01:09:39.722271+00
995	17	21	f	f	2026-07-19 01:09:50.877669+00
996	136	21	f	f	2026-07-19 01:09:54.82866+00
997	21	27	f	f	2026-07-19 01:10:00.828853+00
998	13	14	t	f	2026-07-19 01:10:06.193243+00
999	128	21	f	f	2026-07-19 01:10:08.186247+00
1000	128	21	f	f	2026-07-19 01:10:12.312576+00
1001	30	15	t	f	2026-07-19 01:10:13.31094+00
1002	128	21	f	f	2026-07-19 01:10:18.557405+00
1003	47	16	t	f	2026-07-19 01:10:21.965076+00
1004	128	21	f	f	2026-07-19 01:10:22.560569+00
1005	72	13	f	f	2026-07-19 01:10:28.3199+00
1006	24	11	t	f	2026-07-19 01:10:45.169936+00
1007	128	21	f	f	2026-07-19 01:10:47.80286+00
1008	32	22	f	f	2026-07-19 01:10:53.540647+00
1009	127	21	f	f	2026-07-19 01:10:58.796222+00
1010	32	22	f	f	2026-07-19 01:10:59.332043+00
1011	128	21	f	f	2026-07-19 01:11:07.072958+00
1012	128	21	f	f	2026-07-19 01:11:11.853612+00
1013	128	21	f	f	2026-07-19 01:11:16.449363+00
1014	128	21	f	f	2026-07-19 01:11:20.837769+00
1015	128	21	f	f	2026-07-19 01:11:24.552815+00
1016	128	21	f	f	2026-07-19 01:11:29.665335+00
1017	127	21	f	f	2026-07-19 01:11:32.197884+00
1018	128	21	f	f	2026-07-19 01:11:33.51322+00
1019	128	21	f	f	2026-07-19 01:11:36.191689+00
1020	139	27	f	f	2026-07-19 01:11:36.868273+00
1024	51	5	f	f	2026-07-19 01:11:44.429637+00
1026	111	19	f	f	2026-07-19 01:11:45.531572+00
1027	21	27	f	f	2026-07-19 01:11:45.553167+00
1028	51	5	f	f	2026-07-19 01:11:48.083909+00
1030	51	5	f	f	2026-07-19 01:11:51.859862+00
1031	121	14	f	f	2026-07-19 01:11:52.265111+00
1033	12	14	t	f	2026-07-19 01:11:53.807445+00
1035	51	5	f	f	2026-07-19 01:11:55.296018+00
1492	41	1	t	f	2026-07-19 01:44:20.569613+00
1495	8	13	t	f	2026-07-19 01:44:30.481817+00
1497	94	24	t	f	2026-07-19 01:44:44.646543+00
1504	4	22	f	f	2026-07-19 01:45:07.523557+00
1506	66	8	t	f	2026-07-19 01:45:34.531527+00
1507	119	25	f	f	2026-07-19 01:45:37.331661+00
1508	129	19	f	f	2026-07-19 01:45:44.55487+00
1514	80	27	f	f	2026-07-19 01:46:26.579692+00
1592	79	24	f	f	2026-07-19 01:51:33.564053+00
1614	101	21	f	f	2026-07-19 01:52:36.470177+00
2078	105	9	t	f	2026-07-19 02:32:56.730844+00
2080	119	14	f	f	2026-07-19 02:33:01.34295+00
2082	32	22	f	f	2026-07-19 02:33:09.317823+00
2117	148	21	f	f	2026-07-19 02:36:33.718488+00
2137	92	16	t	f	2026-07-19 02:38:26.641929+00
2141	129	21	f	f	2026-07-19 02:38:44.258176+00
2142	129	21	f	f	2026-07-19 02:38:50.164314+00
2143	129	21	f	f	2026-07-19 02:38:58.636113+00
2147	129	21	f	f	2026-07-19 02:39:24.481979+00
2148	148	21	f	f	2026-07-19 02:39:30.010474+00
2175	101	21	t	f	2026-07-19 02:42:10.811936+00
2179	95	19	f	f	2026-07-19 02:42:40.515718+00
2180	24	10	t	f	2026-07-19 02:42:48.28953+00
2524	131	2	t	f	2026-07-19 03:28:43.714703+00
2525	106	26	t	f	2026-07-19 03:28:43.86228+00
2529	73	22	f	f	2026-07-19 03:29:13.748834+00
2530	37	19	t	f	2026-07-19 03:29:14.344235+00
2535	73	22	f	f	2026-07-19 03:29:50.797186+00
2536	73	22	f	f	2026-07-19 03:29:54.402882+00
2544	73	22	f	f	2026-07-19 03:30:40.675486+00
2545	73	22	f	f	2026-07-19 03:30:43.338721+00
2552	54	21	f	f	2026-07-19 03:31:58.509405+00
2553	6	21	t	f	2026-07-19 03:32:01.95998+00
2554	54	21	f	f	2026-07-19 03:32:02.46545+00
2560	152	21	f	f	2026-07-19 03:32:55.125304+00
2570	54	21	f	f	2026-07-19 03:33:37.972128+00
2571	54	21	f	f	2026-07-19 03:33:46.937509+00
2573	54	21	f	f	2026-07-19 03:33:55.936838+00
2580	125	14	t	f	2026-07-19 03:35:02.56642+00
2581	72	21	f	f	2026-07-19 03:35:02.813795+00
2587	18	19	f	f	2026-07-19 03:36:02.799824+00
2588	92	14	f	f	2026-07-19 03:36:04.624486+00
2589	73	22	f	f	2026-07-19 03:36:07.547366+00
2590	54	21	f	f	2026-07-19 03:36:12.41093+00
2591	73	22	f	f	2026-07-19 03:36:19.605604+00
2593	73	22	f	f	2026-07-19 03:36:20.590211+00
2594	92	14	f	f	2026-07-19 03:36:21.318164+00
2596	73	22	f	f	2026-07-19 03:36:24.883691+00
2598	113	21	f	f	2026-07-19 03:36:27.283442+00
2599	73	22	f	f	2026-07-19 03:36:28.222676+00
2600	94	19	f	f	2026-07-19 03:36:29.140706+00
2601	113	21	f	f	2026-07-19 03:36:31.019325+00
2603	113	21	f	f	2026-07-19 03:36:32.952862+00
2605	54	21	f	f	2026-07-19 03:36:37.771954+00
2611	34	18	t	t	2026-07-19 03:37:00.659038+00
2612	121	24	f	f	2026-07-19 03:37:01.677877+00
2619	113	21	f	f	2026-07-19 03:37:24.255283+00
2620	72	21	f	f	2026-07-19 03:37:24.394094+00
2621	72	21	f	f	2026-07-19 03:37:34.846891+00
2622	18	19	f	f	2026-07-19 03:37:39.181735+00
2625	121	24	t	f	2026-07-19 03:38:01.47274+00
2630	73	22	f	f	2026-07-19 03:38:31.27857+00
2633	103	4	f	f	2026-07-19 03:38:38.942064+00
2638	92	9	t	f	2026-07-19 03:39:50.468768+00
2639	97	19	f	f	2026-07-19 03:39:53.82256+00
2647	4	10	t	f	2026-07-19 03:41:18.440954+00
2649	110	22	t	f	2026-07-19 03:41:39.565132+00
2651	72	18	f	f	2026-07-19 03:42:05.389603+00
2661	113	21	f	f	2026-07-19 03:43:20.461984+00
2676	39	14	f	f	2026-07-19 03:45:52.228458+00
2677	27	15	t	f	2026-07-19 03:45:59.577892+00
2687	54	21	f	f	2026-07-19 03:46:40.096107+00
2688	94	19	f	f	2026-07-19 03:46:45.040326+00
2690	67	9	t	f	2026-07-19 03:46:48.377235+00
2692	94	19	f	f	2026-07-19 03:47:16.271181+00
2696	126	10	t	f	2026-07-19 03:47:43.678863+00
2697	22	13	t	f	2026-07-19 03:47:55.035581+00
3087	94	19	f	f	2026-07-19 04:53:13.600398+00
3089	94	19	f	f	2026-07-19 04:53:22.264277+00
3095	119	19	f	f	2026-07-19 04:55:35.25821+00
3096	75	23	t	f	2026-07-19 04:55:41.317594+00
3101	27	22	f	f	2026-07-19 04:55:56.707041+00
3102	51	24	f	f	2026-07-19 04:55:58.551554+00
3120	51	24	f	f	2026-07-19 04:57:14.923701+00
3123	51	24	f	f	2026-07-19 04:57:27.290853+00
3127	72	19	f	f	2026-07-19 04:57:48.63393+00
3416	65	26	f	f	2026-07-19 06:00:07.673141+00
3417	115	14	f	f	2026-07-19 06:00:19.546921+00
3420	36	14	f	f	2026-07-19 06:00:35.556241+00
3423	115	14	f	f	2026-07-19 06:01:10.714556+00
3445	154	21	f	f	2026-07-19 06:05:18.900572+00
3446	40	6	f	f	2026-07-19 06:05:39.344001+00
3447	154	21	f	f	2026-07-19 06:05:41.20192+00
3448	40	6	t	f	2026-07-19 06:05:42.082296+00
3449	39	26	f	f	2026-07-19 06:05:45.476742+00
3450	154	21	f	f	2026-07-19 06:05:46.57078+00
3458	32	22	f	f	2026-07-19 06:07:18.514584+00
3461	109	21	f	f	2026-07-19 06:07:24.393329+00
3462	32	22	f	f	2026-07-19 06:07:26.870456+00
3469	18	19	f	f	2026-07-19 06:08:16.297842+00
3473	155	6	f	f	2026-07-19 06:09:04.001287+00
3474	155	6	f	f	2026-07-19 06:09:09.347957+00
3475	109	21	f	f	2026-07-19 06:09:21.734426+00
3489	147	4	t	f	2026-07-19 06:14:38.270003+00
3490	87	19	f	f	2026-07-19 06:15:20.832612+00
3491	87	19	f	f	2026-07-19 06:15:24.636466+00
3498	87	19	f	f	2026-07-19 06:17:55.402355+00
3500	124	11	t	f	2026-07-19 06:19:20.383753+00
3703	32	24	f	f	2026-07-19 06:54:46.057493+00
3704	32	24	f	f	2026-07-19 06:54:51.292362+00
1021	128	21	f	f	2026-07-19 01:11:39.041691+00
1022	71	21	f	f	2026-07-19 01:11:42.710296+00
1023	128	21	f	f	2026-07-19 01:11:43.295342+00
1034	21	27	f	f	2026-07-19 01:11:54.925609+00
1036	112	18	f	f	2026-07-19 01:11:55.73698+00
1037	51	5	f	f	2026-07-19 01:11:58.31675+00
1038	71	21	f	f	2026-07-19 01:11:58.398463+00
1039	21	27	f	f	2026-07-19 01:11:59.121958+00
1040	51	5	f	f	2026-07-19 01:12:00.724025+00
1493	80	27	f	f	2026-07-19 01:44:25.830875+00
1501	8	14	f	f	2026-07-19 01:44:56.766132+00
1517	21	19	f	f	2026-07-19 01:46:55.429268+00
1518	4	22	f	f	2026-07-19 01:47:19.281136+00
1531	48	21	t	f	2026-07-19 01:48:13.369228+00
1532	69	14	t	f	2026-07-19 01:48:15.596039+00
1542	57	21	f	f	2026-07-19 01:49:06.211867+00
1543	50	23	t	f	2026-07-19 01:49:12.682297+00
1544	11	21	t	f	2026-07-19 01:49:13.287223+00
1555	72	5	f	f	2026-07-19 01:49:31.839177+00
1558	89	24	f	f	2026-07-19 01:49:35.54348+00
1559	148	21	f	f	2026-07-19 01:49:36.871668+00
1560	129	19	f	f	2026-07-19 01:49:38.345911+00
1562	51	21	t	f	2026-07-19 01:49:39.304797+00
1566	148	21	f	f	2026-07-19 01:49:49.614695+00
1567	127	21	f	f	2026-07-19 01:49:51.593536+00
1568	72	18	f	f	2026-07-19 01:49:59.627081+00
1573	136	21	f	f	2026-07-19 01:50:08.803172+00
1587	24	21	f	f	2026-07-19 01:51:06.993497+00
1588	69	24	f	f	2026-07-19 01:51:10.751456+00
1589	127	21	f	f	2026-07-19 01:51:17.13798+00
1590	44	21	f	f	2026-07-19 01:51:20.128991+00
2090	149	21	f	f	2026-07-19 02:34:24.332051+00
2091	126	14	f	f	2026-07-19 02:34:24.484896+00
2099	149	21	f	f	2026-07-19 02:34:50.144798+00
2104	149	21	f	f	2026-07-19 02:35:10.090616+00
2105	144	14	f	f	2026-07-19 02:35:17.187325+00
2106	11	27	t	f	2026-07-19 02:35:21.456278+00
2107	46	26	f	f	2026-07-19 02:35:24.536218+00
2108	119	14	t	f	2026-07-19 02:35:30.997036+00
2109	34	14	f	f	2026-07-19 02:35:45.381119+00
2110	34	14	f	f	2026-07-19 02:35:52.321465+00
2111	105	27	f	f	2026-07-19 02:35:53.640386+00
2125	105	27	f	f	2026-07-19 02:37:10.621354+00
2126	126	11	t	f	2026-07-19 02:37:13.903434+00
2127	101	21	f	f	2026-07-19 02:37:18.654439+00
2128	101	21	f	f	2026-07-19 02:37:20.244919+00
2134	105	27	f	f	2026-07-19 02:38:11.959715+00
2135	69	27	t	f	2026-07-19 02:38:16.26949+00
2136	133	25	t	f	2026-07-19 02:38:17.047612+00
2139	81	11	t	f	2026-07-19 02:38:40.993364+00
2144	129	21	f	f	2026-07-19 02:39:06.307988+00
2145	105	27	f	f	2026-07-19 02:39:06.955468+00
2146	115	19	f	f	2026-07-19 02:39:16.561029+00
2526	81	14	f	f	2026-07-19 03:28:49.576509+00
2527	104	4	f	f	2026-07-19 03:28:57.648321+00
2528	73	22	f	f	2026-07-19 03:29:08.603568+00
2538	73	22	f	f	2026-07-19 03:30:09.216434+00
2539	73	22	f	f	2026-07-19 03:30:12.698875+00
2540	73	22	f	f	2026-07-19 03:30:15.112984+00
2547	18	19	f	f	2026-07-19 03:31:17.117741+00
2548	53	9	t	f	2026-07-19 03:31:25.036046+00
2549	148	19	f	f	2026-07-19 03:31:37.979427+00
2550	106	19	f	f	2026-07-19 03:31:45.758459+00
2557	148	19	f	f	2026-07-19 03:32:34.369095+00
2558	148	19	f	f	2026-07-19 03:32:51.591187+00
2559	148	19	f	f	2026-07-19 03:32:54.356211+00
2561	126	9	t	f	2026-07-19 03:33:01.384312+00
2592	94	19	f	f	2026-07-19 03:36:20.540388+00
2595	113	21	f	f	2026-07-19 03:36:24.382909+00
2597	73	22	f	f	2026-07-19 03:36:26.258433+00
2602	113	21	f	f	2026-07-19 03:36:32.382207+00
2604	54	21	f	f	2026-07-19 03:36:33.32377+00
2608	73	22	f	f	2026-07-19 03:36:52.178495+00
2609	73	22	f	f	2026-07-19 03:36:54.09404+00
2613	113	21	f	f	2026-07-19 03:37:02.696227+00
2614	113	21	f	f	2026-07-19 03:37:03.732849+00
2615	39	14	f	f	2026-07-19 03:37:10.271923+00
2616	113	21	f	f	2026-07-19 03:37:12.949211+00
2617	22	13	f	f	2026-07-19 03:37:14.833595+00
2618	113	21	f	f	2026-07-19 03:37:21.096339+00
2631	54	21	f	f	2026-07-19 03:38:31.391187+00
2632	54	21	f	f	2026-07-19 03:38:35.638386+00
2634	73	22	f	f	2026-07-19 03:38:45.579605+00
2636	39	14	f	f	2026-07-19 03:39:20.001343+00
2637	92	14	f	f	2026-07-19 03:39:38.336525+00
2640	54	21	f	f	2026-07-19 03:39:56.937079+00
2641	54	21	f	f	2026-07-19 03:40:01.670599+00
2645	24	24	f	f	2026-07-19 03:41:00.588892+00
2646	72	21	t	f	2026-07-19 03:41:14.060507+00
2648	39	14	f	f	2026-07-19 03:41:29.894634+00
2654	39	15	f	f	2026-07-19 03:42:46.658412+00
2657	39	15	f	f	2026-07-19 03:42:53.040837+00
2658	77	5	f	f	2026-07-19 03:42:53.650679+00
2669	18	19	f	f	2026-07-19 03:44:45.134688+00
2670	145	21	f	f	2026-07-19 03:45:18.703949+00
2671	54	21	f	f	2026-07-19 03:45:20.655583+00
2672	54	21	f	f	2026-07-19 03:45:25.594222+00
2681	54	21	f	f	2026-07-19 03:46:16.257759+00
2682	121	25	t	f	2026-07-19 03:46:24.558691+00
2689	113	21	f	f	2026-07-19 03:46:47.079186+00
2691	94	19	f	f	2026-07-19 03:46:50.418976+00
2693	106	19	f	f	2026-07-19 03:47:32.047225+00
2694	18	19	f	f	2026-07-19 03:47:35.93445+00
2695	94	19	f	f	2026-07-19 03:47:40.120092+00
2698	27	21	t	f	2026-07-19 03:48:06.731253+00
2699	94	19	f	f	2026-07-19 03:48:09.136503+00
2700	38	5	t	f	2026-07-19 03:48:56.339624+00
3093	48	24	f	f	2026-07-19 04:55:23.628821+00
3094	103	4	f	f	2026-07-19 04:55:30.271607+00
3097	103	4	f	f	2026-07-19 04:55:41.969+00
3103	129	22	f	f	2026-07-19 04:56:00.676541+00
3104	103	4	f	f	2026-07-19 04:56:02.032781+00
3105	51	24	f	f	2026-07-19 04:56:07.133143+00
3106	103	4	f	f	2026-07-19 04:56:11.72945+00
3107	103	4	f	f	2026-07-19 04:56:22.724151+00
3122	11	19	f	f	2026-07-19 04:57:20.570348+00
3125	51	24	f	f	2026-07-19 04:57:38.702789+00
3126	51	24	f	f	2026-07-19 04:57:41.992991+00
3135	51	24	f	f	2026-07-19 05:00:10.214282+00
3429	155	6	f	f	2026-07-19 06:02:59.712416+00
1025	139	27	f	f	2026-07-19 01:11:45.085625+00
1029	128	21	f	f	2026-07-19 01:11:49.023375+00
1032	71	21	f	f	2026-07-19 01:11:53.3831+00
1041	112	18	f	f	2026-07-19 01:12:07.13661+00
1042	35	22	f	f	2026-07-19 01:12:13.359831+00
1043	20	27	f	f	2026-07-19 01:12:14.101542+00
1044	25	22	f	f	2026-07-19 01:12:16.127568+00
1045	22	26	t	t	2026-07-19 01:12:19.418176+00
1046	95	11	t	f	2026-07-19 01:12:19.651437+00
1047	18	14	t	f	2026-07-19 01:12:19.989231+00
1048	17	21	f	f	2026-07-19 01:12:23.890404+00
1049	92	26	f	f	2026-07-19 01:12:29.006522+00
1050	17	21	f	f	2026-07-19 01:12:30.866229+00
1051	144	21	f	f	2026-07-19 01:12:32.228144+00
1052	25	22	f	f	2026-07-19 01:12:33.569802+00
1053	111	24	t	f	2026-07-19 01:12:35.390463+00
1054	127	14	f	f	2026-07-19 01:12:37.672745+00
1055	51	5	f	f	2026-07-19 01:12:38.412301+00
1056	17	21	f	f	2026-07-19 01:12:41.324804+00
1057	92	26	t	f	2026-07-19 01:12:41.747411+00
1058	119	21	t	f	2026-07-19 01:12:45.672074+00
1059	51	5	f	f	2026-07-19 01:12:46.571789+00
1060	127	14	f	f	2026-07-19 01:12:47.277403+00
1061	51	5	f	f	2026-07-19 01:12:49.945964+00
1062	25	22	f	f	2026-07-19 01:12:50.170677+00
1063	17	21	f	f	2026-07-19 01:12:50.824752+00
1064	62	21	f	f	2026-07-19 01:13:06.657803+00
1065	65	26	f	f	2026-07-19 01:13:08.001542+00
1066	111	13	t	f	2026-07-19 01:13:13.114199+00
1067	27	19	f	f	2026-07-19 01:13:17.731795+00
1068	81	24	f	f	2026-07-19 01:13:17.871858+00
1069	27	19	f	f	2026-07-19 01:13:21.172379+00
1070	124	7	t	f	2026-07-19 01:13:21.939397+00
1071	116	21	f	f	2026-07-19 01:13:22.272593+00
1072	38	14	t	f	2026-07-19 01:13:25.10884+00
1073	139	27	f	f	2026-07-19 01:13:25.116944+00
1074	27	19	f	f	2026-07-19 01:13:25.789813+00
1075	127	14	f	f	2026-07-19 01:13:28.825882+00
1076	116	21	f	f	2026-07-19 01:13:28.835689+00
1077	127	14	f	f	2026-07-19 01:13:33.485575+00
1078	91	21	f	f	2026-07-19 01:13:35.147213+00
1079	112	26	f	f	2026-07-19 01:13:36.033926+00
1080	116	21	f	f	2026-07-19 01:13:36.195192+00
1081	82	7	t	f	2026-07-19 01:13:36.265009+00
1082	127	14	f	f	2026-07-19 01:13:37.202776+00
1083	51	21	f	f	2026-07-19 01:13:38.182714+00
1084	127	14	f	f	2026-07-19 01:13:41.106582+00
1085	116	21	f	f	2026-07-19 01:13:43.301748+00
1086	104	8	t	f	2026-07-19 01:13:47.331473+00
1087	137	21	f	f	2026-07-19 01:13:48.214851+00
1088	81	24	t	f	2026-07-19 01:13:49.024465+00
1089	116	21	f	f	2026-07-19 01:13:51.52252+00
1090	127	14	t	f	2026-07-19 01:13:52.657712+00
1091	62	21	f	f	2026-07-19 01:13:54.042071+00
1092	21	14	t	f	2026-07-19 01:13:54.292607+00
1093	85	14	f	f	2026-07-19 01:14:10.166067+00
1094	111	26	t	f	2026-07-19 01:14:24.274678+00
1095	81	13	t	f	2026-07-19 01:14:37.157573+00
1096	139	27	f	f	2026-07-19 01:14:38.302844+00
1097	19	15	t	f	2026-07-19 01:14:39.793571+00
1098	25	22	f	f	2026-07-19 01:14:41.095226+00
1099	112	26	t	f	2026-07-19 01:14:45.543654+00
1100	25	22	f	f	2026-07-19 01:14:50.348853+00
1101	138	14	f	f	2026-07-19 01:14:58.138444+00
1102	38	21	t	f	2026-07-19 01:15:21.220744+00
1103	26	13	f	f	2026-07-19 01:15:22.989069+00
1104	46	14	f	f	2026-07-19 01:15:24.076771+00
1105	134	7	t	f	2026-07-19 01:15:28.690652+00
1106	26	13	f	f	2026-07-19 01:15:30.158387+00
1107	81	26	f	f	2026-07-19 01:15:30.87035+00
1108	133	21	f	f	2026-07-19 01:15:32.93701+00
1109	26	13	f	f	2026-07-19 01:15:33.317439+00
1110	71	21	f	f	2026-07-19 01:15:35.345325+00
1111	139	27	f	f	2026-07-19 01:15:36.736674+00
1112	4	21	f	f	2026-07-19 01:15:37.09715+00
1113	144	21	f	f	2026-07-19 01:15:39.03139+00
1114	81	26	t	f	2026-07-19 01:15:39.589625+00
1115	54	1	t	f	2026-07-19 01:15:42.508931+00
1116	92	27	f	f	2026-07-19 01:15:45.353562+00
1117	25	22	f	f	2026-07-19 01:15:51.211191+00
1118	112	27	f	f	2026-07-19 01:16:17.507899+00
1119	92	27	f	f	2026-07-19 01:16:18.063876+00
1120	112	27	f	f	2026-07-19 01:16:23.177479+00
1121	139	27	f	f	2026-07-19 01:16:23.729526+00
1122	127	21	f	f	2026-07-19 01:16:31.761932+00
1123	12	15	t	f	2026-07-19 01:16:32.445581+00
1124	26	13	f	f	2026-07-19 01:16:36.303875+00
1125	26	13	f	f	2026-07-19 01:16:39.730299+00
1126	13	8	t	f	2026-07-19 01:16:43.972558+00
1127	111	12	t	t	2026-07-19 01:16:58.364057+00
1128	18	1	t	f	2026-07-19 01:17:03.06523+00
1129	66	7	t	f	2026-07-19 01:17:04.410584+00
1130	139	27	f	f	2026-07-19 01:17:07.163536+00
1131	46	14	f	f	2026-07-19 01:17:11.557351+00
1132	144	8	t	f	2026-07-19 01:17:21.4583+00
1133	29	2	t	f	2026-07-19 01:17:24.085273+00
1134	112	27	f	f	2026-07-19 01:17:27.901306+00
1135	112	27	f	f	2026-07-19 01:17:28.925485+00
1136	48	14	f	f	2026-07-19 01:17:32.730023+00
1137	67	21	f	f	2026-07-19 01:17:34.521214+00
1138	94	19	f	f	2026-07-19 01:17:47.218826+00
1139	77	4	f	f	2026-07-19 01:17:48.190776+00
1140	25	22	f	f	2026-07-19 01:17:49.122362+00
1141	12	13	t	f	2026-07-19 01:17:56.250997+00
1142	77	4	f	f	2026-07-19 01:17:56.705084+00
1143	62	21	f	f	2026-07-19 01:18:06.81247+00
1144	111	27	f	f	2026-07-19 01:18:08.294929+00
1145	62	21	f	f	2026-07-19 01:18:14.670048+00
1146	22	27	f	f	2026-07-19 01:18:16.563472+00
1147	46	14	f	f	2026-07-19 01:18:26.804726+00
1148	62	21	f	f	2026-07-19 01:18:30.154262+00
1149	62	21	f	f	2026-07-19 01:18:32.662309+00
1150	101	20	t	f	2026-07-19 01:18:38.603824+00
1151	92	27	f	f	2026-07-19 01:18:44.746615+00
1152	27	19	f	f	2026-07-19 01:18:45.702575+00
1153	27	19	f	f	2026-07-19 01:19:04.67434+00
1154	111	27	f	f	2026-07-19 01:19:06.110212+00
1155	27	19	f	f	2026-07-19 01:19:09.626031+00
1156	46	14	f	f	2026-07-19 01:19:14.487235+00
1157	27	19	f	f	2026-07-19 01:19:18.107789+00
1158	22	27	f	f	2026-07-19 01:19:22.559343+00
1159	26	13	t	f	2026-07-19 01:19:24.314208+00
1160	22	27	f	f	2026-07-19 01:19:24.96405+00
1161	25	22	t	f	2026-07-19 01:19:30.308586+00
1166	103	20	f	f	2026-07-19 01:20:01.205553+00
1169	9	16	t	f	2026-07-19 01:20:10.12887+00
1191	13	21	f	f	2026-07-19 01:21:30.301728+00
1195	22	27	f	f	2026-07-19 01:21:50.794835+00
1199	80	11	t	f	2026-07-19 01:22:04.231283+00
1200	91	21	f	f	2026-07-19 01:22:08.320739+00
1201	72	7	t	f	2026-07-19 01:22:11.870857+00
1202	47	15	t	f	2026-07-19 01:22:14.663731+00
1206	94	19	f	f	2026-07-19 01:22:32.073421+00
1216	21	25	f	f	2026-07-19 01:23:18.219069+00
1220	22	1	t	f	2026-07-19 01:23:40.27771+00
1222	139	27	f	f	2026-07-19 01:23:56.389712+00
1223	139	27	f	f	2026-07-19 01:23:59.99335+00
1227	7	13	t	f	2026-07-19 01:24:12.328865+00
1498	113	19	f	f	2026-07-19 01:44:44.732812+00
1499	8	14	f	f	2026-07-19 01:44:45.248708+00
1513	89	14	f	f	2026-07-19 01:46:20.603586+00
1520	144	14	f	f	2026-07-19 01:47:27.973849+00
1536	22	15	t	f	2026-07-19 01:48:39.310076+00
1545	51	21	f	f	2026-07-19 01:49:14.144161+00
1546	57	21	f	f	2026-07-19 01:49:15.418313+00
1547	69	24	f	f	2026-07-19 01:49:16.76719+00
1549	57	21	f	f	2026-07-19 01:49:18.684446+00
1551	72	5	f	f	2026-07-19 01:49:20.287336+00
1569	65	26	f	f	2026-07-19 01:50:01.263822+00
1570	79	11	t	f	2026-07-19 01:50:01.603071+00
1571	127	21	f	f	2026-07-19 01:50:02.432556+00
1574	40	16	t	f	2026-07-19 01:50:08.908786+00
1576	127	21	f	f	2026-07-19 01:50:15.970329+00
1577	89	24	f	f	2026-07-19 01:50:18.985162+00
1578	101	21	f	f	2026-07-19 01:50:19.376228+00
1579	92	4	t	f	2026-07-19 01:50:30.541361+00
1580	62	21	t	f	2026-07-19 01:50:30.896726+00
1583	24	21	f	f	2026-07-19 01:50:52.960122+00
1586	139	14	f	f	2026-07-19 01:51:02.59428+00
1596	127	21	f	f	2026-07-19 01:51:39.403949+00
1608	127	21	f	f	2026-07-19 01:52:10.439498+00
1610	127	21	f	f	2026-07-19 01:52:16.716322+00
1611	127	21	f	f	2026-07-19 01:52:21.062899+00
1612	60	26	f	f	2026-07-19 01:52:35.286052+00
1615	16	6	f	f	2026-07-19 01:52:40.052671+00
2118	85	27	f	f	2026-07-19 02:36:51.754827+00
2120	94	27	t	f	2026-07-19 02:36:55.755492+00
2121	85	27	f	f	2026-07-19 02:36:55.937594+00
2138	101	21	f	f	2026-07-19 02:38:37.331775+00
2140	25	27	f	f	2026-07-19 02:38:43.350553+00
2149	129	21	f	f	2026-07-19 02:39:32.84507+00
2150	129	21	f	f	2026-07-19 02:39:40.649371+00
2153	145	13	t	f	2026-07-19 02:39:57.048456+00
2159	72	5	t	f	2026-07-19 02:40:31.835476+00
2169	105	27	f	f	2026-07-19 02:41:32.913809+00
2170	145	5	f	f	2026-07-19 02:41:39.044814+00
2171	46	26	f	f	2026-07-19 02:41:44.365862+00
2173	119	26	f	f	2026-07-19 02:41:51.434533+00
2174	85	27	f	f	2026-07-19 02:41:53.648073+00
2176	133	26	f	f	2026-07-19 02:42:17.897772+00
2181	82	22	f	f	2026-07-19 02:42:53.096836+00
2182	44	22	f	f	2026-07-19 02:42:54.548679+00
2186	85	27	t	f	2026-07-19 02:43:17.419147+00
2187	66	18	f	f	2026-07-19 02:43:55.197184+00
2188	129	21	t	f	2026-07-19 02:43:55.627609+00
2531	73	22	f	f	2026-07-19 03:29:22.0031+00
2533	73	22	f	f	2026-07-19 03:29:34.180342+00
2534	73	22	f	f	2026-07-19 03:29:48.557653+00
2684	54	21	f	f	2026-07-19 03:46:31.436337+00
2685	54	21	f	f	2026-07-19 03:46:34.840787+00
3098	103	4	f	f	2026-07-19 04:55:51.540261+00
3100	27	22	f	f	2026-07-19 04:55:55.690443+00
3108	145	21	f	f	2026-07-19 04:56:27.28042+00
3109	103	4	f	f	2026-07-19 04:56:32.848122+00
3110	145	21	f	f	2026-07-19 04:56:36.378626+00
3112	145	21	f	f	2026-07-19 04:56:44.720251+00
3113	48	11	t	f	2026-07-19 04:56:45.641544+00
3117	129	22	f	f	2026-07-19 04:57:05.278813+00
3121	129	22	f	f	2026-07-19 04:57:17.781532+00
3124	11	19	f	f	2026-07-19 04:57:32.096449+00
3128	51	24	f	f	2026-07-19 04:57:57.446785+00
3129	4	19	f	f	2026-07-19 04:58:08.201436+00
3433	109	21	f	f	2026-07-19 06:03:39.611762+00
3434	155	14	f	f	2026-07-19 06:03:48.23115+00
3435	32	22	f	f	2026-07-19 06:04:09.302873+00
3436	32	22	f	f	2026-07-19 06:04:12.777709+00
3437	32	22	f	f	2026-07-19 06:04:25.42539+00
3438	82	14	f	f	2026-07-19 06:04:26.857563+00
3439	32	22	f	f	2026-07-19 06:04:28.433443+00
3440	32	22	f	f	2026-07-19 06:04:31.089696+00
3443	32	22	f	f	2026-07-19 06:04:40.812357+00
3452	5	1	t	f	2026-07-19 06:05:54.59981+00
3453	154	21	f	f	2026-07-19 06:05:59.134763+00
3454	149	2	f	f	2026-07-19 06:06:01.442625+00
3455	32	22	f	f	2026-07-19 06:06:26.534136+00
3456	40	7	t	f	2026-07-19 06:06:27.188288+00
3457	155	8	f	f	2026-07-19 06:06:59.788819+00
3477	109	21	f	f	2026-07-19 06:10:14.671414+00
3479	53	4	t	f	2026-07-19 06:10:54.889772+00
3485	156	21	t	f	2026-07-19 06:12:19.207165+00
3492	23	16	t	f	2026-07-19 06:15:44.292661+00
3495	87	19	f	f	2026-07-19 06:16:29.942191+00
3716	100	21	f	f	2026-07-19 06:58:03.059594+00
3717	154	22	t	f	2026-07-19 06:58:18.428699+00
3721	115	22	f	f	2026-07-19 06:59:26.337605+00
3722	107	19	f	f	2026-07-19 06:59:26.759484+00
3839	154	26	f	f	2026-07-19 07:35:39.514129+00
3844	154	26	t	f	2026-07-19 07:36:43.12012+00
3898	154	27	f	f	2026-07-19 07:49:23.78782+00
3900	129	19	f	f	2026-07-19 07:49:38.342998+00
3902	107	19	f	f	2026-07-19 07:49:53.688962+00
3903	124	22	f	f	2026-07-19 07:49:59.407603+00
3905	107	19	f	f	2026-07-19 07:50:29.70738+00
3906	129	19	f	f	2026-07-19 07:50:31.126542+00
3909	129	19	f	f	2026-07-19 07:50:45.060921+00
3920	129	19	f	f	2026-07-19 07:52:31.613897+00
3921	129	19	f	f	2026-07-19 07:52:43.114115+00
3930	103	21	f	f	2026-07-19 07:54:35.939601+00
3932	154	6	t	f	2026-07-19 07:55:38.108383+00
3933	106	19	f	f	2026-07-19 07:56:02.169433+00
1162	89	14	f	f	2026-07-19 01:19:33.964987+00
1163	69	22	f	f	2026-07-19 01:19:40.225846+00
1179	46	14	f	f	2026-07-19 01:20:41.587674+00
1180	77	26	f	f	2026-07-19 01:20:52.173077+00
1187	125	14	f	f	2026-07-19 01:21:13.698664+00
1188	8	21	t	f	2026-07-19 01:21:16.116305+00
1190	119	15	t	f	2026-07-19 01:21:28.060243+00
1196	69	15	t	f	2026-07-19 01:21:52.281214+00
1197	65	10	t	f	2026-07-19 01:21:56.626582+00
1198	47	15	f	f	2026-07-19 01:22:00.973624+00
1210	65	26	f	f	2026-07-19 01:22:45.005669+00
1212	112	27	f	f	2026-07-19 01:22:51.143758+00
1213	101	21	f	f	2026-07-19 01:22:53.067341+00
1218	101	21	f	f	2026-07-19 01:23:24.199084+00
1228	69	22	f	f	2026-07-19 01:24:13.52658+00
1511	60	24	t	f	2026-07-19 01:46:04.00978+00
1512	72	16	t	f	2026-07-19 01:46:10.401901+00
1516	24	21	f	f	2026-07-19 01:46:41.227605+00
1521	94	19	f	f	2026-07-19 01:47:32.868444+00
1522	50	22	t	f	2026-07-19 01:47:40.523444+00
1527	80	27	t	f	2026-07-19 01:47:52.345407+00
1535	127	21	f	f	2026-07-19 01:48:37.53989+00
1539	57	21	f	f	2026-07-19 01:48:50.129125+00
1540	136	21	f	f	2026-07-19 01:48:50.467004+00
1548	127	21	f	f	2026-07-19 01:49:17.143226+00
1550	51	21	f	f	2026-07-19 01:49:19.397069+00
1552	69	24	f	f	2026-07-19 01:49:22.962321+00
1553	51	21	f	f	2026-07-19 01:49:23.926676+00
1572	69	24	f	f	2026-07-19 01:50:05.0609+00
1575	127	21	f	f	2026-07-19 01:50:13.835451+00
1581	77	27	f	f	2026-07-19 01:50:40.695065+00
1584	144	14	f	f	2026-07-19 01:50:56.293131+00
1585	89	24	f	f	2026-07-19 01:51:02.313541+00
1591	127	21	f	f	2026-07-19 01:51:26.202714+00
1593	110	14	t	f	2026-07-19 01:51:35.684814+00
1594	79	24	f	f	2026-07-19 01:51:37.359306+00
1595	94	25	t	f	2026-07-19 01:51:38.945396+00
1603	127	21	f	f	2026-07-19 01:51:50.414696+00
1604	77	27	f	f	2026-07-19 01:51:55.946798+00
1605	127	21	f	f	2026-07-19 01:51:58.362626+00
1607	127	21	f	f	2026-07-19 01:52:06.820398+00
1609	75	17	t	f	2026-07-19 01:52:13.818618+00
1613	16	5	f	f	2026-07-19 01:52:35.290046+00
2155	112	9	t	t	2026-07-19 02:40:04.590268+00
2156	81	18	f	f	2026-07-19 02:40:10.344354+00
2157	149	18	f	f	2026-07-19 02:40:18.923091+00
2158	44	22	f	f	2026-07-19 02:40:24.55034+00
2178	95	19	f	f	2026-07-19 02:42:29.340278+00
2183	95	19	f	f	2026-07-19 02:42:56.52858+00
2184	17	22	t	f	2026-07-19 02:43:04.490371+00
2190	44	22	f	f	2026-07-19 02:44:07.29055+00
2532	110	21	t	f	2026-07-19 03:29:25.486813+00
2537	73	22	f	f	2026-07-19 03:30:05.336935+00
2541	73	22	f	f	2026-07-19 03:30:29.218771+00
2546	97	17	t	f	2026-07-19 03:30:57.125983+00
2555	60	8	t	f	2026-07-19 03:32:14.644913+00
2556	148	19	f	f	2026-07-19 03:32:15.469956+00
2565	54	21	f	f	2026-07-19 03:33:15.196445+00
2567	54	21	f	f	2026-07-19 03:33:24.962508+00
2575	121	24	f	f	2026-07-19 03:34:08.105518+00
2576	27	10	t	f	2026-07-19 03:34:16.934+00
2577	131	21	f	f	2026-07-19 03:34:17.161802+00
2578	72	21	f	f	2026-07-19 03:34:46.840407+00
2606	72	21	f	f	2026-07-19 03:36:49.358898+00
2607	73	22	f	f	2026-07-19 03:36:50.492977+00
2610	121	24	f	f	2026-07-19 03:36:55.811354+00
2623	24	24	f	f	2026-07-19 03:37:52.114468+00
2624	24	24	f	f	2026-07-19 03:37:54.57056+00
2626	94	19	f	f	2026-07-19 03:38:19.790759+00
2629	54	21	f	f	2026-07-19 03:38:27.422431+00
2642	54	21	f	f	2026-07-19 03:40:04.41326+00
2643	54	21	f	f	2026-07-19 03:40:13.472285+00
2644	94	19	f	f	2026-07-19 03:40:29.700433+00
2655	54	21	f	f	2026-07-19 03:42:47.566602+00
2656	77	5	f	f	2026-07-19 03:42:48.952018+00
2666	87	24	t	f	2026-07-19 03:44:08.832219+00
2667	113	21	f	f	2026-07-19 03:44:09.90746+00
2668	54	21	f	f	2026-07-19 03:44:15.664462+00
2675	54	21	f	f	2026-07-19 03:45:41.623114+00
2680	54	21	f	f	2026-07-19 03:46:12.957435+00
2683	54	21	f	f	2026-07-19 03:46:28.675645+00
2686	54	21	f	f	2026-07-19 03:46:37.768868+00
3099	27	22	f	f	2026-07-19 04:55:52.444439+00
3111	119	19	f	f	2026-07-19 04:56:43.79378+00
3114	103	4	f	f	2026-07-19 04:56:51.641468+00
3115	129	22	f	f	2026-07-19 04:56:57.883456+00
3116	11	19	f	f	2026-07-19 04:56:58.155231+00
3118	11	19	f	f	2026-07-19 04:57:10.44659+00
3119	129	22	f	f	2026-07-19 04:57:10.767249+00
3130	48	24	f	f	2026-07-19 04:58:26.489359+00
3139	121	2	t	f	2026-07-19 05:00:49.495306+00
3460	32	22	f	f	2026-07-19 06:07:24.303882+00
3463	32	22	f	f	2026-07-19 06:07:30.086602+00
3464	32	22	f	f	2026-07-19 06:07:32.442404+00
3472	79	9	t	f	2026-07-19 06:08:46.344321+00
3481	154	14	t	f	2026-07-19 06:11:26.536665+00
3482	152	26	f	f	2026-07-19 06:12:05.607005+00
3483	24	19	f	f	2026-07-19 06:12:12.066169+00
3484	39	26	t	f	2026-07-19 06:12:15.318793+00
3488	4	19	f	f	2026-07-19 06:14:02.667564+00
3735	121	4	f	f	2026-07-19 07:02:45.408295+00
3736	106	12	t	f	2026-07-19 07:02:57.635278+00
3851	124	22	f	f	2026-07-19 07:40:05.997358+00
3855	129	19	f	f	2026-07-19 07:40:26.285472+00
3856	124	22	f	f	2026-07-19 07:40:26.470586+00
3871	107	19	f	f	2026-07-19 07:42:47.798503+00
3872	19	21	f	f	2026-07-19 07:43:12.31968+00
3879	129	19	f	f	2026-07-19 07:44:47.320497+00
3886	107	19	f	f	2026-07-19 07:46:25.015205+00
3889	154	27	f	f	2026-07-19 07:47:26.010223+00
3890	129	19	f	f	2026-07-19 07:47:28.467331+00
3891	129	19	f	f	2026-07-19 07:47:36.378864+00
3894	129	19	f	f	2026-07-19 07:48:12.870213+00
3911	107	19	f	f	2026-07-19 07:51:28.023652+00
3916	19	19	f	f	2026-07-19 07:51:51.917526+00
3924	19	19	f	f	2026-07-19 07:52:55.725978+00
3925	129	19	f	f	2026-07-19 07:53:17.36906+00
3926	19	21	f	f	2026-07-19 07:53:19.265647+00
3928	154	27	t	f	2026-07-19 07:53:40.739377+00
3934	103	21	f	f	2026-07-19 07:56:22.066662+00
1164	13	6	t	f	2026-07-19 01:19:55.293131+00
1170	95	14	f	f	2026-07-19 01:20:15.948466+00
1171	103	20	f	f	2026-07-19 01:20:20.675655+00
1174	22	27	f	f	2026-07-19 01:20:26.097521+00
1176	22	27	f	f	2026-07-19 01:20:28.562315+00
1177	77	26	f	f	2026-07-19 01:20:29.854861+00
1178	47	15	f	f	2026-07-19 01:20:38.45772+00
1186	46	14	f	f	2026-07-19 01:21:13.598892+00
1189	128	6	f	f	2026-07-19 01:21:28.016951+00
1192	111	5	f	f	2026-07-19 01:21:37.646716+00
1193	128	6	t	f	2026-07-19 01:21:40.117265+00
1194	21	10	t	f	2026-07-19 01:21:45.121685+00
1203	51	8	t	f	2026-07-19 01:22:24.936641+00
1217	66	6	t	f	2026-07-19 01:23:22.543089+00
1221	111	27	t	t	2026-07-19 01:23:53.194861+00
1224	21	27	t	f	2026-07-19 01:24:04.804151+00
1225	18	15	t	f	2026-07-19 01:24:06.657663+00
1226	139	27	f	f	2026-07-19 01:24:09.824673+00
1616	113	19	f	f	2026-07-19 01:52:49.769887+00
1619	113	19	f	f	2026-07-19 01:53:04.750274+00
1620	69	24	f	f	2026-07-19 01:53:09.99103+00
1621	149	16	t	f	2026-07-19 01:53:10.737594+00
1622	47	21	f	f	2026-07-19 01:53:10.986784+00
1625	60	26	f	f	2026-07-19 01:53:38.160219+00
1629	60	26	f	f	2026-07-19 01:53:47.691367+00
1630	144	1	t	f	2026-07-19 01:53:51.295917+00
1635	60	26	t	f	2026-07-19 01:54:22.484026+00
1637	44	21	f	f	2026-07-19 01:54:33.658359+00
1639	77	27	t	f	2026-07-19 01:54:40.908299+00
1643	11	22	f	f	2026-07-19 01:54:52.866812+00
1644	11	22	f	f	2026-07-19 01:54:57.523924+00
1648	24	21	t	f	2026-07-19 01:55:09.872075+00
1649	69	24	f	f	2026-07-19 01:55:29.266533+00
1654	129	19	f	f	2026-07-19 01:55:47.4601+00
1670	16	6	f	f	2026-07-19 01:57:06.614243+00
1673	93	14	t	f	2026-07-19 01:57:10.304724+00
1676	129	19	f	f	2026-07-19 01:57:43.143377+00
1679	91	19	f	f	2026-07-19 01:58:07.297292+00
1693	8	14	f	f	2026-07-19 01:59:26.65516+00
1694	88	21	f	f	2026-07-19 01:59:26.664506+00
1707	69	24	t	f	2026-07-19 02:00:32.786691+00
1711	88	21	f	f	2026-07-19 02:01:00.042809+00
2191	148	21	f	f	2026-07-19 02:44:10.20578+00
2192	53	13	f	f	2026-07-19 02:44:15.301751+00
2224	106	25	t	f	2026-07-19 02:50:39.490829+00
2225	148	5	t	f	2026-07-19 02:50:44.183465+00
2235	72	21	f	f	2026-07-19 02:52:39.688549+00
2238	25	25	f	f	2026-07-19 02:52:51.296417+00
2239	72	21	f	f	2026-07-19 02:53:01.443886+00
2240	85	16	f	f	2026-07-19 02:53:02.556083+00
2241	8	18	f	f	2026-07-19 02:53:12.342893+00
2276	13	12	t	f	2026-07-19 02:58:31.510892+00
2279	4	14	f	f	2026-07-19 03:00:14.047944+00
2280	51	18	f	f	2026-07-19 03:00:29.506355+00
2281	51	18	f	f	2026-07-19 03:00:35.079226+00
2282	51	18	f	f	2026-07-19 03:00:38.622171+00
2283	51	18	f	f	2026-07-19 03:00:41.055656+00
2284	44	22	f	f	2026-07-19 03:00:41.538561+00
2286	51	18	f	f	2026-07-19 03:00:42.26612+00
2287	51	18	f	f	2026-07-19 03:00:42.78795+00
2289	85	16	t	f	2026-07-19 03:01:13.161264+00
2302	106	11	f	f	2026-07-19 03:02:41.148565+00
2303	106	11	t	f	2026-07-19 03:02:45.287406+00
2542	73	22	f	f	2026-07-19 03:30:35.244273+00
2543	73	22	f	f	2026-07-19 03:30:38.393636+00
2551	54	21	f	f	2026-07-19 03:31:52.039818+00
2562	147	10	t	f	2026-07-19 03:33:03.67581+00
2563	54	21	f	f	2026-07-19 03:33:06.526647+00
2564	54	21	f	f	2026-07-19 03:33:10.689918+00
2566	54	21	f	f	2026-07-19 03:33:20.26128+00
2568	9	9	t	f	2026-07-19 03:33:28.120788+00
2569	121	24	f	f	2026-07-19 03:33:28.376737+00
2572	54	21	f	f	2026-07-19 03:33:51.730224+00
2574	54	21	f	f	2026-07-19 03:34:00.636831+00
2579	39	20	t	f	2026-07-19 03:35:02.46451+00
2582	94	19	f	f	2026-07-19 03:35:07.633062+00
2583	87	24	f	f	2026-07-19 03:35:13.388446+00
2584	94	19	f	f	2026-07-19 03:35:47.218995+00
2585	6	15	t	f	2026-07-19 03:35:49.519304+00
2586	92	14	f	f	2026-07-19 03:36:00.987804+00
2627	54	21	f	f	2026-07-19 03:38:19.874625+00
2628	54	21	f	f	2026-07-19 03:38:23.954547+00
2635	72	21	f	f	2026-07-19 03:39:02.462803+00
2650	54	21	f	f	2026-07-19 03:41:52.862399+00
2652	94	19	f	f	2026-07-19 03:42:16.800092+00
2653	39	14	f	f	2026-07-19 03:42:26.121655+00
2659	72	22	f	f	2026-07-19 03:43:02.02764+00
2660	113	21	f	f	2026-07-19 03:43:10.655576+00
2662	113	21	f	f	2026-07-19 03:43:25.004234+00
2663	54	21	f	f	2026-07-19 03:43:57.352534+00
2664	54	21	f	f	2026-07-19 03:44:02.290411+00
2665	54	21	f	f	2026-07-19 03:44:05.473546+00
2673	54	21	f	f	2026-07-19 03:45:29.488453+00
2674	9	5	f	f	2026-07-19 03:45:40.874782+00
2678	54	21	f	f	2026-07-19 03:46:00.854035+00
2679	54	21	f	f	2026-07-19 03:46:06.851027+00
3131	119	18	f	f	2026-07-19 04:58:58.200567+00
3132	137	19	f	f	2026-07-19 04:59:09.929889+00
3133	39	24	t	f	2026-07-19 04:59:54.490541+00
3134	54	14	f	f	2026-07-19 04:59:59.557602+00
3137	51	24	t	f	2026-07-19 05:00:20.590265+00
3138	48	24	f	f	2026-07-19 05:00:41.846924+00
3146	137	19	f	f	2026-07-19 05:04:01.13212+00
3163	71	22	f	f	2026-07-19 05:07:56.471838+00
3165	27	22	f	f	2026-07-19 05:08:29.443045+00
3168	18	19	f	f	2026-07-19 05:09:57.677755+00
3169	18	19	f	f	2026-07-19 05:10:43.136584+00
3171	133	26	f	f	2026-07-19 05:10:55.531318+00
3178	97	21	f	f	2026-07-19 05:15:07.246056+00
3179	29	22	f	f	2026-07-19 05:15:19.681912+00
3180	133	26	f	f	2026-07-19 05:15:26.94092+00
3190	34	5	f	f	2026-07-19 05:17:16.408142+00
3191	34	5	f	f	2026-07-19 05:17:23.339041+00
3192	18	19	f	f	2026-07-19 05:17:25.063331+00
3193	34	5	f	f	2026-07-19 05:17:30.551615+00
3195	34	5	f	f	2026-07-19 05:17:43.02917+00
3205	103	4	f	f	2026-07-19 05:19:20.733241+00
3208	48	14	f	f	2026-07-19 05:20:06.061272+00
3210	65	26	f	f	2026-07-19 05:20:45.82733+00
3212	18	19	f	f	2026-07-19 05:20:50.287146+00
1165	22	27	f	f	2026-07-19 01:19:59.72715+00
1167	89	14	f	f	2026-07-19 01:20:03.987146+00
1168	147	11	t	f	2026-07-19 01:20:07.529072+00
1172	25	23	t	f	2026-07-19 01:20:21.281642+00
1173	22	27	f	f	2026-07-19 01:20:23.70734+00
1175	47	15	f	f	2026-07-19 01:20:28.210272+00
1181	50	1	t	f	2026-07-19 01:20:56.346171+00
1182	92	27	f	f	2026-07-19 01:21:06.741873+00
1183	103	20	t	f	2026-07-19 01:21:07.729263+00
1184	80	9	f	f	2026-07-19 01:21:10.184298+00
1185	128	6	f	f	2026-07-19 01:21:12.426093+00
1204	92	27	f	f	2026-07-19 01:22:27.701349+00
1205	92	27	f	f	2026-07-19 01:22:28.838083+00
1207	71	22	f	f	2026-07-19 01:22:32.395889+00
1208	80	21	t	f	2026-07-19 01:22:36.690745+00
1209	4	21	t	f	2026-07-19 01:22:42.988818+00
1211	65	25	f	f	2026-07-19 01:22:49.736756+00
1214	21	25	f	f	2026-07-19 01:23:17.121389+00
1215	32	15	t	f	2026-07-19 01:23:18.091161+00
1219	77	26	f	f	2026-07-19 01:23:34.048731+00
1229	103	21	f	f	2026-07-19 01:24:14.675144+00
1617	113	19	f	f	2026-07-19 01:52:56.613667+00
1618	4	22	f	f	2026-07-19 01:52:58.843446+00
1626	89	14	f	f	2026-07-19 01:53:38.64217+00
1627	87	2	t	f	2026-07-19 01:53:39.980204+00
1638	77	5	f	f	2026-07-19 01:54:35.066887+00
1657	89	24	f	f	2026-07-19 01:55:53.232081+00
1658	89	24	f	f	2026-07-19 01:55:57.570348+00
1659	20	16	t	f	2026-07-19 01:55:57.895931+00
1663	148	8	t	f	2026-07-19 01:56:19.552875+00
1665	101	15	t	f	2026-07-19 01:56:32.804996+00
1667	60	27	f	f	2026-07-19 01:56:38.615206+00
1669	131	6	t	f	2026-07-19 01:56:57.509644+00
1698	88	21	f	f	2026-07-19 01:59:36.22708+00
1699	95	24	t	f	2026-07-19 01:59:38.842257+00
2193	44	22	f	f	2026-07-19 02:44:20.988639+00
2194	148	21	f	f	2026-07-19 02:44:21.143433+00
2204	53	13	t	f	2026-07-19 02:45:51.972737+00
2205	46	26	f	f	2026-07-19 02:46:14.455023+00
2206	25	25	f	f	2026-07-19 02:46:18.343552+00
2207	46	14	f	f	2026-07-19 02:46:27.961556+00
2208	106	2	t	f	2026-07-19 02:47:07.715634+00
2211	82	22	f	f	2026-07-19 02:47:30.670581+00
2213	67	24	t	f	2026-07-19 02:48:27.541068+00
2218	149	21	f	f	2026-07-19 02:48:45.551969+00
2221	32	14	f	f	2026-07-19 02:50:03.3049+00
2222	111	9	t	f	2026-07-19 02:50:06.905734+00
2223	110	10	t	f	2026-07-19 02:50:29.039018+00
2236	72	21	f	f	2026-07-19 02:52:44.891045+00
2237	72	21	f	f	2026-07-19 02:52:50.701659+00
2248	89	14	f	f	2026-07-19 02:54:06.045737+00
2249	81	19	f	f	2026-07-19 02:54:10.536535+00
2250	101	24	f	f	2026-07-19 02:54:26.785511+00
2252	89	14	f	f	2026-07-19 02:55:02.007276+00
2256	44	22	f	f	2026-07-19 02:55:56.465749+00
2258	80	14	f	f	2026-07-19 02:56:08.531672+00
2259	44	22	f	f	2026-07-19 02:56:15.029809+00
2264	44	22	f	f	2026-07-19 02:57:22.270435+00
2266	38	9	t	f	2026-07-19 02:57:32.502307+00
2270	80	7	f	f	2026-07-19 02:57:43.879637+00
2271	44	22	f	f	2026-07-19 02:57:52.824978+00
2272	101	24	t	f	2026-07-19 02:57:54.195734+00
2273	44	22	f	f	2026-07-19 02:57:58.667865+00
2274	112	16	f	f	2026-07-19 02:58:09.901021+00
2277	44	22	f	f	2026-07-19 02:58:44.601503+00
2285	51	18	f	f	2026-07-19 03:00:41.708074+00
2290	110	20	f	f	2026-07-19 03:01:31.605058+00
2291	148	13	t	f	2026-07-19 03:01:35.014704+00
2292	85	19	f	f	2026-07-19 03:01:37.474343+00
2294	6	20	t	f	2026-07-19 03:01:38.709131+00
2295	110	20	t	f	2026-07-19 03:01:52.080879+00
2300	6	1	t	f	2026-07-19 03:02:11.434118+00
2301	148	14	f	f	2026-07-19 03:02:14.902229+00
2312	95	14	f	f	2026-07-19 03:03:40.387329+00
2320	44	22	f	f	2026-07-19 03:05:09.124852+00
2340	101	25	f	f	2026-07-19 03:07:25.806943+00
2344	82	22	f	f	2026-07-19 03:07:39.073303+00
2348	101	25	f	f	2026-07-19 03:07:52.324721+00
2351	101	25	f	f	2026-07-19 03:08:22.461855+00
2701	94	19	f	f	2026-07-19 03:49:02.436268+00
2702	94	19	f	f	2026-07-19 03:49:29.864216+00
2712	6	22	t	f	2026-07-19 03:50:57.695079+00
3136	13	19	f	f	2026-07-19 05:00:13.68737+00
3140	65	26	f	f	2026-07-19 05:02:21.783931+00
3143	23	2	t	f	2026-07-19 05:03:00.182363+00
3147	18	19	f	f	2026-07-19 05:04:25.740798+00
3153	8	22	f	f	2026-07-19 05:06:14.172078+00
3154	8	22	f	f	2026-07-19 05:06:15.496514+00
3158	32	14	f	f	2026-07-19 05:06:29.094176+00
3159	82	15	t	f	2026-07-19 05:06:36.138863+00
3160	101	18	t	f	2026-07-19 05:07:14.28277+00
3166	54	14	f	f	2026-07-19 05:09:07.1458+00
3181	115	21	f	f	2026-07-19 05:15:32.282641+00
3182	4	19	f	f	2026-07-19 05:16:17.764991+00
3228	115	22	f	f	2026-07-19 05:22:16.765372+00
3230	115	22	f	f	2026-07-19 05:22:26.24384+00
3250	62	26	f	f	2026-07-19 05:25:53.313292+00
3252	8	22	f	f	2026-07-19 05:26:03.278579+00
3259	92	12	t	f	2026-07-19 05:27:33.49095+00
3496	36	14	f	f	2026-07-19 06:17:33.695878+00
3497	109	21	f	f	2026-07-19 06:17:53.023726+00
3499	87	19	f	f	2026-07-19 06:18:26.03364+00
3501	27	14	f	f	2026-07-19 06:20:15.022602+00
3502	155	6	f	f	2026-07-19 06:20:23.463575+00
3503	155	6	f	f	2026-07-19 06:20:28.107169+00
3504	32	13	f	f	2026-07-19 06:20:29.640534+00
3505	152	26	f	f	2026-07-19 06:20:50.930149+00
3506	155	6	f	f	2026-07-19 06:20:52.469101+00
3507	32	14	f	f	2026-07-19 06:20:56.402254+00
3737	121	4	f	f	2026-07-19 07:03:08.466793+00
3739	120	21	f	f	2026-07-19 07:03:35.268588+00
3740	54	22	f	f	2026-07-19 07:05:19.435459+00
3743	32	26	t	f	2026-07-19 07:06:16.533366+00
3744	24	5	f	f	2026-07-19 07:06:19.191524+00
3746	115	23	t	f	2026-07-19 07:06:33.289688+00
3747	5	10	t	f	2026-07-19 07:06:36.721236+00
3854	124	22	f	f	2026-07-19 07:40:16.906249+00
3857	115	27	f	f	2026-07-19 07:40:33.681512+00
3861	129	19	f	f	2026-07-19 07:41:22.912158+00
3862	154	27	f	f	2026-07-19 07:41:25.707749+00
3961	103	21	f	f	2026-07-19 08:03:23.008306+00
3962	155	15	t	f	2026-07-19 08:03:23.549378+00
3963	155	19	f	f	2026-07-19 08:04:20.174426+00
3967	155	19	f	f	2026-07-19 08:04:58.653386+00
3969	130	6	f	f	2026-07-19 08:05:19.088256+00
3970	130	6	f	f	2026-07-19 08:05:24.020188+00
3972	130	6	f	f	2026-07-19 08:05:24.686419+00
3964	155	19	f	f	2026-07-19 08:04:37.101525+00
3965	82	14	f	f	2026-07-19 08:04:39.937057+00
3966	130	6	f	f	2026-07-19 08:04:53.638146+00
3968	155	19	f	f	2026-07-19 08:05:00.583738+00
3971	130	6	f	f	2026-07-19 08:05:24.408497+00
3973	103	21	t	f	2026-07-19 08:05:33.316159+00
3974	130	6	f	f	2026-07-19 08:05:57.494481+00
3975	53	5	f	f	2026-07-19 08:07:23.27223+00
3976	130	6	t	f	2026-07-19 08:07:40.418171+00
3977	124	22	f	f	2026-07-19 08:08:54.396531+00
3978	124	22	f	f	2026-07-19 08:09:07.376029+00
3979	81	14	t	f	2026-07-19 08:09:15.668827+00
3980	124	22	f	f	2026-07-19 08:09:33.100248+00
3981	110	13	t	f	2026-07-19 08:10:03.21743+00
3982	27	9	t	f	2026-07-19 08:10:13.077528+00
3983	110	9	t	f	2026-07-19 08:11:07.877405+00
3984	5	13	t	f	2026-07-19 08:12:18.886156+00
3985	19	21	t	f	2026-07-19 08:12:41.076003+00
3986	100	1	f	f	2026-07-19 08:12:49.583011+00
3987	110	23	t	f	2026-07-19 08:12:52.236692+00
3988	19	14	f	f	2026-07-19 08:13:13.874979+00
3989	19	14	f	f	2026-07-19 08:13:26.457652+00
3990	19	14	f	f	2026-07-19 08:13:34.417628+00
3991	19	1	t	f	2026-07-19 08:13:54.113304+00
3992	22	19	f	f	2026-07-19 08:14:18.712156+00
3993	22	19	f	f	2026-07-19 08:14:32.485093+00
3994	5	19	f	f	2026-07-19 08:15:47.751297+00
3995	149	1	t	f	2026-07-19 08:16:37.973249+00
3996	97	21	f	f	2026-07-19 08:18:17.96353+00
3997	32	19	f	f	2026-07-19 08:18:22.877869+00
3998	19	22	f	f	2026-07-19 08:18:54.169111+00
3999	110	24	f	f	2026-07-19 08:19:18.134941+00
4000	19	14	f	f	2026-07-19 08:19:36.587506+00
4001	19	14	f	f	2026-07-19 08:19:45.275194+00
4002	115	13	f	f	2026-07-19 08:22:06.187166+00
4003	52	15	f	f	2026-07-19 08:22:06.633769+00
4004	115	13	f	f	2026-07-19 08:22:09.913689+00
4005	115	13	f	f	2026-07-19 08:22:13.052652+00
4006	115	13	f	f	2026-07-19 08:22:16.813734+00
4007	115	13	f	f	2026-07-19 08:22:19.907557+00
4008	115	13	f	f	2026-07-19 08:22:24.592174+00
4009	115	13	f	f	2026-07-19 08:22:27.994153+00
4010	115	13	f	f	2026-07-19 08:22:31.556578+00
4011	115	13	f	f	2026-07-19 08:22:35.500566+00
4012	115	13	f	f	2026-07-19 08:22:41.392689+00
4013	115	13	f	f	2026-07-19 08:23:07.039974+00
4014	32	19	f	f	2026-07-19 08:23:12.20147+00
4015	32	19	f	f	2026-07-19 08:23:13.746382+00
4016	115	13	f	f	2026-07-19 08:23:16.050404+00
4017	32	19	f	f	2026-07-19 08:23:16.258633+00
4018	32	19	f	f	2026-07-19 08:23:17.911919+00
4019	115	13	f	f	2026-07-19 08:23:20.13945+00
4020	115	13	f	f	2026-07-19 08:23:24.342302+00
4021	149	2	t	f	2026-07-19 08:23:28.752775+00
4022	115	13	f	f	2026-07-19 08:23:28.950568+00
4023	115	13	f	f	2026-07-19 08:23:32.637104+00
4024	115	13	f	f	2026-07-19 08:23:36.561556+00
4025	115	13	f	f	2026-07-19 08:23:39.940999+00
4026	115	13	f	f	2026-07-19 08:23:43.411594+00
4027	115	13	f	f	2026-07-19 08:23:49.053163+00
4028	110	24	f	f	2026-07-19 08:23:49.172718+00
4029	115	14	f	f	2026-07-19 08:27:41.222834+00
4030	115	14	f	f	2026-07-19 08:27:44.498821+00
4031	115	14	f	f	2026-07-19 08:27:47.816731+00
4032	115	14	f	f	2026-07-19 08:27:52.316637+00
4033	115	14	f	f	2026-07-19 08:27:56.837502+00
4034	115	14	f	f	2026-07-19 08:28:00.388362+00
4035	115	14	f	f	2026-07-19 08:28:03.667184+00
4036	115	14	f	f	2026-07-19 08:28:11.10231+00
4037	115	14	f	f	2026-07-19 08:28:18.729739+00
4038	115	14	f	f	2026-07-19 08:28:21.515981+00
4039	115	14	f	f	2026-07-19 08:28:55.785017+00
4040	115	14	f	f	2026-07-19 08:28:59.533314+00
4041	154	8	t	f	2026-07-19 08:29:00.991341+00
4042	115	14	f	f	2026-07-19 08:29:02.432706+00
4043	115	14	f	f	2026-07-19 08:29:05.664938+00
4044	115	14	f	f	2026-07-19 08:29:12.801526+00
4045	115	14	f	f	2026-07-19 08:29:16.061134+00
4046	115	14	f	f	2026-07-19 08:29:19.102967+00
4047	115	14	f	f	2026-07-19 08:29:22.154503+00
4048	115	14	f	f	2026-07-19 08:29:25.364141+00
4049	115	14	f	f	2026-07-19 08:29:30.075362+00
4050	81	10	t	f	2026-07-19 08:30:58.937254+00
4051	115	14	f	f	2026-07-19 08:32:08.849858+00
4052	115	14	f	f	2026-07-19 08:32:12.846416+00
4053	115	14	f	f	2026-07-19 08:32:17.549161+00
4054	94	19	f	f	2026-07-19 08:33:27.679961+00
4055	81	12	t	f	2026-07-19 08:33:31.739533+00
4056	94	19	f	f	2026-07-19 08:33:41.915811+00
4057	52	15	f	f	2026-07-19 08:35:08.926647+00
4058	52	15	f	f	2026-07-19 08:35:11.612395+00
4059	52	15	f	f	2026-07-19 08:35:18.615812+00
4060	52	15	f	f	2026-07-19 08:35:21.656693+00
4061	26	22	f	f	2026-07-19 08:35:26.562661+00
4062	32	19	f	f	2026-07-19 08:35:40.720863+00
4063	52	15	f	f	2026-07-19 08:35:46.671539+00
4064	52	15	f	f	2026-07-19 08:35:48.015792+00
4065	52	15	f	f	2026-07-19 08:35:49.432303+00
4066	52	15	f	f	2026-07-19 08:35:52.326592+00
4067	19	14	t	f	2026-07-19 08:36:30.421063+00
4068	32	19	f	f	2026-07-19 08:39:34.013593+00
4069	32	19	f	f	2026-07-19 08:39:40.089629+00
4070	81	9	t	f	2026-07-19 08:40:37.37012+00
4071	15	18	f	f	2026-07-19 08:40:53.378619+00
4072	149	5	f	f	2026-07-19 08:41:32.988911+00
4073	69	12	t	f	2026-07-19 08:41:52.454748+00
4074	149	5	f	f	2026-07-19 08:42:12.084706+00
4075	62	5	f	f	2026-07-19 08:42:33.763524+00
4076	15	18	f	f	2026-07-19 08:42:34.108012+00
4077	32	19	f	f	2026-07-19 08:42:47.008012+00
4078	32	19	f	f	2026-07-19 08:42:51.330387+00
4079	15	18	f	f	2026-07-19 08:43:22.000834+00
4080	15	18	f	f	2026-07-19 08:43:27.177999+00
4081	52	15	f	f	2026-07-19 08:43:30.744736+00
4082	52	15	f	f	2026-07-19 08:43:32.813442+00
4083	52	15	f	f	2026-07-19 08:43:36.668077+00
4084	52	15	f	f	2026-07-19 08:43:39.886438+00
4085	82	11	t	f	2026-07-19 08:43:42.982619+00
4086	37	10	t	f	2026-07-19 08:44:28.659728+00
4087	32	19	f	f	2026-07-19 08:46:37.640003+00
4088	152	19	f	f	2026-07-19 08:46:57.60578+00
4091	22	19	t	f	2026-07-19 08:48:36.699209+00
4093	62	5	f	f	2026-07-19 08:49:50.367172+00
4094	62	5	f	f	2026-07-19 08:50:02.7073+00
4099	133	5	f	f	2026-07-19 08:57:06.98897+00
4103	133	5	f	f	2026-07-19 08:57:25.723688+00
4104	120	13	t	f	2026-07-19 08:58:10.01994+00
4105	24	18	f	f	2026-07-19 08:58:25.99247+00
4106	92	18	f	f	2026-07-19 08:58:51.618441+00
4089	81	19	t	f	2026-07-19 08:47:14.48296+00
4090	22	19	f	f	2026-07-19 08:47:45.538071+00
4092	15	18	f	f	2026-07-19 08:48:56.28017+00
4095	23	9	t	f	2026-07-19 08:54:02.489047+00
4096	53	5	f	f	2026-07-19 08:56:28.330399+00
4097	53	5	f	f	2026-07-19 08:56:29.941537+00
4098	133	5	f	f	2026-07-19 08:57:06.185392+00
4100	92	18	f	f	2026-07-19 08:57:17.103431+00
4101	62	5	f	f	2026-07-19 08:57:18.430835+00
4102	53	5	f	f	2026-07-19 08:57:21.131676+00
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teams (id, name, division_id, created_at) FROM stdin;
1	A***n	1	2026-07-17 11:13:35.609458+00
2	나***********요	2	2026-07-17 13:13:24.895693+00
3	신****************************즈	2	2026-07-17 13:14:30.380933+00
4	킹**킹	2	2026-07-17 13:14:35.319853+00
5	정*민	2	2026-07-17 13:14:39.492068+00
6	d***m	2	2026-07-17 13:14:44.511403+00
7	복**********아	2	2026-07-17 13:15:23.169727+00
8	스*********요	2	2026-07-17 13:15:43.418147+00
9	검***대	2	2026-07-17 13:15:46.37603+00
10	세***~	2	2026-07-17 13:15:49.188194+00
11	티**미	2	2026-07-17 13:15:53.165462+00
12	제***************어	2	2026-07-17 13:16:15.115121+00
13	K***m	2	2026-07-17 13:16:17.907402+00
14	야******키	2	2026-07-17 13:16:20.435389+00
15	이*댄	2	2026-07-17 13:16:23.143046+00
16	A**************다	2	2026-07-17 13:16:26.725913+00
17	둘*****.	2	2026-07-17 13:16:30.066676+00
18	두*********강	2	2026-07-17 13:16:34.275053+00
19	n***a	2	2026-07-17 13:16:38.712203+00
20	융*'	2	2026-07-17 13:16:43.466289+00
21	T***3	2	2026-07-17 13:17:26.183954+00
22	던****함	2	2026-07-17 13:17:29.853631+00
23	s******자	2	2026-07-17 13:17:32.761798+00
24	알****요	2	2026-07-17 13:17:36.23736+00
25	즐*러	2	2026-07-17 13:17:40.17137+00
26	김**이	2	2026-07-17 13:17:43.490826+00
27	루*****요	2	2026-07-17 13:17:46.490188+00
28	존***********끝	2	2026-07-17 13:17:49.236395+00
29	니*****라	2	2026-07-17 13:17:52.04207+00
30	쉬****년	2	2026-07-17 13:17:56.08306+00
31	s***O	2	2026-07-17 13:18:12.340426+00
32	팀****지	2	2026-07-17 13:18:15.718047+00
33	P***G	2	2026-07-17 13:18:18.619896+00
34	방*회	2	2026-07-17 13:18:21.303764+00
35	c***t	2	2026-07-17 13:18:24.37019+00
36	송*평	2	2026-07-17 13:18:28.417806+00
37	s***s	2	2026-07-17 13:18:31.568441+00
38	A***0	2	2026-07-17 13:18:39.937895+00
39	Y***w	2	2026-07-17 13:18:43.239826+00
40	A***a	2	2026-07-17 13:18:45.878657+00
41	감********게	2	2026-07-17 13:18:48.607635+00
42	팀*팀	2	2026-07-17 13:18:51.127296+00
43	K***N	2	2026-07-17 13:18:53.7292+00
44	P***c	2	2026-07-17 13:18:56.6685+00
45	더****************)	2	2026-07-17 13:18:59.885044+00
46	혼******팅	2	2026-07-17 13:19:06.846809+00
47	두**치	2	2026-07-17 13:19:14.496883+00
48	J***E	2	2026-07-17 13:19:17.425277+00
49	상******************림	2	2026-07-17 13:19:22.057322+00
50	S***H	2	2026-07-17 13:19:25.250628+00
51	현****대	2	2026-07-17 13:19:28.027093+00
52	M***A	2	2026-07-17 13:19:31.193168+00
53	시*****다	2	2026-07-17 13:19:35.676779+00
54	한**만	2	2026-07-17 13:19:38.126765+00
55	주**이	2	2026-07-17 13:19:40.925013+00
56	J***G	2	2026-07-17 13:19:43.363892+00
57	c***9	2	2026-07-17 13:19:49.044239+00
58	Z***0	2	2026-07-17 13:19:56.94412+00
59	O***x	2	2026-07-17 13:19:59.555213+00
60	한*******교	2	2026-07-17 13:20:02.196736+00
61	플****호	2	2026-07-17 13:20:04.918492+00
62	오***리	2	2026-07-17 13:20:07.543409+00
63	f*********찬	2	2026-07-17 13:20:10.886255+00
64	b***r	2	2026-07-17 13:20:13.484074+00
65	자******스	2	2026-07-17 13:20:16.23219+00
66	4*************썬	2	2026-07-17 13:20:19.283055+00
67	슈******이	2	2026-07-17 13:20:21.88545+00
68	A***A	2	2026-07-17 13:20:30.903448+00
69	금**장	2	2026-07-17 13:20:34.463401+00
70	s***o	2	2026-07-17 13:20:37.552115+00
71	H***R	2	2026-07-17 13:20:40.505274+00
72	으**준	2	2026-07-17 13:20:43.343423+00
73	J***k	2	2026-07-17 13:20:45.926536+00
74	낭******고	2	2026-07-17 13:20:48.761988+00
75	S***2_2	2	2026-07-17 13:20:51.427357+00
76	야************택	2	2026-07-17 13:20:54.062202+00
77	리*쌍	2	2026-07-17 13:20:56.484297+00
78	s***g	2	2026-07-17 13:20:59.034313+00
79	팀********.	3	2026-07-17 13:21:09.110497+00
80	S***A	3	2026-07-17 13:21:13.006139+00
81	N***p	3	2026-07-17 13:21:15.420489+00
82	김*우	3	2026-07-17 13:21:17.817939+00
83	두*********교	3	2026-07-17 13:21:20.631558+00
84	아*******************************게	3	2026-07-17 13:21:23.361633+00
85	s**********요	3	2026-07-17 13:21:27.040134+00
86	광****************들	3	2026-07-17 13:21:29.966228+00
87	#***h	3	2026-07-17 13:21:33.299338+00
88	플*********게	3	2026-07-17 13:21:36.145066+00
89	0***E	3	2026-07-17 13:21:38.890178+00
90	조***이	3	2026-07-17 13:21:41.656638+00
91	g***************봐	3	2026-07-17 13:21:44.409544+00
92	p***n	3	2026-07-17 13:21:47.089655+00
93	C***a	3	2026-07-17 13:21:49.74876+00
94	배*****어	3	2026-07-17 13:21:53.860109+00
95	영******크	3	2026-07-17 13:21:56.547544+00
96	스******점	3	2026-07-17 13:21:58.926869+00
97	엄*************************요	3	2026-07-17 13:22:01.558095+00
98	D***P	3	2026-07-17 13:22:04.447787+00
99	0***4	3	2026-07-17 13:22:07.194864+00
100	*	3	2026-07-17 13:22:10.349672+00
101	@***e	3	2026-07-17 13:22:13.051442+00
102	f***e	3	2026-07-17 13:22:15.628398+00
103	1***************트	3	2026-07-17 13:22:18.72649+00
104	c***n	3	2026-07-17 13:22:21.897238+00
105	안************다	3	2026-07-17 13:22:25.020583+00
107	세**1	2	2026-07-19 00:15:02.921689+00
108	세**2	3	2026-07-19 00:15:12.073853+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, username, password_hash, role, team_id, blocked_reason, blocked_at, created_at, updated_at) FROM stdin;
1	a********n@sca-ctf.com	a***n	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	admin	1	\N	\N	2026-07-17 11:13:35.890975+00	2026-07-17 11:13:35.890975+00
42	w********8@gmail.com	N***O	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	55	\N	\N	2026-07-18 11:38:42.293823+00	2026-07-18 11:38:42.293823+00
3	m********1@naver.com	김*경	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	34	\N	\N	2026-07-18 11:01:30.255168+00	2026-07-18 11:01:30.255168+00
4	k********3@gmail.com	b***2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	43	\N	\N	2026-07-18 11:01:49.852826+00	2026-07-18 11:01:49.852826+00
5	e********7@gmail.com	e***7	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	12	\N	\N	2026-07-18 11:02:00.447028+00	2026-07-18 11:02:00.447028+00
6	k********5_2@gmail.com	3***J	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	72	\N	\N	2026-07-18 11:02:08.849289+00	2026-07-18 11:02:08.849289+00
7	k********0@gmail.com	c***t	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	83	\N	\N	2026-07-18 11:02:27.269985+00	2026-07-18 11:02:27.269985+00
8	h********6_3@gmail.com	W***3	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	91	\N	\N	2026-07-18 11:02:54.287764+00	2026-07-18 11:02:54.287764+00
9	w********5@korea.ac.kr	y***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	59	\N	\N	2026-07-18 11:02:58.951638+00	2026-07-18 11:02:58.951638+00
10	0********e@gmail.com	m***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	44	\N	\N	2026-07-18 11:03:35.788116+00	2026-07-18 11:03:35.788116+00
11	k********9_2@gmail.com	m***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	44	\N	\N	2026-07-18 11:04:34.682119+00	2026-07-18 11:04:34.682119+00
12	s********9_2@gmail.com	m***d	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	16	\N	\N	2026-07-18 11:04:57.353018+00	2026-07-18 11:04:57.353018+00
13	a********f@gmail.com	a***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	3	\N	\N	2026-07-18 11:05:13.459576+00	2026-07-18 11:05:13.459576+00
15	g********5@naver.com	G***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	52	\N	\N	2026-07-18 11:06:33.690066+00	2026-07-18 11:06:33.690066+00
16	k********6@gmail.com	l***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	96	\N	\N	2026-07-18 11:06:47.556785+00	2026-07-18 11:06:47.556785+00
17	q********0@gmail.com	Q***Q	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	75	\N	\N	2026-07-18 11:07:47.940612+00	2026-07-18 11:07:47.940612+00
18	k********r@gmail.com	N***0	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	79	\N	\N	2026-07-18 11:08:02.522743+00	2026-07-18 11:08:02.522743+00
19	s********5@naver.com	J***G	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	56	\N	\N	2026-07-18 11:09:08.05554+00	2026-07-18 11:09:08.05554+00
20	r********0@korea.ac.kr	s***0_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	6	\N	\N	2026-07-18 11:10:09.648663+00	2026-07-18 11:10:09.648663+00
21	a********i@sju.ac.kr	A***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	6	\N	\N	2026-07-18 11:10:12.139905+00	2026-07-18 11:10:12.139905+00
22	h********6_2@gmail.com	M***W	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	103	\N	\N	2026-07-18 11:12:34.606858+00	2026-07-18 11:12:34.606858+00
23	h********7@gmail.com	s***5_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	99	\N	\N	2026-07-18 11:15:42.459409+00	2026-07-18 11:15:42.459409+00
25	h********1@gmail.com	즐*요	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	73	\N	\N	2026-07-18 11:19:39.769319+00	2026-07-18 11:19:39.769319+00
26	s********t@gmail.com	s***1_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	22	\N	\N	2026-07-18 11:19:44.735445+00	2026-07-18 11:19:44.735445+00
28	h********9@gmail.com	j***r	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	46	\N	\N	2026-07-18 11:20:44.131781+00	2026-07-18 11:20:44.131781+00
29	b********7@gmail.com	r***h	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	84	\N	\N	2026-07-18 11:21:15.621206+00	2026-07-18 11:21:15.621206+00
24	h********e_2@gmail.com	1***꺼	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	101	\N	\N	2026-07-18 11:19:01.319792+00	2026-07-18 11:19:01.319792+00
27	j********8_2@naver.com	C***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	23	\N	\N	2026-07-18 11:20:36.529998+00	2026-07-18 11:20:36.529998+00
30	h********e@gmail.com	m***u	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	90	\N	\N	2026-07-18 11:23:20.021003+00	2026-07-18 11:23:20.021003+00
32	k********y@gmail.com	D***1	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	12	\N	\N	2026-07-18 11:25:03.771828+00	2026-07-18 11:25:03.771828+00
33	m********8@gmail.com	p***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	63	\N	\N	2026-07-18 11:25:15.880784+00	2026-07-18 11:25:15.880784+00
34	j********9@gmail.com	p***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	84	\N	\N	2026-07-18 11:25:56.694683+00	2026-07-18 11:25:56.694683+00
35	s********2_2@gmail.com	벼***되	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	97	\N	\N	2026-07-18 11:27:17.098917+00	2026-07-18 11:27:17.098917+00
36	s********5@gmail.com	D***l	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	22	\N	\N	2026-07-18 11:27:50.039278+00	2026-07-18 11:27:50.039278+00
37	r********1@gmail.com	p***s	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	86	\N	\N	2026-07-18 11:29:06.295084+00	2026-07-18 11:29:06.295084+00
38	f********m@gmail.com	k***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	77	\N	\N	2026-07-18 11:31:36.728882+00	2026-07-18 11:31:36.728882+00
39	w********2@naver.com	p***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	26	\N	\N	2026-07-18 11:33:32.536654+00	2026-07-18 11:33:32.536654+00
40	m********e@itskimlot.dev	i***2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	87	\N	\N	2026-07-18 11:34:39.808323+00	2026-07-18 11:34:39.808323+00
41	g********7@gmail.com	h***m	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	30	\N	\N	2026-07-18 11:38:40.139073+00	2026-07-18 11:38:40.139073+00
43	y********9@gmail.com	y***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	17	\N	\N	2026-07-18 11:40:08.189622+00	2026-07-18 11:40:08.189622+00
44	r********2_2@gmail.com	교*리	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	69	\N	\N	2026-07-18 11:40:57.826431+00	2026-07-18 11:40:57.826431+00
45	t********0@gmail.com	서*건	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	69	\N	\N	2026-07-18 11:42:19.098925+00	2026-07-18 11:42:19.098925+00
46	m********g@gmail.com	K***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	80	\N	\N	2026-07-18 11:43:08.124823+00	2026-07-18 11:43:08.124823+00
47	c********t@marulee.dev	M***v	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	96	\N	\N	2026-07-18 11:43:34.06579+00	2026-07-18 11:43:34.06579+00
48	m********m@gmail.com	s***2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	81	\N	\N	2026-07-18 11:44:26.591383+00	2026-07-18 11:44:26.591383+00
49	b********r@gmail.com	b***r	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	64	\N	\N	2026-07-18 11:46:56.859736+00	2026-07-18 11:46:56.859736+00
50	g********2@gmail.com	n***4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	65	\N	\N	2026-07-18 11:48:18.362139+00	2026-07-18 11:48:18.362139+00
51	h********6@gmail.com	T***s	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	85	\N	\N	2026-07-18 11:48:30.139288+00	2026-07-18 11:48:30.139288+00
52	s********0@gmail.com	g***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	54	\N	\N	2026-07-18 11:49:37.091792+00	2026-07-18 11:49:37.091792+00
53	z********k@gmail.com	e***2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	43	\N	\N	2026-07-18 11:50:24.375281+00	2026-07-18 11:50:24.375281+00
54	s********d@gmail.com	Y***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	29	\N	\N	2026-07-18 11:51:25.065676+00	2026-07-18 11:51:25.065676+00
55	g********7@naver.com	g***7	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	54	\N	\N	2026-07-18 11:51:58.511511+00	2026-07-18 11:51:58.511511+00
56	7********m@gmail.com	N***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	65	\N	\N	2026-07-18 11:53:02.403575+00	2026-07-18 11:53:02.403575+00
31	c********6@gmail.com	바******다	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	97	\N	\N	2026-07-18 11:23:30.342174+00	2026-07-18 11:23:30.342174+00
58	u********4@ewha.ac.kr	s***7_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	78	\N	\N	2026-07-18 12:02:50.582853+00	2026-07-18 12:02:50.582853+00
59	z********3@yonsei.ac.kr	z***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	56	\N	\N	2026-07-18 12:07:52.368417+00	2026-07-18 12:07:52.368417+00
60	d********9@gmail.com	d***t	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	93	\N	\N	2026-07-18 12:08:16.366503+00	2026-07-18 12:08:16.366503+00
61	l********2_2@gmail.com	D***r	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	17	\N	\N	2026-07-18 12:10:36.426678+00	2026-07-18 12:10:36.426678+00
62	r********3@gmail.com	s***n	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	45	\N	\N	2026-07-18 12:13:27.558943+00	2026-07-18 12:13:27.558943+00
63	j********1@gmail.com	M***g	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	95	\N	\N	2026-07-18 12:13:55.029675+00	2026-07-18 12:13:55.029675+00
64	h********9@naver.com	P***k	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	18	\N	\N	2026-07-18 12:17:13.544008+00	2026-07-18 12:17:13.544008+00
65	t********8@gmail.com	H***c	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	59	\N	\N	2026-07-18 12:23:22.456286+00	2026-07-18 12:23:22.456286+00
66	d********7@gmail.com	K***W	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	99	\N	\N	2026-07-18 12:25:15.368083+00	2026-07-18 12:25:15.368083+00
67	u********7@gmail.com	K***m	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	75	\N	\N	2026-07-18 12:28:40.634593+00	2026-07-18 12:28:40.634593+00
68	w********4@gmail.com	t***s	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	13	\N	\N	2026-07-18 12:29:41.917163+00	2026-07-18 12:29:41.917163+00
69	l********1@gmail.com	F***O	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	68	\N	\N	2026-07-18 12:35:48.247942+00	2026-07-18 12:35:48.247942+00
70	c********8@gmail.com	A***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	40	\N	\N	2026-07-18 12:49:19.067863+00	2026-07-18 12:49:19.067863+00
71	k********5_3@gmail.com	m***0	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	91	\N	\N	2026-07-18 12:49:54.672039+00	2026-07-18 12:49:54.672039+00
72	1********o@naver.com	인*썰	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	3	\N	\N	2026-07-18 12:50:03.49727+00	2026-07-18 12:50:03.49727+00
74	h********3@gmail.com	n***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	5	\N	\N	2026-07-18 12:51:12.104144+00	2026-07-18 12:51:12.104144+00
75	y********3@naver.com	y***h	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	66	\N	\N	2026-07-18 13:04:27.646936+00	2026-07-18 13:04:27.646936+00
76	a********5@gmail.com	박*현	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	50	\N	\N	2026-07-18 13:07:28.015027+00	2026-07-18 13:07:28.015027+00
77	g********1@naver.com	g***1	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	86	\N	\N	2026-07-18 13:07:44.590471+00	2026-07-18 13:07:44.590471+00
78	c********0@naver.com	z***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	66	\N	\N	2026-07-18 13:08:10.755669+00	2026-07-18 13:08:10.755669+00
79	m********0@konkuk.ac.kr	D***G	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	28	\N	\N	2026-07-18 13:11:37.466931+00	2026-07-18 13:11:37.466931+00
80	1********y@gmail.com	Z***0	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	58	\N	\N	2026-07-18 13:13:15.269282+00	2026-07-18 13:13:15.269282+00
81	b********_@swu.ac.kr	Y***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	8	\N	\N	2026-07-18 13:17:30.09319+00	2026-07-18 13:17:30.09319+00
82	p********n@naver.com	C***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	30	\N	\N	2026-07-18 13:18:36.422932+00	2026-07-18 13:18:36.422932+00
83	o********n@gmail.com	o***c	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	18	\N	\N	2026-07-18 13:18:38.51461+00	2026-07-18 13:18:38.51461+00
84	a********1@naver.com	s***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	8	\N	\N	2026-07-18 13:22:13.051946+00	2026-07-18 13:22:13.051946+00
85	y********1@gmail.com	R***b	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	9	\N	\N	2026-07-18 13:23:59.989532+00	2026-07-18 13:23:59.989532+00
86	g********g@gmail.com	T***z	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	100	\N	\N	2026-07-18 13:30:26.856018+00	2026-07-18 13:30:26.856018+00
87	v********9@gmail.com	잼*이	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	101	\N	\N	2026-07-18 13:42:19.070041+00	2026-07-18 13:42:19.070041+00
88	a********8@naver.com	o***o	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	41	\N	\N	2026-07-18 13:43:00.971477+00	2026-07-18 13:43:00.971477+00
89	d********4@gmail.com	s***f	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	28	\N	\N	2026-07-18 13:44:48.028029+00	2026-07-18 13:44:48.028029+00
90	q********5@naver.com	밤**람	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	76	\N	\N	2026-07-18 13:47:36.329711+00	2026-07-18 13:47:36.329711+00
91	c********7@gmail.com	c***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	47	\N	\N	2026-07-18 13:58:12.10742+00	2026-07-18 13:58:12.10742+00
92	g********6@gmail.com	아*랑	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	27	\N	\N	2026-07-18 14:02:54.881113+00	2026-07-18 14:02:54.881113+00
73	w********4@naver.com	고******생	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	33	\N	\N	2026-07-18 12:50:14.786618+00	2026-07-18 12:50:14.786618+00
93	6********e@gmail.com	c***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	104	\N	\N	2026-07-18 14:12:23.257063+00	2026-07-18 14:12:23.257063+00
94	m********9@gmail.com	S***y	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	79	\N	\N	2026-07-18 14:15:57.64759+00	2026-07-18 14:15:57.64759+00
95	s********1@dimigo.hs.kr	a***z	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	80	\N	\N	2026-07-18 14:18:45.111934+00	2026-07-18 14:18:45.111934+00
96	m********e@juwon21.kr	L***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	88	\N	\N	2026-07-18 14:20:15.70063+00	2026-07-18 14:20:15.70063+00
97	h********r@gmail.com	H***R	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	71	\N	\N	2026-07-18 14:21:40.780464+00	2026-07-18 14:21:40.780464+00
98	e********n@gmail.com	c***o	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	39	\N	\N	2026-07-18 14:32:34.871468+00	2026-07-18 14:32:34.871468+00
99	j********n@naver.com	J***0	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	41	\N	\N	2026-07-18 14:33:08.075977+00	2026-07-18 14:33:08.075977+00
100	a********1@gmail.com	D***A	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	98	\N	\N	2026-07-18 14:39:52.323929+00	2026-07-18 14:39:52.323929+00
101	w********s@gmail.com	C***s	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	36	\N	\N	2026-07-18 14:45:48.390794+00	2026-07-18 14:45:48.390794+00
102	4********3@gmail.com	r***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	87	\N	\N	2026-07-18 14:50:48.877482+00	2026-07-18 14:50:48.877482+00
103	s********0_2@gmail.com	s***r	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	82	\N	\N	2026-07-18 14:51:53.499411+00	2026-07-18 14:51:53.499411+00
104	c********r@shxn.dev	e***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	88	\N	\N	2026-07-18 14:55:42.891749+00	2026-07-18 14:55:42.891749+00
105	t********1@gmail.com	j***w	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	9	\N	\N	2026-07-18 15:28:21.222099+00	2026-07-18 15:28:21.222099+00
106	s********7@gmail.com	g***p	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	51	\N	\N	2026-07-18 15:37:48.732306+00	2026-07-18 15:37:48.732306+00
107	s********7@cau.ac.kr	s***7_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	51	\N	\N	2026-07-18 15:40:04.027465+00	2026-07-18 15:40:04.027465+00
108	d********3@gmail.com	s***0_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	4	\N	\N	2026-07-18 15:48:30.023577+00	2026-07-18 15:48:30.023577+00
109	s********j@naver.com	s***8	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	39	\N	\N	2026-07-18 15:50:37.55883+00	2026-07-18 15:50:37.55883+00
110	p********1@gmail.com	생********명	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	13	\N	\N	2026-07-18 15:57:50.389403+00	2026-07-18 15:57:50.389403+00
111	c********9@kyonggi.ac.kr	c***9	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	57	\N	\N	2026-07-18 16:08:22.887237+00	2026-07-18 16:08:22.887237+00
112	r********y@gmail.com	n***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	83	\N	\N	2026-07-18 16:10:00.892469+00	2026-07-18 16:10:00.892469+00
114	m********e@trillion-won.com	l***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	90	\N	\N	2026-07-18 16:20:11.279108+00	2026-07-18 16:20:11.279108+00
115	g********6_2@gmail.com	t***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	29	\N	\N	2026-07-18 16:23:50.874511+00	2026-07-18 16:23:50.874511+00
116	l********2@gmail.com	m***5	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	77	\N	\N	2026-07-18 16:33:10.421317+00	2026-07-18 16:33:10.421317+00
117	g********9@gmail.com	G***9	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	82	\N	\N	2026-07-18 16:36:14.33759+00	2026-07-18 16:36:14.33759+00
118	n********n@swu.ac.kr	n***3	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	11	\N	\N	2026-07-18 16:48:00.400884+00	2026-07-18 16:48:00.400884+00
119	j********8@naver.com	w***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	60	\N	\N	2026-07-18 16:53:31.638084+00	2026-07-18 16:53:31.638084+00
120	m********e@4den0ma.dev	4***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	7	\N	\N	2026-07-18 17:06:20.836565+00	2026-07-18 17:06:20.836565+00
121	b********k@gmail.com	s***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	16	\N	\N	2026-07-18 17:32:28.770061+00	2026-07-18 17:32:28.770061+00
122	d********6@gmail.com	g***o	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	67	\N	\N	2026-07-18 17:46:51.184239+00	2026-07-18 17:46:51.184239+00
123	k********9@gmail.com	s***1_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	73	\N	\N	2026-07-18 17:54:07.784478+00	2026-07-18 17:54:07.784478+00
124	c********7_2@gmail.com	C***2_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	32	\N	\N	2026-07-18 22:40:21.064388+00	2026-07-18 22:40:21.064388+00
125	w********y@proton.me	w***y	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	21	\N	\N	2026-07-18 22:47:59.63129+00	2026-07-18 22:47:59.63129+00
126	_********p@kakao.com	d***p	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	21	\N	\N	2026-07-18 23:12:25.893551+00	2026-07-18 23:12:25.893551+00
127	2********e@naver.com	s***l	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	92	\N	\N	2026-07-18 23:22:06.299475+00	2026-07-18 23:22:06.299475+00
128	g********o@icloud.com	B***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	92	\N	\N	2026-07-18 23:31:53.654501+00	2026-07-18 23:31:53.654501+00
113	q********9@gmail.com	내**다	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	26	\N	\N	2026-07-18 16:18:49.602115+00	2026-07-18 16:18:49.602115+00
129	s********7_2@gmail.com	5***7	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	32	\N	\N	2026-07-18 23:50:40.386495+00	2026-07-18 23:50:40.386495+00
130	g********8@gmail.com	g***@	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	48	\N	\N	2026-07-18 23:51:41.245298+00	2026-07-18 23:51:41.245298+00
131	i********y@gmail.com	i***y	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	49	\N	\N	2026-07-18 23:53:30.584533+00	2026-07-18 23:53:30.584533+00
132	d********0@naver.com	양*찬	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	63	\N	\N	2026-07-18 23:54:35.740562+00	2026-07-18 23:54:35.740562+00
133	c********2@sch.ac.kr	u***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	45	\N	\N	2026-07-18 23:55:49.61691+00	2026-07-18 23:55:49.61691+00
134	k********b@gmail.com	4***j	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	98	\N	\N	2026-07-18 23:56:39.931421+00	2026-07-18 23:56:39.931421+00
135	j********2@gmail.com	n***1	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	35	\N	\N	2026-07-18 23:58:35.951588+00	2026-07-18 23:58:35.951588+00
136	s********9@gmail.com	s***9_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	70	\N	\N	2026-07-19 00:03:21.871016+00	2026-07-19 00:03:21.871016+00
137	t********h@gmail.com	C***E	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	81	\N	\N	2026-07-19 00:06:50.843369+00	2026-07-19 00:06:50.843369+00
57	0********a@gmail.com	a***0	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	38	\N	\N	2026-07-18 11:57:20.287654+00	2026-07-18 11:57:20.287654+00
138	y********8@gmail.com	y***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	89	\N	\N	2026-07-19 00:07:29.17054+00	2026-07-19 00:07:29.17054+00
139	h********m@gmail.com	h***3	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	52	\N	\N	2026-07-19 00:08:19.665754+00	2026-07-19 00:08:19.665754+00
140	a********0@gmail.com	s***2_10	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	89	\N	\N	2026-07-19 00:09:44.272841+00	2026-07-19 00:09:44.272841+00
141	s********1@gmail.com	s***3	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	107	\N	\N	2026-07-19 00:16:33.675993+00	2026-07-19 00:16:33.675993+00
142	s********a@gmail.com	s***s	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	107	\N	\N	2026-07-19 00:16:53.956981+00	2026-07-19 00:16:53.956981+00
143	s********2@gmail.com	s***3_2	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	108	\N	\N	2026-07-19 00:16:54.089467+00	2026-07-19 00:16:54.089467+00
144	n********r@gmail.com	h***e	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	31	\N	\N	2026-07-19 00:30:38.797069+00	2026-07-19 00:30:38.797069+00
145	y********6@gmail.com	y***i	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	49	\N	\N	2026-07-19 00:34:14.911076+00	2026-07-19 00:34:14.911076+00
146	a********8@gmail.com	뚜*뚜	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	11	\N	\N	2026-07-19 00:35:23.753285+00	2026-07-19 00:35:23.753285+00
147	k********0_2@gmail.com	k***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	85	\N	\N	2026-07-19 00:45:53.91155+00	2026-07-19 00:45:53.91155+00
148	s********4@gmail.com	b***b	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	24	\N	\N	2026-07-19 01:08:38.100603+00	2026-07-19 01:08:38.100603+00
149	n********y@gmail.com	j***y	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	94	\N	\N	2026-07-19 01:10:43.306273+00	2026-07-19 01:10:43.306273+00
150	s********a_2@gmail.com	안*빈	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	42	\N	\N	2026-07-19 01:18:22.75305+00	2026-07-19 01:18:22.75305+00
151	2********1@sunrint.hs.kr	b***m	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	105	\N	\N	2026-07-19 01:46:16.934476+00	2026-07-19 01:46:16.934476+00
152	c********1@naver.com	만*웅	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	24	\N	\N	2026-07-19 02:15:07.640936+00	2026-07-19 02:15:07.640936+00
153	r********2@gmail.com	d***h	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	74	\N	\N	2026-07-19 02:17:15.766803+00	2026-07-19 02:17:15.766803+00
154	y********a@mokpo.ac.kr	Y***a	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	67	\N	\N	2026-07-19 03:16:28.399085+00	2026-07-19 03:16:28.399085+00
155	k********5@gmail.com	k***d	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	2	\N	\N	2026-07-19 03:52:25.62855+00	2026-07-19 03:52:25.62855+00
156	h********y@kw.ac.kr	h***2_4	$2b$12$XNre/oyfXM3DEewQtihWsOXMl05/nHluENViGfXbJH9qmUPSh58Oe	user	14	\N	\N	2026-07-19 05:38:44.349772+00	2026-07-19 05:38:44.349772+00
\.


--
-- Data for Name: vms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vms (id, user_id, challenge_id, vm_id, status, node_name, external_ip, ports, ttl_expires_at, last_error, created_at, updated_at) FROM stdin;
416	93	11	vm-93-11-6e0468416691	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 31077, "container_port": 31340}]	2026-07-19 02:41:46.028157+00	\N	2026-07-19 01:41:46.043215+00	2026-07-19 02:11:56.154191+00
887	119	12	vm-119-12-d5d0c09ec194	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 18886, "container_port": 31337}]	2026-07-19 06:30:39.936293+00	\N	2026-07-19 05:30:39.951513+00	2026-07-19 05:43:08.79642+00
1105	155	4	vm-155-4-4f561dc27394	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 25537, "container_port": 8000}]	2026-07-19 08:52:15.202946+00	\N	2026-07-19 07:52:15.217094+00	2026-07-19 07:52:48.117199+00
1094	101	4	vm-101-4-d523c47f6285	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 13537, "container_port": 8000}]	2026-07-19 08:40:46.695578+00	\N	2026-07-19 07:40:46.710918+00	2026-07-19 07:44:10.558767+00
776	8	9	vm-8-9-ca707d692b59	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 24156, "container_port": 31337}]	2026-07-19 05:27:49.53346+00	\N	2026-07-19 04:27:49.549016+00	2026-07-19 04:34:12.76433+00
1190	85	4	vm-85-4-ac0149e3a4ca	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 18093, "container_port": 8000}]	2026-07-19 09:56:30.464435+00	\N	2026-07-19 08:56:30.478537+00	2026-07-19 09:11:30.77904+00
1176	24	12	vm-24-12-0350c3163026	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 19377, "container_port": 31337}]	2026-07-19 09:39:14.255915+00	\N	2026-07-19 08:39:14.27103+00	2026-07-19 09:00:36.327548+00
80	90	2	vm-90-2-924c1af1b26d	Running	xw-smc17-1	host8.sca-ctf.com	[{"protocol": "tcp", "host_port": 12688, "container_port": 1337}]	2026-07-19 01:01:15.474246+00	\N	2026-07-19 00:01:15.489586+00	2026-07-19 00:54:32.000057+00
746	73	9	vm-73-9-e450681b61c0	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 29379, "container_port": 31337}]	2026-07-19 05:12:51.507149+00	\N	2026-07-19 04:12:51.52192+00	2026-07-19 04:22:14.055728+00
1098	46	10	vm-46-10-743e8a12ce9a	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 23337, "container_port": 31337}]	2026-07-19 08:45:54.46402+00	\N	2026-07-19 07:45:54.478431+00	2026-07-19 08:31:06.154197+00
377	1	3	vm-1-3-6a6666776581	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 12565, "container_port": 8000}]	2026-07-19 02:31:23.650486+00	\N	2026-07-19 01:31:23.664327+00	2026-07-19 02:04:22.024356+00
324	16	11	vm-16-11-dd27c4bfa4c2	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 15267, "container_port": 31340}]	2026-07-19 02:13:12.089697+00	\N	2026-07-19 01:13:12.104688+00	2026-07-19 01:28:54.839849+00
865	119	4	vm-119-4-a09633d8abb2	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 30032, "container_port": 8000}]	2026-07-19 06:15:29.482153+00	\N	2026-07-19 05:15:29.496476+00	2026-07-19 05:29:52.914454+00
1143	39	9	vm-39-9-6a4eeaf5c555	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 31540, "container_port": 31337}]	2026-07-19 09:15:17.373372+00	\N	2026-07-19 08:15:17.388067+00	2026-07-19 08:20:52.900719+00
169	74	1	vm-74-1-d6b121f190eb	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 25442, "container_port": 80}]	2026-07-19 01:23:54.601078+00	\N	2026-07-19 00:23:54.615915+00	2026-07-19 00:37:40.012576+00
1187	111	4	vm-111-4-3df455a54863	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 10575, "container_port": 8000}]	2026-07-19 09:54:00.894671+00	\N	2026-07-19 08:54:00.908774+00	2026-07-19 08:59:49.456866+00
1099	46	9	vm-46-9-6b93fde0e373	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 21986, "container_port": 31337}]	2026-07-19 08:47:02.177893+00	\N	2026-07-19 07:47:02.191991+00	2026-07-19 07:47:27.295693+00
866	43	10	vm-43-10-7145c317f2c5	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 20541, "container_port": 31337}]	2026-07-19 06:17:08.39343+00	\N	2026-07-19 05:17:08.407393+00	2026-07-19 06:15:51.717749+00
1120	86	4	vm-86-4-815c39132ac6	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 11718, "container_port": 8000}]	2026-07-19 09:02:30.514759+00	\N	2026-07-19 08:02:30.530282+00	2026-07-19 08:03:48.666471+00
1004	138	10	vm-138-10-3b9fb28c9610	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 17997, "container_port": 31337}]	2026-07-19 07:49:50.757799+00	\N	2026-07-19 06:49:50.772131+00	2026-07-19 06:59:35.351136+00
1191	149	12	vm-149-12-7dca7c4c914a	Pending	\N	\N	\N	2026-07-19 09:58:12.400999+00	\N	2026-07-19 08:58:12.415893+00	2026-07-19 08:58:12.415893+00
817	44	4	vm-44-4-147558cb6261	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 28803, "container_port": 8000}]	2026-07-19 05:51:57.994908+00	\N	2026-07-19 04:51:58.009333+00	2026-07-19 04:55:29.534609+00
1018	103	10	vm-103-10-a9f589d08f72	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 18463, "container_port": 31337}]	2026-07-19 07:57:38.699448+00	\N	2026-07-19 06:57:38.712695+00	2026-07-19 07:02:11.409345+00
964	123	1	vm-123-1-ba7076394f5c	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 11604, "container_port": 80}]	2026-07-19 07:22:46.744087+00	\N	2026-07-19 06:22:46.759665+00	2026-07-19 07:01:05.760797+00
1182	120	2	vm-120-2-26dc62fba983	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 32184, "container_port": 1337}]	2026-07-19 09:46:53.756965+00	\N	2026-07-19 08:46:53.77215+00	2026-07-19 08:59:37.244952+00
1111	155	11	vm-155-11-e7f923810e9e	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 21260, "container_port": 31340}]	2026-07-19 08:54:15.109093+00	\N	2026-07-19 07:54:15.124177+00	2026-07-19 07:58:05.295884+00
1024	1	4	vm-1-4-4f77e8eaf9dd	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 10300, "container_port": 8000}]	2026-07-19 08:00:49.394773+00	\N	2026-07-19 07:00:49.408928+00	2026-07-19 07:40:41.750074+00
627	74	2	vm-74-2-3de4f3780bd9	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 20073, "container_port": 1337}]	2026-07-19 04:08:29.480447+00	\N	2026-07-19 03:08:29.495445+00	2026-07-19 03:53:43.706368+00
1186	29	12	vm-29-12-acdf58c9f405	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 31666, "container_port": 31337}]	2026-07-19 09:51:35.322347+00	\N	2026-07-19 08:51:35.337785+00	2026-07-19 09:23:17.378737+00
1162	26	4	vm-26-4-b59230617871	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 23973, "container_port": 8000}]	2026-07-19 09:28:25.137261+00	\N	2026-07-19 08:28:25.151719+00	2026-07-19 08:34:21.990333+00
588	144	2	vm-144-2-1ca148883016	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 22409, "container_port": 1337}]	2026-07-19 03:48:59.353263+00	\N	2026-07-19 02:48:59.367301+00	2026-07-19 02:50:16.36205+00
985	156	1	vm-156-1-dd20c1e22f83	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 20668, "container_port": 80}]	2026-07-19 07:35:19.200451+00	\N	2026-07-19 06:35:19.215527+00	2026-07-19 06:37:49.48007+00
1148	121	10	vm-121-10-22ec77c661ba	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 10327, "container_port": 31337}]	2026-07-19 09:16:48.317352+00	\N	2026-07-19 08:16:48.331501+00	2026-07-19 08:17:06.777252+00
1150	121	4	vm-121-4-826ad455f4eb	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 22751, "container_port": 8000}]	2026-07-19 09:18:02.820148+00	\N	2026-07-19 08:18:02.834582+00	2026-07-19 08:40:58.394882+00
510	132	1	vm-132-1-5f064ea8ee91	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 20637, "container_port": 80}]	2026-07-19 03:21:16.09907+00	\N	2026-07-19 02:21:16.113044+00	2026-07-19 02:47:35.44849+00
514	10	2	vm-10-2-c9ffd533ab00	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 13042, "container_port": 1337}]	2026-07-19 03:22:28.719986+00	\N	2026-07-19 02:22:28.734442+00	2026-07-19 03:03:05.057386+00
1095	66	10	vm-66-10-c36136943279	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 15983, "container_port": 31337}]	2026-07-19 08:41:04.200808+00	\N	2026-07-19 07:41:04.215126+00	2026-07-19 08:03:50.450089+00
295	55	10	vm-55-10-aac0c86bbe08	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 26735, "container_port": 31337}]	2026-07-19 01:59:44.009156+00	\N	2026-07-19 00:59:44.023916+00	2026-07-19 01:01:08.154172+00
334	128	10	vm-128-10-138a2baed2cc	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 24461, "container_port": 31337}]	2026-07-19 02:15:49.940696+00	\N	2026-07-19 01:15:49.955177+00	2026-07-19 01:20:11.202198+00
1177	5	4	vm-5-4-feb52abfeb8f	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 15206, "container_port": 8000}]	2026-07-19 09:41:46.647754+00	\N	2026-07-19 08:41:46.660827+00	2026-07-19 08:42:07.003097+00
998	40	9	vm-40-9-8a16713300bd	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 28552, "container_port": 31337}]	2026-07-19 07:44:21.888176+00	\N	2026-07-19 06:44:21.901894+00	2026-07-19 06:52:50.478268+00
1145	81	4	vm-81-4-30d1e6637831	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 24944, "container_port": 8000}]	2026-07-19 09:15:32.245875+00	\N	2026-07-19 08:15:32.259166+00	2026-07-19 08:51:12.778036+00
283	76	10	vm-76-10-29b28eb68c43	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 26306, "container_port": 31337}]	2026-07-19 01:54:49.647149+00	\N	2026-07-19 00:54:49.661114+00	2026-07-19 00:56:10.479142+00
1151	149	4	vm-149-4-98ba63c90dad	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 11575, "container_port": 8000}]	2026-07-19 09:18:06.710531+00	\N	2026-07-19 08:18:06.725014+00	2026-07-19 08:32:08.622451+00
852	9	4	vm-9-4-8c13e37509e6	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 20515, "container_port": 8000}]	2026-07-19 06:07:09.700161+00	\N	2026-07-19 05:07:09.714349+00	2026-07-19 05:39:42.663311+00
1164	5	12	vm-5-12-4c462fcf9a57	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 17044, "container_port": 31337}]	2026-07-19 09:30:25.190164+00	\N	2026-07-19 08:30:25.204365+00	2026-07-19 08:51:59.241877+00
253	136	4	vm-136-4-bee4b7020433	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 30185, "container_port": 8000}]	2026-07-19 01:45:26.727438+00	\N	2026-07-19 00:45:26.742261+00	2026-07-19 00:50:50.236567+00
1152	99	4	vm-99-4-2a57e410f7d2	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 27092, "container_port": 8000}]	2026-07-19 09:18:22.539846+00	\N	2026-07-19 08:18:22.555492+00	2026-07-19 08:20:48.157928+00
386	136	1	vm-136-1-fc398bca80f4	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 11379, "container_port": 80}]	2026-07-19 02:32:36.35388+00	\N	2026-07-19 01:32:36.368387+00	2026-07-19 01:34:07.466643+00
1030	131	4	vm-131-4-7fdb614616a1	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 26229, "container_port": 8000}]	2026-07-19 08:02:29.499723+00	\N	2026-07-19 07:02:29.514764+00	2026-07-19 07:14:26.944971+00
1183	120	10	vm-120-10-2a009ff673dc	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 30578, "container_port": 31337}]	2026-07-19 09:46:59.694592+00	\N	2026-07-19 08:46:59.708731+00	2026-07-19 09:00:41.209403+00
589	144	10	vm-144-10-f9ec669d555e	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 25449, "container_port": 31337}]	2026-07-19 03:49:05.709733+00	\N	2026-07-19 02:49:05.724435+00	2026-07-19 02:50:38.207048+00
1100	22	10	vm-22-10-359191dacdad	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 23637, "container_port": 31337}]	2026-07-19 08:49:18.698017+00	\N	2026-07-19 07:49:18.711951+00	2026-07-19 08:09:02.915883+00
1173	41	4	vm-41-4-bd0dcd7fe69e	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 29928, "container_port": 8000}]	2026-07-19 09:36:46.278245+00	\N	2026-07-19 08:36:46.292949+00	2026-07-19 08:57:10.068137+00
1180	152	4	vm-152-4-5055d7519c43	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 21105, "container_port": 8000}]	2026-07-19 09:44:40.92901+00	\N	2026-07-19 08:44:40.944306+00	2026-07-19 09:25:48.506022+00
1053	154	4	vm-154-4-045e231b60d2	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 22297, "container_port": 8000}]	2026-07-19 08:12:15.840856+00	\N	2026-07-19 07:12:15.854742+00	2026-07-19 07:12:54.398593+00
1166	43	9	vm-43-9-7198c529f50b	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 22047, "container_port": 31337}]	2026-07-19 09:32:09.822937+00	\N	2026-07-19 08:32:09.83791+00	2026-07-19 08:33:26.816+00
1167	137	4	vm-137-4-f79f29d7b96d	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 24751, "container_port": 8000}]	2026-07-19 09:32:42.905034+00	\N	2026-07-19 08:32:42.919474+00	2026-07-19 09:26:10.64469+00
1139	19	9	vm-19-9-d1fb2264f80c	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 16579, "container_port": 31337}]	2026-07-19 09:14:34.01403+00	\N	2026-07-19 08:14:34.029531+00	2026-07-19 08:15:48.413474+00
630	52	1	vm-52-1-b2245ec873e2	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 22518, "container_port": 80}]	2026-07-19 04:09:23.446339+00	\N	2026-07-19 03:09:23.460943+00	2026-07-19 03:30:09.210247+00
1140	39	10	vm-39-10-e4f3d8a6773b	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 12875, "container_port": 31337}]	2026-07-19 09:14:34.384837+00	\N	2026-07-19 08:14:34.399437+00	2026-07-19 08:14:48.609782+00
280	76	4	vm-76-4-256e9facf17b	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 18457, "container_port": 8000}]	2026-07-19 01:53:56.997441+00	\N	2026-07-19 00:53:57.011707+00	2026-07-19 00:54:27.428799+00
1102	112	4	vm-112-4-79b0cbb294bb	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 19442, "container_port": 8000}]	2026-07-19 08:50:20.380516+00	\N	2026-07-19 07:50:20.395574+00	2026-07-19 08:03:59.37689+00
1136	27	11	vm-27-11-ec070bb04b57	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 17256, "container_port": 31340}]	2026-07-19 09:11:45.684591+00	\N	2026-07-19 08:11:45.699429+00	2026-07-19 08:14:07.019164+00
1184	37	4	vm-37-4-0122316e76ad	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 32377, "container_port": 8000}]	2026-07-19 09:47:16.916035+00	\N	2026-07-19 08:47:16.930429+00	2026-07-19 08:57:45.312844+00
1109	118	4	vm-118-4-3501a93bb521	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 26000, "container_port": 8000}]	2026-07-19 08:52:59.45095+00	\N	2026-07-19 07:52:59.465379+00	2026-07-19 08:44:49.112732+00
1132	110	9	vm-110-9-0ca3c12fd4ce	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 19406, "container_port": 31337}]	2026-07-19 09:08:58.311094+00	\N	2026-07-19 08:08:58.325402+00	2026-07-19 08:11:04.84192+00
1189	22	4	vm-22-4-75e00ec523f4	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 11586, "container_port": 8000}]	2026-07-19 09:55:25.766046+00	\N	2026-07-19 08:55:25.78053+00	2026-07-19 08:59:48.699906+00
1121	27	4	vm-27-4-7c6750d5148b	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 22730, "container_port": 8000}]	2026-07-19 09:03:01.053382+00	\N	2026-07-19 08:03:01.068001+00	2026-07-19 08:09:27.839986+00
945	156	2	vm-156-2-ff2cb23bcda2	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 15079, "container_port": 1337}]	2026-07-19 07:11:51.234906+00	\N	2026-07-19 06:11:51.249579+00	2026-07-19 06:15:10.541219+00
123	31	11	vm-31-11-7b28fc2d472d	Running	xw-smc17-1	host8.sca-ctf.com	[{"protocol": "tcp", "host_port": 26230, "container_port": 31340}]	2026-07-19 01:07:43.148776+00	\N	2026-07-19 00:07:43.163034+00	2026-07-19 00:14:29.891571+00
1021	138	12	vm-138-12-4a8cdcf1b0e6	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 21234, "container_port": 31337}]	2026-07-19 07:59:55.251445+00	\N	2026-07-19 06:59:55.264978+00	2026-07-19 07:00:28.352422+00
813	80	1	vm-80-1-6dd62005f2d5	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 11255, "container_port": 80}]	2026-07-19 05:47:53.975775+00	\N	2026-07-19 04:47:53.991086+00	2026-07-19 05:04:40.753002+00
644	57	4	vm-57-4-c9a5bcd1e02f	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 19028, "container_port": 8000}]	2026-07-19 04:14:19.697433+00	\N	2026-07-19 03:14:19.711582+00	2026-07-19 03:15:48.419552+00
1153	20	4	vm-20-4-a457895a5099	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 23047, "container_port": 8000}]	2026-07-19 09:19:14.530077+00	\N	2026-07-19 08:19:14.544494+00	2026-07-19 08:40:43.868496+00
1170	18	4	vm-18-4-d2bac7e6c5e4	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 25887, "container_port": 8000}]	2026-07-19 09:34:03.810005+00	\N	2026-07-19 08:34:03.824871+00	2026-07-19 09:09:58.252065+00
982	40	4	vm-40-4-4d50d5611837	Running	xw-default-1	host5.sca-ctf.com	[{"protocol": "tcp", "host_port": 24428, "container_port": 8000}]	2026-07-19 07:34:37.040905+00	\N	2026-07-19 06:34:37.055024+00	2026-07-19 07:27:01.363235+00
874	91	1	vm-91-1-59ed4e697ffd	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 14078, "container_port": 80}]	2026-07-19 06:23:15.957756+00	\N	2026-07-19 05:23:15.973023+00	2026-07-19 06:19:49.770749+00
891	90	4	vm-90-4-0780b827218e	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 18056, "container_port": 8000}]	2026-07-19 06:35:33.818213+00	\N	2026-07-19 05:35:33.832891+00	2026-07-19 05:35:48.078366+00
555	104	4	vm-104-4-3584c2486dbe	Running	xw-default-2	host6.sca-ctf.com	[{"protocol": "tcp", "host_port": 21692, "container_port": 8000}]	2026-07-19 03:35:16.773479+00	\N	2026-07-19 02:35:16.787488+00	2026-07-19 03:29:25.148776+00
\.


--
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.challenges_id_seq', 28, true);


--
-- Name: discord_connections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.discord_connections_id_seq', 100, true);


--
-- Name: divisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.divisions_id_seq', 3, true);


--
-- Name: registration_key_uses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registration_key_uses_id_seq', 155, true);


--
-- Name: registration_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registration_keys_id_seq', 108, true);


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.submissions_id_seq', 4106, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teams_id_seq', 108, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 156, true);


--
-- Name: vms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vms_id_seq', 1191, true);


--
-- Name: app_configs app_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_configs
    ADD CONSTRAINT app_configs_pkey PRIMARY KEY (key);


--
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);


--
-- Name: discord_connections discord_connections_discord_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discord_connections
    ADD CONSTRAINT discord_connections_discord_user_id_key UNIQUE (discord_user_id);


--
-- Name: discord_connections discord_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discord_connections
    ADD CONSTRAINT discord_connections_pkey PRIMARY KEY (id);


--
-- Name: discord_connections discord_connections_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discord_connections
    ADD CONSTRAINT discord_connections_user_id_key UNIQUE (user_id);


--
-- Name: divisions divisions_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_name_key UNIQUE (name);


--
-- Name: divisions divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (id);


--
-- Name: registration_key_uses registration_key_uses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_key_uses
    ADD CONSTRAINT registration_key_uses_pkey PRIMARY KEY (id);


--
-- Name: registration_keys registration_keys_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_keys
    ADD CONSTRAINT registration_keys_code_key UNIQUE (code);


--
-- Name: registration_keys registration_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_keys
    ADD CONSTRAINT registration_keys_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vms vms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vms
    ADD CONSTRAINT vms_pkey PRIMARY KEY (id);


--
-- Name: idx_discord_connections_discord_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_discord_connections_discord_user ON public.discord_connections USING btree (discord_user_id);


--
-- Name: idx_discord_connections_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_discord_connections_user ON public.discord_connections USING btree (user_id);


--
-- Name: idx_registration_key_uses_key_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_registration_key_uses_key_id ON public.registration_key_uses USING btree (registration_key_id);


--
-- Name: idx_registration_keys_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_registration_keys_team_id ON public.registration_keys USING btree (team_id);


--
-- Name: idx_submissions_challenge; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_challenge ON public.submissions USING btree (challenge_id);


--
-- Name: idx_submissions_correct_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_correct_time ON public.submissions USING btree (correct, submitted_at) WHERE (correct = true);


--
-- Name: idx_submissions_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_user ON public.submissions USING btree (user_id);


--
-- Name: idx_submissions_user_challenge; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_user_challenge ON public.submissions USING btree (user_id, challenge_id);


--
-- Name: idx_teams_division_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teams_division_id ON public.teams USING btree (division_id);


--
-- Name: idx_users_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_team_id ON public.users USING btree (team_id);


--
-- Name: idx_vms_user_challenge; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_vms_user_challenge ON public.vms USING btree (user_id, challenge_id);


--
-- Name: idx_vms_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vms_user_id ON public.vms USING btree (user_id);


--
-- Name: idx_vms_vm_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_vms_vm_id ON public.vms USING btree (vm_id);


--
-- PostgreSQL database dump complete
--

\unrestrict CsFZfWVI9zD7EIphbrr28j13VrL3f9GidcikL8WqsQ5yuZFia6YyHtF2ANPQ3Ru

