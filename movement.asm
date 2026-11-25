//define room types
ROOM_EMPTY = 0
ROOM_STARTER = 1
ROOM_GEM = 2
ROOM_TRAP = 3
ROOM_EXIT = 4

//-----------can Player Move?-----------
//Function: tests if the player can move
//Input: w (up), a (left), s (down), d (right)
//Output: boolean (1 = valid, 0 = invalid)
// ---------------- Room Can Move? ----------------
define(cpm_dir, w19)
define(cpm_row, w20)
define(cpm_col, w21)
define(cpm_dest_row, w22)
define(cpm_dest_col, w23)
    .global canPlayerMove
canPlayerMove:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!

    mov cpm_dir, w0

    // Get player position
    ldr x9, =player_y
    ldr cpm_row, [x9]

    ldr x9, =player_x
    ldr cpm_col, [x9]

    // Determine destination
    cmp cpm_dir, #0
    b.eq cpm_up

    cmp cpm_dir, #1
    b.eq cpm_left

    cmp cpm_dir, #2
    b.eq cpm_down

    cmp cpm_dir, #3
    b.eq cpm_right

    b cpm_invalid

cpm_left:
    sub cpm_dest_col, cpm_col, #1
    mov cpm_dest_row, cpm_row
    b cpm_bounds

cpm_up:
    sub cpm_dest_row, cpm_row, #1
    mov cpm_dest_col, cpm_col
    b cpm_bounds

cpm_right:
    add cpm_dest_col, cpm_col, #1
    mov cpm_dest_row, cpm_row
    b cpm_bounds

cpm_down:
    add cpm_dest_row, cpm_row, #1
    mov cpm_dest_col, cpm_col

// ------ Check bounds ------
cpm_bounds:
    cmp cpm_dest_row, #0
    b.lt cpm_invalid

    cmp cpm_dest_row, #MINIMAP_ROWS
    b.ge cpm_invalid

    cmp cpm_dest_col, #0
    b.lt cpm_invalid

    cmp cpm_dest_col, #MINIMAP_COLS
    b.ge cpm_invalid

    // Check room connectivity
    mov w0, cpm_dest_row
    mov w1, cpm_dest_col
    bl room_is_connected

    b cpm_done

cpm_invalid:
    mov w0, #0

cpm_done:
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp fp, lr, [sp], #16
    ret

//---------------movePlayer--------------
//Function: moves the player up, left, right, down 
//input: <int> 0, 1, 2, 3 (WASD)
//Output: 

define(mp_dir, w19)
define(mp_row, w20)
define(mp_col, w21)

    .global movePlayer
movePlayer:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    stp x19, x20, [sp, #-16]!
    str x21, [sp, #-16]!

    mov mp_dir, w0

    // Check if movement is allowed
    bl canPlayerMove

    cmp w0, #1
    b.ne mp_invalid

    // Load current position
    ldr x9, =player_y
    ldr mp_row, [x9]

    ldr x9, =player_x
    ldr mp_col, [x9]

    // Update coordinates
    cmp mp_dir, #0
    b.eq mp_up

    cmp mp_dir, #1
    b.eq mp_left

    cmp mp_dir, #2
    b.eq mp_down

    cmp mp_dir, #3
    b.eq mp_right

    b mp_invalid

mp_left:
    sub mp_col, mp_col, #1
    b mp_update

mp_up:
    sub mp_row, mp_row, #1
    b mp_update

mp_right:
    add mp_col, mp_col, #1
    b mp_update

mp_down:
    add mp_row, mp_row, #1

// ------ Save new position ------
mp_update:
    ldr x9, =player_y
    str mp_row, [x9]

    ldr x9, =player_x
    str mp_col, [x9]

    mov w0, #1
    b mp_done

mp_invalid:
    mov w0, #0

mp_done:
    ldr x21, [sp], #16
    ldp x19, x20, [sp], #16

    ldp fp, lr, [sp], #16
    ret