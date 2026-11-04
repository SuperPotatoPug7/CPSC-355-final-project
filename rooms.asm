    .data

define(fp, x29)
define(lr, x30)

    .text
    .balign 4

// ---------------- Rotate ----------------
// Function:    takes a byte and rotates the leftmost four bits by one
//              (used for room rotations)
// Input:       w0: room byte
// Output:      w0: room byte (rotated)
    .global rotate
rotate:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

    ldp fp, lr, [sp], #16
    ret