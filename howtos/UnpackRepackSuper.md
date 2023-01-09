## --------  English  --------

If we already have a device partitions backup we should have a folder containing several files with ".bin" extension. We will need "super.bin", so we copy it to a new folder. It is important to keep the original backup files as they were extracted from device and do not work directly with them.

### Unpacking super partition

To unpack "super" partition we will use a script called "unpack_bin_super.sh", contained in the tools folder. We should place this file in the same folder we copied "super.bin" previously.
After running it we will see how 4 new elements are created; an "mnt" folder and 3 disk image files (product.img, system.img and vendor.img). Inside the "mnt" folder there will be 3 subfolders (product, system and vendor) where the 3 disk images will be mounted.

To make any change it is necessary to have root permissions, since the images are mounted as such, either from the console or the file explorer.

### Creating a new super image

Once we have made the changes we wanted, it is time to re-create the super partition that we will write to the device.
We must make sure that the console or file explorer is not located inside the "mnt" folder so that the unmount process does not fail.

Now we will use the script "repack_super_from_bin.sh", previously placed in the same folder. If we run it, the image files and the folder created in the previous step will disappear and a new file "NEW_super.img" will be created.

If we want to make any further change using this newly created file we must use another set of scripts; "unpack_img_super.sh" and "repack_super_from_img.sh".

### FYI

It is important not to mix the use of the scripts; the ones we have used in the first step are only needed to unpack/repack "super.bin" file extracted directly from the device, while other two scripts are meant to be used with a "*_super.img" file created using the scripts set.

The "repack" scripts will always create a file called "NEW_super.img" as output after execution, so any existing file with the same name will be overwritten. Please rename the files you don't want to lose.

<br>

## --------  Spanish  --------

Si ya hemos completado la copia por particiones del dispositivo tendremos una carpeta conteniendo varios archivos con extensión ".bin". Copiaremos uno de ellos, "super.bin", a una carpeta nueva donde trabajaremos con él. Es importante guardar una copia de todos los archivos antes de trabajar con ellos, por si algo sale mal.

### Desempaquetando la partición super

Para desempaquetar la partición "super" usaremos el script "unpack_bin_super.sh", contenido en la carpeta de herramientas de este repositorio. Para ello, debemos colocarlo en la misma carpeta que el archivo "super.bin" que copiamos previamente.
Al ejecutarlo veremos como se crean 4 elementos nuevos; una carpeta "mnt" y 3 archivos de imagen de disco (product.img, system.img y vendor.img). Dentro de la carpeta "mnt" habrá a su vez 3 subcarpetas (product, system y vendor) donde se habrán montado las 3 imágenes de disco.

Para hacer cambios es necesario tener permisos de root, puesto que las imágenes están montadas como tal, bien sea desde la consola o el explorador de archivos.

### Creando una nueva imagen de super

Una vez realizados los cambios que hemos considerado oportunos, es momento de volver a crear la partición super que escribiremos en el dispositivo.
Debemos asegurarnos de que la consola o el explorador de archivos no se encuentran posicionados dentro de la carpeta "mnt" para que no falle el proceso de desmontaje.

En este caso usaremos el script "repack_super_from_bin.sh", colocado previamente en la misma carpeta. Al ejecutarlo desaparecerán los archivos de imagen y la carpeta creados en el punto anterior y veremos como aparece un nuevo archivo "NEW_super.img", nuestra recién creada imagen de la partición "super" lista para escribir en el dispositivo.

Para trabajar usando de base ese archivo recién creado debemos usar otro conjunto de scripts; "unpack_img_super.sh" y "repack_super_from_img.sh", conveniente sobre todo para poder hacer cambios y pruebas sin tener que partir siempre desde el archivo base.

### Información relevante

Es importante no mezclar el uso de los scripts; los que hemos usando en primer lugar sólo sirven para trabajar desde el archivo "super.bin" extraído directamente del dispositivo, mientras que los otros dos sirven para trabajar usando de base un archivo "*_super.img" creado con el conjunto de scripts.

Los scripts "repack" siempre crearán un archivo llamado "NEW_super.img" como salida tras su ejecución, por lo que cualquier archivo existente con el mismo nombre será sobreescrito. Por favor, renombra los archivos que no quieras perder.
