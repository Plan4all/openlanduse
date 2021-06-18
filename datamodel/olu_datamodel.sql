--
--  MIT License
--  Copyright 2020-2021 Plan4all z.s.; SIA Baltic Open Solutions Center; Lesprojekt-služby, s.r.o.; WIRELESSINFO; Masarykova univerzita; Západočeská univerzita v Plzni
--

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


CREATE ROLE olu NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT;

--
-- TOC entry 3821 (class 1262 OID 61879)
-- Name: olu_db; Type: DATABASE; Schema: -; Owner: olu
--

CREATE DATABASE olu_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE olu_db OWNER TO olu;

\connect olu_db

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

--
-- TOC entry 8 (class 2615 OID 66492)
-- Name: olu2; Type: SCHEMA; Schema: -; Owner: olu
--

CREATE SCHEMA olu2;


ALTER SCHEMA olu2 OWNER TO olu;

SET default_tablespace = '';

--
-- TOC entry 255 (class 1259 OID 83304)
-- Name: administrative_unit; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.administrative_unit (
    fid text NOT NULL,
    parent_fid text NOT NULL,
    level_code integer NOT NULL,
    unit_name text NOT NULL,
    country_iso text NOT NULL,
    geom public.geometry(MultiPolygon,4326) NOT NULL
);


ALTER TABLE olu2.administrative_unit OWNER TO olu;

--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE administrative_unit; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.administrative_unit IS 'Table with administrative units';


--
-- TOC entry 243 (class 1259 OID 83095)
-- Name: attribute_origin_type; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.attribute_origin_type (
    type_id integer NOT NULL,
    type_name text NOT NULL,
    description text
);


ALTER TABLE olu2.attribute_origin_type OWNER TO olu;

--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE attribute_origin_type; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.attribute_origin_type IS 'Reference table with attribute origin enumeration';


--
-- TOC entry 228 (class 1259 OID 74692)
-- Name: atts_to_object; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.atts_to_object (
    object_fid bigint NOT NULL,
    atts_fid bigint NOT NULL,
    atts_origin integer
);


ALTER TABLE olu2.atts_to_object OWNER TO olu;

--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE atts_to_object; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.atts_to_object IS 'Decomposition table linking attribute set to OLU object';


--
-- TOC entry 254 (class 1259 OID 83256)
-- Name: clc_value; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.clc_value (
    grid_code integer,
    level1 integer,
    level2 integer,
    level3 integer,
    clc_code integer NOT NULL,
    label1 text,
    label2 text,
    label3 text,
    rgb text
);


ALTER TABLE olu2.clc_value OWNER TO olu;

--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE clc_value; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.clc_value IS 'Reference table with CORINE LAND COVER classification';


--
-- TOC entry 253 (class 1259 OID 83236)
-- Name: hilucs_value; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.hilucs_value (
    hilucs_id text NOT NULL,
    language text,
    label text,
    definition text,
    description text,
    governance_level_id text,
    governance_level_label text,
    codelist_id text,
    codelist_label text,
    reference_source text,
    reference_link text,
    status_id text,
    status_label text,
    parent_id text,
    successor_id text,
    predecessor_id text,
    value_id integer NOT NULL
);


ALTER TABLE olu2.hilucs_value OWNER TO olu;

--
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE hilucs_value; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.hilucs_value IS 'Reference table with HILUCS classification';


--
-- TOC entry 223 (class 1259 OID 66506)
-- Name: olu_attribute_set; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.olu_attribute_set (
    fid bigint NOT NULL,
    hilucs_id integer,
    atts jsonb,
    dataset_fid integer NOT NULL,
    clc_id integer
);


ALTER TABLE olu2.olu_attribute_set OWNER TO olu;

--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE olu_attribute_set; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.olu_attribute_set IS 'Main table with set of attributes to particular OLU feature';


--
-- TOC entry 222 (class 1259 OID 66504)
-- Name: olu_attributes_fid_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.olu_attributes_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.olu_attributes_fid_seq OWNER TO olu;

--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 222
-- Name: olu_attributes_fid_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.olu_attributes_fid_seq OWNED BY olu2.olu_attribute_set.fid;


--
-- TOC entry 225 (class 1259 OID 66517)
-- Name: origin_dataset; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.origin_dataset (
    fid integer NOT NULL,
    metadata_fid integer NOT NULL,
    uri text,
    dataset_type integer DEFAULT 99
);


ALTER TABLE olu2.origin_dataset OWNER TO olu;

--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE origin_dataset; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.origin_dataset IS 'Master table of origin dataset identification';


--
-- TOC entry 245 (class 1259 OID 83111)
-- Name: origin_dataset_type; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.origin_dataset_type (
    type_id integer NOT NULL,
    type_name text NOT NULL,
    description text
);


ALTER TABLE olu2.origin_dataset_type OWNER TO olu;

--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE origin_dataset_type; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.origin_dataset_type IS 'Reference table with dataset types';


--
-- TOC entry 227 (class 1259 OID 66525)
-- Name: origin_metadata; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.origin_metadata (
    fid integer NOT NULL,
    metadata text NOT NULL,
    origin_name text NOT NULL,
    valid_from date,
    valid_to date,
    origin_type text DEFAULT 'vector'::text NOT NULL,
    column_names json
);


ALTER TABLE olu2.origin_metadata OWNER TO olu;

--
-- TOC entry 3831 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE origin_metadata; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.origin_metadata IS 'Table with metadata of origin dataset';


--
-- TOC entry 231 (class 1259 OID 74761)
-- Name: origin_metadata_to_theme; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.origin_metadata_to_theme (
    metadata_fid integer NOT NULL,
    theme_fid integer NOT NULL,
    z_value integer NOT NULL,
    is_reference boolean DEFAULT false NOT NULL
);


ALTER TABLE olu2.origin_metadata_to_theme OWNER TO olu;

--
-- TOC entry 3832 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE origin_metadata_to_theme; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.origin_metadata_to_theme IS 'Decomposition table linking origin theme to origin metadata';


--
-- TOC entry 230 (class 1259 OID 74746)
-- Name: theme; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.theme (
    fid integer NOT NULL,
    theme_uri text,
    theme_name text
);


ALTER TABLE olu2.theme OWNER TO olu;

--
-- TOC entry 3833 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE theme; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.theme IS 'Reference table with themes (e.g. INSPIRE theme)';

--
-- TOC entry 221 (class 1259 OID 66495)
-- Name: olu_object; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.olu_object (
    fid bigint NOT NULL,
    dataset_fid integer NOT NULL,
    z_value integer,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    valid_from date,
    valid_to date
);


ALTER TABLE olu2.olu_object OWNER TO olu;

--
-- TOC entry 3834 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE olu_object; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.olu_object IS 'Main table with geometry';

--
-- TOC entry 220 (class 1259 OID 66493)
-- Name: olu_object_fid_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.olu_object_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.olu_object_fid_seq OWNER TO olu;

--
-- TOC entry 3835 (class 0 OID 0)
-- Dependencies: 220
-- Name: olu_object_fid_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.olu_object_fid_seq OWNED BY olu2.olu_object.fid;


--
-- TOC entry 256 (class 1259 OID 83312)
-- Name: olu_object_to_admin_unit; Type: TABLE; Schema: olu2; Owner: olu
--

CREATE TABLE olu2.olu_object_to_admin_unit (
    object_fid bigint NOT NULL,
    unit_fid text NOT NULL
);


ALTER TABLE olu2.olu_object_to_admin_unit OWNER TO olu;

--
-- TOC entry 3836 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE olu_object_to_admin_unit; Type: COMMENT; Schema: olu2; Owner: olu
--

COMMENT ON TABLE olu2.olu_object_to_admin_unit IS 'Decomposition table linking OLU object to administrative unit';

--
-- TOC entry 224 (class 1259 OID 66515)
-- Name: origin_dataset_dataset_id_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.origin_dataset_dataset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.origin_dataset_dataset_id_seq OWNER TO olu;

--
-- TOC entry 3837 (class 0 OID 0)
-- Dependencies: 224
-- Name: origin_dataset_dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.origin_dataset_dataset_id_seq OWNED BY olu2.origin_dataset.fid;


--
-- TOC entry 244 (class 1259 OID 83109)
-- Name: origin_dataset_type_type_id_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.origin_dataset_type_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.origin_dataset_type_type_id_seq OWNER TO olu;

--
-- TOC entry 3838 (class 0 OID 0)
-- Dependencies: 244
-- Name: origin_dataset_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.origin_dataset_type_type_id_seq OWNED BY olu2.origin_dataset_type.type_id;


--
-- TOC entry 226 (class 1259 OID 66523)
-- Name: origin_metadata_metadata_id_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.origin_metadata_metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.origin_metadata_metadata_id_seq OWNER TO olu;

--
-- TOC entry 3839 (class 0 OID 0)
-- Dependencies: 226
-- Name: origin_metadata_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.origin_metadata_metadata_id_seq OWNED BY olu2.origin_metadata.fid;


--
-- TOC entry 229 (class 1259 OID 74744)
-- Name: origin_theme_theme_id_seq; Type: SEQUENCE; Schema: olu2; Owner: olu
--

CREATE SEQUENCE olu2.origin_theme_theme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE olu2.origin_theme_theme_id_seq OWNER TO olu;

--
-- TOC entry 3840 (class 0 OID 0)
-- Dependencies: 229
-- Name: origin_theme_theme_id_seq; Type: SEQUENCE OWNED BY; Schema: olu2; Owner: olu
--

ALTER SEQUENCE olu2.origin_theme_theme_id_seq OWNED BY olu2.theme.fid;


--
-- TOC entry 3608 (class 2604 OID 66509)
-- Name: olu_attribute_set fid; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_attribute_set ALTER COLUMN fid SET DEFAULT nextval('olu2.olu_attributes_fid_seq'::regclass);


--
-- TOC entry 3607 (class 2604 OID 66498)
-- Name: olu_object fid; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object ALTER COLUMN fid SET DEFAULT nextval('olu2.olu_object_fid_seq'::regclass);


--
-- TOC entry 3609 (class 2604 OID 66520)
-- Name: origin_dataset fid; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset ALTER COLUMN fid SET DEFAULT nextval('olu2.origin_dataset_dataset_id_seq'::regclass);


--
-- TOC entry 3615 (class 2604 OID 83114)
-- Name: origin_dataset_type type_id; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset_type ALTER COLUMN type_id SET DEFAULT nextval('olu2.origin_dataset_type_type_id_seq'::regclass);


--
-- TOC entry 3611 (class 2604 OID 66528)
-- Name: origin_metadata fid; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_metadata ALTER COLUMN fid SET DEFAULT nextval('olu2.origin_metadata_metadata_id_seq'::regclass);


--
-- TOC entry 3613 (class 2604 OID 74749)
-- Name: theme fid; Type: DEFAULT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.theme ALTER COLUMN fid SET DEFAULT nextval('olu2.origin_theme_theme_id_seq'::regclass);


--
-- TOC entry 3651 (class 2606 OID 83311)
-- Name: administrative_unit administrative_unit_pk; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.administrative_unit
    ADD CONSTRAINT administrative_unit_pk PRIMARY KEY (fid);


--
-- TOC entry 3641 (class 2606 OID 83102)
-- Name: attribute_origin_type atts_origin_pk; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.attribute_origin_type
    ADD CONSTRAINT atts_origin_pk PRIMARY KEY (type_id);


--
-- TOC entry 3649 (class 2606 OID 83279)
-- Name: clc_value clc_value_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.clc_value
    ADD CONSTRAINT clc_value_pkey PRIMARY KEY (clc_code);


--
-- TOC entry 3646 (class 2606 OID 83286)
-- Name: hilucs_value hilucs_val_pk; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.hilucs_value
    ADD CONSTRAINT hilucs_val_pk PRIMARY KEY (value_id);


--
-- TOC entry 3624 (class 2606 OID 66514)
-- Name: olu_attribute_set olu_attributes_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_attribute_set
    ADD CONSTRAINT olu_attributes_pkey PRIMARY KEY (fid);


--
-- TOC entry 3635 (class 2606 OID 74696)
-- Name: atts_to_object olu_atts_to_object_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.atts_to_object
    ADD CONSTRAINT olu_atts_to_object_pkey PRIMARY KEY (object_fid, atts_fid);


--
-- TOC entry 3618 (class 2606 OID 66503)
-- Name: olu_object olu_object_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object
    ADD CONSTRAINT olu_object_pkey PRIMARY KEY (fid);


--
-- TOC entry 3654 (class 2606 OID 83319)
-- Name: olu_object_to_admin_unit olu_object_to_admin_unit_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object_to_admin_unit
    ADD CONSTRAINT olu_object_to_admin_unit_pkey PRIMARY KEY (object_fid, unit_fid);


--
-- TOC entry 3628 (class 2606 OID 66522)
-- Name: origin_dataset origin_dataset_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset
    ADD CONSTRAINT origin_dataset_pkey PRIMARY KEY (fid);


--
-- TOC entry 3643 (class 2606 OID 83119)
-- Name: origin_dataset_type origin_dataset_type_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset_type
    ADD CONSTRAINT origin_dataset_type_pkey PRIMARY KEY (type_id);


--
-- TOC entry 3632 (class 2606 OID 66533)
-- Name: origin_metadata origin_metadata_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_metadata
    ADD CONSTRAINT origin_metadata_pkey PRIMARY KEY (fid);


--
-- TOC entry 3639 (class 2606 OID 74765)
-- Name: origin_metadata_to_theme origin_metadata_to_theme_pkey; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_metadata_to_theme
    ADD CONSTRAINT origin_metadata_to_theme_pkey PRIMARY KEY (metadata_fid, theme_fid);


--
-- TOC entry 3637 (class 2606 OID 74754)
-- Name: theme origin_theme_pk; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.theme
    ADD CONSTRAINT origin_theme_pk PRIMARY KEY (fid);


--
-- TOC entry 3630 (class 2606 OID 83089)
-- Name: origin_dataset origindata_uri_unique; Type: CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset
    ADD CONSTRAINT origindata_uri_unique UNIQUE (uri);


--
-- TOC entry 3652 (class 1259 OID 83335)
-- Name: fki_admin_unit_to_parent_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_admin_unit_to_parent_fk ON olu2.administrative_unit USING btree (parent_fid);


--
-- TOC entry 3633 (class 1259 OID 83108)
-- Name: fki_atts_to_object_attsorigin_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_atts_to_object_attsorigin_fk ON olu2.atts_to_object USING btree (atts_origin);


--
-- TOC entry 3620 (class 1259 OID 83271)
-- Name: fki_olu_atts_clc_id_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_olu_atts_clc_id_fk ON olu2.olu_attribute_set USING btree (clc_id);


--
-- TOC entry 3621 (class 1259 OID 83277)
-- Name: fki_olu_atts_hilucs_id_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_olu_atts_hilucs_id_fk ON olu2.olu_attribute_set USING btree (hilucs_id);


--
-- TOC entry 3622 (class 1259 OID 74734)
-- Name: fki_olu_atts_origin_dataset_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_olu_atts_origin_dataset_fk ON olu2.olu_attribute_set USING btree (dataset_fid);


--
-- TOC entry 3616 (class 1259 OID 74728)
-- Name: fki_olu_object_origin_dataset_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_olu_object_origin_dataset_fk ON olu2.olu_object USING btree (dataset_fid);


--
-- TOC entry 3625 (class 1259 OID 66539)
-- Name: fki_origin_dataset_metadata; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_origin_dataset_metadata ON olu2.origin_dataset USING btree (metadata_fid);


--
-- TOC entry 3626 (class 1259 OID 83125)
-- Name: fki_origin_dataset_type_fk; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX fki_origin_dataset_type_fk ON olu2.origin_dataset USING btree (dataset_type);


--
-- TOC entry 3644 (class 1259 OID 83245)
-- Name: hilucs_id_idx; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX hilucs_id_idx ON olu2.hilucs_value USING hash (hilucs_id varchar_ops);


--
-- TOC entry 3647 (class 1259 OID 83244)
-- Name: hilucs_valueid_idx; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX hilucs_valueid_idx ON olu2.hilucs_value USING hash (value_id);


--
-- TOC entry 3619 (class 1259 OID 83030)
-- Name: olu_object_spix; Type: INDEX; Schema: olu2; Owner: olu
--

CREATE INDEX olu_object_spix ON olu2.olu_object USING gist (geom public.gist_geometry_ops_nd);

--
-- TOC entry 3666 (class 2606 OID 83330)
-- Name: administrative_unit admin_unit_to_parent_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.administrative_unit
    ADD CONSTRAINT admin_unit_to_parent_fk FOREIGN KEY (parent_fid) REFERENCES olu2.administrative_unit(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3663 (class 2606 OID 83103)
-- Name: atts_to_object atts_to_object_attsorigin_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.atts_to_object
    ADD CONSTRAINT atts_to_object_attsorigin_fk FOREIGN KEY (atts_origin) REFERENCES olu2.attribute_origin_type(type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3667 (class 2606 OID 83320)
-- Name: olu_object_to_admin_unit object_to_admunit_object_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object_to_admin_unit
    ADD CONSTRAINT object_to_admunit_object_fk FOREIGN KEY (object_fid) REFERENCES olu2.olu_object(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3668 (class 2606 OID 83325)
-- Name: olu_object_to_admin_unit object_to_admunit_unit_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object_to_admin_unit
    ADD CONSTRAINT object_to_admunit_unit_fk FOREIGN KEY (unit_fid) REFERENCES olu2.administrative_unit(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3657 (class 2606 OID 83280)
-- Name: olu_attribute_set olu_atts_clc_id_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_attribute_set
    ADD CONSTRAINT olu_atts_clc_id_fk FOREIGN KEY (clc_id) REFERENCES olu2.clc_value(clc_code);


--
-- TOC entry 3658 (class 2606 OID 83287)
-- Name: olu_attribute_set olu_atts_hilucs_pk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_attribute_set
    ADD CONSTRAINT olu_atts_hilucs_pk FOREIGN KEY (hilucs_id) REFERENCES olu2.hilucs_value(value_id);


--
-- TOC entry 3656 (class 2606 OID 74729)
-- Name: olu_attribute_set olu_atts_origin_dataset_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_attribute_set
    ADD CONSTRAINT olu_atts_origin_dataset_fk FOREIGN KEY (dataset_fid) REFERENCES olu2.origin_dataset(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3655 (class 2606 OID 74723)
-- Name: olu_object olu_object_origin_dataset_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.olu_object
    ADD CONSTRAINT olu_object_origin_dataset_fk FOREIGN KEY (dataset_fid) REFERENCES olu2.origin_dataset(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3662 (class 2606 OID 74702)
-- Name: atts_to_object oluatts_to_obj_attsfid; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.atts_to_object
    ADD CONSTRAINT oluatts_to_obj_attsfid FOREIGN KEY (atts_fid) REFERENCES olu2.olu_attribute_set(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3661 (class 2606 OID 74697)
-- Name: atts_to_object oluatts_to_obj_objfid; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.atts_to_object
    ADD CONSTRAINT oluatts_to_obj_objfid FOREIGN KEY (object_fid) REFERENCES olu2.olu_object(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3659 (class 2606 OID 66534)
-- Name: origin_dataset origin_dataset_metadata; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset
    ADD CONSTRAINT origin_dataset_metadata FOREIGN KEY (metadata_fid) REFERENCES olu2.origin_metadata(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3660 (class 2606 OID 83120)
-- Name: origin_dataset origin_dataset_type_fk; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_dataset
    ADD CONSTRAINT origin_dataset_type_fk FOREIGN KEY (dataset_type) REFERENCES olu2.origin_dataset_type(type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3665 (class 2606 OID 74771)
-- Name: origin_metadata_to_theme origin_metadata_to_theme_metadataid; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_metadata_to_theme
    ADD CONSTRAINT origin_metadata_to_theme_metadataid FOREIGN KEY (metadata_fid) REFERENCES olu2.origin_metadata(fid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3664 (class 2606 OID 74766)
-- Name: origin_metadata_to_theme origin_metadata_to_theme_themeid; Type: FK CONSTRAINT; Schema: olu2; Owner: olu
--

ALTER TABLE ONLY olu2.origin_metadata_to_theme
    ADD CONSTRAINT origin_metadata_to_theme_themeid FOREIGN KEY (theme_fid) REFERENCES olu2.theme(fid) ON UPDATE CASCADE ON DELETE CASCADE;

