    .data

define(fp, x29)
define(lr, x30)

prompt_str:  .string "Move (w/a/s/d): "
scan_fmt:    .string " %c%*[^\n]"
invalid_str: .string "Invalid input. Use w, a, s, or d.\n"

    .text
    .balign 4

// ---------------- Prompt WASD ----------------
// Function:    prints a prompt, reads one character, and re-asks until it is
//              w, a, s, or d (upper case is accepted too)
// Input:       void
// Output:      w0: <int> 0 = up (w), 1 = left (a), 2 = down (s), 3 = right (d),
//                  or -1 if the input ended (EOF) before a move was read
define(pw_char, w9)
    .global prompt_wasd
prompt_wasd:
    stp fp, lr, [sp, #-32]!
    mov fp, sp

pw_loop:
    ldr x0, =prompt_str
    bl printf

    strb wzr, [sp, #16]         // clear the char buffer
    ldr x0, =scan_fmt           // " %c" -> skip whitespace, read 1 char
    add x1, sp, #16             // x1 = address of the buffer
    bl scanf
    cmp w0, #1                  // scanf returns 1 when it read the char
    b.ne pw_eof                 // anything else: no input left, so stop asking

    ldrb pw_char, [sp, #16]
    orr pw_char, pw_char, #0x20 // force lower case

    cmp pw_char, #0x77          // 'w'
    b.ne pw_not_w
    mov w0, #0
    b pw_done
pw_not_w:
    cmp pw_char, #0x61          // 'a'
    b.ne pw_not_a
    mov w0, #1
    b pw_done
pw_not_a:
    cmp pw_char, #0x73          // 's'
    b.ne pw_not_s
    mov w0, #2
    b pw_done
pw_not_s:
    cmp pw_char, #0x64          // 'd'
    b.ne pw_invalid
    mov w0, #3
    b pw_done

pw_invalid:
    ldr x0, =invalid_str
    bl printf
    b pw_loop                   // ask again

pw_eof:
    mov w0, #-1

pw_done:
    ldp fp, lr, [sp], #32
    ret
