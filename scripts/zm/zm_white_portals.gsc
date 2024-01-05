// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using scripts\zm_common\zm_item_pickup.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_fasttravel.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_white_portals;

/*
	Name: init
	Namespace: zm_white_portals
	Checksum: 0xBECB86D2
	Offset: 0x5E0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_spawned(&on_player_spawn);
	main();
}

/*
	Name: main
	Namespace: zm_white_portals
	Checksum: 0xFFFF3465
	Offset: 0x620
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	if(!zm_utility::is_standard())
	{
		level thread teleporter_init();
		level thread function_24167ed8();
	}
	level thread function_ab07399f();
}

/*
	Name: init_clientfields
	Namespace: zm_white_portals
	Checksum: 0x8F3F1077
	Offset: 0x688
	Size: 0x634
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "portal_dest_fx", 20000, 3, "int");
	clientfield::register("toplayer", "PORTAL_YELLOW_BACKYARD", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_YELLOW_HOUSE", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_RED_HOUSE", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_GREEN_HOUSE", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_GREEN_BACKYARD", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_STREET_MID", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_STREET_START", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_PRISONER_HOLDING", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_OPERATIONS", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_TRANSFUSION_FACILITY", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_APD_INTERROGATION", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_DINER", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_BEDS", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_LOUNGE", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_POWER", 20000, 2, "int");
	clientfield::register("toplayer", "PORTAL_STORAGE", 20000, 2, "int");
	clientfield::register("actor", "crawler_portal_spawn_fx", 20000, 1, "counter");
	clientfield::register("toplayer", "teleporter_transition", 20000, 1, "counter");
	clientfield::register("toplayer", "teleporter_depart", 20000, 1, "counter");
	clientfield::register("toplayer", "teleporter_arrive", 20000, 1, "counter");
	clientfield::register("world", "portal_maps_clear_lights", 20000, 1, "int");
	clientfield::register("world", "portal_maps_initialize_lights", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_green_house_backyard", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_red_house", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_yellow_house", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_prisoner_holding", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_street_middle", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_transfusion_facility", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_diner", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_beds", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_power", 20000, 1, "int");
	clientfield::register("world", "portal_map_indicator_storage", 20000, 1, "int");
}

/*
	Name: function_24167ed8
	Namespace: zm_white_portals
	Checksum: 0x251EE8F8
	Offset: 0xCC8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_24167ed8()
{
	level flag::init(#"hash_2120a14c5eeab590");
	level flag::init(#"shield_built");
	level flag::init(#"hash_2a5fb4f6bae2e180");
	zm_crafting::function_d1f16587(#"hash_33a1f55aa9d0ac8e", &function_5702b2e7);
}

/*
	Name: function_ab07399f
	Namespace: zm_white_portals
	Checksum: 0xA34B844F
	Offset: 0xD68
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_ab07399f()
{
	foreach(t_crafting in level.var_4fe2f84d[#"hash_33a1f55aa9d0ac8e"])
	{
		if(isdefined(t_crafting.var_4f749ffe))
		{
			t_crafting.var_ae360c37 = getent(t_crafting.var_4f749ffe.target, "targetname");
			t_crafting.var_ae360c37 ghost();
		}
	}
}

/*
	Name: function_5702b2e7
	Namespace: zm_white_portals
	Checksum: 0x2E8750F9
	Offset: 0xE50
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_5702b2e7(e_player)
{
	if(isdefined(self.stub) && isdefined(self.stub.blueprint))
	{
		t_crafting = self.stub;
	}
	else if(isdefined(self.blueprint))
	{
		t_crafting = self;
	}
	if(t_crafting.blueprint.name == #"hash_ef185e110c83ded")
	{
		t_crafting.var_4f749ffe show();
		t_crafting.var_ae360c37 show();
		level flag::set(#"hash_2120a14c5eeab590");
		if(function_8b1a219a())
		{
			level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_57249497bfb88a5", 64, &function_735e7b);
		}
		else
		{
			level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_57249497bfb88a5", 64, &function_735e7b);
		}
		zm_ui_inventory::function_7df6bb60("zm_whiteteleporter_phase_num", 1);
	}
	else
	{
		level flag::set(#"shield_built");
	}
	if(level flag::get(#"hash_2120a14c5eeab590") && level flag::get(#"shield_built"))
	{
		level flag::set(#"hash_2a5fb4f6bae2e180");
	}
}

/*
	Name: function_735e7b
	Namespace: zm_white_portals
	Checksum: 0xFCA8C528
	Offset: 0x1088
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_735e7b()
{
	self waittill(#"trigger");
	function_e0a8fc52();
}

/*
	Name: function_e0a8fc52
	Namespace: zm_white_portals
	Checksum: 0x2C9E1825
	Offset: 0x10C0
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_e0a8fc52()
{
	level.var_868c98df = 2;
	level notify(#"modifier_acquired");
	self playsound(#"hash_59436c2037092176");
	level.var_279a11a3.related_parent setinvisibletoall();
	var_ae360c37 = getent(level.var_279a11a3.related_parent.target, "targetname");
	var_ae360c37 setinvisibletoall();
	zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 1);
	zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
	zm_unitrigger::unregister_unitrigger(level.var_279a11a3);
}

/*
	Name: function_3264eb9c
	Namespace: zm_white_portals
	Checksum: 0xB6B38E49
	Offset: 0x11E0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_3264eb9c()
{
	level clientfield::set("portal_maps_clear_lights", 1);
}

/*
	Name: function_71e1c159
	Namespace: zm_white_portals
	Checksum: 0x53F8A366
	Offset: 0x1210
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_71e1c159()
{
	level clientfield::set("portal_maps_initialize_lights", 1);
	var_7ed14c5f = function_688df525();
	foreach(s_portal in var_7ed14c5f)
	{
		level thread function_3566160b(s_portal.script_noteworthy, 1);
	}
}

/*
	Name: teleporter_init
	Namespace: zm_white_portals
	Checksum: 0x6A833C79
	Offset: 0x12D8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function teleporter_init()
{
	level.teleport_ae_funcs = [];
	level flag::init(#"portals_active");
	level.var_868c98df = 0;
	level thread setup_portals();
	level.s_zombie_teleport_room = struct::get("zombie_teleport_room", "targetname");
	level clientfield::set("portal_maps_clear_lights", 1);
}

/*
	Name: function_2113985
	Namespace: zm_white_portals
	Checksum: 0x1E8F6085
	Offset: 0x1388
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_2113985()
{
	level.portal_trig = getentarray("portal_trigs", "targetname");
	foreach(e_portal in level.portal_trig)
	{
		e_portal teleport_pad_init();
	}
}

/*
	Name: teleport_pad_init
	Namespace: zm_white_portals
	Checksum: 0x7ECC06CC
	Offset: 0x1438
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function teleport_pad_init()
{
	self.b_active = 1;
	self.b_locked = 0;
	self.b_placed = 0;
	self.a_portal_used = [];
	s_zombie_pos = self function_d9e2dc1f();
	self.fx_pos = s_zombie_pos.origin;
	self thread player_teleporting();
}

/*
	Name: player_teleporting
	Namespace: zm_white_portals
	Checksum: 0x925FDE08
	Offset: 0x14C0
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function player_teleporting()
{
	self endon(#"death");
	user = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		user = waitresult.activator;
		player_used = 0;
		if(isdefined(self.a_portal_used))
		{
			for(i = 0; i < self.a_portal_used.size; i++)
			{
				if(self.a_portal_used[i] == user)
				{
					player_used = 1;
				}
			}
		}
		if(player_used == 1)
		{
			continue;
		}
		else if(zm_utility::is_player_valid(user, 0, 1))
		{
			self thread teleport_player(user);
		}
	}
}

/*
	Name: teleport_player
	Namespace: zm_white_portals
	Checksum: 0x7711B844
	Offset: 0x15D8
	Size: 0x594
	Parameters: 1
	Flags: Linked
*/
function teleport_player(user)
{
	if(!isdefined(user))
	{
		return;
	}
	user endoncallback(&function_96e88318, #"death");
	destination = undefined;
	if(isdefined(user.teleporting) && user.teleporting == 1)
	{
		return;
	}
	level notify(#"portal_used", {#s_portal:self});
	user notify(#"teleporting");
	user.teleporting = 1;
	user.s_teleport = self;
	user.teleport_location = self.origin;
	user clientfield::increment_to_player("teleporter_transition", 1);
	switch(self.n_dest)
	{
		case 0:
		{
			var_298e4578 = level.s_portal_yellow_backyard;
			break;
		}
		case 1:
		{
			var_298e4578 = level.s_portal_yellow_house;
			break;
		}
		case 2:
		{
			var_298e4578 = level.s_portal_red_house;
			break;
		}
		case 3:
		{
			var_298e4578 = level.s_portal_green_house;
			break;
		}
		case 4:
		{
			var_298e4578 = level.s_portal_green_backyard;
			break;
		}
		case 5:
		{
			var_298e4578 = level.s_portal_street_mid;
			break;
		}
		case 6:
		{
			var_298e4578 = level.s_portal_street_start;
			break;
		}
		case 7:
		{
			var_298e4578 = level.s_portal_prisoner_holding;
			break;
		}
		case 8:
		{
			var_298e4578 = level.s_portal_operations;
			break;
		}
		case 9:
		{
			var_298e4578 = level.s_portal_transfusion_facility;
			break;
		}
		case 10:
		{
			var_298e4578 = level.s_portal_apd_interrogation;
			break;
		}
		case 11:
		{
			var_298e4578 = level.s_portal_diner;
			break;
		}
		case 12:
		{
			var_298e4578 = level.s_portal_beds;
			break;
		}
		case 13:
		{
			var_298e4578 = level.s_portal_lounge;
			break;
		}
		case 14:
		{
			var_298e4578 = level.s_portal_power;
			break;
		}
		case 15:
		{
			var_298e4578 = level.s_portal_storage;
			break;
		}
	}
	destination = var_298e4578.var_52a6f692;
	user clientfield::increment_to_player("teleporter_depart", 1);
	playfx(level._effect[#"portal_origin"], self.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_out", self.origin);
	level thread function_fe50866d(user, self, var_298e4578);
	self function_134670b9(1);
	user zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, destination, undefined, string(self.n_dest), 0);
	user clientfield::increment_to_player("teleporter_transition", 1);
	var_298e4578 thread cooldown_portal_timer(user);
	user thread function_c234a5ce();
	user clientfield::increment_to_player("teleporter_arrive", 1);
	playfx(level._effect[#"portal_dest"], var_298e4578.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_go", var_298e4578.origin);
	user playsoundtoplayer(#"hash_39876bf613387fef", user);
	wait(0.5);
	user function_96e88318();
	user notify(#"teleporting_done");
	util::setclientsysstate("levelNotify", "cool_fx", user);
	util::setclientsysstate("levelNotify", "ae1", user);
}

/*
	Name: function_96e88318
	Namespace: zm_white_portals
	Checksum: 0xD4C18B82
	Offset: 0x1B78
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_96e88318(str_notify)
{
	self.teleporting = 0;
	self.s_teleport = undefined;
}

/*
	Name: function_c234a5ce
	Namespace: zm_white_portals
	Checksum: 0xB25867E2
	Offset: 0x1BA0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_c234a5ce()
{
	self endoncallback(&function_4f5d4783, #"death");
	self val::set(#"teleport_exit", "ignoreme", 1);
	wait(1);
	self function_4f5d4783();
}

/*
	Name: function_4f5d4783
	Namespace: zm_white_portals
	Checksum: 0xF75909B3
	Offset: 0x1C18
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_4f5d4783(str_notify)
{
	self val::reset(#"teleport_exit", "ignoreme");
}

/*
	Name: function_26ddb915
	Namespace: zm_white_portals
	Checksum: 0x73699DF3
	Offset: 0x1C58
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_26ddb915()
{
	foreach(player in level.players)
	{
		if(player.teleporting === 1)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: cooldown_portal_timer
	Namespace: zm_white_portals
	Checksum: 0x8807CFCB
	Offset: 0x1CE8
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function cooldown_portal_timer(e_user)
{
	self endon(#"death", #"hash_3c91bf90cecbe758");
	e_user endon(#"death");
	if(!isdefined(self.a_e_users))
	{
		self.a_e_users = [];
	}
	else if(!isarray(self.a_e_users))
	{
		self.a_e_users = array(self.a_e_users);
	}
	self.a_e_users[self.a_e_users.size] = e_user;
	self function_cb7c6fc7(e_user, 0);
	wait(20);
	arrayremovevalue(self.a_e_users, e_user);
	self function_cb7c6fc7(e_user, 1);
	playsoundatposition(#"hash_1c870a3a31a2dcf9", self.origin);
}

/*
	Name: function_cb7c6fc7
	Namespace: zm_white_portals
	Checksum: 0xD263410D
	Offset: 0x1E28
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_cb7c6fc7(e_user, b_show = 1)
{
	if(b_show)
	{
		e_user clientfield::set_to_player(self.script_noteworthy, 2);
	}
	else
	{
		e_user clientfield::set_to_player(self.script_noteworthy, 1);
	}
}

/*
	Name: function_7c7520a5
	Namespace: zm_white_portals
	Checksum: 0x7A92E47A
	Offset: 0x1EA8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_7c7520a5(e_user)
{
	e_user clientfield::set_to_player(self.script_noteworthy, 0);
}

/*
	Name: function_fe50866d
	Namespace: zm_white_portals
	Checksum: 0xD591F273
	Offset: 0x1EE0
	Size: 0xD8
	Parameters: 3
	Flags: Linked
*/
function function_fe50866d(target, portal_enter, portal_exit)
{
	util::wait_network_frame();
	zombies = getaiarray();
	foreach(zombie in zombies)
	{
		if(zombie.favoriteenemy === target)
		{
			zombie thread function_9d689cc4(portal_enter, portal_exit);
		}
	}
}

/*
	Name: function_d9e2dc1f
	Namespace: zm_white_portals
	Checksum: 0xC25D558F
	Offset: 0x1FC0
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_d9e2dc1f()
{
	portals = struct::get_array(self.target, "targetname");
	foreach(portal in portals)
	{
		if(portal.script_noteworthy === "zombie_pos")
		{
			return portal;
		}
	}
}

/*
	Name: function_254e91a2
	Namespace: zm_white_portals
	Checksum: 0x1E5C19E5
	Offset: 0x2078
	Size: 0xAA
	Parameters: 0
	Flags: None
*/
function function_254e91a2()
{
	portals = struct::get_array(self.target, "targetname");
	foreach(portal in portals)
	{
		if(portal.script_noteworthy === "player_pos")
		{
			return portal;
		}
	}
}

/*
	Name: find_portal_destination
	Namespace: zm_white_portals
	Checksum: 0x2A25C319
	Offset: 0x2130
	Size: 0x14A
	Parameters: 1
	Flags: None
*/
function find_portal_destination(var_210b4680)
{
	var_98ceafca = [];
	foreach(s_portal in level.a_s_portals)
	{
		if(self == s_portal)
		{
			continue;
		}
		if(!level.zones[s_portal.zone_name].is_enabled)
		{
			continue;
		}
		if(isdefined(var_210b4680) && s_portal.n_floor != var_210b4680)
		{
			continue;
		}
		if(!isdefined(var_98ceafca))
		{
			var_98ceafca = [];
		}
		else if(!isarray(var_98ceafca))
		{
			var_98ceafca = array(var_98ceafca);
		}
		var_98ceafca[var_98ceafca.size] = s_portal;
	}
	if(var_98ceafca.size > 0)
	{
		return array::random(var_98ceafca);
	}
	return self;
}

/*
	Name: enable_zone_portals_init
	Namespace: zm_white_portals
	Checksum: 0xC6629AAC
	Offset: 0x2288
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function enable_zone_portals_init()
{
	portal_zone_trig = getentarray("portal_zone_trigs", "targetname");
	for(i = 0; i < portal_zone_trig.size; i++)
	{
		portal_zone_trig[i] thread enable_zone_portals();
	}
}

/*
	Name: enable_zone_portals
	Namespace: zm_white_portals
	Checksum: 0xF948E50B
	Offset: 0x2300
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function enable_zone_portals()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	user = waitresult.activator;
	if(laststand::player_is_in_laststand() || zm_utility::is_player_valid(user) && isdefined(self.script_noteworthy))
	{
		level thread zm_zonemgr::enable_zone(self.script_noteworthy);
	}
}

/*
	Name: function_e9848fa7
	Namespace: zm_white_portals
	Checksum: 0xD2BB8BAE
	Offset: 0x23A8
	Size: 0x1FA
	Parameters: 0
	Flags: Linked
*/
function function_e9848fa7()
{
	var_84a6eef7 = undefined;
	var_9d761d98 = function_35babccd(self);
	var_ba7bf98e = [];
	foreach(s_portal in level.a_s_portals)
	{
		if(s_portal.n_floor == var_9d761d98)
		{
			if(!isdefined(var_ba7bf98e))
			{
				var_ba7bf98e = [];
			}
			else if(!isarray(var_ba7bf98e))
			{
				var_ba7bf98e = array(var_ba7bf98e);
			}
			var_ba7bf98e[var_ba7bf98e.size] = s_portal;
		}
	}
	if(var_ba7bf98e.size > 0)
	{
		if(isdefined(self.var_b940d6ea))
		{
			var_4da60e8d = self.var_b940d6ea;
		}
		else
		{
			var_4da60e8d = self.origin;
		}
		var_2bb91264 = 1410065408;
		foreach(portal in var_ba7bf98e)
		{
			var_d9c76d4b = distancesquared(portal.origin, var_4da60e8d);
			if(var_d9c76d4b < var_2bb91264)
			{
				var_2bb91264 = var_d9c76d4b;
				var_84a6eef7 = portal;
			}
		}
	}
	return var_84a6eef7;
}

/*
	Name: function_9d689cc4
	Namespace: zm_white_portals
	Checksum: 0x4F1EF3
	Offset: 0x25B0
	Size: 0x1CC
	Parameters: 2
	Flags: Linked
*/
function function_9d689cc4(portal, portal_exit)
{
	self endoncallback(&function_2ef25d40, #"damage", #"death", #"cancel_teleport");
	if(!isdefined(portal))
	{
		portal = self function_e9848fa7();
		if(!isdefined(portal))
		{
			self.favoriteenemy = undefined;
			return;
		}
	}
	self.var_3f667178 = portal;
	self.var_693b80bb = self.b_ignore_cleanup;
	self.b_ignore_cleanup = 1;
	self thread function_554c780b();
	while(distancesquared(self.origin, portal.origin) > self.goalradius * self.goalradius)
	{
		wait(0.1);
	}
	self notify(#"reached_portal");
	self.var_3f667178 = undefined;
	if(!isdefined(portal_exit))
	{
		if(!isdefined(self.favoriteenemy))
		{
			self.favoriteenemy = zm_hms_util::function_3815943c();
		}
		if(!isdefined(self.favoriteenemy))
		{
			self function_2ef25d40();
			return;
		}
		portal_exit = self.favoriteenemy function_e9848fa7();
		if(!isdefined(portal_exit))
		{
			self.favoriteenemy = undefined;
			self function_2ef25d40();
			return;
		}
	}
	self thread function_71be28e1(self, portal, portal_exit);
}

/*
	Name: function_2ef25d40
	Namespace: zm_white_portals
	Checksum: 0x7C6B6B9C
	Offset: 0x2788
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_2ef25d40(str_notify)
{
	self notify(#"reached_portal");
	self.b_ignore_cleanup = self.var_693b80bb;
	self.var_3f667178 = undefined;
}

/*
	Name: function_71be28e1
	Namespace: zm_white_portals
	Checksum: 0x2141A220
	Offset: 0x27C8
	Size: 0x2A2
	Parameters: 3
	Flags: Linked
*/
function function_71be28e1(zombie, start_portal, end_portal)
{
	self endon(#"death");
	playfx(level._effect[#"teleport_depart"], zombie.origin);
	playfx(level._effect[#"portal_origin"], start_portal.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_out", zombie.origin);
	zombie function_1f034d46(end_portal.origin);
	zombie.b_ignore_cleanup = 1;
	zombie forceteleport(level.s_zombie_teleport_room.origin);
	zombie setentitypaused(1);
	wait(3);
	if(!isdefined(zombie))
	{
		return;
	}
	end_target = end_portal.var_52a6f692[0];
	zombie setentitypaused(0);
	zombie forceteleport(end_portal.origin + (anglestoforward(end_portal.angles) * randomfloatrange(0, 32)), end_target.angles);
	zombie function_1f034d46();
	playfx(level._effect[#"teleport_arrive"], zombie.origin);
	playfx(level._effect[#"portal_dest"], end_portal.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_go", zombie.origin);
	self.b_ignore_cleanup = self.var_693b80bb;
}

/*
	Name: function_554c780b
	Namespace: zm_white_portals
	Checksum: 0xAD48742
	Offset: 0x2A78
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_554c780b()
{
	self endon(#"death", #"reached_portal");
	wait(2);
	self.b_ignore_cleanup = self.var_693b80bb;
}

/*
	Name: function_1f034d46
	Namespace: zm_white_portals
	Checksum: 0x7EF367E6
	Offset: 0x2AC0
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_1f034d46(destination)
{
	self.var_b940d6ea = destination;
	if(isdefined(self.var_b940d6ea))
	{
		self.var_f4bf0819 = undefined;
	}
	else
	{
		self.var_f4bf0819 = undefined;
	}
}

/*
	Name: setup_portals
	Namespace: zm_white_portals
	Checksum: 0xB9086E97
	Offset: 0x2B08
	Size: 0x344
	Parameters: 0
	Flags: Linked
*/
function setup_portals()
{
	a_s_portals = struct::get_array("white_portal");
	foreach(s_portal in a_s_portals)
	{
		s_portal portal_init();
	}
	level.s_portal_yellow_backyard = struct::get("PORTAL_YELLOW_BACKYARD", "script_noteworthy");
	level.s_portal_yellow_house = struct::get("PORTAL_YELLOW_HOUSE", "script_noteworthy");
	level.s_portal_red_house = struct::get("PORTAL_RED_HOUSE", "script_noteworthy");
	level.s_portal_green_house = struct::get("PORTAL_GREEN_HOUSE", "script_noteworthy");
	level.s_portal_green_backyard = struct::get("PORTAL_GREEN_BACKYARD", "script_noteworthy");
	level.s_portal_street_mid = struct::get("PORTAL_STREET_MID", "script_noteworthy");
	level.s_portal_street_start = struct::get("PORTAL_STREET_START", "script_noteworthy");
	level.s_portal_prisoner_holding = struct::get("PORTAL_PRISONER_HOLDING", "script_noteworthy");
	level.s_portal_operations = struct::get("PORTAL_OPERATIONS", "script_noteworthy");
	level.s_portal_transfusion_facility = struct::get("PORTAL_TRANSFUSION_FACILITY", "script_noteworthy");
	level.s_portal_apd_interrogation = struct::get("PORTAL_APD_INTERROGATION", "script_noteworthy");
	level.s_portal_diner = struct::get("PORTAL_DINER", "script_noteworthy");
	level.s_portal_beds = struct::get("PORTAL_BEDS", "script_noteworthy");
	level.s_portal_lounge = struct::get("PORTAL_LOUNGE", "script_noteworthy");
	level.s_portal_power = struct::get("PORTAL_POWER", "script_noteworthy");
	level.s_portal_storage = struct::get("PORTAL_STORAGE", "script_noteworthy");
	function_ea199c46();
	function_a6bb56f6();
}

/*
	Name: portal_init
	Namespace: zm_white_portals
	Checksum: 0xE93EE376
	Offset: 0x2E58
	Size: 0x796
	Parameters: 0
	Flags: Linked
*/
function portal_init()
{
	if(!isdefined(level.a_s_portals))
	{
		level.a_s_portals = [];
	}
	else if(!isarray(level.a_s_portals))
	{
		level.a_s_portals = array(level.a_s_portals);
	}
	self.var_a1cf77d2 = util::spawn_model("tag_origin", self.origin, self.angles);
	if(!isdefined(self.a_e_users))
	{
		self.a_e_users = [];
	}
	else if(!isarray(self.a_e_users))
	{
		self.a_e_users = array(self.a_e_users);
	}
	self.zone_name = zm_zonemgr::get_zone_from_position(self.origin, 1);
	self.var_d5ea18bf = array("PORTAL_YELLOW_BACKYARD", "PORTAL_YELLOW_HOUSE", "PORTAL_RED_HOUSE", "PORTAL_GREEN_HOUSE", "PORTAL_GREEN_BACKYARD", "PORTAL_STREET_MID", "PORTAL_STREET_START", "PORTAL_PRISONER_HOLDING", "PORTAL_OPERATIONS", "PORTAL_TRANSFUSION_FACILITY", "PORTAL_APD_INTERROGATION", "PORTAL_DINER", "PORTAL_BEDS", "PORTAL_LOUNGE", "PORTAL_POWER", "PORTAL_STORAGE");
	if(self.script_noteworthy === "PORTAL_POWER")
	{
		self.var_d99a94d9 = 5;
	}
	else
	{
		self.var_d99a94d9 = 14;
	}
	self.var_52a6f692 = zm_hms_util::function_2719d4c0(self.target, "targetname", "script_int");
	var_c60b7f6d = getentarray(self.target, "targetname");
	foreach(e in var_c60b7f6d)
	{
		if(e.script_noteworthy === "model")
		{
			self.e_model = e;
			continue;
		}
		if(e.script_noteworthy === "info_volume")
		{
			self.e_volume = e;
		}
	}
	switch(self.script_noteworthy)
	{
		case "portal_yellow_backyard":
		{
			self.var_7b89ada3 = 0;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_yellow_house":
		{
			self.var_7b89ada3 = 1;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_red_house":
		{
			self.var_7b89ada3 = 2;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_green_house":
		{
			self.var_7b89ada3 = 3;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_green_backyard":
		{
			self.var_7b89ada3 = 4;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_street_mid":
		{
			self.var_7b89ada3 = 5;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_street_start":
		{
			self.var_7b89ada3 = 6;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_prisoner_holding":
		{
			self.var_7b89ada3 = 7;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_operations":
		{
			self.var_7b89ada3 = 8;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_transfusion_facility":
		{
			self.var_7b89ada3 = 9;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_apd_interrogation":
		{
			self.var_7b89ada3 = 10;
			self.n_floor = 1;
			self.e_model hide();
			break;
		}
		case "portal_diner":
		{
			self.var_7b89ada3 = 11;
			self.n_floor = 2;
			self.e_model hide();
			break;
		}
		case "portal_beds":
		{
			self.var_7b89ada3 = 12;
			self.n_floor = 2;
			self.e_model hide();
			break;
		}
		case "portal_lounge":
		{
			self.var_7b89ada3 = 13;
			self.n_floor = 2;
			self.e_model hide();
			break;
		}
		case "portal_power":
		{
			self.var_7b89ada3 = 14;
			self.n_floor = 2;
			self.e_model hide();
			break;
		}
		case "portal_storage":
		{
			self.var_7b89ada3 = 15;
			self.n_floor = 2;
			self.e_model hide();
			break;
		}
	}
	self.b_active = 0;
	self.b_placed = 0;
	self.b_locked = 0;
}

/*
	Name: function_688df525
	Namespace: zm_white_portals
	Checksum: 0xCE611E71
	Offset: 0x35F8
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_688df525()
{
	a_s_portals = struct::get_array("white_portal");
	a_s_active = [];
	foreach(s_portal in a_s_portals)
	{
		if(s_portal.b_placed)
		{
			if(!isdefined(a_s_active))
			{
				a_s_active = [];
			}
			else if(!isarray(a_s_active))
			{
				a_s_active = array(a_s_active);
			}
			a_s_active[a_s_active.size] = s_portal;
		}
	}
	return a_s_active;
}

/*
	Name: function_a09d62f1
	Namespace: zm_white_portals
	Checksum: 0x5C83CCD6
	Offset: 0x36F8
	Size: 0x56E
	Parameters: 0
	Flags: Linked
*/
function function_a09d62f1()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		e_user = waitresult.e_who;
		if(level.var_868c98df > 0 && !self.b_placed)
		{
			if(zm_utility::is_player_valid(e_user) && math::cointoss())
			{
				e_user thread zm_hms_util::function_51b752a9(#"hash_7832a05d73569401");
			}
			level.var_868c98df--;
			self.b_active = 1;
			self.b_placed = 1;
			if(isdefined(self.e_model))
			{
				self.e_model show();
				playsoundatposition(#"hash_d8a6518e5c2027d", self.e_model.origin + vectorscale((0, 0, 1), 20));
			}
			level.a_s_active = function_688df525();
			if(level.var_868c98df == 0)
			{
				level.a_s_active[0].n_dest = level.a_s_active[1].var_7b89ada3;
				level.a_s_active[1].n_dest = level.a_s_active[0].var_7b89ada3;
				level.a_s_active[0] thread reenable_teleporter();
				level.a_s_active[1] thread reenable_teleporter();
			}
			foreach(s_portal in level.a_s_active)
			{
				level thread function_3566160b(s_portal.script_noteworthy, 1);
			}
		}
		else if(self.b_placed && !self.b_locked && !function_26ddb915())
		{
			level.a_s_active = function_688df525();
			level.var_868c98df++;
			self.b_active = 0;
			self.b_placed = 0;
			if(isdefined(self.e_model))
			{
				self.e_model hide();
				playsoundatposition(#"hash_59436c2037092176", self.e_model.origin + vectorscale((0, 0, 1), 20));
			}
			if(level.var_868c98df == 1)
			{
				foreach(s_active in level.a_s_active)
				{
					s_active disable_teleporter();
				}
			}
			level thread function_3566160b(self.script_noteworthy, 0);
		}
		switch(level.var_868c98df)
		{
			case 0:
			{
				zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 0);
				zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 0);
				break;
			}
			case 1:
			{
				zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 0);
				zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
				break;
			}
			case 2:
			{
				zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 1);
				zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
				break;
			}
			default:
			{
				/#
					iprintlnbold("");
				#/
				break;
			}
		}
	}
}

/*
	Name: portal_ready
	Namespace: zm_white_portals
	Checksum: 0xD81482D0
	Offset: 0x3C70
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function portal_ready()
{
	if(!zm_utility::is_standard())
	{
		self zm_unitrigger::create(&function_99407d66, 128);
		self thread function_a09d62f1();
	}
}

/*
	Name: function_97d4ad50
	Namespace: zm_white_portals
	Checksum: 0x9BFDAB26
	Offset: 0x3CD0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_97d4ad50()
{
	self zm_unitrigger::create(&function_99407d66, 128);
}

/*
	Name: function_99407d66
	Namespace: zm_white_portals
	Checksum: 0x8B98F650
	Offset: 0x3D08
	Size: 0x220
	Parameters: 1
	Flags: Linked
*/
function function_99407d66(e_player)
{
	if(e_player zm_utility::is_drinking())
	{
		self sethintstring("");
		return false;
	}
	if(self.stub.related_parent.b_active === 0 && level.var_868c98df === 0)
	{
		self sethintstring(#"hash_5fb23a325b41e010");
		return true;
	}
	if(self.stub.related_parent.b_active === 1)
	{
		if(function_26ddb915())
		{
			self sethintstring(#"hash_79fc5d02a880a44b");
			return true;
		}
		if(self.stub.related_parent.b_locked === 1)
		{
			self sethintstring(#"hash_4a621c0c0f51fef9");
			return true;
		}
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_57249497bfb88a5");
			return true;
		}
		self sethintstring(#"hash_6801c3df1d9b2a37");
		return true;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_57748c9a86bf5e92");
		return true;
	}
	self sethintstring(#"hash_45755e67c1efbdb6");
	return true;
}

/*
	Name: function_360c6be0
	Namespace: zm_white_portals
	Checksum: 0x6BE67D5E
	Offset: 0x3F38
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_360c6be0()
{
	self endon(#"death");
	while(self.b_active)
	{
		e_user = undefined;
		while(self.b_active && !isdefined(e_user))
		{
			foreach(player in level.players)
			{
				if(isalive(player) && player istouching(self.e_volume))
				{
					e_user = player;
					continue;
				}
			}
			waitframe(1);
		}
		if(array::contains(self.a_e_users, e_user) || (isdefined(self.var_cd2f1fed) && self.var_cd2f1fed))
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_user, 0, 1))
		{
			self thread teleport_player(e_user);
		}
	}
}

/*
	Name: function_a54a70b3
	Namespace: zm_white_portals
	Checksum: 0x5AC2680A
	Offset: 0x40B0
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_a54a70b3()
{
	self endon(#"death");
	self.b_locked = 1;
	for(time = 0; time < 20; time++)
	{
		wait(1);
	}
	self.b_locked = 0;
}

/*
	Name: portal_activate
	Namespace: zm_white_portals
	Checksum: 0x6B7EC20B
	Offset: 0x4118
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function portal_activate()
{
	level.a_s_portals[self.script_noteworthy] = self;
	self function_98cd139();
}

/*
	Name: function_ea199c46
	Namespace: zm_white_portals
	Checksum: 0xA369B451
	Offset: 0x4158
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_ea199c46()
{
	level endon(#"game_end");
	a_s_portals = struct::get_array("white_portal");
	level waittill(#"power_on1");
	exploder::exploder("fxexp_power_on");
	for(i = 0; i < a_s_portals.size; i++)
	{
		a_s_portals[i] portal_activate();
		a_s_portals[i] portal_ready();
	}
	level flag::set(#"portals_active");
	level clientfield::set("portal_maps_initialize_lights", 1);
}

/*
	Name: function_79e8b4c6
	Namespace: zm_white_portals
	Checksum: 0x68515CCB
	Offset: 0x4268
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_79e8b4c6(var_9dff0a2b)
{
	self.n_dest = var_9dff0a2b;
}

/*
	Name: function_98cd139
	Namespace: zm_white_portals
	Checksum: 0x9216C019
	Offset: 0x4290
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_98cd139()
{
	self function_79e8b4c6(self.var_d5ea18bf[self.var_d99a94d9]);
}

/*
	Name: function_134670b9
	Namespace: zm_white_portals
	Checksum: 0x60D460F6
	Offset: 0x42C8
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_134670b9(n_delay)
{
	if(isdefined(self.var_9f43786e))
	{
		self.var_9f43786e = self.var_9f43786e + n_delay;
	}
}

/*
	Name: function_a6bb56f6
	Namespace: zm_white_portals
	Checksum: 0x769DE9D4
	Offset: 0x4300
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_a6bb56f6()
{
	foreach(s_portal in level.a_s_portals)
	{
		s_portal disable_teleporter();
	}
}

/*
	Name: function_3566160b
	Namespace: zm_white_portals
	Checksum: 0x24336D43
	Offset: 0x4388
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_3566160b(str_location, n_newval)
{
	str_clientfield = "";
	switch(str_location)
	{
		case "portal_yellow_house":
		{
			str_clientfield = "portal_map_indicator_yellow_house";
			break;
		}
		case "portal_red_house":
		{
			str_clientfield = "portal_map_indicator_red_house";
			break;
		}
		case "portal_green_backyard":
		{
			str_clientfield = "portal_map_indicator_green_house_backyard";
			break;
		}
		case "portal_street_mid":
		{
			str_clientfield = "portal_map_indicator_street_middle";
			break;
		}
		case "portal_prisoner_holding":
		{
			str_clientfield = "portal_map_indicator_prisoner_holding";
			break;
		}
		case "portal_transfusion_facility":
		{
			str_clientfield = "portal_map_indicator_transfusion_facility";
			break;
		}
		case "portal_diner":
		{
			str_clientfield = "portal_map_indicator_diner";
			break;
		}
		case "portal_beds":
		{
			str_clientfield = "portal_map_indicator_beds";
			break;
		}
		case "portal_power":
		{
			str_clientfield = "portal_map_indicator_power";
			break;
		}
		case "portal_storage":
		{
			str_clientfield = "portal_map_indicator_storage";
			break;
		}
	}
	self clientfield::set(str_clientfield, n_newval);
}

/*
	Name: disable_teleporter
	Namespace: zm_white_portals
	Checksum: 0xD9FF2AE1
	Offset: 0x4528
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function disable_teleporter()
{
	self.var_cd2f1fed = 1;
	self notify(#"hash_3c91bf90cecbe758");
	self.a_e_users = [];
	foreach(e_player in getplayers())
	{
		self function_7c7520a5(e_player);
	}
}

/*
	Name: reenable_teleporter
	Namespace: zm_white_portals
	Checksum: 0xBB8BF0D1
	Offset: 0x45E0
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function reenable_teleporter(var_1e62b431 = 1)
{
	self.var_cd2f1fed = 0;
	self thread function_a54a70b3();
	if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
	{
		var_1e62b431 = 0;
	}
	if(var_1e62b431)
	{
		self thread function_360c6be0();
		foreach(e_player in getplayers())
		{
			self function_cb7c6fc7(e_player, 1);
		}
	}
}

/*
	Name: on_player_spawn
	Namespace: zm_white_portals
	Checksum: 0x4EE0E4D6
	Offset: 0x4710
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function on_player_spawn()
{
	if(level flag::get(#"portals_active"))
	{
		foreach(s_portal in level.a_s_portals)
		{
			if(s_portal.b_active)
			{
				s_portal function_cb7c6fc7(self, 1);
			}
		}
	}
}

/*
	Name: function_35babccd
	Namespace: zm_white_portals
	Checksum: 0x1BA2D7CF
	Offset: 0x47C8
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function function_35babccd(ent)
{
	if(isdefined(ent.var_f4bf0819))
	{
		ent.floor_num = ent.var_f4bf0819;
		return ent.floor_num;
	}
	if(!isdefined(ent.floor_num))
	{
		ent.floor_num = 1;
	}
	index = ent.floor_num - 1;
	var_4e37b34 = level.var_b4fcac11.size;
	for(n = 0; n < var_4e37b34; n++)
	{
		if(ent istouching(level.var_b4fcac11[index]))
		{
			ent.floor_num = index + 1;
			return ent.floor_num;
		}
		index = (index + 1) % var_4e37b34;
	}
	/#
		println("");
	#/
	return ent.floor_num;
}

/*
	Name: function_5c2807fc
	Namespace: zm_white_portals
	Checksum: 0x3CA89BF0
	Offset: 0x4910
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_5c2807fc()
{
	level.var_868c98df = 0;
	a_s_portals = struct::get_array("white_portal");
	foreach(s_portal in a_s_portals)
	{
		s_portal thread disable_teleporter();
		s_portal.b_active = 0;
		if(isdefined(s_portal.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_portal.s_unitrigger);
		}
	}
}

