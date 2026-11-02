    .data

define(fp, x29)
define(lr, x30)

// constants
MINIMAP_ROWS = 11
MINIMAP_COLS = 11

// Bit positions in room_cards Byte 0 (0b11110000)
BIT_LEFT  = 7
BIT_UP    = 6
BIT_RIGHT = 5
BIT_DOWN  = 4

// minimap output strings
up_str: .string             " ┏━┓ "
up_connect_str: .string     " ┏┻┓ "
left_str: .string           " ┃"
left_connect_str: .string   "━┫"
right_str: .string             "┃ "
right_connect_str: .string     "┣━"
down_str: .string           " ┗━┛ "
down_connect_str: .string   " ┗┳┛ "

blank_room_row: .string     "     "

gem_str: .string            "✧"
trap_str: .string           "!"
character_str: .string      "X"
exit_str: .string           "☆"
empty_str: .string          " "

border_h: .string           "##############################################"
border_v:.string            "#"

    .text
    .balign 4

// ======================================
// ---------------- Minimap ----------------
// ======================================

define(card_idx_w,  w0)
define(row,         w1)
define(col,         w2)
define(mimimap_ptr, x9)
define(offset_w,    w10)
define(cols,        w11)

// ---------------- Add To Minimap ----------------
// Function:    adds a room to the minimap, connecting it to the player's room
// Input:       w0: card index, w1: minimap row, w2: minimap colunm
// Output:      void
    .global add_to_minimap
add_to_minimap:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // load minimap address
    ldr mimimap_ptr, =minimap

    // TODO: calculate rotation

    // Store room_card_index at Byte 0 of minimap[i][j]
    mov  cols, #MINIMAP_COLS
    madd offset_w, row, cols, col
    lsl  offset_w, offset_w, #1
    strb card_idx_w, [mimimap_ptr, offset_w, sxtw]

    // TODO: link puzzle

    // TODO: update card avaliability

    ldp fp, lr, [sp], #16
    ret

// ---------------- Init Minimap ----------------
// Function:    initializes the minimap with the starter room in the center
// Input:       void
// Output:      void
init_minimap:
    //      function stack allocation
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    mov w0, #0
    mov w1, #5
    mov w1, #5
    bl add_to_minimap

    //      resetting
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret

define(r_row,       w19)
define(r_col,       w20)
define(r_pass,      w21)
define(r_map_base,  x22)
define(r_card_base, x23)
define(r_byte0,     w24)
define(r_byte1,     w25)

// ---------------- Render Minimap ----------------
// Function:    Renders the minimap
// Input:       void
// Output:      void
render_minimap:
    //      Function stack allocation
    stp fp, lr, [sp, #-64]!
    mov fp, sp
    // Callee-saved registers
    stp x19, x20, [sp, #16]
    stp x21, x22, [sp, #32]
    stp x23, x24, [sp, #48]
    str x25, [sp, #56]

    // TODO: print upper border

    // TODO: loop for # rows
    //      TODO: loop for # cols, printing L & R border as well
    //          TODO: pass 1- print upper room ascii
    //          TODO: pass 2- print center room ascii
    //          TODO: pass 3- print lower room ascii

    // TODO: print lower border

    //      Resetting
    ldr x25, [sp, #56]
    ldp x23, x24, [sp, #48]
    ldp x21, x22, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp fp, lr, [sp], #64
    mov w0, #0
    ret
