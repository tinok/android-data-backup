@echo off

mkdir _data > log.txt  2>&1

echo SEARCHING DEVICE...

::This is the TWRP recovery image for Nexus 7 (2012) [twrp-2.8.6.0-grouper.img]
fastboot boot recovery\twrp.img

echo DEVICE CONNECTED! LOOKING FOR DRIVERS...
:checkfordevice
timeout /t 1 > nul
adb shell exit 2> nul
if %errorlevel% neq 0 goto checkfordevice

echo DRIVERS FOUND! STARTING BACKUP...

::This pulls kobocollect data from the second user account only on Android 4.4
adb pull /data/media/10/odk/instances _data/ >> log.txt  2>&1

7zip\7za a BACKUP_DATA.zip _data >> log.txt  2>&1
7zip\7za a BACKUP_DATA.zip log.txt > nul
del log.txt

echo BACKUP DONE. EMAIL THE FILE "BACKUP_DATA.zip".

pause

adb reboot bootloader