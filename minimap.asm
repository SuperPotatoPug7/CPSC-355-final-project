    .data

define(fp, x29)
define(lr, x30)

// constants
MINIMAP_ROWS = 7
MINIMAP_COLS = 7

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

border_h: .string           "#####################################\n"
border_l:.string            "#"
border_r:.string            "#\n"

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
    mov w9, MINIMAP_ROWS
    mov w10, #2
    udiv w1, w9, w10
    mov w9, MINIMAP_COLS
    udiv w2, w9, w10
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

    ldr r_map_base, =minimap
    ldr r_card_base, =room_cards

    // print upper border
    ldr x0, =border_h
    bl printf

    mov r_row, #0
row_loop:
    cmp r_row, #MINIMAP_ROWS
    b.ge row_loop_done

    // Each row requires 3 passes: 0 = top, 1 = middle, 2 = bottom
    mov r_pass, #0
pass_loop:
    cmp r_pass, #3
    b.ge pass_loop_done

    // Print left border '#'
    ldr x0, =border_l
    bl printf

    // --- 3. Loop through Minimap Columns ---
    mov r_col, #0
col_loop:
    cmp r_col, #MINIMAP_COLS
    b.ge col_loop_done

    // Calculate byte offset: ((r_row * MINIMAP_COLS) + r_col) * 2
    mov w9, #MINIMAP_COLS
    madd w10, r_row, w9, r_col
    lsl w10, w10, #1

    // Load room_card_index (Byte 0 of minimap cell)
    ldrb w11, [r_map_base, w10, sxtw]

    // Check if cell is empty (0xFF)
    cmp w11, #0xFF
    b.ne load_room_card

    // Empty cell: print 5 spaces and continue to next column
    ldr x0, =blank_room_row
    bl printf
    b next_col

load_room_card:
    // Calculate room_cards offset: card_idx * 2
    lsl w11, w11, #1
    ldrb r_byte0, [r_card_base, w11, sxtw]      // Byte 0: connection booleans
    add w11, w11, #1
    ldrb r_byte1, [r_card_base, w11, sxtw]      // Byte 1: room type

    // Route based on current pass (0, 1, or 2)
    cmp r_pass, #0
    b.eq render_pass_0
    cmp r_pass, #1
    b.eq render_pass_1
    b render_pass_2

// --- Pass 0: Upper Room ASCII ---
render_pass_0:
    // TODO

// --- Pass 1: Center Room ASCII (Left + Icon + Right) ---
render_pass_1:
    // TODO

// --- Pass 2: Lower Room ASCII ---
render_pass_2:
    // TODO

next_col:
    add r_col, r_col, #1
    b col_loop

col_loop_done:
    // Print right border '#' and newline
    ldr x0, =border_r
    bl printf

    add r_pass, r_pass, #1
    b pass_loop

pass_loop_done:
    add r_row, r_row, #1
    b row_loop

row_loop_done:

    // print lower border
    ldr x0, =border_h
    bl printf

    //      Resetting
    ldr x25, [sp, #56]
    ldp x23, x24, [sp, #48]
    ldp x21, x22, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp fp, lr, [sp], #64
    mov w0, #0
    ret
