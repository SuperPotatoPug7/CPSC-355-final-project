// --------    R/W section     --------
    .bss

    .data

// holds room data
// <int> the number of remaining avaliable rooms
num_avaliable_rooms:
            .word 20
// 1D global int array of size 20 (holds avaliable room indexes)
avaliable_room_cards:
            .word 1
            .word 2
            .word 3
            .word 4
            .word 5
            .word 6
            .word 7
            .word 8
            .word 9
            .word 10
            .word 11
            .word 12
            .word 13
            .word 14
            .word 15
            .word 16
            .word 17
            .word 18
            .word 19
            .word 20
// 1D global 2-byte array of size 20
    .global room_cards
room_cards:
            // --- 0: STARTER ROOM (1) ---
            .byte 0b11110000 
            .byte 0b00000001 // 0: L, U, R, D (4-Way)      / Starter Room

            // --- 1 to 6: EMPTY ROOMS (6) ---
            .byte 0b10100000 
            .byte 0b00000000 // 1: L, R (Horizontal)       / Empty Room

            .byte 0b01010000 
            .byte 0b00000000 // 2: U, D (Vertical)         / Empty Room
            
            .byte 0b10100000 
            .byte 0b00000000 // 3: L, R (Horizontal)    / Empty Room
            
            .byte 0b01010000 
            .byte 0b00000000 // 4: U, D (Vertical)    / Empty Room
            
            .byte 0b11010000 
            .byte 0b00000000 // 5: L, U, D (T-Junction)    / Empty Room
            
            .byte 0b01110000 
            .byte 0b00000000 // 6: U, R, D (T-Junction)    / Empty Room
            
            // --- 7 to 14: GEM ROOMS (8) ---
            .byte 0b11001100 
            .byte 0b00000010 // 7: L, U (Corner)           / Gem Room
            
            .byte 0b01101100 
            .byte 0b00000010 // 8: U, R (Corner)           / Gem Room
            
            .byte 0b00111100 
            .byte 0b00000010 // 9: R, D (Corner)           / Gem Room
            
            .byte 0b10011100 
            .byte 0b00000010 // 10: L, D (Corner)          / Gem Room
            
            .byte 0b11101100 
            .byte 0b00000010 // 11: L, U, R (T-Junction)   / Gem Room
            
            .byte 0b01111100 
            .byte 0b00000010 // 12: U, R, D (T-Junction)   / Gem Room
            
            .byte 0b00011100 
            .byte 0b00000010 // 13: D (Dead End)  / Gem Room
            
            .byte 0b00011100 
            .byte 0b00000010 // 14: D (Dead End)   / Gem Room
            
            // --- 15 to 18: TRAP ROOMS (4) ---
            .byte 0b11101000 
            .byte 0b00000011 // 15: L, U, R (T-Junction)      / Trap Room
            
            .byte 0b01111000 
            .byte 0b00000011 // 16: U, R, D (T-Junction)      / Trap Room
            
            .byte 0b11111000 
            .byte 0b00000011 // 17: L, U, R, D (4-Way)     / Trap Room
            
            .byte 0b11111000 
            .byte 0b00000011 // 18: L, U, R, D (4-Way)     / Trap Room
            
            // --- 19: EXIT ROOM (1) ---
            .byte 0b00011000 
            .byte 0b00000100 // 19: D (Dead End)     / Exit Room

// 2D global 2-byte array of size 7x7
// initialized to 0b11111111 / 0b11111111 (empty, no puzzle)
    .global minimap
minimap:
    .skip 98, 0xFF

// global 4-byte ints: player x & y locations
    .global player_x
    .global player_y
player_x:
    .word 0
player_y:
    .word 0

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

    bl init_minimap // initializes starter room
    // (test) adds a room
    mov w0, #19
    mov w1, #3
    mov w2, #4
    bl add_to_minimap
    bl render_minimap // (test) renders minimap

    // TODO

    //      resetting
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret
