oldname=$(basename -s .jpeg $1)
name=$oldname"converted"

echo "Converting"

convert $1 \
        -rotate 270 \
        -filter LanczosSharp \
        -resize 600x800 \
        -background white \
        -gravity center \
        -colorspace Gray \
        -dither FloydSteinberg \
        -quality 75 \
        -define png:color-type=0 \
        -define png:bit-depth=8 \
        $name.png

echo "sending to kindle..."
scp -q $name.png mkindle:. 2> /dev/null
ssh mkindle "/usr/sbin/eips -c; /usr/sbin/eips -g ./$name.png" 2> /dev/null
rm $name.png
