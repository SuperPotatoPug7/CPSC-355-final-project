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

    // TODO

    ldp fp, lr, [sp], #16
    ret


// ---------------- Room Is Connected? ----------------
// Function:    checks if the input room is connected to the room of the player's 
//              current position and enterable. (assumes the rooms are adjacent).
// Input:       w0: minimap row, w1: minimap colunm
// Output:      w0: boolean: 1 = True, 0 = False
    .global room_is_connected
room_is_connected:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // TODO

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