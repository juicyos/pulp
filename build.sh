mkdir bin
../yuzu/bin/yc src/kmain.yuzu kmain.asm
cat src/entry.s kmain.asm > _.asm
nasm -f bin _.asm -o bin/kernel.bin
rm kmain.asm _.asm
../peel/bin/juicer c bin/kernel.bin bin/kernel.zip
cat ../seed/bin/fdseed.bin bin/kernel.zip > bin/kernel.img
truncate -s 1440K bin/kernel.img
qemu-system-x86_64 -drive format=raw,file=bin/kernel.img,index=0,if=floppy
