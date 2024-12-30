---
title: Tipos de Bitcoin wallet
date: 2024-07-14
image: "/img/posts/bitcoin-wallet-types.webp"
categories: [ "criptomonedas", "bitcoin" ]
tags: [ "wallet", "BIP" ]
draft: false
featured: true
---

# Tipos de Bitcoin wallet

En el anterior articulo exploré las [direcciones de Bitcoin](/post/2024/bitcoin-address).

En este articulo explico qué es un wallet de Bitcoin y que relación tiene con las direcciones de Bitcoin. Después analizaré los [estándares BIP](/post/2024/bip) que aplican a los wallet específicamente. Y finalizaré con una clasificación de los wallets en base a distintos criterios.

Tras la lectura de este articulo conocerás las características mas relevantes de los distintos wallet de Bitcoin para que puedas elegir el wallet que mejor se adapte a tus propias necesidades.

## Que es un wallet

Un **wallet de Bitcoin**, también llamado **monedero**, es una herramienta que permite a un usuario gestionar sus Bitcoin. No almacena Bitcoins en si, sino las claves privadas y publicas necesarias para que un usuario acceda a sus Bitcoin. La clave privada actúa como la contraseña que permite enviar tus Bitcoin a otro wallet, y debe mantenerse segura. La clave pública esta ligada a las [direcciones de Bitcoin](/post/2024/bitcoin-address), y se utiliza para recibir Bitcoins.

El wallet de Bitcoin tiene cierta relación con una cartera física donde guardas tu dinero en efectivo. Sin embargo, a diferencia de las carteras físicas, un wallet de Bitcoin no almacena ni un solo céntimo de Bitcoin en su interior.

Es probable que pensaras que tus Bitcoin estaban almacenados en tu wallet. Reflexiona sobre lo que te acabo de decir: *en tu wallet no hay ni un solo céntimo de Bitcoin*. No te preocupes si te acaba de explotar la cabeza. Tus Bitcoin están guardados en una base de datos distribuida conocida como **blockchain** y sobre la que hablaremos mas adelante.

## BIP wallet

Los 3 [BIP](/post/2024/bip) más importantes relacionados con los wallets de Bitcoin son:

- BIP-0032: Hierarchical Deterministic Wallets (HD Wallets):
- BIP-0039: Mnemonic Code for Generating Deterministic Keys:
- BIP-0044: Multi-Account Hierarchy for Deterministic Wallets:

Veamos cada uno por separado:

### BIP-0032

La BIP 32 de Bitcoin, titulada *Hierarchical Deterministic Wallets*, y archivada bajo el número [BIP-0032](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki), es una propuesta de tipo informational.

Esta BIP describe un método para generar una secuencia de claves privadas a partir de una clave privada maestra. Con una sola clave privada, el usuario puede regenerar toda una secuencia de claves privadas, y por tanto, todas sus direcciones de Bitcoin asociadas. Esta secuencia de claves es siempre la misma. Esto permite a los usuarios crear varias direcciones de Bitcoin sin necesidad de hacer una copia de seguridad de cada clave individualmente.

### BIP-0039

La BIP 39 de Bitcoin, titulada *Mnemonic code for generating deterministic keys*, y archivada bajo el número [BIP-0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki), es una propuesta de tipo standard track.

Esta BIP describe un método para codificar los 256 bits de una clave privada utilizando una **frase semilla** de 12 o 24 palabras seleccionadas de una [lista de 2048 palabras](https://github.com/bitcoin/bips/blob/master/bip-0039/spanish.txt). Estas palabras se transforman en un hash de 256 bits, que luego se utiliza como la clave privada. Es un estándar ampliamente adoptado, lo que garantiza que los usuarios puedan recuperar sus claves utilizando diferentes monederos.

### BIP-0044

La BIP 44 de Bitcoin, titulada *Multi-Account Hierarchy for Deterministic Wallets*, y archivada bajo el número [BIP-0044](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki), es una propuesta de tipo standard track.

Esta BIP introduce el concepto de wallet multicuenta. Permite crear/restaurar un wallet que permite operar con distintas criptomonedas (no solo Bitcoin), cada una con su propia estructura jerárquica de claves privadas, utilizando una única semilla de recuperación. Esta es la [lista de criptomonedas](https://github.com/satoshilabs/slips/blob/master/slip-0044.md) soportadas. Difícilmente conozcas alguna que no encuentres en esta lista.

## Clasificación de wallet

Los wallet se pueden clasificar en base a distintos criterios. Yo he decidido clasificarlos utilizando tres criterios:

- Control de las claves
- Accesibilidad
- Naturaleza física

### Control de las claves

Dependiendo si las claves privadas las tiene el usuario en su poder o no, los wallet se pueden clasificar en dos grupos:

- Custodial wallet
- Non-custodial wallet

#### Custodial wallet

Un custodial wallet es un tipo de wallet donde una plataforma que actúa como una tercera parte (normalmente un exchange), mantiene y gestiona las claves privadas del usuario.

Esto significa que la entidad que custodia las claves tiene el control directo sobre los activos digitales del usuario.

Los wallets custodial son fáciles de usar. Por tanto, son adecuados para usuarios principiantes. A menudo, las plataformas de custodia ofrecen soporte al cliente, lo que puede ser útil para resolver problemas rápidamente. Si el usuario pierde la clave de acceso, la plataforma de custodia puede ayudar a recuperar la cuenta. Las plataformas de custodia pueden integrar otros servicios financieros como el *trading* o el *staking*.

> *Not your keys, not your Bitcoin*

Por contra, los usuarios no tienen control total sobre sus claves privadas. Dependen de su seguridad, de su confiabilidad e incluso de lo corrupto que pueda ser alguno de sus empleados. Estas plataformas manejan grandes cantidades de criptomonedas y son objetivos atractivos para los ciberdelincuentes. Finalmente, pueden estar sujetas a regulaciones e imponer restricciones o limitar el acceso a tus fondos.

#### Non-custodial wallet

Un Non-custodial wallet es un tipo de wallet donde el usuario tiene control total sobre sus claves privadas. Esto significa que el usuario tiene toda la responsabilidad sobre la gestión y la seguridad de esas claves privadas.

> *Your keys, your Bitcoin*

Son los mas recomendados para usuarios experimentados.

### Accesibilidad

Dependiendo si el wallet necesita estar conectado a Internet para funcionar o no, los wallet se pueden clasificar en dos grupos:

- Online wallet
- Offline wallet

#### Online wallet

Un wallet online, también llamado *hot wallet*, es un tipo de wallet que debe estar conectado a Internet en todo momento mientras se usa.

Al estar conectado a Internet, permite un acceso rápido y cómodo a los fondos asociados desde cualquier sitio donde tengas acceso a Internet.

Por contra, son mas vulnerables a ciberataques debido a la exposición a la red. Algunos requieren verificar la identidad del usuario para operar con ellos, lo que proporciona un nivel de anonimato muy bajo.

#### Offline wallet

Una wallet offline, también llamado *cold wallet*, es un tipo de wallet que solo necesita conectarse a Internet de forma temporal para firmar y enviar transacciones. El resto del tiempo se mantiene desconectado de Internet.

Estos wallets maximizan la seguridad al mantener las claves privadas offline, fuera del alcance de posibles ciberataques. Por tanto, son mas seguros a la hora de almacenar criptomonedas a largo plazo.

Por contra, son menos convenientes para transacciones diarias debido al engorroso proceso que requieren para conectarse y realizar las transacciones.

### Naturaleza física

Dependiendo de la naturaleza física, los wallet se pueden clasificar en dos grupos:

- Logical wallet
- Physical wallet

#### Logical wallet

Los wallets lógicos son software diseñado para instalarse y ejecutarse en algún dispositivo digital. No tienen un formato físico tangible. Todos los wallets online son wallets lógicos. Tenemos tres tipos de wallets lógicos:

- Desktop wallets
- Smartphone wallets
- Browser wallets

##### Desktop wallet

Un desktop wallet es un wallet que puedes instalar y gestionar como una aplicación en tu propio PC.

Ofrecen opciones de cifrado para las claves privadas, y una gama completa de funciones, incluyendo soporte para múltiples criptomonedas, integración con hardware wallets, y opciones avanzadas para transacciones y gestión de activos. Se recomienda operar con ellos desde un PC que esté bien protegido contra virus y otros malwares, y que se conecte a Internet solo cuando sea absolutamente necesario.

Por contra, son vulnerables a virus, key loggers, troyanos y otros tipo de malware. El usuario es el único responsable de la seguridad de sus claves privadas. Pueden requerir una cantidad significativa de recursos hardware (espacio en disco), especialmente si el wallet necesita descargar toda la blockchain para operar. Son una opción sólida para aquellos usuarios que buscan un equilibrio entre seguridad y facilidad de uso.

##### Mobile wallet

Un mobile wallet es un wallet que puedes instalar y gestionar como una APP de tu teléfono móvil (smartphone).

Almacenan tus claves privadas en una APP de tu teléfono móvil. Esto facilita su uso en cualquier lugar y en cualquier momento, haciendo que sean ideales para transacciones diarias y pagos en comercios físicos. Muchos incorporan medidas de seguridad adicionales como autenticación biométrica (huellas dactilares o reconocimiento facial).

Por contra, un smartphone es menos potente que un PC, por lo que interactuar con el wallet puede ser mas lento. Además, los smartphone son vulnerables a virus, troyanos, key loggers o ataques de phishing, especialmente si se descargan aplicaciones de fuentes no confiables. También existe un mayor riesgo de perdida o robo del dispositivo, lo que podría poner en riesgo tus fondos. Por todo ello, se recomienda su uso solamente con pequeñas cantidades de Bitcoin.

##### Browser wallet

Un browser wallet es un wallet que funciona como una extensión del navegador web (Chrome, Firefox, o Brave).

Son ideales para usuarios que interactúan frecuentemente con sitios web que aceptan criptomonedas. Permiten un acceso rápido a los fondos y las funciones de la wallet sin necesidad de abrir una aplicación separada. La mayoría implementa características de seguridad como el cifrado, la autenticación de dos factores (2FA) y protecciones contra phising.

Por contra, su seguridad depende en gran medida de la seguridad del navegador y del sistema operativo del dispositivo.

#### Physical wallet

Los wallets físicos son dispositivos físicos diseñados específicamente para almacenar claves privadas de criptomonedas de manera segura. Hay básicamente tres tipos:

- Hardware wallet
- Paper wallet
- Metal wallet

##### Hardware wallet

Un hardware wallet es un dispositivo hardware diseñado específicamente para almacenar claves privadas de manera segura y protegerlas contra accesos no autorizados. Son wallets offline, que se conectan a algún wallet lógico (software) únicamente en el momento de realizar alguna transacción.

Son dispositivos compactos y muy fáciles de guardar. Funcionan con múltiples criptomonedas. Son considerados una de las formas más seguras de almacenar criptomonedas a largo plazo.

Por contra, pueden ser relativamente caros en comparación con otros tipos de wallets. Si el dispositivo se pierde o se daña, las claves privadas se pueden recuperar usando una frase semilla de recuperación. Pero es imperativo almacenar esa frase de recuperación de forma segura.

##### Paper wallet

Un paper wallet es un trozo de papel donde se almacena, o bien la clave privada para enviar fondos, o bien la frase semilla de 12 o 24 palabras de ese wallet. Mas simple imposible.

Nunca está conectado a Internet, por lo que es inmune a hackeos en linea. Además, es la forma mas económica de almacenar criptomonedas.

Sin embargo, el papel puede destruirse con mucha facilidad (fuego o agua). Es vulnerable a accesos físicos no autorizados, por lo que es imperativo tomar medidas de seguridad adicionales, como el uso de cajas fuertes o distribuir la clave en distintas ubicaciones geográficas. No es muy práctico para hacer un uso habitual.

##### Metal wallet

Un metal wallet es equivalente al paper wallet, pero en lugar de papel, emplea un trozo de metal (hierro, aluminio o titanio).

Son resistentes a daños físicos (fuego o agua). Y son extremadamente duraderos, ofreciendo una excelente protección a largo plazo.

Sin embargo, su fabricación puede mas costosa. Y requieren un almacenamiento seguro para protegerlos contra robos. Lo que supone una desventaja significativa para muchos usuarios.

## Despedida

En este articulo has aprendido que es un wallet de Bitcoin. Ahora ya conoces los tipos de wallet que existen, y puedes elegir el tipo de wallet que mejor se adapte a tus propias necesidades.

Si conoces algún wallet que no encaje en esta clasificación, puedes decírmelo en el [canal de Telegram](https://t.me/lateclaescape) y añadiré la información a este articulo. El canal también sirve para que puedas dejarme preguntas, críticas o cualquier comentario que consideres.

En el próximo articulo haré un listado de todos los wallets que conozco y hablare de sus características. Asi que atento que esto continúa. Muchas gracias por leerme y nos vemos muy pronto.

Pulso la tecla ESC, dos puntos wq!
