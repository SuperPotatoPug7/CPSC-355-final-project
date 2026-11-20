# CPSC 355 final project

## V0.0- Functioning Beta - TODO

- Room generation 
- Map
- Traversal I/O

- Map
- Basic UI:
  - Minimap
  - Room Preview


## V1.0- Minimum Working Prototype - TODO


- playerCanMove- Micheal
  - is movement permissable? -> checks if there's a door & still on map
  - input: w, a, s, d -> up, left, down, right
  - ret: <bool> 1=T, 0=F

- movePlayer- Micheal
  - moves the player up, left, right, down 
  - input: <int> 0, 1, 2, 3 (WASD)
  - Output: 

- isWinState- Micheal
  - checks if player is in exit room & enough gems
  - input:
  - output: <bool> 1=T, 0=F

- promptWASD- Mattew
  - prints prompt, takes user input for movement using scanf, casts to int before ret
  - input: 
  - output: the player's response- w, a, s, d -> returned as <int> 0, 1, 2, 3

- addRandomRoom- Mattew
  - takes random room from avaliableRoomCards, returns index of the associated room
  - input:
  - output: <int> an avaliable room card index, -1 for no avaliable rooms

- prompt strings in .bss- Ali
- array of <pointer>, <8-byte int> correct answer- Ali

- global int gemCount- Ali

- roomHasTriviaQuestion- Mattew
  - checks if a room card has a trivia question
  - input: room card index
  - output: <bool> 1=T, 0=F

- selectRandomTriviaQuestion- Curtis
  - selects a random trivia question index
  - input: 
  - output: <int> trivia prompt index

- printTriviaPrompt- Curtis
  - prints a trivia question
  - input: <int> trivia prompt index
  - output:

- takeTriviaAnswer- Curtis
  - takes the user input for a trivia answer & check if it's correct
  - input: <int> trivia prompt index
  - output: <boolean> 1=correct, 0=incorrect

- updateRoomFlagsAndGemCountFromTriviaAnswer- Ali
  - loses a gem for right question, gains the has_gem flag for correct answer, updates the has_trivia room flag & the has_gem room flag to 0
  - input: <int> trivia prompt index, <boolean> 1=correct, 0=incorrect
  - output: 


- winstate loop: ends when in exit room w/ enough gems (in Main)

- Minigame functionality  - TODO
  - Array of trivia questions  - TODO
  - I/O  - TODO
  - Pseudo-Random selection  - TODO
  - Room clearing (can’t re-trigger minigame after completion)  - TODO
- Splash screen explaining rules  - TODO
- Help screen  - TODO
- Idle state before game starts  - TODO
- Minigame UI  - TODO
- Gem win conditions
- Gem drain on lost minigames

## V1.1- Scope Expansion 2 - TODO

- Saferoom & rounds  - TODO
- Timer-race  - TODO
- More rooms/trivia questions  - TODO
- Alternative features/minigames  - TODO
