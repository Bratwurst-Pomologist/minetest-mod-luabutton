# minetest-mod-luabutton
Button that executes custom lua code on rightclick  
![ContentDB](https://content.minetest.net/packages/Zemtzov7/luabutton/shields/downloads/)
### Nodes
* `luabutton:luabutton` - The button that executes code on rightclick
* `luabutton:luaplate` - Plate that executes code when player is stepping on it
* `luabutton:luatrigger` - Same as plate but invisible
### Usage
* Get the nodes using `/giveme` command.
* All players can execute code of the button. (Privilege check meant to be implemented in custom code ;))
* Players with `server` priv can combine rightclick and `aux1` to open button's code editor.
* To open code editor of LuaTrigger, hold `luabutton:luatrigger` in the hand, press `aux1` and rightclick at the node above which the LuaTrigger is placed.
### License of media (texture)
* `luabutton.png` - by Zemtzov7. License - CC-BY-SA-4.0
