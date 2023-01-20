local games = require("DeathCounterGamesList")
local json = require("json")

local gamename = gameinfo.getromname()
local corename = emu.getsystemid()

gamename = string.gsub( gamename, ' %[.+%]', "")
gamename = string.gsub( gamename, ' %(.+%)', "")

local gameconfig_filename = 'games/' .. corename .. '_' .. gamename .. '.json'

--

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end
 
--


------------------------

local game
local was_dead
local death_count
local previous_input = {}
local eol = string.char(10)

-------------------------

local function update_gui_image_from_form( image_filename_handle, image_x_handle, image_y_handle)
    local image_filename = forms.gettext( image_filename_handle)
    local image_x = tonumber(forms.gettext( image_x_handle))
    local image_y = tonumber(forms.gettext( image_y_handle))

    if image_x == nil then image_x = 0 end
    if image_y == nil then image_y = 0 end

    if image_filename ~= "" then
        game.gui.image = {
            filename = image_filename,
            x=image_x,
            y=image_y
        }
    else
        game.gui.image = nil
    end
end

local function update_gui_label_from_form( label_text_handle, label_x_handle, label_y_handle)
    local label_text = forms.gettext( label_text_handle)
    local label_x = tonumber(forms.gettext( label_x_handle))
    local label_y = tonumber(forms.gettext( label_y_handle))

    if label_x == nil then label_x = 0 end
    if label_y == nil then label_y = 0 end

    if label_text ~= "" then
        game.gui.label = {
            text = label_text,
            x = label_x,
            y = label_y
        }
    else
        game.gui.label = nil
    end
end

local function update_gui_counter_from_form( counter_x_handle, counter_y_handle)
    local counter_x = tonumber( forms.gettext( counter_x_handle))
    local counter_y = tonumber( forms.gettext( counter_y_handle))

    if counter_x == nil then counter_x = 0 end
    if counter_y == nil then counter_y = 0 end

    game.gui.counter = {
        x = counter_x,
        y = counter_y
    }
end

local function update_equals_from_form( equalsloc_handle, equalsval_handle)
    local equalsloc = tonumber( forms.gettext( equalsloc_handle), 16)
    local equalsval = tonumber( forms.gettext( equalsval_handle))

    if equalsval == nil then equalsval = 0 end 
    
    game.equals = {
        location = equalsloc,
        value = equalsval
    }

end

----------------------------------------------------------------------------

local function show_form()
    local form_handle = forms.newform(300, 600, "Death Counter Config")

    local x_offset = 20
    local y_offset = 20

    forms.label( form_handle,
        "equals memory location",
        x_offset, y_offset,
        150, 20
    )

    local equalsloc = ""
    if game.equals ~= nil then
        equalsloc = string.format( "%x", game.equals.location)
    end 

    local equalsloc_handle = forms.textbox(
        form_handle,
        equalsloc,
        50, 20,
        "HEX",
        x_offset+150, y_offset
    )

    y_offset = y_offset + 20

    forms.label( form_handle,
        "equals value",
        x_offset, y_offset,
        150, 20
    )

    local equalsval = ""
    if game.equals ~= nil then 
        equalsval = game.equals.value
    end

    local equalsval_handle = forms.textbox(
        form_handle,
        equalsval,
        50, 20,
        "UNSIGNED",
        x_offset+150, y_offset
    )

    -- Image filename and location config

    y_offset = y_offset + 30
    forms.label(
        form_handle,
        "image filename",
        x_offset, y_offset,
        150, 20
    )

    local image_filename = ""
    local image_x = ""
    local image_y = ""
    console.log( game.gui.image.x .. '--')
    if game.gui.image ~= nil then
        image_filename = game.gui.image.filename
        image_x = tonumber(game.gui.image.x)
        image_y = tonumber(game.gui.image.y)
    end

    local image_filename_handle = forms.textbox(
        form_handle,
        image_filename,
        100, 20,
        nil,
        x_offset+150, y_offset
    )

    y_offset = y_offset + 20
    forms.label(
        form_handle,
        "image x, y",
        x_offset, y_offset,
        150, 20
    )

    local image_x_handle = forms.textbox(
        form_handle,
        image_x,
        25, 25,
        "UNSIGNED",
        x_offset+150, y_offset
    )

    local image_y_handle = forms.textbox(
        form_handle,
        image_y,
        25, 25,
        "UNSIGNED",
        x_offset+185, y_offset
    )

    -- Label text and location config

    y_offset = y_offset + 30
    forms.label(
        form_handle,
        "Label",
        x_offset, y_offset,
        50, 20
    )

    local label_text = ""
    local label_x = ""
    local label_y = ""
    if game.gui.label ~= nil then
        label_text = game.gui.label.text
        label_x = game.gui.label.x
        label_y = game.gui.label.y
    end

    local label_text_handle = forms.textbox(
        form_handle,
        label_text,
        150, 20,
        nil,
        x_offset+60, y_offset
    )

    y_offset = y_offset+20
    forms.label(
        form_handle,
        "Label x, y",
        x_offset, y_offset
    )

    local label_x_handle = forms.textbox(
        form_handle,
        label_x,
        20, 20,
        "UNSIGNED",
        x_offset+80, y_offset
    )

    local label_y_handle = forms.textbox(
        form_handle,
        label_y,
        20, 20,
        "UNSIGNED",
        x_offset+110, y_offset
    )

    -- Counter location config

    y_offset = y_offset + 30
    forms.label(
        form_handle,
        "Counter x, y",
        x_offset, y_offset
    )

    local counter_x = game.gui.counter.x
    local counter_y = game.gui.counter.y

    local counter_x_handle = forms.textbox(
        form_handle,
        counter_x,
        20, 20,
        "UNSIGNED",
        x_offset + 100, y_offset
    )

    local counter_y_handle = forms.textbox(
        form_handle,
        counter_y,
        20, 20,
        "UNSIGNED",
        x_offset + 130, y_offset
    )

    -- Apply button and function

    local function apply_form()
        update_gui_image_from_form( image_filename_handle, image_x_handle, image_y_handle)
        update_gui_label_from_form( label_text_handle, label_x_handle, label_y_handle)
        update_gui_counter_from_form( counter_x_handle, counter_y_handle)
        update_equals_from_form( equalsloc_handle, equalsval_handle)

        --update_config_output(config_output_handle)
    end

    local function save_config()
        file = assert(io.open( gameconfig_filename, 'w'))
        file:write( json.encode( game))
        file:close()
    end

    y_offset = y_offset + 30

    local button_handle = forms.button(
        form_handle,
        "Apply",
        apply_form,
        x_offset+50, y_offset
    )

    forms.button(
        form_handle,
        "Save",
        save_config,
        x_offset+120, y_offset
    )

end
-------------------------

local function init()

    -- Checking for existing configuration

    if file_exists( gameconfig_filename) then 
        local file = assert( io.open( gameconfig_filename))
        game = json.decode( file:read())
        file:close()
    else 
        if games[corename] == nil or games[corename][gamename] == nil then
            console.log( "No game data found for '"..gamename.."' on the '"..corename.."'")
            console.log( "Creating empty data")
        
            games[corename][gamename] = {}
        end
        game = games[corename][gamename]
    end

    if game["gui"] == nil then
        game["gui"] =  {
            counter = {
                x = 16,
                y = 2
            },
            label = {
                text = "",
                x = 50,
                y = 100
            },
            image = {
                filename = "skull.png",
                x = 2,
                y = 2
            }
        }
    end

    if game.gui.counter == nil then
        game.gui.counter = {
            x=0,
            y=0
        }
    end

    if game.gui.counter.horizontal_alignment == nil then
        game.gui.counter.horizontal_alignment = "left"
    end

    was_dead = true
    death_count = 0

    console.log( "Preparing death counter for '"..gamename.."' on the '"..corename.."'")
end

local function draw_deaths()

    if game.gui.label ~= nil then
        gui.drawText( game.gui.label.x, game.gui.label.y, game.gui.label.text, 0xFFFFFFFF, 0x00000000, 10, "Arial", "regular", "center")
    end

    if game.gui.image ~= nil then
        gui.drawImage( game.gui.image.filename, game.gui.image.x, game.gui.image.y)
    end

    gui.drawText( game.gui.counter.x, game.gui.counter.y, death_count, 0xFFFFFFFF, 0x00000000, 10, "Arial", "regular", game.gui.counter.horizontal_alignment)
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

    if keys["Shift+F"] and previous_input["Shift+F"] == nil then
        show_form()
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

