---
title: Bases de datos relacionales
date: 2024-01-19
image: "/img/posts/bitcoin-consensus-mechanism.webp"
categories: ["tecnología"]
tags: ["decimal", "hexadecimal", "ascii", "binario", "base64", "base58" ]
draft: true
featured: true
---





 Diseño de bases de datos relacionales
Hacía ya tiempo que no publicaba nada en este blog. No es por falta de ganas, queridos lectores, os lo aseguro, ni tampoco por falta de ideas (tengo unos cuantos temas pendientes). Es lo de siempre: la falta de tiempo libre. Quien me mandaría a mi emanciparme... ¡¡Con lo bien que estaba yo en casa de mis padres!! :)

Con la llegada del frio invernal, esta semana pasada me decidí a escribir un pequeño articulo para recordar el proceso de normalización del diseño lógico de una base de datos hasta la tercera forma normal (3FN).

Tras publicar una primera versión (quizá alguno de vosotros ya lo leyó, ansiosos, que soys unos ansiosos!! jejeje), en realidad no me gustó mucho el resultado: contenía demasiada información inconexa, y carente del hilo conductor que a mi me gusta seguir para explicar bien las cosas, para que se entiendan.

Así que me puse a revisarlo hasta redactarlo casi por completo. Hoy lo he vuelto a leer y ahora si que está como a mi me gusta. No obstante, el articulo se extendía bastante y he tenido que esquivar distintos temas que han ido apareciendo a lo largo del documento, que darían para escribir bastantes páginas mas sobre esta materia. Quizás para otra ocasión.

Si alguien tiene interés en profundizar en algún tema que dejo apartado, que se ponga en contacto conmigo y así tendremos motivación adicional para escribir el próximo articulo. Espero que os guste.


¿Que es una base de datos?

Una base de datos (BD en adelante) es un almacén de datos de distintos tipos interrelacionados, ordenados adecuadamente, y que generalmente pertenecen a una empresa u organización. Habitualmente se representa con este símbolo. 

¿Que es un sistema gestor de base de datos?


Cada persona del mundo se podría inventar su propio método para organizar internamente una BD de creación propia: ficheros organizados por registros, una  hoja de cálculo, hojas de papel indexadas alfabéticamente, cuaderno de notas, ... Pero ninguno es lo suficientemente eficiente como para manejar volúmenes de información grandes.

Cuando se habla de manejar miles de millones de registros,  interesa que el acceso a la información se pueda automatizar desde un sistema informático que permita el acceso a la información se realice de manera rápida y eficiente. Para eso se crearon los SISTEMAS GESTORES DE BASES DE DATOS (SGBD).

El SGBD es la pieza de software a través de la cual se realizan todas las operaciones sobre la BD, actuando como un interfaz entre la BD y nuestra aplicación. Las operaciones permitidas son:

    Consultas para buscar información

    Inserciones de nuevos datos

    Borrado de datos

    Actualizaciones de los datos existentes.

Internamente, los datos se almacenan en uno o varios  discos, y en uno o varios ficheros. Pero el usuario percibe que todos los datos se encuentran en un mismo lugar, y accede a ellos mediante sentencias específicas que él y el SGBD comprenden.

Los SGBD también se encargan de otras tareas como mantener la seguridad de la información almacenada (tanto por caídas del sistema como por accesos no autorizados), o compartir la información entre varios usuarios,  evitando resultados anómalos debidos a los accesos concurrentes.


¿Que es un sistema de información?

Un sistema de información es un conjunto de elementos hardware, software y humanos, orientados al almacenamiento, tratamiento, y explotación de datos e información, organizados y listos para su uso posterior, generados para cubrir una necesidad u objetivo.

Un sistema de información se compone de varios elementos:

    Usuarios

    Telecomunicaciones (redes LAN, WAN)

    Elementos software (aplicación, BD, SGBD, sistema operativo, ...)

    Elementos hardware (servidores, routers, terminales, TPV, ...)

Como vemos, la BD y el SGBD son dos de los elementos software que componen un sistema de información.

Para desarrollar un sistema de información completo, se siguen varias fases:

    Estudio de la viabilidad

    Recogida y análisis de los requisitos

    Diseño

    Creación de prototipos

    Desarrollo

    Implantación

    Validación

    Prueba

    Operación

En concreto, la fase de diseño de un sistema de información (la que nos ocupa en este documento), se divide a su vez en:

    Diseño de la BD

    Diseño de la aplicación

La BD debe ser independiente de la aplicación que la usa. Por tanto, no se debe diseñar la BD pensando en almacenar los datos en un formato determinado que le venga bien a la aplicación. Este error es bastante típico cuando el diseñador y el programador de la aplicación, son la misma persona, y cuando lo hace, es por comodidad, pero sobre todo por falta de conocimiento.


Diseño de la base de datos

Vamos a profundizar en el diseño de la BD. El diseño de la BD, consta de 3 etapas:

    Diseño conceptual

    Diseño lógico

    Diseño físico

El diseño conceptual de la BD se realiza a partir de los requisitos del cliente, y genera como salida un ESQUEMA CONCEPTUAL, basado en el modelo entidad-relación. Este esquema conceptual es independiente del SGBD seleccionado (por tanto, el mismo para todos ellos). Esta pensado para que sea comprensible para cualquier persona que tenga relación con el proyecto, incluso sin que tenga conocimientos de programación. 

El diseño lógico de la BD se realiza a partir del esquema conceptual, y genera como salida un ESQUEMA LÓGICO. Todos los SGBD de un mismo tipo utilizan el mismo diseño lógico. En este documento vamos a centrarnos en los SGBD relacionales (ver de que se trata esto del modelo relacional, mas adelante). Por tanto, nos sirve para PostgreSQL, MySQL, Oracle, Access, SQLServer, etc.

El diseño físico de la BD se realiza a partir del esquema lógico, y genera como salida un ESQUEMA FISICO. El esquema físico ya es dependiente del SGBD elegido para implementar la DB. Por tanto, un esquema físico de Oracle no es compatible con un esquema físico de PostgreSQL, por poner un ejemplo.

En este documento no hablaremos de diseño conceptual ni tampoco de diseño físico. Ambos escapan del objetivo de este post. Quizás para otra ocasión.


Diseño lógico de la base de datos

Continuamos centrando el objetivo de este documento, entrando en mas detalles del diseño lógico de la BD.

El esquema lógico generado durante la fase de diseño lógico de la BD se representa con un LENGUAJE DE MODELADO. Antes de continuar, vamos a aclarar que es esto de un modelo, y para que sirve.

El mundo real es demasiado complejo, tiene demasiados detalles en los que nos podemos fijar. Para poder representar objetos del mundo real en un modelo, es preciso simplificar la realidad y captar solo aquellos detalles que sean de interés para el modelo en cuestión que deseamos realizar. Es lo que se conoce como modelar la realidad.

Pondremos un símil con el mundo de la especulación inmobiliaria, hoy en día tan de moda y en boca de todos. Un arquitecto hace (en realidad, hacía en la época de bonanza, ya no) varios planos de un edificio antes de que los albañiles empiecen a tirar cemento: plano de las habitaciones de cada vivienda, de los esquemas eléctricos, de los conductos de ventilación, del parking, etc. Cada uno de esos planos es un modelo distinto del edificio construido.

Como diseñadores de la BD, una de las tareas que tendremos que realizar es modelar el esquema lógico de la BD. Para hacer esta tarea, existen distintos lenguajes de modelado:

    Modelo jerárquico: relaciones padre-hijo

    Modelo en red: los hijos pueden tener varios padres

    Modelo relacional: utiliza tablas y relaciones entre ellas

    Modelo orientado a objetos: utiliza objetos y mensajes

    Modelo semántico: utiliza descripciones semánticas de la información.

    Modelo deductivo: utiliza axiomas deductivos y reglas de inferencia.

En este documento vamos a hablar exclusivamente del modelo relacional. Como ejemplos de SGBD relacionales tenemos PostgreSQL, Oracle, MySQL, SQLite, SQLServer, Access, etc.

El modelo relacional

El modelo relacional fue definido por un investigador de IBM, el científico informático Ingles, Edgar Frank Codd, en 1970, quien también desarrolló el sistema de normalización que estudiaremos después.



Probablemente, si has leído hasta este punto del documento es porque ya tenías alguna idea sobre el modelo relacional, y te suenan conceptos como relación, tupla, clave o atributo. De todas formas, como el resto del documento esta basado en estos conceptos, los vamos a definir formalmente, para que no quede ninguna duda:

Un modelo de datos relacional esta formada por un conjunto de RELACIONES R1, R2, ..., Rn, que se representan gráficamente como TABLAS.

La relación Ri esta formada por un conjunto de FILAS, TUPLAS o ENTIDADES, que se corresponden con las INSTANCIAS de la relación.

Se define CARDINALIDAD como el numero de instancias (filas) de una relación en un momento dado.

Cada relación R tiene un conjunto de ATRIBUTOS, COLUMNAS o CAMPOS, A1, A2, ..., Am. Se representan como R(A1, A2, ..., Am).

Llamamos NULO al valor de un atributo para el que no tenemos un valor. Indica un valor que no existe, o que es desconocido.

Llamamos GRADO al número de atributos de una relación.

Llamamos DOMINIO de un atributo, al conjunto de valores válidos que puede tomar ese atributo.

Veamos lo anterior con un ejemplo:

    RELACION_ALUMNOS
    Codigo      DNI         Apellido1       Apellido2   Nombre
    21313       26767671X   Martinez        Romero      Ronnie
    3910        26143413V   Lopez           Garcia      Ilsed
    19423       26913493A   Sanchez         Pons        Spyros

La relación alumnos tiene una cardinalidad 3 (3 filas), un grado 5 (5 columnas), y el dominio del atributo Nombre (por poner un ejemplo) son los strings de 32 bytes.


Claves primarias y ajenas

Muchas de las propiedades del modelo relacional se fundamentan en la definición matemática de Conjunto. Un CONJUNTO es una colección desordenada de elementos distintos del mismo tipo. Una relación es por tanto un Conjunto de tuplas. Luego no puede haber dos tuplas iguales, todas las tuplas son por tanto distintas. Además, no se asume ningún orden dentro de un conjunto.

Como las tuplas no están ordenadas, no se puede hacer referencia a una tupla por su posición dentro de la relación. El modo de hacer referencia a las tuplas es a través de las claves primarias. Pero, ¿que es esto de una clave primaria? Veamos algunas definiciones mas:

Llamamos CLAVE de una tupla a aquellos atributos que identifican de forma única a las entidades de una relación. Existen varios tipos de claves:

    SUPERCLAVE. Cualquier subconjunto de atributos que identifiquen de forma única a las tuplas de una entidad. Por tanto, el conjunto de todos los atributos de una relación es una superclave de esa relación.

    CLAVE CANDIDATA.Es el menor subconjunto de atributos de una superclave que sigue siendo un identificador único. Si a una clave candidata le quitamos un atributo, deja de ser clave candidata. Notar que en una relación puede haber varias claves candidatas, cada una de ellas con un numero distinto de atributos.

    CLAVE PRIMARIA (PK). La clave primaria es la clave candidata que el diseñador elige para identificar a las tuplas de una relación.

    CLAVE AJENA (FK). Es el conjunto de atributos de una relación R2 cuyos valores son completamente NULOS o coinciden completamente con los de la clave primaria de una relación R1. Se dice que la clave ajena de una tupla referencia a la tupla donde se define el valor correspondiente de la clave primaria.

Como las claves son conjuntos de atributos, las vamos a representar con la notación de conjuntos {...}

Diremos que R1 y R2 son dos RELACIONES INTERRELACIONADAS si R1 tiene una clave ajena que apunta a la clave primaria de R2. Por tanto, no confundir el concepto de relación (tabla) con el de interrelación (claves ajena apuntando a clave primaria).


Reglas de integridad

Las claves primarias y ajenas deben cumplir una serie de propiedades que permiten mantener la integridad de la BD, es decir, permiten asegurar que los valores de sus atributos se ajustan a los valores del mundo real modelado.

    La INTEGRIDAD DE ENTIDAD. Ningún de los atributos que componen una clave primaria puede aceptar valores NULOS, ya que la clave primaria debe identificar a cada tupla de la relación. 

    La INTEGRIDAD REFERENCIAL. Las claves ajenas no pueden contener valores que no coincidan exactamente con alguna clave primaria, a menos que todos sus atributos sean NULOS.


Los atributos que no pertenecen a las claves, también deben cumplir una serie de propiedades. En este caso, solo deben aceptar valores de su DOMINIO. Esto implica que no todos los posibles valores de un atributo tienen sentido. Por ejemplo, la edad de las personas no puede ser negativa.
 
Las reglas de integridad deben ser propiedad de la BD, no de la aplicación. Por tanto, no se deben controlar estas restricciones desde la propia aplicación. Con esto evitaremos problemas graves con inserciones, actualizaciones o borrados realizados desde fuera de la propia aplicación (inconsistencias, etc.).


Normalización de relaciones

La teoría de normalización, desarrollada por Codd en 1972, se fundamenta en una serie de formas normales (FN). Inicialmente Codd definió 3 formas normales: 1FN, 2FN y 3FN. Aunque mas tarde se han incluido otras (FNBC, 4FN y 5FN). 

Cada una de las distintas FN exige que se cumplan una serie de condiciones distintas sobre todas las relaciones del modelo. Todas las FN se incluyen en una jerarquía, de forma que una relación que esta en iFN, también está en (i-1)FN. Por ejemplo, una relación en 2FN también esta en 1FN. Aunque no se cumple la inversa, por tanto, una relación en 1FN no tiene por que estar en 2FN (aunque podría estarlo).

El proceso de normalización es un proceso mecánico que, siguiendo unas reglas que definiremos a continuación, reemplaza un conjunto inicial de relaciones por otro conjunto final de relaciones, equivalente (mismos atributos, mismas tuplas y mismas dependencias), pero con una estructura mas simple. 

Como resultado de aplicar el proceso de normalización, se obtiene una BD equivalente y con numerosas ventajas:

    optimiza el espacio de almacenamiento
    elimina las redundancias de datos 
    al eliminar redundancias, se evitan inconsistencias
    mejora la independencia de los datos
    elimina problemas en operaciones de inserción, actualización y borrado

La redundancia de datos es mala porque nos hace desperdiciar espacio en disco, lo que influye en un mayor coste (€/byte), y en un incremento del tiempo de acceso (seg/byte). Ademas, la redundancia crea problemas de mantenimiento. La operación de actualización de los datos redundantes se debe hacer de la misma forma exactamente en todas las ubicaciones del dato redundante, o pronto aparecerán las primeras inconsistencias de datos.

Y llegados a este punto, por fin encontramos el objetivo con el que inicié la escritura de este post: explicar los pasos que debes realizar para normalizar un diseño lógico hasta su tercera forma normal (3FN). Todo lo que hemos explicado hasta este momento era necesario para centrar el objetivo de este post.


La primera forma normal 1FN

Una relación esta en 1FN si y solo si todos sus atributos son atómicos.

Se habla de atomicidad en el sentido de "indivisible". Cada atributo debe contener un único valor de su dominio, en el sentido semántico, de modo que la descomposición de un dato atómico produce una pérdida de significado.

Un ejemplo tipico que incumple la primera forma normal 1FN es cuando en un campo de texto metemos varios valores del mismo dominio, como por ejemplo 3 números de teléfono.

    TABLA CLIENTES
    IDCliente       Nombre      Telefono
    45              Francisco   444444444
    275             Miguel      555555555,666666666,777777777

Una variante del caso anterior, también incorrecta, consiste en separar los campos de la lista de teléfonos en varias columnas. En el ejemplo anterior, sería tener el campo telefono1, telefono2, .... y asi. Este fallo de diseño es incluso peor que el anterior, pues habrá muchos campos nulos y en el caso de necesitar mas, tendríamos que redimensionar la tabla con un nuevo campo (telefono3).

    TABLA_CLIENTES
    IDCliente       Nombre      Telefono1       Telefono2       Telefono3
    45              Francisco   444444444       NULL            NULL
    275             Miguel      555555555       666666666       777777777

¿Como se resuelve? La regla dice lo siguiente:

    R(A,B,C,V) tal que PK(A,B) y el atributo V viola 1FN

Se obtienen dos relaciones:

    R1(A,B,C), PK(A,B)
    R2(A,B,V), PK(A,B), FK(A,B) references R1

Aplicando la regla anterior, se obtienen dos relaciones:

    TABLA_CLIENTES
    IDCliente       Nombre
    45              Francisco
    275             Miguel

    TABLA_TELEFONOS_CLIENTE
    IDCliente       Telefono
    45              444444444
    275             555555555
    275             666666666


Dependencia funcional entre atributos

Antes de continuar con 2FN y 3FN necesitamos introducir el concepto de DEPENDENCIA FUNCIONAL entre los atributos de una relación.

Los atributos de una relación los elegimos nosotros como diseñadores de la BD. Pero las dependencias entre atributos no es sencillo identificarlas, ya que requiere un analisis de las interrelaciones entre atributos, y la intuición a veces no es suficiente para encontrar y clasificar todas las dependencias (en ocasiones la BD modela conocimiento que escapa a nuestra inteligencia, o incluso peor, al sentido común).

Estas dependencias son consecuencia de los objetos del mundo real que describen las relaciones, y no de los valores actualmente almacenados en la relación. Por tanto, si tenemos una relación de vehiculos como la siguiente:

    TABLA_VEHICULOS
    Modelo          Cilindrada   Color
    Seat Leon       1900         Rojo
    Citroen XZ      1900         Rojo
    Suzuki Vitara   1900         Rojo

y en un momento dado, todos los coches de 1900cc son de color rojo, no podemos afirmar que existe una dependencia entre los atributos Color y Cilindrada, ya que se trata de un hecho casual. Por tanto, para buscar dependencias funcionales, no se deben analizar los datos de la relación, sino las entidades abstractas a los que se refieren esos datos.

Las dependencias funcionales se pueden dar entre atributos o entre subconjuntos de atributos. De forma genérica, siendo {X} e {Y} dos subconjuntos de atributos de una relación, diremos que {Y} tiene una dependencia funcional de {X}, o que {X} determina a {Y}, si cada valor de {X} siempre tiene asociado el mismo valor de {Y}.

La dependencia funcional se representa como {X} ---> {Y}

El hecho de que {X} determine a {Y} no quiere decir que conociendo {X} sabemos el valor de {Y}, sino que en la relación indicada, cada vez que {X} tome un valor determinado, {Y} en la misma fila tomara siempre el mismo valor.

Por ejemplo, si tenemos una relación clientes como la siguiente:

    TABLA_CLIENTES
    Dni                 Nombre              Edad
    40145496H           Sergio Garcia       26
    18817495B           Ania Rodriguez      48
    33133473H           Hulk Hogan          48

podemos afirmar que {Dni} determina a {Nombre}, puesto que cada vez que {Dni} tome un valor determinado, el {Nombre} en la misma fila tomara siempre el mismo valor. Sin embargo, no podemos decir que {Edad} determine a {Dni}, puesto que para un mismo valor de {Edad}, (48 años), dos {Dni} diferentes.

Diremos que la dependencia funcional {X} ---> {Y} es completa si {Y} depente de todos los atributos de {X}, no de ningún subconjunto de {X}.

Las dependencias funcionales son restricciones de integridad sobre los datos. Conocer las dependencias funcionales en el momento del diseño de la base de datos permite crear mecanismos para evitar la redundancia (y los potenciales problemas de integridad que eso conlleva) y mejorar la eficiencia.


La segunda forma normal 2FN

Una relación esta en 2FN si esta en 1FN y todos los atributos que no forman parte de la clave candidata dependen completamente de la clave candidata (y no de un subconjunto de esta). Dicho de forma simple, los atributos que no aporten información directa sobre la clave primaria, deben almacenarse en una relación separada. 

Veamos un ejemplo que no está en 2FN:

    TABLA_LINEAS_PEDIDO
    IDCliente   IDProducto      Cantidad        Nombre_producto
    29          42              1               Zapatillas deportivas de tenis
    29          10              2               Zapatillas deportivas de rubgy
    46          9               5               Balón reglamentario de baloncesto
    204         42              1               Zapatillas deportivas de tenis
    144         10              1               Zapatillas deportivas de rugby

En la tabla de lineas de pedido, la única clave candidata es la formada por los atributos [IDCliente,IDProducto].

El campo Cantidad es totalmente dependiente de la clave candidata, puesto que cada cliente compra de un producto una cantidad dada. Por tanto:

    {IDCliente,IDProducto} ---> {Cantidad}

En cambio, el campo Nombre_producto NO es totalmente dependiente de la clave candidata, puesto que el Nombre_producto solo depende del IDProducto, pero no
del IDCliente.

    {IDProducto} ---> {Nombre_producto}

Puesto que NO todos los atributos que no forman parte de la clave candidata dependen completamente de la clave candidata (Nombre_producto solo depende de un subconjunto de la clave candidata), la tabla TABLA_LINEAS_PEDIDO no esta en segunda forma normal 2FN.

Si dejaramos esta tabla tal y como esta, tendriamos una redundancia de datos innecesaria en el atributo Nombre_producto. Y ademas, podríamos crear inconsistencias de datos si cambiamos el campo Nombre_producto de un registro de la tabla. ¿Cual sería el Nombre_producto del IDProducto=42, si ese nombre es distinto en varios registros de la tabla?

¿Como se resuelve? La regla dice lo siguiente:

    R(A,B,C,D) tal que PK(A,B) y {R.A} ---> {R.D}

es decir, un atributo R.D de la tabla R no depende totalmente de la clave primaria PK(A,B), solo de una parte de esa clave primaria.

Se obtienen dos relaciones:

    R1(A,D), PK(A)
    R2(A,B,C), PK(A,B), FK(A) references R1

Aplicando la regla anterior, se obtienen dos relaciones:

    TABLA_PRODUCTOS
    IDProducto  Nombre_producto
    9           Balón reglamentario de baloncesto
    10          Zapatillas deportivas de rugby
    42          Zapatillas deportivas de tenis

    TABLA_LINEAS_PEDIDO
    IDCliente   IDProducto      Cantidad
    29          42              1
    46          9               5
    204         42              1
    144         10              1

Estas dos tablas si estan en 2FN.


La tercera forma normal 3FN.

Una tabla esta en 3FN si esta en 2FN y todos los atributos que no forman parte de la clave candidata dependen únicamente de la clave candidata. Dicho de otro modo mas facil de entender, no existen dependencias funcionales entre los atributos que no forman parte de la clave candidata.

Imagina una tabla que registra ciudades y datos sobre esas ciudades:

    TABLA_CIUDADES
    IDCiudad   Nombre    País      Continente
    1          Paris     Francia   Europa
    2          Lion      Francia   Europa
    3          Berlin    Alemania  Europa
    4          Pekin     China     Asia
    5          Bonn      Alemania  Europa

En el ejemplo anterior, la clave candidata es IDCiudad. Podemos ver que existe una dependencia funcional entre los atributos Pais y Continente, ya que cada Pais pertenece siempre al mismo Continente. Y puesto que ni Pais ni Continente forman parte de la clave candidata (IDCiudad), la tabla no esta en 3FN.

¿Como se resuelve? La regla dice lo siguiente:

    R(A,B,C) tal que PK(A) y {R.B} ---> {R.C}

es decir, un atributo R.C depende funcionalmente de R.B, y ninguno de ellos forma parte de la clave primaria PK(A).

Se obtienen dos relaciones:

    R1(B,C), PK(B)
    R2(A,B), PK(A), FK(B) references R1

Aplicando la regla anterior, se obtienen 2 relaciones:

    TABLA_PAISES
    Pais        Continente
    Francia     Europa
    Alemania    Europa
    China       Asia

    TABLA_CIUDADES
    IDCiudad   Nombre    País
    1          Paris     Francia
    2          Lion      Francia
    3          Berlin    Alemania
    4          Pekin     China
    5          Bonn      Alemania

Si no hubiéramos normalizado, tendríamos que en una fila de la tabla, el Continente de Francia es Europa, pero por error podríamos tener en otra fila de la tabla que el Continente de Francia es Asia (nos cargamos la integridad de los datos). Además, si la tabla mantuviera centenares de miles de registros, tendríamos información duplicada muchisimas veces (redundancia).


El lenguaje estructurado de consultas

El lenguaje que entienden los SGBD relacionales y desde el que se comunica nuestra aplicación con la BD se llama SQL (Structured Query Language). Este lenguaje permite realizar todas las operaciones de consulta, inserción, actualización, borrado y administración de una BD relacional.

Mediante el API adecuado, podremos usar el lenguaje SQL desde nuestra aplicación escrita en C/C++ para acceder a la BD.

No hablaremos mas sobre SQL en este documento. Quizás en otro post me anime a hablar sobre este lenguaje.
