--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: entreprises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entreprises (
    id integer NOT NULL,
    raison_sociale character varying(255) NOT NULL,
    nom_dirigeant character varying(255) NOT NULL,
    numero_rue character varying(255),
    code_postal character varying(20),
    ville character varying(255),
    pays character varying(255),
    service character varying(255),
    email character varying(255) NOT NULL,
    telephone character varying(20) NOT NULL,
    description text
);


ALTER TABLE public.entreprises OWNER TO postgres;

--
-- Name: entreprises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entreprises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entreprises_id_seq OWNER TO postgres;

--
-- Name: entreprises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entreprises_id_seq OWNED BY public.entreprises.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: entreprises id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entreprises ALTER COLUMN id SET DEFAULT nextval('public.entreprises_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: entreprises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entreprises (id, raison_sociale, nom_dirigeant, numero_rue, code_postal, ville, pays, service, email, telephone, description) FROM stdin;
18	kiki	youcef	102 avenue L├®nine	93380	Pierrefitte-sur-Seine	FRANCE	organisation_anniversaire	tassadit.ouzia04@gmail.com	0752080003	hhhh
19	sarl	Tassadit	102 avenue L├®nine	93380	Pierrefitte-sur-Seine	FRANCE	photos	tassadit.ouzia04@gmail.com	0752080003	hhhhhhhhhhhh
20	sasa	moi	52 de rue	85222	vanille	belgique	sejours_entreprise	ddddd@gmail.com	0652251315	hahahahahah
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password) FROM stdin;
1	Barbara Ezelis	$2b$12$mqqYh4w97OSFLHbnJyDVU.2oP3hhMMGjiagCz6VH4xeDBJdQ8C9mm
\.


--
-- Name: entreprises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entreprises_id_seq', 20, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: entreprises entreprises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entreprises
    ADD CONSTRAINT entreprises_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

