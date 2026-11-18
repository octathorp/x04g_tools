## --------  English  --------

This guide gets root ADB on the **stock** X04G firmware (Google Assistant and Cast keep working), optionally over Wi-Fi with key authentication, and updates the time zone rules without touching `/system`. It was tested in November 2026 on firmware `QP1A.190711.020/1.7.5` (security patch 2021-06), with mtkclient from October 2026.

It builds on [Informatic/xiaomi-x04g-research](https://github.com/Informatic/xiaomi-x04g-research). Make a full backup first and keep it: there is no other way back to the factory state.

[Backup whole flash](BackupFlash.md)

### 1. Backup in a single BROM session

Unplug the clock, start mtkclient, then hold volume + while plugging the USB cable. With a script, all reads happen in one session:

	gpt backup/gpt
	rf backup/flash.bin
	r preloader backup/boot1.bin --parttype boot1
	r preloader backup/boot2.bin --parttype boot2
	rl backup/partitions

	python mtk.py script dump.script

The `backup/gpt` and `backup/partitions` folders must exist beforehand. Expect about 3.3 MB/s, so roughly 40 minutes in total. A charge-only USB cable is the most common reason why the clock is not detected at all.

Since Android is not running in BROM mode, each file in `partitions/` must be byte-identical to the matching slice of `flash.bin`, at the offsets given by `python mtk.py printgpt`. Compare their SHA-256 sums before going further.

### 2. Unlock the bootloader: expect a factory reset

	python mtk.py da seccfg unlock

The userdata partition is encrypted with keys bound to the verified boot state. After the unlock, the clock showed "Orange State" and then "Can't load Android system. Your data may be corrupt". A factory data reset from that screen is required, and the clock must then be set up again in Google Home.

To lock it again, write back the original `seccfg.bin` from the backup.

### 3. Patch boot with Magisk and ADB

Use Informatic's `magisk-install.sh` on your own `boot.bin`. The message `./magisk32: line 1: syntax error` printed during patching is harmless: it comes from an ARM binary run on the PC.

Before patching, consider removing the root shell. The stock `init.adb.rc` and `rootshell.sh` open an **unauthenticated root shell on TCP port 1337 for the whole LAN**. Delete the `start rootshell` line and the `service rootshell` block from `init.adb.rc`, and drop the `rootshell.sh` line from `boot-patch.patch` (its hunk header becomes `@@ -183,6 +183,7 @@`).

Flash the result with `python mtk.py w boot new-boot.img`.

Then, from the setup screen, `adb shell` gives `uid=0(root)` with SELinux permissive.

### 4. Optional: ADB over Wi-Fi with key authentication

Use this `init.adb.rc` instead. It keeps ADB authentication on, listens on port 5555 and only accepts the listed hosts:

	on boot
	    exec u:r:magisk:s0 -- /system/bin/setenforce 0
	    exec u:r:magisk:s0 -- /sbin/resetprop ro.secure 0
	    exec u:r:magisk:s0 -- /sbin/resetprop ro.adb.secure 1
	    exec u:r:magisk:s0 -- /sbin/resetprop ro.debuggable 1
	    setprop persist.sys.usb.config adb
	    setprop sys.usb.config adb
	    setprop service.adb.tcp.port 5555
	    stop adbd
	    start adbd

	on property:sys.usb.config=adb && property:sys.usb.configfs=1
	    restart adbd

	# netd flushes INPUT when it starts: add the filter once boot is complete
	on property:sys.boot_completed=1
	    exec u:r:magisk:s0 -- /system/bin/iptables -w -N adbfw
	    exec u:r:magisk:s0 -- /system/bin/iptables -w -A adbfw -s <PC IP> -j RETURN
	    exec u:r:magisk:s0 -- /system/bin/iptables -w -A adbfw -j DROP
	    exec u:r:magisk:s0 -- /system/bin/iptables -w -I INPUT -p tcp --dport 5555 -j adbfw
	    exec u:r:magisk:s0 -- /system/bin/ip6tables -w -I INPUT -p tcp --dport 5555 -j DROP

The clock cannot show the "Allow USB debugging?" prompt, so the keys must be installed beforehand, while ADB is still open over USB. Follow these steps in order:

1. Push your keys (`~/.android/adbkey.pub` of every host) as `/data/misc/adb/adb_keys`, with owner `system:shell` and mode `640`.
2. Run `settings put global adb_allowed_connection_time 0`. Android 10 otherwise revokes keys unused for 7 days.
3. Flash the new boot.
4. Connect once from **every** host right after the first boot.

Android 10 rewrites `adb_keys` from its own key store, and a key only enters that store on its first successful connection. A host that has not connected yet loses its key at the next rewrite.

Reserve the clock's IP address in your router, and double-check the MAC address you type there.

### 5. Time zone rules

The firmware ships tzdata 2019b. For example, it still shows Morocco at UTC+01 after its return to UTC+00 on 2026-09-20.

Android 10 reads `/data/misc/zoneinfo/current/` before the APEX, so up-to-date rules can be installed there without modifying `/system`. Ready-made sets and an install script are available at [laruche/android10-tzdata](https://github.com/laruche/android10-tzdata).

The folder needs a `distro_version` file, otherwise `tzdatacheck` deletes it at boot.

Keep `persist.sys.timezone` as Cast sets it. To roll back, run `rm -rf /data/misc/zoneinfo/current` and reboot.

<br>

## --------  Spanish  --------

Esta guía permite obtener ADB root sobre el firmware **original** del X04G (Google Assistant y Cast siguen funcionando), opcionalmente por Wi-Fi con autenticación por claves, y actualizar las reglas de zona horaria sin tocar `/system`. Se probó en noviembre de 2026 con el firmware `QP1A.190711.020/1.7.5` (parche de seguridad 2021-06) y MTKClient de octubre de 2026.

Se basa en [Informatic/xiaomi-x04g-research](https://github.com/Informatic/xiaomi-x04g-research). Haz primero una copia completa y guárdala: es la única forma de volver al estado de fábrica.

[Hacer copia de la flash completa](BackupFlash.md)

### 1. Copia en una sola sesión BROM

Desconecta el reloj, lanza MTKClient y conecta el cable USB manteniendo pulsado volumen +. Con un script, todas las lecturas se hacen en una sola sesión:

	gpt backup/gpt
	rf backup/flash.bin
	r preloader backup/boot1.bin --parttype boot1
	r preloader backup/boot2.bin --parttype boot2
	rl backup/partitions

	python mtk.py script dump.script

Las carpetas `backup/gpt` y `backup/partitions` deben existir antes. Cuenta con unos 3,3 MB/s, es decir, unos 40 minutos en total. Un cable USB solo de carga es la causa más habitual de que el reloj no se detecte.

Como Android no se ejecuta en modo BROM, cada archivo de `partitions/` debe ser idéntico byte a byte al tramo correspondiente de `flash.bin`, según los offsets que da `python mtk.py printgpt`. Compara sus sumas SHA-256 antes de continuar.

### 2. Desbloquear el bootloader: habrá que restablecer

	python mtk.py da seccfg unlock

La partición userdata está cifrada con claves ligadas al estado de arranque verificado. Tras el desbloqueo, el reloj mostró "Orange State" y después "Can't load Android system. Your data may be corrupt". Hay que hacer un restablecimiento de fábrica desde esa pantalla y volver a configurar el reloj en Google Home.

Para volver a bloquearlo, escribe de nuevo el `seccfg.bin` original de la copia.

### 3. Parchear boot con Magisk y ADB

Usa el `magisk-install.sh` de Informatic sobre tu propio `boot.bin`. El mensaje `./magisk32: line 1: syntax error` que aparece durante el parcheo es inofensivo: viene de un binario ARM ejecutado en el PC.

Antes de parchear, considera quitar la shell root. Los archivos originales `init.adb.rc` y `rootshell.sh` abren una **shell root sin autenticación en el puerto TCP 1337 para toda la red local**. Borra la línea `start rootshell` y el bloque `service rootshell` de `init.adb.rc`, y quita la línea de `rootshell.sh` de `boot-patch.patch` (la cabecera del hunk pasa a `@@ -183,6 +183,7 @@`).

Escribe el resultado con `python mtk.py w boot new-boot.img`.

Después, desde la pantalla de configuración, `adb shell` da `uid=0(root)` con SELinux en modo permisivo.

### 4. Opcional: ADB por Wi-Fi con autenticación por claves

Usa en su lugar el `init.adb.rc` de la sección en inglés. Mantiene activa la autenticación ADB, escucha en el puerto 5555 y solo acepta los equipos indicados.

El reloj no puede mostrar el aviso "¿Permitir depuración USB?", así que las claves deben instalarse antes, mientras ADB sigue abierto por USB. Sigue estos pasos en orden:

1. Copia tus claves (el `~/.android/adbkey.pub` de cada equipo) como `/data/misc/adb/adb_keys`, con propietario `system:shell` y modo `640`.
2. Ejecuta `settings put global adb_allowed_connection_time 0`. Si no, Android 10 revoca las claves que no se usan durante 7 días.
3. Escribe el nuevo boot.
4. Conéctate una vez desde **cada** equipo justo después del primer arranque.

Android 10 reescribe `adb_keys` a partir de su propio almacén de claves, y una clave solo entra en ese almacén en su primera conexión correcta. Un equipo que aún no se ha conectado pierde su clave en la siguiente reescritura.

Reserva la IP del reloj en tu router y comprueba bien la dirección MAC que escribes.

### 5. Reglas de zona horaria

El firmware incluye tzdata 2019b. Por ejemplo, sigue mostrando Marruecos en UTC+01 después de su vuelta a UTC+00 el 2026-09-20.

Android 10 lee `/data/misc/zoneinfo/current/` antes que el APEX, así que se pueden instalar ahí reglas actualizadas sin modificar `/system`. Hay conjuntos ya preparados y un script de instalación en [laruche/android10-tzdata](https://github.com/laruche/android10-tzdata).

La carpeta necesita un archivo `distro_version`; si no, `tzdatacheck` la borra al arrancar.

Deja `persist.sys.timezone` tal como lo configura Cast. Para deshacer el cambio, ejecuta `rm -rf /data/misc/zoneinfo/current` y reinicia.
