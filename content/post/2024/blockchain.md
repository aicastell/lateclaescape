---
title: La blockchain de Bitcoin
date: 2024-09-14
image: "/img/posts/blockchain.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "blockchain"]
draft: false
featured: true
---

# Introducción

Hace unos meses expliqué como la [banca tradicional](/post/2024/banca-tradicional/) opera con una base de datos centralizada que almacena todas las cuentas bancarias de sus clientes con sus respectivos saldos asociados.

En contraste con la banca tradicional, Bitcoin no depende de una base de datos centralizada. En su lugar, utiliza una base de datos distribuída conocida como blockchain.

En este articulo desentraño los secretos de la blockchain de Bitcoin, una estructura de datos revolucionaria que está transformando industrias enteras.

# Nuevos bloques

En el último articulo publicado en este blog hablé sobre [bloques de transacciones](/post/2024/bitcoin-transaction-block/), que básicamente son contenedores de [transacciones de Bitcoin](/post/2024/bitcoin-transaction/).

El día 3 de Enero de 2009 se creó el primer bloque de transacciones de Bitcoin. Desde entonces y hasta hoy, se han creado muchos bloques de transacciones. En concreto, [aquí](https://blockchain.info/q/getblockcount) puedes consultar el numero exacto de bloques creados desde el nacimiento de Bitcoin. El último bloque disponible en el momento de escribir estas palabras es el bloque 861523.

Se sigue creando un bloque nuevo de transacciones aproximadamente cada 10 minutos.

# La blockchain

De manera natural, tras los bloques de transacciones, surge el concepto de **blockchain**. Traducido al español, cadena de bloques. No hace falta ser un genio para imaginar que debe parecerse mucho a una secuencia de bloques de transacciones encadenados.

La primera pregunta es obvia, ¿como se encadenan esos bloques de transacciones de Bitcoin?.

En el articulo sobre [bloques de transacciones](/post/2024/bitcoin-transaction-block/) hablé de un campo de la cabecera llamado *Previous Hash*, que es la huella digital de la cabecera del bloque de transacciones generado previamente en el orden temporal.

Ese campo *Previous Hash* es precisamente el nexo que une el bloque actual con el bloque anterior. Si unes todos los bloques, desde el último generado hasta el primero, a través de sus campos *Previous Hash*, obtendrás una secuencia de bloques de transacciones encadenados, es decir, una **blockchain**.

Este ejemplo debería ayudarte a visualizar una blockchain a nivel conceptual:

```
     Block_57                  Block_58                  Block_59
     +------------------+      +------------------+      +------------------+
     | Header           |      | Header           |      | Header           |
     | - Version        |      | - Version        |      | - Version        |
<----| - Previous Hash  | <----| - Previous Hash  | <----| - Previous Hash  | <----
     | - Merkle root    |      | - Merkle root    |      | - Merkle root    |
     | - Timestamp      |      | - Timestamp      |      | - Timestamp      |
     | - Difficulty     |      | - Difficulty     |      | - Difficulty     |
     | - Nonce          |      | - Nonce          |      | - Nonce          |
     +------------------+      +------------------+      +------------------+
     | TX_Counter: x    |      | TX_Counter: y    |      | TX_Cointer: z    |
     | TX_List          |      | TX_List          |      | TX_List          |
     | - TX_Coinbase    |      | - TX_Coinbase    |      | - TX_Coinbase    |
     | - TX_2           |      | - TX_666         |      | - TX_2           |
     | - TX_x           |      | - TX_y           |      | - TX_z           |
     +------------------+      +------------------+      +------------------+
```

Observa como el bloque 58 está encadenado entre los bloques 57 y 59. Nuestra transacción TX_666 está insertada dentro del bloque numero 58.

## Libro mayor contable

La blockchain implementa un mecanismo similar a un libro contable mayor. En la blockchain tienes almacenadas, bloque a bloque, un historial ordenado cronológicamente de todas y cada una de las transacciones verificadas que han ocurrido en la historia de Bitcoin desde el día de su nacimiento.

Dada una [dirección de Bitcoin](/post/2024/bitcoin-address/), puedes recorrer todos los bloques de la blockchain en busca de aquellas transacciones donde aparezca dicha dirección de Bitcoin. Sumando los saldos recibidos y restando los saldos enviados, tienes el saldo total que tiene la dirección de Bitcoin dada.

Obviamente, recorrer a mano 860.000 bloques es inviable. Pero para eso esta el software del nodo de Bitcoin, que es capaz de hacer esta operación en apenas unos milisegundos.

¿Te ha explotado la cabeza? Bienvenido al mundo del conocimiento.

## Base de datos

La blockchain es una base de datos distribuida e inmutable.

### DB distribuida

La blockchain es una base de datos distribuida porque no existe ningún nodo en la red con funciones especiales.

Por tanto, todos los nodos de la red actúan como pares iguales, almacenando una copia idéntica de la blockchain. Esa copia es exactamente la misma copia en todos los nodos de la red, y se mantiene continuamente sincronizada.

La blockchain de todos los nodos se actualiza cada vez que se inserta un nuevo bloque. El proceso de inserción de un nuevo bloque de transacciones en la blockchain merece un articulo específico del que hablaremos próximamente.

Gracias a este sistema distribuido, la blockchain es resistente a fallos, ya que la red no depende de un solo nodo para su funcionamiento.

Si uno o varios nodos se reinician, fallan, o se apagan por cualquier motivo (fallos de la compañia electrica, censuras gubernamentales, etc), los demás nodos de la red mundial siguen garantizando su correcto funcionamiento.

### DB inmutable

La blockchain es una base de datos inmutable porque una vez que un bloque de transacciones ha sido añadido a la cadena, no puede ser modificado.

Si un nodo malicioso intenta modificar la información de la blockchain que almacena, el resto de los nodos se enteran rápidamente de esa modificación e invalidan su copia. Esto garantiza que los datos almacenados en la blockchain son permanentes y verificables por cualquier persona en la red.

## Transparencia

La blockchain es inherentemente transparente. No hay secretos. Todos los datos son públicos. Cualquier persona puede consultar el contenido de la blockchain, lo que la convierte en una herramienta ideal para aplicaciones que requieren confianza y verificabilidad, como registros financieros o acuerdos legales. Si montas un nodo de Bitcoin en tu casa, tu nodo recibirá exactamente la misma copia de la blockchain que gestionan el resto de los nodos en la red.

## Seguridad

Puesto que cada bloque de transacciones contiene en el campo *Previous_Hash* una huella digital del bloque anterior, los bloques están criptográficamente encadenados.

Esta estructura de datos criptográficamente encadenados es extremadamente segura. Manipular un solo bit de información en cualquiera de los 860.000 bloques sería detectado de inmediato, ya que rompería la huella digital del bloque modificado, pero también rompería las huellas digitales de todos los bloques posteriores de la blockchain, debido precisamente al encadenamiento a través del campo *Previous_Hash*.

## Despedida

La blockchain es una tecnología revolucionaria que ha cambiado la forma de almacenar y verificar información en una red distribuida.

Aunque su primera utilidad ha sido con las criptomonedas, sus aplicaciones prácticas van mucho mas allá. Puede abarcar otros muchos sectores como la logística, los contratos inteligentes y la verificación de identidades. Este blog pretende abordar todos estos asuntos en el futuro.

En el próximo articulo voy a a analizar un intento de hackear la blockchain de Bitcoin, para que asimiles perfectamente por qué es tan segura esta estructura de datos.

Dudas, sugerencias, comentarios, o cualquier otra cuestión, podéis poneros en contacto conmigo a través del [canal de Telegram](https://t.me/lateclaescape), donde estoy encantado de leeros y contestar a vuestras cuestiones.

Muchas gracias por leerme, y nos vemos en el próximo articulo

Pulso la tecla ESC, dos puntos wq!
