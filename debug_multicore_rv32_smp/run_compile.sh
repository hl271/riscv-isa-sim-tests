rm -rf spike32_2*
riscv32-unknown-elf-gcc -g program/multicore.c -DMULTICORE program/entry.S program/init.c -DNHARTS=2 -I ../env -T ./spike32.lds -nostartfiles -mcmodel=medany -DXLEN=32 -o spike32_2_multicore -march=rv32imafdv -mabi=ilp32
# riscv32-unknown-elf-gcc -g program/checksum.c program/tiny-malloc.c program/infinite_loop.S -DDEFINE_MALLOC -DDEFINE_FREE program/entry.S program/init.c -DNHARTS=2 -I ../env -T ./spike32.lds -nostartfiles -mcmodel=medany -DXLEN=32 -o spike32_2_checksum -march=rv32imafdv -mabi=ilp32
