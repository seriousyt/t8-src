// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\gametypes\ztcm.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace ztcm_escape;

/*
	Name: main
	Namespace: ztcm_escape
	Checksum: 0xCC240BC7
	Offset: 0xA0
	Size: 0xB4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ztcm::main(eventstruct);
	level.var_7a973c0e = createuimodel(getglobaluimodel(), "ZMHudGlobal.tcm");
	setuimodelvalue(createuimodel(level.var_7a973c0e, "active"), 0);
	callback::on_localplayer_spawned(&function_13bfe0d8);
}

/*
	Name: function_13bfe0d8
	Namespace: ztcm_escape
	Checksum: 0xAC5942B9
	Offset: 0x160
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_13bfe0d8(localclientnum)
{
	setuimodelvalue(createuimodel(level.var_7a973c0e, "active"), 3);
}

