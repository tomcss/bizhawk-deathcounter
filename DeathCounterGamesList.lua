
local games = {}

games["NES"] = {}
games["SNES"] = {}

-- NES Games

games["NES"]["Batman (U)"] = {
    equals = { location = 0x00B7, value=0 }
}
games["NES"]["Batman (E)"] = games["NES"]["Batman (U)"]
games["NES"]["Batman (J)"] = games["NES"]["Batman (U)"]

games["NES"]["Batman Returns (E)"] = {
    equals = { location = 0x0140, value=0 }
}
games["NES"]["Batman Returns (U)"] = games["NES"]["Batman Returns (E)"]

games["NES"]["Battletoads (U)"] = {
    equals = { location = 0x01C9, value = 243},
    gui = { x = 69, y = 0}
}
games["NES"]["Battletoads (E)"] = games["NES"]["Battletoads (U)"]
games["NES"]["Battletoads (J)"] = games["NES"]["Battletoads (U)"] 

games["NES"]["Beetlejuice (U)"] = {
    equals = { location = 0x030B, value=190}
}

games["NES"]["Bionic Commando (E)"] = {
    equals = { location = 0x00CD, value=0}
--    equals = { location = 0x0536, value=129}
}

games["NES"]["Blaster Master (E)"] = {
    equals = { location = 0x00C5, value=8}
--    equals = { location = 0x00D4, value=6}
--    equals = { location = 0x00DB, value=6}
}
games["NES"]["Blaster Master (U)"] = games["NES"]["Blaster Master (E)"]

games["NES"]["Blue Shadow (E)"] = {
    equals = { location = 0x06F0, value=0}
}
games["NES"]["Blue Shadow (U)"] = games["NES"]["Blue Shadow (E)"]

games["NES"]["Bubble Bobble (E)"] = {
    equals = { location = 0x0031, value=128 }
}
games["NES"]["Bubble Bobble (U)"] = games["NES"]["Bubble Bobble (E)"]

games["NES"]["Castlevania II - Simon's Quest (E)"] = {
    equals = { location = 0x00B4, value=52 },
    gui = {
        image = {
            filename = "skull.png",
            x = 40,
            y = 10
        },
        label = nil,
        counter = {
            x = 60,
            y = 10,
            horizontal_alignment = "left"
        }
    }
}
games["NES"]["Castlevania II - Simon's Quest (KC)"] = games["NES"]["Castlevania II - Simon's Quest (E)"]
games["NES"]["Castlevania II - Simon's Quest (U)"] = games["NES"]["Castlevania II - Simon's Quest (E)"]

games["NES"]["Super Mario Bros. (E)"] = {
    equals = { location = 0x07CA, value=148},
    gui = {
        image = {
            filename = "skull.png",
            x = 4,
            y = 6
        },
        label = nil,
        counter = {
            x = 10,
            y = 18,
            horizontal_alignment = "center"
        }
    }
}
games["NES"]["Super Mario Bros. (E) (REVA)"] = games["NES"]["Super Mario Bros. (E)"] 
games["NES"]["Super Mario Bros. (E) (REVB)"] = games["NES"]["Super Mario Bros. (E)"] 
games["NES"]["Super Mario Bros. (W)"] = games["NES"]["Super Mario Bros. (E)"] 

games["NES"]["Super Mario Bros. 2 (U)"] = {
    equals = { location = 0x0608, value=128},
    gui = {
        image = {
            filename = "skull.png",
            x = 4,
            y = 6
        },
        label = nil,
        counter = {
            x = 10,
            y = 18,
            horizontal_alignment = "center"
        }
    }
}
games["NES"]["Super Mario Bros. 2 (U) (PRG0)"] = games["NES"]["Super Mario Bros. 2 (U)"]
games["NES"]["Super Mario Bros. 2 (U) (PRG1)"] = games["NES"]["Super Mario Bros. 2 (U)"]

-- SNES Games

games["SNES"]["Mega Man X (Europe)"] = {
    equals = { location = 0x0BCF, value = 0}
}
games["SNES"]["Mega Man X (USA)"] = games["SNES"]["Mega Man X (Europe)"]

games["SNES"]["Super Mario World (Europe)"] = {
    reduced = 0x0DBE
}

return games