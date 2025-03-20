PGDMP  )    9                }            stage_db    16.1    16.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16448    stage_db    DATABASE     {   CREATE DATABASE stage_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE stage_db;
                postgres    false            �            1259    16461    entreprises    TABLE     �  CREATE TABLE public.entreprises (
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
    DROP TABLE public.entreprises;
       public         heap    postgres    false            �            1259    16460    entreprises_id_seq    SEQUENCE     �   CREATE SEQUENCE public.entreprises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.entreprises_id_seq;
       public          postgres    false    216            �           0    0    entreprises_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.entreprises_id_seq OWNED BY public.entreprises.id;
          public          postgres    false    215            �            1259    16470    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16469    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    218            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    217            U           2604    16464    entreprises id    DEFAULT     p   ALTER TABLE ONLY public.entreprises ALTER COLUMN id SET DEFAULT nextval('public.entreprises_id_seq'::regclass);
 =   ALTER TABLE public.entreprises ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            V           2604    16473    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �          0    16461    entreprises 
   TABLE DATA           �   COPY public.entreprises (id, raison_sociale, nom_dirigeant, numero_rue, code_postal, ville, pays, service, email, telephone, description) FROM stdin;
    public          postgres    false    216   �       �          0    16470    users 
   TABLE DATA           7   COPY public.users (id, username, password) FROM stdin;
    public          postgres    false    218   �       �           0    0    entreprises_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.entreprises_id_seq', 20, true);
          public          postgres    false    215            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    217            X           2606    16468    entreprises entreprises_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.entreprises
    ADD CONSTRAINT entreprises_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.entreprises DROP CONSTRAINT entreprises_pkey;
       public            postgres    false    216            Z           2606    16477    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            \           2606    16479    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    218            �   �   x���AN�@EמS��&��BX"U�q��L�g"��8c*bϻo}���|`xiK;��+p&����x��	�u�Z�c��HM�x�������jAz��9�z�3�"ADU�8�!�1ڳU?!��6L`/g[kmC�TKP��,��rB���o����"L��qEG�$��q�����#�3�=�dYi��|:
+Aw�w�y�6U]50�ϙ���	 �{      �   [   x�3�tJ,JJ,JTp�J��,�T1JR14R�-,��0)�4�v��H��t	�3�0����u��LLw�2�0�Huq�J	�p�������� ;'     