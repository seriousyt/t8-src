// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cmp_revive_prompt : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cmp_revive_prompt
		Checksum: 0xF5FE5705
		Offset: 0x258
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cmp_revive_prompt
		Checksum: 0xA1D0CDD3
		Offset: 0x478
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_reviveprogress
		Namespace: cmp_revive_prompt
		Checksum: 0x578D9F07
		Offset: 0x430
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_reviveprogress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: cmp_revive_prompt
		Checksum: 0x395535FF
		Offset: 0x3E8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_health(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "health", value);
	}

	/*
		Name: set_clientnum
		Namespace: cmp_revive_prompt
		Checksum: 0xD95B448D
		Offset: 0x3A0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_clientnum(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientnum", value);
	}

	/*
		Name: close
		Namespace: cmp_revive_prompt
		Checksum: 0x5CE0A74B
		Offset: 0x370
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cmp_revive_prompt
		Checksum: 0x368CC272
		Offset: 0x320
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "mp_revive_prompt", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cmp_revive_prompt
		Checksum: 0xD2DF4B9F
		Offset: 0x278
		Size: 0x9C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("clientnum", 1, 7, "int", 0);
		cluielem::add_clientfield("health", 1, 5, "float", 0);
		cluielem::add_clientfield("reviveProgress", 1, 5, "float", 0);
	}

}

#namespace mp_revive_prompt;

/*
	Name: register
	Namespace: mp_revive_prompt
	Checksum: 0x30DC56AC
	Offset: 0xF0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cmp_revive_prompt();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_revive_prompt
	Checksum: 0x26876B00
	Offset: 0x138
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: mp_revive_prompt
	Checksum: 0xE4FD9A76
	Offset: 0x178
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: mp_revive_prompt
	Checksum: 0x9EE86B32
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_clientnum
	Namespace: mp_revive_prompt
	Checksum: 0x505D0E79
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_clientnum(player, value)
{
	[[ self ]]->set_clientnum(player, value);
}

/*
	Name: set_health
	Namespace: mp_revive_prompt
	Checksum: 0xF625634F
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(player, value)
{
	[[ self ]]->set_health(player, value);
}

/*
	Name: set_reviveprogress
	Namespace: mp_revive_prompt
	Checksum: 0xEB3352B2
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_reviveprogress(player, value)
{
	[[ self ]]->set_reviveprogress(player, value);
}

