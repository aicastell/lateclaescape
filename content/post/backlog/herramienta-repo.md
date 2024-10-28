---
title: La herramienta repo
date: 2024-01-19
image: "/img/posts/coding.webp"
categories: ["tools"]
tags: ["decimal", "hexadecimal", "ascii", "binario", "base64", "base58" ]
draft: true
featured: true
---




 La herramienta repo
Introducción

Hoy vamos a hablar sobre la gestión de proyectos grandes. Y cuando digo grandes, me refiero a proyectos realmente grandes. Si os parece bien usaremos el proyecto Android como ejemplo de partida.

El proyecto Android está compuesto por muchos repositorios Git diferentes almacenados en servidores deslocalizados y repartidos por todo el mundo. Y cuando digo muchos, me refiero a una cantidad enorme (y casi insana) de repositorios Git diferentes. Cada repositorio Git esta formado por un conjunto de ficheros fuente y documentación, y almacena un historico de los cambios realizados en cada fichero por los desarrolladores que aportan código a ese repositorio. Estos desarrolladores residen en distintas ciudades del mundo y la mayoría ni siquiera se conocen entre ellos en persona. Esto es Android señor@s. Pensad en ello cada ves que cojáis el móvil. Yo cada día me sigo preguntando como es posible que todo esto funcione tan bien xDD.

Usar varios repositorios Git diferentes para aislar cada componente del proyecto es una buena practica, incuestionable hoy en día, ya que reduce la complejidad del proyecto, facilita el trabajo colaborativo entre distintos desarrolladores, y en general mejora la organización del proyecto. Sin embargo, gestionar tantos repositorios diferentes puede suponer un esfuerzo titánico para la persona encargada de hacer ese trabajo.

Imagina que eres la persona encargada de mantener el proyecto Android, compuesto por mas de 700 repositorios Git (si 700, has leído bien). Tras un tiempo de desarrollo, llega el momento de publicar la primera Release Candidate (RC.1) del proyecto. Publicas la RC.1. Pero el desarrollo continúa, los repositorios evolucionan con nuevas funcionalidades, llegan nuevos commit, se crean nuevas ramas, algunas se fusionan, aparecen nuevos repositorios, etc. Pasado un tiempo, alguien detecta un bug en la RC.1. Necesitas volver a la situación del proyecto en el momento de publicar la RC.1 para hacer el bugfix. ¿Como vas a recordar el conjunto de repositorios git de que estaba compuesto el proyecto en el momento de publicar la RC.1? ¿En qué commit se encontraba cada repositorio en el momento de hacer la RC.1? ¿Como volvemos a la situación de la RC.1 para poder corregir el bug? ¿Y como regresamos a la situación actual después de viajar al pasado?

Si piensas en resolver esto de manera manual, la respuesta es que si, efectivamente es posible hacerlo. Sin embargo, sería un trabajo monstruoso, propenso a errores, costoso, doloroso y suficientemente aburrido como para pedir una baja por depresión. Los ingenieros necesitamos solucionar estos problemas de manera mas eficiente y automatizada. No nos gusta hacer trabajos aburridos, repetitivos y de manera manual. Aunque es posible que tengas algo de experiencia con Git y pienses en los submodulos para resolver este problema. No, no sigas por esta vía. He sufrido los submodulos de Git para intentar hacer estas cosas y no, no funcionan todo lo bien que deberían. Son un continuo dolor de cabeza que en el peor de los casos pueden terminar por hacerte perder parte de tu trabajo. Personalmente no os recomiendo usar submodulos de Git para esta cuestión.

Para resolver todos estos problemas Google desarrolla su propia herramienta, a la que llama "repo", en un intento de centralizar la gestión de todos los repositorios de los que esta compuesto un proyecto grande de forma sencilla y ágil. Es un script escrito en Python que funciona a modo de wrapper de la herramienta Git. De acuerdo, a mi no me hagáis caso. Pero si Google decide no usar submodulos de Git para gestionar los repositorios del proyecto Android, por algo será.
Funcionamiento de repo

repo utiliza como entrada un fichero de texto en formato XML conocido como fichero de manifest. En el fichero de manifest se define una lista de los repositorios Git de los que está compuesto el proyecto, y la revisión (rama, o tag, o commit ID) en la que se encuentra cada uno de esos repositorios en el momento de hacer la foto del proyecto.

La persona encargada de gestionar el proyecto creará este fichero antes de publicar la RC. Para el caso que nos ocupa, crearía un fichero "default.xml" para la RC.1. Puesto que a lo largo del tiempo se generan distintas RC (en Android mas de 900 RC, tal y como veremos después), tendremos un montón de ficheros default.xml (uno por cada nueva release que se genere). Todos esos ficheros de manifest se deberían guardar en algún sitio seguro. La mejor manera de guardarlos será en un repositorio de ficheros de manifest que de ahora en adelante llamaremos manifest.git (aunque puedes llamarlo como prefieras). En ese repositorio usaremos una rama distinta por cada RC que se genere, en la que se guardará la versión particular del fichero default.xml para esa RC.

A grandes rasgos, esta es la manera en la que Google se encarga de gestionar el proyecto Android.
Instalación de repo

Empezamos instalando la herramienta repo. Hoy en día se puede instalar haciendo uso de los repositorios de paquetes oficiales de cualquier distribución de Linux basada en Ubuntu/Debian usando apt:

    $ sudo apt install repo

Inicialización del sandbox

Una vez instalada, puedes usar repo para inicializar tu sandbox de trabajo, descargando tu repositorio de ficheros de manifest:

     $ repo init -u <url-de-manifest.git> [-b <branch-name>] [-m manifest-name.xml] 

Por ejemplo, para inicializar un sandbox de trabajo para Android, haríamos lo siguiente:

    $ mkdir -p sandbox/android
    $ cd sandbox/android
    $ repo init -u https://android.googlesource.com/platform/manifest 

Se pueden usar algunos parámetros opcionales. El parámetro -b te permite indicar la rama del repositorio manifest que quieres descargar (la primera vez que lo descargas, seguramente no la sepas). El parámetro -m te permite indicar el nombre del fichero manifest que quieres usar, en caso de que hayas usado un nombre diferente al que se descarga por defecto (default.xml).

El comando anterior genera un fichero local .repo con información que debes conocer:

    $ ls -l .repo/
    total 12
    drwxrwxr-x 3 aicastell aicastell 4096 mar 9 11:50 manifests
    drwxrwxr-x 10 aicastell aicastell 4096 mar 9 11:50 manifests.git
    lrwxrwxrwx 1 aicastell aicastell 21 mar 9 11:50 manifest.xml -> manifests/default.xml
    drwxrwxr-x 7 aicastell aicastell 4096 mar 9 11:50 repo

Empezando por el final, el directorio repo/ es el repositorio Git donde se descarga la última versión del comando repo:

    $ cd .repo/repo/ 
    $ git remote -v 
    origin https://gerrit.googlesource.com/git-repo (fetch)
    origin https://gerrit.googlesource.com/git-repo (push)

Puede parecer absurdo descargar esta herramienta, ya que previamente ha sido instalada en el PC con el comando apt. Sin embargo, en realidad tiene su explicación. En este directorio se descarga la última versión disponible de la herramienta. Cuando repo se ejecuta, detecta que la versión descargada es mas nueva que la que se ejecuta, y te avisa para que la actualices con un simple comando "cp":

    ... A new repo command ( 1.25) is available.
    ... You should upgrade soon:
    cp /path/to/.repo/repo/repo /usr/bin/repo

El directorio manifests/ es el repositorio Git de ficheros manifest descargado localmente:

    $ cd .repo/manifests/
    $ git remote -v
    origin https://android.googlesource.com/platform/manifest (fetch)
    origin https://android.googlesource.com/platform/manifest (push) 

Husmeando un poco mas:

    $ git branch -r | wc -l
    980

vemos que a fecha de hoy 3 de Marzo de 2019, Android tiene ni mas ni menos que 980 ramas distintas. Es decir, 980 versiones distintas del fichero manifest. Vamos a situarnos en una rama en concreto del repositorio:

    $ git checkout android-9.0.0_r9 -b android-9.0.0_r9

Veamos el último commit de esa rama:

    $ git log -1
    commit d69a58cdccdfa187db6179693aa33474fa379a60 
    Author: The Android Open Source Project
    Date: Mon Oct 1 15:13:25 2018 -0700

        Manifest for Android 9.0.0 Release 9

Parece que la versión 9.0.0 fue lanzada el 1 de Octubre de 2018 sobre las 15:13:25, poco después de comer el mismo día que mi hermano cumplía 38 años! :)

Por último vemos que hay un symlink (o enlace simbólico) .repo/manifest.xml que siempre apuntará dentro del repositorio de ficheros manifest al fichero de manifest actualmente en uso, que como ya hemos dicho antes, por defecto se llama default.xml, pero puedes indicar otro diferente con el parámetro -m.
Sincronización de repo

Una vez tenemos decidido el fichero de manifest que queremos usar (apuntado por el symlink .repo/manifest.xml), lanzamos este comando:

    $ repo sync -j 4 -c

El comando repo sync actualiza en los directorios locales los repositorios remotos definidos en el fichero manifest actualmente en uso. Si el repositorio remoto todavía no existe en local, clonará un nuevo directorio desde el repositorio remoto, y configurará las ramas según lo especificado en el fichero manifest. Si el repositorio local ya existe, actualizará los cambios remotos y hará un rebase de cualquier cambio local sobre los nuevos cambios remotos descargados.

Este comando también tiene algunos parámetros opcionales. El parámetro "-j" especifica el numero de procesos concurrentes que se encargarán de hacer la descarga. Al ser opcional, si no lo especificas, por defecto el valor es 1. Si ajustas este valor al numero de procesadores de tu máquina, reducirás el tiempo de descarga considerablemente. Otro parámetro opcional interesante es el flag "-c". Hemos dicho que Android esta compuesto de cientos de repositorios Git, y por tanto cada uno tiene su propio histórico de ramas. La pregunta es, ¿realmente necesitamos hacer un git-clone de todas las ramas de cada repositorio que compone Android? Probablemente no. Aquí es donde el flag "-c" se vuelve útil. Con este flag, repo solo descargará la rama especificada en el manifest, no todas las ramas creadas en el servidor remoto. Esto nos ahorrará bastante espacio y también reducirá el tiempo total de la descarga.
El fichero manifest

Vamos ahora a analizar el formato interno del fichero manifest. El manifest del proyecto Android es bastante largo. Usamos un ejemplo recortado para facilitar su comprensión:

     $ cat default.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
      <remote name="aosp"   fetch="https://android.googlesource.com/"/>
      <remote name="udinic" fetch="https://github.com/udinic/"/>

      <default revision="android-9.0.0_r9" remote="aosp" sync-j="4" />

      <project path="art"                name="platform/art" />
      <project path="bionic"             name="platform/bionic" />
      <project path="tools/adt/eclipse"  name="platform/tools/adt/eclipse" />
      <project path="dalvik"             name="platform_dalvik"          remote="udinic"/>
      <project path="frameworks/base"    name="platform_frameworks_base" remote="udinic" />
    </manifest>

Como hemos dicho antes, vemos que se trata de un fichero XML que podemos editar y manipular.

Todo el contenido del fichero va metido dentro de un nodo del arbol XML llamado "manifest". Del nodo "manifest" cuelgan al principio una lista de nodos llamados "remote" que identifican los servidores Git que alojan los distintos repositorios del proyecto. El atributo "name" indica el nombre que damos a ese servidor para identificarlo dentro del fichero manifest. El atributo "fetch" indica la URL de la que se hará el clone. Puedes definir tantos nodos remote como necesites.

Después se define un nodo "default". En este nodo se indica un atributo "remote" que indica atributo "name" del nodo "remote" del que se van a hacer los clones de los repositorios. Y un atributo "revisión" que indica la revisión (la branch o el tag) por defecto.

A continuación se especifican una lista de nodos "project", uno por cada repositorio que debe descargarse. Nota personal: creo que la etiqueta "project" es una mala elección que lleva a confusión, no hablamos del proyecto (Android), hablamos de los repositorios que lo componen. Con el atributo opcional "remote" se indica el servidor donde está alojado el repositorio. Si no aparece, por defecto se usará el indicado en el nodo "default". Con el atributo "name" se indica el nombre del repositorio que vas a descargar. Por ejemplo, name="platform_frameworks_base" hace que el checkout se realice del repositorio https://github.com/udinic/platform_frameworks_base.git. Con el atributo "path" indicas el directorio local donde debes dejar lo descargado. Por ejemplo, si usas path=".", se creará un directorio local "platform_frameworks_base". Pero si usas path="temp", se creará un directorio local "temp/platform_frameworks_base".
Un ejemplo práctico

De acuerdo, no somos Google y no tenemos proyectos tan grandes entre manos. Pero igualmente podemos aprovechar lo aprendido hasta ahora para gestionar nuestros proyectos compuestos por dos o mas repositorios. Veamos un ejemplo práctico:

Imagina que trabajas en un proyecto compuesto por tres repositorios: repo1.git, repo2.git y repo3.git.

Lo primero que vas a necesitar es crear un repositorio adicional para el manifest (manifest.git), que contenga un fichero de manifest default.xml donde se especifique la lista de repositorios de los que consta el proyecto y otros datos como los servidores desde donde se hacen los checkouts, la rama que se descarga de cada repositorio, o el path local donde se guarda el repositorio descargado:

    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
        <remote name="github" fetch="https://github.com/aicastell" />
 
        <default revision="develop" remote="github" />
 
        <project path="src/repo1/" name="repo1.git" />
        <project path="src/repo2/" name="repo2.git" />
        <project path="src/repo3/" name="repo3.git" />
    </manifest>

Fíjate que hemos definido la revisión "develop" en el nodo "default" que afecta a todos los repositorios. No tendría por que ser así, podrías usar una revisión diferente en cada nodo project. Pero en este ejemplo lo vamos a hacer de esta manera, asumiendo que todos los repositorios repo.git tienen creada una rama "develop".

Una vez que hemos creado el repositorio de manifest, editado el fichero default.xml, guardado los cambios, commiteados y pusheados a la rama "master", usa este conjuro para descargar en tu sandbox local todos los repositorios bajo control de repo:

    $ cd sandbox
    $ repo init -u https://github.com/aicastell/manifest.git
    $ repo sync

Tras el repo sync vemos que los repositorios descargados no tienen nombre de rama asignado:

    $ cd repo1.git
    $ git branch
    * (no branch)

Sin embargo el commit ID al que apunta cada repositorio es el mismo que el apuntado por su rama "develop", por lo que haciendo un checkout resolvemos el problema:

    $ git checkout develop
    $ git branch
    develop

Estudia ahora el contenido del directorio sandbox:

    $ find *  -maxdepth 1 | sort
    src
    src/repo1
    src/repo2
    src/repo3

Vemos como efectivamente se han descargado los tres repositorios en el path indicado en los nodos project.

De ahora en adelante continúas tu trabajo en cada repositorio repo.git con tu workflow habitual, creando ramas y tags, haciendo commits, subiendo tus cambios con push, y de cuando en cuando haciendo una pull requests para fusionar unas ramas con otras.

El proyecto ha avanzado tanto que llega el momento de generar una nueva release candidate: la RC.2. El proceso a seguir sería el siguiente:

Primero sitúa todos los repositorios repo.git en la rama que quieres usar para inmortalizar el momento RC.2. Si esa rama se llama igual en todos ellos (en este ejemplo estamos usando "develop"), este comando facilita el trabajo:

    $ repo forall -c 'git checkout develop'

Una vez que todos los repositorios repo.git están apuntando a la rama "develop", procede a crear en todos ellos una nueva rama llamada "RC.2" usando este comando:

    $ repo forall -c 'git branch RC.2; git checkout RC.2; git push $REPO_REMOTE RC.2'

La variable de entorno REPO_REMOTE se rellena de forma automática con el nombre del repositorio por el que se itera, según lo indicado en el campo "name" de cada nodo project. Por tanto, ahora tenemos una nueva rama en todos los repositorios repo.git llamada "RC.2"

Llega el momento de anotar lo hecho en el fichero default.xml del proyecto manifest. Crea en el repositorio de manifest una nueva rama llamada "RC.2" y adapta el default.xml para que refleje la nueva realidad que acabamos de inmortalizar:

    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
        <remote name="github" fetch="https://github.com/aicastell" />
 
        <default revision="RC.2" remote="github" />
 
        <project path="src/repo1/" name="repo1.git" />
        <project path="src/repo2/" name="repo2.git" />
        <project path="src/repo3/" name="repo3.git" />
    </manifest>

El desarrollo del proyecto proseguirá. Pero si en algún momento deseas volver al estado de la RC.2, lo podrás hacer invocando este conjuto:

    $ cd sandbox
    $ repo init -u https://github.com/aicastell/manifest.git -b RC.2
    $ repo sync

Cierre del post

Espero que con esto quede mas o menos claro el funcionamiento de esta herramienta. Los que ya la conocíais hayáis aclarado un poco mas sobre su funcionamiento. Y los que no, le perdáis el miedo y os animéis a usarla a partir de ahora. Os espero en la próxima entrega. Let the source be with you. Hasta la próxima! :)
