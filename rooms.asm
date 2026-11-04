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
define(gr_cols, w10)
define(gr_offset_w, w11)
define(gr_card_index, w13)
get_room_pointer:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // load minimap & room cards addresses
    ldr gr_minimap_ptr, =minimap
    ldr gr_room_cards_ptr, =room_cards

    // Get target's room_card_index at Byte 0 of minimap[i][j]
    mov  gr_cols, #MINIMAP_COLS
    madd gr_offset_w, gr_row, cols, gr_col
    lsl  gr_offset_w, gr_offset_w, #1
    ldrb card_index, [gr_minimap_ptr, gr_offset_w, sxtw]

    // if target tile is empty (0xFF), not enterable
    cmp card_index, #0b11111111
    b.eq gr_is_empty_room

    lsl offset_w, card_index, #1
    add gr_room_card_ptr, room_cards_ptr, offset_w, uxtw
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
define(cols, w15)
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

    // get room flags pointer
    ldr minimap_ptr, =minimap
    ldr room_cards_ptr, =room_cards
    mov cols, #MINIMAP_COLS
    madd offset_w, saved_row, cols, saved_col
    lsl  offset_w, offset_w, #1
    ldrb card_index, [minimap_ptr, offset_w, sxtw]
    lsl offset_w, card_index, #1
    add card_flags_ptr, room_cards_ptr, offset_w, uxtw

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
    .global remove_room_avaliability
remove_room_avaliability:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

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
define(player_row, w9)
define(player_col, w10)
define(mimimap_ptr, x11)
define(room_cards_ptr, x12)
define(card_index, w13)
define(offset_w,    w14)
define(cols, w15)
define(direction_bitmask, w19)
define(player_flags, w20)
    .global room_is_connected
room_is_connected:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    stp x19, x20, [sp, #-16]!

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

    // load minimap & room cards addresses
    ldr mimimap_ptr, =minimap
    ldr room_cards_ptr, =room_cards

    // Get target's room_card_index at Byte 0 of minimap[i][j]
    mov  cols, #MINIMAP_COLS
    madd offset_w, target_row, cols, target_col
    lsl  offset_w, offset_w, #1
    ldrb card_index, [mimimap_ptr, offset_w, sxtw]
    // if target tile is empty (0xFF), not enterable
    cmp card_index, #0b11111111
    b.eq not_connected
    // get the room_card boolean flags for the target room using the card_index
    lsl offset_w, card_index, #1
    ldrb target_flags, [room_cards_ptr, offset_w, uxtw]

    // Get player's room's room_card_index at Byte 0 of minimap[i][j]
    mov  cols, #MINIMAP_COLS
    madd offset_w, player_row, cols, player_col
    lsl  offset_w, offset_w, #1
    ldrb card_index, [mimimap_ptr, offset_w, sxtw]
    // get the room_card boolean flags for the player's room using the card_index
    lsl offset_w, card_index, #1
    ldrb player_flags, [room_cards_ptr, offset_w, uxtw]

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