-- Pregunta 1)
SELECT 
    p.id,
    p.nombre AS "Nombre profesor",
    s.monto AS "Sueldo",
    pc."PROFESOR_JEFE" AS "Jefatura",
    CASE 
        WHEN pc."PROFESOR_JEFE" = TRUE THEN c.codigo_curso
        ELSE NULL
    END AS "Codigo Curso",
    CASE 
        WHEN pc."PROFESOR_JEFE" = TRUE THEN (
            SELECT string_agg(a.nombre, ', ')
            FROM "ALU_CURSO" ac
            JOIN "ALUMNO" a ON ac.id_alumno = a.id
            WHERE ac.id_curso = pc.id_curso
        )
        ELSE NULL
    END AS "Lista Alumnos"
FROM
    "PROF_CURSO" pc
JOIN
    "PROFESOR" p ON pc.id_profesor = p.id
JOIN
    "EMPLEADO" e ON p.id_empleado = e.id
JOIN 
    "SUELDO" s ON e.id_sueldo = s.id
JOIN 
    "CURSO" c ON pc.id_curso = c.id;
	
-- Pregunta 2)
WITH AlumnosConMaxInasistencias AS (
    SELECT 
        C.codigo_curso,
        A.nombre AS nombre_alumno,
        COUNT(*) AS inasistencias
    FROM 
        public."CURSO" C
    INNER JOIN 
        public."ALU_CURSO" AC ON C.id = AC.id_curso
    INNER JOIN 
        public."ALUMNO" A ON AC.id_alumno = A.id
    LEFT JOIN 
        public."ASISTENCIA" ASIS ON AC.id = ASIS.id_alu_curso AND ASIS.presente = false
    GROUP BY 
        C.codigo_curso, A.nombre
)
SELECT
    codigo_curso,
    nombre_alumno,
    inasistencias
FROM AlumnosConMaxInasistencias
WHERE inasistencias = (
    SELECT MAX(inasistencias) FROM AlumnosConMaxInasistencias
)
ORDER BY
    codigo_curso, inasistencias DESC;
	
-- Pregunta 3)
SELECT 
   E.rol,
   S.monto,
   C.nombre AS comuna
FROM
   "EMPLEADO" E, 
   "SUELDO" S,
    "COMUNA" C
WHERE 
   E.id_sueldo = S.id AND
   E.id_comuna = C.id
Order by 
   C.nombre,
   S.monto
   
-- Pregunta 4)
SELECT
    EXTRACT(YEAR from AC.generacion) AS año,
    C.codigo_curso AS curso,
    COUNT(AC.id_alumno) AS cantidad_alumnos
FROM
    "ALU_CURSO" AC
INNER JOIN
    "CURSO" C ON AC.id_curso = C.id
GROUP BY
    EXTRACT(YEAR from AC.generacion),
    C.codigo_curso
ORDER BY
    cantidad_alumnos ASC
LIMIT 1;

-- Pregunta 5)
SELECT
    a.nombre,
    c.codigo_curso AS "Curso"
FROM
    "CURSO" c
JOIN
    "ALU_CURSO" ac ON c.id = ac.id_curso
JOIN
    "ALUMNO" a ON a.id = ac.id_alumno
WHERE
    ac.id NOT IN (
        SELECT
            id
        FROM
            "ASISTENCIA"
        WHERE
            presente = FALSE
    );

-- Pregunta 6)
SELECT 
    P.id AS id_profesor,
    P.nombre AS nombre_profesor,
    S.monto AS sueldo,
    COUNT(FH.id) AS horas_clase
FROM 
    "PROFESOR" AS P
JOIN 
    "EMPLEADO" AS E ON P.id_empleado = E.id
JOIN 
    "PROF_CURSO" AS PC ON P.id = PC.id_profesor
JOIN 
    "FRANJA_HORARIA" AS FH ON PC.id_bloque = FH.id
JOIN 
    "SUELDO" AS S ON E.id_sueldo = S.id
GROUP BY 
    P.id, P.nombre, S.monto
ORDER BY 
    horas_clase DESC
LIMIT 1;
	
-- Pregunta 7)
SELECT 
    P.id AS id_profesor,
    P.nombre AS nombre_profesor,
    S.monto AS sueldo,
    COUNT(FH.id) AS horas_clase
FROM 
    "PROFESOR" AS P
JOIN 
    "EMPLEADO" AS E ON P.id_empleado = E.id
JOIN 
    "PROF_CURSO" AS PC ON P.id = PC.id_profesor
JOIN 
    "FRANJA_HORARIA" AS FH ON PC.id_bloque = FH.id
JOIN 
    "SUELDO" AS S ON E.id_sueldo = S.id
GROUP BY 
    P.id, P.nombre, S.monto
ORDER BY 
    horas_clase ASC
LIMIT 1;
	
-- Pregunta 8)
SELECT 
    A.id AS id_alumno,
    A.nombre AS nombre_alumno,
    C.codigo_curso AS codigo_curso,
    AP.nombre AS nombre_apoderado,
    AP.asociacion AS asociacion_apoderado
FROM 
    public."ALUMNO" A
INNER JOIN public."APODERADO" AP ON A.id_apoderado = AP.id
INNER JOIN public."ALU_CURSO" AC ON A.id = AC.id_alumno
INNER JOIN public."CURSO" C ON AC.id_curso = C.id
WHERE 
    AP.asociacion != 'Madre' AND AP.asociacion != 'Padre';
	
-- Pregunta 9)
SELECT C.nombre, CO.nombre, 
AVG(CASE 
        WHEN A.presente 
            THEN 1 
            ELSE 0 
        END) AS promedio_asistencia
        
FROM "COLEGIO" C,"COMUNA" CO,"ALUMNO" AL,"ASISTENCIA" A
WHERE C.id_comuna = CO.id
AND C.id = AL.id_colegio
AND AL.id = A.id_bloque
AND EXTRACT(YEAR FROM A.fecha) = 2019
GROUP BY C.nombre, CO.nombre
ORDER BY promedio_asistencia DESC
LIMIT 1; 

-- Pregunta 10)
SELECT sub2.nombre, sub2.gen_year, sub2.numAlumnos
FROM (
    SELECT tempsub.gen_year as gen_year, MAX(tempsub.numAlumnos) as maxAlumnos
    FROM (
        SELECT C.nombre as nombre, EXTRACT(YEAR FROM AC.generacion) as gen_year, COUNT(A.id) as numAlumnos
        FROM "COLEGIO" C,"ALUMNO" A, "ALU_CURSO" AC
        WHERE C.id = A.id_colegio
        AND A.id = AC.id_alumno
        GROUP BY C.nombre, gen_year
        ORDER BY numAlumnos DESC
    ) tempsub
    GROUP BY gen_year
    ORDER BY gen_year DESC
) sub1,
(
    SELECT C.nombre as nombre, EXTRACT(YEAR FROM AC.generacion) as gen_year, COUNT(A.id) as numAlumnos
    FROM "COLEGIO" C,"ALUMNO" A, "ALU_CURSO" AC
    WHERE C.id = A.id_colegio
    AND A.id = AC.id_alumno
    GROUP BY C.nombre, gen_year
    ORDER BY numAlumnos DESC
) sub2
WHERE sub2.gen_year = sub1.gen_year
AND sub2.numAlumnos = sub1.maxAlumnos;
