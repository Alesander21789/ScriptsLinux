sudo fdisk -l //para ver los discos
sudo mount -t ext4 -o rw /dev/sdb1 /media/sdba/ //para montar el disco de virtualbox
sudo ewfmount /media/sdba/ImagenUbuntu20.E01 /media/evidencia/ //para montar el disco efw
sudo mmls /media/evidencia/ewf1 //para ver los tamaños de las particiones
 sudo file  /media/evidencia/ewf1 // para ver si el disco esta dañado
 sudo blkid /media/evidencia/ewf1 //para ver el sistema de archivos
 La herramienta fsstat de 
sleuthkit sirve para 
comprobar un sistema de 
ficheros
– La opción -o indica el offset 
donde está el sistema de 
ficheros
• Columna “start” del 
comado mmls
 sudo losetup -rf -o  $((512 * 0000002048)) /media/evidencia/ewf1 //para crear el loop

 loop -a //para verlo
 sudo mount -o ro,noexec,noload /dev/loop0 /home/parrot/montado //para finalizar y montarlo
