---
title: Bitcoin Improvement Proposal
date: 2024-06-27
image: "/img/posts/bip.webp"
categories: ["criptomonedas", "bitcoin"]
tags: [ "BIP" ]
draft: false
featured: true
---

# Introducción

En el mundo de Bitcoin la innovación es constante. Detrás de cada actualización y mejora del sistema se encuentra un proceso colaborativo conocido como BIP.

Tras la lectura de este articulo entenderás que son las BIP, como funcionan y por qué son fundamentales para el crecimiento y la seguridad de Bitcoin.

## ¿Que es una BIP?

Las siglas BIP significan *Bitcoin Improvement Proposal*. La traducción en español significa propuesta de mejora de Bitcoin, lo que ya aclara que una BIP es una propuesta para mejorar el funcionamiento de Bitcoin.

Entrando mas en detalle, la BIP es el mecanismo estándar elegido para proponer una nueva funcionalidad, para recopilar la opinión de la comunidad sobre un tema, o para documentar una decisión de diseño que se han tomado en Bitcoin.

BIP se ha hecho a semejanza del estándar PEP o *Python Enhancement Proposal*, que es el estándar utilizado para proponer mejoras en el lenguaje de programación Python.

Otras criptomonedas se han inspirado en un concepto similar para desarrollar su propio estándar de propuestas de mejora. Por ejemplo, Ethereum utiliza EIP o *Ethereum Improvement Proposal*, y Litecoin utiliza LIP o *Litecoin Improvement Proposal*.

## Propuesta BIP

Cada BIP se presenta como un documento de diseño escrito en formato mediawiki o markdown, donde se realiza una especificación técnica concisa de los cambios a introducir en la estructura de Bitcoin, así como su justificación y motivaciones.

Cada BIP es revisado por la comunidad, que decide por consenso si dicha propuesta es aprobada o no. Si es aprobada, posteriormente colaboran en su desarrollo.

El autor de una BIP es responsable de construir consenso dentro de la comunidad y de documentar las opiniones disidentes.

## Tipos de BIP

Debido a la diversidad de las propuestas, se ha decidido categorizar las BIP en tres tipos diferentes:

- BIP standard track
- BIP process
- BIP informational

### BIP standard track

Las BIP para el seguimiento del estándar pueden modificar el código fuente, introducir restricciones o incluso alterar la forma en que se validan las transacciones de Bitcoin. Estas BIP afectan al núcleo del sistema por lo que son criticas. Debido a esto, estos BIP requieren el consenso de toda la comunidad para que entren en vigencia.

### BIP process

Las BIP de procesos son reglas y procedimientos que ayudan a organizar cómo la comunidad de Bitcoin toma decisiones y gestiona el desarrollo de nuevas características y mejoras. No abordan cambios técnicos en el código de Bitcoin, sino que se centran en los métodos y prácticas que la comunidad debe seguir. Estas propuestas también deben ser examinadas por la comunidad y aprobadas mediante votación por consenso.

### BIP informational

Las BIP informativas se utilizan para compartir información útil, directrices o recomendaciones con la comunidad de Bitcoin. Estas BIP no proponen cambios en el código ni en los procesos. Están destinadas a educar y proporcionar información relevante tanto a usuarios como a desarrolladores. La comunidad no tiene que someter estas BIP a votación, ya que no implican cambios en el funcionamiento de Bitcoin.

## Estados de BIP

Cada BIP puede pasar por varios estados durante su ciclo de vida. La siguiente imagen muestra los distintos estados posibles y sus transiciones:

![BIP process](/img/bip-process.webp)

Estos estados ayudan a la comunidad de Bitcoin a rastrear el progreso y el estado de las propuestas de mejora, asegurando un proceso organizado y transparente para la evolución del protocolo. Veamos cada uno por separado:

### Draft

Este es el estado inicial de una BIP. Indica que la propuesta está en desarrollo y no ha sido oficialmente presentada a la comunidad. La BIP está siendo escrita y revisada por su autor o autores antes de ser formalmente sometida a consideración.

### Deferred

Una BIP diferida es aquella que ha sido postergada para su consideración futura. La propuesta no será revisada ni discutida en el momento actual, pero puede ser retomada más adelante.

### Accepted

Este estado indica que la comunidad de Bitcoin ha revisado y aceptado la BIP. La BIP ha sido aprobada para su implementación, pero aún no se ha completado la implementación.

### Rejected

Una BIP rechazada es aquella que ha sido revisada y no ha recibido el consenso necesario para ser aceptada. La propuesta no será implementada y no se le dará más consideración a menos que sea revisada y re-presentada.

### Withdrawn

El autor de la BIP ha decidido retirar la propuesta antes de que fuera aceptada o rechazada. La propuesta ya no está activa ni será considerada, a menos que el autor decida volver a presentarla en el futuro.

### Final

Este estado indica que la BIP ha sido completamente implementada y ya no requiere más modificaciones. La propuesta ha sido adoptada y su implementación está completa. Es la última etapa para muchas BIP.

### Replaced

Una BIP puede ser reemplazada por otra BIP que cubre los mismos aspectos de una manera diferente o mejor. La propuesta original ya no está activa y ha sido sustituida por una nueva propuesta que se considera más adecuada.

### Active

Este estado se aplica a las BIP que no introducen cambios técnicos pero son continuas y aplicables en el tiempo, como ciertos procesos o recomendaciones. La propuesta está en uso y sigue siendo relevante para la comunidad. No está completada ni finalizada, pero sigue vigente.

## Repositorio de BIP

Las BIP se guardan como archivos de texto en [este repositorio Git](https://github.com/bitcoin/bips). Dado que son archivos de texto, el historial de revisiones del repositorio actúa como un registro histórico de cada propuesta.

### BIP-0001

La primera BIP, titulada *BIP Purpose and Guidelines*, y archivada bajo el numero [BIP-0001](https://github.com/bitcoin/bips/blob/master/bip-0001.mediawiki), es una propuesta de tipo process.

Esta BIP establece el proceso formal para proponer mejoras en Bitcoin. Introduce el concepto de *Bitcoin Improvement Proposal*, define los tipos de BIP, y detalla los pasos necesarios para que una propuesta sea considerada y adoptada por la comunidad.

El texto de la BIP-0001 ha sido utilizada como referencia principal para extraer toda la información incluida en este articulo.

## Despedida

Con este articulo has aprendido cómo se gestionan y desarrollan las innovaciones dentro del ecosistema de Bitcoin. Ahora ya sabes lo que es una BIP.

En el próximo articulo, hablaré sobre wallets de criptomonedas. Haré referencia explícita a algunas BIP importantes como la el 0032, la 0039 o la 0044. Ya no me detendré en los detalles sobre qué es una BIP, porque eso ahora mismo ya lo sabes. No te pierdas el próximo articulo, porque es realmente muy interesante.

Recuerda que tienes un [canal de Telegram](https://t.me/lateclaescape) para dejar sugerencias, preguntas, críticas o cualquier comentario. Verte por el canal siempre es una fuente de energía que me anima a seguir escribiendo en este blog. Como siempre, muchas gracias por leerme y nos vemos muy pronto.

Pulso la tecla `ESC:wq!`
