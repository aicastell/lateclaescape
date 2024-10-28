---
title: Bitcoin y la blockchain
date: 2023-12-27
image: "/img/posts/bitcoin-consensus-mechanism.webp"
categories: [ "criptomonedas" ]
tags: [ "bitcoin", "blockchain" ]
draft: true
featured: true
---

¿Como se procesa un bloque de transacciones? Lo explicaremos despues. 

Junto con el IBAN se anota el saldo disponible en esa cuenta bancaria, actualizado tras cada operación realizada. Todos esos datos se almacenan en una base de datos centralizada propiedad del banco.

Cada nodo creará un nuevo bloque de transacciones en el que eventualmente se incluirá esta transacción TX_666, junto con otras muchas. Este bloque de transacciones será minado por todos los nodos. El primer nodo que consiga minarlo obtendrá una recompensa económica en forma de Bitcoin. Y también el privilegio de poder escribir (añadir) el nuevo bloque de transacciones (que incluye la transacción TX_666) en una base de datos distribuida conocida como blockchain. A partir de aquí, la transacción TX_666 se dará por finalizada.

+++
Bitcoin utiliza las funciones de hash Secure Hash Algorithm (SHA) y el RACE Integrity Primitives Evaluation Message Digest (RIPEMD). En concreto utiliza las variantes SHA-256 y RIPEMD160.

En el articulo anterior vimos que cada nodo de la red tiene su propio mempool de transacciones validadas ordenadas por prioridad.



  El software instalado en cada Nodo de la red de Bitcoin actúa creando un nuevo bloque de transacciones aproximadamente cada 10 minutos (no es del todo exacto como veremos después). ¿Que es un bloque de transacciones? Pues un contenedor que almacena muchas transacciones    . ¿Y de donde sale cada transacción insertada en ese bloque? Las extrae de su mempool, de la cola de transacciones ordenadas por prioridad. Cada bloque de transacciones tiene un tamaño limitado a 1MB, por lo que el Nodo solo puede elegir un subconjunto de todas las t  ra  nsacciones almacenadas en su mempool. ¿Adivinas cuales elige primero? Efectivamente, elige aquellas transacciones con mas prioridad. Es decir, las transacciones que han pagado un Fee mas elevado. Puesto que cada transacción ocupa unos 400 bytes, esto limita a unas   2000   la cantidad total de transacciones que se pueden insertar en un bloque. Quedando el resto de las transacciones almacenadas en el mempool a la espera de que se genere un nuevo bloque dentro de 10 minutos.




La prioridad define el orden con el que se procesan las transacciones. Las transacciones que pagan un Fee mas elevado se van a procesar primero. Y las que pagan un Fee mas reducido van a tardar mas tiempo en ser procesadas. En momentos temporales con un gran volumen de transacciones, pagar una Fee mas elevado puede tener sentido para garantizar que la transacción se procese antes, mientras que pagar una Fee mas reducido puede provocar que la transacción tarde mucho tiempo en procesarse (horas o incluso días). En cambio, en momentos   temporales con bajo volumen de transacciones, tiene mas sentido pagar un Fee mas reducido (o incluso nulo).

  Fíjate que da igual si transfieres 0.1 BTC o 9000 BTC. La Fee no es un porcentaje de lo transferido. Es un valor absoluto que permite establecer un orden de las transacciones, con total independencia del importe transferido. Esto permite hacer transferencias de grandes   sumas de dinero prácticamente a coste cero.





### El bloque Génesis

Pensemos ahora en el origen de los tiempos. No existen Bitcoins en circulación. Nadie tiene un wallet con Bitcoins. Tenemos una red distribuida de 5 Nodos de Bitcoin (BN1, BN2, BN3, BN4 y BN5). Cada nodo tiene su propio mempool, vacío. ¿Que mecanismo se sigue para poner el sistema en marcha? Esta historia se inició con la construcción del primer bloque, el bloque Block_0, conocido como el **Bloque Génesis**. Este bloque tiene este formato:

```
Block_0: {
    Block_Header: {
              Version: "0x1",
        Previous_Hash: "",
          Merkle_Root: "",
            Timestamp: "",
           Difficulty: "32",
                Nonce: ""
    },
    TX_List: [
        TX_SYS: { Emisor: "COINBASE", Receptor: "???", Cantidad: 50.0 BTC" }
    ]
}
```

Como vemos, el campo (2.2) Previous Hash esta vacío ya que al ser el primer bloque de transacciones generado en la historia de Bitcoin, no existe ningún bloque previo. Este bloque solo incluye una transacción en el grupo (4) Transaction List, llamada TX_SYS, que sera la que pondrá los primeros 50.0 BTC del sistema en circulación. El wallet del sistema como vemos se denomina COINBASE.

¿Como se decide quien será el beneficiario de los primeros 50.0 BTC puestos en circulación? Es un proceso que se repite con cada bloque nuevo. Se inicia una competición entre todos los Nodos de la red. El reto consiste en encontrar un valor para el campo (2.6) Nonce de la cabecera que haga que el hash SHA-256 del grupo (2) Block_Header cumpla una determinada condición. ¿Que condición debe cumplir ese hash? Que tenga los N primeros bits a cero '0'. El valor N viene determinado por el campo Difficulty (2.5) de la cabecera del bloque. El campo Difficulty es por tanto el nivel de dificultad del reto y se fija inicialmente en 32. Cuanto mas alto sea el valor Difficulty, mas difícil será resolverlo. Para complicar aún mas las cosas, el campo (2.4) Timestamp codifica los segundos transcurridos desde el 1 de Enero de 1970 y se actualiza cada segundo hasta el instante exacto en el que se resuelve el reto. Al variar un campo del Block_Header cada segundo, el hash de ese campo también cambia cada segundo. Por tanto los nodos tienen como máximo 1 segundo para resolver el reto antes de que el Timestamp se incremente en uno y deban reiniciar el proceso para buscar un hash completamente distinto. Aquí vemos a los 5 Nodos de la red trabajando sobre este bloque Block_0:

```
+---------+  +---------+  +---------+  +---------+  +---------+
| Block_0 |  | Block_0 |  | Block_0 |  | Block_0 |  | Block_0 |
+---------+  +---------+  +---------+  +---------+  +---------+
     |            |            |            |            |
    BN1          BN2          BN3          BN4          BN5
```

Los 5 nodos están ahora compitiendo por encontrar un campo Nonce tal que al aplicar la función de hash SHA-256 del grupo (2) Block_Header (la cabecera del Block_0) se genere una huella digital que tenga los 32 primeros bits a cero. Los 5 Nodos de la red se ponen a calcular funciones de hash SHA-256 sobre Block_Header a toda velocidad, exprimiendo la potencia de sus CPU al máximo de sus posibilidades, probando con distintos valores para el campo Nonce. El campo Timeout se incrementa en 1 cada segundo. Por tanto, los nodos disponen como máximo de 1 segundo para encontrar el hash correcto antes de que el Timestamp se actualice y tengan que reiniciar el proceso con la nueva cabecera.

Pasarán unos minutos antes de que uno de los Nodos, por puro azar, resuelve el reto con un Nonce 0x7c2bac1d el Sábado 3 de Enero de 2009 a las 19:15:05. Esa fecha se corresponde con el Timestamp 0x495fb939. Es decir, han pasado 1231010105 segundos desde el 1 de Enero de 1970 hasta el instante exacto en el que se ha calculado este Nonce. Supongamos que es el nodo BN1 de Estados Unidos, con wallet WL1 = 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa, el que ha resuelto el reto. Veamos como queda la estructura final del bloque Block_0:

```
Block_0: {
    Block_Header: {
              Version: "0x1",
        Previous_Hash: "",
          Merkle_Root: "0x4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
            Timestamp: "0x495fb939",
           Difficulty: "32",
                Nonce: "0x7c2bac1d"
    },
    TX_List: [
        TX_SYS: { Emisor: "COINBASE", Receptor: "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa", Cantidad: 50.0 BTC" }
    ]
}
```

Podemos comprobar que el Nonce calculado resuelve el reto matemático porque aplicando la función de hash SHA-256 sobre el grupo Block_Header:

```
SHA-256(Block_Header) = 0x000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f
```

obtenemos un hash SHA-256 que tiene los 8 primeros valores hexadecimales con valor cero (0x0), y como cada valor hexadecimal codifica 4 bits, tenemos una huella digital que tiene los 32 primeros bits a cero. Esa huella digital identifica de forma única a ese bloque, hasta el punto de que, dada su huella digital, existen exploradores [como este](https://www.blockchain.com/es/btc/block/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f) que te permiten ver su contenido online.

El nodo BN1 ha calculado un Nonce correcto y por tanto es el ganador de la competición. El wallet WL1 se establece como Receptor de la primera transacción de la historia y única del bloque Block_0 (TX_SYS). Por tanto el wallet 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa pasa a tener 50.0 BTC. El usuario dueño de ese wallet ya tiene 50.0 BTC en su propiedad. Porque es el único que tiene la clave privada para poder gastar esos Bitcoin.

Hoy en día nos puede parecer una locura regalar 50.0 BTC al precio actual, pero en Enero de 2009 esos 50.0 BTC tenían un valor de 0.0€. El sistema regaló los primeros 50.0 BTC a coste cero. Los datos que hemos analizado durante la construcción del este bloque Block_0 son reales. Son los datos con los que se inició toda esta historia de Bitcoin. Justo hoy 3 de Enero de 2024 hace 15 años que se generó este bloque Block_0. Y por eso ha sido hoy el día elegido para publicar este post. ¡Feliz cumpleaños Bloque Génesis!









### Las primeras transacciones en la historia de Bitcoin

Ya tenemos a un usuario con saldo positivo en un Wallet. A partir de este momento se inician las transferencias entre wallets. En nuestra red simplificada con 5 Nodos de Bitcoin y 5 wallet asociados, estos 5 usuarios empiezan a hacerse transferencias. Veamos una posible secuencia de transferencias, en una linea temporal con 9 instantes de tiempo t1 hasta t9:

```
Time    Transaction     Payload
--------------------------------------------------------------------------
t1      TX_01  { Emisor: WL1, Receptor: WL2, Cantidad:  9.0 BTC }
t2      TX_02  { Emisor: WL1, Receptor: WL3, Cantidad:  6.0 BTC }
t3      TX_03  { Emisor: WL1, Receptor: WL4, Cantidad:  8.0 BTC }
t4      TX_04  { Emisor: WL1, Receptor: WL5, Cantidad:  7.0 BTC }
t5      TX_05  { Emisor: WL2, Receptor: WL3, Cantidad:  4.0 BTC }
t6      TX_06  { Emisor: WL3, Receptor: WL4, Cantidad:  2.0 BTC }
t7      TX_07  { Emisor: WL4, Receptor: WL5, Cantidad:  4.0 BTC }
t8      TX_08  { Emisor: WL4, Receptor: WL2, Cantidad:  6.0 BTC }
t9      TX_09  { Emisor: WL5, Receptor: WL3, Cantidad:  1.0 BTC }
```

En la tabla anterior vemos como:

* En el instante de tiempo t1 se hace una transferencia de 9.0 BTC desde el wallet WL1 hasta el wallet WL2.
* En el instante de tiempo t2 se hace una transferencia de 6.0 BTC desde el wallet WL1 hasta el wallet WL3.
* En el instante de tiempo t3 se hace una transferencia de 8.0 BTC desde el wallet WL1 hasta el wallet WL4.

Y así sucesivamente con los instantes de tiempo restantes (t4 hasta t9).

Fijaros como se van distribuyendo los Bitcoins a lo largo del tiempo por los distintos wallet a medida que se van realizando transacciones. Representaremos la secuencia temporal con esta tabla:

```
        WL1     WL2     WL3     WL4     WL5
t0      50.0    0.0     0.0     0.0     0.0
t1      41.0    9.0     0.0     0.0     0.0
t2      35.0    9.0     6.0     0.0     0.0
t3      27.0    9.0     6.0     8.0     0.0
t4      20.0    9.0     6.0     8.0     7.0
t5      20.0    5.0    10.0     8.0     7.0
t6      20.0    5.0     8.0    10.0     7.0
t7      20.0    5.0     8.0     6.0    11.0
t8      20.0   11.0     8.0     0.0    11.0
t9      20.0   11.0     9.0     0.0    10.0
```

En cada transacción los Bitcoin van cambiando de mano, pero no tenemos nuevos Bitcoins en circulación. Por tanto, tras cada transacción, el total de Bitcoin en circulación sigue siendo el mismo, es decir, 50.0 BTC en total. Si sumamos los saldos de los 5 wallet en cada instante temporal, veremos que siempre suman 50.0 BTC. Por ejemplo, en t7 tenemos que el wallet WL1 tiene 20.0 BTC, el wallet WL2 tiene 5.0 BTC, el wallet WL3 tiene 8.0 BTC, el wallet WL4 tiene 6.0 BTC y el wallet WL5 tiene 11.0 BTC. En total la suma son 50.0 BTC.

### El primer bloque de transacciones

Nuestra red de 5 Nodos de Bitcoin sigue operativa. Cada nodo mantiene su propia cola mempool. La mempool de cada nodo va acumulando las primeras transacciones que se han ido generando en la red. Cada transacción recibida por los nodos se encola en sus respectivos mempool reordenada por prioridad. A los 10 minutos, nuestros 5 nodos de Bitcoin crean un nuevo bloque de transacciones en el que incluyen las transacciones mas prioritarias que hayan en sus respectivos mempool en ese momento. Sabemos que dentro de un bloque caben unas 2000 transacciones, pero por ahora solo se han generado unas pocas transacciones. Así que de momento este bloque va a contener todas las transacciones disponibles en el mempool.

```
Block_1: {
    Block_Header: {
              Version: "0x1",
        Previous_Hash: "0x000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f",
          Merkle_Root: "",
            Timestamp: "",
           Difficulty: "32",
                Nonce: ""
    },
    TX_List: [
        TX_SYS: { Emisor: "COINBASE", Receptor: "???", Cantidad: 50.0 BTC" },
        TX_01: { Emisor: WL1, Receptor: WL2, Cantidad: 9.0 BTC },
        TX_02: { Emisor: WL1, Receptor: WL3, Cantidad: 6.0 BTC },
        TX_03: { Emisor: WL1, Receptor: WL4, Cantidad: 8.0 BTC },
        TX_04: { Emisor: WL1, Receptor: WL5, Cantidad: 7.0 BTC },
        TX_05: { Emisor: WL2, Receptor: WL3, Cantidad: 4.0 BTC },
        TX_06: { Emisor: WL3, Receptor: WL4, Cantidad: 2.0 BTC },
        TX_07: { Emisor: WL4, Receptor: WL5, Cantidad: 4.0 BTC }
        TX_08: { Emisor: WL4, Receptor: WL2, Cantidad: 6.0 BTC },
        TX_09: { Emisor: WL5, Receptor: WL3, Cantidad: 1.0 BTC }
    ]
}
```

El valor del campo (2.5) Difficulty se mantiene en 32 porque no hay nodos nuevos en la red y con esta dificultad el sistema puede garantizar que los nodos puedan resolver el reto del Nonce en menos de 10 minutos. Fíjate como el campo (2.2) Previous_Hash ahora si tiene un valor, se corresponde con el Hash de la cabecera del bloque anterior (es decir, el hash SHA-256 de la cabecera del Block_0). Este campo actúa protegiendo la integridad de la cabecera del bloque anterior. Fíjate como se ha preparado una nueva transacción TX_SYS lista para poner en circulación otros 50.0 BTC nuevos. Esos nuevos 50.0 BTC todavía no tienen dueño asignado. Los ganará el próximo nodo que resuelva el Nonce de este bloque Block_1. De nuevo se inicia un proceso competitivo en el que todos los Nodos de la red se ponen a calcular el Nonce de este nuevo bloque:

```
   +---------+  +---------+  +---------+  +---------+  +---------+
   | Block_1 |  | Block_1 |  | Block_1 |  | Block_1 |  | Block_1 |
   +---------+  +---------+  +---------+  +---------+  +---------+
        |            |            |            |            |
       BN1          BN2          BN3          BN4          BN5
```

Los 5 nodos compiten por encontrar un campo Nonce tal que al aplicar la función de hash SHA-256 sobre el grupo (2) Block_Header (la cabecerea del Block_1) se genere una huella digital que tenga los 32 primeros bits a cero. Los 5 Nodos de la red se ponen a calcular funciones de hash SHA-256 sobre el campo Block_Header a toda velocidad, exprimiendo la potencia de sus CPU al máximo de sus posibilidades. Pasados unos minutos, otro de los nodos, de nuevo por puro azar, resuelve el reto con un campo Nonce 0x61bdd208 el Sábado 3 de Enero de 2009 a las 19:24:02, fecha que se corresponde con el Timestamp 0x495fbb52. Supongamos que el reto lo resuelve el nodo ruso BN2, con wallet WL2 = 1HLoD9E4SDFFPDiYfNYnkBLQ85Y51J3Zb1. Vemos la estructura final del bloque Block_1:

```
Block_1: {
    Block_Header: {
              Version: "0x1",
        Previous_Hash: "0x000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f",
          Merkle_Root: "0x9b0fc92260312ce44e74ef369f5c66bbb85848f2eddd5a7a1cde251e54ccfdd5",
            Timestamp: "0x495fbb52",
           Difficulty: "32",
                Nonce: "0x61bdd208"
    },
    TX_List: [
        TX_SYS: { Emisor: "COINBASE", Receptor: "1HLoD9E4SDFFPDiYfNYnkBLQ85Y51J3Zb1", Cantidad: 50.0 BTC" },
        TX_01: { Emisor: WL1, Receptor: WL2, Cantidad: 9.0 BTC },
        TX_02: { Emisor: WL1, Receptor: WL3, Cantidad: 6.0 BTC },
        TX_03: { Emisor: WL1, Receptor: WL4, Cantidad: 8.0 BTC },
        TX_04: { Emisor: WL1, Receptor: WL5, Cantidad: 7.0 BTC },
        TX_05: { Emisor: WL2, Receptor: WL3, Cantidad: 4.0 BTC },
        TX_06: { Emisor: WL3, Receptor: WL4, Cantidad: 2.0 BTC },
        TX_07: { Emisor: WL4, Receptor: WL5, Cantidad: 4.0 BTC }
        TX_08: { Emisor: WL4, Receptor: WL2, Cantidad: 6.0 BTC },
        TX_09: { Emisor: WL5, Receptor: WL3, Cantidad: 1.0 BTC }
    ]
}
```

De nuevo podemos comprobar que el Nonce calculado resuelve el reto matemático aplicando la función de hash SHA-256 sobre el Block_Header:

```
SHA-256(Block_Header) = 0x000000006a625f06636b8bb6ac7b960a8d03705d1ace08b1a19da3fdcc99ddbd
```

Obtenemos un hash SHA-256 que tiene los 8 primeros valores hexadecimales con valor cero (0x0). Es decir, los 32 primeros bits a cero.

El nodo BN2 ha calculado el Nonce correcto y por tanto es el ganador de la competición. El wallet del Nodo BN2 se establece como Receptor de los 50.0 BTC Bitcoin nuevos que el sistema acaba de poner en circulación. Por tanto el wallet 1HLoD9E4SDFFPDiYfNYnkBLQ85Y51J3Zb1 pasa a tener 50.0 BTC.

## Los mineros de Bitcoin

El proceso general que acabamos de describir recibe el nombre de **minería de Bitcoin**. A la tarea de buscar el Nonce valido para un bloque se la llama **minado del bloque**. A los Nodos de la Red de Bitcoin, y por extensión también a sus dueños, se les llama **mineros de Bitcoin**. Hemos identificado la SEGUNDA utilidad de los Nodos de Bitcoin: minar bloques de transacciones para encontrar el Nonce correcto. En las noticias, en Internet, o hablando con un amigo, estoy seguro que alguna vez habéis oído hablar sobre los mineros de Bitcoin. Y te los imaginabas con pico y pala ¿verdad? Siento decepcionarte. No son esa clase de mineros como acabas de aprender.

Al reto matemático consistente en averiguar el Nonce se le llama **prueba de esfuerzo** (Proof of Work o POW), puesto que es un reto que exige un esfuerzo computacional enorme para los mineros de Bitcoin, que deben calcular muchísimas funciones de hash SHA-256 sobre la cabecera del bloque cada segundo, hasta dar con el campo Nonce que cumpla la condición establecida por el campo Difficulty.

Queda bastante claro que los nodos de Bitcoin son muy importantes para el funcionamiento de todo este sistema. De hecho, si desaparecieran todos los nodos, la criptomoneda Bitcoin desaparecería con ellos. Es muy importante que esos Nodos se mantengan operativos siempre. Pero poner un nodo de Bitcoin en marcha supone una inversión de dinero importante para su propietario. Supone comprar hardware caro, pagar la factura de la luz, mantener actualizado el software. ¿Quien va a hacer todo esto a cambio de nada? Parece un sistema destinado al fracaso.

¿De que manera se incentiva a los mineros para que mantengan sus nodos operativos? El incentivo es estrictamente económico. Funciona mediante recompensas. Ya hemos visto un poco el funcionamiento. Se recompensa con Bitcoins al minero que gana la competición y logra minar un bloque. ¿Y de donde salen los Bitcoin de esa recompensa? Provienen de dos fuentes:

1. De las Fees
2. Recompensa por bloque

### Las fees

De una parte, el minero recibe la suma de todas las Fees pagadas por los emisores de las distintas transacciones que han sido añadidas al bloque minado. Ese es el motivo principal por el que las Fees mas elevadas tienen mas prioridad. Los Mineros han invertido mucho dinero y horas de trabajo, y quieren rentabilizar al máximo su inversión.

### Recompensa por bloque

De otra parte, el sistema crea nuevos Bitcoin cada vez que se mina un bloque. Los crea de la nada. El sistema lo que hace es añadir una nueva transacción al bloque minado en el que usa como emisor un wallet del sistema (COINBASE) y como receptor el wallet del minero. Esa transacción es la primera que se escribe en el bloque. ¿Cual es la recompensa por bloque minado? Es una recompensa fijada en las entrañas del algoritmo de Bitcoin. En el origen de los tiempos, allá por 2009, la recompensa era de 50.0 BTC por cada bloque minado. Por aquel entonces el precio de Bitcoin era de 0.0€. Por lo que regalar 50.0BTC era como regalar piedras.

Sin embargo, Bitcoin está diseñado para reducir esa recompensa a la mitad exactamente cada 210000 bloques, lo que ocurre aproximadamente cada cuatro años. Al evento que reduce esa recompensa a la mitad se le conoce como **Bitcoin Halving**. En la historia del Bitcoin ya hemos vivido 3 Halving. El último Halving ocurrió el pasado 11 de Mayo de 2020. Actualmente la recompensa por bloque minado es de 6.25 BTC. El próximo Halving se espera durante este año 2024.

```
Event               Date            Block       Reward (BTC)    BTC mined(%)
----------------------------------------------------------------------------
Bitcoin origin      03/01/2009      0           50.0000         50.0%
Halving 1           28/11/2012      210000      25.0000         75.0%
Halving 2           09/07/2016      420000      12.5000         87.5%
Halving 3           11/05/2020      630000       6.2500         93.75%
Halving 4           2024            840000       3.1250         96.875%
Halving 5           2028            1050000      1.5625         98.4375%
Halving 6           2032            1260000      0.78125        99.21875%
```

¿Que implicaciones tiene el Bitcoin Halving?. Te contesto con otra pregunta: ¿entiendes la Ley de Oferta y Demanda?. Pues ni mas ni menos, ocurre lo mismo. Cada vez que ocurre un Bitcoin Halving se reduce a la mitad la cantidad de Bitcoins que el sistema pone en circulación. Se reduce la oferta. Por otro lado, el interés en las criptomonedas es creciente. Cada vez hay mas instituciones que compran Bitcoin en cantidades ingentes como reserva de valor: estados, compañías de seguros, bancos... La demanda aumenta. Con menos oferta y mas demanda, ¿que ocurre? Es inevitable: el precio del Bitcoin aumenta. Y este es el principal motivo por el que el precio de Bitcoin es y será cada vez mas elevado. Tomando como referencia un mes cualquiera (por ejemplo el 25 de Diciembre) vamos a ver el histórico de precios de Bitcoin a lo largo de su historia:

```
25/12/2009        0.00$
25/12/2010        0.25$
25/12/2011        4.00$
25/12/2012       13.00$ (Halving 1)
25/12/2013      682.00$
25/12/2014      319.00$
25/12/2015      455.00$
25/12/2016      896.00$ (Halving 2)
25/12/2017    14026.00$
25/12/2018     3815.00$
25/12/2019     7275.00$
25/12/2020    23652.00$ (Halving 3)
25/12/2021    50389.00$
25/12/2022    16458.00$
25/12/2023    43013.00$
```

Te animo a predecir su precio para el 25/12/2024 (año del Halving 4) en el [canal de Telegram](https://t.me/lateclaescape).

Bitcoin esta diseñado para poner en circulación un máximo de 21 millones de monedas. Se estima que hay unos 8000 millones de personas en el planeta. No habrá Bitcoin para todos.

Puesto que se mina un bloque nuevo cada 10 minutos, el sistema está poniendo nuevos Bitcoin en circulación cada 10 minutos de forma ininterrumpida. Hoy mismo se están creando 6.25 BTC nuevos cada 10 minutos. Al precio actual (1.0 BTC = 40000€) la red esta recompensando a los mineros con 250000€ cada 10 minutos. Es decir, 36 millones de euros al día. Motivo mas que suficiente para invertir en hardware y poner un minero en marcha. ¿No te parece?

Sin embargo, al ritmo de minado marcado por el propio algoritmo, un nuevo bloque cada 10 minutos, se espera que mas del 99% del Bitcoin habrá sido minado para el año 2032. A partir de esa fecha no habrá muchos Bitcoin nuevos disponibles para poner en circulación. ¿Que incentivo tendrán los mineros para mantener sus nodos operativos a partir de esa fecha? Exclusivamente las comisiones (Fee). Se espera que las comisiones pagadas por los emisores de las transacciones sean aliciente suficiente para que los mineros mantengan sus nodos operativos. ¿Será suficiente para que los mineros mantengan operativos sus nodos? Habrá que verlo.

Quiero aprovechar este momento para contaros una anécdota. Durante los años 2009, 2010, 2011 y parte de 2012, se regalaban 50.0 BTC cada 10 minutos. Por aquel entonces, minar Bitcoin era bastante sencillo. Al no haber muchos Nodos en la red, el campo Difficulty era muy bajo. Y con un hardware relativamente barato se podían conseguir Bitcoin muy fácilmente. El 18 de mayo de 2010, un programador estadounidense llamado Laszlo Hanyecz publicó en el foro de Bitcoin que había usado 10000 Bitcoins (valorados en 40$ en aquel momento) para comprar dos pizzas grandes de Papa John. Al precio actual, aquellas 2 pizzas están valoradas hoy en día en 400 millones de euros. ¡La pizza mas cara de la historia!

### El hashrate de los mineros

La potencia de calculo de cada minero de Bitcoin viene determinada por el número de hashes SHA-256 que es capaz de calcular su hardware por segundo. Este valor es conocido como su **hashrate**. Tenemos varias unidades para el hashrate de los mineros:

```
 H/s (Hash)         1
kH/s (KiloHash)     1000
MH/s (MegaHash)     1000000
GH/s (GigaHash)     1000000000
TH/s (TeraHash)     1000000000000
PH/s (PetaHash)     1000000000000000
EH/s (ExaHash)      1000000000000000000
ZH/s (ZettaHash)    1000000000000000000000
YH/s (YottaHash)    1000000000000000000000000
```

Un procesador Intel Core i7 3930k es capaz de generar unos 66000000 hashes SHA-256 por segundo. Dicho de otro modo, tiene una capacidad de 66 MegaHash/s. Por otro lado, el campo Nonce tiene 4 bytes, luego existen 2 ^ 32 = 4294967296 valores Nonce posibles. ¿Cuantos segundos necesita este procesador Intel Core i7 3930k para calcular el hash SHA-256? En el peor de los casos (suponiendo que tenga que probar todas las posibilidades) tendríamos:

```
4294967296 / 66000000 = 65 segundos
```

Es decir, un procesador Intel Core i7 bastante potente necesita mas de un minuto calculando hashes a máximo rendimiento para probar todos los Nonce posibles. Sin embargo, solo dispone de una ventana de un segundo antes de que el campo Timeout se incremente, y por tanto el hash de la cabecera cambie por completo. Resolver el reto matemático en menos de un segundo es una tarea que exige de una capacidad computacional descomunal.

Miles de mineros repartidos por todo el mundo aportan su hashrate a la red de Bitcoin. Sumando el hashrate de cada minero tenemos el hashrate total de la red. La red sabe el hashrate total en todo momento. Hoy mientras escribo estas lineas tenemos un hashrate total de 520 EH/s. Es decir 520000000000000000000 Hashes por segundo. Una auténtica barbaridad. Sin ninguna duda me atrevo a afirmar que se trata del mayor supercomputador jamás construido por el ser humano.

Hemos dicho que aproximadamente cada 10 minutos se genera un nuevo bloque. Ese periodo de 10 minutos viene determinado por el tiempo aproximado que la red tarda en minar un bloque. Obviamente, en una red dinámica como la de Bitcoin, en la que algunos nodos se pueden apagar y otros se pueden encender, el hashrate global varia con el tiempo. ¿Como regula el sistema esa tasa de minado de bloques constante, en torno a los 10 minutos? Para conseguirlo, el sistema juega con el campo Difficulty de la cabecera del bloque. Exactamente cada 2016 bloques minados, el sistema ajusta el valor de Difficulty para adaptarse a la nueva realidad de la red. Cuando hay muchos mineros, se aumenta el Difficulty para que sea mas difícil encontrar el hash correcto. Y cuando hay pocos mineros, se reduce el Difficulty para que sea mas fácil encontrar el hash correcto.





## La base de datos de Bitcoin (blockchain)

Este proceso de crear un bloque nuevo se repite aproximadamente cada 10 minutos. Pero, ¿y esos bloques? ¿donde se almacenan de forma persistente?

La banca tradicional utiliza una base de datos centralizada que almacena todas las cuentas bancarias con sus saldos asociados. Bitcoin también necesita una base de datos. Pero a diferencia de lo que ocurre con los bancos tradicionales, la base de datos de Bitcoin no se encuentra almacenada en un solo ordenador central. No tiene dueño. No está gestionada ni administrada por ninguna empresa, organismo o entidad central. ¡Whaaaaaat! ¿De verdad es posible todo eso?.

Pues si. Para lograrlo Bitcoin utiliza una base de datos distribuida, que se encuentra replicada en cada uno de los Nodos de la red de Bitcoin. Esto significa que existe una copia exacta de toda la base de datos en cada Nodo de la red. Acabamos de identificar la TERCERA utilidad de los Nodos de Bitcoin: proveer espacio de almacenamiento suficiente para alojar la base de datos. El software instalado en cada Nodo se encarga de descargar la base de datos completa, y posteriormente de mantenerla sincronizada con la del resto de los Nodo activos en la red. El tamaño actual de la base de datos de Bitcoin supera los 100GB y sigue creciendo cada día. Así que si intentas instalarte un Nodo de Bitcoin ten un poco de paciencia porque dependiendo de la velocidad de tu conexión de Internet, puedes tardar horas o incluso días en descargarla completamente. Asegúrate primero de tener mas de 100GB libres en tu disco duro.

Al no depender de un solo servidor central, la base de datos distribuida no tiene un solo punto de fallo. Por lo que el sistema es tolerante a fallos catastróficos incluso en las condiciones mas adversas que podáis imaginar. Si el gobierno Chino decide vetar el uso de Bitcoin, el nodo BN3 caería de nuestra red. Sin embargo, esto no afectaría a la red de Bitcoin ni a su disponibilidad, ya que seguirá funcionando en el resto de los países con total normalidad.

La banca tradicional organiza su base de datos como una tabla. Una tabla enorme si, pero en definitiva una tabla. Bitcoin no utiliza tablas. En cambio, organiza su información interna como una lista encadenada de bloques de transacciones. Bloques de transacciones como los bloques Block_0 o Block_1 que hemos analizado en secciones anteriores. Y debido a esto, la tecnología subyacente recibe el nombre de cadena de bloques o blockchain. Tecnología de la que estoy seguro que habíais oído hablar en mas de una ocasión pero si estáis leyendo este documento probablemente es porque todavía no habíais entendido como funciona.

### Inserción de bloques en la blockchain

Una vez calculado el campo Nonce del bloque Block_0, debe insertarse ese bloque como el primero de la blockchain. ¿Que proceso se sigue para insertar el nuevo bloque Block_0 en la blockchain?. Hemos dicho que se trata de un sistema distribuido en el que todos los Nodos pueden operar sin necesidad de que haya un coordinador central. Si todos los nodos de la red son iguales, y ninguno de ellos dicta un orden al resto, ¿como eligen entre todos ellos el nodo encargado de añadir el siguiente bloque a la blockchain? Pues muy simple: El nodo que resuelve primero el reto del Nonce es el ganador del reto, y como tal tendrá el honor de poder insertar ese bloque minado en la blockchain.

El Nodo que resolvió el reto matemático del Block_0 fue el Nodo de los Estados Unidos (BN1). ¿Como debe proceder ahora? Una vez encontrada la solución, el nodo BN1 difunde la solución propuesta al resto de los nodos de la red. El resto de los nodos de la red deben verificar la solución propuesta por el nodo BN1. Para ello cada nodo de la red debe realizar 3 comprobaciones:

1. Verificar que el Nonce propuesto realmente resuelve el reto matemático
2. Verificar la firma digital del emisor de cada transacción
3. Verificar que el emisor de cada transacción tenga saldo positivo suficiente para hacer la transferencia

Para el primer bloque Block_0 solo tienen sentido la comprobacion 1). Las comprobaciones 2) y 3) no tienen sentido para el Block_0 al no existir transacciones de wallet en ese primer bloque. Una vez que los nodos han verificado que el campo Nonce propuesto resuelve el reto matemático, el resto de los nodos de la red aceptan al ganador y detienen su intento de encontrar la solución para este bloque. Y depositan en el nodo ganador BN1 toda su confianza para que sea él el encargado de añadir ese nuevo bloque Block_0 a la blockchain. El nodo BN1 inserta finalmente el bloque Block_0 en la blockchain, que pasará a ser el primer Bloque de nuestra cadena de bloques.

```
Block_0
```

El resto de los nodos sincronizan su blockchain con la blockchain almacenada en el nodo ganador (BN1), añadiendo el bloque Block_0, y eliminando de sus respectivos mempools todas las transacciones contenidas en ese bloque (inicialmente ninguna). Si algún nodo esta apagado en este momento, cuando se encienda lo primero que hará el software es resincronizar la blockchain, con lo que añadirá este Block_0 y todos los añadidos posteriormente hasta el instante en el que se encienda el nodo.

El proceso de minado para calcular el Nonce se repite cada 10 minutos. A los 10 minutos nuestros 5 Nodos de Bitcoin crean el bloque Block_1 en el que incluyen las transacciones mas prioritarias que haya en sus respectivos mempool en ese momento. Una vez calculado el Nonce del Block_1 por el nodo ruso BN2, el proceso se repite. El nodo BN2 difunde la solución propuesta al resto de los nodos de la red. El resto de los nodos verifican la solución propuesta. Verifican 1) que el Nonce propuesto resuelve el reto matemático, 2) que la firma digital del emisor de cada transacción es valida y 3) que el wallet de cada emisor tiene saldo positivo suficiente para hacer la transferencia. Por ejemplo, para la transacción TX_05, la comprobacion 3) supone que los nodos verifiquen que el wallet emisor WL2 tiene al menos 4.0 BTC en su wallet en ese monento.

Hechas las comprobaciones oportunas, el resto de los nodos de la red aceptan al ganador y detienen su intento de encontrar la solución para este Block_1. Depositan en el nodo ganador BN2 la confianza para que inserte el nuevo bloque Block_1 en la blockchain. Finalmente el nodo BN2 se encarga de insertar el bloque Block_1 en la blockchain, que pasará a ser el segundo Bloque de nuestra cadena de bloques:

```
+---------+      +---------+
| Block_0 | <--- | Block_1 |
+---------+      +---------+
```

El resto de los nodos sincronizan su blockchain con la blockchain almacenada en el nodo ganador (BN2), añadiendo el bloque Block_1, y eliminando de sus respectivos mempools todas las transacciones contenidas en ese bloque. De nuevo, si algún nodo esta apagado en este momento, cuando se encienda lo primero que hará el software es resincronizar la blockchain, con lo que añadirá este Block_1 y todos los añadidos posteriormente hasta el instante en el que se encienda el nodo.

A partir del momento en el que el bloque Block_1 se inserta en la blockchain, el conjunto de transacciones que se han añadido en ese bloque pasan del estado validado al estado verificado. Las transacciones utilizadas en el ejemplo TX_01, TX_02, ..., TX_09 finalmente se convierten en transacciones verificadas, que ya están disponibles en la blockchain. A partir de este momento, sus respectivos receptores pasan a ser los legítimos propietarios de los Bitcoin transferidos en cada transacción.

Fíjate como el funcionamiento de la blockchain se asemeja mucho al funcionamiento de cualquier banco. Si intento hacer una transferencia desde mi banco por un importe superior al saldo que tengo en mi cuenta, el banco no me va a dejar. Blockchain tampoco. Sin embargo, estamos operando como un banco con total independencia de cualquier empresa, de cualquier estado o de cualquier persona.

Con el tiempo se irán creando y añadiendo nuevos bloques a la blockchain. El Block_3 se encadenará con el Block_2. El Block_4 con el Block_3. Y así sucesivamente:

```
+---------+      +---------+      +---------+      +---------+      +---------+
| Block_0 | <--- | Block_1 | <--- | Block_2 | <--- | Block_3 | <--- | Block_4 |
+---------+      +---------+      +---------+      +---------+      +---------+
```

Como vemos, los bloques se irán encadenando siguiendo la secuencia temporal en la que son creados.

La gran innovación es que hemos sido capaces de construir un sistema totalmente descentralizado, donde existe una única versión de la verdad. Donde podemos determinar con total seguridad y garantizado criptográficamente, cual es el saldo de cada usuario, sin que haya ni un solo nodo que sea fundamental para el funcionamiento del sistema. Los nodos pueden caer, se pueden cambiar, pueden aparecer nuevos, nadie puede censurar a nadie, ni hay ninguno que sea arbitro. Entre todos ellos se coordinan.

### Acciones con la blockchain

La blockchain nos permite hacer muchas acciones:

1. Nos permite reconstruir toda la lista de transacciones validas que se han producido a lo largo y ancho de la historia de Bitcoin, ordenadas por tiempo.
2. Nos permite regenerar el saldo de cada wallet en un momento dado. El wallet WL1 tiene 20.0 BTC puesto que ha recibido 50.0 BTC, ha enviado 9.0 BTC, ha enviado 6.0 BTC, ha enviado 8.0 BTC y ha enviado 7.0 BTC. Podemos hacer lo mismo con el resto de los wallet:

```
WL1: 50.0 - 9.0 - 6.0 - 8.0 - 7.0 = 20.0 BTC
WL2: 50.0 + 9.0 - 4.0 + 6.0       = 61.0 BTC
WL3:  6.0 + 4.0 - 2.0 + 1.0       =  9.0 BTC
WL4:  8.0 + 2.0 - 4.0 - 6.0       =  0.0 BTC
WL5:  7.0 + 4.0 - 1.0             = 10.0 BTC
```

3. Nos permite conocer con toda precisión cuánto Bitcoin hay en circulación en un momento dado. Algo que es impensable con las monedas tradicionales como el Euro. En este caso en concreto tenemos 20.0 BTC en el wallet WL1, 61.0 BTC en el wallet WL2, 9.0 BTC en el wallet WL3, 0.0 BTC en el wallet WL4 (menudo derrochador!) y 10.0 BTC en el wallet WL5. Si sumamos el saldo de todos los wallets, en nuestra cadena de bloques hay ahora mismo un total de 100.0 BTC en circulación. Que como vemos, coincide con los 100.0 BTC que el wallet COINBASE ha puesto en circulación (50.0 BTC en el Block_0 y 50.0 BTC en el Block_1).

La base de datos blockchain es de dominio publico. Cualquiera puede consultar su contenido. Existen varias maneras de consultar la blockchain, pero la mas cómoda y sencilla consiste en utilizar algún servicio web como el que provee [blockchain.com](https://www.blockchain.com/). Por ejemplo, podemos consultar el saldo en Bitcoins que tiene asociado cualquier wallet en un momento dado. Vamos a husmear el wallet WL1 = 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa. Para ello haz click en [este enlace](https://www.blockchain.com/btc/address/1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa)

El wallet que acabas de consultar no es un wallet cualquiera. Es un wallet muy especial, puesto que se trata del primer wallet que se creó en la historia de Bitcoin. Como veras, ahora mismo hay 72.74 BTC asociados a ese wallet. Lo que al cambio actual equivale a la nada despreciable cantidad de 2.9 millones de euros.

Hemos dicho que cualquier puede generar un wallet de Bitcoin en su propio ordenador. De hecho, puede crear miles en un momento. Sin embargo, para que un wallet aparezca en la blockchain, es necesario que otro wallet con saldo positivo le haya enviado previamente una cantidad de Bitcoins mayor que 0.0 en una transacción. Dicho de otro modo, para que un wallet exista en la blockchain, debe haber sido receptor de alguna transacción con saldo positivo. Por tanto, los wallets que nunca han recibido Bitcoins en una transacción no aparecen en la blockchain. Es como si no existieran.

### Aspectos clave en la seguridad de la blockchain

Tenemos una base de datos replicada en muchos Nodos de Bitcoin. La pregunta es casi inmediata: ¿como es posible que una base de datos pueda ser segura, si está almacenada en el ordenador de cualquier persona? ¿Como evita la blockchain que un hacker ruso experimentado pueda manipular el contenido de un bloque?. ¿Sería posible crear un wallet WTF y reemplazar el destinatario de alguna transacción?. ¿Quien se daría cuenta?. Para dar respuesta a todas estas preguntas, vamos a repasar los campos que dotan de seguridad a los bloques de la blockchain. Para ello analizaremos un posible ataque a la seguridad de la blockchain realizado por un hacker ruso:

```
    Block_0                     Block_1                     Block_2                             Block_665000
    +------------------+        +------------------+        +------------------+                +------------------+
    | Block Header     |        | Block Header     |        | Block Header     |                | Block Header     |
    | - Version        |        | - Version        |        | - Version        |                | - Version        |
    | - Previous Hash  |        | - Previous Hash  |        | - Previous Hash  |                | - Previous Hash  |
    | - Merkle root    |        | - Merkle root    |        | - Merkle root    |                | - Merkle root    |
    | - Timestamp      |        | - Timestamp      |        | - Timestamp      |                | - Timestamp      |
    | - Difficulty     |  <---  | - Difficulty     |  <---  | - Difficulty     |  <--- ... <--- | - Difficulty     |
    | - Nonce          |        | - Nonce          |        | - Nonce          |                | - Nonce          |
    +------------------+        +------------------+        +------------------+                +------------------+
    | Transaction List |        | Transaction List |        | Transaction List |                | Transaction List |
    | - TX_1           |        | - TX_1           |        | - TX_1           |                | - TX_1           |
    |                  |        | - TX_2           |        | - TX_2           |                | - TX_2           |
    |                  |        | - TX_x           |        | - TX_y           |                | - TX_z           |
    +------------------+        +------------------+        +------------------+                +------------------+
```

El campo (2.3) Merkle Root de un bloque es una huella digital derivada de las huellas digitales de todas y cada una de las transacciones incluidas en ese bloque. En definitiva, es la huella digital del grupo (4) Transaction List. Por tanto, este campo asegura la integridad de todas las transacciones del bloque.

Tenemos un hacker ruso obstinado, intentando hackear la blockchain. El hacker quiere cambiar el destinatario de alguna transacción, sustituyendo el wallet de algún legítimo destinatario por su propio wallet WTF. Al cambiar un solo bit de una transacción, debe recalcular el campo (2.3) Merkle Root. Lo cual es factible, ya que hacer un hash SHA-256 de todas las transacciones tiene un coste computacional muy bajo. El hacker ruso está un paso mas cerca de hackear la blockchain.

Sin embargo, al cambiar el campo Merkle Root acaba de modificar el hash SHA-256 del grupo (2) Block Header. Eso significa que acaba de romper la propiedad del campo Nonce, que exige que el hash SHA-256 del grupo (2) Block Header cumpla con un numero de ceros determinado por el campo (2.5) Difficulty.

El hacker ruso sabe lo que hace. Y decide modificar el campo (2.5) Difficulty a un valor ridículamente bajo (1), y recalcular el campo Nonce para que el hash SHA-256 del bloque tenga un solo cero. Algo que tiene un coste computacional muy bajo y que da como resultado un Nonce que cumple la condición requerida por el campo Difficulty de valor 1.

El hacker ruso tiene a la blockchain contra las cuerdas. Mmm... ¿Estas seguro? En realidad la blockchain nunca estuvo en peligro. Haz un poco de memoria. ¿Recuerdas cuando hablamos del campo DiSign de las transacciones? Cada transacción dentro del bloque está firmada digitalmente por el Emisor. Lo cual significa que cualquier cambio en una transacción sería inmediatamente detectado por los Nodos de la red cuando verifiquen las transacciones del bloque. Por tanto, el intento del hackeo quedaría detectado y eliminado por los propios Nodos de la red Bitcoin.

Por si alguien se pasa de listo, entra en juego el campo (2.2) Previous Hash. Este campo almacena el hash SHA-256 de la cabecera del bloque anterior, es decir, del bloque generado previamente en el orden temporal. Por tanto, el campo Previous Hash del Block_1 almacena el hash SHA-256 de la cabecera del Bloque_0. El campo Previous Hash del Block_2 almacena el hash SHA-256 de la cabecera del Bloque_1. Y así sucesivamente con el resto de los bloques de la blockchain. Si alguien intentara manipular la cabecera de un bloque, provocaría un efecto de avalancha sobre el resto de los bloques de la blockchain.

 El hacker ruso no se rinde y decide que va a recalcular las cabeceras de todos los bloques. ¿Cuantos bloques crees que tiene la blockchain? Un bloque nuevo cada 10 minutos durante 12 años... [Aquí](https://blockchain.info/q/getblockcount) puedes consultar el numero exacto de bloques de la blockchain. Actualmente tenemos unos 823250 bloques. ¿De verdad crees que el hacker ruso será capaz de re-calcular el Nonce de uno solo de esos bloques en menos de 1 segundo?. Como ves, esta característica de tener los bloques linkados mediante huellas digitales proporciona a la Blockchain una seguridad y una resistencia a la manipulación extremadamente elevada.

## Cierre del post

Esta historia comenzó con un post publicado por Satoshi Nakamoto el Viernes 09 de Enero de 2009 a las 17:05:49 y que podéis leer íntegramente pulsando [aquí](https://www.mail-archive.com/cryptography@metzdowd.com/msg10142.html)

Satoshi Nakamoto es el seudónimo utilizado por el creador de Bitcoin, quien hoy en día sigue sin desvelar su identidad. Tras este seudónimo no sabemos si se esconde un hombre, una mujer, o un grupo de activistas. Nadie lo sabe. Existen muchas teorías conspiranoicas al respecto de este asunto. Nakamoto en japonés significa "origen central", mientras que "Satoshi" en ese mismo idioma significa "inteligencia". En ese contexto, el nombre traducido podría corresponder al término "Inteligencia Central", lo cual lo sitúa en el entorno de la Agencia Central de Inteligencia de los Estados Unidos (la CIA). Algunas teorías sugieren que a los bancos todopoderosos no les hace mucha gracia esto del Bitcoin porque pone en riesgo a su negocio. Por lo que su vida podría correr peligro. Incluso hay gente que afirma que ya podría estar muerto. Otros creen que Satoshi habría acumulado una gran cantidad de Bitcoin durante la fase inicial del proyecto y que al precio actual, eso le situaría entre las personas mas ricas del planeta. Lo cual le obligaría a tributar una cantidad ingente de impuestos. Otros muchos, entre los cuales me incluyo, opinan que Bitcoin está demasiado bien diseñado para que todo esto lo planteara una sola persona. Por lo que podría tratarse del seudónimo utilizado por algún grupo de activistas. Lo único cierto que se sabe es que su última aparición pública fue el 12 de Diciembre de 2010 en una discusión técnica en el foro BitcoinTalk en la que se debatían alternativas para defenderse de posibles ataques por denegación de servicio (DoS).

La primera persona en contestar a ese post fue Harold Thomas Finney. Harold fue un notable activista criptográfico, participante regular en los foros de cypherpunk, pionero en el Bitcoin al tratarse de la persona que recibió la primera transacción de la red, la transacción del bloque genesis. Tras ser diagnosticado de Esclerosis Lateral Amiotrófica (ELA), durante 5 años sufrió un deterioro progresivo de su salud hasta su fallecimiento a la edad de 58 años, el 28 de Agosto de 2014. Harold decidió invertir su fortuna en Bitcoin en su futuro, y tras su fallecimiento su cuerpo fue criopreservado a la temperatura de -196 ºC, disminuyendo sus funciones vitales para preservar su organismo en condiciones de vida suspendida por mucho tiempo, hasta que la ciencia sea capaz de llevar a cabo una reparación y reactivación celular.

Harold hacía esta reflexión sobre Bitcoin el día 11 de Enero de 2009, apenas unos pocos días después del arranque del proyecto: *"As an amusing thought experiment, imagine that Bitcoin is successful and becomes the dominant payment system in use throughout the world. Then the total value of the currency should be equal to the total value of all the wealth in the world. Current estimates of total worldwide household wealth that I have found range from $100 trillion to $300 trillion. With 20 million coins, that gives each coin a value of about $10 million. So the possibility of generating coins today with a few cents of compute time may be quite a good bet, with a payoff of something like 100 million to 1! Even if the odds of Bitcoin succeeding to this degree are slim, are they really 100 million to one against? Something to think about..."*.

Pulso la tecla ESC, dos puntos wq!












Hablar sobre mercados de criptomonedas, como podemos convertirlas en euros o en otras criptomonedas. 


















Para modificar un bloque en el pasado, un atacante tendría que rehacer la prueba-de-trabajo del bloque y de todos los bloques después y luego alcanzar y pasar el trabajo de los nodos honestos. Luego demostraremos que la probabilidad de un atacante más lento de alcanzar disminuye exponencialmente a medida que bloques subsecuentes son añadidos






Los pasos para gestionar la red son como sigue:
1) Transacciones nuevas son emitidas a todos los nodos.
2) Cada nodo recolecta nuevas transacciones en un bloque.
3) Cada nodo trabaja en encontrar una prueba-de-trabajo difícil para su bloque.
4) Cuando un nodo encuentra una prueba-de-trabajo, emite el bloque a todos los nodos.
5) Los nodos aceptan el bloque si todas las transacciones en el bloque son válidas y no se han
gastado ya.
6) Los nodos expresan su aceptación del bloque al trabajar en crear el próximo bloque en la
cadena, utilizando el hash del bloque aceptado como el hash previo.









Por convención, la primera transacción en el bloque es una transacción especial que comienza una moneda nueva cuyo dueño es el creador del bloque. Esto agrega un incentivo para que los nodos apoyen a la red, y provee una forma inicial de distribuir monedas en circulación, dado que no hay una autoridad para crearlas. Esta adición estable de una cantidad constante de monedas nuevas es análoga a mineros de oro gastando recursos para agregar oro a la circulación. En nuestro caso, es el tiempo del CPU y la electricidad que se gasta.

El incentivo también puede ser fundado con costos de transacción. Si el valor de salida de una transacción es menor que la entrada, la diferencia es una tarifa de transacción que se le añade al valor de incentivo del bloque que contiene la transacción. Una vez que un número predeterminado de monedas han entrado en circulación, el incentivo puede transicionar enteramente a tarifas de transacción y ser completamente libre de inflación.















----------

¿Cómo se protegen las criptomonedas de estos ataques de doble gasto?

Bitcoin y otras criptomonedas operan bajo la tecnología blockchain, que posee dos mecanismos para evitar los ataques fraudulentos de doble gasto. Primero, se realiza una validación y registro de todas las transacciones realizadas. En el caso de Bitcoin, es un registro abierto, verificable y auditable. En segundo lugar, se realiza una verificación para comprobar la autenticidad de cada operación mediante la aplicación de un instrumento conocido como Prueba de Trabajo (PoW).

Cada registro añadido a la blockchain mantiene un orden consecutivo y ascendente, y cada bloque añadido es vinculado mediante técnicas criptográficas con el bloque anterior. Con lo que se garantiza una inalterabilidad de los datos y, por tanto, de la red. Este mecanismo también permite confirmar las transacciones realizadas, y una vez esto ocurre, mientras mayor número de confirmaciones posee una operación, será prácticamente imposible duplicarla o falsificarla.

De la misma manera, cada vez que la red crece y más nodos se incorporan a ésta, se vuelve más robusta y el proceso de minado se complica muchísimo más. Por lo que se requiere de mayor poder computacional para poder llevar a cabo uno de estos ataques con éxito. Y esto implicaría un enorme gasto energético que lo hace poco atractivo.

Es importante mencionar que la red Bitcoin es particularmente propensa a sufrir un ataque de doble gasto en el momento que se realizan las transacciones y éstas poseen 0 confirmaciones. Por lo que siempre es recomendable la espera de al menos 6 confirmaciones de la red para dar por realizada una transacción, sin correr el riesgo de que ésta será revertida.




