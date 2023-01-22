
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





