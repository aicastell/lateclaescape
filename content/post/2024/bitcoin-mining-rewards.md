---
title: El sistema de recompensas
date: 2024-09-27
image: "/img/posts/mining-rewards.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "mining rig", "full node", "pow"]
draft: true
featured: true
---

# Introducción

Los [nodos de Bitcoin](/posts/bitcoin-nodes/), con el tiempo, con el crecimiento de la red y con la complejidad de las operaciones, se han ido especializando para manejar mejor las distintas tareas requeridas.

Algunos nodos, conocidos como nodos completos o **full nodes**, se han especializado en almacenar la blockchain completa. Otros nodos, conocidos como **mining nodes**, **mining rigs**, o simplemente **mineros de Bitcoin**, se han especializado en la minería de Bitcoin.

Precisamente en este articulo voy a hablar sobre la minería de Bitcoin. Es un articulo que une todos los conceptos que hemos visto sobre Bitcoin.

## Recompensa de bloque

Operar un nodo minero que compita en la red de Bitcoin para intentar resolver el problema PoW antes que ningún otro nodo minero es costoso en terminos económicos. El nodo minero requiere una gran cantidad de recursos, tanto energéticos como computacionales. El propietario debe invertir en hardware especializado, cubrir los altos costos de la energía eléctrica que consume, y mantener el software actualizado. El sistema sería insostenible si no hubiera algun tipo de incentivo a cambio.

### Transacción Coinbase

La transacción Coinbase (TX_Coinbase) es una transacción especial y única en cada bloque de transacciones. La crea el nodo minero después de elegir de su mempool las transacciones que van a formar parte del nuevo bloque. A diferencia de las transacciones normales, la transacción Coinbase no tiene dirección de origen, y como dirección de destino se añade la dirección de Bitcoin del dueño del nodo minero.

El nodo minero acaba de preparar su propia recompensa si consigue minar este bloque antes que nadie. ¿Cual es la cantidad de Bitcoin transferida al nodo minero? ¿De donde salen esos Bitcoin?es la recompensa? Pero, de que cantidad de bitcoin estamos hablando?





la crea el nodo minero antes de empezar a minar su bloque.
tiene como objetivo recompensar al nodo minero si consigue minar su bloque. 


Cuando el nodo minero crea un nuevo bloque de transacciones, añade a la lista de transacciones una transacción especial que se conoce como transacción Coinbase (TX_Coinbase). Esta transacción no tiene dirección origen, tiene como dirección de destino la dirección de Bitcoin del propietario del nodo minero. La cantidad de Bitcoin a transferir en esa transacción es la suma de dos 



<F2>

mineros añaden al bloque de transacciones que acaban de crear una transacción especial llamada Coinbase (TX_Coinbase).




El nodo minero que propone un bloque minado que es aceptado por la red (y por tanto insertado en la blockchain) recibe una recompensa a cambio en forma de Bitcoin. Esta recompensa proviene de

Bitcoin incentiva a los nodos mineros para que sus propietarios mantengan sus nodos operativos. Hay dos tipos de recompensa en forma de Bitcoin para el nodo minero que consigue minar un bloque.

    Recompensa de bloque: Es la cantidad de bitcoins que un minero recibe cuando añade exitosamente un nuevo bloque a la blockchain. Esta recompensa incluye los nuevos bitcoins creados en ese bloque (inflación controlada) y las comisiones de las transacciones incluidas en el bloque.

- Transacción Coinbase
- Fees



Esta es la manera en la que el sistema pone nuevos Bitcoin en circulación. La dificultad se ajusta para minar un nuevo bloque cada 10 minutos. De esta manera, el sistema tiene extracción de bitcoin asegurada hasta 2170.

#### Transacción Coinbase


La **transacción Coinbase** (TX_Coinbase) es creada por cada nodo minero antes de empezar a minar el bloque. Es una transacción especial y única en cada bloque de Bitcoin, que tiene como objetivo recompensar al minero que consigue minar un bloque. A diferencia de las transacciones normales, la transacción Coinbase no tiene dirección de origen, solo tiene dirección de destino: el wallet del dueño del nodo minero. Esta es la manera en la que el sistema pone nuevos Bitcoin en circulación.

En los origenes de Bitcoin, esa recompensa empezó siendo de 50.0 BTC por bloque minado. Si, eso significa que por cada bloque minado, el minero que conseguía minarlo recibía a cambio 50.0 BTC. Se ponían 50 BTC nuevos en circulación cada 10 minutos. Los nuevos Bitcoin generados provienen del protocolo, que emite una cantidad fija de nuevos bitcoins en cada bloque. Este es un mecanismo de emisión controlada para garantizar que el suministro total de Bitcoin esté limitado a 21 millones.

Sin embargo, Bitcoin está diseñado para reducir esa recompensa a la mitad exactamente cada 210000 bloques, lo que ocurre aproximadamente cada cuatro años. Al evento que reduce esa recompensa a la mitad se le conoce como **Bitcoin Halving**. En la historia del Bitcoin ya hemos vivido 4 Halving. El último Halving ocurrió el pasado 19 de Abril de 2024. Actualmente la recompensa por bloque minado es de 3.1250 BTC. El próximo Halving se espera en 2028.

| Event             | Date          |  Block     |  Reward (BTC) |   BTC mined(%) |
|-------------------|---------------|------------|---------------|--------------- |
| Bitcoin origin    | 03/01/2009    |  0         |  50.0000      |   50.0%        |
| Halving 1         | 28/11/2012    |  210000    |  25.0000      |   75.0%        |
| Halving 2         | 09/07/2016    |  420000    |  12.5000      |   87.5%        |
| Halving 3         | 11/05/2020    |  630000    |   6.2500      |   93.75%       |
| Halving 4         | 19/04/2024    |  840000    |   3.1250      |   96.875%      |
| Halving 5         | 2028          |  1050000   |   1.5625      |   98.4375%     |
| Halving 6         | 2032          |  1260000   |   0.78125     |   99.21875%    |

#### Fees

Además de la recompensa fija en BTC, la transacción coinbase también incluye las comisiones de las transacciones que el minero ha seleccionado de la mempool para incluir en el bloque. Las transacciones pagan una comisión a los mineros como incentivo adicional. Por tanto, el valor total que recibe un minero en la transacción coinbase es la suma de:

- La recompensa por bloque (por ejemplo, 6.25 BTC).
- Las comisiones de las transacciones incluidas en ese bloque.

La recompensa por bloque disminuye con el tiempo en eventos de halving.

Cada transacción que se incluye en el bloque paga una comisión a los mineros. Estas comisiones se suman a la recompensa de bloque para formar el pago total que recibe el minero a través de la coinbase.

Ejemplo:

Si un minero encuentra un bloque válido en el estado actual de la red (con una recompensa de 6.25 BTC), y las transacciones incluidas pagan comisiones por un total de 0.5 BTC, la transacción coinbase reflejará un total de 6.75 BTC como pago al minero.

En resumen:

La transacción coinbase es la forma en que los mineros reciben recompensas por su trabajo. Esta transacción genera nuevos bitcoins, y su valor está compuesto por la recompensa fija de bloque (que disminuye con el tiempo) y las comisiones de las transacciones que el minero incluye en el bloque. La coinbase transaction es la primera en cada bloque y no tiene inputs, ya que simplemente crea nuevos bitcoins según las reglas del protocolo.

Transacción coinbase: Es la primera transacción en un bloque nuevo. A diferencia de las demás transacciones, no tiene inputs previos (orígenes de fondos). La transacción coinbase es la forma en que los nuevos bitcoins entran en circulación, y representa la recompensa del bloque que se otorga al minero.


## Conclusión

La minería de Bitcoin, centrada en la inserción de nuevos bloques en la blockchain, es el pilar que asegura el buen funcionamiento de esta criptomoneda. A través del proceso de prueba de trabajo, los mineros garantizan que las transacciones sean válidas y que la blockchain se mantenga inmutable y segura. Este esfuerzo no solo sostiene el ecosistema de Bitcoin, sino que también asegura su descentralización, uno de sus principios fundamentales.

El proceso puede parecer complejo, pero en su núcleo, la minería es esencialmente una carrera global para mantener el registro de todas las transacciones de Bitcoin de manera segura y confiable.



Despues de esto, hablar de full-node (como montar el tuyo). Y hablar de mining-node.


