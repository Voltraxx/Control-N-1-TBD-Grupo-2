--crear base de datos
CREATE DATABASE DB_COLEGIO;


--creación de tablas
BEGIN;


CREATE TABLE IF NOT EXISTS public."COLEGIO"
(
	id bigint NOT NULL,
    id_comuna bigint NOT NULL,
	nombre text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."COMUNA"
(
	id bigint NOT NULL,
	nombre text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."EMPLEADO"
(
	id bigint NOT NULL,
    id_sueldo bigint NOT NULL,
    id_colegio bigint NOT NULL,
    id_comuna bigint NOT NULL,
	rol text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."PROFESOR"
(
	id bigint NOT NULL,
	id_empleado bigint NOT NULL,
	nombre text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."SUELDO"
(
	id bigint NOT NULL,
	monto bigint NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."ALUMNO"
(
	id bigint NOT NULL,
    id_comuna bigint NOT NULL,
    id_colegio bigint NOT NULL,
    id_apoderado bigint NOT NULL,
	nombre text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."APODERADO"
(
	id bigint NOT NULL,
    id_comuna bigint NOT NULL,
	nombre text NOT NULL,
	asociacion text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."CURSO"
(
	id bigint NOT NULL,
    codigo_curso text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."ASISTENCIA"
(
	id bigint NOT NULL,
    id_bloque bigint NOT NULL,
	id_alu_curso bigint NOT NULL,
	presente boolean NOT NULL,
    fecha date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."FRANJA_HORARIA"
(
	id bigint NOT NULL,
	bloque integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."PROF_CURSO"
(
	id bigint NOT NULL,
	id_profesor bigint NOT NULL,
	id_curso bigint NOT NULL,
    id_bloque bigint NOT NULL,
    "PROFESOR_JEFE" boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."PLANTILLA_CURSO"
(
	id bigint NOT NULL,
    id_curso bigint NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."ALU_CURSO"
(
	id bigint NOT NULL,
    id_alumno bigint NOT NULL,
	id_curso bigint NOT NULL,
    generacion date NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public."COLEGIO"
    ADD FOREIGN KEY (id_comuna)
    REFERENCES public."COMUNA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EMPLEADO"
    ADD FOREIGN KEY (id_sueldo)
    REFERENCES public."SUELDO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EMPLEADO"
    ADD FOREIGN KEY (id_colegio)
    REFERENCES public."COLEGIO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."EMPLEADO"
    ADD FOREIGN KEY (id_comuna)
    REFERENCES public."COMUNA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PROFESOR"
    ADD FOREIGN KEY (id_empleado)
    REFERENCES public."EMPLEADO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ALUMNO"
    ADD FOREIGN KEY (id_comuna)
    REFERENCES public."COMUNA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ALUMNO"
    ADD FOREIGN KEY (id_colegio)
    REFERENCES public."COLEGIO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ALUMNO"
    ADD FOREIGN KEY (id_apoderado)
    REFERENCES public."APODERADO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."APODERADO"
    ADD FOREIGN KEY (id_comuna)
    REFERENCES public."COMUNA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ASISTENCIA"
    ADD FOREIGN KEY (id_bloque)
    REFERENCES public."FRANJA_HORARIA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ASISTENCIA"
    ADD FOREIGN KEY (id_alu_curso)
    REFERENCES public."ALU_CURSO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PROF_CURSO"
    ADD FOREIGN KEY (id_profesor)
    REFERENCES public."PROFESOR" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PROF_CURSO"
    ADD FOREIGN KEY (id_curso)
    REFERENCES public."CURSO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PROF_CURSO"
    ADD FOREIGN KEY (id_bloque)
    REFERENCES public."FRANJA_HORARIA" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PLANTILLA_CURSO"
    ADD FOREIGN KEY (id_curso)
    REFERENCES public."CURSO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ALU_CURSO"
    ADD FOREIGN KEY (id_alumno)
    REFERENCES public."ALUMNO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."ALU_CURSO"
    ADD FOREIGN KEY (id_curso)
    REFERENCES public."CURSO" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;