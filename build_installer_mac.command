#!/bin/sh
cd "$(dirname "$0")" # zum Pfad dieses Skriptes wechseln

# ---- Benoetigte Informationen in Variablen speichern ---------------------------
# Mit den folgeneden Variablen koennen die Grundlegenden Daten fuer das Projekt
# eingestellt werden:
NAME="Maven Build Beispiel"
DESCRIPTION="Beispielprojekt zur Erzeugung von modulbasierten Jar-Dateien und plattformspezifischen Installern"
VERSION="1.0.0" # Version muss groesser gleich 1.0.0 sein!
VENDOR="NAME DES ENTWICKLERS EINTRAGEN"
COPYRIGHT="Copyright ©"
LICENSE_FILE="LICENSE.txt"

# Einstellungen fuer jpackage:
INPUT="installers/input/${VERSION}"
OUT="installers/${VERSION}/macOS"
MODULE_PATH="installers/input/${VERSION}/lib"
MAIN_MODULE="testmodul"
MAIN_CLASS="de.hochschule_bochum.aid.testmodul.main.FXApp"

# Weitere Befehle fuer jpackage:
# App Icon aendern: --icon "path/to/icon.png"
#ICON="path/to/icon.png"

# Systemspezifische Optionen
# Paketname darf maximal 16 Zeichen haben!
MAC_PACKAGE_NAME="Build Beispiel"
# weltweit eindeutiger Paketidentifier -> Pfad zur Main-Klasse ohne Unterstrich!
MAC_PACKAGE_ID="de.hochschule-bochum.aid.testmodul.main.FXApp"

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
echo "Installer fuer macOS werden erzeugt."
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
--mac-package-name "${MAC_PACKAGE_NAME}" \
--mac-package-identifier "${MAC_PACKAGE_ID}" \
#--icon "${ICON}"

echo ""
echo "${NAME-$VERSION}.pkg wird erstellt"
echo ""
jpackage \
--type "pkg" \
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
--mac-package-name "${MAC_PACKAGE_NAME}" \
--mac-package-identifier "${MAC_PACKAGE_ID}" \
#--icon "${ICON}"

echo ""
echo ""
echo "Der Prozess wurde beendet."
echo ""