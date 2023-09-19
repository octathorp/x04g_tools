# x04g_tools
Xiaomi Smart Clock - Global variant (X04G) development tools

## --------  English  --------

This repo contains several useful tools for (Xiaomi) Mi Smart Clock development, mainly for X04G global version, but also working with chinese LX04 version.

Main difference between variants is their software:

- LX04 variant is a Xiao AI voice assistant, for chinese market, based on Android 8.1.
- X04G variant is a Google Assistant device, based on Android Go 10.

Both variants share the same hardware, so you can install both software versions on them.

### Technical specs

- **CPU**: MTK 8167 (MT8167), 4 Cortex-A35 cores @ 1.5GHz
- **RAM**: 1GB DDR3
- **Screen**: 4 inches 800x480
- **WiFi/BT**: WiFi 2.4GHz, BT5.0
- **Ports**: microUSB power/data
- **Buttons**: volume +/-, mute
- **Mic**: 2 mics array
- **Speaker**: 1 x 1.5 inches
- **Sensors**: light/proximity

### HOWTOs

[Backup whole flash](howtos/BackupFlash.md)

[Working with super image](howtos/UnpackRepackSuper.md)

[GSI compatibility](howtos/WorkingWithGSI.md)

### Included tools

[Tools folder](tools)

### External tools

- **MTKClient**: https://github.com/bkerler/mtkclient

- **Android Image Kitchen**: https://forum.xda-developers.com/t/tool-android-image-kitchen-unpack-repack-kernel-ramdisk-win-android-linux-mac.2073775/

- **Magisk**: https://github.com/topjohnwu/Magisk

- **GSI images**: https://github.com/phhusson/treble_experimentations/wiki/Generic-System-Image-%28GSI%29-list

<br>

## --------  Spanish  --------

Este repositorio contiene una lista de herramientas útiles para el (Xiaomi) Mi Smart Clock, versión global X04G, aunque también sirven para la versión china LX04.

La principal diferencia entre ambas variantes está en su software;
- la variante LX04 funciona como asistente de Xiao AI, dirigida al mercado chino, y con la ROM basada en Android 8.1.
- la variante global X04G es un dispositivo asistente de Google, con una ROM basada en Android Go 10.

Ambas variantes cuentan con el mismo hardware y puede saltarse de una a otra versión simplemente cambiando su ROM.

### Especificaciones

- **CPU**: MTK 8167 (MT8167), 4 cores Cortex-A35 a 1.5GHz
- **RAM**: 1GB DDR3
- **Pantalla**: 4 pulgadas 800x480
- **WiFi/BT**: WiFi 2.4GHz, BT5.0
- **Puertos**: microUSB alimentación/datos
- **Botones**: físicos de volumen +/- y mute
- **Micrófono**: 2 micrófonos en la parte superior
- **Altavoz**: mono, 1.5 pulgadas
- **Sensores**: luminosidad/proximidad

### Guías

[Hacer copia de la flash completa](howtos/BackupFlash.md)

[Trabajando con una imagen super](howtos/UnpackRepackSuper.md)

[Compatibilidad de GSI](howtos/WorkingWithGSI.md)

### Herramientas incluidas

[Carpeta de herramientas](tools)

### Herramientas externas

- **MTKClient**: https://github.com/bkerler/mtkclient

- **Android Image Kitchen**: https://forum.xda-developers.com/t/tool-android-image-kitchen-unpack-repack-kernel-ramdisk-win-android-linux-mac.2073775/

- **Magisk**: https://github.com/topjohnwu/Magisk

- GSI images: https://github.com/phhusson/treble_experimentations/wiki/Generic-System-Image-%28GSI%29-list
