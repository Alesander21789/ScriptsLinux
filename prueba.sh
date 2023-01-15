#!/bin/bash

echo "ejecucion ./nombre_del_script.sh <image_file> <main_folder> <profile>"
#guarda la ruta de Volatility en una variable
volatility_path="/home/kali/Programas/volatility/vol.py"

#Comprobar si los parámetros son correctos
if [ $# -ne 3 ]; then
    echo "Error: La cantidad de parametros es incorrecta"
    echo "Uso: $0 <image_file> <main_folder> <profile>"
    exit 1
fi

# asigna valor a las variables a partir de los parametros
image_file=$1
main_folder=$2
profile=$3

#Valida si la ruta de la imagen de memoria existe
if [ ! -f $image_file ]; then
    echo "Error: La ruta de la imagen de memoria no es valida"
    exit 1
fi

#Valida si el perfil especificado existe y es valido
valid_profiles=("WinXPSP2x86" "Win7SP1x86" "Win7SP1x64" "Win10x64_19041")
if [[ ! " ${valid_profiles[@]} " =~ " ${profile} " ]]; then
    echo "Error: El perfil especificado no es valido"
    exit 1
fi

#Pide al usuario cuantos comandos desea filtrar
echo "Cuantos comandos desea filtrar (0-12)"
read num_comandos

#Valida si el numero de comandos es correcto
if [ $num_comandos -lt 0 ] || [ $num_comandos -gt 12 ]; then
    echo "Error: El numero de comandos debe estar entre 0 y 12"
    exit 1
fi

#Arreglo con los nombres de los comandos
comandos=("pslist" "connscan" "dlllist" "hivelist" "sockets" "pstree" "syscalls" "connections" "netscan" "filescan" "handles" "imageinfo")

#Arreglo para almacenar el texto de filtro de cada comando
texto_filtro=()

#Pide al usuario el texto de filtro para cada comando
for (( i=1; i<=$num_comandos; i++ ))
do
    echo "Ingrese el texto de filtro para el comando ${comandos[i-1]}"
    read texto
    texto_filtro[$i]=$texto
done


#Crea la carpeta principal si no existe
mkdir -p $main_folder

# Crea las carpetas para guardar la información
mkdir -p $main_folder/procesos $main_folder/red $main_folder/dlls $main_folder/registro $main_folder/sockets $main_folder/hilos $main_folder/llamadas_al_sistema $main_folder/conexiones_red $main_folder/escaneo_red $main_folder/archivos $main_folder/manejadores $main_folder/particiones





echo "$(tput setaf 2)Extrayendo información de la tabla de procesos$(tput setaf 4)"

if [ ${texto_filtro[1]} ]; then  
python2.7 $volatility_path -f $image_file --profile=$profile pslist | grep ${texto_filtro[1]} > $main_folder/procesos/pslist.txt

echo "pslist terminado"

	else 

python2.7 $volatility_path -f $image_file --profile=$profile pslist > $main_folder/procesos/pslist.txt

echo "$(tput setaf 1)pslist terminado$(tput setaf 7)"

fi 





echo "$(tput setaf 2)Extrayendo información de las conexiones de red$(tput setaf 4)"

if [ ${texto_filtro[2]} ]; then 

python2.7 $volatility_path -f $image_file --profile=$profile connscan | grep ${texto_filtro[2]} > $main_folder/red/connscan.txt

	else
	
 python2.7 $volatility_path -f $image_file --profile=$profile connscan > $main_folder/red/connscan.txt
 
 echo "$(tput setaf 2)pslist terminado$(tput setaf 7)"

fi





echo "Extrayendo información de las dlls cargadas"

if [ ${texto_filtro[3]} ]; then

python2.7 $volatility_path -f $image_file --profile=$profile dlllist | grep ${texto_filtro[3]} > $main_folder/dlls/dlllist.txt

	else
	
python2.7 $volatility_path -f $image_file --profile=$profile dlllist > $main_folder/dlls/dlllist.txt

fi





echo "Extrayendo información de las claves del registro"

if [ ${texto_filtro[4]} ]; then 


python2.7 $volatility_path -f $image_file --profile=$profile hivelist | grep ${texto_filtro[4]} > $main_folder/registro/hivelist.txt

	else
	
python2.7 $volatility_path -f $image_file --profile=$profile hivelist > $main_folder/registro/hivelist.txt

	
fi



echo "Extrayendo información de los procesos de sockets"

if [ ${texto_filtro[5]} ]; then


python2.7 $volatility_path -f $image_file --profile=$profile sockets | grep ${texto_filtro[5]} > $main_folder/sockets/sockets.txt

	else

python2.7 $volatility_path -f $image_file --profile=$profile sockets > $main_folder/sockets/sockets.txt


fi




echo "Extrayendo información de los procesos de hilos"


if [ ${texto_filtro[6]} ]; then

python2.7 $volatility_path -f $image_file --profile=$profile pstree | grep ${texto_filtro[6]} > $main_folder/hilos/pstree.txt

	else
	
python2.7 $volatility_path -f $image_file --profile=$profile pstree  $main_folder/hilos/pstree.txt	

fi



echo "Extrayendo información de las llamadas al sistema"
python2.7 $volatility_path -f $image_file --profile=$profile syscalls | grep ${texto_filtro[7]} > $main_folder/llamadas_al_sistema/syscalls.txt

echo "Extrayendo información de las conexiones a la red"
python2.7 $volatility_path -f $image_file --profile=$profile connections | grep ${texto_filtro[8]} > $main_folder/conexiones_red/connections.txt

echo "Extrayendo información de las conexiones a la red"
python2.7 $volatility_path -f $image_file --profile=$profile netscan | grep ${texto_filtro[9]} > $main_folder/escaneo_red/netscan.txt

echo "Escanear Archivos"
$python2.7 volatility_path -f $image_file --profile=$profile filescan | grep ${texto_filtro[10]} > $main_folder/archivos/filescan.txt


echo "Extrayendo información de los manejadores"
python2.7 $volatility_path -f $image_file --profile=$profile handles | grep ${texto_filtro[11]} > $main_folder/manejadores/handles.txt

echo "Extrayendo información de las particiones"
python2.7 $volatility_path -f $image_file --profile=$profile imageinfo | grep ${texto_filtro[12]} > $main_folder/particiones/imageinfo.txt




#Ejecuta los comandos restantes sin filtrar si no se especifico un filtro
for (( i=$num_comandos+1; i<=12; i++ ))
do
    if [ -z ${texto_filtro[i]} ]; then
        echo "Extrayendo información de ${comandos[i-1]}"
        $volatility_path -f $image_file --profile=$profile ${comandos[i-1]} > $main_folder/${comandos[i-1]}/${comandos[i-1]}.txt
    else
        echo "Extrayendo información de ${comandos[i-1]} con filtro: ${texto_filtro[i]}"
       python2.7  $volatility_path -f $image_file --profile=$profile ${comandos[i-1]} | grep ${texto_filtro[i]} > $main_folder/${comandos[i-1]}/${comandos[i-1]}.txt
    fi
done

echo "Proceso finalizado"


