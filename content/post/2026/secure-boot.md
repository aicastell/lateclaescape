---
title: Secure Boot
date: 2026-05-27
image: /img/posts/secure-boot.webp
categories: [ "cybersecurity", "criptografía" ]
tags: [ "chain_of_trust", "root_of_trust", "bootloader", "confidencialidad", "integridad", "autenticación", "secure_boot", "eFuse" ]
draft: false
featured: true
---

# Introducción

Cuando hablamos de **Secure Boot**, mucha gente imagina simplemente una opción de BIOS o una característica de seguridad más dentro del sistema operativo. Pero la realidad es mucho más profunda y compleja.

**Secure Boot** es un mecanismo de seguridad cuyo objetivo es garantizar que únicamente software auténtico y no modificado se ejecute durante el proceso de arranque de un sistema.

En sistemas Linux embedded, el arranque suele estar compuesto por varias etapas: código ROM, bootloader, kernel, device tree, initramfs y, finalmente, userspace. El **Secure Boot** construye una cadena de confianza en la que cada etapa verifica criptográficamente la siguiente antes de transferirle el control.

Este articulo construye un modelo mental genérico, sin entrar en detalles particulares sobre ninguna plataforma en concreto. Voy a explicar cómo se establece la cadena de confianza, cuándo se generan las claves, cuándo se generan las firmas, dónde se almacenan las firmas y como se verifica cada imagen.

Al finalizar este artículo tendrás una visión bastante cercana a lo que ocurre en el mundo real cuando enciendes un dispositivo correctamente securizado desde el propio código ROM. Si te interesa la ciberseguridad y trabajas con sistemas Linux embedded, firmware, Android o bootloaders, entender este flujo es fundamental, porque la seguridad de un sistema no empieza en userspace. Empieza mucho antes: justo en el instante en el que pulsas el botón de encendido. El Power ON.

# Importancia del Secure Boot

Sin **Secure Boot**, un atacante con acceso físico a tu dispositivo podría reemplazar cualquier etapa del arranque de tu dispositivo (bootloader, kernel o initramfs) por versiones modificadas que abrieran brechas de seguridad deliberadas. Un smartphone comprometido a este nivel podría:

- instalar rootkits persistentes invisibles para el sistema operativo
- instalar key-loggers para interceptar el teclado y capturar contraseñas y credenciales
- robar tokens de autenticación 2FA
- acceder a fotos, mensajes y documentos sensibles
- monitorizar permanentemente la actividad del usuario
- mantener el malware incluso después de reinstalar el sistema

**Secure Boot** existe precisamente para impedir que firmware no autorizado pueda ejecutarse durante el arranque. La cadena de confianza garantiza que cada componente del sistema haya sido verificado criptográficamente antes de transferirle el control.

# Definición de blob

En este artículo voy a llamar `blob` (*binary large object*) a cualquier componente binario que participa en el arranque de un dispositivo. Tenemos varios ejemplos:

- SPL
- bootloader
- kernel (Linux)
- device tree (DTB)
- initramfs

# Conceptos criptográficos

El **Secure Boot** está basado en cuatro conceptos criptográficos fundamentales que probablemente ya conozcas si sigues este blog. Te dejo referencias a cada uno para refrescar conceptos:

- [Hash criptográfico](/post/2024/huellas-digitales-fingerprints)
- [Criptografía asimétrica](/post/2024/criptografia-asimetrica)
- [Firma digital](/post/2024/firmas-digitales)
- [Criptografía simétrica](/post/2024/criptografia-simetrica)

## Hash criptográfico

Una función de HASH calcula un hash criptográfico de unos datos de entrada. Por ejemplo, si tomamos como entrada la imagen de un kernel, obtendremos como salida su hash asociado:

```
digest = HASH(kernel)
```

El `digest` calculado cambia completamente si se modifica cualquier bit del `blob`. Esto permite detectar cualquier manipulación realizada sobre el `blob` de entrada.

## Criptografía asimétrica

Depende de un par de claves relacionadas matemáticamente:

- K_PRI
- K_PUB

La clave privada (K_PRI) debe permanecer secreta. Se utiliza para firmar imágenes y nunca debe estar presente en el dispositivo final. Normalmente se almacena en un entorno protegido, por ejemplo un HSM o una maquina offline.

La clave pública (K_PUB) no es secreta. Puede distribuirse libremente y se utiliza para verificar las firmas digitales generadas con la clave privada correspondiente.

## Firma digital

### Generación

Una firma digital se genera combinando un hash criptográfico con la clave privada (K_PRI):

```
digest = HASH(blob)
signature = SIGN(K_PRI, digest)
```

Cuando el hash `digest` queda firmado digitalmente con la clave privada K_PRI, la integridad digital del `blob` queda protegida criptográficamente.

### Verificación

El verificador calcula localmente el hash del `blob` recibido:

```
local_digest = HASH(blob)
```

Después utiliza la clave pública (K_PUB) para verificar criptográficamente la firma:

```
VERIFY(K_PUB, signature, local_digest)
```

Las firmas digitales permiten comprobar la autenticidad y la integridad de los distintos `blobs` que participan en el arranque del sistema. Con ellas se comprueba que los datos fueron firmados por quien posee la clave privada correspondiente y posteriormente no fueron manipulados por nadie. El hash se usa para detectar cambios. Y la firma digital, para verificar la autenticidad del `blob`.

## Criptografía simétrica

La criptografía simétrica utiliza una única clave secreta K_SECRET para cifrar y descifrar información.

```
cipher = ENCRYPT(K_SECRET, blob)
blob = DECRYPT(K_SECRET, cipher)
```

Por tanto, solamente puede descifrar quien conoce la clave secreta K_SECRET con la que se ha cifrado el `blob`. Esta clave secreta debe permanecer protegida en todo momento. Si un atacante obtiene esa clave, podrá descifrar toda la información protegida con ella.

La criptografía simétrica impide que un atacante pueda leer el contenido de cualquier `blob`. Por tanto, esta capa añade confidencialidad al **Secure Boot**. Pero esta capa de confidencialidad en el modelo de **Secure Boot** es opcional. NO es obligatoria.

# Chain of Trust

El **Secure Boot** garantiza que solo software auténtico y no modificado se ejecute durante el proceso de arranque. Para ello basa todo su proceso de arranque en el concepto de cadena de confianza (*chain of trust*). La idea general es sencilla: cada etapa del arranque verifica criptográficamente la siguiente antes de transferirle el control. Una cadena típica podría ser esta:

![Secure Boot trust chain](/img/secure-boot-trust-chain.webp)

Ningún componente comienza su ejecución hasta que la etapa anterior verifique su firma digital (es auténtico y no ha sido modificado). Si la verificación de una etapa es correcta, el arranque continúa, y el proceso se repite en la siguiente etapa. Si alguna verificación falla, el sistema detiene el proceso de arranque y entra en un modo de recuperación controlado.

En este articulo veremos cómo se generan las claves, cómo se realizan esas verificaciones criptográficas, y cómo se construye esta cadena de confianza desde el propio hardware.

# Root of Trust

Toda cadena de confianza necesita un punto inicial que se considere confiable. En **Secure Boot**, la confianza de toda la cadena se ancla en una raíz de confianza (*root of trust*) almacenada en hardware, y por tanto inmutable (no se puede modificar).

## Memoria hardware programable

Muchas plataformas disponen de memoria programable irreversible. Esa memoria solo se puede escribir una vez, y su contenido queda permanente dentro del dispositivo. Los registros de esta memoria se conocen como eFuse o fusibles electrónicos. Se usan para almacenar información crítica de seguridad como:

- si **Secure Boot** está o no activado
- hash de las claves públicas autorizadas
- claves simétricas opcionales
- estado de ciclo de vida del dispositivo
- contadores anti-rollback
- bits de revocación de claves

# Preparar el entorno (build time)

## Generación de claves

Antes de fabricar o provisionar el producto, el fabricante genera un par de claves asimétricas:

- K_PRI
- K_PUB

Y, opcionalmente, una clave simétrica de la que hablaremos después:

- K_SECRET

Después, se calcula el hash de la clave pública:

```
pub_digest = HASH(K_PUB)
```

Ese hash se programa permanentemente en uno de los eFuses:

```
eFuse.kpub_hash = pub_digest
```

A partir de ese momento, el dispositivo tiene una referencia inmutable para verificar qué clave pública se considera legítima.

## Firmar los blobs

Conceptualmente, por cada `blob` se calcula su firma digital:

```
digest = HASH(blob)
signature = SIGN(K_PRI, digest)
```

Este proceso se realiza:

- O bien al finalizar la compilación de cada `blob`
- O bien durante la generación de la release (una vez finalizada la compilación de todos ellos)

El resultado final deja de ser únicamente el `blob` binario y pasa a ser una imagen firmada llamada `signed_image`, compuesta por tres componentes:

- `blob`
- signature
- K_PUB

Estos tres componentes se almacenan en la memoria del dispositivo embedded. Lo importante aquí es que deben ser accesibles para la etapa que realice la verificación. Eso no supone un problema de seguridad porque la clave pública (K_PUB) no es secreta.

## Encriptar las imágenes firmadas

Como un paso opcional, el fabricante podría encriptar la imagen firmada `signed_image` con la clave secreta (K_SECRET):

```
encrypted_blob = ENCRYPT(K_SECRET, signed_image)
```

El resultado `encrypted_blob` es un `blob` cifrado cuyo contenido no puede leerse sin conocer la clave secreta correspondiente.

# Proceso de arranque (boot time)

La CPU ejecuta primero la BootROM. La BootROM está integrada físicamente dentro del SoC y reside en memoria ROM interna, por lo que no puede modificarse mediante software convencional. Por este motivo constituye la raíz inicial de confianza (Root of Trust) del sistema.

En sistemas Linux embedded, la BootROM junto con cierta configuración hardware persistente forman el punto inicial de confianza del arranque. Además, la BootROM es la primera etapa encargada de verificar criptográficamente el siguiente componente del boot.

Durante las primeras fases del arranque, la BootROM lee información almacenada en los eFuses para determinar distintos parámetros del dispositivo, entre ellos el medio principal de almacenamiento externo (SPI, MMC, NAND, NOR, SD, etc). A continuación inicializa el controlador correspondiente y comienza la carga del firmware externo.

## Lectura de la imagen firmada

La BootROM comienza la carga de la primera etapa de firmware externo. Lee los tres componentes de la primera imagen firmada:

- `blob`
- signature
- K_PUB_recibida

## Verificación de la clave pública

A partir de la clave pública leída `K_PUB_recibida`, la BootROM calcula su hash:

```
digest_calculado = HASH(K_PUB_recibida)
```

Y compara `digest_calculado` con el hash programado en el eFuse hardware:

```
digest_calculado == eFuse.kpub_hash
```

Si no coincide, no podemos confiar en la clave publica recibida `K_PUB_recibida`. El proceso de arranque se aborta.

Si coincide, esa clave pública se considera una clave publica autorizada.

## Autenticidad e integridad

Una vez autorizada la clave publica `K_PUB_recibida`, el sistema verifica la firma digital del `blob`:

```
digest = HASH(blob)
VERIFY(K_PUB_recibida, signature, digest)
```

Si la firma no es válida, el sistema debe rechazarlo. Y el proceso se detiene. En cambio, si es válida, el `blob` se considera auténtico e íntegro y puede ejecutarse. Esa nueva etapa repite el mismo proceso para el siguiente componente del arranque.

La clave pública utilizada para verificar la firma `K_PUB_recibida` acompaña a la propia imagen. Por ello, el sistema necesita una raíz de confianza hardware que permita determinar si esa clave pública recibida es realmente la legítima. En caso contrario, un atacante podría:

- generar su propio par de claves
- modificar el `blob`
- firmarlo con su clave privada
- e incluir su propia clave pública

La firma seguiría siendo matemáticamente válida, pero el pero el sistema estaría confiando en una clave elegida por el atacante.

Para evitarlo, el dispositivo almacena en hardware seguro (por ejemplo, en un eFuse) una referencia confiable de la clave pública autorizada. Normalmente se guarda un hash de dicha clave.

## Confidencialidad (opcional)

Las firmas digitales garantizan autenticidad e integridad, pero no garantizan confidencialidad.

Un sistema puede utilizar **Secure Boot** sin cifrar el firmware. En ese caso, aunque un atacante no pueda modificar los `blobs` sin invalidar la firma, sí podría leer su contenido si obtiene acceso físico al almacenamiento.

Para evitarlo, algunas plataformas añaden una capa adicional de cifrado simétrico:

```
encrypted_blob = ENCRYPT(K_SECRET, signed_image)
```

Durante el arranque, la etapa previa recupera K_SECRET, descifra la imagen y continúa el proceso normal de verificación:

```
signed_image = DECRYPT(K_SECRET, encrypted_blob)
```

A partir de ese momento:

- se valida la clave pública
- se verifica la firma digital
- y finalmente se ejecuta el `blob`

La clave secreta K_SECRET debe permanecer protegida dentro del dispositivo, por lo que suele almacenarse en hardware especializado como TPMs, Secure Elements o enclaves criptográficos. Un ejemplo de este enfoque es el chip Titan M2 utilizado en los dispositivos Pixel, diseñado para proteger claves sensibles y participar en el proceso de Verified Boot del sistema.

Es importante entender que comprometer K_SECRET no rompe el modelo de **Secure Boot**. Un atacante podría descifrar el firmware y leer su contenido, pero seguiría sin poder modificarlo sin disponer de la clave privada de firma K_PRI, que nunca se almacena en el dispositivo.

# Aceleradores criptográficos

Muchas plataformas modernas integran hardware criptográfico dedicado para ejecutar operaciones sensibles de forma aislada del sistema operativo general. Estos chips de seguridad suelen implementar primitivas como:

- SHA
- RSA
- ECC
- AES
- generación de números aleatorios
- almacenamiento y gestión protegida de claves

Su objetivo es acelerar operaciones criptográficas, reducir exposición de material sensible, impedir que ciertas claves abandonen el hardware seguro y aumentar resistencia frente a ataques físicos y lógicos.

Un ejemplo conocido es el chip Titan M2 utilizado en los dispositivos Pixel, que actúa como elemento de seguridad dedicado y participa en tareas relacionadas con **Secure Boot**, protección de claves y verificación de integridad del sistema.

La existencia de este hardware no cambia el modelo conceptual del **Secure Boot**, pero sí proporciona un entorno más robusto y aislado para ejecutar operaciones criptográficas críticas.

# Conclusión

En este articulo hemos visto como **Secure Boot** define literalmente en qué software puede confiar un dispositivo desde el primer ciclo de reloj después del encendido. Toda la seguridad posterior depende de esta cadena de confianza inicial.

Si un atacante consigue comprometer el proceso de arranque, podrá ejecutar código antes incluso de que el kernel o el sistema operativo comiencen a funcionar. Por eso **Secure Boot** no es únicamente un mecanismo de verificación de firmas. Es una arquitectura completa de confianza basada en criptografía, hardware seguro y validaciones encadenadas.

¿Te ha gustado el articulo? No dejes de suscribirte al [Canal de Telegram](https://t.me/lateclaescape) para ser el primero en enterarte de las próximas publicaciones. Muchas gracias por leerme y nos vemos en el próximo articulo.

Pulso la tecla `ESC:wq!`
