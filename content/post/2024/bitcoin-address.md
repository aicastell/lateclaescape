---
title: Direcciones Bitcoin
date: 2024-06-21
image: "/img/posts/bitcoin-address.webp"
categories: [ "criptomonedas", "bitcoin" ]
tags: [ "bitcoin address", "dirección de bitcoin", "IBAN" ]
draft: false
featured: true
---

# Direcciones Bitcoin

Si has llegado aquí por casualidad, antes de continuar quiero darte la bienvenida a este blog. Espero que encuentres contenido a la altura de tus expectativas.

En este articulo comparo las direcciones de Bitcoin con conceptos de la banca tradicional que te resultaran familiares. Si todavía no lo has hecho, es un buen momento para leerte este articulo sobre [la banca tradicional](/post/2024/banca-tradicional).

Una dirección de Bitcoin funciona de manera similar al IBAN de una cuenta bancaria tradicional. Permite guardar Bitcoins, enviarlos a otros usuarios, o recibirlos.

Sin embargo, hay diferencias importantes tanto en su proceso de creación como en su proceso de gestión, que veremos a lo largo de este articulo.

## Proceso de creación

Una dirección de Bitcoin se crea a partir de un proceso matemático que se inicia generando una [clave privada asimétrica](/post/2024/criptografia-asimetrica). Veamos el proceso:

### La clave privada

En el contexto de Bitcoin, una clave privada es un numero entero de 256 bits generado de forma aleatoria.

No importa como generes esos 256 bits, con tal que no sean repetibles ni predecibles.

Puedes utilizar por ejemplo una moneda, lápiz y papel. Tirando la moneda al aire 256 veces y anotando 0 o 1 según salga cara o cruz, al finalizar el proceso tendrás los 256 bits que puedes usar como clave privada.

También puedes usar la [huella digital SHA-256](/post/2024/huellas-digitales-fingerprints) de un conjunto de palabras elegidas al azar.

```
$ echo "perro silla gato mesa" | sha256sum
cc0858bcf3ac2014cf99f73becaac7c936e2e52bd1805fb501290936e94cf346
```

Para el propósito educacional que nos ocupa, usaremos esta secuencia de 256 bits (64 símbolos hexadecimales, cada uno de 4 bits) como nuestra clave privada de Bitcoin.

> ¡OJO! Es una clave privada inventada. ¡no la uses en el mundo real!

### La clave publica

La clave publica se obtiene a partir de la clave privada generada en el paso anterior.

En el contexto de Bitcoin se utiliza la función ECDS (Eliptic Curve Digital Signature) o firma digital por curva elíptica, sobre la clave privada, para obtener como salida la clave pública asociada.

La clave pública generada tendrá un aspecto similar a este:

```
03bb4f3445f7cc7e5e60e29a51137436fc0dec02804f556febe412406103d5d2c6
```

Si eres desarrollador de software, puedes usar [este script](https://github.com/aicastell/scripts/blob/master/src/get_btc_public_address.py) en Python para analizar el proceso en detalle.

Si has leído el articulo sobre criptografía asimétrica ya sabrás que este par de claves pública y privada están relacionadas matemáticamente. A partir de la clave privada podemos obtener la clave pública. Pero a partir de la clave publica es computacionalmente imposible obtener la clave privada.

### La dirección Bitcoin

Una dirección de Bitcoin es una cadena alfanumérica que representa un destino único dentro de la red de Bitcoin al que se pueden transferir fondos. Hay 3 tipos de direcciones de Bitcoin:

| Tipo    | Significado          | Dirección Bitcoin                          |
|---------|----------------------|--------------------------------------------|
|P2PKH    | Pay-to-PubKey-Hash   | 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa         |
|P2SH     | Pay-to-Script-Hash   | 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy         |
|Bench32  | SegWit               | bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf6s20 |

El proceso para generar la dirección de Bitcoin aplica una serie de transformaciones sobre la clave pública para terminar obteniendo la dirección de Bitcoin. A modo de ejemplo, veamos las transformaciones necesarias para obtener una dirección Bitcoin de tipo P2PKH:

El proceso se inicia aplicando la función de hash [RIPEMD160](/post/2024/huellas-digitales-fingerprints) sobre la clave pública. El resultado se pasa dos veces por la función de hash [SHA-256](/post/2024/huellas-digitales-fingerprints). Los 4 primeros bytes del resultado se añaden al final del hash RIPEMD160. Y el resultado total se codifica en [base58](/post/2024/sistemas-de-codificacion) para obtener finalmente la dirección de Bitcoin.

El siguiente esquema resume el proceso:

![Bitcoin address P2PKH schema](/img/bitcoin-addr-generation-p2pkh-schema.webp)

Fíjate que las flechas tienen una sola dirección, es un camino unidireccional, sin vuelta atrás. A partir de la clave privada podemos generar la dirección de Bitcoin. Pero a partir de la dirección de Bitcoin es imposible obtener la clave privada.

Si eres desarrollador de software, entenderás mejor el proceso analizando [este script](https://github.com/aicastell/scripts/blob/master/src/get_btc_address.py) en Python.

Para la mayoría de las personas, una dirección de Bitcoin es simplemente un revoltijo de letras y números sin mucho sentido. Pero tu ahora ya formas parte de ese 0.05% de la población mundial que entiende como se genera una dirección de Bitcoin.

## Proceso de gestión

Las direcciones de Bitcoin juegan un papel fundamental en la red de Bitcoin por muy diversas razones:

- Identificación de actores
- Seguridad
- Transparencia
- Privacidad
- Accesibilidad y usabilidad
- Descentralización y autonomía

Veamos estos puntos en detalle, por separado:

### Identificación de actores

Las direcciones Bitcoin permiten identificar de manera única al emisor y al receptor de una transacción. Para recibir Bitcoin de alguien, tienes que darle tu dirección de Bitcoin al emisor. Para enviar Bitcoin a alguien, el receptor debe darte su dirección de Bitcoin.

### Seguridad

La clave privada es necesaria para poder enviar los fondos de una dirección Bitcoin a otra dirección. Poseer la clave privada es la prueba que demuestra que tú eres el legítimo propietario de los Bitcoin que vas a transferir.

La seguridad de una dirección de Bitcoin, y por tanto, de todos los Bitcoin asociados a esa dirección, depende exclusivamente de guardar a buen recaudo y en el mas absoluto secreto esa clave privada.

Guardar de forma segura esa clave privada es **esencial** para que no perder tus Bitcoin. Si la clave privada se corrompe, se pierde o se borra, estas bien jodido, porque es **prácticamente imposible** recuperar los Bitcoin asociados a esa dirección sin tu clave privada. Se estima que un 20% de los Bitcoin totales en circulación nunca se podrán recuperar. Sus usuarios, o bien perdieron las claves privadas, o bien fallecieron sin transmitirlas. Sin la clave privada, estos Bitcoin permanecerán bloqueados de forma eterna, sin que nadie pueda volver a usarlos jamás.

Si en algún momento te roban la clave privada, simplemente perderás la propiedad de tus Bitcoin, que pasarán a manos del nuevo (pero ilegítimo) propietario. El hecho de que no haya datos personales asociados a la dirección Bitcoin hace prácticamente imposible identificar al ladrón. Por tanto, **nunca** reveles tu clave privada **a nadie**.

### Transparencia

Las dirección de Bitcoin es de naturaleza pública. Todo el mundo puede ver las direcciones públicas. Cualquier persona puede consultar una base de datos pública para verificar el saldo de una dirección Bitcoin, y las transacciones asociadas a dicha dirección.

### Privacidad

Las direcciones de Bitcoin se crean sin estar asociadas a una identidad del mundo real (DNI, pasaporte, etc), proporcionando un cierto nivel de anonimato. Aunque puedas conocer el saldo de una dirección Bitcoin, no sabes quien es su propietario.

Sin embargo, en el momento que le dices a alguien tu dirección de Bitcoin para que te envíe unas monedas, estas revelando tu identidad. Esto plantea un problema para tu propia privacidad si reutilizas la misma dirección de Bitcoin para distintas transacciones, ya que tu identidad queda asociada a dicha dirección de Bitcoin. Para mejorar tu propia privacidad, es recomendable no reutilizar las direcciones de Bitcoin, y usar una nueva para cada transacción.

### Accesibilidad y usabilidad

Las direcciones de Bitcoin proporcionan una manera sencilla para que los usuarios interactúen con la red de Bitcoin. Pueden ser fácilmente copiadas, pegadas y compartidas entre usuarios para facilitar transacciones.

La estructura de una dirección de Bitcoin incluye un mecanismo de checksum que ayuda a prevenir errores tipográficos al introducir una dirección.

### Descentralización y autonomía

La generación y la gestión de direcciones de Bitcoin no dependen de ninguna entidad central. Cualquier usuario tiene control total para crear tantas direcciones de Bitcoin nuevas como desee, sin necesidad de ningún intermediario.

## Notación

Voy a representar una dirección de Bitcoin como un objeto en notación JavaScript (JavaScript Object Notation o mas conocido como JSON), un formato fácil de leer y entender para cualquier persona.

```
Bitcoin_Address: {
    "address": "1AgvypRTsWnWkaThh473sXscRynsEZSfjA",
 "public_key": "03bb4f3445f7cc7e5e60e29a51137436fc0dec02804f556febe412406103d5d2c6",
"private_key": "0xcc0858bcf3ac2014cf99f73becaac7c936e2e52bd1805fb501290936e94cf346"
}
```

Como ves, el objeto JSON de una dirección Bitcoin tiene 3 atributos:

- address: la dirección Bitcoin, en este caso en formato P2PKH
- public_key: la clave pública
- private_key: la clave privada

> ¡OJO! Las claves publica y privada de esta dirección Bitcoin son inventadas con fines educativos. ¡No transfieras Bitcoin a esa dirección porque se perderá en la eternidad!

## Relación con la banca tradicional

Una dirección de Bitcoin funciona de manera similar al IBAN de una cuenta bancaria tradicional, en el sentido que permite a su propietario guardar, enviar o recibir Bitcoins.

La clave privada de la dirección de Bitcoin es el equivalente al PIN de la banca tradicional. Se necesita para poder enviar los fondos de una dirección Bitcoin a otra.

En la banca tradicional, los bancos son los encargados de crear una cuenta bancaria. Una persona puede tener varias cuentas bancarias. Cada entidad bancaria registrará los datos personales de esa persona. Y esos datos personales quedarán vinculados a la cuenta bancaria creada. En cambio, para crear una dirección de Bitcoin, no necesitas ninguna autoridad central. No necesitas ningún banco. Cualquier persona puede crear una dirección Bitcoin en su propia casa con su propio ordenador. Ni siquiera necesitas conexión a Internet para hacer esta operación.

Con la banca tradicional, las entidades bancarias son las encargadas de guardar las claves de acceso como el PIN. En cambio, con una dirección Bitcoin, toda la responsabilidad sobre la custodia y la seguridad de la clave privada recae sobre la persona que ha creado la dirección.

La banca tradicional asocia a cada cuenta bancaria una identidad personal. En cambio, el crear una dirección de Bitcoin, no se asocia ninguna identidad personal, el proceso es completamente anónimo.

La banca tradicional se encarga de conservar tu dinero seguro en su caja fuerte. En cambio, dentro de una dirección de Bitcoin no hay ni un solo centavo de Bitcoin. ¿Como?. Dices que en mi dirección de Bitcoin no hay, ¿ni un solo centavo?. No te preocupes si te acaba de explotar la cabeza. Tus Bitcoin están guardados en un sitio seguro. En próximos artículos te explicaré dónde están guardados.

## Despedida

En este articulo has aprendido que una dirección de Bitcoin se deriva por reglas matemáticas a partir de una clave publica. Y que ésta se obtiene a partir de la clave privada asociada. Ya sabes que la dirección de Bitcoin es el equivalente al IBAN de la banca tradicional. Y que la clave privada es el equivalente al PIN de la banca tradicional. En el próximo articulo trataremos el [estandar BIP](/post/2024/bip), necesario para tratar los [wallets de Bitcoin](/post/2024/bitcoin-wallet-types) con rigor mas adelante.

Como siempre, puedes encontrarme en el [canal de Telegram](https://t.me/lateclaescape) donde estoy atento a sugerencias, dudas, criticas y cualquier otro comentario. Gracias por leerme y, ¡nos vemos en el próximo articulo!.

Pulso la tecla ESC, dos puntos wq!
