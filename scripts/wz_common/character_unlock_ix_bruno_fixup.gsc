// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_ix_bruno_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0x45EEF792
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_bruno_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0x388594C6
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"ix_bruno_unlock", #"hash_677a722d85cbd06", #"cu28_item", &function_d95e620c, #"hash_1493c49bbdfb17ad");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0x36458ADE
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_bda4e460 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4547b7ecb49469f0")) ? getgametypesetting(#"hash_4547b7ecb49469f0") : 0);
	return var_bda4e460;
}

