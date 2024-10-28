---
title: La herramienta openssl
date: 2023-12-27
image: "/img/posts/la-tecla-esc.jpg"
categories: ["criptografía", "tools"]
tags: ["openssl"]
draft: true
featured: true
---

## Ejemplo avanzado de criptografia simetrica

Veamos un ejemplo mas avanzado solo apto para software developers.

En Linux tenemos la librería criptográfica *libopenssl* y una herramienta llamada *openssl* para interactuar con dicha librería. Vamos a repetir los pasos usando estas herramientas. Como algoritmo simétrico usaremos AES-CBC-256.

Bob y Alice se ven en persona, generan una clave en un fichero *clave.txt* que comparten para sus comunicaciones futuras:

```
$ openssl rand -base64 32 > clave.txt
```

Un buen día por la mañana, Alice quiere mandar un mensaje secreto a Bob. Alice genera un mensaje en el fichero *mensaje.txt*:

```
$ echo "Nos vemos mañana en el cine" > mensaje.txt
```

Alice encripta el contenido del fichero *mensaje.txt* con la función de encriptado simétrico AES-CBC-256, usando la *clave.txt* que comparte con Bob:

```
$ openssl enc -aes-256-cbc -in mensaje.txt -out mensaje_encriptado.enc -pass file:clave.txt
```

Alice envía el fichero *mensaje_encriptado.enc* a Bob.

Cuando Bob recibe el mensaje encriptado, utiliza la función de desencriptado simétrico AES-CBC-256, usando la misma clave *clave.txt* para desencriptarlo:

```
$ openssl enc -d -aes-256-cbc -in mensaje_encriptado.enc -out mensaje_desencriptado.txt -pass file:clave.txt
```

Y por fin Bob puede ver el contenido del mensaje que le ha mandado Alice, contenido en el fichero *mensaje_desencriptado.txt*:

```
$ cat mensaje_desencriptado.txt
Nos vemos mañana en el cine
```

Bob acaba de ver el mensaje original que le ha enviado Alice. Nadie mas que Alice y Bob conocen el contenido de ese mensaje, porque son los únicos que tienen el fichero *clave.txt*.







## Ejemplo avanzado de criptografia asimetrica

Veamos un ejemplo mas avanzado solo apto para software developers.

En Linux tenemos la librería criptográfica libopenssl y una herramienta llamada openssl para interactuar con dicha librería. Vamos a repetir los pasos usando estas herramientas. Como algoritmo asimétrico usaremos RSA.

Bob genera en el ordenador de su casa una clave privada RSA, y guarda esta clave en el fichero *private_key.pem*. Este fichero debe guardarlo celosamente.

```
openssl genpkey -algorithm RSA -out private_key.pem
```

A partir de la clave privada RSA, genera su clave publica, y la guarda en el fichero *public_key.pem*:

```
openssl rsa -pubout -in private_key.pem -out public_key.pem
```

Bob envía un mensaje por Whatsapp a Alice en el que comparte con ella su clave publica contenida en el fichero *public_key.pem*:

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
echo "La semana que viene viajo de nuevo a tu pais" > mensaje.txt
```

Alice utiliza la función de encriptación asimétrica RSA, usando la clave pública de Bob almacenada en *public_key.pem* para encriptar el mensaje M:

```
openssl rsautl -encrypt -pubin -inkey public_key.pem -in mensaje.txt -out mensaje_encriptado.enc
```

Alice envía a Bob el mensaje encriptado, almacenado en el fichero *mensaje_encriptado.enc*.

Cuando Bob recibe el mensaje encriptado, utiliza la función de desencriptación asimétrica RSA junto con su clave privada para desencriptarlo:

```
openssl rsautl -decrypt -inkey private_key.pem -in mensaje_encriptado.enc -out mensaje_desencriptado.txt
```

Finalmente, Bob puede visualizar el contenido del mensaje que le ha enviado Alice, el cual está contenido en el fichero mensaje_desencriptado.txt

```
$ cat mensaje_desencriptado.txt
La semana que viene viajo de nuevo a tu pais
```

Bob ha podido ver el mensaje original que le ha enviado Alice. Nadie mas que Alice y Bob conocen el contenido de dicho mensaje. Alice lo conoce porque lo ha generado, mientras que Bob lo conoce porque es la única persona que posee la clave privada con la que se puede desencriptar cualquier mensaje encriptado con su clave publica. La clave privada de Bob nunca ha sido compartida por Internet. Sigue almacenada de forma segura en su propio ordenador.


