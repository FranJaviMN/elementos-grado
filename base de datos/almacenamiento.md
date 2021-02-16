# Oracle


1. Crea un tablespace de undo e intenta crear una tabla en él.

Creamos el *tablespace* de nombre *undo_oracle1* y con un datafile de nombre *tablespaceundo1*:
```sql
SQL> create undo tablespace undo_oracle1 DATAFILE 'tablespaceundo1.dbf' size 100M autoextend on;

Tablespace creado.
```

Ahora bien, si intentamos crear una table en dicho tablespace nos saldrá el siguiente error:
```sql
SQL> create table prueba1(
  2  nombre varchar2(10))
  3  tablespace undo_oracle1;
create table prueba1(
*
ERROR en lÝnea 1:
ORA-30022: No se pueden crear segmentos en un tablespace de deshacer
```

2. Crea un tablespace temporal TEMP2 y escribe una sentencia SQL que genere un script que haga usar TEMP2 a todos los usuarios que tienen USERS como tablespace por defecto.

Lo primero que debemos de hacer es crear dicho *tablespace* por lo que lo creamos:
```sql
SQL> CREATE TEMPORARY TABLESPACE TEMPORAL TEMPFILE  'temp1.dbf' SIZE 100M;

Tablespace creado.
```

Una vez creado dicho *tablespace* temporal, debemos de ejecutar la siguiente sentencia sql que cambiara el *tablespace* de todos los usuarios que se encuentren en el *tablespace users*, para ello debemos, primero, sacar a los usuarios que se encuentran en dicho *tablespace*:
```sql
SQL> select USERNAME from DBA_USERS where DEFAULT_TABLESPACE='USERS';
USERNAME
------------------------------
SCOTT
FRAN
PRUEBAS
USRPRACTICA1
...
```

3. Borra todos los tablespaces creados para esta práctica sin que quede rastro de ellos. Realiza las acciones previas que sean necesarias.

Para ello, solo debemos de borrar los que hemos creado, en este caso solo hemos creado dos que son *TEMPORAL* y *undo_oracle1*, para ello debemos de usar las siguientes sentencias de SQL:
```sql
#### Borramos el tablespace TEMPORAL ####
SQL> DROP TABLESPACE TEMPORAL INCLUDING CONTENTS AND DATAFILES;

Tablespace borrado.

#### Borramos el tablespace undo_oracle1 ####
SQL> DROP TABLESPACE undo_oracle1 INCLUDING CONTENTS AND DATAFILES;

Tablespace borrado.
```

4. Averigua los segmentos existentes para realizar un ROLLBACK y el tamaño de sus extensiones.

Para ello debemos de hacer una consulta a **DBA_ROLLBACK_SEGS** seleccionando los campos de *SEGMENT_NAME y INITIAL_EXTENT* para asi obtener el nombre de los segmentos que existen y el tamaño de estos:
```sql
SQL> select SEGMENT_NAME, INITIAL_EXTENT FROM DBA_ROLLBACK_SEGS;

SEGMENT_NAME                   INITIAL_EXTENT
------------------------------ --------------
SYSTEM                                 114688
_SYSSMU10_378818850$                   131072
_SYSSMU9_3186340089$                   131072
_SYSSMU8_1682283174$                   131072
_SYSSMU7_1101470402$                   131072
_SYSSMU6_1439239625$                   131072
_SYSSMU5_2520346804$                   131072
_SYSSMU4_1451910634$                   131072
_SYSSMU3_478608968$                    131072
_SYSSMU2_1531987058$                   131072
_SYSSMU1_3086899707$                   131072

11 filas seleccionadas.
```

Si queremos mas información respecto a dichos segmentos, podemos hacer una consulta a **DBA_EXTENTS**.


5. Queremos limpiar nuestro fichero tnsnames.ora. Averigua cuales de sus entradas se están usando en algún enlace de la base de datos.


6. Escribe una entrada en tu blog explicando las limitaciones de Postgres y MariaDB respecto a ORACLE en cuanto a la gestión del almacenamiento.


# Postgres

7. Averigua si pueden establecerse claúsulas de almacenamiento para las tablas o los espacios de tablas en Postgres.

El concepto de *tablespace* en postgres si existe aunque con diferencias en cuanto a funcionalidad respecto a la versión de estos en oracle. Los *tablespace* en postgres aportan una mejora al sistema ya que permiten una segmentación y una dictribución física de los datos mucho mas eficiente ya que estos los podemos guardar en diversos **directorios**. Como ejemplo practico seria la creacion de un *tablespace* con los datos de acceso mas concurridos en el mismo disco duro local.
```sql
#### ORACLE ####
CREATE [TEMPORARY|UNDO] TABLESPACE nombrets
[DATAFILE|TEMPFILE] ruta_absoluta_fichero [SIZE nº [K|M]][REUSE][AUTOEXTEND ON [MAXSIZE n M]]
… (podemos añadir más ficheros separando con comas)...
[LOGGING|NOLOGGING]
[PERMANENT|TEMPORARY]
[DEFAULT STORAGE
(clausulas de almacenamiento)]
[OFFLINE];

#### POSTGRES ####
CREATE TABLESPACE tablespace_name
    [ OWNER { new_owner | CURRENT_USER | SESSION_USER } ]
    LOCATION 'directory'
    [ WITH ( tablespace_option = value [, ... ] ) ]
```

# MariaDB

8. Averigua si existe el concepto de índice en MySQL y si coincide con el existente en ORACLE. Explica los distintos tipos de índices existentes.

El concepto de índice en MySQL si existe y tiene varios tipos:

* **Parciales**:
```sql
CREATE INDEX idx_Alumnos_direccion ON Alumnos (direccion(100))
```

* **Multicolumna**: Este tipo de índices abarca más de una columna. Por ejemplo, nombre y apellidos.
```sql
CREATE INDEX idx_Alumnos_nombre_apellidos ON Alumnos (apellidos(100),nombre)
```

* **Secundarios o clusters: Normalmente**, este índice es sinónimo de la clave primaria. Así, si tengo creado como índice de clave primaria una columna id, físicamente los registros estarán:
```sql
ID-------Nombre
1--------Angel
2--------Maria
3--------Juan
4--------Ana
```

## Estructura de índices

* **Tipo B-Tree**:

Su uso es adecuado para consultas basadas en operadores de comparación (<,>, =, < >) y rangos de valores (between).

El índice también se puede usar LIKE para realizar comparaciones.

* **Tipo HASH**:

Se basan en el uso de una función de HASH. Este tipo de función, transforma una entrada en un valor único. Se usan solo para comparaciones de igualdad que usan los operadores = o <=>. Este tipo de índice no se puede utilizar para buscar la siguiente entrada en orden.

# MongoDB

9. Explica los distintos motores de almacenamiento que ofrece MongoDB, sus características principales y en qué casos es más recomendable utilizar cada uno de ellos.


# Fuentes Consultadas:

Mysql Indices - https://wiki.cifprodolfoucha.es/index.php?title=Mysql_Indices#Estructura_de_.C3.ADndices

Indexes(MongoDB) - https://docs.mongodb.com/manual/indexes/