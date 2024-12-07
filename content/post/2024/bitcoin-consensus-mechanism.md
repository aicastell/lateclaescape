---
title: El mecanismo de consenso
date: 2024-10-23
image: "/img/posts/bitcoin-consensus-mechanism.webp"
categories: ["criptomonedas", "bitcoin"]
tags: [ "mining_rig", "full_node", "pow", "fork", "bloque_minado", "minería" ]
draft: false
featured: true
---

# Introducción

Imagina un escenario en el que cada nodo en la red de Bitcoin pudiera añadir nuevos bloques de transacciones a su copia local de la blockchain sin coordinación alguna. Cada nodo acabaría creando su propia versión de la cadena de bloques, dando lugar a múltiples bifurcaciones, conocidas como **forks**. Este caos fragmentaría la red y erosionaría por completo la confianza en el sistema.

Para evitar el desorden y asegurar de forma descentralizada y eficiente que todos los nodos mantengan una única versión confiable de la blockchain, Bitcoin implementa un mecanismo de consenso distribuido, que garantiza la integridad, la seguridad y la confianza en la red. En este articulo vas a aprender qué es y como funciona este mecanismo.

# El mecanismo de consenso

Bitcoin es una red distribuida compuesta por nodos que no dependen de una autoridad central para funcionar. Esto plantea un desafío clave: es necesario definir un **mecanismo de consenso** que permita a todos los nodos de la red de Bitcoin llegar a un acuerdo sobre cual es el siguiente bloque de transacciones que deben añadir a su blockchain local. Este mecanismo asegurará que todos los nodos tengan la misma versión de la blockchain, evitando bifurcaciones o inconsistencias.

El mecanismo de consenso de Bitcoin está basado en varios elementos clave que paso a enumerar a continuación:

- [Huella digital](/post/2024/huellas-digitales-fingerprints/)
- [Dificultad](/post/2024/bitcoin-transaction-block)
- [Nonce](/post/2024/bitcoin-transaction-block)
- [Transacciones](/post/2024/bitcoin-transaction)
- [Bloque de transacciones](/post/2024/bitcoin-transaction-block/)
- [Blockchain](/post/2024/blockchain/)
- Prueba de trabajo
- Nodos mineros
- Minería de Bitcoin
- Nodo completo

Incluyo una referencia a los elementos de esta lista que ya han sido abordados en artículos anteriores, deteniéndome únicamente en la explicación de los conceptos nuevos.

## Nodos mineros

Los **nodos mineros** o **mining rings** son los nodos de Bitcoin especializados en crear nuevos bloques de transacciones. A partir de su mempool, eligen las transacciones de mayor prioridad para crear un nuevo bloque de transacciones. Es decir, las transacciones que pagan una comisión Fee mas elevada.

La **prueba de trabajo**, **proof-of-work**, o simplemente **PoW** por sus siglas en ingles, es un problema matemático complejo que tratan de resolver los nodos mineros continuamente. Consiste en encontrar un campo *Nonce* válido para el bloque de transacciones que acaban de crear, que cumpla con la *Dificultad* establecida en la red en ese momento. Esto significa, obtener una huella digital del bloque que tenga un numero determinado de ceros a la izquierda.

La **minería de Bitcoin** es el proceso mediante el cual todos los nodos mineros de la red de Bitcoin compiten por ser el primero en resolver el problema PoW. El primer nodo minero que resuelve el PoW, añade el campo correcto *Nonce* a la cabecera del bloque. Al bloque de transacciones que incluye un *Nonce* válido se le conoce como **bloque minado**.

El nodo minero que consigue minar un bloque gana el derecho a proponer su bloque de transacciones a la red.

Resolver el PoW requiere una capacidad computacional muy elevada. Esto asegura que proponer bloques a la red requiera de un esfuerzo computacional significativo, limitando posibles ataques y asegurando la descentralización.

## Nodos completos

Los denominados **nodos completos** o **full node** son los nodos de Bitcoin especializados en almacenar una copia completa de la blockchain. Los full nodes no participan en la minería, pero son cruciales para mantener la integridad del sistema. Actúan como guardianes, verificando que los bloques minados propuestos por los nodos mineros sean válidos. Esta verificación consiste en:

- Verificar que los hash del bloque minado sean validos
- Verificar que todas las transacciones dentro del bloque minado sean validas
- Verificar que no hay intentos de gastar los Bitcoin dos veces (double-spending)
- Verificar que el bloque minado sea el siguiente bloque de la blockchain mas larga de toda la red.

Si el bloque minado cumple con todas estas reglas, el full node acepta el bloque y lo añade a su propia copia local de la blockchain. Las transacciones que se incluyen en el nuevo bloque se consideran confirmadas y pasan a formar parte del historial inmutable de la blockchain. Después, el full node propaga el bloque minado a otros full nodes de la red, que repiten el proceso de verificación.

Si el proceso de verificación falla por cualquier motivo (por ejemplo, si el nodo minero hizo trampas incluyendo transacciones inválidas), el full node rechaza el bloque, que no será aceptado en su copia local, ni propagado al resto de los nodos de la red.

Este proceso asegura que todos los full node tengan una misma copia de la blockchain.

## Conclusión

El mecanismo de consenso distribuido es la piedra angular que permite que Bitcoin funcione de manera descentralizada y segura. Gracias a la PoW, los nodos de la red logran acordar una única versión de la blockchain, evitando el caos de las bifurcaciones y asegurando que las transacciones sean verificadas correctamente. Este proceso no solo garantiza la integridad de la red, sino que también fomenta la confianza entre los participantes, en un sistema donde no se requiere de intermediarios. Es una estructura compleja pero brillante, que ha permitido a Bitcoin prosperar como la principal criptomoneda del mundo.

Sin embargo, el consenso no es solo una cuestión de seguridad y coordinación. Hay un incentivo clave que motiva a los mineros a invertir tiempo y recursos en asegurar la red: las recompensas. En el próximo artículo trataré específicamente este sistema de recompensas.

Estoy siempre atento a tus comentarios en el [canal de Telegram](https://t.me/lateclaescape). Los tomo muy en cuenta, ya que me dan un feedback muy importante a la hora de valorar la calidad del contenido publicado. Estoy abierto a escuchar sugerencias y criticas de cualquier tipo. No te quedes con dudas, si no terminas de entender algún concepto, pregunta abiertamente en el canal, e intentaré aclarar tus dudas y si es precio, reescribiré el articulo para que esa misma duda no se repita en futuros lectores.

Gracias por leerme y nos vemos en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!
