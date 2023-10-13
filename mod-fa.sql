CREATE DATABASE albertheijn
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

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

CREATE TABLE public.aankoop (
    transactiebonuskaartnummer integer NOT NULL,
    productproductnummer integer NOT NULL,
    aantal integer NOT NULL
);


ALTER TABLE public.aankoop OWNER TO postgres;

CREATE TABLE public.bonuskaart (
    bonuskaartnummer integer NOT NULL,
    naam character varying(255),
    adres character varying(255),
    woonplaats character varying(255)
);


ALTER TABLE public.bonuskaart OWNER TO postgres;

CREATE SEQUENCE public.bonuskaart_bonuskaartnummer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bonuskaart_bonuskaartnummer_seq OWNER TO postgres;

ALTER SEQUENCE public.bonuskaart_bonuskaartnummer_seq OWNED BY public.bonuskaart.bonuskaartnummer;

CREATE TABLE public.filiaal (
    filiaalnummer integer NOT NULL,
    plaats character varying(255) NOT NULL,
    adres character varying(255) NOT NULL
);


ALTER TABLE public.filiaal OWNER TO postgres;

CREATE SEQUENCE public.filiaal_filiaalnummer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filiaal_filiaalnummer_seq OWNER TO postgres;

ALTER SEQUENCE public.filiaal_filiaalnummer_seq OWNED BY public.filiaal.filiaalnummer;

CREATE TABLE public.product (
    productnummer integer NOT NULL,
    omschrijving character varying(255) NOT NULL,
    prijs numeric(6,2) NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

CREATE SEQUENCE public.product_productnummer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_productnummer_seq OWNER TO postgres;

ALTER SEQUENCE public.product_productnummer_seq OWNED BY public.product.productnummer;

CREATE TABLE public.transactie (
    transactienummer integer NOT NULL,
    datum date NOT NULL,
    tijd time without time zone NOT NULL,
    bonuskaartbonuskaartnummer integer NOT NULL,
    filiaalfiliaalnummer integer NOT NULL
);


ALTER TABLE public.transactie OWNER TO postgres;

CREATE SEQUENCE public.transactie_transactienummer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactie_transactienummer_seq OWNER TO postgres;


ALTER SEQUENCE public.transactie_transactienummer_seq OWNED BY public.transactie.transactienummer;

ALTER TABLE ONLY public.bonuskaart ALTER COLUMN bonuskaartnummer SET DEFAULT nextval('public.bonuskaart_bonuskaartnummer_seq'::regclass);


ALTER TABLE ONLY public.filiaal ALTER COLUMN filiaalnummer SET DEFAULT nextval('public.filiaal_filiaalnummer_seq'::regclass);

ALTER TABLE ONLY public.product ALTER COLUMN productnummer SET DEFAULT nextval('public.product_productnummer_seq'::regclass);


ALTER TABLE ONLY public.transactie ALTER COLUMN transactienummer SET DEFAULT nextval('public.transactie_transactienummer_seq'::regclass);

SELECT pg_catalog.setval('public.bonuskaart_bonuskaartnummer_seq', 1, false);

SELECT pg_catalog.setval('public.filiaal_filiaalnummer_seq', 1, false);

SELECT pg_catalog.setval('public.product_productnummer_seq', 5, true);

SELECT pg_catalog.setval('public.transactie_transactienummer_seq', 4, true);

ALTER TABLE ONLY public.aankoop
    ADD CONSTRAINT aankoop_pkey PRIMARY KEY (transactiebonuskaartnummer, productproductnummer);

ALTER TABLE ONLY public.bonuskaart
    ADD CONSTRAINT bonuskaart_pkey PRIMARY KEY (bonuskaartnummer);


ALTER TABLE ONLY public.filiaal
    ADD CONSTRAINT filiaal_pkey PRIMARY KEY (filiaalnummer);


ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (productnummer);


ALTER TABLE ONLY public.transactie
    ADD CONSTRAINT transactie_pkey PRIMARY KEY (transactienummer);


ALTER TABLE ONLY public.aankoop
    ADD CONSTRAINT fkaankoop554580 FOREIGN KEY (productproductnummer) REFERENCES public.product(productnummer);


ALTER TABLE ONLY public.aankoop
    ADD CONSTRAINT fkaankoop744000 FOREIGN KEY (transactiebonuskaartnummer) REFERENCES public.transactie(transactienummer);


ALTER TABLE ONLY public.transactie
    ADD CONSTRAINT fktransactie507746 FOREIGN KEY (filiaalfiliaalnummer) REFERENCES public.filiaal(filiaalnummer);


ALTER TABLE ONLY public.transactie
    ADD CONSTRAINT fktransactie647021 FOREIGN KEY (bonuskaartbonuskaartnummer) REFERENCES public.bonuskaart(bonuskaartnummer);
