---
title: La banca tradicional
date: 2024-06-07
image: "/img/posts/banca-tradicional.webp"
categories: [ "finanzas", "economia" ]
tags: [ "banca tradicional", IBAN", "PIN" ]
draft: false
featured: true
---

# La banca tradicional

En este articulo explico el funcionamiento de un banco tradicional. Voy a simplificar mucho la realidad. El objetivo es utilizar esta información en próximos artículos para buscar semejanzas con las criptomonedas.

Un banco tradicional es una empresa privada que gestiona una **caja fuerte** donde se acumula el [dinero FIAT](/post/2024/dinero-fiat) que ahorran todos sus usuarios.

## La cuenta bancaria

Una cuenta bancaria es un acuerdo financiero entre un usuario y un banco. Actúa como una especie de hucha donde el banco custodia el dinero depositado por ese usuario.

El dinero de la cuenta bancaria puede ser utilizado por su propietario para realizar operaciones como depósitos, retiros, pagos, cobros, y transferencias.

### Creación

Para operar con el banco, cada usuario debe crear una cuenta bancaria.

Para crear una cuenta bancaria, el nuevo usuario debe identificarse presentando información detallada como su DNI, edad, o información de contacto. Con esta información el banco puede verificar su identidad para cumplir con las regulaciones legales y los protocolos de seguridad establecidos.

Una vez dado de alta, el banco asigna al usuario:

- un **IBAN** o International Bank Account Number
- un **PIN** o Personal Identification Number
- un **saldo** inicial

El **IBAN** es un identificador único para cada cuenta bancaria a nivel mundial. Es un identificador público que puedes compartir con cualquier persona que tenga que depositarte dinero en tu cuenta. El formato del IBAN varía según el país, pero generalmente incluye un código de país, dos dígitos de control y una serie de caracteres que identifican de manera única la cuenta bancaria.

El **PIN** es un número secreto para poder operar con tu cuenta bancaria. Te permite conocer tu saldo, realizar pagos y transferir dinero a otras cuentas bancarias. Por tanto, es un dato que solo debe conocer la persona autorizada a usar dicha cuenta bancaria. Es esencial mantener este número seguro y no compartirlo con terceros.

El **saldo** refleja el dinero que tiene ese usuario acumulado en su cuenta bancaria en un momento dado. En el momento del alta, el saldo inicial es de 0€. El saldo se actualizará automáticamente con cada transacción realizada, como depósitos, retiros, pagos y transferencias.

### Notación

Voy a representar una cuenta bancaria como un objeto en notación JSON (JavaScript Object Notation), que es un formato fácil de leer para cualquier persona.

```
{
  "Bank_Account": {
              "IBAN": "ES9121000418450200051332",
               "PIN": "1234",
           "Balance": "0€",
          "Identity": {
                  "name": "Juan Carlos",
               "surname": "Noexisto Meinventan",
                   "DNI": "12345678A",
             "residence": "Calle Falsa 123, Madrid, España",
                   "age": 35
        }
    }
}
```

### Operaciones

Una vez registrado, el usuario del banco puede hacer tres operaciones básicas con su cuenta bancaria:

1. Depositar dinero
2. Retirar dinero
3. Transferir dinero

Cuando alguien **deposita dinero** en una cuenta bancaria, la cantidad depositada se añade al saldo de esa cuenta bancaria, incrementando el valor total en la caja fuerte del banco en la cantidad depositada. Para depositar dinero en una cuenta solo necesitas conocer el IBAN de esa cuenta. No necesitas el PIN. Por tanto, es una operación que puede hacer cualquiera que conozca el IBAN.

Cuando un usuario **retira dinero** del banco, la cantidad retirada se resta del saldo de su cuenta bancaria, disminuyendo el valor total en la caja fuerte del banco en la cantidad retirada. El usuario puede retirar como máximo el dinero que tiene en el saldo de su cuenta bancaria en el momento de la operación. Para esta operación es necesario conocer el IBAN y el PIN. Por tanto, es una operación que solo puede hacer el usuario autorizado (el que conoce el PIN).

Cuando un usuario **transfiere dinero** de su cuenta bancaria a la cuenta bancaria de otro usuario, la cantidad de dinero que se resta del saldo de la cuenta emisora se suma al saldo de la cuenta receptora. En este caso el dinero total almacenado en la caja fuerte del banco no varía. Simplemente cambia de manos. El usuario puede transferir como máximo el dinero que tiene en el saldo de su cuenta en el momento de la operación. Para esta operación es necesario conocer el IBAN de la cuenta destino y el PIN de la cuenta origen. Por tanto, es una operación que solo puede hacer el usuario autorizado.

## Base de datos centralizada

El banco gestiona una **base de datos centralizada** en la que almacena los datos de todos sus usuarios. Puedes imaginar esta base de datos como una gran hoja de cálculo tipo Excel, en la que cada fila almacena los datos de un usuario. Esta base de datos está custodiada por el propio banco.

Veamos todo esto con un ejemplo sencillo:

| Identidad | IBAN  | PIN  | Saldo |
|-----------|-------|------|-------|
| U1        | IBAN1 | 1234 |   7€  |
| U2        | IBAN2 | 1982 |   2€  |
| U3        | IBAN3 | 9876 |   1€  |

Imagina un banco muy pequeño con solo tres usuarios:

- U1: usuario numero uno
- U2: usuario numero dos
- U3: usuario numero tres

Cada usuario tiene una cuenta bancaria asociada:

- IBAN1: cuenta bancaria de U1
- IBAN2: cuenta bancaria de U2
- IBAN3: cuenta bancaria de U3

Cada usuario tiene un saldo inicial diferente. En el instante de tiempo t0:

- la cuenta IBAN1 tiene 7€
- la cuenta IBAN2 tiene 2€
- la cuenta IBAN3 tiene 1€

Representaremos toda esta información de esta manera:

```
            IBAN1   IBAN2   IBAN3   CAJA
t0          7€      2€      1€      10€
```

El saldo total en la caja fuerte en el instante de tiempo t0 es de 10€.

## Ejemplos de transferencia

La base de datos del banco se actualiza con cada operación realizada por alguno de sus clientes. En el instante de tiempo t1, el usuario U1 transfiere 2€ al usuario U2. El usuario U1 se queda con 5€ y el usuario U2 se queda con 4€.

```
            IBAN1   IBAN2   IBAN3   CAJA
t0          7€      2€      1€      10€
t1          5€      4€      1€      10€
```

Después, en el instante de tiempo t2, el usuario U2 (que tiene 4€) transfiere 1€ al usuario U3. El usuario U2 se queda con 3€ y el usuario U3 se queda con 2€.

```
            IBAN1   IBAN2   IBAN3   CAJA
t0          7€      2€      1€      10€
t1          5€      4€      1€      10€
t2          5€      3€      2€      10€
```

Finalmente, en el instante de tiempo t3, el usuario U3 (que ahora tiene 2€) transfiere 2€ al usuario U1, el usuario U3 se queda con 0€ y el usuario U1 se queda con 7€.

```
            IBAN1   IBAN2   IBAN3   CAJA
t0          7€      2€      1€      10€
t1          5€      4€      1€      10€
t2          5€      3€      2€      10€
t3          7€      3€      0€      10€
```

Acabamos de realizar tres operaciones de tipo transferencia. Fíjate como tras cada operación, la cantidad de dinero total que hay en la caja fuerte del banco no varia. La caja fuerte de nuestro ejemplo de banco siempre tiene un saldo total de 10€.

El banco impedirá ciertas operaciones cuando el usuario no tenga saldo suficiente en su cuenta bancaria. Por ejemplo, en la situación t3, el usuario U3 no podría transferir 1€ a nadie, porque no dispone de saldo suficiente. El usuario U2 tampoco podría transferir 5€ a nadie, porque solo tiene 3€ en su cuenta. Y el usuario U1 no podría retirar 10€ de su cuenta porque solo dispone de 7€.

## Despedida

En este articulo has aprendido que es el IBAN y el PIN de una cuenta bancaria. Has aprendido que para depositar dinero necesitas conocer el IBAN, pero para retirar o transferir dinero, necesitas conocer el PIN. Aunque parezcan conceptos triviales, conviene tenerlos presentes para entender los artículos posteriores. En el siguiente artículo sobre criptomonedas hablaremos sobre las direcciones de Bitcoin.

Como siempre, estaré atento a cualquier cualquier duda, sugerencia o comentario por el [canal de Telegram](https://t.me/lateclaescape). Nos vemos en el siguiente articulo!.

Pulso la tecla ESC, dos puntos wq!
