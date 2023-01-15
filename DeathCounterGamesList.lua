
local games = {}

games["NES"] = {}
games["SNES"] = {}

-- NES Games

games["NES"]["Battletoads (U)"] = {
    equals = { location = 0x01C9, value = 243},
    gui = { x = 69, y = 0}
}
games["NES"]["Battletoads (U) [!]"] = games["NES"]["Battletoads (U)"]

-- SNES Games

games["SNES"]["Mega Man X (Europe)"] = {
    equals = { location = 0x0BCF, value = 0}
}
games["SNES"]["Mega Man X (USA)"] = games["SNES"]["Mega Man X (Europe)"]

games["SNES"]["Super Mario World (Europe)"] = {
    reduced = 0x0DBE
}

return games