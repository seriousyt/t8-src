// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_perk_mod_electric_cherry;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_electric_cherry
	Checksum: 0x4D999E2C
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_electric_cherry", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_electric_cherry
	Checksum: 0x3C6DD8FF
	Offset: 0xC0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_electriccherry", &function_a58eb885, &function_aa41af78);
	zm_perks::register_perk_init_thread(#"specialty_mod_electriccherry", &function_5aa2ffe6);
}

/*
	Name: function_5aa2ffe6
	Namespace: zm_perk_mod_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x140
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_5aa2ffe6()
{
}

/*
	Name: function_a58eb885
	Namespace: zm_perk_mod_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x150
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_a58eb885()
{
}

/*
	Name: function_aa41af78
	Namespace: zm_perk_mod_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_aa41af78()
{
}

