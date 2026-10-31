// --------    R/W section     --------
    .bss

// holds room data
// 1D global 1-byte array of size 20
room_cards: .byte // TODO: design room cards
            0b01111100 // starter room, LURD, N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
            0b00000000 // empty room, , N, N
// Global int: number of rooms
num_of_rooms: .quad 20

// 2D global 2-byte array of size 21x21
// initialized to 0b11111111 / 0b11111111 (empty, no puzzle)
minimap:
    .fill 441, 2, 0xFFFF


    .data

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
