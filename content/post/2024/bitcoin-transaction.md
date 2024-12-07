---
title: Transacciones de Bitcoin
date: 2024-08-25
image: "/img/posts/bitcoin-transaction.webp"
categories: [ "criptomonedas", "bitcoin" ]
tags: [ "transacción", "wallet", "bitcoin address" ]
draft: false
featured: true
---

# Motivación

Antes de empezar, quiero darte la bienvenida a este blog, y agradecerte el tiempo que dediques a su lectura. Intento cuidar el contenido de cada articulo para que cada minuto que dediques a su lectura te aporte valor.

Si eres un lector asiduo a este blog ya sabes muchas cosas sobre Bitcoin. Repaso algunos conceptos que has aprendido.

Sabes que un [wallet de Bitcoin](/post/2024/bitcoin-wallet-types) es una herramienta que contiene [direcciones de Bitcoin](/post/2024/bitcoin-address). Que cada dirección de Bitcoin tiene asociada dos [claves asimétricas](/post/2024/criptografia-asimetrica): una clave pública y una clave privada. Que estas dos claves asimétricas están relacionadas matemáticamente. Que la clave privada es necesaria para enviar Bitcoin. Que a partir de la clave publica se deriva la dirección de Bitcoin. Y que la dirección de Bitcoin se utiliza para recibir Bitcoin.

Si tienes claros estos conceptos de los que acabo de hablar, estas listo para afrontar la lectura de este articulo. En caso contrario, antes de continuar te recomendaría revisar los artículos referenciados para que saques el máximo provecho del tiempo que inviertas en la lectura.

## Transacción de Bitcoin

Si estas leyendo este articulo probablemente sea porque quieres aprender lo que es una transacción de Bitcoin. Así que voy a empezar por su definición.

Una **transacción de Bitcoin** es el proceso mediante el cual se transfiere una cantidad de Bitcoin entre dos direcciones de Bitcoin: una dirección que actúa como emisora y la otra como receptora.

La literatura suele relacionar dos wallets de Bitcoin cuando se habla de transacciones: un wallet emisor y un wallet receptor. Sin embargo, yo te hablo de direcciones de Bitcoin, no de wallets. Hablar de wallets es usar un término impreciso. Los Bitcoin no se transfieren entre wallets. Se transfieren entre direcciones de Bitcoin, que eso si, están asociadas a un wallet. De ahí la importancia de entender perfectamente cual es su diferencia.

## Ejemplo de transacción

Te explicaré con un ejemplo práctico como se crea una transacción de Bitcoin.

El emisor tiene un wallet con varias direcciones de Bitcoin. Una de sus direcciones tiene un saldo de 10.0 BTC. El emisor quiere transferir 3.0 BTC al receptor. El receptor tiene un wallet de Bitcoin sin saldo en ninguna de sus direcciones de Bitcoin. El emisor y el receptor de la transacción pueden ser personas diferentes. Pero también pueden ser la misma persona, ya que una sola persona puede poseer distintas direcciones de Bitcoin.

La transacción va a transferir 3.0 BTC desde la dirección de Bitcoin emisora hasta la dirección de Bitcoin receptora.

### Direcciones de Bitcoin

Por un lado tenemos al emisor de la transacción, que tiene la dirección de Bitcoin emisora (BASend) en su wallet:

```
  BASend: {
      "address": "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
   "public_key": "K_PRI_SEND",
  "private_key": "K_PUB_SEND"
  }
```

Por otro lado tenemos al receptor de la transacción, que tiene la dirección de Bitcoin receptora (BARecv) en su wallet:

```
  BARecv: {
      "address": "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
   "public_key": "K_PRI_RECV",
  "private_key": "K_PUB_RECV"
  }
```

### Crear la transacción

La transacción la crea el emisor. Es decir, la persona que quiere enviar una cantidad de Bitcoin a alguien.

Para crear una nueva transacción, el emisor necesita ser propietario de una dirección de Bitcoin con fondos suficientes para crear la transacción. El emisor está en posesión de una dirección de Bitcoin "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk" con un saldo de 10.0 BTC. Por tanto, tiene fondos suficientes para transferir 3.0 BTC al receptor.

A continuación, el emisor necesita la dirección de Bitcoin del receptor, que es "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu" en este ejemplo.

El emisor crea la transacción en la que incluye la dirección del emisor, la dirección del receptor, y la cantidad de Bitcoin que desea transferir (3.0 BTC).

```
TX_666: {
  Emisor: "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
Cantidad: "3.0 BTC"
}
```

Bautizo a esta transacción con un nombre infernal, **TX_666**, para que te resulte bien llamativa y no la pierdas de vista. La voy a referenciar en próximos artículos.

El emisor añade adicionalmente una pequeña comisión o *Fee* de la que hablaré en el próximo articulo.

```
TX_666: {
  Emisor: "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
Cantidad: "3.0 BTC",
     Fee: "0.0004972 BTC"
}
```

### Firma digital de la transacción

Imagina que cualquier persona pudiera crear una transacción de Bitcoin tal y como acabo de describir. Esta persona podría crear transacciones fraudulentas poniendo como emisor la dirección de cualquier wallet con saldo positivo, y como receptor la dirección de su propio wallet. Se sentiría un hacker todo poderoso. Obviamente, esto no sería admisible. ¿Como resuelve Bitcoin este problema?

Para evitar este problema, el emisor debe añadir a la transacción una [firma digital](/post/2024/firmas-digitales) "Disign" que demuestre que es el legitimo propietario de los 3.0 BTC que va a transferir al receptor.

Esta firma digital se genera calculando una [huella digital](/post/2024/huellas-digitales-fingerprints) SHA-256 de la transacción, que posteriormente se encripta con la clave privada del emisor (K_PRI_SEND). Veamos los pasos en detalle:

Primero se calcula la huella digital SHA-256 de la transacción:

```
SHA-256(TX_666) = 0x556833d3496c2b786906d61e91c25f3158ca5a140a8d6c2502ce05a191054c4d
```

Esta huella digital ahora se encripta con la clave privada del emisor.

```
ENCRYPT(K_PRI_SEND, 0x556833d3496c2b786906d61e91c25f3158ca5a140a8d6c2502ce05a191054c4d) = "DIGITAL_SIGNATURE"
```

Esta firma digital que hemos llamado "DIGITAL_SIGNATURE" se incluye en la transacción como un nuevo campo al que llamamos "DiSign".

```
TX_666: {
  Emisor: "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
Cantidad: "3.0 BTC",
     Fee: "0.0004972 BTC",
  DiSign: "DIGITAL_SIGNATURE"
}
```

## Despedida

La transacción TX_666 acaba de nacer. La ha creado el emisor de la transacción. Pero esta transacción TX_666 no ha finalizado. No finalizará hasta que el receptor tenga sus 3.0 BTC en la dirección de Bitcoin receptora. Y el emisor tenga sus 7.0 BTC en la dirección de Bitcoin emisora.

La transacción TX_666 acaba de iniciar un largo viaje. Este viaje es el que va a guiar los próximos artículos publicados en este blog. Acompaña a la transacción TX_666 en su camino para descubrir todos los secretos sobre el funcionamiento de Bitcoin explicados como nunca antes te los había explicado nadie. Te espero en la próxima parada, donde hablaremos sobre como la transacción se propaga por la red de nodos de Bitcoin.

Como siempre, puedes encontrarme en el [canal de Telegram](https://t.me/lateclaescape) donde estoy atento a sugerencias, dudas, criticas y cualquier otro comentario. Gracias por leerme y, ¡nos vemos en el próximo articulo!.

Pulso la tecla ESC, dos puntos wq!
