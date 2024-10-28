---
title: Bloques de transacción
date: 2024-09-06
image: "/img/posts/bitcoin-transaction-block.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "bloque de transacciones", "mempool" ]
draft: false
featured: true
---

# Motivación

En un articulo reciente sobre [transacciones de Bitcoin](/posts/bitcoin-transaction/) has asistido al nacimiento de la transacción TX_666 en directo.

Después dediqué un articulo a la [gestión de transacciones](/posts/bitcoin-transaction-management/), la primera responsabilidad de los [nodos de Bitcoin](/posts/bitcoin-nodes/), donde he explicado como un nodo de la [red de Bitcoin](/posts/bitcoin-nodes-network) recibe la transacción TX_666, la verifica y la propaga al resto de los nodos de la red.

En este articulo incorporo un nuevo concepto: los bloques de transacciones.

Voy a centrarme en describir que es un bloque de transacciones y cual es su estructura interna. Dejaré todo lo que esté relacionado con su utilidad para los próximos artículos de este blog.

Este articulo da continuidad al viaje de la transacción TX_666. No ha terminado y no finalizará hasta que el receptor tenga 3.0 BTC en la dirección de Bitcoin receptora y al emisor solamente le queden 7.0 BTC en la dirección de Bitcoin emisora.

## Los bloques de transacciones

Un **bloque de transacciones** es un objeto contenedor que como su nombre indica, agrupa a un conjunto de transacciones en su interior.

En un articulo anterior te dije que la segunda responsabilidad de [los nodos de Bitcoin](/posts/bitcoin-nodes/) era gestionar los bloques de transacciones. Pues bien, la creación de estos bloques de transacciones recae precisamente sobre los nodos de Bitcoin.

Los bloques de transacciones se crean aproximadamente cada 10 minutos. El por qué y el cómo son preguntas que responderé en capítulos posteriores.

En un bloque de transacciones solo se insertan transacciones que han sido previamente verificadas. Por tanto, las transacciones que se insertan en el bloque se extraen directamente del mempool del nodo que crea el bloque.

El tamaño del bloque de transacciones está limitado a 1 MB. Dado que cada transacción ocupa en promedio unos 350 bytes, en la práctica, se pueden incluir aproximadamente unas 3000 transacciones por bloque.

Si en la mempool del nodo hay pocas transacciones (menos de 3000), todas las transacciones encoladas en la mempool se insertan dentro del bloque de transacciones.

Si en la mempool del nodo hay muchas transacciones (muchas mas de 3000), solo algunas transacciones de la mempool caben dentro del bloque debido a su limitación de tamaño. En este caso, se priorizan las transacciones con mayor prioridad, es decir, aquellas con una comisión *Fee* mas elevada. Las transacciones que no son incluidas en el bloque de transacciones se mantienen en la mempool, esperando ser incluidas en el siguiente bloque.

## Estructura interna

Cada bloque de transacciones tiene una estructura interna formada por dos campos:

- Cabecera
- Cuerpo

Veamos cada componente por separado:

### Cabecera del bloque

La cabecera del bloque (Header) contiene información esencial para la identificación y la validación del bloque. Tiene un tamaño total de 80 bytes en los que se almacenan los siguientes campos:

- Version (4 bytes)
- Previous Hash (32 bytes)
- Merkle root (32 bytes)
- Timestamp (4 bytes)
- Difficulty (4 bytes)
- Nonce (4 bytes)

El campo *Version* identifica la versión del software con la que se ha generado este bloque. Se utiliza para saber que versión del software debe encargarse de interpretarlo. Es útil en caso de cambios a futuro que modifiquen algún campo.

El campo *Previous Hash* es la huella digital de la cabecera del bloque de transacciones generado previamente en el orden temporal. Esta muy relacionado con el concepto de *blockchain*, sobre el que hablaremos en el próximo articulo.

El campo *Merkle Root* es una huella digital derivada de las huellas digitales de todas y cada una de las transacciones incluidas en este bloque.

El campo *Timestamp* codifica los segundos transcurridos desde el 1 de Enero de 1970 y se actualiza cada segundo hasta el instante exacto en el que se calcula el valor correcto para el campo *Nonce*. Puesto que este campo *Timestamp* de la cabecera varía cada segundo, la huella digital de la cabecera también varía cada segundo. Por tanto, se dispone de un segundo como máximo para calcular el campo *Nonce* correcto, antes de que cambie el *Timestamp*.

El campo *Difficulty* es un número que codifica la dificultad para calcular el campo *Nonce*. Variar este dato permite controlar la dificultad del cálculo del campo *Nonce*. Cuanto mas alto sea el valor *Difficulty*, mas difícil será calcular el *Nonce*. Por contra, cuanto mas bajo sea el valor *Difficulty*, mas fácil será calcular el *Nonce*. El campo *Difficulty* se actualiza cada 2016 bloques de transacciones nuevos (aproximadamente cada dos semanas).

El campo *Nonce* es un valor random que debe ser calculado de tal manera que, una vez se añade a la cabecera, la huella digital SHA-256 de toda la cabecera del bloque genere un hash que tenga los Z = *Difficulty* primeros bits a valor cero '0'. El valor de Z viene determinado por el campo *Difficulty* de la cabecera del bloque. Calcular el campo *Nonce* tiene un altísimo coste computacional que puede ajustarse dinámicamente, variando el campo *Difficulty* según las necesidades de cada momento temporal.

Entenderás perfectamente la utilidad de los campos *Difficulty* y *Nonce* en el articulo donde hablo específicamente sobre la [minería de Bitcoin](/posts/bitcoin-consensus-mechanism/).

### Cuerpo del bloque

El cuerpo del bloque (Body) almacena el conjunto de transacciones verificadas. Su tamaño máximo es de 1MB, pero el tamaño real varía dependiendo del numero de transacciones que contenga. Internamente tiene dos campos:

- TX_Counter (2 bytes)
- TX_List (variable)

El campo *TX_Counter* indica el numero de transacciones que almacena este bloque. Su valor que puede variar entre 1 (que es el número mínimo de transacciones en un bloque) y el máximo del rango (con 2 bytes tenemos un máximo teórico de 65535 transacciones).

El campo *TX_List* es el elemento mas grande del bloque de transacciones. Contiene la lista de todas las transacciones almacenadas en este bloque. Recuerda, transacciones que han sido extraídas de la mempool del nodo que ha creado el bloque.

La primera transacción en la lista *TX_List* de cada bloque siempre es una transacción especial que se conoce como transacción *Coinbase* (TX_Coinbase). Hablaremos sobre ella mas adelante cuando abordemos el tema de las [recompensas de Bitcoin](/posts/bitcoin-rewards).

## Ejemplo de bloque de transacciones

De nuevo voy a utilizar JavaScript Object Notation (JSON), para representar un bloque de transacciones que utilizaremos como ejemplo. Voy a analizar este bloque contigo para que quede todo un poco mas claro.

```
Block_58: {
    Header: {
              Version: "1",
        Previous_Hash: "0x000000009b6654d7d89d2b72638cdd20e593550a2d495e5b9eb0ff3c37504c60",
          Merkle_Root: "0x9635054e3de101ea39dcfa5f4cec63ceb1205db6e0a99304c8db2b3a162137e4",
            Timestamp: "1231906257",
           Difficulty: "32",
                Nonce: "0x12182F1E"
    },
    Body: {
           TX_Counter: 1549,
              TX_List: [ TX_Coinbase, TX_2, TX_3, ..., TX_666, ..., TX_1549 ]
    }
}
```

El objeto JSON Block_58 representa al bloque de transacciones número 58 de Bitcoin.

Este bloque utiliza el campo *Version* con valor "1", lo que indica que es uno de los primeros bloques creados en la historia de Bitcoin.

La fecha exacta de su creación en Unix *Timestamp* es 1231906257. Este valor representa los segundos transcurridos desde el 1 de Enero de 1970. [Convertido a formato fecha](https://www.epochconverter.com/), nos da el Miércoles 14 de enero de 2009 a las 5:10:57

El campo *Previous_Hash* indica la huella digital SHA-256 de la cabecera del bloque de transacciones número 57 (el anterior).

```
SHA-256(Block_57(Header)) =  0x000000009b6654d7d89d2b72638cdd20e593550a2d495e5b9eb0ff3c37504c60
```

El campo *Nonce* con valor 0x12182F1E indica que al calcular la huella digital SHA-256 de la cabecera que incluya este *Nonce*, se genera un hash que tiene los *Difficulty* (32) primeros bits a valor '0'. Veamos si esto se cumple. Para ello calculo la huella digital SHA-256 de la cabecera del bloque número 58:

```
SHA-256(Block_58(Header)) =  0x0000000075b4df54f33c4e60cf88c5dd6a6455f16f4fbe220ae81e157ce32ef1
```

Si contamos ceros del hash por la izquierda, veremos que tenemos 8 dígitos hexadecimales a la izquierda con valor cero (0x0000000075...). Es decir, 32 bits a valor cero. Por tanto, podemos decir que si, se cumple la condición.

El campo *TX_Counter* con valor 1549 en el cuerpo del bloque indica que tenemos 1549 transacciones verificadas pero pendientes de confirmar.

En el campo *TX_List* del cuerpo del bloque tenemos la lista de las 1549 transacciones. Parece que nuestra transacción TX_666 ha sido una de las elegidas para insertarse en este bloque. Su viaje continúa, pero no, todavía no termina aquí.

El campo *Merkle_Root* de la cabecera indica la huella digital de todas las transacciones incluidas en *TX_List*. Es decir:

```
SHA-256(Block_58(TX_List) = 0x9635054e3de101ea39dcfa5f4cec63ceb1205db6e0a99304c8db2b3a162137e4
```

## Despedida

Los bloques de transacciones son mucho mas que un simple contenedor. Son la columna vertebral de la red Bitcoin. Cada elemento del bloque, desde la cabecera hasta el cuerpo, cumple una función vital que contribuye a la seguridad y robustez del sistema.

Desgranar la estructura interna de un bloque de transacciones de Bitcoin ha sido algo fascinante que muestra los detalles internos de la tecnología que ha logrado asegurar la integridad y la transparencia de una red financiera descentralizada.

En próximos artículos y a medida que avances en el estudio de Bitcoin, iré aclarando ciertos conceptos que revelan la elegancia y la complejidad de este sistema financiero revolucionario.

Me gusta que termines los articulo sin quedarte con dudas. Te animo a preguntar cualquier cuestión que no haya quedado suficientemente clara por el [canal de Telegram](https://t.me/lateclaescape) donde estoy atento a sugerencias, dudas, criticas y cualquier otro comentario.

Gracias por leerme y, ¡nos vemos en el próximo articulo!.

Pulso la tecla ESC, dos puntos wq!

