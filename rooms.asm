    .data

MINIMAP_COLS = 7

define(fp, x29)
define(lr, x30)

    .text
    .balign 4

// ---------------- Get Room Pointer ----------------
// Function:    Gets the room card associated with an i,j index on
//              the minimap.
// Input:       w0: minimap row, w1: minimap colunm
// Output:      x0: room card pointer, w1: boolean success (1 = found, 0 = not found)
define(gr_row, w0)
define(gr_col, w1)
define(gr_room_card_ptr, x0)
define(gr_success, w1)
define(gr_minimap_ptr, x9)
define(gr_room_cards_ptr, x10)
define(gr_cols, w11)
define(gr_offset_w, w12)
define(gr_card_index, w13)
    .global get_room_pointer
get_room_pointer:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // load minimap & room cards addresses
    ldr gr_minimap_ptr, =minimap
    ldr gr_room_cards_ptr, =room_cards

    // Get target's room_card_index at Byte 0 of minimap[i][j]
    mov  gr_cols, #MINIMAP_COLS
    madd gr_offset_w, gr_row, gr_cols, gr_col
    lsl  gr_offset_w, gr_offset_w, #1
    ldrb gr_card_index, [gr_minimap_ptr, gr_offset_w, sxtw]

    // if target tile is empty (0xFF), not enterable
    cmp gr_card_index, #0b11111111
    b.eq gr_is_empty_room

    // get room card pointer using room card index
    lsl gr_offset_w, gr_card_index, #1
    add gr_room_card_ptr, gr_room_cards_ptr, gr_offset_w, uxtw
    mov gr_success, #1
    b gr_done

gr_is_empty_room:

    mov gr_room_card_ptr, #0
    mov gr_success, #0

gr_done:

    ldp fp, lr, [sp], #16
    ret


// ---------------- Connect Room ----------------
// Function:    rotates a room in memory until it is connected to the
//              room the player is currently in
// Input:       w0: minimap row, w1: minimap colunm
// Output:      void
define(minimap_ptr, x11)
define(room_cards_ptr, x12)
define(card_index, w13)
define(offset_w, w14)
define(saved_row, w19)
define(saved_col, w20)
define(card_flags_ptr, x21)
define(c_i, x22)
    .global connect_room
connect_room:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!

    // Save input coordinates across function calls
    mov saved_row, w0
    mov saved_col, w1

    // get room card pointer
    bl get_room_pointer
    mov card_flags_ptr, x0

// ------ test & rotate x3 ------

    mov c_i, #0
connect_loop:

    // test
    mov w0, saved_row
    mov w1, saved_col
    bl  room_is_connected
    cmp w0, #1
    b.eq connect_done

    // rotate
    ldrb w0, [card_flags_ptr]
    bl   rotate
    strb w0, [card_flags_ptr]

    // increment & loop
    add c_i, c_i, #1
    cmp c_i, #3
    b.lt connect_loop

connect_done:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp fp, lr, [sp], #16
    ret


// ---------------- Remove Room Avaliablity ----------------
// Function:    removes a room card from the pile of avaliable cards
// Input:       w0: <int> card index
// Output:      void
define(rra_target_idx, w0)
define(rra_cards_ptr, x9)
define(rra_num_ptr, x10)
define(rra_count, w11)
define(rra_i, w12)
define(rra_next_i, w13)
    .global remove_room_avaliability
remove_room_avaliability:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // Load base addresses and current count of available rooms
    ldr rra_cards_ptr, =avaliable_room_cards
    ldr rra_num_ptr, =num_avaliable_rooms
    ldr rra_count, [rra_num_ptr]

// ------ Search for target card index in avaliable_room_cards ------ 
    mov rra_i, #0
rra_search_loop:
    // if target not in array, exit
    cmp rra_i, rra_count
    b.ge rra_done

    // offset = i * 4 bytes (.word)
    lsl rra_offset_w, rra_i, #2
    // get avaliable_rooms[i] & compare to target
    ldr rra_curr_val, [rra_cards_ptr, rra_offset_w, sxtw]
    cmp rra_curr_val, rra_target_idx
    // if found, move to shifting loop
    b.eq rra_shift_loop

    // loop & increment
    add rra_i, rra_i, #1
    b rra_search_loop

// ------ Shift subsequent elements left by 1 ------
rra_shift_loop:
    // check for exit (end of array)
    add rra_next_i, rra_i, #1
    cmp rra_next_i, rra_count
    b.ge rra_update_count

    // TODO

    // loop & increment
    mov rra_i, rra_next_i
    b rra_shift_loop

// ------ Decrement num_avaliable_rooms by 1 ------
rra_update_count:
    sub rra_count, rra_count, #1
    str rra_count, [rra_num_ptr]

rra_done:

    ldp fp, lr, [sp], #16
    ret


// ---------------- Room Is Connected? ----------------
// Function:    checks if the input room is connected to the room of the player's 
//              current position and enterable. (assumes the rooms are adjacent).
// Input:       w0: minimap row, w1: minimap colunm
// Output:      w0: boolean: 1 = True, 0 = False
define(target_row, w0)
define(target_col, w1)
define(target_flags, w0)
define(card_index, w13)
define(direction_bitmask, w19)
define(player_flags, w20)
define(player_row, w21)
define(player_col, w22)
    .global room_is_connected
room_is_connected:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!

    //      load player pos
    ldr x9, =player_y
    ldr player_row, [x9]
    ldr x10, =player_x
    ldr player_col, [x10]

// ------ determine if L, R, U, or D of player; set bit mask accordingly ------

    cmp target_col, player_col
    b.lt dir_left           // target_col < p_col -> left of player
    b.gt dir_right          // target_col > p_col -> right of player
    cmp target_row, player_row
    b.lt dir_up             // target_row < p_row -> above player
    b.gt dir_down           // target_row > p_row -> below player
    b not_connected
dir_left:
    mov direction_bitmask, #0b10000000
    b load_rooms
dir_up:
    mov direction_bitmask, #0b01000000
    b load_rooms
dir_right:
    mov direction_bitmask, #0b00100000
    b load_rooms
dir_down:
    mov direction_bitmask, #0b00010000

// ------ Get Room flags for player's room & target room ------
load_rooms:

    // get the target's room_card boolean flags
    bl get_room_pointer
    cbz  w1, connect_done // (exit early if empty room)
    ldrb target_flags, [x0]

    // get the player's room's room_card boolean flags
    mov w0, player_row
    mov w1, player_col
    bl get_room_pointer
    ldrb player_flags, [x0]

// ------ Rotate & Compare using Bitmask ------

    // rotate target room 180 degrees
    bl rotate
    bl rotate

    // AND-compare them w/ the bitmask; if they match, that means they're connected
    and target_flags, target_flags, player_flags
    and target_flags, target_flags, direction_bitmask
    cmp target_flags, #0
    mov w0, #1
    b.ne done_connected

not_connected:
    mov w0, #0

done_connected:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp fp, lr, [sp], #16
    ret


// ---------------- Rotate ----------------
// Function:    takes a byte and rotates the leftmost four bits by one
//              (used for room rotations)
// Input:       w0: room boolean_flags byte
// Output:      w0: room boolean_flags byte (rotated)
rotate:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // copy & shift left
    and w9, w0, #0b00001111
    lsl w10, w0, #1
    // copy & shift right
    and w10, w10, #0b11100000
    lsr w11, w0, #3
    and w11, w11, #0b00010000
    // recombine
    orr w0, w9, w10
    orr w0, w0, w11

    ldp fp, lr, [sp], #16
    ret