local editing = {}
local F = minetest.formspec_escape

minetest.register_node("luabutton:luabutton",{
  description = "Lua Button",
  paramtype = "light",
  paramtype2 = "facedir",
  drawtype = "nodebox",
  node_box = {
	type = "fixed",
	fixed = {
		{-0.3, -0.3, 0.4, 0.3, 0.3, 0.5},
		{-0.1, -0.1, 0.4, 0.1, 0.1, 0.35},
	}
  },
  tiles = {"luabutton.png"},
  inventory_image = "luabutton.png",
  groups = {not_in_creative_inventory=1,unbreakable=1},
  on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
	local name = clicker:get_player_name()
	local ctrl = clicker:get_player_control()
	local meta = minetest.get_meta(pos)
	if ctrl.aux1 and minetest.check_player_privs(clicker,{server=true}) then
		minetest.show_formspec(name, "luabutton_code", "size[16,9]" ..
			"field[0.4,0.5;15.7,1;infotext;Infotext;"..F(meta:get_string("infotext")).."]" ..
			"textarea[0.4,1.3;15.7,8.3;code;Variables: pos\\, node\\, clicker\\, itemstack\\, pointed_thing;"..F(meta:get_string("code")).."]" ..
			"set_focus[save]" ..
			"button[13.8,8.4;2,1;save;Save]")
		editing[name] = pos
		return itemstack
	end
	local code = meta and meta:get_string("code")
	local func, synerr = loadstring("return function(pos,node,clicker,itemstack,pointed_thing)"..code.." end")
	if func then
		local good, err = pcall(func(),pos,node,clicker,itemstack,pointed_thing)
		if not good then
			minetest.chat_send_player(name,"/!\\ LuaButton error: "..dump(err))
		end
	else
		minetest.chat_send_player(name,"/!\\ LuaButton error: "..dump(synerr))
	end
  end,
})
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "luabutton_code" then return end
	if fields.save then
		local name = player:get_player_name()
		local pos = editing[name]
		local meta = pos and minetest.get_meta(pos)
		if not meta then return end
		meta:set_string("code",fields.code)
		meta:set_string("infotext",fields.infotext)
		meta:mark_as_private("code")
		minetest.chat_send_player(name,"Saved")
	end
end)
