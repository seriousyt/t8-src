// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using script_40114edfb27a2dd9;

#namespace hud;

/*
	Name: __init__system__
	Namespace: hud
	Checksum: 0x1C8456E
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hud", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hud
	Checksum: 0x2312E110
	Offset: 0xD8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	scavenger_icon::register("scavenger_pickup");
}

