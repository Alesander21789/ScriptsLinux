
dokcer pull ubuntu # para descargar la iamgen sin hacer el run
docker images # para ver las imagenes que hay descargadas
docker run ubuntu # crear un contenedor con una iamgen
docker ps -a # ver contenedores isntalados
docker ps # ver contenedoires corriendo
docker ps --help # ayuda del comando
docker ps -l # ultimo contenedor que se ha echo una opearación
docker ps -n 4 # ver los ultimos cuatro coentenedores arrancados
docker ps -a -q #mustra los id de los contenedores isntalados
docker ps -a -s # mustra el tamaño de los contenedores isntaldos
docker run --name ubuntu1 ubuntu # crea un contenedor que se llama ubuntu1
#dos formas de tener un contenedor funcionando, en modo interactivo y background
docker run --name ubuntu2 -it ubuntu # esto seria modo interactivo, a veces despues hay que poner bhas
docker stop ubuntu4 # para cerrar un contenedos activo con nombre ubuntu4
docker start ubuntu4 # para arrancarlo
docker start  -i ubuntu4 # pàra entrar en el bash
docker run -d --name ngix nginx # inciia en background el contenedor
docker run --name fedora2 -d -it fedora # para obligar al modo background a maquinas que no pueden con -d porque no estan preparadas
docker run --name apache2 -d httpd:alpine # para bajarme una versión concreta
docker rm ade2 # para eliminar un contenedor solo hace falta los cuatro primeros digitos del identificador 
docker rmi feb5 # para eliminar una imagen
docker  exec ubuntu2 date #ejecutar un comando en el contenedor
docker exec -it ubuntu2 bash # esto me permite entrar en el conetenedor
docker attach ubuntu4 # veo lo que esta saliendo en la maquina
docker run -d ubuntu sh -c "while true; do date; done"
# del rpoceso en segundo plano anteriro con el comando dokcer logs y su id voy sanncado por pantalla todo loq ue esta haciendo la maquina en segundo plano
docker logs b9ca # pudeo filtrar con tail, grep etc
docker kill b9ca # para matar un proceso en segudno plano
docker top uguntuBash # permite ver el rpoceso que más esta consumiendo en el contenedor
docker stats uguntuBash # nos permite ver información sobre ese contenedor
docker inspect e2a4 # para ver la informacion del contenedor
docker system df # da informacion sobre el numero de contenedores, imagenes...
docker system prune # borra contenedores, imagenes , redes , cache que no se esten utilizando
docker cp docker.sh uguntuBash:/tmp #para copìar un fichero un contenedor
docker run --name ubuntuVariable -d -it -e V1=20 ubuntu # para enviar una variable
docker run -it -d --rm --name ubuntuVariables -e V1=10 -e V2="ALESANDER" ubuntu bas. # con --rm cuando acabe se borra
docker run --name maria -d -e MARIADB_ROOT_PASSWORD=abc123.  mariadb # para configurar el root de mariadb
docker exec -it maria bash # ejecuto el bash en maria db
docker run --name apache1 -d -p 8080:80 httpd #redireciono el puerto 80 de la maquina al 8080 del anfitrion
docker exec -it apache1 bash # para conectarme a esa maquina
docker run --name en2 -d -P 80:80 nginx # genera de forma automita un puerto para el conetendor
docker network ls # muestra las redes de docker
docker inspect en2 | grep IPA # INSPECCINO LA MAQUINA Y FILTRO LA RED
docker network inspect bridge # inspecciono la red de tipo bridge
docker port en2 # mustra los puertos de un contenedordocker image inspect nginx

 


docker image inspect nginx # mira los datos de una image, asi puedo ver los puertos que usadokcer
dokcer network create red1 # creo una red bride, en esta red no como en la bridge por defecto todos los puertos estan expuetos, en el otro caso no 
docker network create --subnet=192.168.1.0/24  red2 # creo una red en esta subred de modo bridege
docker run -it --name ubujntuRed --network red2 ubuntu bash #asociar el conetendor a una red
docker network connect red2 ubuntua # conecta el contenedor ubuntua  a la red2






Existen varias formas de crear volúmenes en Docker, aquí te presento tres ejemplos:

Usando la opción -v al momento de ejecutar un contenedor:
Copy code
docker run -d -p 8080:80 -v /path/to/local/directory:/var/www/html nginx
En este ejemplo, estamos montando el directorio /path/to/local/directory en el contenedor en la ruta /var/www/html y ejecutando un servidor web Nginx en el contenedor.

Usando el comando docker volume create:
Copy code
docker volume create my-data-volume
En este ejemplo, estamos creando un volumen llamado my-data-volume que luego puede ser montado en un contenedor utilizando la opción --mount.

Usando la opción --mount al momento de ejecutar un contenedor:
Copy code
docker run -d --mount source=my-data-volume,target=/var/www/html nginx
En este ejemplo, estamos montando el volumen my-data-volume en el contenedor en la ruta /var/www/html y ejecutando un servidor web Nginx en el contenedor.




Existen tres tipos de persistencia en Docker: volúmenes, directorios compartidos del host y Union File System (UFS). A continuación se describen cada uno con más detalle y ejemplos:

Volúmenes: Los volúmenes son espacios de almacenamiento independientes de los contenedores que se pueden compartir entre ellos y que sobreviven al cierre o eliminación de los contenedores. Los volúmenes se crean y administran utilizando el comando docker volume. Por ejemplo, para crear un volumen llamado "my-data-volume":
Copy code
docker volume create my-data-volume
Para montar un volumen en un contenedor se usa la opción --mount al momento de ejecutar el contenedor:

Copy code
docker run -d --mount source=my-data-volume,target=/var/www/html nginx
En este ejemplo, estamos montando el volumen "my-data-volume" en el contenedor en la ruta /var/www/html y ejecutando un servidor web Nginx en el contenedor.

Directorios compartidos del host: Esta opción permite compartir un directorio del sistema operativo host con un contenedor. El directorio compartido se monta en el contenedor como un volumen, pero los cambios realizados en el contenedor también se reflejan en el host y viceversa. Es posible compartir un directorio del host con un contenedor utilizando la opción -v al momento de ejecutar el contenedor:
Copy code
docker run -d -p 8080:80 -v /path/to/local/directory:/var/www/html nginx
En este ejemplo, estamos montando el directorio /path/to/local/directory en el contenedor en la ruta /var/www/html y ejecutando un servidor web Nginx en el contenedor.

Union File System (UFS): Es un sistema de archivos que permite montar varios directorios o volúmenes en un solo punto de montaje, creando una jerarquía de archivos. UFS se utiliza para crear un sistema de archivos a partir de varios volúmenes, permitiendo que los cambios realizados en un volumen no afecten a los demás. Es posible crear un sistema de archivos UFS utilizando el comando docker run con la opción --mount.
Copy code
docker run -d --mount source=my-data-volume,target=/var/www/html --mount source=my-logs-volume,target=/var/log/nginx nginx
En este ejemplo, estamos montando dos volúmenes "my-data-volume" y "my-logs-volume" en el contenedor en las r


Dockerfile




FROM ubuntu
RUN apt-get update &&  apt-get install -y python && apt-install -y git && apt-get install -y iputils-ping
CMD echo "wellcome a this container"

RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt

ENTRYPOINT ["ping","-c","3"]
CMD ["localhost"]




FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \ && apt-get install -y >

##WORKDIR## 
RUN mdkdir /datos
WORKDIR /datos
ROUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

COPY index.html .
COPY app.log /datos

ENTRYPOINT ["/bin/bash"]



#EL comando COPY copia un fichero, ale comando ADD, ADD docs doc, copia un idrectorio y ADD f* /datos/ copia todos loar archivos que empiecen por f, podemos traernos algo de una url


RUN mdkdir /datos
WORKDIR /datos
ROUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

COPY index.html .
COPY app.log /datos


##ENV##

##Asi no se pueden cambiar
ENV dir=/data dir1=/data1

RUN mkdir $dir && mkdir $dir1

##Asi se pueden cambiar
ENV TEXTO="AAAAAA"
CMD echo $TEXTO

ENTRYPOINT ["/bin/bash"]



docker run -it --rm --name a --env x=10 ubuntu # cuando salgamos lo borra


CMD ["echo", "wellcome to this container"] ## Esto se hace sin usar una shell si lo pusiere sin los corchetes si que ejecutaria eso en una shell


##Copio un script le doy permisos, pos último lo ejecuto en una shell con el comando CMD sin los corchetes para que ejecute una shell si o si

ADD lanzar.sh
RUN chmod +x /datos/datos1/lanzar.sh
CMD /datos1/lanzar.sh

##arg es similar a env, la diferencia es que no tengo que ponerle un valor, nos permite pasar variables en el momento de cosntruir la iamgen##
ARG dir2
RUN mkdir dir2

docker build -i image:v6 --build-arg dir2=/data2



###EXPOSE permite exponer puertos ##

RUN apt-get install -y apache2
EXPOSE 80

##volume##

ADD paginas /var/www/html
VOLUME ["/var/www/html"]

docker run -it --rm -p 9020:80 --volumes-from c1 --name c2 image:v6 ##uso el volumen ya creado de la otra áquina para compartirlo




##Si seleccionamos otra versión de Ubuntu o de Postgres, puede que
##tengamos que modificar el fichero para adaptarlo
FROM ubuntu
LABEL "Creador"="Apasoft Training apasoft.training@gmail.com"

##Actualizamos
RUN apt-get update

##Instalamos WGET para el repositorio
RUN apt-get install -y wget

##Instalamos lsb-release para conocer la relesase del ubuntu
RUN apt-get install -y lsb-release

##Instalamos gpg2 para descargar la clave GPG
RUN apt-get install -y gnupg2


##Instalamos tzdata, porque Ubuntu ahora la pide de forma interactiva
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

##Configuramos el repositorio

RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list


## Descargamos la clave
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc|apt-key add -

##Actualizamos el sistema
RUN apt-get update


##Instalamos Postgres
RUN apt-get -y install postgresql-12


##Nos cambiamos al usuario postgres, que se ha creado
##al instalar postgreSQL
USER postgres



##Creamos un usuario denominado “pguser” con password
##”secret” y creamos una base de datos llamada “pgdb”
RUN /etc/init.d/postgresql start \
&& psql --command "CREATE USER pguser WITH SUPERUSER PASSWORD 'secret';" \
&& createdb -O pguser pgdb






##Nos cambiamos a usuario ROOT
USER root



##Permitimos que se puede acceder a PostgreSQL
##desde clientes remotos
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/12/main/pg_hba.conf




##PErmitimos que se pueda acceder por cualquier

##IP que tenga el contenedor
RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

##Exponemos el Puerto de la Base de Datos
EXPOSE 5432


##Creamos un directorio en /var/run y le damos permisos
##para el usuario postgres
RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
##Creamos los volúmenes necesarios para guardar
##el backup de la configuración, logs y bases de datos
##y poder acceder desde fuera del contenedor
VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
##Nos cambiamos al usuario postgres
USER postgres
##Indicamos el comando a ejecutar al crear el contenedor
##Básicamente arrancar posrtgres con la configuración
##adecuada
CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]



docker build -t trainingdock/postgres:v1 .


docker run -d --name postgres1 --network net1 trainingdock/postgres:v1



docker ps




