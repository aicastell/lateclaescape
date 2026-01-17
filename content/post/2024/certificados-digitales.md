---
title: Los certificados digitales
date: 2024-03-23
image: "/img/posts/digital-certificate.webp"
categories: [ "criptografía" ]
tags: [ "certificado_digital", "certificate_request", "autoridad_certificadora", "clave_de_sesión", "mitm" ]
draft: false
featured: true
---

# Motivación

La seguridad de las comunicaciones electrónicas es de vital importancia en el mundo digital que nos rodea.

En artículos anteriores hemos intentado resolver sin éxito el temido ataque Man In The Middle (MITM). Lo hemos intentado usando usando [criptografía simétrica](/post/2024/criptografia-simetrica), [criptografía asimétrica](/post/2024/criptografia-asimetrica), e incluso [firmas digitales](/post/2024/firmas-digitales). Pero ningún mecanismo por si solo ha demostrado ser eficaz.

En este artículo abordamos de nuevo este desafío. De entrada ya te adelanto que esta vez si vamos a parar los pies al temido ciberdelincuente. Acompáñame en la lectura de este articulo y aprenderás como hacerlo.

## Autoridades certificadoras (CA)

En la vida real, cuando desconfías de alguien, ¿que haces?. Correcto, preguntas referencias a algún amigo que sea de tu máxima confianza. Pues bien, en las comunicaciones digitales el problema del ataque MITM se resuelve mas o menos igual.

Ante la falta de confianza en la fuente de información, buscamos una fuente de confianza externa que actúe como tercero para certificar la identidad de todos los involucrados en la comunicación, ya sea el emisor o el receptor, antes de iniciar las comunicaciones. A esta fuente de confianza externa se la conoce como **Autoridad Certificadora** (CA). Estas son algunas de las CA más reconocidas a nivel mundial:

- [Identrust](https://www.identrust.com/)
- [Digicert](https://www.digicert.com/)
- [Globalsign](https://www.globalsign.com/)
- [Sectigo](https://www.sectigo.com/)
- [Let's Encrypt](https://letsencrypt.org/)

Hago mención especial a **Let's Encrypt**. Fundada en 2016, es una iniciativa sin ánimo de lucro respaldada por varias organizaciones importantes en el campo de la seguridad informática:

- [Electronic Frontier Foundation](https://www.eff.org/es) (EFF)
- [Fundación Mozilla](https://foundation.mozilla.org)
- [OVH](https://www.ovhcloud.com)
- [Akamai](https://www.akamai.com)
- [Cisco Systems](https://www.cisco.com/)
- [Linux Foundation](https://www.linuxfoundation.org/)

Aunque es relativamente reciente, ha ganado popularidad rápidamente al ofrecer un proceso gratuito y completamente automatizado para certificar la identidad de un sitio web. El sitio web de [lateclaescape](http://www.lateclaescape.com) está certificado por Let's Encrypt.

## Certificate Request (CR)

Veamos ahora como se realiza la certificación de la identidad de los participantes involucrados en la comunicación digital.

Cada participante involucrado en la comunicación digital debe crear un **Certificate Request** (CR) y enviarlo a la Autoridad Certificadora (CA).

El CR es un documento electrónico compuesto por tres secciones:

```
Certificate_Request {
    "Identidad",
    "Clave Publica",
    "Firma Digital"
}
```

La "Identidad" contiene información sobre la identidad del titular. Se puede incluir la identidad de sitios web, de servidores, de dispositivos, de personas físicas (individuos) o de personas jurídicas (empresas). Dependiendo del titular certificado, se incluirá información como su nombre, su dirección de correo electrónico, la URL de su sitio web, o el nombre de la empresa.

La "Clave Publica" contiene la [clave publica asimétrica](/post/2024/criptografia-asimetrica) asociada al titular del CR.

La "Firma Digital" es una [firma digital](/post/2024/firma-digital) de todo el CR, realizada por el propio titular usando su clave privada. Esta firma digital solo puede verificarse con la clave pública incluida en la segunda sección.

El CR se envía a la CA. Cuando la CA recibe el CR, debe verificar toda la información que contiene.

Para validar la identidad del titular, es posible que la CA solicite documentación adicional como el DNI, el pasaporte o las escrituras de la sociedad.

Para validar que la clave publica pertenece realmente al titular, la CA utiliza la "Clave pública" incluida en el CR para verificar la "Firma digital" del propio CR. Si lo logra, considera que la firma digital es válida y por tanto el CR es auténtico. Por tanto, la CA esta segura que el CR no ha sido alterado desde que se firmó digitalmente.

## Certificados digitales

Una vez verificada toda la información del CR, la CA genera un **Digital Certificate** (DC) y se lo envía al titular.

El DC es un documento electrónico compuesto por 4 secciones:

```
Digital_Certificate {
    "Identidad"
    "Clave Publica"
    "Firma Digital"
    "Periodo de Validez"
}
```

La "Identidad" contiene información sobre la identidad del titular. Es la misma información contenida en la misma sección del CR.

La "Clave Publica" contiene la [clave publica asimétrica](/post/2024/criptografia-asimetrica) asociada a la identidad del titular. Es la misma información contenida en la misma sección del CR.

La "Firma Digital" es una [firma digital](/post/2024/firma-digital) de todo el documento DC realizada por la CA con su propia clave privada. Esta firma digital es el componente esencial de todo este mecanismo, ya que garantiza la autenticidad y la integridad del DC emitido por la CA.

El "Periodo de Validez" es un periodo de validez durante el cual el DC será valido, incluyendo una fecha de inicio y de final. Después del vencimiento, los DC deben ser renovados o reemplazados.

## Ejemplo

Veamos como Bob y Alice pueden tener una comunicación segura sin posibilidad de un ataque MITM utilizando certificados digitales firmados por una autoridad certificadora confianza.

### Generación de claves

Alice genera un par de claves asimétricas en su PC:

- K_PUB_ALICE
- K_PRI_ALICE

Y Bob hace lo mismo en su PC:

- K_PUB_BOB
- K_PRI_BOB

### Solicitud de certificado

Alice crea un Certificate Request CR_ALICE en el que incluye su identidad, su clave publica y la firma digital de este documento:

```
CR_ALICE {
    ALICE,
    K_PUB_ALICE,
    CR_DISIGN_ALICE
}
```

Bob crea un Certificate Request CR_BOB en el que incluye su identidad, su clave publica y la firma digital de este documento:

```
CR_BOB {
    BOB,
    K_PUB_BOB,
    CR_DISIGN_BOB
}
```


Alice envía el documento CR_ALICE a la Autoridad Certificadora IdenTrust. Y Bob envía el documento CR_BOB a la Autoridad Certificadora CertiGo.

### Verificación de la identidad

IdenTrust verifica la identidad de Alice según la información proporcionada en CR_ALICE. Tras un proceso exhaustivo de revisión de los datos incluidos en el CR_ALICE, IdenTrust da por buenos los datos de Alice.

CertiGo hace exactamente lo mismo con Bob. Verifica la identidad de Bob según la información proporcionada en CR_BOB. Tras un proceso exhaustivo de revisión de los datos incluidos en el CR_BOB, CertiGo da por buenos los datos de Bob.

### Generación de los certificados digitales

IdenTrust genera un certificado digital para Alice (DC_ALICE). Le asigna un periodo de validez (PERIOD_ALICE), y lo firma digitalmente con su propia clave privada (K_PRI_IDENTRUST), generando la firma digital DC_DISIGN_IDENTRUST.

```
DC_ALICE {
    ALICE,
    K_PUB_ALICE,
    DC_DISIGN_IDENTRUST,
    PERIOD_ALICE
}
```

CertiGo genera un certificado digital para Bob (DC_BOB). Le asigna un periodo de validez (PERIOD_BOB), y lo firma digitalmente con su propia clave privada (K_PRI_CERTIGO), generando la firma digital DC_DISIGN_CERTIGO.

```
DC_BOB {
    BOB,
    K_PUB_BOB,
    DC_DISIGN_CERTIGO,
    PERIOD_BOB
}
```

### Distribución de certificados firmados

IdenTrust le envía el certificado digital DC_ALICE a Alice. Y CertiGo le envía el certificado digital DC_BOB a Bob.

Cuando Alice recibe su certificado digital DC_ALICE, puede verificar la firma digital DC_DISIGN_IDENTRUST con la clave publica de IdenTrust (K_PUB_IDENTRUST) para confirmar que es el certificado que ha firmado IdenTrust y por tanto es auténtico.

Cuando Bob recibe su certificado digital DC_BOB, puede verificar la firma digital DC_DISIGN_CERTIGO, con la clave publica de CertiGo (K_PUB_CERTIGO) para confirmar que es el certificado que ha firmado CertiGo y por tanto es auténtico.

Alice almacena DC_ALICE en su dispositivo, junto con la clave privada K_PRI_ALICE que mantiene en secreto. De igual modo, Bob almacena DC_BOB en su dispositivo, junto con la clave privada K_PRI_BOB que también mantiene en secreto.

### Intercambio de certificados digitales

Bob envía su certificado digital DC_BOB a Alice. Y Alice envía su certificado digital DC_ALICE a Bob.

Alice verifica la autenticidad del certificado de Bob utilizando la clave publica de Certigo. Esto garantiza que Alice esté realmente comunicándose con Bob y no con un atacante.

Bob verifica la autenticidad del certificado de Alice utilizando la clave publica de IdentTrust. Esto garantiza que Bob esté realmente comunicándose con Alice y no con un atacante.

Una vez intercambiados los certificados, ambos están preparados para establecer un canal de comunicación seguro.

### La clave de sesión

Bob genera SK, una [clave simétrica](/post/2024/criptografia-simetrica) de gran importancia, bautizada como **clave de sesión**.

Bob encripta la clave de sesión SK utilizando la clave pública de Alice (K_PUB_ALICE). Esta clave pública la ha obtenido del certificado digital de Alice (DC_ALICE).

```
ASYM_ENCRYPT(K_PUB_ALICE, SK) = ME
```

Bob envía ME, es decir, la clave de sesión SK encriptada, a Alice. Como está encriptada con la clave pública de Alice, solo ella puede desencriptarla utilizando su clave privada correspondiente.

Alice recibe ME, la clave de sesión encriptada, y la desencripta utilizando su clave privada correspondiente (K_PRI_ALICE).

```
ASYM_DECRYPT(K_PRI_ALICE, ME) = SK
```

Ahora Alice ya tiene la misma clave de sesión SK que Bob ha generado.

### Inicio comunicaciones seguras

Con la clave de sesión SK compartida de forma segura entre Bob y Alice, ambos pueden encriptar y desencriptar los mensajes intercambiados en sus comunicaciones privadas sin miedo alguno a ser interceptados por un ciberdelincuente.

Fijaros como el ataque MITM se ha evitado cuando ambos extremos de la comunicación han podido verificar cuidadosamente la identidad del otro extremo, y han logrado compartir una clave simétrica SK de forma segura.

A partir de ese momento, las comunicaciones se encriptan/desencriptan utilizando la clave de sesión SK, lo que implica el uso de criptografía simétrica, mucho mas rápida que la criptografía asimétrica. La velocidad es un factor crucial, especialmente al intercambiar mensajes de gran tamaño.

## Despedida

En este artículo hemos explorado el funcionamiento de los certificados digitales, su importancia en la seguridad informática, y los beneficios que ofrecen tanto a personas físicas como jurídicas, en la protección de sus activos digitales y en la mitigación de riesgos en un entorno cada vez más conectado y hostil.

Por fin hemos logrado que Alice y Bob puedan establecer un canal de comunicaciones seguro, sin temor al temible ataque MITM. Sus comunicaciones ahora si cumplen los tres principios básicos de la seguridad informática: confidencialidad, autenticidad e integridad.

Mas adelante aprenderemos a usar la librería criptográfica OpenSSL para abordar todos los temas tratados en esta serie de artículos sobre seguridad informática desde un punto de vista mucho mas práctico.

De momento ya tienes las bases matemáticas y criptográficas necesarias para poder afrontar retos mucho mas interesantes. Es hora de empezar a hablar sobre criptomonedas. Pero no como hacen los *criptobros*, sino como hacemos los ingenieros.

Nos vemos muy pronto.

Pulso la tecla `ESC:wq!`
