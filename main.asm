// --------    R/W section     --------
    .bss

// holds room data
// 1 byte
starter_room_card: .byte 0b01111100 // starter room, LURD, N, N
// 1D global 2-byte array of size 19
room_cards: .byte // TODO: design room cards
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