// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weapons.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace stats;

/*
	Name: function_d92cb558
	Namespace: stats
	Checksum: 0x2860BB99
	Offset: 0x88
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function function_d92cb558(result, vararg)
{
	/#
		if(!isdefined(result))
		{
			pathstr = (ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0]);
			if(!isdefined(pathstr))
			{
				return;
			}
			for(i = 1; i < vararg.size; i++)
			{
				pathstr = (pathstr + "") + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
			}
			println("" + pathstr);
		}
	#/
}

/*
	Name: function_f94325d3
	Namespace: stats
	Checksum: 0x4D970CF8
	Offset: 0x1B8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_f94325d3()
{
	player = self;
	/#
		assert(isplayer(player), "");
	#/
	if(isbot(player) || (isdefined(level.disablestattracking) && level.disablestattracking))
	{
		return false;
	}
	if(sessionmodeiswarzonegame())
	{
		if(getdvarint(#"scr_disable_merits", 0) == 1)
		{
			return false;
		}
		if(!isdefined(game.state) || game.state == "pregame")
		{
			return false;
		}
		if(!isdedicated() && getdvarint(#"wz_stat_testing", 0) == 0)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_8921af36
	Namespace: stats
	Checksum: 0x72901F5A
	Offset: 0x308
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_8921af36()
{
	return level.var_12323003;
}

/*
	Name: get_stat
	Namespace: stats
	Checksum: 0xFE68475F
	Offset: 0x320
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Variadic
*/
function get_stat(...)
{
	/#
		assert(vararg.size > 0);
	#/
	if(vararg.size == 0)
	{
		return 0;
	}
	result = 0;
	if(isdefined(self))
	{
		/#
			assert(isplayer(self), "");
		#/
		result = self readstat(vararg);
		/#
			function_d92cb558(result, vararg);
		#/
	}
	return result;
}

/*
	Name: function_6d50f14b
	Namespace: stats
	Checksum: 0x822F6119
	Offset: 0x3E8
	Size: 0xC0
	Parameters: 1
	Flags: Variadic
*/
function function_6d50f14b(...)
{
	/#
		assert(vararg.size > 0);
	#/
	if(vararg.size == 0)
	{
		return 0;
	}
	result = 0;
	if(isdefined(self))
	{
		/#
			assert(isplayer(self), "");
		#/
		result = self function_c3462d90(vararg);
		/#
			function_d92cb558(result, vararg);
		#/
	}
	return result;
}

/*
	Name: function_ff8f4f17
	Namespace: stats
	Checksum: 0xE6BEAAB2
	Offset: 0x4B0
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Variadic
*/
function function_ff8f4f17(...)
{
	/#
		assert(vararg.size > 0);
	#/
	if(vararg.size == 0)
	{
		return 0;
	}
	result = 0;
	if(isdefined(self))
	{
		/#
			assert(isplayer(self), "");
		#/
		result = self function_24c32cb1(vararg);
		/#
			function_d92cb558(result, vararg);
		#/
	}
	return result;
}

/*
	Name: set_stat
	Namespace: stats
	Checksum: 0x33A78DA4
	Offset: 0x578
	Size: 0x12A
	Parameters: 1
	Flags: Linked, Variadic
*/
function set_stat(...)
{
	/#
		assert(vararg.size > 1);
	#/
	if(vararg.size <= 1)
	{
		return 0;
	}
	if(!function_f94325d3())
	{
		return 0;
	}
	result = 0;
	if(isdefined(self))
	{
		/#
			assert(isplayer(self), "");
		#/
		value = vararg[vararg.size - 1];
		arrayremoveindex(vararg, vararg.size - 1);
		result = self writestat(vararg, value);
		/#
			function_d92cb558(result, vararg);
		#/
	}
	return isdefined(result) && result;
}

/*
	Name: inc_stat
	Namespace: stats
	Checksum: 0xA4B264C2
	Offset: 0x6B0
	Size: 0x152
	Parameters: 1
	Flags: Linked, Variadic
*/
function inc_stat(...)
{
	/#
		assert(vararg.size > 1);
	#/
	if(vararg.size <= 1)
	{
		return;
	}
	if(!function_f94325d3())
	{
		return;
	}
	player = self;
	/#
		assert(isplayer(player), "");
	#/
	if(!isdefined(player) || !isplayer(player))
	{
		return;
	}
	value = vararg[vararg.size - 1];
	arrayremoveindex(vararg, vararg.size - 1);
	result = player incrementstat(vararg, value);
	/#
		function_d92cb558(result, vararg);
	#/
	return isdefined(result) && result;
}

/*
	Name: function_e6106f3b
	Namespace: stats
	Checksum: 0xAEC2FFA4
	Offset: 0x810
	Size: 0x104
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e6106f3b(statname, value)
{
	self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
	self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue", value);
	self set_stat(#"playerstatslist", statname, #"statvalue", value);
	self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

/*
	Name: function_1d354b96
	Namespace: stats
	Checksum: 0xBA2028EF
	Offset: 0x920
	Size: 0x70
	Parameters: 2
	Flags: Linked, Private
*/
function private function_1d354b96(statname, value)
{
	var_44becfa9 = self inc_stat(#"playerstatslist", statname, #"statvalue", value);
	self addgametypestat(statname, value);
	return var_44becfa9;
}

/*
	Name: function_ed81f25e
	Namespace: stats
	Checksum: 0xAF661531
	Offset: 0x998
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_ed81f25e(statname)
{
	return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"statvalue");
}

/*
	Name: function_baa25a23
	Namespace: stats
	Checksum: 0xFB3C752C
	Offset: 0x9F8
	Size: 0x7A
	Parameters: 2
	Flags: None
*/
function function_baa25a23(statname, value)
{
	if(!function_f94325d3())
	{
		return false;
	}
	if(sessionmodeiswarzonegame())
	{
		function_e6106f3b(statname, value);
	}
	else
	{
		self addgametypestat(statname, value);
		return true;
	}
}

/*
	Name: function_d40764f3
	Namespace: stats
	Checksum: 0xFDC7263A
	Offset: 0xA80
	Size: 0x78
	Parameters: 2
	Flags: Linked
*/
function function_d40764f3(statname, value)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	if(sessionmodeiswarzonegame())
	{
		return function_1d354b96(statname, value);
	}
	self addgametypestat(statname, value);
	return 1;
}

/*
	Name: function_7a850245
	Namespace: stats
	Checksum: 0xA6F3DDFB
	Offset: 0xB08
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function function_7a850245(statname, value)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	return self set_stat(#"afteractionreportstats", statname, value);
}

/*
	Name: function_62b271d8
	Namespace: stats
	Checksum: 0x9BBCA73C
	Offset: 0xB68
	Size: 0x1E6
	Parameters: 2
	Flags: Linked
*/
function function_62b271d8(statname, value)
{
	teammates = getplayers(self.team);
	foreach(player in teammates)
	{
		if(!player function_f94325d3())
		{
			continue;
		}
		teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");
		if(!isdefined(teammatecount))
		{
			return;
		}
		playerxuid = int(self getxuid(1));
		for(i = 0; i < teammatecount; i++)
		{
			var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");
			if(var_bd8d01a8 === playerxuid)
			{
				player set_stat(#"afteractionreportstats", #"teammates", i, statname, value);
				break;
			}
		}
	}
}

/*
	Name: function_b7f80d87
	Namespace: stats
	Checksum: 0xB7775FED
	Offset: 0xD58
	Size: 0x1E6
	Parameters: 2
	Flags: None
*/
function function_b7f80d87(statname, value)
{
	teammates = getplayers(self.team);
	foreach(player in teammates)
	{
		if(!player function_f94325d3())
		{
			continue;
		}
		teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");
		if(!isdefined(teammatecount))
		{
			return;
		}
		playerxuid = int(self getxuid(1));
		for(i = 0; i < teammatecount; i++)
		{
			var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");
			if(var_bd8d01a8 === playerxuid)
			{
				player inc_stat(#"afteractionreportstats", #"teammates", i, statname, value);
				break;
			}
		}
	}
}

/*
	Name: function_81f5c0fe
	Namespace: stats
	Checksum: 0x7C8AC546
	Offset: 0xF48
	Size: 0xEA
	Parameters: 2
	Flags: None
*/
function function_81f5c0fe(statname, value)
{
	if(!function_f94325d3() || sessionmodeiswarzonegame())
	{
		return 0;
	}
	gametype = level.var_12323003;
	map = util::get_map_name();
	mapstats = (isarenamode() ? #"mapstatsarena" : #"mapstats");
	return self inc_stat(mapstats, map, #"permode", gametype, statname, value);
}

/*
	Name: set_stat_global
	Namespace: stats
	Checksum: 0xA3431346
	Offset: 0x1040
	Size: 0xEA
	Parameters: 3
	Flags: Linked
*/
function set_stat_global(statname, value, var_b6d36336 = 0)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	if(sessionmodeiswarzonegame())
	{
		return function_e6106f3b(statname, value);
	}
	if(isarenamode() && !var_b6d36336)
	{
		return self set_stat(#"playerstatslist", statname, #"arenavalue", value);
	}
	return self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

/*
	Name: get_stat_global
	Namespace: stats
	Checksum: 0xCB48DD6B
	Offset: 0x1138
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function get_stat_global(statname, var_b6d36336 = 0)
{
	if(isarenamode() && !var_b6d36336)
	{
		return self get_stat(#"playerstatslist", statname, #"arenavalue");
	}
	return self get_stat(#"playerstatslist", statname, #"statvalue");
}

/*
	Name: set_stat_challenge
	Namespace: stats
	Checksum: 0x774C9E55
	Offset: 0x11E8
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function set_stat_challenge(statname, value)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	return self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

/*
	Name: get_stat_challenge
	Namespace: stats
	Checksum: 0x249D9D92
	Offset: 0x1250
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function get_stat_challenge(statname)
{
	return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

/*
	Name: function_af5584ca
	Namespace: stats
	Checksum: 0xC7F22ABC
	Offset: 0x1298
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_af5584ca(statname)
{
	return self get_stat(#"playerstatslist", statname, #"challengetier");
}

/*
	Name: function_8e071909
	Namespace: stats
	Checksum: 0x2B3E299A
	Offset: 0x12E0
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_8e071909(statname, value)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	return self set_stat(#"playerstatslist", statname, #"challengetier", value);
}

/*
	Name: function_878e75b7
	Namespace: stats
	Checksum: 0xD26FAE90
	Offset: 0x1348
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_878e75b7(statname)
{
	return self get_stat(#"playerstatsbygametype", util::get_gametype_name(), statname, #"challengevalue");
}

/*
	Name: function_dad108fa
	Namespace: stats
	Checksum: 0xC09322FB
	Offset: 0x13A8
	Size: 0xCA
	Parameters: 2
	Flags: Linked
*/
function function_dad108fa(statname, value)
{
	if(!function_f94325d3())
	{
		return 0;
	}
	if(sessionmodeiswarzonegame())
	{
		return function_1d354b96(statname, value);
	}
	if(isarenamode())
	{
		return self inc_stat(#"playerstatslist", statname, #"arenavalue", value);
	}
	return self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

/*
	Name: function_bb7eedf0
	Namespace: stats
	Checksum: 0x757D42F9
	Offset: 0x1480
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function function_bb7eedf0(statname, value)
{
	if(sessionmodeiswarzonegame())
	{
		return self function_1d354b96(statname, value);
	}
	setglobal = self function_dad108fa(statname, value);
	return self addgametypestat(statname, value);
}

/*
	Name: function_eec52333
	Namespace: stats
	Checksum: 0x6D2278FC
	Offset: 0x1510
	Size: 0x17A
	Parameters: 6
	Flags: Linked
*/
function function_eec52333(weapon, statname, value, classnum, pickedup, var_9ade9f55)
{
	if(sessionmodeiswarzonegame() && game.state == "pregame")
	{
		return;
	}
	if(sessionmodeiszombiesgame() && level.zm_disable_recording_stats === 1)
	{
		return;
	}
	if(isdefined(level.var_b10e134d))
	{
		[[level.var_b10e134d]](self, weapon, statname, value);
	}
	self addweaponstat(weapon, statname, value, classnum, pickedup, var_9ade9f55);
	switch(statname)
	{
		case "shots":
		case "used":
		{
			self function_f95ea9b6(weapon);
			break;
		}
		case "kills":
		{
			if(weapon.var_ff0b00ba)
			{
				self function_dad108fa(#"kills_equipment", 1);
			}
			break;
		}
	}
}

/*
	Name: function_e24eec31
	Namespace: stats
	Checksum: 0x23F47B90
	Offset: 0x1698
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function function_e24eec31(weapon, statname, value)
{
	self function_eec52333(weapon, statname, value, undefined, undefined, undefined);
}

