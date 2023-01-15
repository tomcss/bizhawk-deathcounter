
# Death Counter
Death counter for the BizHawk console emulator

## About

This Lua script is written for the **BizHawk** multi-system emulator. It adds a death counter on the game screen to keep track of the number of times the player has died. The death count persists through game-overs, save states and soft and hard resets (but not core resets).

## How to use

Download the two Lua files and place them in the Lua subfolder of the BizHawk installation. You can also create a subfolder inside the Lua folder to place them there.

After starting the emulator, go to **Tools -> Lua Console** to open the Lua script manager.

From there, go to **Script -> Open Script** and load the **DeathCounter** script (*not* the DeathCounterGameList script).

If the Output window tells you it's preparing a death counter, that means it's working and it has support for the game you've loaded. If it tells you it can't find game data, that means your loaded game hasn't been added to the Death Counter Game List (yet).

## DeathCounterGameList.lua

This file contains configuration for each game that's supported.

The way the plugin works is that it looks for specific values in memory, and works out if the player has died when they change.

For games where the player has energy, this usually means looking for a specific memory location to return a value of 0 (the player has 0 energy, ergo they're dead). This isn't always 0, in Battletoads a specific memory location has the value 243 if the player has no energy left.

For games where there the player only has lives and no energy, such as Mario, the plugin detects a decrease of value at a specific memory location.

A sample game configuration looks like this:

```lua
games["NES"]["Battletoads (U)"] = {
    equals = { location = 0x01C9, value = 243},
    gui = { x = 69, y = 0}
}
```
An `equals` property means that the plugin looks for the given `value` at the given specified `location`. If that location in memory returns that value, the plugin registers it as a death.

The `gui` property configures the `x` and `y` offset of the **Deaths: #** text on the screen.
```lua
games["NES"]["Battletoads (U) [!]"] = games["NES"]["Battletoads (U)"]
```
Alternative versions of the ROM often have the same memory layout, so you can just assign an existing configuration to them.

An example configuration of a game with lives instead of energy:
```lua
games["SNES"]["Super Mario World (Europe)"] = {
    reduced = 0x0DBE
}
```
The `reduced` property holds a memory location. If the value at that memory location decreases, it's registered as a death.

## Keyboard Shortcuts
The plugin isn't perfect. When games show a demo of the gameplay, those deaths usually get recorded as well. Some games will trigger a death by initializing a new game. So sometimes you need to finetune the results a little. Luckily, we have some keyboard shortcuts to do this:

| Shortcut | Action |
|--|--|
| `Shift + NumpadMinus` | Reduce the death counter by 1 |
| `Shift + NumpadPlus` | Increase the death counter by 1 |
| `Shift + NumpadEnter` | Reset the death counter to 0 |
