#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="./imagenesRam/uno.lime"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu_5_4_0-148-generic_profilex64"

RUTA_VOLATILITY="."

VOLATITLITY_RESULTS="resultadosVolatility"

# Verificar si Volatility está instalado
if ! command -v $RUTA_VOLATILITY python2.7 vol.py &> /dev/null
then
    color_rojo="\033[91m"
    color_normal="\033[0m"
    echo -e "${color_rojo}Volatility no está instalado. Por favor, instale Volatility 2.6 antes de continuar.${color_normal}"
    exit
fi

# Comprueba si la imagen de RAM y la ruta de Volatility existen
if [ ! -f "$RAM_IMAGE" ]; then
  color_rojo="\033[91m"
  color_normal="\033[0m"
  echo -e "${color_rojo}El archivo de volcado de memoria no existe. Por favor, proporcione un archivo válido.${color_normal}"
  exit 1
fi

# Verificar si el perfil de LinuxUbuntu_5_4_0-148-generic_profilex está instalado
if ! python2.7 vol.py --info | grep -q "LinuxUbuntu_5_4_0-148-generic_profilex64"
then
    color_rojo="\033[91m"
    color_normal="\033[0m"
    echo -e "${color_rojo}El perfil de LinuxUbuntu_5_4_0-148-generic_profilex64 no está instalado. Por favor, instale el perfil antes de continuar.${color_normal}"
    exit
fi

# Crear un directorio para guardar los archivos de salida
if [ ! -d "$VOLATITLITY_RESULTS" ]
then
    mkdir -p $VOLATITLITY_RESULTS
fi

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"                 # Muestra una lista de todos los procesos en ejecución en la imagen de memoria de Linux.
  "linux_psaux"                  # Proporciona una lista detallada de procesos en ejecución, incluyendo los argumentos de línea de comandos utilizados para iniciar cada proceso.
  "linux_pstree"                 # Genera un árbol de procesos que muestra las relaciones jerárquicas entre los procesos en ejecución.
  "linux_netstat"                # Muestra información sobre las conexiones de red activas en la imagen de memoria.
  "linux_pswview"                # Proporciona una visualización de los procesos en ejecución y los puertos asociados.
  "linux_bash"                   # Identifica los comandos ejecutados en la shell de Bash en el sistema.
  "linux_lsmod"                  # Enumera los módulos del kernel cargados en el sistema.
  "linux_mount"                  # Muestra información sobre los sistemas de archivos montados en el sistema.
  "linux_find_file"              # Permite buscar archivos específicos en la imagen de memoria.
  "linux_proc_maps"              # Muestra el mapa de memoria de un proceso específico en la imagen de memoria.
  "linux_dump_map"               # Extrae una región de memoria específica de la imagen y la guarda en un archivo.
  "linux_cpuinfo"                # Muestra información sobre el procesador y su configuración.
  "linux_lsof"                   # Lista los archivos abiertos por los procesos en ejecución.
  "linux_lsof | grep -i /home/ubunt"  # Filtra los archivos abiertos que pertenecen al directorio /home/ubunt.
  "linux_bash_env"               # Muestra las variables de entorno establecidas en la shell de Bash.
  "linux_dynamic_env"            # Muestra las variables de entorno modificadas durante la ejecución de los procesos.
  "linux_psenv"                  # Muestra las variables de entorno establecidas para cada proceso en ejecución.
  "linux_arp"                    # Muestra la tabla de caché de resolución de direcciones (ARP) del sistema.
  "linux_ifconfig"               # Muestra la configuración de las interfaces de red.
  "linux_route_cache"            # Muestra la caché de enrutamiento del sistema.
  "linux_tmpfs -L"               # Muestra información sobre los sistemas de archivos de tipo tmpfs montados en el sistema.
  "linux_dmesg"                  # Muestra los mensajes del kernel capturados por dmesg.
  "linux_find_file"              # Permite buscar archivos específicos en el sistema.
)

# Crea un directorio para guardar los resultados
if [ ! -d "VOLATITLITY_RESULTS" ]; then mkdir -p $VOLATITLITY_RESULTS; fi


# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  color_azul="\033[94m"
  color_normal="\033[0m"
  echo -e "${color_azul}Ejecutando: $cmd${color_normal}"
  resultado=$(python2.7 vol.py -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd")
  salida=$(echo "$resultado" | grep --color=auto "$cmd\|<palabra clave>")
  echo "$resultado" | tee -a "$RUTA_VOLATILITY/$VOLATITLITY_RESULTS/output_$cmd.txt"
  echo -e "${color_azul}Resultado guardado en: $RUTA_VOLATILITY/$VOLATITLITY_RESULTS/output_$cmd.txt${color_normal}"
  echo ""

  read -p "¿Desea filtrar el archivo txt generado? (s/n): " respuesta
  if [[ $respuesta == "s" || $respuesta == "S" ]]; then
    read -p "Ingrese las palabras para filtrar (separadas por comas): " palabras
    IFS=',' read -ra palabras_array <<< "$palabras"
    grep_pattern=$(IFS='|'; echo "${palabras_array[*]}")
    echp $grep_pattern
    salida_filtrada=$(grep -E "$grep_pattern" "$VOLATITLITY_RESULTS/output_$cmd.txt")
    echo $salida_filtrada
    echo "$salida_filtrada" > "$VOLATITLITY_RESULTS/filtrado_output_$cmd.txt"
    echo -e "${color_azul}Resultado filtrado guardado en: $VOLATITLITY_RESULTS/filtrado_output_$cmd.txt${color_normal}"
    echo ""
  fi
done

# Generar un informe HTML
read -p -e "¿Desea generar un informe HTML con los resultados? (s/n) " respuesta
if [ "$respuesta" == "s" ]
then
    echo -e "${color_azul}Generando informe HTML...${color_normal}"
   python3 GenerarInforme.sh ./$VOLATITLITY_RESULTS/
fi





# Preguntar si se desea filtrar los archivos de salida por una palabra clave
read -p "¿Desea filtrar los archivos de salida por una palabra clave? (s/n) " respuesta

if [ "$respuesta" == "s" ]
then
    # Pedir la palabra clave a buscar
    read -p "Por favor, introduzca la palabra clave: " palabra_clave

    # Filtrar los archivos de salida por la palabra clave y guardar la salida en un archivo
    echo -e "${color_azul}Resultados de la búsqueda:${color_normal}"
    grep -r "$palabra_clave" "$RUTA_VOLATILITY/$VOLATITLITY_RESULTS/*.txt" | tee filtrado.txt
fi



echo -e "${color_azul}Análisis de Volatility completado.${color_normal}"
