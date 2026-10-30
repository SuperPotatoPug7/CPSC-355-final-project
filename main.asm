// --------    R/W section     --------
    .bss

    .data

define(fp, x29)
define(lr, x30)

// -------- Executable section --------
    .text
    .balign 4
    .global main

// ---------------- Main ----------------

main:
    //      function stack allocation
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

    //      resetting
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret