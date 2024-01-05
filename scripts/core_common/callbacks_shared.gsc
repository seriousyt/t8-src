// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\voice\voice_events.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\simple_hostmigration.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace callback;

/*
	Name: callback
	Namespace: callback
	Checksum: 0x84569FC2
	Offset: 0x128
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function callback(event, params)
{
	mpl_heatwave_fx(level, event, params);
	if(self != level)
	{
		mpl_heatwave_fx(self, event, params);
	}
}

/*
	Name: function_bea20a96
	Namespace: callback
	Checksum: 0xF0F9E0D6
	Offset: 0x190
	Size: 0xB0
	Parameters: 2
	Flags: None
*/
function function_bea20a96(event, params)
{
	ais = getaiarray();
	foreach(ai in ais)
	{
		ai mpl_heatwave_fx(ai, event, params);
	}
}

/*
	Name: function_daed27e8
	Namespace: callback
	Checksum: 0x2B792A9A
	Offset: 0x248
	Size: 0xD0
	Parameters: 2
	Flags: Linked
*/
function function_daed27e8(event, params)
{
	mpl_heatwave_fx(level, event, params);
	players = getplayers();
	foreach(player in players)
	{
		player mpl_heatwave_fx(player, event, params);
	}
}

/*
	Name: mpl_heatwave_fx
	Namespace: callback
	Checksum: 0xCCE64424
	Offset: 0x320
	Size: 0x274
	Parameters: 3
	Flags: Linked, Private
*/
function private mpl_heatwave_fx(ent, event, params)
{
	if(isdefined(ent) && isdefined(ent._callbacks) && isdefined(ent._callbacks[event]))
	{
		for(i = 0; i < ent._callbacks[event].size; i++)
		{
			if(!isarray(ent._callbacks[event][i]))
			{
				continue;
			}
			callback = ent._callbacks[event][i][0];
			/#
				/#
					assert(isfunctionptr(callback), "" + "");
				#/
			#/
			if(!isfunctionptr(callback))
			{
				return;
			}
			obj = ent._callbacks[event][i][1];
			var_47e0b77b = (isdefined(ent._callbacks[event][i][2]) ? ent._callbacks[event][i][2] : []);
			if(isdefined(obj))
			{
				if(isdefined(params))
				{
					util::function_cf55c866(obj, callback, self, params, var_47e0b77b);
				}
				else
				{
					util::function_50f54b6f(obj, callback, self, var_47e0b77b);
				}
				continue;
			}
			if(isdefined(params))
			{
				util::function_50f54b6f(self, callback, params, var_47e0b77b);
				continue;
			}
			util::single_thread_argarray(self, callback, var_47e0b77b);
		}
		arrayremovevalue(ent._callbacks[event], 0, 0);
	}
}

/*
	Name: add_callback
	Namespace: callback
	Checksum: 0x516B037D
	Offset: 0x5A0
	Size: 0x4C
	Parameters: 4
	Flags: Linked
*/
function add_callback(event, func, obj, a_params)
{
	function_2b653c00(level, event, func, obj, a_params);
}

/*
	Name: function_d8abfc3d
	Namespace: callback
	Checksum: 0xC030B3D5
	Offset: 0x5F8
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_d8abfc3d(event, func, obj, a_params)
{
	function_2b653c00(self, event, func, obj, a_params);
}

/*
	Name: function_2b653c00
	Namespace: callback
	Checksum: 0xCB86B010
	Offset: 0x648
	Size: 0x21C
	Parameters: 5
	Flags: Linked, Private
*/
function private function_2b653c00(ent, event, func, obj, a_params)
{
	if(!isdefined(ent))
	{
		return;
	}
	/#
		/#
			assert(isfunctionptr(func), "" + "");
		#/
	#/
	if(!isfunctionptr(func))
	{
		return;
	}
	/#
		assert(isdefined(event), "");
	#/
	if(!isdefined(ent._callbacks) || !isdefined(ent._callbacks[event]))
	{
		ent._callbacks[event] = [];
	}
	foreach(callback in ent._callbacks[event])
	{
		if(isarray(callback) && callback[0] == func)
		{
			if(!isdefined(obj) || callback[1] == obj)
			{
				return;
			}
		}
	}
	array::add(ent._callbacks[event], array(func, obj, a_params), 0);
	if(isdefined(obj))
	{
		obj thread remove_callback_on_death(event, func);
	}
}

/*
	Name: function_862146b3
	Namespace: callback
	Checksum: 0xEE54B94F
	Offset: 0x870
	Size: 0x3C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_862146b3(event, func)
{
	return string(event) + string(func);
}

/*
	Name: remove_callback_on_death
	Namespace: callback
	Checksum: 0x1D643576
	Offset: 0x8B8
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function remove_callback_on_death(event, func)
{
	self notify(function_862146b3(event, func));
	self endon(function_862146b3(event, func));
	self util::waittill_either("death", "remove_callbacks");
	remove_callback(event, func, self);
}

/*
	Name: remove_callback
	Namespace: callback
	Checksum: 0x9959E51C
	Offset: 0x950
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function remove_callback(event, func, obj)
{
	function_3f5f097e(level, event, func, obj);
}

/*
	Name: function_52ac9652
	Namespace: callback
	Checksum: 0x7266BE6F
	Offset: 0x998
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_52ac9652(event, func, obj, instant)
{
	function_3f5f097e(self, event, func, obj, instant);
}

/*
	Name: function_3f5f097e
	Namespace: callback
	Checksum: 0x3B83E856
	Offset: 0x9E8
	Size: 0x1FC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_3f5f097e(ent, event, func, obj, instant)
{
	if(!isdefined(ent._callbacks))
	{
		return;
	}
	/#
		assert(isdefined(event), "");
	#/
	if(func === "all")
	{
		ent._callbacks[event] = [];
		return;
	}
	/#
		assert(isdefined(ent._callbacks[event]), "");
	#/
	if(!isdefined(ent._callbacks[event]))
	{
		return;
	}
	if(isdefined(instant) && instant)
	{
		arrayremovevalue(ent._callbacks[event], 0, 0);
		return;
	}
	foreach(index, func_group in ent._callbacks[event])
	{
		if(isarray(func_group) && func_group[0] == func)
		{
			if(func_group[1] === obj)
			{
				if(isdefined(obj))
				{
					obj notify(function_862146b3(event, func));
				}
				ent._callbacks[event][index] = 0;
				break;
			}
		}
	}
}

/*
	Name: on_finalize_initialization
	Namespace: callback
	Checksum: 0xA2B45217
	Offset: 0xBF0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_finalize_initialization(func, obj)
{
	add_callback(#"on_finalize_initialization", func, obj);
}

/*
	Name: on_connect
	Namespace: callback
	Checksum: 0xF89BE2A2
	Offset: 0xC38
	Size: 0x44
	Parameters: 3
	Flags: Linked, Variadic
*/
function on_connect(func, obj, ...)
{
	add_callback(#"on_player_connect", func, obj, vararg);
}

/*
	Name: remove_on_connect
	Namespace: callback
	Checksum: 0x202FDC0F
	Offset: 0xC88
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_connect(func, obj)
{
	remove_callback(#"on_player_connect", func, obj);
}

/*
	Name: on_connecting
	Namespace: callback
	Checksum: 0x49AB0659
	Offset: 0xCD0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_connecting(func, obj)
{
	add_callback(#"on_player_connecting", func, obj);
}

/*
	Name: remove_on_connecting
	Namespace: callback
	Checksum: 0xF9E11D0C
	Offset: 0xD18
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_connecting(func, obj)
{
	remove_callback(#"on_player_connecting", func, obj);
}

/*
	Name: on_disconnect
	Namespace: callback
	Checksum: 0x86FC821D
	Offset: 0xD60
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_disconnect(func, obj)
{
	add_callback(#"on_player_disconnect", func, obj);
}

/*
	Name: remove_on_disconnect
	Namespace: callback
	Checksum: 0x40C1C88E
	Offset: 0xDA8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_disconnect(func, obj)
{
	remove_callback(#"on_player_disconnect", func, obj);
}

/*
	Name: on_spawned
	Namespace: callback
	Checksum: 0xDB107381
	Offset: 0xDF0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_spawned(func, obj)
{
	add_callback(#"on_player_spawned", func, obj);
}

/*
	Name: remove_on_spawned
	Namespace: callback
	Checksum: 0xD70D96EC
	Offset: 0xE38
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_spawned(func, obj)
{
	remove_callback(#"on_player_spawned", func, obj);
}

/*
	Name: remove_on_revived
	Namespace: callback
	Checksum: 0x1C26A8A7
	Offset: 0xE80
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_revived(func, obj)
{
	remove_callback(#"on_player_revived", func, obj);
}

/*
	Name: on_deleted
	Namespace: callback
	Checksum: 0x51026241
	Offset: 0xEC8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_deleted(func, obj)
{
	add_callback(#"on_entity_deleted", func, obj);
}

/*
	Name: remove_on_deleted
	Namespace: callback
	Checksum: 0x67BDEFC3
	Offset: 0xF10
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_deleted(func, obj)
{
	remove_callback(#"on_entity_deleted", func, obj);
}

/*
	Name: on_loadout
	Namespace: callback
	Checksum: 0x63CD15D
	Offset: 0xF58
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_loadout(func, obj)
{
	add_callback(#"on_loadout", func, obj);
}

/*
	Name: remove_on_loadout
	Namespace: callback
	Checksum: 0xB96CC40D
	Offset: 0xFA0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_loadout(func, obj)
{
	remove_callback(#"on_loadout", func, obj);
}

/*
	Name: on_player_damage
	Namespace: callback
	Checksum: 0xBC5F2011
	Offset: 0xFE8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_player_damage(func, obj)
{
	add_callback(#"on_player_damage", func, obj);
}

/*
	Name: remove_on_player_damage
	Namespace: callback
	Checksum: 0xB88346CA
	Offset: 0x1030
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_player_damage(func, obj)
{
	remove_callback(#"on_player_damage", func, obj);
}

/*
	Name: on_start_gametype
	Namespace: callback
	Checksum: 0x2A988E1A
	Offset: 0x1078
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_start_gametype(func, obj)
{
	add_callback(#"on_start_gametype", func, obj);
}

/*
	Name: on_end_game
	Namespace: callback
	Checksum: 0xD6F4272
	Offset: 0x10C0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_end_game(func, obj)
{
	add_callback(#"on_end_game", func, obj);
}

/*
	Name: function_14dae612
	Namespace: callback
	Checksum: 0xC6261666
	Offset: 0x1108
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_14dae612(func, obj)
{
	add_callback(#"hash_1b5be9017cd4b5fa", func, obj);
}

/*
	Name: on_game_playing
	Namespace: callback
	Checksum: 0x43B76AD6
	Offset: 0x1150
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_game_playing(func, obj)
{
	add_callback(#"on_game_playing", func, obj);
}

/*
	Name: on_joined_team
	Namespace: callback
	Checksum: 0xA868744
	Offset: 0x1198
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_joined_team(func, obj)
{
	add_callback(#"joined_team", func, obj);
}

/*
	Name: on_joined_spectate
	Namespace: callback
	Checksum: 0xDC8AC6D
	Offset: 0x11E0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_joined_spectate(func, obj)
{
	add_callback(#"on_joined_spectate", func, obj);
}

/*
	Name: on_player_killed
	Namespace: callback
	Checksum: 0x32350EF
	Offset: 0x1228
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_player_killed(func, obj)
{
	add_callback(#"on_player_killed", func, obj);
}

/*
	Name: on_player_killed_with_params
	Namespace: callback
	Checksum: 0xBEB0E916
	Offset: 0x1270
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_player_killed_with_params(func, obj)
{
	add_callback(#"on_player_killed_with_params", func, obj);
}

/*
	Name: on_player_corpse
	Namespace: callback
	Checksum: 0xBC7328FC
	Offset: 0x12B8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_player_corpse(func, obj)
{
	add_callback(#"on_player_corpse", func, obj);
}

/*
	Name: remove_on_player_killed
	Namespace: callback
	Checksum: 0xF0BD5F6
	Offset: 0x1300
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_player_killed(func, obj)
{
	remove_callback(#"on_player_killed", func, obj);
}

/*
	Name: remove_on_player_killed_with_params
	Namespace: callback
	Checksum: 0x601C160E
	Offset: 0x1348
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_player_killed_with_params(func, obj)
{
	remove_callback(#"on_player_killed_with_params", func, obj);
}

/*
	Name: function_80270643
	Namespace: callback
	Checksum: 0x9DED72FF
	Offset: 0x1390
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_80270643(func, obj)
{
	add_callback(#"on_team_eliminated", func, obj);
}

/*
	Name: function_c53a8ab8
	Namespace: callback
	Checksum: 0xFA9CD0F1
	Offset: 0x13D8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_c53a8ab8(func, obj)
{
	remove_callback(#"on_team_eliminated", func, obj);
}

/*
	Name: on_ai_killed
	Namespace: callback
	Checksum: 0x17A981E7
	Offset: 0x1420
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_ai_killed(func, obj)
{
	add_callback(#"on_ai_killed", func, obj);
}

/*
	Name: remove_on_ai_killed
	Namespace: callback
	Checksum: 0xF5C52487
	Offset: 0x1468
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_ai_killed(func, obj)
{
	remove_callback(#"on_ai_killed", func, obj);
}

/*
	Name: on_actor_killed
	Namespace: callback
	Checksum: 0x477BAD34
	Offset: 0x14B0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_actor_killed(func, obj)
{
	add_callback(#"on_actor_killed", func, obj);
}

/*
	Name: remove_on_actor_killed
	Namespace: callback
	Checksum: 0x888FC6E1
	Offset: 0x14F8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_actor_killed(func, obj)
{
	remove_callback(#"on_actor_killed", func, obj);
}

/*
	Name: on_vehicle_spawned
	Namespace: callback
	Checksum: 0xB38D0B55
	Offset: 0x1540
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_vehicle_spawned(func, obj)
{
	add_callback(#"on_vehicle_spawned", func, obj);
}

/*
	Name: remove_on_vehicle_spawned
	Namespace: callback
	Checksum: 0x59EEF38
	Offset: 0x1588
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_vehicle_spawned(func, obj)
{
	remove_callback(#"on_vehicle_spawned", func, obj);
}

/*
	Name: on_vehicle_killed
	Namespace: callback
	Checksum: 0xA5AE4BE8
	Offset: 0x15D0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_vehicle_killed(func, obj)
{
	add_callback(#"on_vehicle_killed", func, obj);
}

/*
	Name: on_vehicle_collision
	Namespace: callback
	Checksum: 0x5AF19C5F
	Offset: 0x1618
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_vehicle_collision(func, obj)
{
	function_d8abfc3d(#"veh_collision", func, obj);
}

/*
	Name: remove_on_vehicle_killed
	Namespace: callback
	Checksum: 0x2687D486
	Offset: 0x1660
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_vehicle_killed(func, obj)
{
	remove_callback(#"on_vehicle_killed", func, obj);
}

/*
	Name: on_ai_damage
	Namespace: callback
	Checksum: 0xA3674D7
	Offset: 0x16A8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_ai_damage(func, obj)
{
	add_callback(#"on_ai_damage", func, obj);
}

/*
	Name: remove_on_ai_damage
	Namespace: callback
	Checksum: 0x87E496AF
	Offset: 0x16F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_ai_damage(func, obj)
{
	remove_callback(#"on_ai_damage", func, obj);
}

/*
	Name: on_ai_spawned
	Namespace: callback
	Checksum: 0xCB569F75
	Offset: 0x1738
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_ai_spawned(func, obj)
{
	add_callback(#"on_ai_spawned", func, obj);
}

/*
	Name: remove_on_ai_spawned
	Namespace: callback
	Checksum: 0x2CFA1CDC
	Offset: 0x1780
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_ai_spawned(func, obj)
{
	remove_callback(#"on_ai_spawned", func, obj);
}

/*
	Name: on_actor_damage
	Namespace: callback
	Checksum: 0x86F92B65
	Offset: 0x17C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_actor_damage(func, obj)
{
	add_callback(#"on_actor_damage", func, obj);
}

/*
	Name: remove_on_actor_damage
	Namespace: callback
	Checksum: 0x437B455C
	Offset: 0x1810
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_actor_damage(func, obj)
{
	remove_callback(#"on_actor_damage", func, obj);
}

/*
	Name: function_9d78f548
	Namespace: callback
	Checksum: 0x3CDC138B
	Offset: 0x1858
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_9d78f548(func, obj)
{
	add_callback(#"hash_2e68909d4e4ed889", func, obj);
}

/*
	Name: function_f125b93a
	Namespace: callback
	Checksum: 0x6AC669DF
	Offset: 0x18A0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_f125b93a(func, obj)
{
	remove_callback(#"hash_2e68909d4e4ed889", func, obj);
}

/*
	Name: on_vehicle_damage
	Namespace: callback
	Checksum: 0xADF1F59A
	Offset: 0x18E8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_vehicle_damage(func, obj)
{
	add_callback(#"on_vehicle_damage", func, obj);
}

/*
	Name: remove_on_vehicle_damage
	Namespace: callback
	Checksum: 0x51A076CC
	Offset: 0x1930
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_vehicle_damage(func, obj)
{
	remove_callback(#"on_vehicle_damage", func, obj);
}

/*
	Name: on_downed
	Namespace: callback
	Checksum: 0x454AC3AD
	Offset: 0x1978
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_downed(func, obj)
{
	add_callback(#"on_player_downed", func, obj);
}

/*
	Name: remove_on_downed
	Namespace: callback
	Checksum: 0x4390435
	Offset: 0x19C0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_downed(func, obj)
{
	remove_callback(#"on_player_downed", func, obj);
}

/*
	Name: on_laststand
	Namespace: callback
	Checksum: 0xE74C576D
	Offset: 0x1A08
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_laststand(func, obj)
{
	add_callback(#"on_player_laststand", func, obj);
}

/*
	Name: remove_on_laststand
	Namespace: callback
	Checksum: 0x3D1933D7
	Offset: 0x1A50
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_laststand(func, obj)
{
	remove_callback(#"on_player_laststand", func, obj);
}

/*
	Name: on_bleedout
	Namespace: callback
	Checksum: 0xD6A8A085
	Offset: 0x1A98
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_bleedout(func, obj)
{
	add_callback(#"on_player_bleedout", func, obj);
}

/*
	Name: on_revived
	Namespace: callback
	Checksum: 0x3FFBB095
	Offset: 0x1AE0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_revived(func, obj)
{
	add_callback(#"on_player_revived", func, obj);
}

/*
	Name: on_mission_failed
	Namespace: callback
	Checksum: 0xE314F14
	Offset: 0x1B28
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_mission_failed(func, obj)
{
	add_callback(#"on_mission_failed", func, obj);
}

/*
	Name: on_challenge_complete
	Namespace: callback
	Checksum: 0xF40D52C4
	Offset: 0x1B70
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_challenge_complete(func, obj)
{
	add_callback(#"on_challenge_complete", func, obj);
}

/*
	Name: on_weapon_change
	Namespace: callback
	Checksum: 0x3ED583EA
	Offset: 0x1BB8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_weapon_change(func, obj)
{
	add_callback(#"weapon_change", func, obj);
}

/*
	Name: remove_on_weapon_change
	Namespace: callback
	Checksum: 0xB325B099
	Offset: 0x1C00
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_weapon_change(func, obj)
{
	remove_callback(#"weapon_change", func, obj);
}

/*
	Name: on_weapon_fired
	Namespace: callback
	Checksum: 0xEE4E1D97
	Offset: 0x1C48
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_weapon_fired(func, obj)
{
	add_callback(#"weapon_fired", func, obj);
}

/*
	Name: remove_on_weapon_fired
	Namespace: callback
	Checksum: 0x8E15FE5A
	Offset: 0x1C90
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_weapon_fired(func, obj)
{
	remove_callback(#"weapon_fired", func, obj);
}

/*
	Name: on_grenade_fired
	Namespace: callback
	Checksum: 0x8EA2A6D9
	Offset: 0x1CD8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_grenade_fired(func, obj)
{
	add_callback(#"grenade_fired", func, obj);
}

/*
	Name: remove_on_grenade_fired
	Namespace: callback
	Checksum: 0x21318271
	Offset: 0x1D20
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_grenade_fired(func, obj)
{
	remove_callback(#"grenade_fired", func, obj);
}

/*
	Name: on_offhand_fire
	Namespace: callback
	Checksum: 0xE4FEF738
	Offset: 0x1D68
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_offhand_fire(func, obj)
{
	add_callback(#"offhand_fire", func, obj);
}

/*
	Name: remove_on_offhand_fire
	Namespace: callback
	Checksum: 0x44A90068
	Offset: 0x1DB0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_offhand_fire(func, obj)
{
	remove_callback(#"offhand_fire", func, obj);
}

/*
	Name: function_4b7977fe
	Namespace: callback
	Checksum: 0xFBF1A71A
	Offset: 0x1DF8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_4b7977fe(func, obj)
{
	add_callback(#"hash_198a389d6b65f68d", func, obj);
}

/*
	Name: function_61583a71
	Namespace: callback
	Checksum: 0xC315505C
	Offset: 0x1E40
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_61583a71(func, obj)
{
	remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

/*
	Name: on_detonate
	Namespace: callback
	Checksum: 0xB80C13E5
	Offset: 0x1E88
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_detonate(func, obj)
{
	function_d8abfc3d(#"detonate", func, obj);
}

/*
	Name: remove_on_detonate
	Namespace: callback
	Checksum: 0xBD40B1E5
	Offset: 0x1ED0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_detonate(func, obj)
{
	function_52ac9652(#"detonate", func, obj);
}

/*
	Name: on_double_tap_detonate
	Namespace: callback
	Checksum: 0xB772467A
	Offset: 0x1F18
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_double_tap_detonate(func, obj)
{
	function_d8abfc3d(#"doubletap_detonate", func, obj);
}

/*
	Name: remove_on_double_tap_detonate
	Namespace: callback
	Checksum: 0x2FC056B4
	Offset: 0x1F60
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_double_tap_detonate(func, obj)
{
	function_52ac9652(#"doubletap_detonate", func, obj);
}

/*
	Name: on_death
	Namespace: callback
	Checksum: 0xE537229B
	Offset: 0x1FA8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_death(func, obj)
{
	function_d8abfc3d(#"death", func, obj);
}

/*
	Name: remove_on_death
	Namespace: callback
	Checksum: 0x6BE04E4D
	Offset: 0x1FF0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_death(func, obj)
{
	function_52ac9652(#"death", func, obj);
}

/*
	Name: function_27d9ab8
	Namespace: callback
	Checksum: 0x2E2FB659
	Offset: 0x2038
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_27d9ab8(func, obj)
{
	add_callback(#"hash_1e4a4ca774f4ce22", func, obj);
}

/*
	Name: on_trigger
	Namespace: callback
	Checksum: 0xAD8DDD2F
	Offset: 0x2080
	Size: 0x44
	Parameters: 3
	Flags: Linked, Variadic
*/
function on_trigger(func, obj, ...)
{
	function_d8abfc3d(#"on_trigger", func, obj, vararg);
}

/*
	Name: remove_on_trigger
	Namespace: callback
	Checksum: 0xE0034CC6
	Offset: 0x20D0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_trigger(func, obj)
{
	function_52ac9652(#"on_trigger", func, obj);
}

/*
	Name: on_trigger_once
	Namespace: callback
	Checksum: 0xFAA7ACC
	Offset: 0x2118
	Size: 0x44
	Parameters: 3
	Flags: Linked, Variadic
*/
function on_trigger_once(func, obj, ...)
{
	function_d8abfc3d(#"on_trigger_once", func, obj, vararg);
}

/*
	Name: remove_on_trigger_once
	Namespace: callback
	Checksum: 0xACDAC15
	Offset: 0x2168
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_trigger_once(func, obj)
{
	function_52ac9652(#"on_trigger_once", func, obj);
}

/*
	Name: function_33f0ddd3
	Namespace: callback
	Checksum: 0x9229CD7B
	Offset: 0x21B0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_33f0ddd3(func, obj)
{
	add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

/*
	Name: function_824d206
	Namespace: callback
	Checksum: 0x995ACE6C
	Offset: 0x21F8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_824d206(func, obj)
{
	remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

/*
	Name: on_boast
	Namespace: callback
	Checksum: 0x8F34252E
	Offset: 0x2240
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_boast(func, obj)
{
	add_callback(#"on_boast", func, obj);
}

/*
	Name: remove_on_boast
	Namespace: callback
	Checksum: 0xFC4C89E7
	Offset: 0x2288
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_boast(func, obj)
{
	remove_callback(#"on_boast", func, obj);
}

/*
	Name: function_5753ac6e
	Namespace: callback
	Checksum: 0x22CAE9FF
	Offset: 0x22D0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_5753ac6e(func, obj)
{
	add_callback(#"hash_4a9c56bba76da754", func, obj);
}

/*
	Name: function_16046baa
	Namespace: callback
	Checksum: 0x3772DA9C
	Offset: 0x2318
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_16046baa(func, obj)
{
	remove_callback(#"hash_4a9c56bba76da754", func, obj);
}

/*
	Name: on_menu_response
	Namespace: callback
	Checksum: 0x8576071B
	Offset: 0x2360
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_menu_response(func, obj)
{
	add_callback(#"on_menu_response", func, obj);
}

/*
	Name: on_item_pickup
	Namespace: callback
	Checksum: 0x1B6691D0
	Offset: 0x23A8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_item_pickup(func, obj)
{
	add_callback(#"on_item_pickup", func, obj);
}

/*
	Name: on_item_drop
	Namespace: callback
	Checksum: 0xC70847ED
	Offset: 0x23F0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_item_drop(func, obj)
{
	add_callback(#"on_drop_item", func, obj);
}

/*
	Name: on_drop_inventory
	Namespace: callback
	Checksum: 0x475D4D10
	Offset: 0x2438
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_drop_inventory(func, obj)
{
	add_callback(#"on_drop_inventory", func, obj);
}

/*
	Name: on_item_use
	Namespace: callback
	Checksum: 0xA80B4B56
	Offset: 0x2480
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_item_use(func, obj)
{
	add_callback(#"on_item_use", func, obj);
}

/*
	Name: on_stash_open
	Namespace: callback
	Checksum: 0x4DFD68BB
	Offset: 0x24C8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_stash_open(func, obj)
{
	add_callback(#"on_stash_open", func, obj);
}

/*
	Name: on_character_unlock
	Namespace: callback
	Checksum: 0x3F88FE8E
	Offset: 0x2510
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_character_unlock(func, obj)
{
	add_callback(#"on_character_unlock", func, obj);
}

/*
	Name: on_contract_complete
	Namespace: callback
	Checksum: 0xA84A0571
	Offset: 0x2558
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_contract_complete(func, obj)
{
	add_callback(#"contract_complete", func, obj);
}

/*
	Name: codecallback_preinitialization
	Namespace: callback
	Checksum: 0x1073802E
	Offset: 0x25A0
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_preinitialization(eventstruct)
{
	callback(#"on_pre_initialization");
	system::run_pre_systems();
}

/*
	Name: codecallback_finalizeinitialization
	Namespace: callback
	Checksum: 0xFA2CCC8A
	Offset: 0x25E8
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_finalizeinitialization(eventstruct)
{
	system::run_post_systems();
	callback(#"on_finalize_initialization");
}

/*
	Name: add_weapon_damage
	Namespace: callback
	Checksum: 0x8E7F1694
	Offset: 0x2630
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function add_weapon_damage(weapontype, callback)
{
	if(!isdefined(level.weapon_damage_callback_array))
	{
		level.weapon_damage_callback_array = [];
	}
	level.weapon_damage_callback_array[weapontype] = callback;
}

/*
	Name: callback_weapon_damage
	Namespace: callback
	Checksum: 0x90C9D5E0
	Offset: 0x2688
	Size: 0xDA
	Parameters: 5
	Flags: None
*/
function callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage)
{
	if(isdefined(level.weapon_damage_callback_array))
	{
		if(isdefined(level.weapon_damage_callback_array[weapon]))
		{
			self thread [[level.weapon_damage_callback_array[weapon]]](eattacker, einflictor, weapon, meansofdeath, damage);
			return true;
		}
		if(isdefined(level.weapon_damage_callback_array[weapon.rootweapon]))
		{
			self thread [[level.weapon_damage_callback_array[weapon.rootweapon]]](eattacker, einflictor, weapon, meansofdeath, damage);
			return true;
		}
	}
	return false;
}

/*
	Name: add_weapon_fired
	Namespace: callback
	Checksum: 0x95A05DA1
	Offset: 0x2770
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function add_weapon_fired(weapon, callback)
{
	if(!isdefined(level.var_129c2069))
	{
		level.var_129c2069 = [];
	}
	level.var_129c2069[weapon] = callback;
}

/*
	Name: callback_weapon_fired
	Namespace: callback
	Checksum: 0x3A6C7E69
	Offset: 0x27C8
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function callback_weapon_fired(weapon)
{
	if(isdefined(weapon) && isdefined(level.var_129c2069))
	{
		if(isdefined(level.var_129c2069[weapon]))
		{
			self thread [[level.var_129c2069[weapon]]](weapon);
			return true;
		}
		if(isdefined(level.var_129c2069[weapon.rootweapon]))
		{
			self thread [[level.var_129c2069[weapon.rootweapon]]](weapon);
			return true;
		}
	}
	return false;
}

/*
	Name: codecallback_startgametype
	Namespace: callback
	Checksum: 0xF0291F72
	Offset: 0x2878
	Size: 0x4E
	Parameters: 1
	Flags: Event
*/
event codecallback_startgametype(eventstruct)
{
	if(!isdefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[level.callbackstartgametype]]();
		level.gametypestarted = 1;
	}
}

/*
	Name: codecallback_playerconnect
	Namespace: callback
	Checksum: 0xBDCB6DA4
	Offset: 0x28D0
	Size: 0x30
	Parameters: 1
	Flags: Event
*/
event codecallback_playerconnect(eventstruct)
{
	self endon(#"disconnect");
	[[level.callbackplayerconnect]]();
}

/*
	Name: codecallback_playerdisconnect
	Namespace: callback
	Checksum: 0x949EDE02
	Offset: 0x2908
	Size: 0x8C
	Parameters: 1
	Flags: Event
*/
event codecallback_playerdisconnect(eventstruct)
{
	self notify(#"death");
	self.player_disconnected = 1;
	self notify(#"disconnect");
	level notify(#"disconnect", self);
	[[level.callbackplayerdisconnect]]();
	callback(#"on_player_disconnect");
}

/*
	Name: codecallback_migration_setupgametype
	Namespace: callback
	Checksum: 0xD1FA637F
	Offset: 0x29A0
	Size: 0x34
	Parameters: 0
	Flags: Event
*/
event codecallback_migration_setupgametype()
{
	/#
		println("");
	#/
	simple_hostmigration::migration_setupgametype();
}

/*
	Name: codecallback_hostmigration
	Namespace: callback
	Checksum: 0x79F45823
	Offset: 0x29E0
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_hostmigration(eventstruct)
{
	/#
		println("");
	#/
	[[level.callbackhostmigration]]();
}

/*
	Name: codecallback_hostmigrationsave
	Namespace: callback
	Checksum: 0xE574ED37
	Offset: 0x2A28
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_hostmigrationsave(eventstruct)
{
	/#
		println("");
	#/
	[[level.callbackhostmigrationsave]]();
}

/*
	Name: codecallback_prehostmigrationsave
	Namespace: callback
	Checksum: 0x96B466D8
	Offset: 0x2A70
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_prehostmigrationsave(eventstruct)
{
	/#
		println("");
	#/
	[[level.callbackprehostmigrationsave]]();
}

/*
	Name: codecallback_playermigrated
	Namespace: callback
	Checksum: 0xA089CCB2
	Offset: 0x2AB8
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_playermigrated(eventstruct)
{
	/#
		println("");
	#/
	[[level.callbackplayermigrated]]();
}

/*
	Name: codecallback_playerdamage
	Namespace: callback
	Checksum: 0x92E884BD
	Offset: 0x2B00
	Size: 0xC8
	Parameters: 1
	Flags: Event
*/
event codecallback_playerdamage(eventstruct)
{
	self endon(#"disconnect");
	[[level.callbackplayerdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

/*
	Name: codecallback_playerkilled
	Namespace: callback
	Checksum: 0x7354F8EF
	Offset: 0x2BD0
	Size: 0x98
	Parameters: 1
	Flags: Event
*/
event codecallback_playerkilled(eventstruct)
{
	self endon(#"disconnect");
	[[level.callbackplayerkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

/*
	Name: function_73e8e3f9
	Namespace: callback
	Checksum: 0x6A44544A
	Offset: 0x2C70
	Size: 0x78
	Parameters: 1
	Flags: Event
*/
event function_73e8e3f9(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_3a9881cb))
	{
		[[level.var_3a9881cb]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_894859a2, eventstruct.var_ab5b905e, eventstruct.weapon);
	}
}

/*
	Name: function_323548ba
	Namespace: callback
	Checksum: 0x7CF95E65
	Offset: 0x2CF0
	Size: 0x38
	Parameters: 1
	Flags: Event
*/
event function_323548ba(eventstruct)
{
	self endon(#"disconnect");
	[[level.callbackplayershielddamageblocked]](eventstruct.damage);
}

/*
	Name: codecallback_playerlaststand
	Namespace: callback
	Checksum: 0xCC25887A
	Offset: 0x2D30
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event codecallback_playerlaststand(eventstruct)
{
	self endon(#"disconnect");
	self stopanimscripted();
	[[level.callbackplayerlaststand]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

/*
	Name: function_46c0443b
	Namespace: callback
	Checksum: 0x199E784F
	Offset: 0x2DE8
	Size: 0x38
	Parameters: 1
	Flags: Event
*/
event function_46c0443b(eventstruct)
{
	self endon(#"disconnect");
	[[level.var_69959686]](eventstruct.weapon);
}

/*
	Name: function_9e4c68e2
	Namespace: callback
	Checksum: 0x6DB8E9DE
	Offset: 0x2E28
	Size: 0x48
	Parameters: 1
	Flags: Event
*/
event function_9e4c68e2(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_bb1ea3f1))
	{
		[[level.var_bb1ea3f1]](eventstruct.weapon);
	}
}

/*
	Name: function_2f677e9d
	Namespace: callback
	Checksum: 0x9ABDED37
	Offset: 0x2E78
	Size: 0x48
	Parameters: 1
	Flags: Event
*/
event function_2f677e9d(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_2f64d35))
	{
		[[level.var_2f64d35]](eventstruct.weapon);
	}
}

/*
	Name: function_d7eb3672
	Namespace: callback
	Checksum: 0xB9A743F3
	Offset: 0x2EC8
	Size: 0x48
	Parameters: 1
	Flags: Event
*/
event function_d7eb3672(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_a28be0a5))
	{
		[[level.var_a28be0a5]](eventstruct.weapon);
	}
}

/*
	Name: function_7dba9a1
	Namespace: callback
	Checksum: 0x9A480B36
	Offset: 0x2F18
	Size: 0x48
	Parameters: 1
	Flags: Event
*/
event function_7dba9a1(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_bd0b5fc1))
	{
		[[level.var_bd0b5fc1]](eventstruct.weapon);
	}
}

/*
	Name: function_3b159f77
	Namespace: callback
	Checksum: 0x261A9AB8
	Offset: 0x2F68
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event function_3b159f77(eventstruct)
{
	self endon(#"disconnect");
	if(isdefined(level.var_4268159))
	{
		[[level.var_4268159]](eventstruct.gestureindex, eventstruct.animlength);
	}
	callback(#"on_boast", eventstruct);
}

/*
	Name: function_e35aeddd
	Namespace: callback
	Checksum: 0x21C0A6EA
	Offset: 0x2FE8
	Size: 0x44
	Parameters: 1
	Flags: Event
*/
event function_e35aeddd(eventstruct)
{
	self endon(#"disconnect");
	callback(#"hash_4a9c56bba76da754");
}

/*
	Name: codecallback_playermelee
	Namespace: callback
	Checksum: 0xF17BE2E6
	Offset: 0x3038
	Size: 0x8C
	Parameters: 1
	Flags: Event
*/
event codecallback_playermelee(eventstruct)
{
	self endon(#"disconnect");
	[[level.callbackplayermelee]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

/*
	Name: codecallback_actorspawned
	Namespace: callback
	Checksum: 0x130666F
	Offset: 0x30D0
	Size: 0x28
	Parameters: 1
	Flags: Event
*/
event codecallback_actorspawned(eventstruct)
{
	self [[level.callbackactorspawned]](eventstruct.entity);
}

/*
	Name: codecallback_actordamage
	Namespace: callback
	Checksum: 0xC6815F52
	Offset: 0x3100
	Size: 0xCC
	Parameters: 1
	Flags: Event
*/
event codecallback_actordamage(eventstruct)
{
	[[level.callbackactordamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

/*
	Name: codecallback_actorkilled
	Namespace: callback
	Checksum: 0xD2B47BA8
	Offset: 0x31D8
	Size: 0x78
	Parameters: 1
	Flags: Event
*/
event codecallback_actorkilled(eventstruct)
{
	[[level.callbackactorkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

/*
	Name: codecallback_actorcloned
	Namespace: callback
	Checksum: 0x93AFC83C
	Offset: 0x3258
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event codecallback_actorcloned(eventstruct)
{
	[[level.callbackactorcloned]](eventstruct.clone);
}

/*
	Name: function_5b0a9275
	Namespace: callback
	Checksum: 0xD038FC8
	Offset: 0x3288
	Size: 0xD8
	Parameters: 1
	Flags: Event
*/
event function_5b0a9275(eventstruct)
{
	[[level.var_6788bf11]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

/*
	Name: codecallback_vehiclespawned
	Namespace: callback
	Checksum: 0xC74C14F1
	Offset: 0x3368
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event codecallback_vehiclespawned(eventstruct)
{
	if(isdefined(level.callbackvehiclespawned))
	{
		[[level.callbackvehiclespawned]](eventstruct.spawner);
	}
}

/*
	Name: codecallback_vehiclekilled
	Namespace: callback
	Checksum: 0x8E2A6E58
	Offset: 0x33A8
	Size: 0x78
	Parameters: 1
	Flags: Event
*/
event codecallback_vehiclekilled(eventstruct)
{
	[[level.callbackvehiclekilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

/*
	Name: codecallback_vehicledamage
	Namespace: callback
	Checksum: 0x18886C80
	Offset: 0x3428
	Size: 0xCC
	Parameters: 1
	Flags: Event
*/
event codecallback_vehicledamage(eventstruct)
{
	[[level.callbackvehicledamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

/*
	Name: codecallback_vehicleradiusdamage
	Namespace: callback
	Checksum: 0x632B3A7
	Offset: 0x3500
	Size: 0xB4
	Parameters: 1
	Flags: Event
*/
event codecallback_vehicleradiusdamage(eventstruct)
{
	[[level.callbackvehicleradiusdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
}

/*
	Name: finishcustomtraversallistener
	Namespace: callback
	Checksum: 0xF544437D
	Offset: 0x35C0
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function finishcustomtraversallistener()
{
	self endon(#"death");
	self waittillmatch({#notetrack:"end"}, #"custom_traversal_anim_finished");
	self finishtraversal();
	self unlink();
	self.usegoalanimweight = 0;
	self.blockingpain = 0;
	self.customtraverseendnode = undefined;
	self.customtraversestartnode = undefined;
	self notify(#"custom_traversal_cleanup");
}

/*
	Name: killedcustomtraversallistener
	Namespace: callback
	Checksum: 0x94AA7060
	Offset: 0x3678
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function killedcustomtraversallistener()
{
	self endon(#"custom_traversal_cleanup");
	self waittill(#"death");
	if(isdefined(self))
	{
		self finishtraversal();
		self stopanimscripted();
		self unlink();
	}
}

/*
	Name: codecallback_playcustomtraversal
	Namespace: callback
	Checksum: 0x77A15D6B
	Offset: 0x36F8
	Size: 0x1CC
	Parameters: 1
	Flags: Event
*/
event codecallback_playcustomtraversal(eventstruct)
{
	entity = eventstruct.entity;
	endparent = eventstruct.end_entity;
	entity.blockingpain = 1;
	entity.usegoalanimweight = 1;
	entity.customtraverseendnode = entity.traverseendnode;
	entity.customtraversestartnode = entity.traversestartnode;
	entity animmode("noclip", 0);
	entity orientmode("face angle", eventstruct.direction[1]);
	if(isdefined(endparent))
	{
		offset = entity.origin - endparent.origin;
		entity linkto(endparent, "", offset);
	}
	entity animscripted("custom_traversal_anim_finished", eventstruct.location, eventstruct.direction, eventstruct.animation, eventstruct.anim_mode, undefined, eventstruct.playback_speed, eventstruct.goal_time, eventstruct.lerp_time);
	entity thread finishcustomtraversallistener();
	entity thread killedcustomtraversallistener();
}

/*
	Name: codecallback_faceeventnotify
	Namespace: callback
	Checksum: 0x9324FCE4
	Offset: 0x38D0
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function codecallback_faceeventnotify(notify_msg, ent)
{
	if(isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims)
	{
		if(isdefined(level.face_event_handler) && isdefined(level.face_event_handler.events[notify_msg]))
		{
			ent sendfaceevent(level.face_event_handler.events[notify_msg]);
		}
	}
}

/*
	Name: codecallback_menuresponse
	Namespace: callback
	Checksum: 0x7C1CA8A
	Offset: 0x3978
	Size: 0xA8
	Parameters: 1
	Flags: Event
*/
event codecallback_menuresponse(eventstruct)
{
	if(!isdefined(level.menuresponsequeue))
	{
		level.menuresponsequeue = [];
		level thread menu_response_queue_pump();
	}
	index = level.menuresponsequeue.size;
	level.menuresponsequeue[index] = {#eventstruct:eventstruct, #ent:self};
	level notify(#"menuresponse_queue");
}

/*
	Name: menu_response_queue_pump
	Namespace: callback
	Checksum: 0xD341ED76
	Offset: 0x3A28
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function menu_response_queue_pump()
{
	while(true)
	{
		level waittill(#"menuresponse_queue");
		do
		{
			if(isdefined(level.menuresponsequeue[0].ent))
			{
				level.menuresponsequeue[0].ent notify(#"menuresponse", level.menuresponsequeue[0].eventstruct);
				level.menuresponsequeue[0].ent callback(#"menu_response", level.menuresponsequeue[0].eventstruct);
			}
			arrayremoveindex(level.menuresponsequeue, 0, 0);
			waitframe(1);
		}
		while(level.menuresponsequeue.size > 0);
	}
}

/*
	Name: codecallback_callserverscript
	Namespace: callback
	Checksum: 0xA961AFF4
	Offset: 0x3B28
	Size: 0xDE
	Parameters: 1
	Flags: Event
*/
event codecallback_callserverscript(eventstruct)
{
	if(!isdefined(level._animnotifyfuncs))
	{
		return;
	}
	if(isdefined(level._animnotifyfuncs[eventstruct.label]))
	{
		if(isdefined(eventstruct.param3) && eventstruct.param3 != "")
		{
			eventstruct.entity [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
		}
		else
		{
			eventstruct.entity [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
		}
	}
}

/*
	Name: codecallback_callserverscriptonlevel
	Namespace: callback
	Checksum: 0x425CED8
	Offset: 0x3C10
	Size: 0xCE
	Parameters: 1
	Flags: Event
*/
event codecallback_callserverscriptonlevel(eventstruct)
{
	if(!isdefined(level._animnotifyfuncs))
	{
		return;
	}
	if(isdefined(level._animnotifyfuncs[eventstruct.label]))
	{
		if(isdefined(eventstruct.param3) && eventstruct.param3 != "")
		{
			level [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
		}
		else
		{
			level [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
		}
	}
}

/*
	Name: function_2073f6dc
	Namespace: callback
	Checksum: 0x662950E9
	Offset: 0x3CE8
	Size: 0x10C
	Parameters: 1
	Flags: Event
*/
event function_2073f6dc(eventstruct)
{
	origin = self.origin;
	magnitude = float(eventstruct.magnitude);
	innerradius = float(eventstruct.innerradius);
	outerradius = int(eventstruct.outerradius);
	innerdamage = (isdefined(self.var_f501d778) ? self.var_f501d778 : 50);
	outerdamage = (isdefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25);
	physicsexplosionsphere(origin, outerradius, innerradius, magnitude, outerdamage, innerdamage);
}

/*
	Name: codecallback_launchsidemission
	Namespace: callback
	Checksum: 0x1568D98C
	Offset: 0x3E00
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event codecallback_launchsidemission(eventstruct)
{
	switchmap_preload(eventstruct.name, eventstruct.game_type);
	luinotifyevent(#"open_side_mission_countdown", 1, eventstruct.list_index);
	wait(10);
	luinotifyevent(#"close_side_mission_countdown");
	switchmap_switch();
}

/*
	Name: codecallback_fadeblackscreen
	Namespace: callback
	Checksum: 0xE79A0065
	Offset: 0x3EA8
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event codecallback_fadeblackscreen(eventstruct)
{
	if(isplayer(self) && !isbot(self))
	{
		self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
	}
}

/*
	Name: function_4b5ab05f
	Namespace: callback
	Checksum: 0xD44578B2
	Offset: 0x3F30
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event function_4b5ab05f(eventstruct)
{
	if(isplayer(self) && !isbot(self))
	{
		self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
	}
}

/*
	Name: abort_level
	Namespace: callback
	Checksum: 0xE3BEC634
	Offset: 0x3FB8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function abort_level()
{
	/#
		println("");
	#/
	level.callbackstartgametype = &callback_void;
	level.callbackplayerconnect = &callback_void;
	level.callbackplayerdisconnect = &callback_void;
	level.callbackplayerdamage = &callback_void;
	level.callbackplayerkilled = &callback_void;
	level.var_3a9881cb = &callback_void;
	level.callbackplayerlaststand = &callback_void;
	level.var_4268159 = &callback_void;
	level.var_69959686 = &callback_void;
	level.callbackplayermelee = &callback_void;
	level.callbackactordamage = &callback_void;
	level.callbackactorkilled = &callback_void;
	level.var_6788bf11 = &callback_void;
	level.callbackvehicledamage = &callback_void;
	level.callbackvehiclekilled = &callback_void;
	level.callbackactorspawned = &callback_void;
	level.callbackbotentereduseredge = &callback_void;
	level.callbackbotcreateplayerbot = &callback_void;
	level.callbackbotshutdown = &callback_void;
	if(isdefined(level._gametype_default))
	{
		setdvar(#"g_gametype", level._gametype_default);
	}
	exitlevel(0);
}

/*
	Name: codecallback_glasssmash
	Namespace: callback
	Checksum: 0x302837F3
	Offset: 0x4200
	Size: 0x58
	Parameters: 1
	Flags: Event
*/
event codecallback_glasssmash(eventstruct)
{
	level notify(#"glass_smash", {#direction:eventstruct.direction, #position:eventstruct.position});
}

/*
	Name: function_5019e563
	Namespace: callback
	Checksum: 0xBDE21233
	Offset: 0x4260
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_5019e563(eventstruct)
{
	self callback(#"freefall", eventstruct);
}

/*
	Name: function_87b05fa3
	Namespace: callback
	Checksum: 0xA8DCF8F4
	Offset: 0x4298
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_87b05fa3(eventstruct)
{
	self callback(#"parachute", eventstruct);
}

/*
	Name: codecallback_swimming
	Namespace: callback
	Checksum: 0xBAE084F6
	Offset: 0x42D0
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_swimming(eventstruct)
{
	self callback(#"swimming", eventstruct);
}

/*
	Name: codecallback_underwater
	Namespace: callback
	Checksum: 0x5F1CA4AA
	Offset: 0x4308
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_underwater(eventstruct)
{
	self callback(#"underwater", eventstruct);
}

/*
	Name: function_8877d89
	Namespace: callback
	Checksum: 0xEB732E3C
	Offset: 0x4340
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_8877d89(eventstruct)
{
	self callback(#"hash_42aa89b2a0951308", eventstruct);
}

/*
	Name: function_930ce3c3
	Namespace: callback
	Checksum: 0x1CED91B2
	Offset: 0x4378
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event function_930ce3c3(eventstruct)
{
	/#
		self callback(#"debug_movement", eventstruct);
	#/
}

/*
	Name: function_7d45bff
	Namespace: callback
	Checksum: 0x315DA427
	Offset: 0x43B8
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event function_7d45bff(eventstruct)
{
	self endon(#"death");
	level flagsys::wait_till("system_init_complete");
	self callback(#"hash_1e4a4ca774f4ce22");
}

/*
	Name: codecallback_trigger
	Namespace: callback
	Checksum: 0x71DA971F
	Offset: 0x4420
	Size: 0xB4
	Parameters: 2
	Flags: Linked, Event
*/
event codecallback_trigger(eventstruct, look_trigger = 0)
{
	if(look_trigger || !trigger::is_look_trigger())
	{
		self util::script_delay();
		self callback(#"on_trigger", eventstruct);
		self callback(#"on_trigger_once", eventstruct);
		self remove_on_trigger_once("all");
	}
}

/*
	Name: codecallback_entitydeleted
	Namespace: callback
	Checksum: 0x1FEC034A
	Offset: 0x44E0
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_entitydeleted(eventstruct)
{
	self callback(#"on_entity_deleted");
}

/*
	Name: codecallback_botentereduseredge
	Namespace: callback
	Checksum: 0x775922FD
	Offset: 0x4518
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event codecallback_botentereduseredge(eventstruct)
{
	self [[level.callbackbotentereduseredge]](eventstruct.start_node, eventstruct.end_node, eventstruct.mantle_node, eventstruct.start_position, eventstruct.end_position, eventstruct.var_a8cc518d);
}

/*
	Name: codecallback_botcreateplayerbot
	Namespace: callback
	Checksum: 0x3A82429E
	Offset: 0x4588
	Size: 0x20
	Parameters: 1
	Flags: Event
*/
event codecallback_botcreateplayerbot(eventstruct)
{
	self [[level.callbackbotcreateplayerbot]]();
}

/*
	Name: codecallback_botstopupdate
	Namespace: callback
	Checksum: 0x3DD61E80
	Offset: 0x45B0
	Size: 0x20
	Parameters: 1
	Flags: Event
*/
event codecallback_botstopupdate(eventstruct)
{
	self [[level.callbackbotshutdown]]();
}

/*
	Name: function_451258ba
	Namespace: callback
	Checksum: 0x25FB09CE
	Offset: 0x45D8
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event function_451258ba(eventstruct)
{
	self voice_events::function_c710099c(eventstruct.event, eventstruct.params);
}

/*
	Name: function_f5026566
	Namespace: callback
	Checksum: 0x5BC6CC04
	Offset: 0x4618
	Size: 0xA4
	Parameters: 1
	Flags: Event
*/
event function_f5026566(eventstruct)
{
	if(!isdefined(level.var_abb3fd2))
	{
		return;
	}
	/#
	#/
	eventdata = {};
	eventdata.tableindex = eventstruct.tableindex;
	eventdata.event_info = eventstruct.event_info;
	self [[level.var_abb3fd2]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

/*
	Name: codecallback_decoration
	Namespace: callback
	Checksum: 0x9E7DAC33
	Offset: 0x46C8
	Size: 0x70
	Parameters: 1
	Flags: Event
*/
event codecallback_decoration(eventstruct)
{
	a_decorations = self getdecorations(1);
	if(!isdefined(a_decorations))
	{
		return;
	}
	level notify(#"decoration_awarded", a_decorations.size == 12);
	[[level.callbackdecorationawarded]]();
}

/*
	Name: function_f4449e63
	Namespace: callback
	Checksum: 0x2CB8931B
	Offset: 0x4740
	Size: 0x58
	Parameters: 1
	Flags: Event
*/
event function_f4449e63(eventstruct)
{
	if(isdefined(level.var_17c7288a))
	{
		[[level.var_17c7288a]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_c5a66313);
	}
}

/*
	Name: codecallback_detonate
	Namespace: callback
	Checksum: 0xE4B0DA1C
	Offset: 0x47A0
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_detonate(eventstruct)
{
	self callback(#"detonate", eventstruct);
}

/*
	Name: function_92aba4c4
	Namespace: callback
	Checksum: 0x13044A33
	Offset: 0x47D8
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_92aba4c4(eventstruct)
{
	self callback(#"doubletap_detonate", eventstruct);
}

/*
	Name: codecallback_death
	Namespace: callback
	Checksum: 0xE6FF4420
	Offset: 0x4810
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_death(eventstruct)
{
	self callback(#"death", eventstruct);
}

/*
	Name: callback_void
	Namespace: callback
	Checksum: 0x80F724D1
	Offset: 0x4848
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function callback_void()
{
}

