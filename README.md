
# Death Counter
Death counter for the BizHawk console emulator

## About

This Lua script is written for the **BizHawk** multi-system emulator. It adds a death counter on the game screen to keep track of the number of times the player has died. The death count persists through game-overs, save states and soft and hard resets (but not core resets).

## How to use

Download the two Lua files and place them in the Lua subfolder of the BizHawk installation. You can also create a subfolder inside the Lua folder to place them there.

After starting the emulator, go to **Tools -> Lua Console** to open the Lua script manager.

From there, go to **Script -> Open Script** and load the **DeathCounter** script (*not* the DeathCounterGameList script).

The output window will tell you if a configuration for this game exists or if a new configuration is created.

The way this plugin works is that every frame it looks for a certain memory location to contain a certain value. If that value is found at that location, that means the player died.

Finding the correct memory location and value can be a little tricky, and requires some understanding and experience using the **RAM Search** 

## Configuring a game

If you have a found a correct memory location and value pair, press `Shift + F` to open the game configuration window. Here you can specify the memory location in the `equals memory location`, and the value to look for in the `equals value` box.

Clicking `Apply` will apply the configuration to the game. Clicking `Save` will save the configuration of the game into the `games/` folder.

If you have a working new configuration, please send the game json file from the `games/` folder to me via a pm or a pull request and I'll add it to the repository.

## Configuring the UI

Press `Shift + F` to open the game configuration window.

`image filename` is the filename for the image to display, which by default is the skull you see next to the counter. Leaving the name empty will cause no image to be displayed.
`image x, y` are the co-ordinates where the image is displayed.

`Label` is a line of text you can have displayed on the screen (perhaps instead of an image).
`Label x, y`are the co-ordinates where this text is displayed.

`Counter x, y`are the co-ordinates of the death count number on the screen.

Clicking `Apply` will apply these changes to the game. Clicking `Save` will save the configuration to file.

## Keyboard Shortcuts
| Shortcut | Action |
|--|--|
| `Shift + F` | Show game configuration form |
| | |
| `Shift + NumpadMinus` | Reduce the death counter by 1 |
| `Shift + NumpadPlus` | Increase the death counter by 1 |
| `Shift + NumpadEnter` | Reset the death counter to 0 |
