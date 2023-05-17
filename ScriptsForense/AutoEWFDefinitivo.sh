#!/bin/bash

echo "Introduce la ruta donde está montada la imagen:"
read mounted_image_path

echo "Introduce el directorio de salida:"
read output_dir

echo "Introduce el nombre de user:"
read user

# Crear directorio de salida y subdirectorios

mkdir -p "${output_dir}/copia"
extraction_dir="${output_dir}/copia"

# Extraer logs, historiales de bash y zsh, configuración de red, archivos de users, grupos, contraseñas y sudoers
cp "${mounted_image_path}/var/log/"* "${extraction_dir/}/log"
cp "${mounted_image_path}/home/${user}/.bash_history" "${extraction_dir/}bash_history"
cp "${mounted_image_path}/home/${user}/.zsh_history" "${extraction_dir/}zsh_history"
cp "${mounted_image_path}/etc/network/interfaces" "${extraction_dir/}network_config"
cp "${mounted_image_path}/etc/passwd" "${extraction_dir/}users"
cp "${mounted_image_path}/etc/group" "${extraction_dir/}groups"
cp "${mounted_image_path}/etc/shadow" "${extraction_dir/}passwords"
cp "${mounted_image_path}/etc/sudoers" "${extraction_dir/}sudoers"

# Listar archivos modificados hace un día
echo "Archivos modificados hace un día:" > "${extraction_dir/}modified_files.txt"
find "${mounted_image_path}" -type f -mtime 1 >> "${extraction_dir/}modified_files.txt"

# Extraer información adicional para el análisis forense
cp "${mounted_image_path}/etc/fstab" "${extraction_dir/}fstab"
cp "${mounted_image_path}/etc/hosts" "${extraction_dir/}hosts"
cp "${mounted_image_path}/etc/crontab" "${extraction_dir/}crontab"
cp -r "${mounted_image_path}/etc/cron.d" "${extraction_dir/}cron.d"
cp -r "${mounted_image_path}/etc/cron.daily" "${extraction_dir/}cron.daily"
cp -r "${mounted_image_path}/etc/cron.hourly" "${extraction_dir/}cron.hourly"
cp -r "${mounted_image_path}/etc/cron.monthly" "${extraction_dir/}cron.monthly"
cp -r "${mounted_image_path}/etc/cron.weekly" "${extraction_dir/}cron.weekly"



# Recopilamos informaci�n del sistema
echo "Recopilando informaci�n del sistema..."
mkdir $extraction_dir/informacion-sistema
cat $mounted_image_path/etc/*release* >> $extraction_dir/informacion-sistema/sistema.txt
cat $mounted_image_path/proc/meminfo > $extraction_dir/informacion-sistema/memoria.txt
stat -c %w / > $extraction_dir/fecha-creacion.txt
sudo debugfs -R 'stat /lost+found' $mounted_image_path >$extraction_dir/informacion-sistema/lost.txt
zdump $mounted_image_path/etc/localtime > ·extraction_dir/localtime.txt

# Recuperamos registros de actividad del sistema
echo "Recuperando registros de actividad del sistema..."
mkdir $extraction_dir/registros-sistema
cp $mounted_image_path/var/log/auth.log $extraction_dir/registros-sistema/auth.log
cp $mounted_image_path/var/log/dmesg $extraction_dir/registros-sistema/dmesg.log
cp $mounted_image_path/var/log/kern.log $extraction_dir/registros-sistema/kern.log
cp $mounted_image_path/var/log/syslog $extraction_dir/registros-sistema/syslog.log
cp $mounted_image_path/var/log/lastlog $extraction_dir/registros-sistema/lastlog
last -i $mounted_image_path/var/log/wtmp >  $extraction_dir/registros-sistema/inicio_sesion.txt
last -if $mounted_image_path/var/log/wtmp >  $extraction_dir/registros-sistema/inicio_sesion.txt
lastb -i $mounted_image_path/var/log/btmp >  $extraction_dir/registros-sistema/inicio_sesion_fallido.txt
lastb -if $mounted_image_path/var/log/btmp >  $extraction_dir/registros-sistema/inicio_sesionfallido.txt

# Recuperamos archivos de configuraci�n importantes
echo "Recuperando archivos de configuraci�n..."
mkdir $extraction_dir/archivos-configuracion
cp $mounted_image_path/etc/fstab $extraction_dir/archivos-configuracion/fstab.txt
cp $mounted_image_path/etc/passwd $extraction_dir/archivos-configuracion/passwd.txt
cp $mounted_image_path/etc/shadow $extraction_dir/archivos-configuracion/shadow.txt
cp $mounted_image_path/etc/sudoers $extraction_dir/archivos-configuracion/sudoers.txt
cp $mounted_image_path/etc/sudoers.d $extraction_dir/archivos-configuracion/sudoers.d.txt
cp $mounted_image_path/etc/group $extraction_dir/archivos-configuracion/group.txt



# Recopilamos informaci�n del sistema de archivos

echo "Recopilando informaci�n del sistema de archivos..."
mkdir $extraction_dir/sitema-archivos
ls -la $mounted_image_path/home/$user/home > $extraction_dir/sitema-archivos/users.txt
find $mounted_image_path/home/$user -type f -name "*.log" -exec cp {} $extraction_dir/sitema-archivos/logs.txt \;
cat $mounted_image_path/etc/lsb-release > $extraction_dir/sitema-archivos/version.txt
cat $mounted_image_path/hostname > $extraction_dir/sistema-archivos/hostanme.txt



# Recuperamos archivos eliminados
#echo "Recuperando archivos eliminados..."
#mkdir $extraction_dir/archivos-eliminados
#sudo foremost -t all -i $mounted_image_path/media/$user -o $extraction_dir/archivos-eliminados


# Recuperamos contrase�as
echo "Recuperando contrase�as..."
sudo unshadow $mounted_image_path/media/$user/etc/passwd $mounted_image_path/home/$user/etc/shadow > $extraction_dir/passwd-shadow.txt
# Descifrar contrase�as con John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.tx $extraction_dir/passwd-shadow.txt

sudo john --wordlist=/usr/share/wordlists/rockyou.txt $mounted_image_path/home/$user/.ssh/authorized_keys
sudo john --wordlist=/usr/share/wordlists/rockyou.txt $mounted_image_path/var/lib/mysql/mysql/user.MYD
sudo john --wordlist=/usr/share/wordlists/rockyou.txt $mounted_image_path/var/lib/mysql/mysql/db.MYD 

# Recuperamos informaci�n de red
echo "Recuperando informaci�n de red..."
mkdir $extraction_dir/red
cat $mounted_image_path/etc/network/interfaces > $extraction_dir/interfaces.txt
cat $mounted_image_path/etc/sysconfig/network-scripts > $extraction_dir/red/network_scripts.txt
cat $mounted_image_path/etc/hosts > $extraction_dir/red/hosts.txt
cat $mounted_image_path/etc/resolv.conf > $extraction_dir/red/dns.txt
cat $mounted_image_path/etc/nsswitch.conf > $extraction_dir/red/orden_dns.txt
cat $mounted_image_path/var/lib/NetworkManager > $extraction_dir/red/dhcp.txt
cat $mounted_image_path/var/lib/dhclient >>  $extraction_dir/red/dhcp.txt
cat $mounted_image_path/var/lib/dhcp >>  $extraction_dir/red/dhcp.txt

#Fecha instalacion aproximada
echo "Recuperando informaci�n de red..."
mkdir $extraction_dir/instalacion
stat -c %w $mounted_image_path/lost+found  > /$extraction_dir/instalacion/instalacion.txt
sudo debugfs -R 'stat /lost+found' /dev/sda1 >> /$extraction_dir/instalacion/instalacion.txt
head $mounted_image_path/var/log/installer/syslog >>  /$extraction_dir/instalacion/instalacion.txt
cat $mounted_image_path/etc/localtime  >>  /$extraction_dir/instalacion/zonahoraria.txt

# Historial de comandos
echo "Historial de comandos ..."
mkdir $extraction_dir/historial-comandos
find $mounted_image_path/home -name ".bash_history" -exec cp --parents {} "$extraction_dir/historial-comandos/historial_comandos.txt" \;
find $mounted_image_path/home -name ".zsh_history" -exec cp --parents {} "$extraction_dir/historial-comandos/historial_comandos_dos.txt" \;
find $mounted_image_path/home -name ".bash_history" -exec cp --parents {} "$extraction_dir/historial-comandos/historial_comandos.txt" \;
find $mounted_image_path/home -name ".lesshst" -exec cp --parents {} "$extraction_dir/historial-comandos/less.txt" \;
find $mounted_image_path/home -name ".viminfo" -exec cp --parents {} "$extraction_dir/historial-comandos/vim.txt" \;


# Logs 
mkdir $extraction_dir/volvado_logs
find $mounted_image_path/ -name "*.log" -exec cp {} $extraction_dir/volvado_logs \;


# Archivos de configuraci�n
echo "Archivos de configuracion..."
mkdir $extraction_dir/historial-configuracion
find /mnt/image/etc -type f -name "*.conf" -o -name "*.cfg" -exec cp --parents {} "$extraction_dir/historial-configuracion/historial_configuracion.txt" \;

# Cron jobs
echo "Jobs..."
mkdir $extraction_dir/historial-cron
find $mounted_image_path/etc/cron* -type f -exec cp --parents {} "$extraction_dir/historial-cron/cron.txt" \;

# Servicios y demonios
echo "Servicios y demonios..."
mkdir $extraction_dir/services-demons
find $mounted_image_path/etc/systemd/system -type f -name "*.service" -exec cp --parents {} "$extraction_dir/services/services.txt-demons" \;

# Timestamp ficheros
echo "Timestamp ficheros......"
mkdir $extraction_dir/timestamp-ficheros


find $mounted_image_path/home -newer $mounted_image_path/ -printf "%p, %A+,%T+,%C+\n" > $extraction_dir/timestamp-ficheros/timestam.txt

#Buscar un fichero sudo find /home/parrot/montado/home/ -name gruyere.py
#Buscar grupos a los que pertenece un user grep <user> /home/parrot/montado/etc/group


#SSH
echo "SSH..."
mkdir $extraction_dir/ssh
cp $mounted_image_path/home/$user/.ssh/known_hosts  $extraction_dir/ssh/known_hosts

cp $mounted_image_path/home/$user/.ssh/config  $extraction_dir/ssh/config

#MRU
mkdir ·extraction_dir/mru
cp $mounted_image_path/home/$user/.local/share/recently-used.xbel > $extraction_dir/mru/


#Papelear
mkdir $extraction_dir/papelera
cp $mounted_image_path/home/$user/.local/share/Trash/info > $extraction_dir/papelera/
cp $mounted_image_path/home/$user/.local/share/Trash/files  > $extraction_dir/papelera/

echo "Extracción completada. Los archivos extraídos se encuentran en ${extraction_dir/}"
