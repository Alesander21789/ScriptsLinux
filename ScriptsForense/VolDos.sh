#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  volatility -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "output_$cmd.txt"
  echo "Resultado guardado en: output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."




#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  volatility -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "output_$cmd.txt"
  echo "Resultado guardado en: output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."




#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con la ruta a tu instalación de Volatility
VOLATILITY_PATH="path/to/volatility"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comprueba si la imagen de RAM y la ruta de Volatility existen
if [ ! -f "$RAM_IMAGE" ]; then
  echo "Error: No se encuentra la imagen de RAM en la ruta especificada."
  exit 1
fi

if [ ! -f "$VOLATILITY_PATH" ]; then
  echo "Error: No se encuentra Volatility en la ruta especificada."
  exit 1
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
mkdir -p volatility_results

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  $VOLATILITY_PATH -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "volatility_results/output_$cmd.txt"
  echo "Resultado guardado en: volatility_results/output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."
