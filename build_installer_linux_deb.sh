#!/bin/sh
cd "$(dirname "$0")" # zum Pfad dieses Skriptes wechseln

# ---- Benoetigte Informationen in Variablen speichern ---------------------------
# Mit den folgeneden Variablen koennen die Grundlegenden Daten fuer das Projekt
# eingestellt werden:
NAME="Maven Build Beispiel"
DESCRIPTION="Beispielprojekt zur Erzeugung von modulbasierten Jar-Dateien und plattformspezifischen Installern"
VERSION=1.0.0
VENDOR="NAME DES ENTWICKLERS EINTRAGEN"
COPYRIGHT="Copyright ©"
LICENSE_FILE="LICENSE.txt"

# Einstellungen fuer jpackage:
INPUT="installers/input/${VERSION}"
OUT="installers/${VERSION}/Linux"
MODULE_PATH="installers/input/${VERSION}/lib"
MAIN_MODULE="testmodul"
MAIN_CLASS="de.hochschule_bochum.aid.testmodul.main.FXApp"

# Weitere Befehle fuer jpackage:
# App Icon aendern: --icon "path/to/icon.png"
#ICON="path/to/icon.png"

# Systemspezifische Optionen
LINUX_MENU_GROUP="Development;Education;"
LINUX_RPM_LICENSE_TYPE="MIT"

# ---- Eingabeordner leeren ------------------------------------------------------
mkdir -p $INPUT
rm -r -f $INPUT/*

# ---- Maven build ---------------------------------------------------------------
echo ""
echo "Maven build durchfuehren"
echo ""
mvn clean install

# ---- Installer erzeugen --------------------------------------------------------
echo ""
echo "Installer fuer Linux werden erzeugt."
echo ""
echo "App-Image wird erstellt"
echo ""

jpackage \
--type "app-image" \
--name "${NAME}" \
--description "${DESCRIPTION}" \
--app-version "${VERSION}" \
--vendor "${VENDOR}" \
--copyright "${COPYRIGHT}" \
--input "${INPUT}" \
--dest "${OUT}" \
--module-path "${MODULE_PATH}" \
--module-path "${INPUT}" \
--module "${MAIN_MODULE}/${MAIN_CLASS}" \
# --icon "${ICON}"

echo "${NAME-$VERSION}.deb wird erstellt"
echo ""
jpackage \
--type "deb" \
--name "${NAME}" \
--description "${DESCRIPTION}" \
--app-version "${VERSION}" \
--vendor "${VENDOR}" \
--copyright "${COPYRIGHT}" \
--license-file "${LICENSE_FILE}" \
--input "${INPUT}" \
--dest "${OUT}" \
--module-path "${MODULE_PATH}" \
--module-path "${INPUT}" \
--module "${MAIN_MODULE}/${MAIN_CLASS}" \
--linux-menu-group "${LINUX_MENU_GROUP}" \
--linux-shortcut \
--linux-rpm-license-type "${LINUX_RPM_LICENSE_TYPE}" \
# --icon "${ICON}"

echo ""
echo "Der Prozess wurde beendet."
echo ""