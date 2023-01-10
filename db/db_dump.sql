--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.1 (Ubuntu 15.1-1.pgdg22.04+1)

-- Started on 2022-12-15 18:09:58 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 220 (class 1259 OID 16607)
-- Name: transaction_topup_sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_topup_sources (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.transaction_topup_sources OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16616)
-- Name: transaction_topup_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transaction_topup_sources ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transaction_topup_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16597)
-- Name: transaction_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.transaction_types OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16606)
-- Name: transaction_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transaction_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transaction_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16617)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    wallet_id integer NOT NULL,
    transaction_type_id integer NOT NULL,
    transaction_topup_source_id integer,
    wallet_from_to_id integer,
    amount numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    description character varying(35)
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16644)
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transactions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16567)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16568)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    otp_reset_password integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16581)
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 777001
    INCREMENT BY 1
    MINVALUE 777001
    MAXVALUE 777999
    CACHE 1;


ALTER TABLE public.wallets_id_seq OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16583)
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id integer DEFAULT nextval('public.wallets_id_seq'::regclass) NOT NULL,
    balance numeric NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- TOC entry 3413 (class 0 OID 16607)
-- Dependencies: 220
-- Data for Name: transaction_topup_sources; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.transaction_topup_sources (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (3, 'Cash', '2022-12-14 13:16:47.649356+07', '2022-12-14 13:16:47.649356+07', NULL);
INSERT INTO public.transaction_topup_sources (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (2, 'Credit Card', '2022-12-14 13:16:44.216176+07', '2022-12-14 13:16:44.216176+07', NULL);
INSERT INTO public.transaction_topup_sources (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (1, 'Bank Transfer', '2022-12-14 13:16:34.803458+07', '2022-12-14 13:16:34.803458+07', NULL);


--
-- TOC entry 3411 (class 0 OID 16597)
-- Dependencies: 218
-- Data for Name: transaction_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.transaction_types (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (1, 'Top Up', '2022-12-14 13:14:23.904122+07', '2022-12-14 13:14:23.904122+07', NULL);
INSERT INTO public.transaction_types (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (2, 'Transfer in', '2022-12-14 13:14:29.556697+07', '2022-12-14 13:14:29.556697+07', NULL);
INSERT INTO public.transaction_types (id, name, created_at, updated_at, deleted_at) OVERRIDING SYSTEM VALUE VALUES (3, 'Transfer out', '2022-12-14 13:14:34.282187+07', '2022-12-14 13:14:34.282187+07', NULL);


--
-- TOC entry 3415 (class 0 OID 16617)
-- Dependencies: 222
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (46, 777013, 1, 1, NULL, 10000000, '2022-12-15 17:43:26.660964+07', '2022-12-15 17:43:26.660964+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (3, 777002, 2, NULL, 777013, 200000, '2020-03-04 19:31:24.011811+07', '2020-03-04 19:31:24.011811+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (2, 777013, 3, NULL, 777002, -200000, '2020-03-04 17:30:27.942543+07', '2020-03-04 17:30:27.942543+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (1, 777013, 1, 2, NULL, 1000000, '2020-02-04 17:30:27.942543+07', '2020-02-04 17:30:27.942543+07', NULL, 'Top Up from Credit Card');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (10, 777005, 3, NULL, 777010, -234000, '2020-08-03 12:31:33.883171+07', '2020-08-03 12:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (9, 777011, 2, NULL, 777005, 250000, '2020-08-02 09:31:33.883171+07', '2020-08-02 09:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (8, 777005, 3, NULL, 777011, -250000, '2020-08-01 20:31:33.883171+07', '2020-08-01 20:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (7, 777005, 1, 3, NULL, 4500000, '2020-08-01 17:31:33.883171+07', '2020-08-01 17:31:33.883171+07', NULL, 'Top Up from Cash');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (6, 777003, 1, 1, NULL, 5000000, '2020-05-26 17:31:33.883171+07', '2020-05-26 17:31:33.883171+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (5, 777003, 2, NULL, 777013, 240000, '2020-05-21 17:31:33.883171+07', '2020-05-21 17:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (4, 777013, 3, NULL, 777003, -240000, '2020-05-20 17:31:33.883171+07', '2020-05-20 17:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (21, 777008, 3, NULL, 777005, -300000, '2021-08-21 07:31:33.883171+07', '2021-08-21 07:31:33.883171+07', NULL, 'halo');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (20, 777008, 1, 2, NULL, 2380000, '2021-07-20 07:31:33.883171+07', '2021-07-20 07:31:33.883171+07', NULL, 'Top Up from Credit Card');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (19, 777005, 2, NULL, 777007, 300000, '2021-06-02 23:31:33.883171+07', '2021-06-02 23:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (18, 777007, 3, NULL, 777005, -300000, '2021-05-20 09:31:33.883171+07', '2021-05-20 09:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (17, 777008, 2, NULL, 777007, 842999, '2021-05-12 09:31:33.883171+07', '2021-05-12 09:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (16, 777007, 3, NULL, 777008, -842999, '2021-03-28 09:31:33.883171+07', '2021-03-28 09:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (15, 777002, 2, NULL, 777007, 234000, '2021-03-20 09:31:33.883171+07', '2021-03-20 09:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (14, 777007, 3, NULL, 777002, -234000, '2021-02-01 01:31:33.883171+07', '2021-02-01 01:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (13, 777007, 1, 3, NULL, 4999000, '2020-12-31 01:31:33.883171+07', '2020-12-31 01:31:33.883171+07', NULL, 'Top Up from Cash');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (12, 777005, 1, 3, NULL, 200000, '2020-12-25 12:31:33.883171+07', '2020-12-25 12:31:33.883171+07', NULL, 'Top Up from Cash');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (11, 777010, 2, NULL, 777005, 234000, '2020-12-20 12:31:33.883171+07', '2020-12-20 12:31:33.883171+07', NULL, '');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (37, 777011, 3, NULL, 777002, -99823, '2022-03-06 09:31:33.883171+07', '2022-03-06 09:31:33.883171+07', NULL, 'halo');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (36, 777003, 2, NULL, 777011, 428192, '2022-03-06 04:31:33.883171+07', '2022-03-06 04:31:33.883171+07', NULL, 'hai');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (35, 777011, 3, NULL, 777003, -428192, '2022-03-05 23:31:33.883171+07', '2022-03-05 23:31:33.883171+07', NULL, 'hai');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (34, 777011, 1, 3, NULL, 1000000, '2022-03-05 22:31:33.883171+07', '2022-03-05 22:31:33.883171+07', NULL, 'Top Up from Cash');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (33, 777008, 2, NULL, 777010, 200000, '2022-03-04 20:31:33.883171+07', '2022-03-04 20:31:33.883171+07', NULL, 'bayar cicilan kos');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (32, 777010, 3, NULL, 777008, -200000, '2022-03-03 20:31:33.883171+07', '2022-03-03 20:31:33.883171+07', NULL, 'bayar cicilan kos');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (31, 777004, 2, NULL, 777010, 100000, '2022-03-01 20:31:33.883171+07', '2022-03-01 20:31:33.883171+07', NULL, 'bayar makan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (30, 777010, 3, NULL, 777004, -100000, '2022-02-07 19:31:33.883171+07', '2022-02-07 19:31:33.883171+07', NULL, 'bayar makan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (29, 777010, 1, 1, NULL, 990999, '2022-02-07 16:31:33.883171+07', '2022-02-07 16:31:33.883171+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (28, 777002, 2, NULL, 777009, 999000, '2022-02-07 12:31:33.883171+07', '2022-02-07 12:31:33.883171+07', NULL, 'bayar baju');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (27, 777009, 3, NULL, 777002, -999000, '2022-01-25 12:31:33.883171+07', '2022-01-25 12:31:33.883171+07', NULL, 'bayar baju');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (26, 777009, 1, 2, NULL, 2492812, '2022-01-23 12:31:33.883171+07', '2022-01-23 12:31:33.883171+07', NULL, 'Top Up from Credit Card');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (25, 777011, 2, NULL, 777009, 123020, '2022-01-22 14:31:33.883171+07', '2022-01-22 14:31:33.883171+07', NULL, 'halo');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (24, 777009, 3, NULL, 777011, -123020, '2022-01-01 00:31:33.883171+07', '2022-01-01 00:31:33.883171+07', NULL, 'halo');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (23, 777009, 1, 2, NULL, 249812, '2021-12-20 00:31:33.883171+07', '2021-12-20 00:31:33.883171+07', NULL, 'Top Up from Credit Card');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (22, 777005, 2, NULL, 777008, 300000, '2021-11-20 07:31:33.883171+07', '2021-11-20 07:31:33.883171+07', NULL, 'halo');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (45, 777013, 1, 1, NULL, 10000000, '2022-12-15 15:43:23.392787+07', '2022-12-15 15:43:23.392787+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (44, 777013, 1, 1, NULL, 10000000, '2022-12-15 12:43:23.392787+07', '2022-12-15 12:43:23.392787+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (43, 777011, 2, NULL, 777012, 482292, '2022-09-02 17:43:09.471969+07', '2022-09-02 17:43:09.471969+07', NULL, 'buat lu nikahan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (42, 777012, 3, NULL, 777011, -482292, '2022-05-03 02:31:33.883171+07', '2022-05-03 02:31:33.883171+07', NULL, 'buat lu nikahan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (41, 777013, 2, NULL, 777012, 482292, '2022-04-03 02:31:33.883171+07', '2022-04-03 02:31:33.883171+07', NULL, 'buat lu makan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (40, 777012, 3, NULL, 777013, -482292, '2022-03-09 02:31:33.883171+07', '2022-03-09 02:31:33.883171+07', NULL, 'buat lu makan');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (39, 777012, 1, 1, NULL, 4214988, '2022-03-08 02:31:33.883171+07', '2022-03-08 02:31:33.883171+07', NULL, 'Top Up from Bank Transfer');
INSERT INTO public.transactions (id, wallet_id, transaction_type_id, transaction_topup_source_id, wallet_from_to_id, amount, created_at, updated_at, deleted_at, description) OVERRIDING SYSTEM VALUE VALUES (38, 777002, 2, NULL, 777011, 99823, '2022-03-07 02:31:33.883171+07', '2022-03-07 02:31:33.883171+07', NULL, 'halo');


--
-- TOC entry 3408 (class 0 OID 16568)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (2, '$2a$04$mHqWUCRlcrUjHF0pOdqwU.G6Un3R6VKqlVTLKITqDj5YuXsLV6hlS', 'guardiansemacs@shopee.com', '2022-12-15 17:22:45.550042+07', '2022-12-15 17:22:45.550042+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (3, '$2a$04$9p2tEjg7T87daic.Q3ucGOXVEW3.Z3HIOFpoiNQOmBBk9/KWPcny2', 'techsgroove@shopee.com', '2022-12-15 17:22:51.177442+07', '2022-12-15 17:22:51.177442+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (4, '$2a$04$Arl2G71uxcNtTLkmE6/XA.5IRmjHytc8f5gwMyxuNC.0tNvI.0O4K', 'benchowls@shopee.com', '2022-12-15 17:22:56.430201+07', '2022-12-15 17:22:56.430201+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (5, '$2a$04$T1/1gIH6twv6y.KlpfrUau7gYKUytg7IHq6LE04YoJ4HusBip6uS.', 'gmailschools@shopee.com', '2022-12-15 17:23:00.532984+07', '2022-12-15 17:23:00.532984+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (6, '$2a$04$/b.haYta2K/L9EYu9SnMW.8x1/SJdt/XeB2BTF41NjljswRiCj66G', 'lastlyeasier@shopee.com', '2022-12-15 17:23:06.617993+07', '2022-12-15 17:23:06.617993+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (8, '$2a$04$rS4DQUvIFnyIEN1ExpBkw.33/rjJNr9TgC5Jrt64k5jxC0g5kvlcC', 'transformedresistor@shopee.com', '2022-12-15 17:23:12.943476+07', '2022-12-15 17:23:12.943476+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (9, '$2a$04$TBP3HuHL4AcTi4nzIVJTJuP0FY1fBR5NGxRaMpEmMbiNSAUQgnvG2', 'selectivepearls@shopee.com', '2022-12-15 17:23:17.864817+07', '2022-12-15 17:23:17.864817+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (10, '$2a$04$hU8B7/8Grq0nNwlC5RegAeJsHrznK0lLKpClcXjGDzFK.P.rOqAwO', 'beliefpdt@shopee.com', '2022-12-15 17:23:23.583699+07', '2022-12-15 17:23:23.583699+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (11, '$2a$04$ESFsoAexgWo9oqYZ2FLwhOcjChfuJdqcrtMTB6D8YkGJ.KvBC8.We', 'dsmexpedited@shopee.com', '2022-12-15 17:23:27.780504+07', '2022-12-15 17:23:27.780504+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (12, '$2a$04$ZBklTQ7cijPpYJRtb.ewNOxuip8xepCiU52DQ1n5/ch7Cidti6mxy', 'connectionsvbulletin@shopee.com', '2022-12-15 17:23:31.49712+07', '2022-12-15 17:23:31.49712+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (13, '$2a$04$IPsOEjqgwvwHokWfVa/BZecqmUFTWk54Pbj10FIky1EADrk9kVkZ6', 'contributionsfraction@shopee.com', '2022-12-15 17:23:40.60322+07', '2022-12-15 17:23:40.60322+07', NULL, 0);
INSERT INTO public.users (id, password, email, created_at, updated_at, deleted_at, otp_reset_password) VALUES (14, '$2a$04$LlGY67XxUUlfbhhM/MhzfeTY3zwqgshjSLk7ojwgQ2zup8X/3oGqe', 'warwickshiredavid@shopee.com', '2022-12-15 17:23:45.141926+07', '2022-12-15 17:23:45.141926+07', NULL, 0);


--
-- TOC entry 3410 (class 0 OID 16583)
-- Dependencies: 217
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777006, 0, 6, '2022-12-15 17:23:06.61827+07', '2022-12-15 17:23:06.61827+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777007, 3622001, 8, '2022-12-15 17:23:12.94373+07', '2022-12-15 17:33:50.696135+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777005, 4816000, 5, '2022-12-15 17:23:00.533276+07', '2022-12-15 17:34:24.384786+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777009, 1620604, 10, '2022-12-15 17:23:23.583983+07', '2022-12-15 17:40:33.648067+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777004, 100000, 4, '2022-12-15 17:22:56.430527+07', '2022-12-15 17:41:01.801899+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777010, 924999, 11, '2022-12-15 17:23:27.780726+07', '2022-12-15 17:41:19.501153+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777008, 3122999, 9, '2022-12-15 17:23:17.865103+07', '2022-12-15 17:41:19.501297+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777003, 5668192, 3, '2022-12-15 17:22:51.177726+07', '2022-12-15 17:41:51.090333+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777002, 1532823, 2, '2022-12-15 17:22:45.550838+07', '2022-12-15 17:42:02.777022+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777012, 3250404, 13, '2022-12-15 17:23:40.603475+07', '2022-12-15 17:43:09.471449+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777011, 1327297, 12, '2022-12-15 17:23:31.497433+07', '2022-12-15 17:43:09.471624+07', NULL);
INSERT INTO public.wallets (id, balance, user_id, created_at, updated_at, deleted_at) VALUES (777013, 31042292, 14, '2022-12-15 17:23:45.14212+07', '2022-12-15 17:43:26.660849+07', NULL);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 221
-- Name: transaction_topup_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_topup_sources_id_seq', 3, true);


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 219
-- Name: transaction_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_types_id_seq', 3, true);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 223
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 46, true);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 14, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 216
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 777013, true);


--
-- TOC entry 3257 (class 2606 OID 16615)
-- Name: transaction_topup_sources transaction_topup_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_topup_sources
    ADD CONSTRAINT transaction_topup_sources_pkey PRIMARY KEY (id);


--
-- TOC entry 3255 (class 2606 OID 16605)
-- Name: transaction_types transaction_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_types
    ADD CONSTRAINT transaction_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3259 (class 2606 OID 16623)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 2606 OID 16579)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3251 (class 2606 OID 16577)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3253 (class 2606 OID 16590)
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 16624)
-- Name: transactions transaction_topup_source_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transaction_topup_source_fk FOREIGN KEY (transaction_topup_source_id) REFERENCES public.transaction_topup_sources(id) ON DELETE SET NULL;


--
-- TOC entry 3262 (class 2606 OID 16629)
-- Name: transactions transaction_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transaction_type_fk FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_types(id) ON DELETE SET NULL;


--
-- TOC entry 3260 (class 2606 OID 16591)
-- Name: wallets user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 16634)
-- Name: transactions wallet_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT wallet_fk FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE SET NULL;


--
-- TOC entry 3264 (class 2606 OID 16639)
-- Name: transactions wallet_from_to_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT wallet_from_to_fk FOREIGN KEY (wallet_from_to_id) REFERENCES public.wallets(id);


-- Completed on 2022-12-15 18:09:58 WIB

--
-- PostgreSQL database dump complete
--

