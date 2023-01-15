local games = require"DeathCounterGamesList"

local gamename = gameinfo.getromname()
local corename = emu.getsystemid()

-- Checking for existing configuration

if games[corename] == nil or games[corename][gamename] == nil then
    console.log( "No game data found for '"..gamename.."' on the '"..corename.."'")
    return
end

------------------------

local game
local previous_values = {}
local was_dead
local death_count
local previous_input = {}

local function init()
    game = games[corename][gamename]
    previous_values = {}

    if game["reduced"] ~= nil then
        previous_values[game["reduced"]] = memory.read_u8(game["reduced"])
    end

    if games[gui] == nil then
        games[gui] = { x = 0, y = 0}
    end

    was_dead = true
    death_count = 0

    console.log( "Preparing death counter for '"..gamename.."' on the '"..corename.."'")
end

local function draw_deaths()
    gui.drawText( game["gui"]["x"], game["gui"]["y"], "Deaths: " .. death_count, 0xFFFFFFFF, 0x00000000, 10)
end

local function parse_input()
    local keys = input.get()

    if keys["Shift+KeypadAdd"] and previous_input["Shift+KeypadAdd"] == nil then
        death_count = death_count + 1
    end

    if keys["Shift+KeypadSubtract"] and previous_input["Shift+KeypadSubtract"] == nil then
        death_count = death_count - 1
    end

    if keys["Shift+KeypadEnter"] and previous_input["Shift+KeypadEnter"] == nil then
        death_count = 0
    end

    previous_input = {}

    for key, value in pairs( keys) do
        previous_input[key] = true
    end

end 

local function has_died()
    local death = false

    if game["equals"] ~= nil then
        local value = memory.read_u8( game["equals"]["location"])

        if value == game["equals"]["value"] then 
            death = true
        end
    end

    if game["reduced"] ~= nil then
        local value = memory.read_u8(game["reduced"])

        if value < previous_values[game["reduced"]] then
            death = true
        end

        previous_values[game["reduced"]] = value
    end

    return death
end

init()

while true do
    local is_dead = has_died()

    if was_dead and is_dead == false then
        was_dead = false
    end

    if is_dead == true and was_dead == false then
        was_dead = true
        death_count = death_count + 1
    end

    parse_input()

    draw_deaths()

    emu.frameadvance()
end

