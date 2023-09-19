## --------  English  --------

It is possible to install GSI ROMs on Mi Smart Clock thanks to the fact that it is based on Android 10, leading to compatibility with the Treble project that enables this functionality. However there are two limitations that, although they do not detract from the functionality, must be taken into account:

1.- To install a GSI image on the device you have to insert it previously in a "super" image, due to the fact that the product, system and vendor logical partitions are not exposed through fastboot, either in bootloader or fastbootd.

2.- Because the precompiled SELinux policies are very restrictive, GSI ROMs do not boot with SELinux enabled. In order to use them we must disable this feature (as we don't have a better solution yet).

### Unpacking super for GSI

Steps are similar to those we followed previously with stock ROM, and in fact we need the result of that work (one of the NEW_super.img files we have verified is working properly) as a base to get a GSI ROM installed.

We will use the "unpack_gsi_super.sh" script, contained in the tools folder.

This script, if used in conjunction with a "super.img" like the one we generated with the previous guide, will delete the product and system images, leaving only vendor.img and this same file mounted in "mnt/vendor".
Because the GSI images have a larger size than the one originally intended for the logical partition system, it is necessary to get rid of product, which we will not need anyway, to make space.
Similarly, system.img is deleted as it contains the system we want to replace, and will not serve any function in this case.

If instead we use it together with a super.img that has already been prepared containing a GSI image, it will mount the system and vendor partitions inside "mnt" to work normally with them.

### Creating super for GSI

If when unpacking our super image we have run out of system.img file, it means that the super image has not yet been modified to contain a GSI image. Therefore we must manually copy the GSI image we have chosen renamed to "system.img", so that after running the unpacking script and copying this file we will find vendor.img, "mnt/vendor" mounted and system.img.

If on the other hand system.img exists and is mounted in "mnt/system", the super image we are using was already correctly prepared to host the GSI image.

In either case, just run the "repack_gsi_super.sh" script to get a super image with the changes made, as in the previous guide.

### Modifying boot

To get the GSI ROM to boot we have to modify the cmdline of the boot partition, otherwise we will find an infinite bootloop, which if we debug via ADB, we will find SELinux policies contained in the vendor partition prohibit access to critical configuration files to different system services.

The easy way to solve this, although not the most appropriate, is to disable SELinux. At least, until there is a better solution.

We will use Android Image Kitchen (linked in the main page of the repository), which will allow us to unpack the boot.bin file that we obtained with the backup of the device using MTKClient.

Once unpacked, it will be enough to replace its original cmdline:

	bootopt=64S3,32N2,32N2 buildvariant=user
	
with this one and repack it:

	bootopt=64S3,32N2,32N2 buildvariant=userdebug enforcing=0 androidboot.selinux=permissive
	
To find out how to write the new boot.img to the device, refer to the "FlashingPartitions" guide in this repository.




## --------  Spanish  --------

Es posible usar ROMs GSI en el Mi Smart Clock gracias a que está basado en Android 10, conllevando esto la compatibilidad con el proyecto Treble que habilita esta funcionalidad. Sin embargo hay dos limitaciones que, si bien no nos restan funcionalidad, hay que tener en cuenta:

1.- Para instalar una imagen GSI en el dispositivo hay que insertar ésta previamente en una imagen "super", debido a que las particiones lógicas product, system y vendor no están expuestas a través de fastboot, ya sea en el bootloader o en fastbootd.

2.- Debido a que las políticas SELinux precompiladas dentro de vendor son muy restrictivas las ROMs GSI no arrancan con SELinux habilitado. Para poder usarlas debemos deshabilitar esta característica (a falta de una mejor solución por el momento).

### Desempaquetando super para GSI

Los pasos son parecidos a los que hemos seguido previamente para trabajar con la ROM stock, y de hecho necesitamos el producto de ese trabajo (uno de los archivos NEW_super.img que funcione correctamente) como base para conseguir instalar una ROM GSI.

Usaremos el script "unpack_gsi_super.sh", contenido en la carpeta de herramientas, junto con el archivo creado anteriormente (un super.img que hayamos generado nosotros y hayamos verificado que funciona correctamente).

Este script, si lo usamos en conjunción con un "super.img" como el que hemos generado con la guía anterior, borrará las imágenes product y system, dejando sólo vendor.img y éste mismo archivo montado en "mnt/vendor".
Debido a que las imágenes GSI tienen un mayor tamaño que el destinado en principio para la partición lógica system, es necesario deshacerse de product, que igualmente no necesitaremos, para hacer espacio.
Del mismo modo, system.img es borrado ya que contiene el sistema que queremos sustituir, y no cumplirá ninguna función para este caso.

Si en cambio lo usamos junto con un super que ya ha sido preparado conteniendo una imagen GSI montará las particiones system y vendor dentro de "mnt" para trabajar normalmente con ellas.

### Creando super para GSI

Si al desempaquetar nuestra imagen de super nos hemos quedado sin archivo system.img quiere decir que esa imagen de super aún no había sido modificada para contener una imagen GSI. Por ello debemos copiar manualmente la imagen GSI que hemos elegido renombrada a "system.img", de forma que tras la ejecución del script de desempaquetado y la copia de este archivo nos encontremos con vendor.img, "mnt/vendor" montado y system.img.

Si por el contrario system.img existe y está montado en "mnt/system", la imagen de super que estamos usando estaba ya correctamente preparada para alojar la imagen GSI.

En cualquier de los dos casos, bastará con ejecutar el script "repack_gsi_super.sh" para obtener una imagen de super con los cambios realizados, como en la guía anterior.

### Modificando boot

Para conseguir que la ROM GSI arranque es necesario hacer una modificación dentro del cmdline de la partición boot del dispositivo, de lo contrario nos encontraremos con un bootloop infinito, que si depuramos mediantes ADB, veremos que se debe a que las políticas de SELinux contenidas en la partición vendor prohíben el acceso a archivos críticos de configuración a diferentes servicios del sistema.

El modo más sencillo de solventar esto, si bien no el más adecuado, es deshabilitar SELinux. Al menos, hasta que haya una solución mejor.

Usaremos Android Imagen Kitchen (enlazado en la página principal del repositorio), que nos permitirá desempaquetar el archivo boot.bin que obtuvimos con la copia de seguridad del dispositivo mediante MTKClient.

Una vez desempaquetado, bastará con sustituir su cmdline original:

	bootopt=64S3,32N2,32N2 buildvariant=user
	
con este y volver a empaquetarlo:

	bootopt=64S3,32N2,32N2 buildvariant=userdebug enforcing=0 androidboot.selinux=permissive
	
Para saber cómo escribir el nuevo boot.img en el dispositivo, dirígete a la guía "FlashingPartitions" en este mismo repositorio.
