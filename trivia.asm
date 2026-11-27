// ====================================================
// ---------------- Trivia ----------------
// ====================================================

    .data

define(fp, x29)
define(lr, x30)
// skips whitespace, reads 1 char, then discards the rest of the line (so extra typed
// characters are not read as the answer to the next prompt)
trivia_scan_fmt:.string " %c%*[^\n]"

// global 4-byte int: the number of gems the player is holding
    .balign 4
    .global gem_count
gem_count:
    .word 0

// global 4-byte int: the number of questions in trivia_questions
    .global num_trivia_questions
num_trivia_questions:
    .word 40

// ---------------- Trivia Prompt Strings ----------------
// each string is a question followed by its 4 numbered choices (1-4), ending in a newline

trivia_prompt_0:
    .ascii  "How many general-purpose registers does AArch64 have?\n"
    .ascii  "  1) 16\n"
    .ascii  "  2) 30\n"
    .ascii  "  3) 31\n"
    .string "  4) 32\n"

trivia_prompt_1:
    .ascii  "Which instruction copies the value of one register into another?\n"
    .ascii  "  1) mov\n"
    .ascii  "  2) cmp\n"
    .ascii  "  3) ret\n"
    .string "  4) bl\n"

trivia_prompt_2:
    .ascii  "Which pseudo-op makes the label main visible to the linker?\n"
    .ascii  "  1) .string\n"
    .ascii  "  2) .balign\n"
    .ascii  "  3) .word\n"
    .string "  4) .global\n"

trivia_prompt_3:
    .ascii  "Which register name uses only the low-order 32 bits of register 19?\n"
    .ascii  "  1) x19\n"
    .ascii  "  2) w19\n"
    .ascii  "  3) r19\n"
    .string "  4) b19\n"

trivia_prompt_4:
    .ascii  "Which registers are used to pass arguments into a function?\n"
    .ascii  "  1) x0 - x7\n"
    .ascii  "  2) x9 - x15\n"
    .ascii  "  3) x19 - x28\n"
    .string "  4) x29 and x30\n"

trivia_prompt_5:
    .ascii  "Which register is the frame pointer (FP)?\n"
    .ascii  "  1) x0\n"
    .ascii  "  2) x19\n"
    .ascii  "  3) x30\n"
    .string "  4) x29\n"

trivia_prompt_6:
    .ascii  "Which register is the link register (LR)?\n"
    .ascii  "  1) x8\n"
    .ascii  "  2) x30\n"
    .ascii  "  3) x29\n"
    .string "  4) x18\n"

trivia_prompt_7:
    .ascii  "Which registers are callee-saved, meaning a function you call preserves their values?\n"
    .ascii  "  1) x0 - x7\n"
    .ascii  "  2) x9 - x15\n"
    .ascii  "  3) x19 - x28\n"
    .string "  4) x16 and x17\n"

trivia_prompt_8:
    .ascii  "What value do you get when you read from the zero register (XZR or WZR)?\n"
    .ascii  "  1) 0\n"
    .ascii  "  2) 1\n"
    .ascii  "  3) -1\n"
    .string "  4) The last value written to it\n"

trivia_prompt_9:
    .ascii  "Which register points to the top of the run-time stack?\n"
    .ascii  "  1) PC\n"
    .ascii  "  2) LR\n"
    .ascii  "  3) XZR\n"
    .string "  4) SP\n"

trivia_prompt_10:
    .ascii  "Which prefix marks an immediate as hexadecimal?\n"
    .ascii  "  1) 0b\n"
    .ascii  "  2) 0x\n"
    .ascii  "  3) 0h\n"
    .string "  4) 0d\n"

trivia_prompt_11:
    .ascii  "Which instruction calls a function and remembers where to come back to?\n"
    .ascii  "  1) b\n"
    .ascii  "  2) cmp\n"
    .ascii  "  3) bl\n"
    .string "  4) mov\n"

trivia_prompt_12:
    .ascii  "After a function call, which register holds the return value?\n"
    .ascii  "  1) x0\n"
    .ascii  "  2) x19\n"
    .ascii  "  3) x29\n"
    .string "  4) x30\n"

trivia_prompt_13:
    .ascii  "Is ARMv8-A a RISC or a CISC architecture?\n"
    .ascii  "  1) CISC\n"
    .ascii  "  2) RISC\n"
    .ascii  "  3) Both\n"
    .string "  4) Neither\n"

trivia_prompt_14:
    .ascii  "In stp x29, x30, [sp, -16]! how many bytes of stack memory are allocated?\n"
    .ascii  "  1) 8\n"
    .ascii  "  2) 29\n"
    .ascii  "  3) 30\n"
    .string "  4) 16\n"

trivia_prompt_15:
    .ascii  "Which instruction returns control to the calling code?\n"
    .ascii  "  1) bl\n"
    .ascii  "  2) cmp\n"
    .ascii  "  3) ret\n"
    .string "  4) mov\n"

trivia_prompt_16:
    .ascii  "What does add x19, x20, x21 calculate?\n"
    .ascii  "  1) x19 = x20 + x21\n"
    .ascii  "  2) x21 = x19 + x20\n"
    .ascii  "  3) x20 = x19 + x21\n"
    .string "  4) x19 = x19 + x20 + x21\n"

trivia_prompt_17:
    .ascii  "Which instruction does signed integer division?\n"
    .ascii  "  1) mul\n"
    .ascii  "  2) udiv\n"
    .ascii  "  3) sub\n"
    .string "  4) sdiv\n"

trivia_prompt_18:
    .ascii  "What does dividing by 0 with sdiv or udiv write to the destination register?\n"
    .ascii  "  1) -1\n"
    .ascii  "  2) 0\n"
    .ascii  "  3) The numerator\n"
    .string "  4) Nothing: the program crashes\n"

trivia_prompt_19:
    .ascii  "Which instruction multiplies two registers?\n"
    .ascii  "  1) add\n"
    .ascii  "  2) sub\n"
    .ascii  "  3) mul\n"
    .string "  4) cmp\n"

trivia_prompt_20:
    .ascii  "Which instruction is useful for calculating the remainder after a division?\n"
    .ascii  "  1) msub\n"
    .ascii  "  2) ret\n"
    .ascii  "  3) bl\n"
    .string "  4) cmp\n"

trivia_prompt_21:
    .ascii  "When calling printf, what goes in x0?\n"
    .ascii  "  1) The number of arguments\n"
    .ascii  "  2) The return address\n"
    .ascii  "  3) The stack pointer\n"
    .string "  4) The address of the format string\n"

trivia_prompt_22:
    .ascii  "Which instruction always jumps to a label, with no condition and no linking?\n"
    .ascii  "  1) b.eq\n"
    .ascii  "  2) b\n"
    .ascii  "  3) cmp\n"
    .string "  4) ret\n"

trivia_prompt_23:
    .ascii  "How many condition flags does ARMv8 have?\n"
    .ascii  "  1) 2\n"
    .ascii  "  2) 3\n"
    .ascii  "  3) 4\n"
    .string "  4) 8\n"

trivia_prompt_24:
    .ascii  "Which condition flag is true when a result is zero?\n"
    .ascii  "  1) Z\n"
    .ascii  "  2) N\n"
    .ascii  "  3) C\n"
    .string "  4) V\n"

trivia_prompt_25:
    .ascii  "Which condition flag is true when a result is negative?\n"
    .ascii  "  1) Z\n"
    .ascii  "  2) C\n"
    .ascii  "  3) V\n"
    .string "  4) N\n"

trivia_prompt_26:
    .ascii  "What does cmp x1, x2 do?\n"
    .ascii  "  1) Copies x2 into x1\n"
    .ascii  "  2) Subtracts x2 from x1 and only updates the condition flags\n"
    .ascii  "  3) Adds x1 and x2 and stores the sum in x1\n"
    .string "  4) Swaps x1 and x2\n"

trivia_prompt_27:
    .ascii  "After cmp, which branch is taken only if the two values were equal?\n"
    .ascii  "  1) b.ne\n"
    .ascii  "  2) b.gt\n"
    .ascii  "  3) b.eq\n"
    .string "  4) b.lt\n"

trivia_prompt_28:
    .ascii  "What is special about instructions that end in s, such as adds and subs?\n"
    .ascii  "  1) They also set the condition flags\n"
    .ascii  "  2) They only work on strings\n"
    .ascii  "  3) They save the result on the stack\n"
    .string "  4) They run more slowly\n"

trivia_prompt_29:
    .ascii  "How many times is the body of a do loop guaranteed to run?\n"
    .ascii  "  1) Zero times\n"
    .ascii  "  2) Exactly twice\n"
    .ascii  "  3) Exactly ten times\n"
    .string "  4) At least once\n"

trivia_prompt_30:
    .ascii  "After cmp x19, x20 which branch is taken only if x19 is greater than x20?\n"
    .ascii  "  1) b.lt\n"
    .ascii  "  2) b.gt\n"
    .ascii  "  3) b.eq\n"
    .string "  4) b.le\n"

trivia_prompt_31:
    .ascii  "Which instruction stores a pair of registers to the stack?\n"
    .ascii  "  1) ldp\n"
    .ascii  "  2) ret\n"
    .ascii  "  3) stp\n"
    .string "  4) bl\n"

trivia_prompt_32:
    .ascii  "How many bits wide is register x0?\n"
    .ascii  "  1) 64\n"
    .ascii  "  2) 32\n"
    .ascii  "  3) 16\n"
    .string "  4) 8\n"

trivia_prompt_33:
    .ascii  "In ARMv8 assembly, what starts a comment?\n"
    .ascii  "  1) ;\n"
    .ascii  "  2) --\n"
    .ascii  "  3) REM\n"
    .string "  4) //\n"

trivia_prompt_34:
    .ascii  "Which instruction loads a value from memory into a register?\n"
    .ascii  "  1) str\n"
    .ascii  "  2) ldr\n"
    .ascii  "  3) mov\n"
    .string "  4) cmp\n"

trivia_prompt_35:
    .ascii  "Which command assembles and links myprog.s into an executable called myprog?\n"
    .ascii  "  1) ls myprog.s\n"
    .ascii  "  2) m4 myprog.s\n"
    .ascii  "  3) gcc myprog.s -o myprog\n"
    .string "  4) ret myprog\n"

trivia_prompt_36:
    .ascii  "How many bits does one hexadecimal digit represent?\n"
    .ascii  "  1) 4\n"
    .ascii  "  2) 2\n"
    .ascii  "  3) 3\n"
    .string "  4) 8\n"

trivia_prompt_37:
    .ascii  "In A64, how many bits are in a word?\n"
    .ascii  "  1) 8\n"
    .ascii  "  2) 16\n"
    .ascii  "  3) 64\n"
    .string "  4) 32\n"

trivia_prompt_38:
    .ascii  "An int is 4 bytes. How many bytes does the array int ia[5] take up?\n"
    .ascii  "  1) 5\n"
    .ascii  "  2) 20\n"
    .ascii  "  3) 9\n"
    .string "  4) 40\n"

trivia_prompt_39:
    .ascii  "Which instruction adds 1 to x19?\n"
    .ascii  "  1) mov x19, 1\n"
    .ascii  "  2) sub x19, x19, 1\n"
    .ascii  "  3) add x19, x19, 1\n"
    .string "  4) cmp x19, 1\n"

// ---------------- Trivia Question Array ----------------
// 1D global array of size 40, 16 bytes per entry:
//   bytes 0-7:  <pointer> the prompt string
//   bytes 8-15: <8-byte int> the number of the correct choice (1-4)
    .balign 8
    .global trivia_questions
trivia_questions:
    .xword trivia_prompt_0, 3
    .xword trivia_prompt_1, 1
    .xword trivia_prompt_2, 4
    .xword trivia_prompt_3, 2
    .xword trivia_prompt_4, 1
    .xword trivia_prompt_5, 4
    .xword trivia_prompt_6, 2
    .xword trivia_prompt_7, 3
    .xword trivia_prompt_8, 1
    .xword trivia_prompt_9, 4
    .xword trivia_prompt_10, 2
    .xword trivia_prompt_11, 3
    .xword trivia_prompt_12, 1
    .xword trivia_prompt_13, 2
    .xword trivia_prompt_14, 4
    .xword trivia_prompt_15, 3
    .xword trivia_prompt_16, 1
    .xword trivia_prompt_17, 4
    .xword trivia_prompt_18, 2
    .xword trivia_prompt_19, 3
    .xword trivia_prompt_20, 1
    .xword trivia_prompt_21, 4
    .xword trivia_prompt_22, 2
    .xword trivia_prompt_23, 3
    .xword trivia_prompt_24, 1
    .xword trivia_prompt_25, 4
    .xword trivia_prompt_26, 2
    .xword trivia_prompt_27, 3
    .xword trivia_prompt_28, 1
    .xword trivia_prompt_29, 4
    .xword trivia_prompt_30, 2
    .xword trivia_prompt_31, 3
    .xword trivia_prompt_32, 1
    .xword trivia_prompt_33, 4
    .xword trivia_prompt_34, 2
    .xword trivia_prompt_35, 3
    .xword trivia_prompt_36, 1
    .xword trivia_prompt_37, 4
    .xword trivia_prompt_38, 2
    .xword trivia_prompt_39, 3

// ====================================================
// ---------------- Trivia Results ----------------
// ====================================================

    .text
    .balign 4

// ---------------- Update Room Flags & Gem Count From Trivia Answer ----------------
// Function:    updates the player's current room & the gem count after a trivia question.
//              correct: the player gains two gems (if the room still has its gem)
//              incorrect: the player loses a gem (the count never goes below 0)
//              either way, the room's has_active_puzzle & still_has_gem flags are
//              set to 0, so the question can't be triggered again
// Input:       w0: <int> trivia prompt index (unused), w1: <boolean> 1 = correct, 0 = incorrect
// Output:      void
define(ur_correct, w19)
define(ur_flags_ptr, x0)
define(ur_flags, w9)
define(ur_has_gem, w10)
define(ur_gem_count_ptr, x11)
define(ur_gem_count, w12)
    .global update_room_flags_and_gem_count_from_trivia_answer
update_room_flags_and_gem_count_from_trivia_answer:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    str x19, [sp, #-16]!

    // save the answer result across the function call
    mov ur_correct, w1

    // get the room card of the room the player is in
    ldr x9, =player_y
    ldr w0, [x9]
    ldr x9, =player_x
    ldr w1, [x9]
    bl get_room_pointer

    // no room card at the player's position -> nothing to update
    cbz w1, ur_done

    // load the room's flags & the gem count
    ldrb ur_flags, [ur_flags_ptr]
    ldr ur_gem_count_ptr, =gem_count
    ldr ur_gem_count, [ur_gem_count_ptr]

    cbz ur_correct, ur_incorrect

// ------ Correct: gain two gems if the room still has its gem (the still_has_gem flag, bit 2, is 0 or 1) ------
    ubfx ur_has_gem, ur_flags, #2, #1
    add ur_gem_count, ur_gem_count, ur_has_gem, lsl #1     // + (0 or 1) * 2
    b ur_store

// ------ Incorrect: lose a gem, if there is one to lose ------
ur_incorrect:
    cbz ur_gem_count, ur_store
    sub ur_gem_count, ur_gem_count, #1

// ------ Save the gem count & clear has_active_puzzle (bit 3) and still_has_gem (bit 2) ------
ur_store:
    str ur_gem_count, [ur_gem_count_ptr]
    mov w13, #0b00001100
    bic ur_flags, ur_flags, w13
    strb ur_flags, [ur_flags_ptr]

ur_done:
    ldr x19, [sp], #16
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret

.global selectRandomTriviaQuestion
selectRandomTriviaQuestion:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    bl rand // puts w0 = the random num

    ldr x9, =num_trivia_questions // 40 questions
    ldr w9, [x9] // w9 =40

    udiv w10, w0, w9 // divide the random num by the num of questions
    msub w10, w10, w9, w0 // w10 = w0 - (w10 * w9)

    mov w0, w10

    ldp fp, lr, [sp], #16     // restore fp & lr
    ret

.global printTriviaPrompt
printTriviaPrompt:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    ldr x9, =trivia_questions // the array address

    mov w11, #16 
    umull x10, w0, w11 

    add x9, x9, x10 // x9 = the address of this question's entry: start of the list + current position
    ldr x0, [x9] // x0 is the pointer to the question string

    bl printf

    ldp fp, lr, [sp], #16
    ret

.global takeTriviaAnswer
takeTriviaAnswer:

    stp fp, lr, [sp, #-32]!
    mov fp, sp
    str x19, [sp, #24]
    mov w19, w0

    strb wzr, [sp, #16] // clear the char buffer (so no input counts as a wrong answer)
    ldr x0, =trivia_scan_fmt
    add x1, sp, #16
    bl scanf

    ldrb w9, [sp, #16] // the character the user typed
    sub w9, w9, #'0' // turn the char into a number

    ldr x10, =trivia_questions // x10 = the start of the list
    mov x11, #16 // representing the 16 byte size of each element
    mul x12, x19, x11 // depth of the q
    add x10, x10, x12 // the address = x10
    add x10, x10, #8  // skip the 8 byte question pointer to get the answer

    ldr w13, [x10] // w13 = the correct answer
    cmp w9, w13

    mov w0, #1
    b.eq trivia_answer_correct
    mov w0, #0

    trivia_answer_correct:
    ldr x19, [sp, #24]
    ldp fp, lr, [sp], #32
    ret
