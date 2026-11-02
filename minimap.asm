    .data

define(fp, x29)
define(lr, x30)

// constants
MINIMAP_COLS = 21

// minimap output strings
up_str: .string             " ┏━┓ "
up_connect_str: .string     " ┏┻┓ "
left_str: .string           " ┃"
left_connect_str: .string   "━┫"
right_str: .string             "┃ "
right_connect_str: .string     "┣━"
down_str: .string           " ┗━┛ "
down_connect_str: .string   " ┗┳┛ "

gem_str: .string            "✧"
trap_str: .string           "!"
character_str: .string      "X"
exit_str: .string           "☆"
empty_str: .string          " "

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
