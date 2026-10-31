// --------    R/W section     --------
    .bss

    .data

// holds room data
// 1D global 2-byte array of size 20
    .global room_cards
room_cards: // TODO: design room cards
            .byte 0b00001111 0b00000001 // Down, Up, Right, Left / Starter Room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room
            .byte 0b00000000 0b00000000 //  / empty room

// 2D global 2-byte array of size 21x21
// initialized to 0b11111111 / 0b11111111 (empty, no puzzle)
    .global minimap
minimap:
    .skip 882, 0xFF

define(fp, x29)
define(lr, x30)

// -------- Executable section --------
    .text
    .balign 4
    .global main



// ======================================
// ---------------- Main ----------------
// ======================================



main:
    //      function stack allocation
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

    //      resetting
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret
