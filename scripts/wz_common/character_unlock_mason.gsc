// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_mason;

/*
	Name: __init__system__
	Namespace: character_unlock_mason
	Checksum: 0x1C210ABD
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_mason", &__init__, undefined, #"character_unlock_mason_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_mason
	Checksum: 0xA10B630E
	Offset: 0x140
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "array_broadcast", 1, 1, "int");
	clientfield::register("toplayer", "array_effects", 1, 1, "int");
	character_unlock_fixup::function_90ee7a97(#"mason_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_mason
	Checksum: 0x976C483F
	Offset: 0x1E0
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"on_team_eliminated", &function_4ac25840);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			item_world_fixup::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d215d711186a8db", 1);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"hash_d215d711186a8db", 6);
		}
		dynent = getdynent(#"array_broadcast");
		if(isdefined(dynent))
		{
			dynent.onuse = &function_1e224132;
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_mason
	Checksum: 0x2676F52
	Offset: 0x360
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"cu19_item")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"mason_unlock"))
			{
				self character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334980069e5e2fa", 1);
			}
		}
	}
}

/*
	Name: function_1e224132
	Namespace: character_unlock_mason
	Checksum: 0x260B0C8
	Offset: 0x448
	Size: 0x15C
	Parameters: 3
	Flags: Linked
*/
function function_1e224132(activator, laststate, state)
{
	if(isplayer(activator) && !level.inprematchperiod)
	{
		characterassetname = getcharacterassetname(activator getcharacterbodytype(), currentsessionmode());
		if(activator character_unlock::function_f0406288(#"mason_unlock"))
		{
			level clientfield::set("array_broadcast", 1);
			activator clientfield::set_to_player("array_effects", 1);
			activator thread function_e3abcf2();
			activator character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334970069e5e147", 1);
		}
		activator stats::function_d40764f3(#"activation_count_broadcast", 1);
	}
}

/*
	Name: function_e3abcf2
	Namespace: character_unlock_mason
	Checksum: 0xB8B512B
	Offset: 0x5B0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_e3abcf2()
{
	self endon(#"disconnect", #"game_ended");
	var_70f6f8c = 1;
	while(isplayer(self) && isalive(self) && var_70f6f8c)
	{
		var_70f6f8c = self character_unlock::function_f0406288(#"mason_unlock");
		waitframe(1);
	}
	self clientfield::set_to_player("array_effects", 0);
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_mason
	Checksum: 0xACB09955
	Offset: 0x678
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
{
	if(isdefined(level.var_7733b33f) && level.var_7733b33f)
	{
		return;
	}
	var_c503939b = globallogic::function_e9e52d05();
	if(var_c503939b <= function_c816ea5b())
	{
		foreach(team in level.teams)
		{
			if(teams::function_9dd75dad(team) && !teams::is_all_dead(team))
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(player character_unlock::function_f0406288(#"mason_unlock"))
					{
						player character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334980069e5e2fa", 1);
					}
				}
			}
		}
		level.var_7733b33f = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_mason
	Checksum: 0xAC8F231E
	Offset: 0x868
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c816ea5b()
{
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	switch(maxteamplayers)
	{
		case 1:
		{
			return 15;
		}
		case 2:
		{
			return 8;
		}
		case 4:
		default:
		{
			return 4;
		}
		case 5:
		{
			return 4;
		}
	}
}

