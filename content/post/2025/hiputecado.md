---
title: Hiputecado
date: 2025-05-01
image: "/img/posts/hiputecado.webp"
categories: [ "bancos" ]
tags: [ "hipoteca", "euribor", "importe_prestamo", "amortización", "tipo_de_interes", "capital" ]
draft: true
featured: true
---

# Introducción

Firmar una hipoteca es, probablemente, una de las decisiones financieras más importantes de tu vida.

Cuando buscas una hipoteca, habitualmente te centras en encontrar un banco que te la conceda, y que la cuota mensual "te cuadre". Sin embargo, por falta de conocimientos financieros, poca gente entiende realmente de dónde sale la cuota mensual, cómo se distribuyen los pagos mes a mes a lo largo del tiempo, cómo evoluciona la deuda, y cómo factores como una amortización anticipada, una revisión de tipos o un periodo de carencia pueden alterar de forma significativa el coste total de la hipoteca.

Este articulo explica de forma sencilla y clara, cómo se calcula la cuota mensual de tu hipoteca y cómo se reparte el dinero que pagas cada mes. Comprender bien este reparto no es un simple detalle: es la clave para descubrir cómo puedes ahorrarte miles de euros a lo largo de los años. Sí, has leído bien: miles y miles de euros que, si no entiendes cómo funciona tu hipoteca, acabarán en manos del banco en lugar de quedarse en tu bolsillo.

Es información valiosa y totalmente gratuita. ¿Quieres pagar menos por tu hipoteca y entender por fin cómo ahorrar a lo grande? Pues sigue leyendo, porque este articulo también te interesa.

# Conceptos financieros

Empecemos explicando algunos conceptos financieros que vamos a utilizar después.

- Importe del préstamo
- Deuda pendiente
- Plazo de devolución
- Tipo de interés
- Periodicidad

## Importe del préstamo

El **importe del préstamo hipotecario**, o **capital inicial**, es la cantidad de dinero que el banco te presta para comprar una vivienda. Actualmente los bancos no conceden el 100% del precio de compra de la vivienda. Normalmente financian solo un porcentaje del valor del inmueble (por ejemplo, el 80%). El resto (el 20%) mas los gastos de gestión (aproximadamente un 10%) debes aportarlo de tus ahorros personales. Esto significa que si quieres pedir una hipoteca, vas a necesitar tener en el banco unos ahorros mínimos de 60000€.

## Deuda pendiente

Una vez concedido el préstamo, la **deuda pendiente** con el banco es la cantidad total de dinero que debes del préstamo hipotecario en un momento dado. Antes de pagar la primera cuota, la deuda pendiente coincide con el importe total prestado. A medida que realizas pagos mensuales, la deuda pendiente va disminuyendo. Veremos esto después con mas detalle.

## Plazo de devolución

El plazo de devolución es el tiempo que acuerdas con el banco para devolver el dinero que te ha prestado. En las hipotecas, este plazo suele ir desde los 10 hasta los 35 años.

## Tipo de interés

El tipo de interés es un porcentaje que el banco te cobra por prestarte dinero. Mucha gente piensa que el tipo de interés se aplica sobre el **importe del préstamo**, pero no es así. El tipo de interés se aplica sobre la **deuda pendiente**. Esto tiene muchas implicaciones, que veremos después.

Existen principalmente tres tipos de interés:

- Interés a tipo fijo
- Interés a tipo variable
- Interés a tipo mixto

### Interés a tipo fijo

En una hipoteca con interés a tipo fijo, se fija un tipo de interés que será el mismo durante toda la vida del préstamo. Esto hace que las cuotas mensuales se mantengan constante durante toda la vida del préstamo. Desde el primer día sabes exactamente cuánto vas a pagar cada mes, lo que te aporta estabilidad, seguridad financiera y facilita mucho la planificación a largo plazo.

Elegir un tipo fijo resulta especialmente interesante cuando los tipos de interés del mercado están bajos, ya que te permite asegurarte esas condiciones favorables durante toda la vida del préstamo. Esto te protege frente a posibles subidas futuras de los tipos, evitando sorpresas desagradables.

### Interés a tipo variable

En una hipoteca a tipo variable, el interés que pagas depende de un índice de referencia —normalmente el Euribor— al que se le suma un diferencial fijo que establece el banco. Este índice de referencia (Euribor) se actualiza periódicamente, por lo general cada 6 o 12 meses.

Esta modalidad puede ser muy beneficiosa si los tipos de interés tienen una tendencia bajista, ya que tu cuota irá disminuyendo y pagarás menos intereses en total. Sin embargo, también implica un mayor riesgo: si los tipos suben, tus cuotas aumentarán, y el coste final de la hipoteca podría dispararse.

#### Ejemplo de interés a tipo variable

Si el Euribor está al 3% y tu hipoteca tiene un diferencial de +0,5%, el tipo de interés que pagarás será del 3,5% durante ese periodo. Cuando llegue el momento de la revisión, se volverá a actualizar el interés en función del nuevo valor del Euribor. Si el Euribor baja al 2%, tu nuevo interés será del 2,5%. Pero si sube al 4%, entonces tu interés ascenderá al 4,5%. Así, tu cuota hipotecaria puede subir o bajar con cada revisión, en función de cómo evolucione el Euribor.

### Interés a tipo mixto

En una hipoteca a tipo mixto, el préstamo comienza con un periodo inicial —normalmente entre 5 y 10 años— en el que el interés es fijo y la cuota se mantiene estable. Pasado ese tiempo, la hipoteca pasa a tipo variable, ajustándose a la evolución de un índice de referencia, como el euribor.

Esta fórmula busca ofrecer lo mejor de ambos mundos: estabilidad y cuotas previsibles durante los primeros años (normalmente los más delicados económicamente), y después la posibilidad de beneficiarte de bajadas de tipos si el mercado es favorable.

## Periodicidad

La periodicidad de una hipoteca se refiere a la frecuencia con la que debes realizar los pagos de la cuota del préstamo. En la mayoría de los casos, la periodicidad es mensual, es decir, se paga una cuota cada mes.

# Hipoteca modelo

A lo largo de este articulo voy a utilizar los datos de una hipoteca modelo en España. El importe del préstamo será de 120000€. Pactarás con el banco un plazo de devolución de 30 años. Y la tasa de interés anual será de un 3% a tipo fijo.

# Calculo cuota mensual

Para calcular la cuota mensual que vas a pagar por tu hipoteca necesitas considerar estas variables:

- C: Capital inicial (euros)
- n: Plazo de devolución (meses)
- r_anual: Tipo de interés (%)
- r_mensual: Tipo de interés mensual = r_anual / 12
- i: Índice de interés: r_mensual / 100

Se hace servir esta formula:

$$
\text{Cuota mensual} = C \cdot \frac{i}{1 - (1 + i)^{-n}}
$$

Rellena las variables con sus valores:

- C = 120000€
- n = 30 años x 12 meses = 360 meses
- r_anual = 3%
- r_mensual = r_anual / 12 = 3% / 12 = 0.25%
- i = r_mensual / 100 = 0.25 / 100 = 0.0025

Sustituye los valores en la formula y haz el calculo:

$$
\text{Cuota mensual} = 120000 \cdot \frac{0.0025}{1 - (1 + 0.0025)^{-360}} = 505.92\text{€}
$$

Esto significa que para pagar tu deuda con el banco, vas a tener que pagar 505.92€ durante los próximos 30 años.

# Conceptos cuota mensual

Si multiplicas 505.92€ por 30 años por 12 meses, tienes el total que vas a pagar por el préstamo: 182131.2€. Abre los ojos y vuelve a leerlo. Pediste al banco 120 mil euros, y has terminado pagando mas de 180 mil. Si, 60 mil euros de mas. Acabas de flipar, ¿verdad? ¿Como es esto posible?.

La cuota que pagas todos los meses al banco no se destina en su totalidad a reducir la deuda que tienes pendiente con el banco. Una parte de la cuota mensual se destina a reducir la deuda que tienes con el banco (técnicamente se conoce como **amortizar capital**). Y otra parte se destina a pagar **intereses** por el dinero que te han prestado. Tu cuota mensual es la suma de ambos conceptos:

$$
\text{Cuota mensual} = \text{Amortización de capital} + \text{Intereses}
$$

Veamos cada concepto por separado:

## Intereses

Los intereses son dinero que le pagas al banco a cambio del dinero que te ha prestado. Para los bancos, los "intereses" son su principal fuente de ingresos netos. Un negocio redondo: ingresar dinero pasivo a cambio de trabajar nada.

Para ti, los "intereses" van a ser el lastre de tu economía para el resto de tu vida. Es dinero que le pagas al banco y te impide reducir mas rápido tu deuda pendiente. Básicamente, dinero que le regalas al banco. Dicho de otro modo, dinero que tiras a la papelera.

Una mente inquieta como la tuya quiere entender cuanto dinero de tu cuota mensual va destinado al pago de intereses y cuanto a amortizar capital. Los intereses de la cuota mensual se obtienen usando estas dos variables:

- D: Deuda pendiente (euros)
- i: Índice de interés: r_mensual / 100

Se aplica esta formula:

$$
\text{Intereses de la cuota} = \text{D} \times i
$$

Siguiendo con la hipoteca modelo que estamos siguiendo en este articulo, la primera cuota que pagas al banco tienes una deuda con el banco de 120000€. Por tanto:

- D = 120000€
- i = 0.0025

El primer mes pagas al banco estos intereses:

$$
\text{Intereses de la primera cuota} = 120000 \times 0.0025 = 300\text{€}
$$

Fíjate que los intereses se calculan con la deuda pendiente (D) y no con el capital inicial (C). Cuanto menos deuda pendiente, menos intereses. Parece una frase tonta, pero tiene tantas implicaciones que dedicaremos un articulo entero a hablar sobre esta cuestión.

## Amortización de capital

Has pagado 505.92€ de la primera cuota de tu hipoteca. Te pregunto ahora, ¿que cantidad de dinero has reducido tu deuda pendiente con el banco? Si me contestas 505.92€, es que no has entendido nada. A tu cuota mensual debes quitarle los intereses que has pagado, para saber cuanto capital has amortizado. Su calculo es tan simple como restar de la cuota mensual, la parte de los intereses:

$$
\text{Amortización de capital} = \text{Cuota mensual} - \text{Intereses}
$$

Por tanto, la primera cuota que pagas al banco, en realidad amortizas este capital:

$$
\text{Amortización de la cuota} = 505,92\text{€} - 300\text{€} = 205.92\text{€}
$$

Efectivamente, has reducido tu deuda pendiente en 205.92€. Le sigues debiendo al banco 120000 - 205.92€ = 119794.08€.

# Cierre

En este articulo has aprendido cómo se calcula la cuota mensual de tu hipoteca y cómo se reparte esa cuota entre intereses y amortización de capital. Ahora ya tienes una base sólida para tomar decisiones más informadas sobre tu préstamo. Entender este reparto es clave para descubrir oportunidades de ahorro que, de otro modo, pasarían desapercibidas.

El próximo articulo explicará como funciona una **tabla de amortización francesa**, lo que te permitirá visualizar cómo evoluciona tu deuda mes a mes y cómo va cambiando la proporción entre intereses y capital amortizado. Y habrá un último articulo con trucos personales para que ahorres mucho dinero con tu hipoteca. Si quieres entender cómo puedes optimizar el pago de tu hipoteca, no te pierdas los próximos artículos de esta serie.

Y si te ha picado la curiosidad, te han surgido dudas hipotecarias existenciales, o si simplemente quieres contarme lo caro que está todo, puedes unirte de forma totalmente gratuita al[canal de Telegram](https://t.me/lateclaescape) y dejarme allí tus preguntas, sugerencias, críticas (mejor si son constructivas), o simplemente pasarte a saludar.

¡Nos vemos calculando la próxima cuota de tu hipoteca!.

Pulso la tecla ESC, dos puntos wq!

