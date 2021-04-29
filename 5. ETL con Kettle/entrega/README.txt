INSTRUCCIONES
========================================================
- Para evitar problemas a la hora de importar los scripts SQL es conveniente desactivar la revisión de claves foráneas.
- Para la ejecución del ETL:
    · Abrir el fichero 'load_reservas.kjb' como fichero individual, no abrir repositorio.
    · Al ejecutar, no debería de haber problemas de rutas para las cargas de las fuentes
      externas porque se ha utilizado la variable de Kettle ${Internal.Entry.Current.Directory}
    · Sin embargo, si se abre como repositorio esa variable será '/', y Kettle no será capaz de
      encontrar la carpeta de las fuentes externas.
- Las fuentes externas se encuentran en './kettle/Fuentes externas/'