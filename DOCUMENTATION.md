# CPSC 355 final project

This is the section where design & archetectural decisions are explained to make maintenence & collaboration easier.

## Data Structures

- Map:
  - 2D static array in .bss
  - 31x31
  - 2 bytes:
    - byte 1:
      - \<6-bit int> room card index
        - initialized with max value means empty
      - \<2-bit int> rotation
    - byte 2:
      - \<8-bit int> puzzle index
        - initialized with max value means none

- Room Cards:
  - 1D array of N rooms
  - 1 byte:
    - byte 1- booleans & room type:
      - \<2-bit int> room type
      - \<boolean> conects_left
      - \<boolean> connects_up
      - \<boolean> connects_right
      - \<boolean> connects_down
      - \<boolean> has_active_puzzle
      - \<boolean> still_has_gem
  - Room Types:
    - Empty Room: nothing inside
    - Starter Room: nothing inside, exists on init
    - Gem Room: has puzzle & a gem
    - Trap Room: has puzzle & no gem
    - room type encoding: 0 = empty, 1 = starter room, 2 = gem room, 3 = trap room

## UI

## I/O

## Maze Traversal
