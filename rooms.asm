// ---------------- Room Is Connected? ----------------
// Function:    checks if the input room is connected to the room of the player's 
//              current position and enterable. (assumes the rooms are adjacent).
// Input:       w0: minimap row, w1: minimap colunm
// Output:      w0: boolean: 1 = True, 0 = False
define(c_row, w0)
define(c_col, w1)
    .global room_is_connected
room_is_connected:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO: determine bitmask for comparisons

    // TODO: rotate & compare room flags w/ bitmask

    ldp fp, lr, [sp], #16
    ret