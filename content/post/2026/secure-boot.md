---
title: Secure Boot
date: 2026-05-18
image: /img/posts/secure-boot.webp
categories: [ "cybersecurity", "criptografía" ]
tags: [ "LUKS", "clave_simétrica", "ext4", "confidencialidad", "integridad", "autentificacion" ]
draft: true
featured: true
---

# Introducción

Secure Boot es un mecanismo de seguridad cuyo objetivo es garantizar que únicamente software auténtico y no modificado se ejecute durante el proceso de arranque de un sistema.

En sistemas Embedded Linux, el arranque suele estar compuesto por varias etapas: código ROM, bootloader, kernel, device tree, initramfs y, finalmente, userspace. El Secure Boot construye una cadena de confianza en la que cada etapa verifica criptográficamente la siguiente antes de transferirle el control.

El objetivo de este articulo es construir un modelo mental genérico, sin entrar en detalles particulares sobre ninguna plataforma en concreto. Voy a explicar cómo se establece la cadena de confianza, cuándo se generan las claves, cuándo se generan las firmas, dónde se almacenan las firmas y como se verifica cada imagen. Al finalizar el articulo tendrás un conocimiento bastante cercano a lo que ocurre en el mundo real cuando enciendes un dispositivo correctamente securizado desde el código de la ROM.

Si te interesa esto del mundo de la ciberseguridad, no te pierdas este articulo, porque la seguridad en tu dispositivo empieza desde el mismo momento en el que le das alimentación a tu dispositivo.

# Importancia del Secure Boot

Sin Secure Boot, un atacante con acceso físico al dispositivo puede modificar el proceso de arranque completo. Eso significa que podría reemplazar cualquier etapa del arranque de tu dispositivo (bootloader, kernel o initramfs) por versiones modificadas que comprometan su seguridad. Un smartphone comprometido a este nivel podría:

- instalar rootkits persistentes invisibles para el sistema operativo
- instalar key-loggers para interceptar el teclado y capturar contraseñas y credenciales
- robar claves criptográficas y tokens de autenticación
- acceder a fotos, mensajes y documentos sensibles
- monitorizar permanentemente la actividad del usuario
- mantener el malware incluso después de reinstalar el sistema

Precisamente por eso existe Secure Boot. Para impedir que firmware no autorizado pueda ejecutarse durante el arranque. La cadena de confianza garantiza que cada componente del sistema haya sido verificado criptográficamente antes de transferirle el control.

# Definición de blob

En este artículo llamaremos blob a cualquier componente binario que participa en el arranque de un dispositivo:

- SPL
- bootloader
- kernel (Linux)
- device tree (DTB)
- initramfs

# Conceptos criptográficos

El Secure Boot esta basado en conceptos criptográficos fundamentales que ya conoces si eres un asiduo de este blog. Pero que te referencio si no los conoces para que profundices sobre ellos. Son estos cuatro:

- [Hash criptográfico](/post/2024/huellas-digitales-fingerprints)
- [Criptografía asimétrica](/post/2024/criptografia-asimetrica)
- [Firma digital](/post/2024/firmas-digitales)
- [Criptografía simétrica](/post/2024/criptografia-simetrica)

## Hash criptográfico

Un hash criptográfico calcula un hash de unos datos de entrada. Por ejemplo, si tomamos como entrada la imagen de un kernel, obtendremos como salida su hash asociado:

```
digest = HASH(kernel)
```

El digest calculado cambia completamente si cambia cualquier bit del blob.

En Secure Boot, el hash permite detectar modificaciones sobre el blob. Cuando ese hash queda protegido mediante una firma digital, la integridad del blob puede verificarse criptográficamente.

## Criptografía asimétrica

Depende de un par de claves relacionadas matemáticamente:

- K_PRI
- K_PUB

La clave privada (K_PRI) debe permanecer secreta. Se utiliza para firmar imágenes y nunca debe estar presente en el dispositivo final. Normalmente se almacena en un entorno protegido, por ejemplo un HSM o una maquina offline.

La clave pública (K_PUB) no es secreta. Puede distribuirse libremente y se utiliza para verificar las firmas generadas con la clave privada correspondiente.

## Firma digital

### Generación

Una firma digital se genera combinando una función hash con la clave privada (K_PRI):

```
digest = HASH(blob)
signature = SIGN(K_PRI, digest)
```

### Verificación

El verificador calcula localmente el hash del blob recibido:

```
local_digest = HASH(blob)
```

Después utiliza la clave pública (K_PUB) para verificar criptográficamente la firma:

```
VERIFY(K_PUB, signature, local_digest)
```

En Secure Boot, las firmas digitales permiten comprobar la autenticidad y la integridad de los distintos blob que participan en el arranque del sistema. Es decir, que los datos fueron firmados por quien posee la clave privada correspondiente y que no fueron manipulados por nadie. El hash se usa para detectar cambios. Y la firma digital, para verificar la autenticidad del blob.

## Criptografía simétrica

La criptografía simétrica utiliza una única clave secreta K_SECRET para cifrar y descifrar información.

```
cipher = ENCRYPT(K_SECRET, blob)
blob = DECRYPT(K_SECRET, cipher)
```

Por tanto, solamente puede cifrar y descifrar quien conoce la clave secreta K_SECRET. Esta clave secreta debe permanecer protegida en todo momento. Si un atacante obtiene esa clave, podrá descifrar toda la información protegida con ella.

La criptografía simétrica impide que un atacante pueda leer el contenido de cualquier blob. Por tanto, esta capa añade confidencialidad al mecanismo del Secure Boot. Pero debe quedar claro que esta capa de confidencialidad dentro del modelo de Secure Boot NO es obligatoria. Es opcional.

# Chain of Trust

El Secure Boot garantiza que solo software auténtico y no modificado se ejecute durante el proceso de arranque. Para ello basa todo su proceso de arranque en el concepto de cadena de confianza (*chain of trust*). La idea general es sencilla: cada etapa del arranque verifica criptográficamente la siguiente antes de transferirle el control.

La autenticidad de cada etapa se basa en firmas digitales. Opcionalmente, algunas plataformas añaden además una capa de cifrado simétrico para proporcionar confidencialidad.

Una cadena típica podría ser esta:

![Secure Boot trust chain](/img/secure-boot-trust-chain.webp)

Ningún componente comienza su ejecución hasta que la etapa anterior confirme que es auténtico y no ha sido modificado. Si la verificación de una etapa es correcta, el arranque continúa verificando la siguiente etapa. Si alguna verificación falla, el sistema detiene el proceso de arranque y entra en un modo de recuperación controlado.

En este articulo veremos cómo se generan las claves, cómo se realizan esas verificaciones criptográficas, y cómo se construye esta cadena de confianza desde el propio hardware.

# Root of Trust

Toda cadena de confianza necesita un punto inicial que se considere confiable. En Secure Boot, la confianza de toda la cadena se ancla en una raíz de confianza (*root of trust*) almacenada en hardware, y por tanto inmutable (no se puede modificar).

En sistemas embedded, ese punto suele ser la BootROM mas una cierta configuración hardware persistente. La BootROM es código grabado físicamente dentro del SoC. No se carga desde memoria externa, por lo que se considera el primer componente confiable del sistema. La BootROM es la primera etapa que verifica criptográficamente el siguiente componente del arranque.

## Memoria hardware programable

Muchas plataformas disponen de memoria programable irreversible. Es memoria que solo se puede escribir una vez, y cuyo contenido queda permanente dentro del dispositivo. Los registros de esta memoria se conocen como eFuse o fusibles electrónicos. Se usan para almacenar información crítica de seguridad como:

- si Secure Boot está o no activado
- hash de las claves públicas autorizadas
- claves simétricas opcionales
- estado de ciclo de vida del dispositivo
- contadores anti-rollback
- bits de revocación de claves

TODO: Una pequeña explicación de cada uno?

# Preparar el entorno (build time)

## Generación de claves

Antes de fabricar o provisionar el producto, el fabricante genera un par de claves asimétricas:

- K_PRI
- K_PUB

Después calcula el hash de la clave pública:

```
kpub_hash = HASH(K_PUB)
```

Ese hash se programa permanentemente en uno de los eFuses (memoria hardware permanente).

```
eFuse.kpub_hash = kpub_hash
```

A partir de ese momento, el dispositivo tiene una referencia inmutable para decidir qué clave pública se considera legítima.

Ocionalmente, el fabricante genera una clave simétrica de la que hablaremos después:

- K_SECRET

## Firmar los blobs

Conceptualmente, por cada blob se calcula su firma digital:

```
digest = HASH(blob)
signature = SIGN(K_PRI, digest)
```

Este proceso se realiza:

- O bien al finalizar la compilación de cada blob
- O bien durante la generación de la release (una vez finalizada la compilación de todos ellos)

El resultado final deja de ser únicamente el blob binario y pasa a ser una imagen firmada llamada signed_image. Esta imagen integra tres componentes:

- blob
- signature
- K_PUB

Los tres componentes de la imagen firmada deben almacenarse en la memoria del dispositivo embedded. Lo importante aquí es que deben estar disponibles para el verificador (la etapa que realiza la verificación). Eso no supone un problema de seguridad porque la clave pública (K_PUB) no es secreta.

## Encriptar las imágenes firmadas

Como un paso opcional, el fabricante podría encriptar la imagen firmada signed_image con la clave secreta (K_SECRET):

```
encrypted_blob = ENCRYPT(K_SECRET, signed_image)
```

El resultado `encrypted_blob` es un blob cifrado cuyo contenido no puede interpretarse sin conocer la clave secreta correspondiente.

# Proceso de arranque (boot time)

## Arranca la BootROM

La CPU ejecuta primero la BootROM.

La BootROM está dentro del SoC. Al estar integrada fisicamente dentro del SoC, la BootROM no puede modificarse mediante software convencional. Por tanto, se considera software de confianza.

## Lectura de la configuración hardware

La BootROM lee la información de los eFuses:

- secure_boot_enabled
- kpub_hash
- lifecycle_state
- rollback_state
- revoke_bits

## Lectura de la imagen firmada

La BootROM identifica el dispositivo principal de almacenamiento externo: SPI, MMC, NAND, NOR, SD, etc.

La BootROM lee del dispositivo principal de almacenamiento donde se encuentran los componentes de la primera imagen firmada.

La BootROM lee estos tres componentes:

- blob
- signature
- K_PUB_recibida

## Verificación de la clave pública

La BootROM ya tiene disponible la clave pública recibida (K_PUB_recibida). A partir de ella, calcula su hash:

```
hash_calculado = HASH(K_PUB_recibida)
```

Y lo compara con el hash programado en el eFuse hardware:

```
hash_calculado == eFuse.kpub_hash
```

Si no coincide, el arranque se aborta. Ya que no podemos confiar en la clave publica obtenida (K_PUB_recibida).

Si coincide, esa clave pública se considera autorizada.

## Verificación de la firma digital

Una vez aceptada la clave pública, el sistema verifica la firma digital de la imagen firmada:

```
digest = HASH(blob)
VERIFY(K_PUB_recibida, signature, digest)
```

Si la firma no es válida, el sistema debe rechazarlo. Y el proceso se detiene.

Si la firma es válida, el blob se considera auténtico e íntegro. Y pasa a ejecutarse ese blog, que repite el proceso para la siguiente etapa.

¿Por qué es necesario el hash de la clave publica fuseado? Porque la clave pública viene junto con la imagen firmada. Si no hubiera una referencia hardware que indicase qué clave pública es legítima, un atacante podría generar su propio par de claves, modificar el blob, firmarlo con su clave privada, incluir su propia clave publica. Y matemáticamente, la firma sería válida con su clave pública. El sistema verificaría correctamente. Pero estaría usando una clave pública elegida por el atacante.

Por eso hace falta una raíz de confianza hardware que responda a esta pregunta: ¿es ésta la clave pública realmente autorizada?.

## Confidencialidad opcional

Un sistema puede implementar Secure Boot únicamente para garantizar autenticidad e integridad mediante firmas digitales, permitiendo que el contenido de los blobs siga siendo visible.

Sin embargo, el nivel de seguridad puede incrementarse significativamente añadiendo una capa de criptografía simétrica que impida que un atacante pueda leer el contenido de los blobs almacenados en la memoria del dispositivo.



El modelo de Secure Boot descrito hasta ahora está basado en criptografía asimétrica y firmas digitales. Ese modelo garantiza autenticidad y integridad. Pero no garantiza confidencialidad.

Eso significa que, aunque un atacante no pueda modificar el firmware sin romper la firma digital, sí podría leer su contenido si tuviera acceso físico al almacenamiento del dispositivo.

Para añadir confidencialidad, algunas plataformas incorporan una capa adicional basada en criptografía simétrica. En ese modelo, la imagen firmada (signed_image) se almacena cifrada:

```
encrypted_blob = ENCRYPT(K_SECRET, signed_image)
```

Durante el arranque, la etapa previa obtiene la clave secreta (K_SECRET), descifra la imagen y recupera el signed_image original:

```
signed_image = DECRYPT(K_SECRET, encrypted_blob)
```

A partir de ese momento, el proceso continúa exactamente igual que en el Secure Boot tradicional:

- verificar clave pública
- verificar firma digital
- ejecutar blob

La clave K_SECRET debe permanecer protegida dentro del dispositivo, ya que cualquier atacante que consiga obtenerla podrá descifrar el firmware almacenado.

Por este motivo, muchas plataformas almacenan este tipo de claves dentro de hardware seguro especializado, como TPMs, Secure Elements o enclaves criptográficos aislados, diseñados para dificultar la extracción de material sensible incluso frente a ataques físicos.

Es importante entender que el compromiso de K_SECRET no rompe automáticamente el modelo de Secure Boot. Si un atacante obtiene esa clave, podrá leer el firmware, pero seguirá sin poder modificarlo, ya que para generar firmware válido necesitaría la clave privada de firma (K_PRI), y esa clave nunca se almacena en el dispositivo.

Por tanto, las firmas digitales protegen autenticidad e integridad. Y el cifrado simétrico protege confidencialidad. Son mecanismos complementarios, pero independientes.

# Aceleradores criptográficos

Muchas plataformas modernas integran hardware criptográfico dedicado para ejecutar operaciones sensibles de forma aislada del sistema operativo general. Estos chips de seguridad suelen implementar primitivas como:

- SHA
- RSA
- ECC
- AES
- generación de números aleatorios
- almacenamiento y gestión protegida de claves

Su objetivo es:

- acelerar operaciones criptográficas
- reducir exposición de material sensible
- impedir que ciertas claves abandonen el hardware seguro
- aumentar resistencia frente a ataques físicos y lógicos

Un ejemplo conocido es el chip Titan M2 utilizado en los dispositivos Pixel, que actúa como elemento de seguridad dedicado y participa en tareas relacionadas con Secure Boot, protección de claves y verificación de integridad del sistema.

La existencia de este hardware no cambia el modelo conceptual del Secure Boot, pero sí proporciona un entorno más robusto y aislado para ejecutar operaciones criptográficas críticas.

# Conclusion

Cuando hablamos de Secure Boot, mucha gente imagina simplemente una opción de BIOS o una característica de seguridad más dentro del sistema operativo. Pero la realidad es mucho más profunda. Secure Boot define literalmente en qué software puede confiar un dispositivo desde el primer ciclo de reloj después del encendido. Toda la seguridad posterior depende de esta cadena de confianza inicial. Porque si un atacante consigue comprometer el proceso de arranque, podrá ejecutar código antes incluso de que el kernel o el sistema operativo comiencen a funcionar.

Por eso Secure Boot no es únicamente un mecanismo de verificación de firmas. Es una arquitectura completa de confianza basada en criptografía, hardware seguro y validaciones encadenadas. Entender este flujo es esencial para cualquiera que trabaje con sistemas embedded, boot-loaders, firmware, Android y ciberseguridad. Porque la seguridad real de un sistema no empieza en userspace. Empieza mucho antes. Empieza en la ROM.

Pulso la tecla `ESC:wq!`
