---
title: Hiputecado
date: 2024-01-19
image: "/img/posts/la-tecla-esc.jpg"
categories: [ "bancos" ]
tags: [ "hipoteca" ]
draft: true
featured: true
---



Mejorando la vida de los nuevos hipotecados
==============================================================================

¿Quereis un consejo de un amigo? Nunca se os ocurra hipotecaros. Bueno, que lo
hagais si no teneis otro remedio, pero no lo hagais si realmente no lo necesitais.
Yo estoy a punto de cometer ese error. Ya no tengo otra salida.

Compré un piso en Abril de 2007 en pleno boom inmoviliario por un precio bastante
razonable para lo que se movía en aquel momento, ante la loca escalada de precios
que me incitó pensar en la posibilidad de no poder tener nada mio por el resto de
mi vida. Los precios empezaban a estar prohibitivos para cualquiera.

5 meses despues la burbuja inmoviliaria me estalló en las manos. A mi como a muchos
otros amigos de mi edad que les pasó lo mismo. Jovenes ilusionados con tener su
propia vivienda, habían puesto todos sus ahorros en manos de unos promotores
que poco tiempo despues se declararon insolventes, en quiebra. El desconocimiento
del sector y la confianza de que "todo iba bien", hizo que mucha gente entregara
esas cantidades acuentas sin ser abaladas por el banco, tal y como dicta la ley de
contratos de compraventa de viviendas.

El Articulo 47 de la Constitución Española, dice textualmente:

    "Todos los españoles tienen derecho a disfrutar de una vivienda digna
    y adecuada. Los poderes públicos promoverán las condiciones necesarias
    y establecerán las normas pertinentes para hacer efectivo este derecho,
    regulando la utilización del suelo de acuerdo con el interés general
    para impedir la especulación"

Confiemos en que los politicos de este pais algun día se dediquen a atender las
vardaderas necesidades de los ciudadanos, y les busquen soluciones, y no sigan
con la inercia de contar chistes delante de los suyos sobre las habilidades o
las carencias de su oposición. Es lamentable, indignante, frustrante, y un largo
sin fin de adjetivos que podrían seguir describiendo la situación actual de la
politica en este pais.

Gracias a ellos, seremos la generación de los pringados. Los excesos cometidos
por algunos a los que hoy en día les importa un pimiento que estemos en crisis.
Espero que algun día los politicos y gobernantes de este pais se den cuenta de
los problemas reales de los ciudadanos y se preocupen
realmente por resolverlos, y no se dediquen a contar chistes sobre las habilidades
o las carencias de su oposición.

La realidad es que los pocos que hemos tenido la suerte de que terminen nuestros
pisos, debemos hacer frente a la temida hipoteca, por un importe hoy por hoy muy
por encima del valor real de tasación del inmueble adquirido. Nadie hace nada
para evitar este tipo de injusticias. Pero lo cierto es que las personas que nos
encontramos en esta situación, pagaremos las consecuencias por el resto de nuestros
días.

Para salir lo mejor parado de esta nueva experiencia que me brinda la vida, he tenido
que aprender muchos terminos nuevos relacionados con las hipotecas: indices de
referencias, hipotecas a tipo fijo o variable, diferenciales sobre el euribor,
comisiones de apertura, amortizacion, cancelación, productos vinculados, suelos
o techos de interés, y un largo etcetera de términos economistas de los que no
había oido hablar en mi vida, o si lo había hecho, no les había prestado la
suficiente atención.

Mucha gente me dice... ¡es que hay que saber un poco de todo! Ya me gustaría a mi
que todos los economistas que manejan ordenadores para su trabajo diario aprendieran
a manejarse con conceptos tecnológicos de la informática como ensambladores, juegos
de instrucciones, compiladores, linkers, herencia virtual, constructores, variables,
punteros, estructuras, uniones, debuggers, etc.

No obstante, la suerte que tenemos los informáticos es que si algo se nos da bien
son los números, asi que el trabajo de un economista podemos aprender a realizarlo
en poco mas de una semana. Y con la información aprendida, voy a intentar explicaros
como funciona esto de las hipotecas, el calculo de las cuotas mensuales, y algunos
trucos que os permitiran ahorraros dinero con el tiempo.

Vamos a hacer un estudio donde os voy a explicar como se calculan las mensualidades
de la hipoteca.

Los datos que vamos a necesitar son:

- Capital solicitad (€): es la cantidad de dinero que le pides al banco.
- Plazo de amortización (meses): es el tiempo que vas a tardar en devolverle la
hipoteca al banco
- Interes anual (%): es el interes aplicado cada año

Con estos tres datos tenemos todo lo necesario para empezar.

Veamos todo esto con un ejemplo práctico. Pediremos 12000€ al banco, a devolver en 2 años y a un tipo de interes del 6% anual.

    Capital solicitado = C = 12000€
    Plazo de amortización = n = 24 meses
    Tasa anual de interes = 6%
    Tasa de interes mensual = 6% / 12 meses = 0.5%
    Indice de interes = i = Tasa de interes mensual / 100 = 0.005

Para calcular la cuota mensual de una hipoteca se hace servir esta formula.

    Cuota Mensual Hipoteca = C * i / [ 1 - (1 + i)**-n]

donde 2**3 = 8 (es la operacion "elevado a").

Ya es curioso que en el sitio web donde la encontré explicaban que muchos de
nuestros banqueros, con el dineral que ganan, ni siquiera sepan de donde sale
esta cantidad.

En nuestro caso concreto

    C = 12000€
    i = 0.5 / 100 = 0.005
    n = 24 meses

Sustituyendo los valores en la formula y haciendo el calculo, tenemos que la cuota mensual seria esta:

    = 12000 * 0.005 / [ 1 - (1+0.005)**(-24)] =
    = 531.85€

La siguiente tabla demuestra como se amortiza el capital pendiente a lo largo de los 24 meses:

    Año Mes     Cuota       Interes     Amortizacion        Capital pendiente
    =========================================================================
    0   0                                                   12.000,00 €
    1   1       531,85 €    60,00 €     471,85 €            11.528,15 €
    1   2       531,85 €    57,64 €     474,21 €            11.053,95 €
    1   3       531,85 €    55,27 €     476,58 €            10.577,37 €
    1   4       531,85 €    52,89 €     478,96 €            10.098,41 €
    1   5       531,85 €    50,49 €     481,36 €            9.617,05 €
    1   6       531,85 €    48,09 €     483,76 €            9.133,29 €
    1   7       531,85 €    45,67 €     486,18 €            8.647,11 €
    1   8       531,85 €    43,24 €     488,61 €            8.158,50 €
    1   9       531,85 €    40,79 €     491,05 €            7.667,44 €
    1   10      531,85 €    38,34 €     493,51 €            7.173,93 €
    1   11      531,85 €    35,87 €     495,98 €            6.677,96 €
    1   12      531,85 €    33,39 €     498,46 €            6.179,50 €
    2   13      531,85 €    30,90 €     500,95 €            5.678,55 €
    2   14      531,85 €    28,39 €     503,45 €            5.175,09 €
    2   15      531,85 €    25,88 €     505,97 €            4.669,12 €
    2   16      531,85 €    23,35 €     508,50 €            4.160,62 €
    2   17      531,85 €    20,80 €     511,04 €            3.649,58 €
    2   18      531,85 €    18,25 €     513,60 €            3.135,98 €
    2   19      531,85 €    15,68 €     516,17 €            2.619,81 €
    2   20      531,85 €    13,10 €     518,75 €            2.101,06 €
    2   21      531,85 €    10,51 €     521,34 €            1.579,72 €
    2   22      531,85 €    7,90 €      523,95 €            1.055,77 €
    2   23      531,85 €    5,28 €      526,57 €            529,20 €
    2   24      531,85 €    2,65 €      529,20 €            0,00 €

=====================================

IMPORTE TOTAL = 12764,33€
Intereses = 764,33€

Explicar el hecho de que a medida que se amortiza capital se van reduciendo los intereses.

Algunos bancos ofrecen un periodo de carencia inicial en el que no se amortiza capital
y solo se amortizan interes. Veamos cual es el efecto de hacer esto. Vamos a aplicar
una carencia de capital de 6 meses.
Ahora usamos un periodo de carencia de capital de 6 meses, es decir,
los 6 primeros meses pagaremos intereses pero no amortizaremos capital.


    Año Mes     Cuota       Interés     Amortización        Capital Pendiente
    =========================================================================
    0   0                                                   12.000,00 €
    1   1       60,00 €     60,00 €     -   €               12.000,00 €
    1   2       60,00 €     60,00 €     -   €               12.000,00 €
    1   3       60,00 €     60,00 €     -   €               12.000,00 €
    1   4       60,00 €     60,00 €     -   €               12.000,00 €
    1   5       60,00 €     60,00 €     -   €               12.000,00 €
    1   6       60,00 €     60,00 €     -   €               12.000,00 €
    1   7       698,78 €    60,00 €     638,78 €            11.361,22 €
    1   8       698,78 €    56,81 €     641,97 €            10.719,24 €
    1   9       698,78 €    53,60 €     645,18 €            10.074,06 €
    1   10      698,78 €    50,37 €     648,41 €            9.425,65 €
    1   11      698,78 €    47,13 €     651,65 €            8.774,00 €
    1   12      698,78 €    43,87 €     654,91 €            8.119,09 €
    2   13      698,78 €    40,60 €     658,19 €            7.460,90 €
    2   14      698,78 €    37,30 €     661,48 €            6.799,42 €
    2   15      698,78 €    34,00 €     664,78 €            6.134,64 €
    2   16      698,78 €    30,67 €     668,11 €            5.466,53 €
    2   17      698,78 €    27,33 €     671,45 €            4.795,09 €
    2   18      698,78 €    23,98 €     674,81 €            4.120,28 €
    2   19      698,78 €    20,60 €     678,18 €            3.442,10 €
    2   20      698,78 €    17,21 €     681,57 €            2.760,53 €
    2   21      698,78 €    13,80 €     684,98 €            2.075,55 €
    2   22      698,78 €    10,38 €     688,40 €            1.387,15 €
    2   23      698,78 €    6,94 €      691,85 €            695,30 €
    2   24      698,78 €    3,48 €      695,30 €            0,00 €

======================

IMPORTE TOTAL = 12938,05€
Intereses = 938,05€

Lo primero que vemos es que una vez finalizado el periodo de carencia, las cuotas aumentan
sustancialmente, puesto que tenemos que devolver el mismo capital prestado (no hemos amortizado
todavia nada) en menos tiempo. Otro inconveniente es el aumento del importe total por intereses
Obviamente esto tiene tambien su ventaja y es que inicialmente siempre cuesta mas hacer frente
al importe de la hipoteca y que (teóricamente) cone l tiempo ganaremos mas y tendremos mas
facilidad para hacer frente a ese incremento de importe.


A parte de esto, quiero mostraros algunos datos que os deberían resultar muy interesantes
para entender la forma de ahorrar dinero, y en cualquier caso, ser conscientes de la cantidad
de dinero que se quedara el banco por el hecho de prestaros ese dinero:


Test 1: Ahorro por anticipar la amortizacion parcial:

100000€ a un 3% anual durante 10 años
Se amortizan 20.000€


Año de amortizacion parcial     Interes total
==================================================
1                               12725€
2                               13053€
3                               13379€
4                               13701€
5                               14020€
6                               14339€
7                               14649€
8                               14960€
9                               15267€
nunca                           15872€


Conclusion: Cuanto antes se amortiza capital, mejor


Test 2: Ahorro por duracion de la hipoteca

Duracion de la hipoteca         Interes total
====================================================
5                               7812€
10                              15872€
15                              24304€
20                              33103€
25                              42263€
30                              51777€
35                              61637€
40                              71807€

Conclusion: Cuanto antes se devuelva lo prestado, mejor


Test 3: Incremento de los intereses vs años de amortizacion, para una misma
cantidad de dinero prestada por el banco de 100.000€

TAE(%)          (10 años)       (20 años)       (30 años)       (40 años)
===========================================================================
0.0%            0€              0€              0€              0€
1.0%            5124€           10374€          15790€          21365€
2.0%            10416€          21412€          33063€          45342€
3.0%            15852€          33103€          51777€          71807€
4.0%            21494€          45435€          71869€          100571€
5.0%            27278€          58389€          93255€          131398€
6.0%            33224€          71943€          115838€         164026€

Como vemos en esta tabla, para un mismo tipo de interes, el incremento de
euros pagados por intereses aumenta sustancialmente a medida que se alarga
la vida del prestamo. Estamos hablando que por 100.000€ devueltos en 10 años
al 6% parariamos 33.224€, mientras que para la misma cantidad de dinero
devuelta en un periodo de 40 años, al mismo tipo de interes, pagariamos la
friolera de 164026€, bastante mas del doble de lo que nos han prestado.




-------------------------------------------

 Hiputecado
Compré un piso en Abril de 2007 en plena burbuja inmobiliaria por un precio bastante razonable para lo que se movía en aquellos momentos, ante la alocada escalada de precios que me hizo creer que era de las últimas oportunidades que tendría en mi vida para tener algo mio en propiedad. Y es que los precios de venta ya rozaban lo prohibitivo...



5 meses después de firmar el contrato de arras para comprar un piso sobre plano, la burbuja me estalló en las manos. A mi, como a muchos otros amigos, conocidos y familiares. Mucha gente de mi edad, rondando los 30 años. Jóvenes ilusionados con tener su propia vivienda, habían puesto todos sus ahorros en manos de unos promotores que poco tiempo después se declararon insolventes, en quiebra. El desconocimiento del sector, de los riesgos de una operación tan arriesgada, de la legislación que regula este mercado, la confianza de que "todo iba bien" y que "nada malo podía pasar", hizo que mucha gente entregara cantidades de dinero a cuenta sin ser avaladas por el banco. Muchísima gente sigue hoy en día en los juzgados gastando su dinero en abogados para intentar recuperar parte de aquel dinero, muchos otros lo han perdido ya todo. Historias realmente lamentables.

Es de recordar que el Articulo 47 de la Constitución Española, dice textualmente:

    "Todos los españoles tienen derecho a disfrutar de una vivienda digna
    y adecuada. Los poderes públicos promoverán las condiciones necesarias
    y establecerán las normas pertinentes para hacer efectivo este derecho,
    regulando la utilización del suelo de acuerdo con el interés general
    para impedir la especulación"



Se trata de un derecho fundamental de todos los ciudadanos españoles. A estas alturas, ya no creo que haya ningún poder público de este país que se preocupe realmente por atender las verdaderas necesidades de los ciudadanos. Ellos siguen sonrientes, contando chistes delante de los suyos sobre las habilidades o las carencias de sus opositores. Es indignante, frustrante, vergonzoso y un largo sin fin de adjetivos que podrían seguir describiendo la situación política lamentable que vivimos en este país.

Gracias a todos ellos, muchos otros al igual que yo seremos la generación de los pringados de este país. Los pringados que pagaremos los excesos cometidos por algunos a los que hoy en día les importa un pimiento que estemos en crisis. Mientras ellos disfrutarán de lo ganado en tiempos de bonanza, otros lo estaremos pagando el resto de nuestras vidas. Y muy caro.

De los pocos que después de un largo calvario de abogados de mas de 4 años, hemos tenido la "suerte" (muy entre comillas) de que terminen la construcción de nuestra vivienda, debemos hacer frente ahora a la hipoteca, por un importe hoy por hoy muy por encima de su valor real de tasación en el mercado. A sabiendas de que los precios seguirán cayendo en los próximos meses y, probablemente, años. O eso o perder el 100% de las cantidades anticipadas. Pagar el resto de mi vida por un bien que no tiene la mitad de su valor. Viva las leyes de este país.

Para intentar reducir el coste de dicha vivienda al máximo, he tenido que aprender en muy pocos días muchos términos nuevos relacionados con el mundillo de los economistas: indices de referencias, hipotecas a tipo fijo o variable, diferenciales sobre el euribor, comisiones de apertura, amortización, cancelación, productos vinculados, suelos o techos de interés, y un largo etcétera. Y hacer números por mi cuenta para sacar mis propias conclusiones.

Mucha gente me dice... ¡es que hay que saber un poco de todo! No lo veo justo. Daría lo que fuera por ver a todos los economistas, abogados, jueces, etc. que manejan ordenadores para su trabajo a diario, se vieran en la obligación de aprender a manejarse con conceptos informáticos como ensambladores, juegos de instrucciones, compiladores, linkers, librerías, herencia, polimorfismo, estructuras de datos, clases, objetos, constructores, variables, punteros, estructuras, uniones, debuggers, ... stack overflow.

Como ingeniero tengo conocimientos matemáticos mas que suficientes para sacar a flote la triste realidad de los datos económicos que se ocultan detrás de las hipotecas. En lo que sigue intentaré explicaros como funciona esto de las hipotecas, como se realiza el cálculo de la cuota mensual y como funciona el tema de los intereses. Veremos también algunos datos que conviene tener en cuenta para ahorraros bastantes euros durante todo el pago de vuestra hipoteca.

Calculo de la cuota mensual

Veamos primero como se calcula la cuota que se paga cada mes de una hipoteca. Este dato se obtiene aplicando una formula que depende de estas 3 variables:

- Capital solicitad (€): es la cantidad de dinero que le pides al banco.
- Plazo de amortización (meses): es el tiempo que vas a tardar en devolverle el capital solicitado al banco
- Interes anual o TAE (%): es el interés aplicado cada año sobre el capital que le seguimos debiendo al banco (capital no amortizado).

Con estos tres datos tenemos todo lo necesario. Veamos un ejemplo práctico para entenderlo mejor. Pediremos al banco un crédito de 12.000€ a devolver en 2 años y a un tipo de interés TAE del 6% anual.

    Capital solicitado = C = 12000€
    Plazo de amortización = n = 24 meses
    TAE = 6%



A partir de estos 3 datos, se extrae el índice "i" de interés, como:

    TAE mensual = 6% / 12 meses = 0.5%
    Indice del interés = i = TAE mensual / 100 = 0.5 / 100 = 0.005



A partir de las variables anteriores, calculamos la cuota mensual de una hipoteca aplicando esta ecuación:

    Cuota Mensual Hipoteca = C * i / [ 1 - (1 + i)**-n ]



donde 2**3 = 2*2*2 = 8 (es la operación "elevado a"). En nuestro caso concreto

    C = 12000€
    i = 0.005
    n = 24 meses



Sustituyendo las variables calculadas en la ecuación, y haciendo el cálculo, tenemos el resultado de la cuota mensual:

    Cuota Mensual = 12000 * 0.005 / [ 1 - (1 + 0.005)**(-24) ] = 531.85€ / mes



No fue fácil encontrar esta formula. Pero me hizo gracia leer en el sitio donde la encontré que muchos de los banqueros que gestionan este tipo de productos financieros ni siquiera saben de donde se obtiene esta cantidad. Será por las primas anuales que cobran, demostrando que hay nivel...

La siguiente tabla demuestra como se amortiza el capital pendiente a lo largo de los 24 meses del plazo de amortización

    Año Mes     Cuota       Interés     Amortización        Capital pendiente
    =========================================================================
    0   0                                                   12.000,00 €
    1   1       531,85 €    60,00 €     471,85 €            11.528,15 €
    1   2       531,85 €    57,64 €     474,21 €            11.053,95 €
    1   3       531,85 €    55,27 €     476,58 €            10.577,37 €
    1   4       531,85 €    52,89 €     478,96 €            10.098,41 €
    1   5       531,85 €    50,49 €     481,36 €            9.617,05 €
    1   6       531,85 €    48,09 €     483,76 €            9.133,29 €
    1   7       531,85 €    45,67 €     486,18 €            8.647,11 €
    1   8       531,85 €    43,24 €     488,61 €            8.158,50 €
    1   9       531,85 €    40,79 €     491,05 €            7.667,44 €
    1   10      531,85 €    38,34 €     493,51 €            7.173,93 €
    1   11      531,85 €    35,87 €     495,98 €            6.677,96 €
    1   12      531,85 €    33,39 €     498,46 €            6.179,50 €
    2   13      531,85 €    30,90 €     500,95 €            5.678,55 €
    2   14      531,85 €    28,39 €     503,45 €            5.175,09 €
    2   15      531,85 €    25,88 €     505,97 €            4.669,12 €
    2   16      531,85 €    23,35 €     508,50 €            4.160,62 €
    2   17      531,85 €    20,80 €     511,04 €            3.649,58 €
    2   18      531,85 €    18,25 €     513,60 €            3.135,98 €
    2   19      531,85 €    15,68 €     516,17 €            2.619,81 €
    2   20      531,85 €    13,10 €     518,75 €            2.101,06 €
    2   21      531,85 €    10,51 €     521,34 €            1.579,72 €
    2   22      531,85 €    7,90 €      523,95 €            1.055,77 €
    2   23      531,85 €    5,28 €      526,57 €            529,20 €
    2   24      531,85 €    2,65 €      529,20 €            0,00 €

    =====================================

    IMPORTE TOTAL = 12764,33€
    Intereses = 764,33€



Como vemos, a medida que se amortiza capital (se reduce la deuda contraída con el banco) se van reduciendo los intereses, puesto que los interese solo se aplican sobre el capital pendiente de ser amortizado.

Carencia de capital

Algunos bancos ofrecen unas hipotecas con un periodo de carencia inicial en el que el hipotecado pasa un tiempo (de 1 a 5 años) durante el cual solo paga intereses, sin amortizar capital. Para entender esto, vamos a aplicar una carencia de capital de 6 meses al ejemplo anterior. Por tanto, durante los 6 primeros meses pagaremos intereses pero no amortizaremos capital.


    Año Mes     Cuota       Interés     Amortización        Capital Pendiente
    =========================================================================
    0   0                                                   12.000,00 €
    1   1       60,00 €     60,00 €     -   €               12.000,00 €
    1   2       60,00 €     60,00 €     -   €               12.000,00 €
    1   3       60,00 €     60,00 €     -   €               12.000,00 €
    1   4       60,00 €     60,00 €     -   €               12.000,00 €
    1   5       60,00 €     60,00 €     -   €               12.000,00 €
    1   6       60,00 €     60,00 €     -   €               12.000,00 €
    1   7       698,78 €    60,00 €     638,78 €            11.361,22 €
    1   8       698,78 €    56,81 €     641,97 €            10.719,24 €
    1   9       698,78 €    53,60 €     645,18 €            10.074,06 €
    1   10      698,78 €    50,37 €     648,41 €            9.425,65 €
    1   11      698,78 €    47,13 €     651,65 €            8.774,00 €
    1   12      698,78 €    43,87 €     654,91 €            8.119,09 €
    2   13      698,78 €    40,60 €     658,19 €            7.460,90 €
    2   14      698,78 €    37,30 €     661,48 €            6.799,42 €
    2   15      698,78 €    34,00 €     664,78 €            6.134,64 €
    2   16      698,78 €    30,67 €     668,11 €            5.466,53 €
    2   17      698,78 €    27,33 €     671,45 €            4.795,09 €
    2   18      698,78 €    23,98 €     674,81 €            4.120,28 €
    2   19      698,78 €    20,60 €     678,18 €            3.442,10 €
    2   20      698,78 €    17,21 €     681,57 €            2.760,53 €
    2   21      698,78 €    13,80 €     684,98 €            2.075,55 €
    2   22      698,78 €    10,38 €     688,40 €            1.387,15 €
    2   23      698,78 €    6,94 €      691,85 €            695,30 €
    2   24      698,78 €    3,48 €      695,30 €            0,00 €

    ======================

    IMPORTE TOTAL = 12938,05€
    Intereses = 938,05€



Indudablemente puede ser una buena idea contar con un periodo de carencia cuando por distintas razones no podemos hacer frente a las primeras mensualidades de nuestra hipoteca. No obstante, conviene hacer hincapié en los aspectos negativos. Una vez transcurrido el periodo de carencia, vemos como las cuotas aumentan de manera considerable, puesto que tenemos que devolver el mismo capital prestado (no hemos amortizado todavía capital) en menos tiempo. Otro inconveniente es el aumento del importe total por intereses, ya que durante el periodo de carencia, estamos pagando el máximo de intereses al banco, al no estar amortizando capital.

Cosas obvias que conviene recordar

Para finalizar, quisiera mostraros algunos datos extras que os deberían resultar muy útiles para entender como se puede ahorrar dinero al pagar una hipoteca.

Primero, anticipar las amortizaciones parciales de capital para reducir el coste total de la operación. Supongamos una hipoteca de 100.000€ a un 3% TAE a devolver durante 10 años. Vamos a amortizar 20.000€ en distintos momentos desde que se solicita el préstamo:

    Año de amortización parcial     Interes total
    ==================================================
    1                               12725€
    2                               13053€
    3                               13379€
    4                               13701€
    5                               14020€
    6                               14339€
    7                               14649€
    8                               14960€
    9                               15267€
    nunca                           15872€



De la tabla anterior se deduce que cuanto antes amorticemos capital, mas barata nos resultará la hipoteca, puesto que nos beneficiaremos durante mas tiempo de la reducción de capital pendiente de devolución, y por tanto de la reducción de intereses pagados por ese capital pendiente que le debemos al banco.

Obviamente, para poder amortizar hay que tener una alta capacidad de ahorro. Dicha capacidad de ahorro queda mermada por las distintas vinculaciones que nos exigen las entidades bancarias para poder ofrecer un buen diferencial con el índice de referencia (generalmente el euribor): planes de pensiones, fondos de inversión, seguros de hogar y de vida, etc. No soy un experto en la materia, pero según estos cálculos, yo aconsejaría huir de dichas vinculaciones como de la peste.

Segundo, devolver al banco lo antes posible el dinero que nos ha prestado, para lo cual interesa que el plazo de amortización (n) sea lo menor posible. La siguiente tabla muestra el interés total pagado por una cantidad de 100.000€ solicitada al banco a un interés TAE dado, y devuelto durante los años indicados.

    TAE(%)          (10 años)       (20 años)       (30 años)       (40 años)
    ===========================================================================
    0.0%            0€              0€              0€              0€
    1.0%            5124€           10374€          15790€          21365€
    2.0%            10416€          21412€          33063€          45342€
    3.0%            15852€          33103€          51777€          71807€
    4.0%            21494€          45435€          71869€          100571€
    5.0%            27278€          58389€          93255€          131398€
    6.0%            33224€          71943€          115838€         164026€



En la tabla anterior se observa como, a un misma tasa de interés anual TAE, cuanto menos tiempo tardemos en devolver el dinero prestado, menos nos costará el total de la operación. Dicho de otro modo, cuanto mas años tardamos en devolver el dinero, mas pagamos. Que nadie se equivoque. No se trata de picos despreciables de pocos euros. Fijaros en la barbaridad de intereses que se le pagan al banco por 100.000€ a un 6% durante 40 años: 164026€, ¡¡solo en concepto de intereses!!

Conclusiones

La conclusión de todo esto: si os lo podéis permitir, no os hipotequéis. Cualquier otra opción es mejor: plantearos la opción de vivir de alquiler. No se está nada mal y disfrutareis mucho mas de vuestras vidas. Esperar que os toque alguna herencia o incluso comprar lotería y a ver si hay suerte.

Mientras tanto, ahorrar todo el dinero que podáis, y si algún día decidís comprar, pagad el piso en metálico. Esa es la única opción que mínimamente garantiza el cumplimiento del Articulo 47 de la Constitución Española. Lo demás, es un error imperdonable. Un robo de guante blanco al amparo de la Ley. 
