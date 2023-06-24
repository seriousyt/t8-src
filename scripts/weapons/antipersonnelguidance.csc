// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace antipersonnel_guidance;

/*
	Name: __init__system__
	Namespace: antipersonnel_guidance
	Checksum: 0xD14166A3
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"antipersonnel_guidance", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: antipersonnel_guidance
	Checksum: 0xAA05B95C
	Offset: 0xF8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level thread player_init();
	duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

/*
	Name: player_init
	Namespace: antipersonnel_guidance
	Checksum: 0xFD223B51
	Offset: 0x150
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function player_init()
{
	util::waitforclient(0);
	players = getlocalplayers();
	foreach(player in players)
	{
		player thread watch_lockon(0);
	}
}

/*
	Name: watch_lockon
	Namespace: antipersonnel_guidance
	Checksum: 0x62EA086A
	Offset: 0x208
	Size: 0x19E
	Parameters: 1
	Flags: None
*/
function watch_lockon(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"lockon_changed");
		target = waitresult.target;
		state = waitresult.state;
		if(isdefined(self.replay_lock) && (!isdefined(target) || self.replay_lock != target))
		{
			self.ap_lock duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
			self.ap_lock = undefined;
		}
		switch(state)
		{
			case 0:
			case 1:
			case 3:
			{
				target duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
				break;
			}
			case 2:
			case 4:
			{
				target duplicate_render::change_dr_flags(localclientnum, "ap_locked", undefined);
				self.ap_lock = target;
				break;
			}
		}
	}
}

