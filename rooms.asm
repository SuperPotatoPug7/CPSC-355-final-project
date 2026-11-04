    .data

define(fp, x29)
define(lr, x30)

    .text
    .balign 4


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


// ---------------- Connect Room ----------------
// Function:    rotates a room in memory until it is connected to the
//              room the player is currently in
// Input:       w0: minimap row, w1: minimap colunm
// Output:      w0: boolean: 1 = True, 0 = False
    .global connect_room
connect_room:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

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
define(room_row, w0)
define(room_col, w1)
define(player_row, w9)
define(player_col, w10)
define(direction_bitmask, x19)
    .global room_is_connected
room_is_connected:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    stp x19, x20, [sp, #-16]!

    //      load player pos
    ldr player_row, =player_x
    ldr player_col, =player_y

    //      determine if L, R, U, or D of player; set bit mask accordingly
    cmp target_col, p_col
    b.lt dir_left           // target_col < p_col -> left of player
    b.gt dir_right          // target_col > p_col -> right of player
    cmp target_row, p_row
    b.lt dir_up             // target_row < p_row -> above player
    b.gt dir_down           // target_row > p_row -> below player
    b not_connected
dir_left:
    mov direction_bitmask, #0b10000000
    b load_rooms
dir_up:
    mov dir_mask, #0b01000000
    b load_rooms
dir_right:
    mov dir_mask, #0b00100000
    b load_rooms
dir_down:
    mov dir_mask, #0b00010000

    // TODO: rotate & compare room flags w/ bitmask

not_connected:
    mov w0, #0

done_connected:
    ldp x19, x20, [sp], #16
    ldp fp, lr, [sp], #16
    ret