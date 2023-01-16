
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
            horizontal_alignment = "center"
        }
    }
}
games["NES"]["Castlevania II - Simon's Quest (KC)"] = games["NES"]["Castlevania II - Simon's Quest (E)"]
games["NES"]["Castlevania II - Simon's Quest (U)"] = games["NES"]["Castlevania II - Simon's Quest (E)"]

-- SNES Games

games["SNES"]["Mega Man X (Europe)"] = {
    equals = { location = 0x0BCF, value = 0}
}
games["SNES"]["Mega Man X (USA)"] = games["SNES"]["Mega Man X (Europe)"]

games["SNES"]["Super Mario World (Europe)"] = {
    reduced = 0x0DBE
}

return games