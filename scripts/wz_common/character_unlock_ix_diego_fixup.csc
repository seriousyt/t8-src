// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_ix_diego_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_diego_fixup
	Checksum: 0xD2F8F29B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_diego_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_diego_fixup
	Checksum: 0xCAE09206
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"ix_diego_unlock", #"hash_75365263415c16f2", #"cu29_item", &function_d95e620c, #"hash_374df23cda9c79ed");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ix_diego_fixup
	Checksum: 0x22D6A816
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_fb6c1efd = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_ff653cbb1438270")) ? getgametypesetting(#"hash_ff653cbb1438270") : 0);
	return var_fb6c1efd;
}

