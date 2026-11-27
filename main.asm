// --------    R/W section     --------
    .bss

    .data

// holds room data
// <int> the number of remaining avaliable rooms
    .global num_avaliable_rooms
num_avaliable_rooms:
            .word 19
// 1D global int array of size 19 (holds avaliable room indexes)
    .global avaliable_room_cards
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
    .balign 4
    .global player_x
    .global player_y
player_x:
    .word 0
player_y:
    .word 0

// output strings
m_gems_str:     .string "Gems: %d / %d\n"
m_correct_str:  .string "Correct!\n"
m_wrong_str:    .string "Wrong again BUCKO\n"
m_blocked_str:  .string "You can't go that way.\n"
m_no_rooms_str: .string "There are no undiscovered rooms left.\n"
m_win_str:      .string "You found the exit with %d gems. You win!\n"

define(fp, x29)
define(lr, x30)

// -------- Executable section --------
    .text
    .balign 4
    .global main



// ======================================
// ---------------- Main ----------------
// ======================================



define(m_dir, w19)
define(m_dest_row, w20)
define(m_dest_col, w21)
define(m_trivia_index, w22)
define(m_correct, w23)
main:
    //      function stack allocation
    stp fp, lr, [sp, #-64]!
    mov fp, sp
    //      callee-saved registers
    stp x19, x20, [sp, #16]
    stp x21, x22, [sp, #32]
    str x23, [sp, #48]

    // seed the random number generator with the current time
    mov x0, #0
    bl time
    bl srand

    bl init_minimap // initializes starter room

    // Gameplay Loop
main_loop:

    bl render_minimap // renders minimap

    // win: the player is in the exit room with enough gems
    bl isWinState
    cmp w0, #1
    b.eq m_win

    // check if room has trivia question
    ldr x9, =player_y
    ldr w0, [x9]
    ldr x9, =player_x
    ldr w1, [x9]
    bl get_room_pointer         // w2 = the room card index of the player's room
    mov w0, w2
    bl room_has_trivia_question

    cmp w0, #1
    b.ne m_hs_skip

m_has_trivia:

    // select random trivia question: w0 = trivia prompt index
    bl selectRandomTriviaQuestion
    mov m_trivia_index, w0      // callee-saved, so it survives the calls below

    // print question prompt
    bl printTriviaPrompt

    // take input 1-4 & check against the correct answer: w0 = 1 if correct, 0 if incorrect
    mov w0, m_trivia_index
    bl takeTriviaAnswer
    mov m_correct, w0

    // tell the player how they did
    ldr x0, =m_correct_str
    cmp m_correct, #1
    b.eq m_print_result
    ldr x0, =m_wrong_str
m_print_result:
    bl printf

    // update boolean flags & gem count
    mov w0, m_trivia_index      // (unused by the update function)
    mov w1, m_correct
    bl update_room_flags_and_gem_count_from_trivia_answer

m_hs_skip:

    // print the gem count
    ldr x0, =m_gems_str
    ldr x9, =gem_count
    ldr w1, [x9]
    ldr x9, =required_gems
    ldr w2, [x9]
    bl printf

m_prompt:

    // prompt for WASD
    bl prompt_wasd
    cmp w0, #0
    b.lt main_loop_done
    mov m_dir, w0

    // check if allowed movement
    bl canPlayerMove
    cmp w0, #1
    b.ne m_blocked

    // find the destination tile
    ldr x9, =player_y
    ldr m_dest_row, [x9]
    ldr x9, =player_x
    ldr m_dest_col, [x9]

    // & step once in the chosen direction
    cmp m_dir, #0
    b.eq m_dest_up
    cmp m_dir, #1
    b.eq m_dest_left
    cmp m_dir, #2
    b.eq m_dest_down
    add m_dest_col, m_dest_col, #1
    b m_dest_found
m_dest_up:
    sub m_dest_row, m_dest_row, #1
    b m_dest_found
m_dest_left:
    sub m_dest_col, m_dest_col, #1
    b m_dest_found
m_dest_down:
    add m_dest_row, m_dest_row, #1
m_dest_found:

    // if room exists, move to it
    mov w0, m_dest_row
    mov w1, m_dest_col
    bl get_room_pointer
    cmp w1, #1
    b.eq m_move

    // if room doesn't exist, add it
    bl add_random_room
    cmp w0, #0
    b.lt m_no_rooms
    mov w1, m_dest_row
    mov w2, m_dest_col
    bl add_to_minimap
    b main_loop

m_move:
    mov w0, m_dir
    bl movePlayer
    b main_loop

m_blocked:
    ldr x0, =m_blocked_str
    bl printf
    b m_prompt

m_no_rooms:
    ldr x0, =m_no_rooms_str
    bl printf
    b m_prompt

m_win:
    ldr x0, =m_win_str
    ldr x9, =gem_count
    ldr w1, [x9]
    bl printf

main_loop_done:

    //      resetting
    ldr x23, [sp, #48]
    ldp x21, x22, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp fp, lr, [sp], #64
    mov w0, #0
    ret
