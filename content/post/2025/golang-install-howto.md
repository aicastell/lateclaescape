---
title: Instalación de Go
date: 2025-07-18
image: /img/posts/golang-install-howto.webp
categories: [ "programming_language" ]
tags: [ "golang", "howto" ]
draft: false
featured: true
---

# Introducción

Go es un lenguaje que ha calado entre desarrolladores que buscan simplicidad, rendimiento y concurrencia sin complicaciones. En el artículo anterior hice una introducción al [lenguaje Go](/post/2025/golang-language). Hablé sobre sus principios de diseño y las razones por las que Go se ha convertido en una opción atractiva para proyectos de backend, microservicios o herramientas de línea de comandos.

Este articulo explica cómo instalar Go en Linux para que puedas empezar a compilar tus propios proyectos. La instalación de Go es sorprendentemente sencilla, tal y como veras. Es un articulo muy básico pero necesario para los que nunca habéis instalado este lenguaje.

# Instalación de Go

Para instalar la versión mas nueva de Go debes seguir estos pasos:

Usando tu navegador favorito, ves a esta pagina [https://go.dev/dl/](https://go.dev/dl/) y localiza la última versión disponible para tu arquitectura y para tu sistema operativo. En mi caso, voy a instalar Go para un PC con arquitectura X86_64, en Linux. La ultima versión disponible hasta la fecha es la 1.24.5. Por tanto, debo descargar el archivo go1.24.5.linux-amd64.tar.gz:

```
$ cd ~/Descargas
$ wget https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
```

A continuación, descomprime el archivo descargado en el directorio /usr/local, utilizado en Linux para almacenar software instalado manualmente, como será este caso.

```
$ sudo tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz
```

El comando anterior instala todos los ficheros necesarios del compilador de Go. El binario del compilador se llama "go".

# Configuración del entorno

Cuando ejecutas el comando "go" en la terminal, tu sistema probablemente no lo encontrará:

```
$ go
bash: go: No such file or directory
```

Este error ocurre porque el terminal busca el binario "go" en una lista de directorios definida por la variable de entorno PATH. Pero el binario "go" se ha instalado en el directorio /usr/local/go/bin, un directorio que no está en la lista de directorios definidos por PATH.

Para solucionar este problema, añade el directorio /usr/local/go/bin a la variable de entorno PATH:

```
$ export PATH=$PATH:/usr/local/go/bin
```

Este comando export solo afecta a la sesión actual de tu terminal. Cuando cierres la sesión actual, o cuando abras una sesión nueva, el PATH volverá a su valor por defecto, que no incluye este directorio /usr/local/go/bin.

Para hacer este cambio persistente en cualquier sesión, debes añadir esa línea al archivo de configuración de bash:

```
$ echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
```

Luego, recarga la configuración para que se aplica en la sesión actual:

```
$ source ~/.bashrc
```

A partir de aquí ya tendrás la variable PATH siempre definida en cualquier terminal que abras.

# Verificación

Ahora ya puedes ejecutar el comando "go" desde cualquier directorio:

```
$ go version
go version go1.24.5 linux/amd64
```

Enhorabuena, ya tienes Go instalado en tu ordenador.

# Despedida

Si te ha picado el gusanillo de Go, esto no ha hecho más que empezar. Mas adelante publicaré una serie de artículos prácticos donde me meteré de lleno en proyectos reales. Aprenderás a domar Go como un auténtico profesional. Si te interesa este contenido, no dudes en comentarlo en el [canal de Telegram](https://t.me/lateclaescape), en la medida de mis posibilidades, intentaré priorizar los temas que generen un mayor interés.

De momento toca volver a Hugo. En el próximo artículo utilizaré Go para [compilar el framework Hugo](/post/2025/hugo-install-howto) desde cero. Será el primer paso que necesitas para construir un blog como éste. Así que no te lo pierdas. Prepara tu terminal... ¡y nos vemos en el siguiente artículo!

Pulso la tecla `ESC:wq!`
