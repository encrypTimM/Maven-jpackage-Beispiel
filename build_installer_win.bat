@echo off
rem ---- Benoetigte Informationen in Variablen speichern -------------
rem Mit den folgeneden Variablen koennen die Grundlegenden Daten fuer
rem das Projekt eingestellt werden:
set NAME="Maven Build Beispiel"
set DESCRIPTION="Beispielprojekt zur Erzeugung von modulbasierten Jar-Dateien und plattformspezifischen Installern"
set VERSION=1.0.0
set VENDOR="NAME DES ENTWICKLERS EINTRAGEN"
set COPYRIGHT="Copyright (c)"
set LICENSE_FILE="LICENSE.txt"

rem ---- Einstellungen fuer jpackage: --------------------------------
set INPUT="installers/input/%VERSION%"
set OUT="installers/%VERSION%/Windows"
set MODULE_PATH="installers/input/%VERSION%/lib"
set MAIN_MODULE="testmodul"
set MAIN_CLASS="de.hochschule_bochum.aid.testmodul.main.FXApp"

rem Systemspezifische Optionen
set WIN_MENU_GROUP="Maven Build Beispiel"

rem ---- Eingabeordner fuer jpackage leeren --------------------------
if exist %INPUT% del /Q %INPUT%

rem ---- Maven build -------------------------------------------------
echo.
echo Maven build durchfuehren
echo.
call mvn clean install

rem ---- Installer erzeugen ------------------------------------------
echo.
echo Installer fuer Windows werden erzeugt.
echo.

rem ---- exe ----
echo App-Image wird erstellt
echo.
@echo on
jpackage ^
--type app-image ^
--name %NAME% ^
--description %DESCRIPTION% ^
--app-version %VERSION% ^
--vendor %VENDOR% ^
--copyright %COPYRIGHT% ^
--input %INPUT% ^
--dest %OUT% ^
--module-path %MODULE_PATH% ^
--module-path "%INPUT%" ^
--module "%MAIN_MODULE%/%MAIN_CLASS%"
@echo off

rem ---- exe ----
echo %NAME%-%VERSION%-win-install.exe wird erstellt
echo.
@echo on
jpackage ^
--type exe ^
--name %NAME% ^
--description %DESCRIPTION% ^
--app-version %VERSION% ^
--vendor %VENDOR% ^
--copyright %COPYRIGHT% ^
--license-file %LICENSE_FILE% ^
--input %INPUT% ^
--dest %OUT% ^
--module-path %MODULE_PATH% ^
--module-path "%INPUT%" ^
--module "%MAIN_MODULE%/%MAIN_CLASS%" ^
--win-dir-chooser ^
--win-shortcut ^
--win-menu ^
--win-menu-group %WIN_MENU_GROUP%
@echo off

ren %OUT%\%NAME%-%VERSION%.exe %NAME%-%VERSION%-win-install.exe
echo.
echo.

rem ---- msi ----
echo %NAME%-%VERSION%-win-install.msi wird erstellt
echo.
@echo on
jpackage ^
--type msi ^
--name %NAME% ^
--description %DESCRIPTION% ^
--app-version %VERSION% ^
--vendor %VENDOR% ^
--copyright %COPYRIGHT% ^
--license-file %LICENSE_FILE% ^
--input %INPUT% ^
--dest %OUT% ^
--module-path %MODULE_PATH% ^
--module-path "%INPUT%" ^
--module "%MAIN_MODULE%/%MAIN_CLASS%" ^
--win-dir-chooser ^
--win-shortcut ^
--win-menu ^
--win-menu-group %WIN_MENU_GROUP%
@echo off

ren %OUT%\%NAME%-%VERSION%.msi %NAME%-%VERSION%-win-install.msi
echo.
echo.

rem ---- Auf Bestaetigung von Benutzer warten ------------------------------------
echo "Zum Abschliessen eine beliebige Taste druecken"
pause