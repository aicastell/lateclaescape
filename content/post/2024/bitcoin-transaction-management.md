---
title: Gestión de transacciones
date: 2024-08-31
image: "/img/posts/bitcoin-transaction-management.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "nodos", "transacción", "mempool" ]
draft: false
featured: true
---

# Motivación

En un articulo anterior he hablado sobre las tres responsabilidades principales de un [nodo de Bitcoin](/posts/bitcoin-nodes), que son:

- Gestionar transacciones
- Gestionar bloques de transacciones
- Gestionar la blockchain

En otro articulo he explicado que los nodos de Bitcoin se organizan en una [red de nodos de Bitcoin](/posts/bitcoin-nodes-network) para compartir información entre ellos. Para simplificar, reduje la red mundial de nodos a solo cinco: BN1, BN2, BN3, BN4 y BN5, aunque en la realidad, esta red está formada por decenas de miles de nodos.

En el articulo sobre [transacciones de Bitcoin](/posts/bitcoin-transaction) has asistido al proceso de creación de la transacción TX_666. Te la incluyo de nuevo para que no la pierdas de vista:

  ```
  TX_666: {
    Emisor: "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
  Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
  Cantidad: "3.0 BTC",
       Fee: "0.0004972 BTC",
    DiSign: "DIGITAL_SIGNATURE"
  }
  ```

En este artículo, me enfocaré en la primera responsabilidad de los nodos de Bitcoin: la gestión de las transacciones. Prepárate, porque esto se pone interesante.

## Gestión de las transacciones

Hablando específicamente sobre la gestión de transacciones, los nodos de Bitcoin tienen cuatro responsabilidades que realizan en orden:

1. Recibir la transacción
2. Verificar la transacción
3. Difundir la transacción
4. Encolar la transacción

![Bitcoin transaction management steps](/img/bitcoin-transaction-management-diagram.webp)

### 1. Recibir la transacción

Tras crear la transacción TX_666, el usuario emisor la envía a uno de los nodos de la red de Bitcoin. Por ejemplo, al nodo español BN5.

### 2. Verificar la transacción

Cuando el nodo de Bitcoin BN5 recibe la transacción TX_666 realiza una serie de verificaciones para asegurarse de que la transacción es válida. Vamos a analizar este proceso de verificación.

Lo primero que hace el nodo de Bitcoin es validar la firma digital del emisor. Es decir, el campo DiSign. Para ello intenta desencriptar el campo DiSign con la clave publica del Emisor (K_PUB_SEND). Recuerda que al ser pública, es conocida por todos, incluso por los Nodos de la red. Si no lo consigue, el nodo ha detectado a un impostor e invalida la transacción TX_666. Y fin de la historia de esta transacción.

Si el nodo consigue desencriptar el campo DiSign con la clave publica del Emisor, ya sabe que el emisor de la transacción es el legitimo propietario de los 3.0 BTC que se están transmitiendo al receptor. El proceso continúa.

Al desencriptar DiSign con K_PUB_SEND, obtiene la huella digital creada por el emisor:

```
Decrypt(K_PUB_SEND, "DIGITAL_SIGNATURE") = 0x556833d3496c2b786906d61e91c25f3158ca5a140a8d6c2502ce05a191054c4d
```

Por otro lado, el nodo recalcula la huella digital de la transacción por si mismo, para lo cual necesita eliminar de la transacción el campo DiSign:

```
TX_666: {
  Emisor: "1LwEptPi5m7in3RuXGqJJvwMkBcDhpNtPk",
Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
Cantidad: "3.0 BTC",
     Fee: "0.0004972 BTC",
}
```

Una vez hecho esto, recalcula su huella digital SHA-256:

```
SHA-256(TX_666) = 0x556833d3496c2b786906d61e91c25f3158ca5a140a8d6c2502ce05a191054c4d
```

El nodo compara la huella digital obtenida al desencriptar DiSign, con la huella digital que acaba de calcular. Si son diferentes, ha detectado una transacción fraudulenta puesto que alguien ha intentado modificar los datos de la transacción. De nuevo, en este caso se invalida la transacción TX_666. Y fin de la historia de esta transacción.

Si las huellas digitales SHA-256 comparadas son iguales, el proceso de verificación continúa.

Como última comprobación, el nodo de Bitcoin consulta si la dirección de Bitcoin emisora dispone de fondos suficientes para realizar la transferencia. Si solamente tuviera 2.0 BTC, la transacción se cancelaría con el error de saldo insuficiente. Y de nuevo, fin de la historia de esta transacción.

Como el emisor tiene 10.0 BTC y solamente quiere transferir 3.0 BTC, dispone de fondos suficientes para realizar la operación. Por tanto, la transacción finalmente se verifica como valida.

Fíjate como la transacción va en texto plano, sin encriptar. La seguridad de la transacción depende única y exclusivamente de la firma digital DiSign generada por el emisor de la transacción. Una idea sencilla y brillante. Una genialidad al alcance de muy pocos.

Este proceso de verificación de las transacciones se repite con cada transacción nueva que envía un usuario a la red de Bitcoin.

### 3. Difundir la transacción

Después de verificar la transacción TX_666 como válida, el nodo BN5 la difunde a todos los nodos de la red de Bitcoin. Así, la transacción TX_666 llega a a los nodos BN1, BN2, BN3, y BN4. Esta difusión se realiza utilizando el protocolo de difusión del que hablamos en el articulo sobre [red de nodos de Bitcoin](/posts/bitcoin-nodes-network). La difusión completa a todos los nodos de la red tarda apenas unos segundos.

### 4. Encolar la transacción

Cada vez que un nodo de Bitcoin recibe una nueva transacción verificada, la almacena en un área de almacenamiento temporal de transacciones verificadas pero pendientes de ser confirmadas, que se conoce como **mempool**.

Por tanto, la transacción TX_666 ahora mismo queda encolada en la mempool de cada nodo de la red de Bitcoin. Es decir, en la mempool de BN1, BN2, BN3, BN4 y BN5.

Si te fijas, la transacción TX_666 tiene una comisión *Fee* de 0.0004972 Bitcoin. En el articulo sobre [transacciones de Bitcoin](/posts/bitcoin-transactions) mencioné que mas adelante hablaría sobre una pequeña comisión *Fee* que se inserta en cada transacción. Ha llegado el momento de explicarte en que consiste esta comisión.

La comisión *Fee* es una pequeña cantidad de Bitcoin que el emisor incluye de forma voluntaria en la transacción que acaba de crear, y que sirve como incentivo para que su transacción se procese antes. Las transacciones con comisiones *Fee* más altas tienen mayor prioridad y, por tanto, se procesan antes. Las transacciones con comisiones *Fee* más bajas tienen menos prioridad y, por tanto, tardan más en procesarse.

Esto significa que la mempool es una cola ordenada por prioridad. La prioridad viene determinada por la comisión *Fee* de cada transacción. En la cabeza se sitúan las transacciones mas prioritarias. Y en la cola las transacciones menos prioritarias.


## Despedida

En este artículo has aprendido como los nodos de Bitcoin reciben, verifican, difunden, y finalmente encolan en su mempool las transacciones de Bitcoin que van creando los usuarios emisores. Al final de este proceso, las transacciones verificadas quedan almacenadas en la mempool de cada nodo de la red de Bitcoin.

Ya tenemos la transacción TX_666 en la mempool de todos los nodos de la red de Bitcoin. Sin embargo, nuestra transacción TX_666 todavía tiene un largo camino por recorrer. Esta transacción no finalizará hasta que el receptor tenga sus 3.0 BTC en su dirección de Bitcoin, y el emisor tenga los 7.0 BTC restantes en su dirección emisora.

En el próximo articulo veremos que es un bloque de transacciones y como nuestra transacción TX_666 termina dentro de uno de estos bloques.

Han empezado a salir muchos conceptos que pueden generar confusión si no se tienen claros todos los conceptos previos. No te quedes con dudas. Estaré pendiente del [canal de Telegram](https://t.me/lateclaescape) para intentar aclarar cualquier duda que te pueda surgir al respecto.

Como siempre, muchas gracias por leerme, y espero volver a verte en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!
