## --------  English  --------

It is important to make a backup before doing anything else in order to be able to restore the device if necessary. There are no recovery images for this device available online, therefore you will only be able to solve any problem derived from this procedure by restoring the backup that you should have made in the first place.

[Backup whole flash](BackupFlash.md)

### Unlocking bootloader

We need MTKClient (which we already have installed and running). Run this command to delete these partitions:

	python mtk e metadata,userdata,md_udc

Connect device with volume + pressed and wait for it to finish. Once done, run this other command:

	python mtk da seccfg unlock
	
Followed by:

	python mtk reset
	
Disconnect the device, wait for a few seconds and reconnect it. Mi logo will show along with a text indicating that the device is in "Orange State". Bootloader is now unlocked.


### Installing system

Disconnect device from PC, and press three upper buttons to reconnect it. After 5 seconds release the mute button and leave the other two buttons pressed until the text "No command" shows on the screen.
Press mute and volume + buttons several times until the usual recovery menu appears. Select "Reboot to bootloader".

Once in fastboot mode, execute the following commands:

	fastboot flash boot boot.img
	fastboot flash super super.img
	fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
	fastboot reboot
	
boot.img file must be the original boot.img file modified as described at the end of the [guide for working with GSI](WorkingWithGSI.md).
super.img file must be the result of our previous work.
vbmeta.img file is located in the MTKClient root folder as vbmeta.img.empty.

Once the reboot command has been executed, we must wait a few minutes for the system to boot. Depending on many factors it may take longer, so it is advisable to be patient.




## --------  Spanish  --------

Para instalar sistemas o imágenes custom debemos seguir el siguiente proceso. Es importante realizar una copia de seguridad previamente para poder restaurar el dispositivo en caso de necesidad. No hay disponibles online imágenes de recuperación del dispositivo, por lo tanto sólo podrás resolver cualquier problema derivado de este procedimiento restaurando la copia de seguridad que debes haber realizado en primera instancia.

[Hacer copia de la flash completa](BackupFlash.md)


### Desbloquear el bootloader

Necesitamos MTKClient (que ya tenemos instalado y funcionando). Ejecutamos este comando para borrar estas particiones:

	python mtk e metadata,userdata,md_udc

Conectamos el dispositivo con el volumen + presionado y esperamos a que termine. Una vez hecho, ejecutamos este otro comando:

	python mtk da seccfg unlock
	
Seguido de:

	python mtk reset
	
Desconectamos el dispositivo, esperamos unos segundos y volvemos a conectarlo. Aparecerá el logo de Mi junto con un texto indicando que el dispositivo está en "Orange State". Ya tenemos desbloqueado el bootloader.


### Instalar el sistema

Desconectamos el dispositivo del PC, y presionando los tres botones superiores lo volvemos a conectar. Pasados 5 segundos soltamos el boton de mute y dejamos los otros dos pulsados hasta que aparezca el texto "Sin comandos" en pantalla.
Presionamos mute y volumen + varias veces hasta que aparezca el menú habitual de recovery. Seleccionamos "Reboot to bootloader".

Una vez en modo fastboot ejecutamos los siguientes comandos:

	fastboot flash boot boot.img
	fastboot flash super super.img
	fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
	fastboot reboot

El archivo boot.img debe ser el boot.img original modificado tal y como se describe al final de la [guía para trabajar con GSI](WorkingWithGSI.md)
El archivo super.img debe ser el resultado de nuestro trabajo previo.
El archivo vbmeta.img se encuentra en la carpeta raíz de MTKClient como vbmeta.img.empty

Una vez ejecutado el comando de reboot debemos esperar unos minutos a que el sistema arranque. Dependiendo de múltiples factores puede alargarse, así que conviene ser pacientes.
