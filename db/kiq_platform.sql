--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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
-- Name: get_recurring_seconds(integer); Type: FUNCTION; Schema: public; Owner: kiqadmin
--

CREATE FUNCTION public.get_recurring_seconds(n integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
CASE n
WHEN 0 THEN
RETURN 0;
WHEN 1 THEN
RETURN 3600;
WHEN 2 THEN
RETURN 86400;
WHEN 3 THEN
RETURN 2419200;
WHEN 4 THEN
RETURN 31536000;
END CASE;
END;
$$;



ALTER FUNCTION public.get_recurring_seconds(n integer) OWNER TO kiq_admin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps (
    id integer NOT NULL,
    path text,
    data text,
    mask integer,
    name text
);


ALTER TABLE public.apps OWNER TO kiq_admin;

--
-- Name: apps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_id_seq OWNER TO kiq_admin;

--
-- Name: apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_id_seq OWNED BY public.apps.id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id integer NOT NULL,
    name text,
    sid integer
);


ALTER TABLE public.file OWNER TO kiq_admin;

--
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO kiq_admin;

--
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;

--
-- Name: recurring; Type: TABLE; Schema: public; Owner: kiqadmin
--

CREATE TABLE public.recurring (
    id integer NOT NULL,
    sid integer NOT NULL,
    "time" integer
);


ALTER TABLE public.recurring OWNER TO kiq_admin;

--
-- Name: recurring_id_seq; Type: SEQUENCE; Schema: public; Owner: kiqadmin
--

CREATE SEQUENCE public.recurring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recurring_id_seq OWNER TO kiq_admin;

--
-- Name: recurring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kiqadmin
--

ALTER SEQUENCE public.recurring_id_seq OWNED BY public.recurring.id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    id integer NOT NULL,
    mask integer,
    flags text,
    envfile text,
    "time" integer,
    completed integer DEFAULT 0,
    recurring integer DEFAULT 0,
    notify boolean DEFAULT false
);


ALTER TABLE public.schedule OWNER TO kiq_admin;

--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_id_seq OWNER TO kiq_admin;

--
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_id_seq OWNED BY public.schedule.id;


--
-- Name: apps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps ALTER COLUMN id SET DEFAULT nextval('public.apps_id_seq'::regclass);


--
-- Name: file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- Name: recurring id; Type: DEFAULT; Schema: public; Owner: kiqadmin
--

ALTER TABLE ONLY public.recurring ALTER COLUMN id SET DEFAULT nextval('public.recurring_id_seq'::regclass);



--
-- Name: schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN id SET DEFAULT nextval('public.schedule_id_seq'::regclass);


--
-- Data for Name: apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps (id, path, data, mask, name) FROM stdin;
1	/target/apps/task_test/task_test	/target/apps/task_test/tasks_data.json	1	Task Runner
2	/target/apps/concurrent_calls/concurrent_calls	/target/apps/concurrent_calls/calls_data.json	2	Concurrent Calls
\.


--
-- Name: apps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_id_seq', 1, true);


--
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_id_seq', 1, true);


--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_id_seq', 1, true);


--
-- Name: apps apps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps
    ADD CONSTRAINT apps_pkey PRIMARY KEY (id);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- Name: file file_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_sid_fkey FOREIGN KEY (sid) REFERENCES public.schedule(id);


--
-- PostgreSQL database dump complete
--

