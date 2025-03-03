# rm -rf spike32_*
# riscv32-unknown-elf-gcc -g program/main.c -DDEFINE_FREE program/entry.S  -DNHARTS=1 -I ../env -T ./spike32.lds -nostartfiles -mcmodel=medany -DXLEN=32 -o spike32_main -march=rv32imafdcv -mabi=ilp32
# riscv32-unknown-elf-gcc -g program/checksum.c program/tiny-malloc.c program/infinite_loop.S -DDEFINE_MALLOC -DDEFINE_FREE program/entry.S program/init.c -DNHARTS=1 -I ../env -T ./spike32.lds -nostartfiles -mcmodel=medany -DXLEN=32 -o spike32_checksum -march=rv32imafdcv -mabi=ilp32

make clean
make