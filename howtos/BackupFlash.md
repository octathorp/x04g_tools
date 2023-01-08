## --------  English  --------

First step before modifying software running on device (ROM) is to make a backup of the flash contents. This will allow us to get back to factory state if we need it, as well as getting a copy of the installed software.

There is no firmware download available for X04G, either officially or unofficially, so it is really important to follow this procedure to get the basis for our modifications.
The author of these guides will not provide a backup of the device or the software in flashtool format, as it contains both proprietary files and unique device IDs.
For the same reason, it is recommended that you do not share your own backup.
<br>

### MTKClient

Thanks to **MTKClient** (https://github.com/bkerler/mtkclient) we will be able to make a complete backup of device flash.
This includes both the software running (Android Go 10) with Google Assistant and other partitions, as well as user data and device IDs (serial number, WiFI/BT MAC).
Since there is no package download available for SP Flash Tool containing the device software, this is a simple way to fill that gap.

Once MTKClient has been installed following the steps in its repository, it will be enough to execute "mtk_gui" with python ("python mtk_gui") to display its graphical interface window. In the same way, the terminal window from which we have executed the command will indicate that the program is waiting for the device.
While we hold down the volume up button we connect the USB cable between device and PC, it will be then detected and after a few seconds all of the available options will be shown.

First thing to do is to backup flash memory. In the "Flash tools" tab click on the "Read flash" button, select the path where you want to save the file and wait patiently as it may take some time, depending on factors such as our USB controller, quality of connection cable or operating system version.

Once this process is finished, we will do the same with "Read preloader" and "Read boot2" buttons.
Then, in the "Read partition(s)" tab, check "Select all partitions" and press the "Read partition(s)" button to make a copy of the device's memory again, this time split into partitions.

If everything went well the backup size should be close to 4GB (both the full backup and the sum of the files from the partitions backup), which is the same size of the device's flash memory.

<br>

## --------  Spanish  --------

El primer paso antes de modificar el software del dispositivo es hacer una copia de seguridad del contenido de su memoria flash. Esto nos permitirá volver al estado inicial si lo necesitamos en algún momento, así como obtener el software que se está ejecutando en el dispositivo y sobre el que haremos las modificaciones.

No hay disponible ninguna descarga del firmware para X04G, ni oficial ni extraoficialmente, por lo que es realmente importante seguir este procedimiento para conseguir la base sobre la que realizar nuestras modificaciones.
El autor de estas guías no facilitará un backup del dispositivo ni el software en formato usable, ya que éste contiene tanto archivos propietarios del fabricante como identificadores únicos del dispositivo del que se obtiene.
Por el mismo motivo, es recomendable que no compartas tu propio backup.
<br>

### MTKClient

Gracias a **MTKClient** (https://github.com/bkerler/mtkclient) podremos hacer una copia de seguridad completa del contenido del dispositivo.
Esto incluye tanto el software que está ejecutando (Android Go 10) con Google Assistant como las particiones auxiliares, así como los datos de usuario y los identificativos del dispositivo (número de serie, MAC de WiFI/BT, etc).
Debido a que no hay disponible ninguna descarga del paquete para SP Flash Tool conteniendo el software del dispositivo, esta es una forma sencilla de suplir esa carencia.

Una vez instalado MTKClient siguiendo los pasos de su repositorio, bastará con ejecutar "mtk_gui" con python ("python mtk_gui") para que se muestren la ventana de su interfaz gráfica. Del mismo modo en la ventana del terminal desde la que hemos ejecutado el comando se nos indicará que el programa está esperando al dispositivo.
Mientras mantenemos presionado el botón de subir volumen conectamos el cable USB entre el dispositivo y el PC, éste será detectado y tras unos segundos se mostrarán todas las opciones disponibles en la interfaz.

Lo primero que haremos será la copia de seguridad de la memoria completa. Para ello en la pestaña "Flash tools" pulsaremos el botón "Read flash", le indicaremos la ruta donde guardar el archivo y esperaremos pacientemente ya que puede tardar bastante tiempo, dependiendo de factores como nuestra controladora USB, la calidad del cable de conexión o la versión del sistema operativo.

Una vez terminado este proceso haremos lo mismo con los botones "Read preloader" y "Read boot2".
Después, en la pestaña "Read partition(s)" marcaremos "Select all partitions" y pulsaremos el botón "Read partition(s)" para de nuevo hacer una copia de la memoria del dispositivo, esta vez separada en particiones.

Si todo ha ido bien la copia de seguridad debe tener un tamaño cercano a los 4GB (tanto la completa como la suma de los archivos de la otra), que es el tamaño de la memoria flash del dispositivo.
