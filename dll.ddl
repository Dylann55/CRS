-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2021-12-12 22:12:47 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE actividad (
    id_actividad                 INTEGER NOT NULL,
    grupocurso_id_grupocurso     INTEGER NOT NULL,
    puntos                       INTEGER NOT NULL,
    contenido                    VARCHAR2(150) NOT NULL,
    participante_id_participante INTEGER NOT NULL
);

ALTER TABLE actividad ADD CONSTRAINT actividad_pk PRIMARY KEY ( id_actividad );

CREATE TABLE administrador (
    id_usuario INTEGER NOT NULL
);

ALTER TABLE administrador ADD CONSTRAINT administrador_pk PRIMARY KEY ( id_usuario );

CREATE TABLE asignatura (
    id_asignatura            INTEGER NOT NULL,
    habilitado               INTEGER NOT NULL,
    nombre                   VARCHAR2(150) NOT NULL,
    administrador_id_usuario INTEGER NOT NULL
);

ALTER TABLE asignatura ADD CONSTRAINT asignatura_pk PRIMARY KEY ( id_asignatura );

CREATE TABLE bibliotecapreguntas (
    id_biblioteca            INTEGER NOT NULL,
    asignatura_id_asignatura INTEGER NOT NULL
);

CREATE UNIQUE INDEX bibliotecapreguntas__idx ON
    bibliotecapreguntas (
        asignatura_id_asignatura
    ASC );

ALTER TABLE bibliotecapreguntas ADD CONSTRAINT bibliotecapreguntas_pk PRIMARY KEY ( id_biblioteca );

CREATE TABLE clase (
    id_clase         INTEGER NOT NULL,
    fecha_creacion   DATE NOT NULL,
    nombre           VARCHAR2(150) NOT NULL,
    modulo_id_modulo INTEGER NOT NULL
);

ALTER TABLE clase ADD CONSTRAINT clase_pk PRIMARY KEY ( id_clase );

CREATE TABLE curso (
    id_curso                 INTEGER NOT NULL,
    semestre_id_semestre     INTEGER NOT NULL,
    asignatura_id_asignatura INTEGER NOT NULL,
    profesor_id_usuario      INTEGER NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( id_curso );

CREATE TABLE equipo (
    id_equipo                INTEGER NOT NULL,
    nombre                   VARCHAR2(150) NOT NULL,
    grupocurso_id_grupocurso INTEGER NOT NULL
);

ALTER TABLE equipo ADD CONSTRAINT equipo_pk PRIMARY KEY ( id_equipo );

CREATE TABLE estudiante (
    id_usuario               INTEGER NOT NULL,
    administrador_id_usuario INTEGER NOT NULL
);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( id_usuario );

CREATE TABLE grupocurso (
    id_grupocurso            INTEGER NOT NULL,
    curso_id_curso           INTEGER NOT NULL,
    letra                    VARCHAR2(1) NOT NULL,
    preguntas_totales        INTEGER NOT NULL,
    preguntas_por_estudiante INTEGER NOT NULL
);

ALTER TABLE grupocurso ADD CONSTRAINT grupocurso_pk PRIMARY KEY ( id_grupocurso );

CREATE TABLE individual (
    id_participante           INTEGER NOT NULL,
    puntosdesdeequipoanterior INTEGER,
    equipo_id_equipo          INTEGER
);

ALTER TABLE individual ADD CONSTRAINT individual_pk PRIMARY KEY ( id_participante );

CREATE TABLE inscripciongrupocurso (
    estudiante_id_usuario    INTEGER NOT NULL,
    grupocurso_id_grupocurso INTEGER NOT NULL
);

ALTER TABLE inscripciongrupocurso ADD CONSTRAINT inscripciongrupocurso_pk PRIMARY KEY ( estudiante_id_usuario,
                                                                                        grupocurso_id_grupocurso );

CREATE TABLE integrante_equipo (
    id_participante                   INTEGER NOT NULL,
    equipo_id_equipo                  INTEGER NOT NULL,
    nºparticipaciones                 INTEGER NOT NULL,
    nºrespuestasincorrectas           INTEGER NOT NULL,
    nºpuntosrecibidos                 INTEGER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    integrante_equipo_id_participante INTEGER
);

CREATE UNIQUE INDEX integrante_equipo__idx ON
    integrante_equipo (
        integrante_equipo_id_participante
    ASC );

ALTER TABLE integrante_equipo ADD CONSTRAINT integrante_equipo_pk PRIMARY KEY ( id_participante );

CREATE TABLE modulo (
    id_modulo                INTEGER NOT NULL,
    nombre                   VARCHAR2(150) NOT NULL,
    grupocurso_id_grupocurso INTEGER NOT NULL
);

ALTER TABLE modulo ADD CONSTRAINT modulo_pk PRIMARY KEY ( id_modulo );

CREATE TABLE participacionpregunta (
    id_participacionpregunta     INTEGER NOT NULL,
    acierta                      INTEGER NOT NULL,
    participante_id_participante INTEGER NOT NULL,
    pregunta_id_pregunta         INTEGER NOT NULL
);

ALTER TABLE participacionpregunta ADD CONSTRAINT participacionpregunta_pk PRIMARY KEY ( participante_id_participante,
                                                                                        id_participacionpregunta );

CREATE TABLE participacionpreguntapropuesta ( 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    preguntapropuesta_id_preguntapropuesta INTEGER NOT NULL,
    participante_id_participante           INTEGER NOT NULL,
    acierta                                INTEGER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    id_participacionpreguntapropuesta      INTEGER NOT NULL
);

--  ERROR: PK name length exceeds maximum allowed length(30) 
ALTER TABLE participacionpreguntapropuesta ADD CONSTRAINT participacionpreguntapropuesta_pk PRIMARY KEY ( id_participacionpreguntapropuesta,
                                                                                                          participante_id_participante );

CREATE TABLE participante (
    id_participante          INTEGER NOT NULL,
    estudiante_id_usuario    INTEGER NOT NULL,
    grupocurso_id_grupocurso INTEGER NOT NULL
);

ALTER TABLE participante ADD CONSTRAINT participante_pk PRIMARY KEY ( id_participante );

CREATE TABLE pregunta (
    id_pregunta                       INTEGER NOT NULL,
    contenido                         VARCHAR2(150) NOT NULL,
    tema                              VARCHAR2(150) NOT NULL,
    subtema                           VARCHAR2(150) NOT NULL,
    usado                             INTEGER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    bibliotecapreguntas_id_biblioteca INTEGER NOT NULL,
    pregunta_id_pregunta              INTEGER
);

ALTER TABLE pregunta ADD CONSTRAINT pregunta_pk PRIMARY KEY ( id_pregunta );

CREATE TABLE preguntaescogida (
    clase_id_clase       INTEGER NOT NULL,
    pregunta_id_pregunta INTEGER NOT NULL
);

ALTER TABLE preguntaescogida ADD CONSTRAINT preguntaescogida_pk PRIMARY KEY ( clase_id_clase,
                                                                              pregunta_id_pregunta );

CREATE TABLE preguntapropuesta (
    id_preguntapropuesta         INTEGER NOT NULL,
    aprobado                     INTEGER NOT NULL,
    pregunta                     VARCHAR2(150) NOT NULL,
    participante_id_participante INTEGER NOT NULL,
    grupocurso_id_grupocurso     INTEGER NOT NULL
);

ALTER TABLE preguntapropuesta ADD CONSTRAINT preguntapropuesta_pk PRIMARY KEY ( id_preguntapropuesta );

CREATE TABLE profesor (
    id_usuario               INTEGER NOT NULL,
    administrador_id_usuario INTEGER NOT NULL
);

ALTER TABLE profesor ADD CONSTRAINT profesor_pk PRIMARY KEY ( id_usuario );

CREATE TABLE semestre (
    id_semestre              INTEGER NOT NULL,
    fechainicio              DATE NOT NULL,
    fechatermino             DATE NOT NULL,
    nºsemestre               INTEGER NOT NULL,
    habilitado               INTEGER NOT NULL,
    administrador_id_usuario INTEGER NOT NULL
);

ALTER TABLE semestre ADD CONSTRAINT semestre_pk PRIMARY KEY ( id_semestre );

CREATE TABLE usuario (
    id_usuario INTEGER NOT NULL,
    nombre     VARCHAR2(150) NOT NULL,
    apellido   VARCHAR2(150) NOT NULL,
    contraseña VARCHAR2(150) NOT NULL,
    rut        INTEGER NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE usuario ADD CONSTRAINT usuario_rut_un UNIQUE ( rut );

ALTER TABLE actividad
    ADD CONSTRAINT actividad_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

ALTER TABLE actividad
    ADD CONSTRAINT actividad_participante_fk FOREIGN KEY ( participante_id_participante )
        REFERENCES participante ( id_participante );

ALTER TABLE administrador
    ADD CONSTRAINT administrador_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE asignatura
    ADD CONSTRAINT asignatura_administrador_fk FOREIGN KEY ( administrador_id_usuario )
        REFERENCES administrador ( id_usuario );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE bibliotecapreguntas
    ADD CONSTRAINT bibliotecapreguntas_asignatura_fk FOREIGN KEY ( asignatura_id_asignatura )
        REFERENCES asignatura ( id_asignatura );

ALTER TABLE clase
    ADD CONSTRAINT clase_modulo_fk FOREIGN KEY ( modulo_id_modulo )
        REFERENCES modulo ( id_modulo );

ALTER TABLE curso
    ADD CONSTRAINT curso_asignatura_fk FOREIGN KEY ( asignatura_id_asignatura )
        REFERENCES asignatura ( id_asignatura );

ALTER TABLE curso
    ADD CONSTRAINT curso_profesor_fk FOREIGN KEY ( profesor_id_usuario )
        REFERENCES profesor ( id_usuario );

ALTER TABLE curso
    ADD CONSTRAINT curso_semestre_fk FOREIGN KEY ( semestre_id_semestre )
        REFERENCES semestre ( id_semestre );

ALTER TABLE equipo
    ADD CONSTRAINT equipo_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_administrador_fk FOREIGN KEY ( administrador_id_usuario )
        REFERENCES administrador ( id_usuario );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE grupocurso
    ADD CONSTRAINT grupocurso_curso_fk FOREIGN KEY ( curso_id_curso )
        REFERENCES curso ( id_curso );

ALTER TABLE individual
    ADD CONSTRAINT individual_equipo_fk FOREIGN KEY ( equipo_id_equipo )
        REFERENCES equipo ( id_equipo );

ALTER TABLE individual
    ADD CONSTRAINT individual_participante_fk FOREIGN KEY ( id_participante )
        REFERENCES participante ( id_participante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE inscripciongrupocurso
    ADD CONSTRAINT inscripciongrupocurso_estudiante_fk FOREIGN KEY ( estudiante_id_usuario )
        REFERENCES estudiante ( id_usuario );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE inscripciongrupocurso
    ADD CONSTRAINT inscripciongrupocurso_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

ALTER TABLE integrante_equipo
    ADD CONSTRAINT integrante_equipo_equipo_fk FOREIGN KEY ( equipo_id_equipo )
        REFERENCES equipo ( id_equipo );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE integrante_equipo
    ADD CONSTRAINT integrante_equipo_integrante_equipo_fk FOREIGN KEY ( integrante_equipo_id_participante )
        REFERENCES integrante_equipo ( id_participante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE integrante_equipo
    ADD CONSTRAINT integrante_equipo_participante_fk FOREIGN KEY ( id_participante )
        REFERENCES participante ( id_participante );

ALTER TABLE modulo
    ADD CONSTRAINT modulo_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE participacionpregunta
    ADD CONSTRAINT participacionpregunta_participante_fk FOREIGN KEY ( participante_id_participante )
        REFERENCES participante ( id_participante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE participacionpregunta
    ADD CONSTRAINT participacionpregunta_pregunta_fk FOREIGN KEY ( pregunta_id_pregunta )
        REFERENCES pregunta ( id_pregunta );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE participacionpreguntapropuesta
    ADD CONSTRAINT participacionpreguntapropuesta_participante_fk FOREIGN KEY ( participante_id_participante )
        REFERENCES participante ( id_participante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE participacionpreguntapropuesta
    ADD CONSTRAINT participacionpreguntapropuesta_preguntapropuesta_fk FOREIGN KEY ( preguntapropuesta_id_preguntapropuesta )
        REFERENCES preguntapropuesta ( id_preguntapropuesta );

ALTER TABLE participante
    ADD CONSTRAINT participante_estudiante_fk FOREIGN KEY ( estudiante_id_usuario )
        REFERENCES estudiante ( id_usuario );

ALTER TABLE participante
    ADD CONSTRAINT participante_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_bibliotecapreguntas_fk FOREIGN KEY ( bibliotecapreguntas_id_biblioteca )
        REFERENCES bibliotecapreguntas ( id_biblioteca );

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_pregunta_fk FOREIGN KEY ( pregunta_id_pregunta )
        REFERENCES pregunta ( id_pregunta );

ALTER TABLE preguntaescogida
    ADD CONSTRAINT preguntaescogida_clase_fk FOREIGN KEY ( clase_id_clase )
        REFERENCES clase ( id_clase );

ALTER TABLE preguntaescogida
    ADD CONSTRAINT preguntaescogida_pregunta_fk FOREIGN KEY ( pregunta_id_pregunta )
        REFERENCES pregunta ( id_pregunta );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE preguntapropuesta
    ADD CONSTRAINT preguntapropuesta_grupocurso_fk FOREIGN KEY ( grupocurso_id_grupocurso )
        REFERENCES grupocurso ( id_grupocurso );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE preguntapropuesta
    ADD CONSTRAINT preguntapropuesta_participante_fk FOREIGN KEY ( participante_id_participante )
        REFERENCES participante ( id_participante );

ALTER TABLE profesor
    ADD CONSTRAINT profesor_administrador_fk FOREIGN KEY ( administrador_id_usuario )
        REFERENCES administrador ( id_usuario );

ALTER TABLE profesor
    ADD CONSTRAINT profesor_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE semestre
    ADD CONSTRAINT semestre_administrador_fk FOREIGN KEY ( administrador_id_usuario )
        REFERENCES administrador ( id_usuario );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             2
-- ALTER TABLE                             59
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  17
-- WARNINGS                                 0
