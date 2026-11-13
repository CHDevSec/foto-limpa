#!/usr/bin/env bash
#
# demo.sh — a foto entrega onde tu mora (lab de privacidade EXIF/GPS)
#
# Gera uma foto de TREINO (nossa), planta uma coordenada GPS fake nos metadados EXIF,
# mostra o que o `exiftool` revela e, no fim, gera uma cópia LIMPA e prova que o GPS sumiu.
# Nenhuma foto de terceiro é usada. Ver ../ETICA.md
#
set -euo pipefail
cd "$(dirname "$0")"

FOTO="lab-foto.jpg"
LIMPA="lab-foto-limpa.jpg"

# coordenada de LAB (fake). Qualquer semelhança com praia carioca é só pro vídeo. :)
LAT="-22.9711"
LON="-43.1822"

need() { command -v "$1" >/dev/null 2>&1 || { echo "FALTA: $1. Ver instalação no README."; exit 1; }; }
need exiftool
if command -v magick >/dev/null 2>&1; then MG=magick
elif command -v convert >/dev/null 2>&1; then MG=convert
else echo "FALTA: imagemagick (magick/convert). Ver instalação no README."; exit 1; fi

echo "==> [1/4] gerando a foto de treino ($FOTO)"
$MG -size 1200x900 gradient:'#2b6cb0'-'#e2c290' \
    -pointsize 46 -fill '#ffffffcc' -gravity south -annotate +0+40 'FOTO DE LAB - CHDEVSEC' \
    "$FOTO"

echo "==> [2/4] plantando o GPS dentro do arquivo (metadados EXIF)"
exiftool -overwrite_original -q \
  -Make="Apple" -Model="iPhone 13" \
  -DateTimeOriginal="2026:11:10 17:12:00" \
  -GPSLatitude="$LAT" -GPSLatitudeRef="S" \
  -GPSLongitude="$LON" -GPSLongitudeRef="W" \
  "$FOTO"

echo
echo "==> [3/4] o que QUALQUER UM lê do arquivo (sem ver a imagem):"
echo "-------------------------------------------------------------"
exiftool -Make -Model -DateTimeOriginal -GPSPosition "$FOTO"
echo "-------------------------------------------------------------"
echo "    ^ a coordenada acima joga direto no mapa. Tava escrita DENTRO da foto."
echo

echo "==> [4/4] limpando: gerando $LIMPA sem nenhum metadado"
cp "$FOTO" "$LIMPA"
exiftool -overwrite_original -q -all= "$LIMPA"
echo "    conferindo o GPS na cópia limpa:"
echo "-------------------------------------------------------------"
exiftool -GPSPosition "$LIMPA" || true
echo "-------------------------------------------------------------"
echo "    (vazio = limpo. A imagem continua igual, só o metadado foi embora.)"
echo
echo "Pronto. A defesa no teu celular tá em ../defesa/checklist.md"
