#!/usr/bin/env bash

# usage:
# ./build-snes.sh debug
# ./build-snes.sh release

set -e

MODE="${1:-debug}"
ASM="main.asm"
HEADER="header.inc"

if [[ "$MODE" != "debug" && "$MODE" != "release" ]]; then
  echo "Usage: $0 [debug|release]"
  exit 1
fi

EXT="sfc"
[[ "$MODE" == "release" ]] && EXT="smc"

# ---- timestamp ----
TIMESTAMP=$(date +"%Y%m%d__%p%I%M%S" | tr '[:lower:]' '[:upper:]')

# ---- extract NAME from header.inc ----
if [[ ! -f "$HEADER" ]]; then
  echo "header.inc not found"
  exit 1
fi

ROMNAME=$(sed -n 's/.*NAME[[:space:]]*"\([^"]*\)".*/\1/p' "$HEADER" | head -n 1)

if [[ -z "$ROMNAME" ]]; then
  echo "NAME not found in header.inc"
  exit 1
fi

# sanitize name:
# spaces → dashes
# remove illegal filename characters
ROMNAME=$(echo "$ROMNAME" \
  | tr ' ' '-' \
  | sed 's/[^A-Za-z0-9\-]//g')

# ---- output folder ----
OUTDIR="ROM"
mkdir -p "$OUTDIR"

OUTFILE="${OUTDIR}/${TIMESTAMP}__${MODE^^}__${ROMNAME}.${EXT}"

# ---- build ----
echo "Assembling ($MODE): $ASM"
echo ">------------------------------->"
wla-65816 -v -o main.o "$ASM"
echo ">------------------------------->"

echo " "
echo "CREATING LINK FILE"
echo ">------------------------------->"
echo "[objects]" > main.link
echo "main.o" >> main.link
echo ">------------------------------->"

echo " "
echo "LINKING to CREATE ROM"
echo ">------------------------------->"
wlalink -v -r main.link "$OUTFILE"
echo ">------------------------------->"

rm -f main.o main.link

echo " "
echo "BUILT:"
echo ">------------------------------->"
echo "$OUTFILE"
echo ">------------------------------->"
