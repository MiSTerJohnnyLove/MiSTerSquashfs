# MisterSquashfs
This kernel adds squashfs support, enabling you to compress roms using gzip, lzma, lz4, or zstd, transparently and without needing any modifications to cores.

If you are using windows and need gensquashfs, https://github.com/AgentD/squashfs-tools-ng<br/>
Otherwise install it in linux through your package manager, for example "sudo apt-get install squashfs-tools-ng"

To limit the number of symbolic links made, take a ROM pack and first put it in an empty folder. In this example, it's called compress.

mkdir compress<br/>
mv Super\ EverDrive\ \&\ SD2SNES/ compress/<br/>
gensquashfs -D compress -c xz -b 1048576 super_everdrive_and_sd2snes.img<br/>
mv compress/Super\ EverDrive\ \&\ SD2SNES/ ./<br/>
du -sh Super\ EverDrive\ \&\ SD2SNES/ super_everdrive_and_sd2snes.img<br/>
11G     Super EverDrive & SD2SNES/<br/>
3.9G    super_everdrive_and_sd2snes.img

mkdir compress<br/>
mv NeoGeo compress/<br/>
gensquashfs -D compress -c xz -b 1048576 neogeo.img<br/>
mv compress/NeoGeo ./<br/>
du -sh NeoGeo neogeo.img<br/>
7.3G    NeoGeo/<br/>
1.8G    neogeo.img<br/>

upload img files to /media/fat/squashfs/SNES/ and /media/fat/squashfs/NeoGeo/, respectively. You will have to create these folders yourself first.<br/>
upload squashfs_mount.sh to /media/fat/Scripts, you will have to run this yourself after every hard reset or power on.<br/>
upload zImage_dtb to /media/fat/linux/, preferably after renaming the original zImage_dtb to zImage_dtb.bak. This will be wiped out the next time the kernel is updated. Contact me on discord, preferably after joining the classic gaming discord so the DM will go through or so you can tag me in a MiSTer room (Johnny Love#0896) if this happens and my github hasn't been updated with a new kernel containing squashfs support.

For more information, see https://misterfpga.org/viewtopic.php?f=27&t=965 and https://redd.it/ibl8j3

Please do NOT contact me on discord for help. The reddit/misterfpga posts are the only place I will help people, because that way it will help others at the same time, and will allow other people to help you as well.
