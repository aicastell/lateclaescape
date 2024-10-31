---
title: El sistema de recompensas
date: 2024-10-31
image: "/img/posts/mining-rewards.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "block reward", "bitcoin halving", "fee"]
draft: true
featured: true
---

# Introducción

Operar un nodo minero que compita en la red de Bitcoin de tu a tu con el resto de los nodos mineros, para intentar resolver el problema PoW antes que ningún otro nodo minero de la red, es costoso en términos económicos. El nodo minero requiere una gran cantidad de recursos, tanto energéticos como computacionales. El propietario debe invertir en hardware especializado, cubrir los altos costos de la energía eléctrica que consume, y mantener el software actualizado. El sistema sería insostenible si no hubiera algún tipo de incentivo a cambio.

# Recompensa de bloque

La **recompensa de bloque** o **block reward**, es la cantidad de Bitcoin que recibe un nodo minero cuando mina un bloque que finalmente es añadido exitosamente a la blockchain. Esta recompensa proviene de dos fuentes:

- Comisiones (Fee)
- Subsidio de bloque

## Comisiones (Fee)

En el articulo donde trato la [gestión de las transacciones](/post/2024/bitcoin-transaction-management) expliqué que el nodo de Bitcoin elige de la mempool aquellas transacciones con una comisión mas elevada. Pero no expliqué el motivo.

¿Cual es el motivo? Pues muy sencillo. La suma de todas las comisiones son una parte del incentivo que cobrará el minero en forma de Bitcoin, en el caso de ser el primer nodo de Bitcoin en minar su bloque de transacciones. Esto incentiva a que los nodos mineros prioricen las transacciones con un Fee mas elevado, pues al incluirlas en su bloque, obtienen mayores ingresos.

## Subsidio de bloque

Con cada bloque minado se ponen nuevos Bitcoin en circulación, conocidos como **subsidio de bloque**. El subsidio de bloque es la otra parte del incentivo que cobrará el minero en forma de Bitcoin en el caso que sea el primer nodo de Bitcoin en minar su bloque de transacciones.

Este incentivo esta estructurado de tal modo que se emite Bitcoin nuevo con cada bloque minado. En los orígenes de Bitcoin se recompensaba a los mineros con 50.0 BTC por cada bloque minado. Esta recompensa se divide a la mitad exactamente cada 210.000 bloques, lo que ocurre aproximadamente cada cuatro años. Al evento que reduce la cantidad de Bitcoin nuevo que se pone en circulación a la mitad, se le conoce como **Bitcoin halving**. En la historia de Bitcoin ya hemos vivido cuatro halvings. El último ocurrió el pasado 19 de Abril de 2024. Actualmente la recompensa es de 3.125 BTC por bloque minado. El próximo halving se espera para 2028.

| Event             | Date          |  Block     |  Reward (BTC) |   BTC mined(%) |
|-------------------|---------------|------------|---------------|--------------- |
| Bitcoin origin    | 03/01/2009    |  0         |  50.0000      |   50.0%        |
| Halving 1         | 28/11/2012    |  210000    |  25.0000      |   75.0%        |
| Halving 2         | 09/07/2016    |  420000    |  12.5000      |   87.5%        |
| Halving 3         | 11/05/2020    |  630000    |   6.2500      |   93.75%       |
| Halving 4         | 19/04/2024    |  840000    |   3.1250      |   96.875%      |
| Halving 5         | 2028          |  1050000   |   1.5625      |   98.4375%     |
| Halving 6         | 2032          |  1260000   |   0.78125     |   99.21875%    |

Este es el mecanismo de emisión controlado de Bitcoin. Está programado en el código fuente de Bitcoin, para reducirse hasta alcanzar un limite máximo total de 21 millones de Bitcoin en circulación. A partir de ese momento (estimado alrededor del año 2140), este incentivo dejará de existir. Y los mineros competirán exclusivamente por las comisiones (Fee) de cada bloque de transacciones.

# Transacción Coinbase

Hace algunos artículos hablamos sobre las [transacciones de Bitcoin](/post/2024/bitcoin-transaction), que sirven para transferir Bitcoin entre dos direcciones de Bitcoin: una dirección que actúa como emisora y la otra como receptora.

A diferencia de las transacciones normales, la **transacción coinbase** (TX_Coinbase) es una transacción especial y única en cada bloque de transacciones. La crea el nodo minero cada vez que construye un nuevo bloque de transacciones. Esta transacción coinbase no proviene de la mempool. No tiene dirección de origen, y tiene como dirección de destino la dirección de Bitcoin del nodo minero que la crea. Tampoco tiene comisión (Fee).

```
TX_COINBASE: {
  Emisor: "COINBASE",
  Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
  Cantidad: "3.625 BTC",
  DiSign: "DIGITAL_SIGNATURE"
}
```

En la Cantidad se incluye la recompensa del nodo minero. Por ejemplo, si un minero encuentra un bloque válido en 2025, cuando la recompensa de bloque son 3.125 BTC, y las transacciones incluidas pagan comisiones por un total de 0.5 BTC, la transacción coinbase reflejará un total de 3.625 BTC como pago al minero.

El nodo minero acaba de preparar su propia recompensa si consigue minar este bloque antes que nadie. La transacción coinbase es esencial para asegurar que los nodos mineros son recompensados por su trabajo. Y por tanto, para garantizar que sigan estando operativos.

# Despedida

Operar un nodo minero en la red de Bitcoin es una tarea exigente que requiere una inversión considerable en términos de tiempo, recursos y energía. Sin embargo, el sistema de incentivos de Bitcoin, compuesto por la recompensa de bloque y las comisiones, ha demostrado ser una estructura robusta para motivar a los mineros a asegurar la red. La introducción progresiva de Bitcoin en circulación mediante el subsidio de bloque y el evento de reducción de recompensa halving, establece un modelo económico que controla la oferta de Bitcoin de forma predecible y limitada, hasta alcanzar el máximo de 21 millones de monedas.

A medida que la recompensa por bloque disminuye y eventualmente desaparece, las comisiones de transacción tomarán un rol central en el incentivo de los mineros. Este sistema no solo asegura la descentralización de Bitcoin, sino también su sostenibilidad a largo plazo, confiando en el equilibrio entre incentivos económicos y seguridad de la red. Bitcoin sigue demostrando que un sistema de consenso bien diseñado puede ser la base de una red financiera global sin la necesidad de una autoridad centralizada.

Pulso la tecla escape, dos puntos wq!
