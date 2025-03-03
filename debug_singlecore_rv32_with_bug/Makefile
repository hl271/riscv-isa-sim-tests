# Define target name (without extension)
TARGET = spike32_main

# Toolchain commands
CC       = riscv32-unknown-elf-gcc
OBJCOPY  = riscv32-unknown-elf-objcopy

# Common flags
CFLAGS   =  -g -O0 -DDEFINE_MALLOC -DDEFINE_FREE -DNHARTS=1 -mcmodel=medany -DXLEN=32 -march=rv32imafdcv -mabi=ilp32
LDFLAGS  = -T ./spike32.lds -nostartfiles
INCLUDES = -I ../env

# Source files for main application
SOURCES = program/main.c program/entry.S

# Default target: build ELF and then a binary version if desired
all: $(TARGET).elf $(TARGET)

# Rule to build the ELF file
$(TARGET).elf: $(SOURCES)
	$(CC) $(CFLAGS) $(INCLUDES) $(SOURCES) $(LDFLAGS) -o $(TARGET).elf

# Build binary file for spike
$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) $(INCLUDES) $(SOURCES) $(LDFLAGS) -o $(TARGET)

# Optional: create a binary file from the ELF file
bin: $(TARGET).bin

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

# Optional checksum target (formerly commented out)
CHECKSUM_TARGET = spike32_checksum.elf
checksum: program/checksum.c program/tiny-malloc.c program/infinite_loop.S program/entry.S program/init.c
	$(CC) $(CFLAGS) -DDEFINE_MALLOC -DDEFINE_FREE -DNHARTS=1 $(INCLUDES) -T ./spike32.lds -nostartfiles -mcmodel=medany -DXLEN=32 -march=rv32imafdcv -mabi=ilp32 \
	    program/checksum.c program/tiny-malloc.c program/infinite_loop.S program/entry.S program/init.c -o $(CHECKSUM_TARGET)

# Clean up generated files
clean:
	rm -rf spike32_* 

.PHONY: all bin checksum clean
