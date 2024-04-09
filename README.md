GRUPO 2
INTEGRANTES:
	Garbriel Cabrera
	Juan Pablo Cárdenas
	Felipe Carrasco	
	José Foitzick
	Fernando Iribarra
	Ivan Misle

CAMBIOS REALIZADOS AL DIAGRAMA ENTREGADO:

- Se añadió una relación entre Empleado y Comuna, ya que no se puede asumir que porque un empleado trabaja en un colegio en cierta comuna el empleado reside en esa comuna. La tabla Empleado es la que posee la ID de la comuna.
- Se añadió una relación entre Colegio y Alumno, ya que no existe una conexion logica entre estas debido al tipo de relaciones entre Colegio - Comuna y Empleado - Profesor (Uno es a Muchos). La tabla Alumno es la que posee la ID del colegio.
