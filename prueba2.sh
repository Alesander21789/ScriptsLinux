#!/bin/bash

echo "Fecha y hora de inicio: $(date +%d/%m/%Y\ %H:%M:%S)"
inicio=$(date +%s)





#Comprobacion de argumentos
if [ $# -lt 4 ]; then
    echo "Faltan argumentos. Uso: $0 <archivo_memoria> <carpeta_principal> <perfil_sistema> <comandos_elegidos>"
    exit 1
fi

#Asigna variables a los argumentos
image_file=$1
main_folder=$2
profile=$3
volatility_path=$4
comandos_elegidos=$5



#Comandos de Volatility
comandos=("pslist" "connscan" "dlllist" "hivelist" "sockets" "pstree" "syscalls" "connections" "netscan" "filescan" "handles" "imageinfo" "particiones")

#Crea la carpeta principal si no existe
if [ ! -d $main_folder ]; then
    mkdir $main_folder
fi

#Crea las carpetas para guardar la información
for comando in "${comandos[@]}"
do
    mkdir -p $main_folder/$comando
done


# color value black 0, red 1, green 2, yellow 3, blue 4, magenta 5, cyan 6, blanco 7

#Ejecuta los comandos elegidos
IFS=","
read -ra comandos_elegidos <<< "$comandos_elegidos"
for comando_elegido in "${comandos_elegidos[@]}"
do
    echo "$(tput setaf 1)Extrayendo información de $comando_elegido numero  $(tput setaf 4)"
    python2.7 $volatility_path -f $image_file --profile=$profile $comando_elegido > $main_folder/$comando_elegido/$comando_elegido.txt
    echo "$(tput setaf 1)Finalizado la extración de inormación del comando comando_elegido$(tput setaf 7)"
done


#Permite al usuario filtrar la información
echo "$(tput setaf 1)¿Desea filtrar alguna información? (s/n)$(tput setaf 4)"
read respuesta
if [ $respuesta == "s" ]
then
    echo "Indique el nombre del comando a filtrar y el texto a buscar separados por un espacio"
    echo "Ejemplo: filescan password"
    read filtro comando
    echo $filtro "filtro   "
    echo $comando "comando   "
 #   grep $texto_filtro $main_folder/${comandos[$comando_filtro]}/${comandos[$comando_filtro]}.txt > $main_folder/${comandos[$comando_filtro]}/filtrado_${comandos[$comando_filtro]}.txt
 grep $filtro $main_folder/$comando/$comando.txt > $main_folder/$comando/filtrado_$filtro-$comando.txt
fi

















final=$(date +%s)
diferencia=$((final-inicio))
echo "El script tardó $diferencia segundos en ejecutarse"
echo "Fecha y hora de fin: $(date +%d/%m/%Y\ %H:%M:%S)"
