--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-01-11 00:46:18

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
-- TOC entry 216 (class 1259 OID 16419)
-- Name: guests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guests (
    id integer NOT NULL,
    fullname character varying NOT NULL,
    email character varying,
    phone_number character varying,
    address character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    uuid character varying NOT NULL,
    visit boolean DEFAULT false
);


ALTER TABLE public.guests OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16428)
-- Name: guests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.guests ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.guests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16399)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    deleted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16408)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS public.messages
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    display_name character varying COLLATE pg_catalog."default" NOT NULL,
    message character varying(200) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    guest_uuid character varying COLLATE pg_catalog."default",
    CONSTRAINT messages_pkey PRIMARY KEY (id),
    CONSTRAINT guest_fk FOREIGN KEY (guest_uuid)
        REFERENCES public.guests (uuid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.messages
    OWNER to postgres;


--
-- TOC entry 3335 (class 0 OID 16419)
-- Dependencies: 216
-- Data for Name: guests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guests (id, fullname, email, phone_number, address, created_at, updated_at, deleted_at, uuid, visit) OVERRIDING SYSTEM VALUE VALUES (2, 'anjaygokil2', '', '', '', '2023-01-10 00:10:50.948482+07', '2023-01-10 00:22:20.755674+07', '2023-01-10 00:23:53.587374+07', 'df8a0338-ef32-4ff1-836f-4caa0376d07a', false);
INSERT INTO public.guests (id, fullname, email, phone_number, address, created_at, updated_at, deleted_at, uuid, visit) OVERRIDING SYSTEM VALUE VALUES (3, 'anjaygok2il', '', '', '', '2023-01-10 00:23:59.591527+07', '2023-01-10 23:55:05.908809+07', NULL, '5f9fda2e-9e07-4157-a8ca-0357d79a9d1d', false);
INSERT INTO public.guests (id, fullname, email, phone_number, address, created_at, updated_at, deleted_at, uuid, visit) OVERRIDING SYSTEM VALUE VALUES (4, 'anjaygoki2l2', '', '', '', '2023-01-10 23:36:34.393483+07', '2023-01-10 23:54:43.499455+07', '2023-01-10 23:57:49.996811+07', 'c706cab6-578f-4e8c-8281-79b589bc7785', false);


--
-- TOC entry 3333 (class 0 OID 16399)
-- Dependencies: 214
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, username, password, deleted_at, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (1, 'superadmin', '$2a$04$EcMzh6DxNpV6nY/ekgdj7ua/xKziTEAjdAChblkHM.Tu6l600mWPW', NULL, '2023-01-09 22:48:41.710793+07', '2023-01-09 22:48:41.710793+07');
INSERT INTO public.users (id, username, password, deleted_at, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (2, 'test_user', '$2a$04$kuCDSWzYf.0iXpp2cgBhXOovFzv4vajegpyp2egaiEnun2WqDQQka', NULL, '2023-01-09 22:50:20.973154+07', '2023-01-09 22:50:20.973154+07');


--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 217
-- Name: guests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guests_id_seq', 4, true);


--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 3188 (class 2606 OID 16427)
-- Name: guests guests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guests
    ADD CONSTRAINT guests_pkey PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 16410)
-- Name: users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 3186 (class 2606 OID 16407)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3190 (class 2606 OID 16430)
-- Name: guests uuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guests
    ADD CONSTRAINT uuid UNIQUE (uuid);


-- Completed on 2023-01-11 00:46:18

--
-- PostgreSQL database dump complete
--

