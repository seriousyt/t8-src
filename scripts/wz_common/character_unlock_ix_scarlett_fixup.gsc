// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_ix_scarlett_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_scarlett_fixup
	Checksum: 0x166E5636
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_scarlett_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_scarlett_fixup
	Checksum: 0x75091B7B
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"ix_scarlett_unlock", #"hash_63c7568898cd4fec", #"hash_279757876549356c", &function_d95e620c, #"hash_74fceff1a255277d");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ix_scarlett_fixup
	Checksum: 0xAD241814
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_d0df1180 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2b0f9caa00363ee8")) ? getgametypesetting(#"hash_2b0f9caa00363ee8") : 0);
	return var_d0df1180;
}

