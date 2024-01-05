// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_stoker_interface.gsc;
#using scripts\core_common\spawner_shared.gsc;

#namespace archetype_stoker;

/*
	Name: init_shared
	Namespace: archetype_stoker
	Checksum: 0xF9E388A6
	Offset: 0x88
	Size: 0x80
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init_shared()
{
	if(isdefined(level.stokerinit))
	{
		return;
	}
	level.stokerinit = 1;
	function_3f70d4b7();
	spawner::add_archetype_spawn_function(#"stoker", &function_d30d1f3);
	stokerinterface::registerstokerinterfaceattributes();
	/#
	#/
}

/*
	Name: function_3f70d4b7
	Namespace: archetype_stoker
	Checksum: 0x80F724D1
	Offset: 0x110
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3f70d4b7()
{
}

/*
	Name: function_d30d1f3
	Namespace: archetype_stoker
	Checksum: 0xBD791711
	Offset: 0x120
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d30d1f3()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_236d6de;
}

/*
	Name: function_236d6de
	Namespace: archetype_stoker
	Checksum: 0xB519408B
	Offset: 0x178
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_236d6de(entity)
{
	entity.__blackboard = undefined;
	entity function_d30d1f3();
}

/*
	Name: function_e4ef4e27
	Namespace: archetype_stoker
	Checksum: 0x50640978
	Offset: 0x1B0
	Size: 0x58
	Parameters: 4
	Flags: Linked
*/
function function_e4ef4e27(entity, attribute, oldvalue, value)
{
	if(isdefined(entity.var_80cf70fb))
	{
		entity [[entity.var_80cf70fb]](entity, attribute, oldvalue, value);
	}
}

