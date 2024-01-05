// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_wallbuy.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_wall_to_wall_clearance;

/*
	Name: __init__system__
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0x4D2FD287
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_wall_to_wall_clearance", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0xDF5D1E69
	Offset: 0xE8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_wall_to_wall_clearance", "time", 30, &enable, &disable, &validation, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0xC2738FFE
	Offset: 0x178
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	zm_wallbuy::function_c047c228(&function_84832f40);
	zm_wallbuy::function_33023da5(&function_84832f40);
	zm_wallbuy::function_48f914bd(&override_ammo_cost);
}

/*
	Name: disable
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0xB73CAB53
	Offset: 0x1E8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	zm_wallbuy::function_a6889c(&function_84832f40);
	zm_wallbuy::function_782e8955(&function_84832f40);
	zm_wallbuy::function_99911dae(&override_ammo_cost);
}

/*
	Name: validation
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0x41034431
	Offset: 0x258
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(!zm_custom::function_901b751c(#"zmwallbuysenabled"))
	{
		return false;
	}
	return true;
}

/*
	Name: function_84832f40
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0x3F0F46FB
	Offset: 0x290
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function function_84832f40(w_wallbuy, var_2b6f3563)
{
	return 10;
}

/*
	Name: override_ammo_cost
	Namespace: zm_bgb_wall_to_wall_clearance
	Checksum: 0xCBF163D0
	Offset: 0x2B0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function override_ammo_cost(w_wallbuy, stub)
{
	if(self zm_weapons::has_upgrade(w_wallbuy))
	{
		return 500;
	}
	return 10;
}

