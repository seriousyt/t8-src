// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_983e5028;

/*
	Name: __init__system__
	Namespace: namespace_983e5028
	Checksum: 0x5EDBB3C1
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_1633972af838a447", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_983e5028
	Checksum: 0x7102B1AD
	Offset: 0xF0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_2fc73bc20035fe8", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_983e5028
	Checksum: 0x861EF37D
	Offset: 0x158
	Size: 0xC8
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_d34d02af)
{
	level.var_d34d02af = zm_trial::function_5769f26a(var_d34d02af);
	callback::on_weapon_fired(&on_weapon_fired);
	foreach(player in getplayers())
	{
		player thread function_a5a431f6();
	}
}

/*
	Name: on_end
	Namespace: namespace_983e5028
	Checksum: 0xC72452A0
	Offset: 0x228
	Size: 0x36
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	callback::remove_on_weapon_fired(&on_weapon_fired);
	level.var_d34d02af = undefined;
}

/*
	Name: on_weapon_fired
	Namespace: namespace_983e5028
	Checksum: 0xBF560CD0
	Offset: 0x268
	Size: 0x7C
	Parameters: 1
	Flags: Private
*/
function private on_weapon_fired(params)
{
	if(zm_weapons::is_explosive_weapon(params.weapon))
	{
		self zm_score::player_reduce_points("take_specified", level.var_d34d02af * 2);
	}
	else
	{
		self zm_score::player_reduce_points("take_specified", level.var_d34d02af);
	}
}

/*
	Name: function_a5a431f6
	Namespace: namespace_983e5028
	Checksum: 0x15CCBA79
	Offset: 0x2F0
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private function_a5a431f6()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = self waittill(#"ammo_reduction", #"lightning_ball_created");
		self zm_score::player_reduce_points("take_specified", level.var_d34d02af);
	}
}

