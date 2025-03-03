#include "encoding.h"

#define STACK_SIZE (90 * XLEN / 8)

  .section      .text.entry
  .globl _start
_start:
  j handle_reset

nmi_vector:
  j nmi_vector

handle_reset:
  // Basic initialization without trap or multicore setup.
  csrwi mstatus, 0

  // Check if required extensions exist.
  csrr   t1, misa
  addi   t2, x0, 1 	
  slli   t2, t2, 20      // U_EXTENSION
  and    t2, t1, t2
  bne    x0, t2, 1f
  addi   t2, x0, 1
  slli   t2, t2, 18      // S_EXTENSION	
  and    t2, t1, t2
  bne    x0, t2, 1f
  j 2f
1:
  csrwi mideleg, 0
  csrwi medeleg, 0
2:
  csrwi mie, 0

  // Initialize global pointer.
  .option push
  .option norelax
  la gp, __global_pointer$
  .option pop

  // Initialize stack pointer.
  la    sp, stack_bottom
  // Allocate STACK_SIZE for each hart.
  li    t1, STACK_SIZE
  csrr  t0, CSR_MHARTID
  addi  t0, t0, 1
1:
  add   sp, sp, t1
  addi  t0, t0, -1
  bnez  t0, 1b

  // Zero-out the .bss section.
  la    t0, __bss_start
  la    t1, __bss_end
1:
  bge   t0, t1, 2f
  sb    zero, 0(t0)
  addi  t0, t0, 1
  j     1b
2:

  // Jump to main instead of _init.
  j     main

loop_forever:
  j loop_forever

  .align 2
precease:
    li t1, 100000
1:
    addi t1, t1, -1
    bnez t1, 1b
cease:
  .word 0x30500073  // cease instruction.
  j loop_forever

  // Fill the stack with known data to detect overrun.
  .section .data
  .align 4
stack_bottom:
  .fill NHARTS * STACK_SIZE/4, 4, 0x22446688
stack_top:
initialized:
  .word 0
