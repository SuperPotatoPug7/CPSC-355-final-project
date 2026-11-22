// ====================================================
// ---------------- Trivia ----------------
// ====================================================

    .data

define(fp, x29)
define(lr, x30)

// global 4-byte int: the number of gems the player is holding
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
    .ascii  "In Khoikhoi folklore, where are the eyes of the man-eating aigamuxa?\n"
    .ascii  "  1) The hands\n"
    .ascii  "  2) The head\n"
    .ascii  "  3) The feet\n"
    .string "  4) The chest\n"

trivia_prompt_1:
    .ascii  "If someone is your genitor, who are they?\n"
    .ascii  "  1) Biological father\n"
    .ascii  "  2) Legal father\n"
    .ascii  "  3) Stepfather\n"
    .string "  4) Godfather\n"

trivia_prompt_2:
    .ascii  "The Elder Scrolls 6 has had its official subtitle revealed. What is it?\n"
    .ascii  "  1) Black Marsh\n"
    .ascii  "  2) Godhead\n"
    .ascii  "  3) Tamriel\n"
    .string "  4) Sentinel\n"

trivia_prompt_3:
    .ascii  "A \"wanyudo\" comes from the folklore of which country?\n"
    .ascii  "  1) Thailand\n"
    .ascii  "  2) Japan\n"
    .ascii  "  3) China\n"
    .string "  4) Philippines\n"

trivia_prompt_4:
    .ascii  "Modern copyright law can be traced back to a 1710 statute from which country?\n"
    .ascii  "  1) France\n"
    .ascii  "  2) The US\n"
    .ascii  "  3) Germany\n"
    .string "  4) The UK\n"

trivia_prompt_5:
    .ascii  "Which real-life killer partly inspired Leatherface in The Texas Chain Saw Massacre?\n"
    .ascii  "  1) Ed Gein\n"
    .ascii  "  2) Ted Bundy\n"
    .ascii  "  3) John Wayne Gacy\n"
    .string "  4) BTK\n"

trivia_prompt_6:
    .ascii  "Which of these is an example of a grey-market offering?\n"
    .ascii  "  1) Secondhand furniture on Kijiji\n"
    .ascii  "  2) Liquidation sales\n"
    .ascii  "  3) Genuine phones imported and resold by unauthorized dealers\n"
    .string "  4) Farmer's market vendors\n"

trivia_prompt_7:
    .ascii  "Which fast-food chain in Canada serves a sweet-style spaghetti topped with sliced hot dogs?\n"
    .ascii  "  1) A&W\n"
    .ascii  "  2) Jollibee\n"
    .ascii  "  3) Arby's\n"
    .string "  4) Mary Brown's Chicken\n"

trivia_prompt_8:
    .ascii  "In Marxist literature, which group is considered the opposite of the bourgeoisie?\n"
    .ascii  "  1) Intelligentsia\n"
    .ascii  "  2) Proletariat\n"
    .ascii  "  3) Petit bourgeoisie\n"
    .string "  4) Middle class\n"

trivia_prompt_9:
    .ascii  "What does \"pulchritudinous\" mean?\n"
    .ascii  "  1) Glowing\n"
    .ascii  "  2) Diseased\n"
    .ascii  "  3) Rage-inducing\n"
    .string "  4) Beautiful\n"

trivia_prompt_10:
    .ascii  "The founder of Scientology was close friends with which famous science fiction author?\n"
    .ascii  "  1) Isaac Asimov\n"
    .ascii  "  2) William Gibson\n"
    .ascii  "  3) Robert A. Heinlein\n"
    .string "  4) Frank Herbert\n"

trivia_prompt_11:
    .ascii  "\"Donair\" originates from which country?\n"
    .ascii  "  1) Greece\n"
    .ascii  "  2) Saudi Arabia\n"
    .ascii  "  3) USA\n"
    .string "  4) Canada\n"

trivia_prompt_12:
    .ascii  "Which song plays at the start of the end-credits for Scary Movie 2?\n"
    .ascii  "  1) The Cranberries - Zombie\n"
    .ascii  "  2) Nelly - Ride Wit Me\n"
    .ascii  "  3) Blink-182 - \"Adam's Song\"\n"
    .string "  4) Richard Wagner - Ride of the Valkyries\n"

trivia_prompt_13:
    .ascii  "Before starting Valve, Gabe Newell worked at which company?\n"
    .ascii  "  1) Apple\n"
    .ascii  "  2) IBM\n"
    .ascii  "  3) Microsoft\n"
    .string "  4) Atari\n"

trivia_prompt_14:
    .ascii  "Which European country was the centre of the Reconquista, when Christian kingdoms retook land from Muslim rule?\n"
    .ascii  "  1) Albania\n"
    .ascii  "  2) Russia\n"
    .ascii  "  3) Italy\n"
    .string "  4) Spain\n"

trivia_prompt_15:
    .ascii  "In Congolese folklore, what does the dwarf-like eloko carry?\n"
    .ascii  "  1) A hammer\n"
    .ascii  "  2) A jewel\n"
    .ascii  "  3) An eye\n"
    .string "  4) A bell\n"

trivia_prompt_16:
    .ascii  "Which of these works features its own author as the main character?\n"
    .ascii  "  1) A Clockwork Orange\n"
    .ascii  "  2) The Divine Comedy\n"
    .ascii  "  3) Kafka on the Shore\n"
    .string "  4) To Kill a Mockingbird\n"

trivia_prompt_17:
    .ascii  "Which country completely surrounds Lesotho?\n"
    .ascii  "  1) Madagascar\n"
    .ascii  "  2) South Africa\n"
    .ascii  "  3) Yemen\n"
    .string "  4) Eritrea\n"

trivia_prompt_18:
    .ascii  "Which of these is a film rather than a video game?\n"
    .ascii  "  1) Postal 2\n"
    .ascii  "  2) Manhunt\n"
    .ascii  "  3) Terrifier 2\n"
    .string "  4) Hatred\n"

trivia_prompt_19:
    .ascii  "The Japanese media franchise Danganronpa has been stated by a producer to be inspired by which Western horror series?\n"
    .ascii  "  1) Saw\n"
    .ascii  "  2) Halloween\n"
    .ascii  "  3) The Purge\n"
    .string "  4) A Nightmare on Elm Street\n"

trivia_prompt_20:
    .ascii  "The protagonist of the 2012 remake of \"Maniac\" played which character in the Lord of the Rings films?\n"
    .ascii  "  1) Frodo\n"
    .ascii  "  2) Sam\n"
    .ascii  "  3) Gandalf\n"
    .string "  4) Bilbo Baggins\n"

trivia_prompt_21:
    .ascii  "Which of these is not a Portuguese word?\n"
    .ascii  "  1) Favela\n"
    .ascii  "  2) Carioca\n"
    .ascii  "  3) Saudade\n"
    .string "  4) Hacienda\n"

trivia_prompt_22:
    .ascii  "Which film did actor Charlie Sheen report to the authorities in the early 1990s, convinced it was a real snuff film?\n"
    .ascii  "  1) Guinea Pig 2: Flower of Flesh and Blood\n"
    .ascii  "  2) Cannibal Holocaust\n"
    .ascii  "  3) August Underground's Mordum\n"
    .string "  4) Faces of Death\n"

trivia_prompt_23:
    .ascii  "Mike Masnick, who coined the term \"Streisand effect\" in 2005, founded and runs which website?\n"
    .ascii  "  1) TechCrunch\n"
    .ascii  "  2) Techdirt\n"
    .ascii  "  3) The Verge\n"
    .string "  4) Ars Technica\n"

trivia_prompt_24:
    .ascii  "In which country is \"chalkie\" slang for a teacher?\n"
    .ascii  "  1) South Africa\n"
    .ascii  "  2) India\n"
    .ascii  "  3) Australia\n"
    .string "  4) UK\n"

trivia_prompt_25:
    .ascii  "Which bestselling horror author said in a 2008 Entertainment Weekly column that he was no fan of video games, while still arguing against a proposed ban on violent ones?\n"
    .ascii  "  1) Clive Barker\n"
    .ascii  "  2) R. L. Stine\n"
    .ascii  "  3) Dean Koontz\n"
    .string "  4) Stephen King\n"

trivia_prompt_26:
    .ascii  "Which author is generally credited with inventing the detective story?\n"
    .ascii  "  1) Agatha Christie\n"
    .ascii  "  2) Arthur Conan Doyle\n"
    .ascii  "  3) Edgar Allan Poe\n"
    .string "  4) Wilkie Collins\n"

trivia_prompt_27:
    .ascii  "What does \"l'esprit de l'escalier\" mean?\n"
    .ascii  "  1) Thinking of the perfect response too late\n"
    .ascii  "  2) Elevator music\n"
    .ascii  "  3) Hauntings in a non-residential area\n"
    .string "  4) Good workmanship\n"

trivia_prompt_28:
    .ascii  "Which classic Universal Monsters movie included a scene of a girl being thrown into a lake?\n"
    .ascii  "  1) Creature from the Black Lagoon\n"
    .ascii  "  2) Frankenstein\n"
    .ascii  "  3) The Phantom of the Opera\n"
    .string "  4) The Invisible Man\n"

trivia_prompt_29:
    .ascii  "According to director Bob Clark, John Carpenter's Halloween grew out of an imagined sequel to which horror film?\n"
    .ascii  "  1) Psycho\n"
    .ascii  "  2) Silent Night, Bloody Night\n"
    .ascii  "  3) The Texas Chain Saw Massacre\n"
    .string "  4) Black Christmas\n"

trivia_prompt_30:
    .ascii  "Three of these are the Japanese, Korean and Chinese words for \"comics\". Which is the odd one out?\n"
    .ascii  "  1) Manga\n"
    .ascii  "  2) Donghua\n"
    .ascii  "  3) Manhwa\n"
    .string "  4) Manhua\n"

trivia_prompt_31:
    .ascii  "Which is generally considered the oldest university in continuous operation in Europe?\n"
    .ascii  "  1) University of Bologna\n"
    .ascii  "  2) University of Oxford\n"
    .ascii  "  3) University of Cambridge\n"
    .string "  4) University of Paris\n"

trivia_prompt_32:
    .ascii  "How many years after the Joker's first comic appearance did Harley Quinn debut in Batman: The Animated Series?\n"
    .ascii  "  1) 42\n"
    .ascii  "  2) 47\n"
    .ascii  "  3) 52\n"
    .string "  4) 57\n"

trivia_prompt_33:
    .ascii  "Which member of the original Plants vs. Zombies team was composer Laura Shigihara's boyfriend around the time of the game's release?\n"
    .ascii  "  1) Rich Werner\n"
    .ascii  "  2) Tod Semple\n"
    .ascii  "  3) George Fan\n"
    .string "  4) Stephen Notley\n"

trivia_prompt_34:
    .ascii  "Which of these Nordic countries is not part of Scandinavia in the strict sense?\n"
    .ascii  "  1) Denmark\n"
    .ascii  "  2) Norway\n"
    .ascii  "  3) Sweden\n"
    .string "  4) Finland\n"

trivia_prompt_35:
    .ascii  "The 2026 horror film \"Backrooms\" was primarily filmed in what Canadian city?\n"
    .ascii  "  1) Vancouver, BC\n"
    .ascii  "  2) Toronto, Ontario\n"
    .ascii  "  3) Winnipeg, Manitoba\n"
    .string "  4) Montreal, Quebec\n"

trivia_prompt_36:
    .ascii  "Kabab koobideh originates from which country's cuisine?\n"
    .ascii  "  1) Iran\n"
    .ascii  "  2) Afghanistan\n"
    .ascii  "  3) Yemen\n"
    .string "  4) Turkey\n"

trivia_prompt_37:
    .ascii  "Which smartphone brand belongs to the same conglomerate that runs Everland, South Korea's largest theme park?\n"
    .ascii  "  1) LG\n"
    .ascii  "  2) Samsung\n"
    .ascii  "  3) Sony\n"
    .string "  4) Nokia\n"

trivia_prompt_38:
    .ascii  "Which car brand's pickup trucks have been called \"the vehicular equivalent of the AK-47\" for being cheap, durable and everywhere in conflict zones?\n"
    .ascii  "  1) Toyota\n"
    .ascii  "  2) Land Rover\n"
    .ascii  "  3) Peugeot\n"
    .string "  4) Ford\n"

trivia_prompt_39:
    .ascii  "Which rare disease destroys the ability to sleep and has been fatal in every known case?\n"
    .ascii  "  1) Narcolepsy\n"
    .ascii  "  2) Huntington's disease\n"
    .ascii  "  3) Fatal familial insomnia\n"
    .string "  4) African sleeping sickness\n"

// ---------------- Trivia Question Array ----------------
// 1D global array of size 40, 16 bytes per entry:
//   bytes 0-7:  <pointer> the prompt string
//   bytes 8-15: <8-byte int> the number of the correct choice (1-4)
    .balign 8
    .global trivia_questions
trivia_questions:
    .xword trivia_prompt_0, 3 // 0: The feet
    .xword trivia_prompt_1, 1 // 1: Biological father
    .xword trivia_prompt_2, 4 // 2: Sentinel
    .xword trivia_prompt_3, 2 // 3: Japan
    .xword trivia_prompt_4, 4 // 4: The UK
    .xword trivia_prompt_5, 1 // 5: Ed Gein
    .xword trivia_prompt_6, 3 // 6: Genuine phones imported and resold by unauthorized dealers
    .xword trivia_prompt_7, 2 // 7: Jollibee
    .xword trivia_prompt_8, 2 // 8: Proletariat
    .xword trivia_prompt_9, 4 // 9: Beautiful
    .xword trivia_prompt_10, 3 // 10: Robert A. Heinlein
    .xword trivia_prompt_11, 4 // 11: Canada
    .xword trivia_prompt_12, 2 // 12: Nelly - Ride Wit Me
    .xword trivia_prompt_13, 3 // 13: Microsoft
    .xword trivia_prompt_14, 4 // 14: Spain
    .xword trivia_prompt_15, 4 // 15: A bell
    .xword trivia_prompt_16, 2 // 16: The Divine Comedy
    .xword trivia_prompt_17, 2 // 17: South Africa
    .xword trivia_prompt_18, 3 // 18: Terrifier 2
    .xword trivia_prompt_19, 1 // 19: Saw
    .xword trivia_prompt_20, 1 // 20: Frodo
    .xword trivia_prompt_21, 4 // 21: Hacienda
    .xword trivia_prompt_22, 1 // 22: Guinea Pig 2: Flower of Flesh and Blood
    .xword trivia_prompt_23, 2 // 23: Techdirt
    .xword trivia_prompt_24, 3 // 24: Australia
    .xword trivia_prompt_25, 4 // 25: Stephen King
    .xword trivia_prompt_26, 3 // 26: Edgar Allan Poe
    .xword trivia_prompt_27, 1 // 27: Thinking of the perfect response too late
    .xword trivia_prompt_28, 2 // 28: Frankenstein
    .xword trivia_prompt_29, 4 // 29: Black Christmas
    .xword trivia_prompt_30, 2 // 30: Donghua
    .xword trivia_prompt_31, 1 // 31: University of Bologna
    .xword trivia_prompt_32, 3 // 32: 52
    .xword trivia_prompt_33, 3 // 33: George Fan
    .xword trivia_prompt_34, 4 // 34: Finland
    .xword trivia_prompt_35, 1 // 35: Vancouver, BC
    .xword trivia_prompt_36, 1 // 36: Iran
    .xword trivia_prompt_37, 2 // 37: Samsung
    .xword trivia_prompt_38, 1 // 38: Toyota
    .xword trivia_prompt_39, 3 // 39: Fatal familial insomnia

// ====================================================
// ---------------- Trivia Results ----------------
// ====================================================

    .text
    .balign 4

// ---------------- Update Room Flags & Gem Count From Trivia Answer ----------------
// Function:    updates the player's current room & the gem count after a trivia question.
//              correct: the player gains the room's gem (if it still has one)
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

// ------ Correct: gain the room's gem (the still_has_gem flag, bit 2, is 0 or 1) ------
    ubfx ur_has_gem, ur_flags, #2, #1
    add ur_gem_count, ur_gem_count, ur_has_gem
    b ur_store

// ------ Incorrect: lose a gem, if there is one to lose ------
ur_incorrect:
    cbz ur_gem_count, ur_store
    sub ur_gem_count, ur_gem_count, #1

// ------ Save the gem count & clear has_active_puzzle (bit 3) and still_has_gem (bit 2) ------
ur_store:
    str ur_gem_count, [ur_gem_count_ptr]
    bic ur_flags, ur_flags, #0b00001100
    strb ur_flags, [ur_flags_ptr]

ur_done:
    ldr x19, [sp], #16
    ldp fp, lr, [sp], #16
    mov w0, #0
    ret
