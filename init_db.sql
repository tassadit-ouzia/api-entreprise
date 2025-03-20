-- Table: public.users

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_username_key UNIQUE (username)
);

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

-- Table: public.entreprises

CREATE TABLE IF NOT EXISTS public.entreprises
(
    id integer NOT NULL DEFAULT nextval('entreprises_id_seq'::regclass),
    raison_sociale character varying(255) COLLATE pg_catalog."default" NOT NULL,
    nom_dirigeant character varying(255) COLLATE pg_catalog."default" NOT NULL,
    numero_rue character varying(255) COLLATE pg_catalog."default",
    code_postal character varying(20) COLLATE pg_catalog."default",
    ville character varying(255) COLLATE pg_catalog."default",
    pays character varying(255) COLLATE pg_catalog."default",
    service character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    telephone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT entreprises_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.entreprises
    OWNER to postgres;