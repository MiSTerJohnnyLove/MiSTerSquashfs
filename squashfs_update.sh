#!/bin/bash
mkdir /media/fat/squashfs/ 2>/dev/null
mkdir /media/fat/squashfs-mount/ 2>/dev/null
mkdir /media/fat/squashfs-updates/ 2>/dev/null
touch /media/fat/Scripts/squashfs_update.old.sh
cd /media/fat/Games
for i in */ ; do
  mkdir /media/fat/squashfs/"$i" 2>/dev/null
done

export UPDATE_DIR="/media/fat/squashfs-updates/"
cd $UPDATE_DIR
export BASE_URL="https://github.com/MiSTerJohnnyLove/MiSTerSquashfs/raw/master"
echo downloading checksums
rm -f checksums.txt.old >/dev/null
touch checksums.txt
mv checksums.txt checksums.txt.old
wget $BASE_URL/checksums.txt
echo if there are no new updates, exit immediately
diff checksums.txt checksums.txt.old >/dev/null && exit 0
echo updates detected
for i in `awk '{print $2}' < checksums.txt` ; do
  echo checking $i
  touch $i
  grep "$i" checksums.txt | md5sum -c >/dev/null || rm -f "$i"
  if [ -f $i ] ; then
    echo $i remained the same ; else
    wget $BASE_URL/"$i"
    grep "$i" checksums.txt | md5sum -c >/dev/null || rm -f "$i"
  fi
done

echo checking update script integrity, re-run later if it quits here
grep squashfs_update.sh checksums.txt | md5sum -c >/dev/null || ( rm -f "$i" ; exit 1 )
diff squashfs_update.sh /media/fat/Scripts/squashfs_update.old.sh >/dev/null || ( mv -f /media/fat/Scripts/squashfs_update.sh /media/fat/Scripts/squashfs_update.old.sh ; cp -f squashfs_update.sh /media/fat/Scripts/squashfs_update.sh )

echo final checks to see if everything downloaded fine, exiting otherwise
md5sum -c checksums.txt || exit 1

echo no issues, updating everything
cp -f squashfs_mount.sh /media/fat/Scripts/
cp -f squashfs_mount.sh /etc/init.d/S99squashfs
mv -f /media/fat/linux/zImage_dtb /media/fat/linux/zImage_dtb.nosquash
cp zImage_dtb /media/fat/linux/zImage_dtb
echo installation complete
