# convert pdf to png with gs
# Usage: getimage.sh <pdf file>

FILEPATH=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")

# check file exist
if [ ! -f "$FILEPATH" ]; then
    echo "File not found!"
    exit 1
fi

command -v gs >/dev/null 2>&1 || { echo >&2 "Ghostscript is not installed.  Aborting."; exit 1; }

run() {
    gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -sOutputFile="image-%d.png" "$1"
}

# move image to Images folder
if [ ! -d "Images" ]; then
    mkdir Images
fi

mv image-*.png Images

run "$FILEPATH"
