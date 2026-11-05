// io.asm
define(fp, x29)
define(lr, x30)

    .data
prompt_str:     .string "Move (w/a/s/d): "
input_fmt:      .string " %c"          // leading space skips leftover newline
bad_input_str:  .string "Invalid input.\n"

    .text
    .balign 4

// ---------------- Get Move ----------------
// Function:    prompts the player and reads one character
// Input:       void
// Output:      w0: the character typed
    .global get_move
get_move:
    stp fp, lr, [sp, #-32]!
    mov fp, sp

    ldr x0, =prompt_str
    bl  printf

    ldr x0, =input_fmt
    add x1, sp, #16            // scratch space on the stack for the char
    bl  scanf

    ldrb w0, [sp, #16]         // return the char in w0

    ldp fp, lr, [sp], #32
    ret