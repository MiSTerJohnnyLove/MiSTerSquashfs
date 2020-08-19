#!/bin/bash
mkdir /media/fat/squashfs/ 2>/dev/null
mkdir /media/fat/squashfs-mount/ 2>/dev/null

cd /media/fat/squashfs/
for a in * ; do
  echo squashfs: core detected: "$a"
  cd /media/fat/squashfs/"$a"
  for b in *.img ; do
    cd /media/fat/squashfs/"$a"
    echo squashfs: image detected for "$a": "$b"
    mkdir /media/fat/squashfs-mount/"$a" 2>/dev/null
    mkdir /media/fat/squashfs-mount/"$a"/"$b" 2>/dev/null
    mount -o ro,loop "$b" /media/fat/squashfs-mount/"$a"/"$b"
    cd /media/fat/Games/"$a" || echo error: "$a" is not in /media/fat/Games - quitting
    for c in /media/fat/squashfs-mount/"$a"/"$b"/* ; do
      ln -s "$c" 2>/dev/null
    done
  done
done
