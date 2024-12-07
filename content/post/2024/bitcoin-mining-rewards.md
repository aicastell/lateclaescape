---
title: El sistema de recompensas
date: 2024-10-31
image: "/img/posts/mining-rewards.webp"
categories: ["criptomonedas", "bitcoin"]
tags: [ "block reward", "bitcoin halving", "fee"]
draft: false
featured: true
---

# Introducción

Operar un nodo minero que compita en la red de Bitcoin de tu a tu con el resto de los nodos mineros, para intentar resolver el problema PoW antes que ningún otro nodo minero de la red, es costoso en términos económicos. El nodo minero requiere una gran cantidad de recursos, tanto energéticos como computacionales. El propietario debe invertir en hardware especializado, cubrir los altos costos de la energía eléctrica que consume, y mantener el software actualizado. El sistema sería insostenible si no hubiera algún tipo de incentivo a cambio.

# Recompensa de bloque

La **recompensa de bloque** o **block reward**, es la cantidad de Bitcoin que recibe un nodo minero cuando mina un bloque que finalmente es añadido exitosamente a la blockchain. Esta recompensa proviene de dos fuentes:

- Comisiones (Fee)
- Subsidio de bloque

## Comisiones (Fee)

En el articulo donde trato la [gestión de las transacciones](/post/2024/bitcoin-transaction-management) expliqué que el nodo de Bitcoin selecciona, entre las transacciones de la mempool, aquellas con una comisión mas alta. Pero no expliqué el motivo detrás de esta selección.

La razón es sencilla: la suma de todas las comisiones es parte de la recompensa que recibirá el minero si es el primero en minar su bloque de transacciones. Este incentivo motiva a los mineros a priorizar las transacciones con un Fee más elevado, ya que al incluirlas en su bloque maximizan sus ingresos.

## Subsidio de bloque

Cada bloque minado introduce nuevos Bitcoin en circulación, conocidos como el **subsidio de bloque**. Este subsidio constituye la otra parte de la recompensa que recibe un minero en caso de ser el primero en validar y agregar un bloque de transacciones a la blockchain.

Este incentivo está diseñado para generar nuevos Bitcoin con cada bloque añadido. En el origen de los tiempos, los mineros eran recompensados con 50 BTC por bloque. Esta cantidad se reduce a la mitad cada 210,000 bloques, aproximadamente cada cuatro años, en un evento conocido como **Bitcoin halving**. Hasta la fecha, Bitcoin ha experimentado cuatro halvings, el último de los cuales tuvo lugar el 19 de abril de 2024, dejando la recompensa actual en 3.125 BTC por bloque. El próximo halving se prevé para 2028.

| Event             | Date          |  Block     |  Reward (BTC) |   BTC mined(%) |
|-------------------|---------------|------------|---------------|--------------- |
| Bitcoin origin    | 03/01/2009    |  0         |  50.0000      |   50.0%        |
| Halving 1         | 28/11/2012    |  210000    |  25.0000      |   75.0%        |
| Halving 2         | 09/07/2016    |  420000    |  12.5000      |   87.5%        |
| Halving 3         | 11/05/2020    |  630000    |   6.2500      |   93.75%       |
| Halving 4         | 19/04/2024    |  840000    |   3.1250      |   96.875%      |
| Halving 5         | 2028          |  1050000   |   1.5625      |   98.4375%     |
| Halving 6         | 2032          |  1260000   |   0.78125     |   99.21875%    |

Este mecanismo de emisión controlada está integrado en el código de Bitcoin y continuará reduciendo la cantidad de BTC emitidos hasta alcanzar el límite total de 21 millones. Una vez que se alcance esta cantidad, estimado alrededor de 2140, el subsidio de bloque desaparecerá, y los mineros dependerán únicamente de las comisiones de las transacciones (Fee) para obtener ingresos.

# Transacción Coinbase

Hace algunos artículos hablé sobre las [transacciones de Bitcoin](/post/2024/bitcoin-transaction), que permiten transferir Bitcoin entre dos direcciones de Bitcoin: una dirección que actúa como emisora y la otra como receptora.

A diferencia de las transacciones convencionales, la **transacción coinbase** (TX_Coinbase) es una transacción especial y única en cada bloque de transacciones. Esta transacción es generada por el nodo minero cada vez que crea un nuevo bloque de transacciones. A diferencia de las demás, la transacción coinbase no proviene de la mempool, no tiene una dirección de origen y su destino es la dirección de Bitcoin del minero que la genera. Además, no incluye ninguna comisión (Fee).

```
TX_COINBASE: {
  Emisor: "COINBASE",
  Receptor: "1PPVzjfPZece9mwJKdPB5Kbhv4JiSemFCu",
  Cantidad: "3.625 BTC",
  DiSign: "DIGITAL_SIGNATURE"
}
```

En la cantidad indicada se incluye la recompensa correspondiente al nodo minero. Por ejemplo, si un minero valida un bloque en octubre de 2024, cuando la recompensa por bloque es de 3.125 BTC y las transacciones incluidas aportan comisiones totales de 0.5 BTC, la transacción coinbase reflejará un total de 3.625 BTC como pago al minero.

De este modo, el nodo minero asegura su propia recompensa si logra minar el bloque antes que otros. La transacción coinbase es fundamental para garantizar que los nodos mineros reciban una compensación por su trabajo, lo que a su vez asegura su continuidad operativa en la red.

# Despedida

Operar un nodo minero en la red de Bitcoin es una tarea exigente que requiere una inversión considerable en términos de tiempo, recursos y energía. Sin embargo, el sistema de incentivos de Bitcoin, compuesto por la recompensa de bloque y las comisiones, ha demostrado ser una estructura robusta para motivar a los mineros a asegurar la red. La introducción progresiva de Bitcoin en circulación mediante el subsidio de bloque y el evento de reducción de recompensa halving, establece un modelo económico que controla la oferta de Bitcoin de forma predecible y limitada, hasta alcanzar el máximo de 21 millones de monedas.

A medida que la recompensa por bloque disminuye y eventualmente desaparece, las comisiones de transacción tomarán un rol central en el incentivo de los mineros. Este sistema no solo asegura la descentralización de Bitcoin, sino también su sostenibilidad a largo plazo, confiando en el equilibrio entre incentivos económicos y seguridad de la red. Bitcoin sigue demostrando que un sistema de consenso bien diseñado puede ser la base de una red financiera global sin la necesidad de una autoridad centralizada.

Pulso la tecla ESC, dos puntos wq!
