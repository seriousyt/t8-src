// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59a783d756554a80;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_item_pickup.gsc;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace namespace_87e11242;

/*
	Name: __init__system__
	Namespace: namespace_87e11242
	Checksum: 0x19609B03
	Offset: 0x220
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_3ee2bcf1f7dc56c8", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_87e11242
	Checksum: 0xBF14505B
	Offset: 0x268
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	init_flags();
	init_quest();
}

/*
	Name: init_clientfields
	Namespace: namespace_87e11242
	Checksum: 0xF28B6BF0
	Offset: 0x2A8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "" + #"hash_31a98ee76e835504", 1, 1, "int");
	clientfield::register("world", "" + #"hash_3284b0cf34bfe44e", 1, 1, "int");
	clientfield::register("world", "" + #"hash_b143d97bf92fc66", 1, 1, "counter");
	clientfield::register("world", "" + #"hash_28f972533bb468fd", 1, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_87e11242
	Checksum: 0x67453635
	Offset: 0x3B8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_4c30d0428f1d4060");
	level flag::init(#"hash_5516784173c2ee27");
	level flag::init(#"server_fixed");
	level flag::init(#"card_inserted");
	level flag::init(#"hash_5df188993c013698");
}

/*
	Name: init_quest
	Namespace: namespace_87e11242
	Checksum: 0x9F8E0249
	Offset: 0x468
	Size: 0x69C
	Parameters: 0
	Flags: Linked
*/
function init_quest()
{
	level.s_fix_server = struct::get("fix_server", "targetname");
	level.s_fix_server_spark_fx = struct::get("fix_server_spark_fx", "targetname");
	level.s_punch_card_insert = struct::get("punch_card_insert", "targetname");
	level.var_af224340 = getent("punch_card_screen", "targetname");
	level.var_af224340 hide();
	level.var_9c0c4b0d = struct::get_array("aat_dmg_fx", "targetname");
	array::sort_by_script_int(level.var_9c0c4b0d, 1);
	level.var_67599dfe = [];
	for(i = 0; i < level.var_9c0c4b0d.size; i++)
	{
		level.var_67599dfe[i] = 0;
	}
	var_b3edfb92 = getent("server_part_placement", "targetname");
	var_b3edfb92 hide();
	var_240bceab = array(#"hash_1a4bbbe1a3b57e4f");
	var_e4158c30 = array(#"hash_7544aa4a3281de20");
	var_19bb8831 = array(#"hash_cfe3836bc9ca39", #"hash_4b18b104deb5d028");
	var_17b5a12 = array(#"hash_ebea45d703b1ed2", #"hash_2c58be4a6b26629b", #"hash_3db46912689769f0", #"hash_1152f3ac3dddade1");
	var_b37ebf6 = array(#"hash_4768d4b244860f63");
	var_4e4ef50e = array(#"hash_217e6ae56b61ad3b");
	var_2c28b1bb = array(#"hash_2747b199d121f40b");
	level.var_5a599dbf = [];
	level.var_5a599dbf[0] = {#vo_line:var_240bceab, #in_inventory:0};
	level.var_5a599dbf[1] = {#vo_line:var_e4158c30, #in_inventory:0};
	level.var_5a599dbf[2] = {#vo_line:var_19bb8831, #in_inventory:0};
	level.var_5a599dbf[3] = {#vo_line:var_17b5a12, #in_inventory:0};
	level.var_5a599dbf[4] = {#vo_line:var_b37ebf6, #in_inventory:0};
	level.var_5a599dbf[5] = {#vo_line:var_4e4ef50e, #in_inventory:0};
	level.var_5a599dbf[6] = {#vo_line:var_2c28b1bb, #in_inventory:0};
	level.var_a035a0b9 = zm_hms_util::function_bffcedde("office_punch_card", "targetname", "script_int");
	level.var_3d015a65 = 0;
	foreach(var_453ce50f in level.var_a035a0b9)
	{
		var_453ce50f zm_item_pickup::function_e8661563(&function_e8d6a81b, 1);
	}
	var_453ce50f = getent("punch_card_anim", "targetname");
	/#
		assert(isdefined(var_453ce50f), "");
	#/
	var_453ce50f hide();
	zm_sq::register(#"pernell_archive", #"step_1", #"pernell_archive_step1", &pernell_archive_step1_setup, &pernell_archive_step1_cleanup);
	zm_sq::register(#"pernell_archive", #"step_2", #"pernell_archive_step2", &pernell_archive_step2_setup, &pernell_archive_step2_cleanup);
	zm_sq::start(#"pernell_archive");
	level thread function_afb5905e();
}

/*
	Name: function_afb5905e
	Namespace: namespace_87e11242
	Checksum: 0xA76DF726
	Offset: 0xB10
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_afb5905e()
{
	level waittill(#"all_players_spawned");
	level clientfield::set("" + #"hash_3284b0cf34bfe44e", 1);
	level clientfield::set("" + #"hash_31a98ee76e835504", 1);
}

/*
	Name: pernell_archive_step1_setup
	Namespace: namespace_87e11242
	Checksum: 0x48CDFE02
	Offset: 0xBA8
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function pernell_archive_step1_setup(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_2cbf5e38 = 0;
		s_server_part_pickup = struct::get("server_part_pickup");
		s_server_part_pickup zm_unitrigger::create(#"", 64, &function_8703c1fe);
		level flag::wait_till(#"hash_4c30d0428f1d4060");
		var_185199a1 = getent(s_server_part_pickup.target, "targetname");
		var_185199a1 playsound(#"hash_18f957b8000dd0c6");
		var_185199a1 delete();
		zm_unitrigger::unregister_unitrigger(s_server_part_pickup.s_unitrigger);
		s_server_part_pickup struct::delete();
		level.s_fix_server zm_unitrigger::create(#"", 64, &function_e4fcfb0a);
		level flag::wait_till(#"hash_5516784173c2ee27");
		playsoundatposition(#"hash_359664e44a2bb635", level.s_fix_server.origin);
		level clientfield::set("" + #"hash_3284b0cf34bfe44e", 0);
		level clientfield::increment("" + #"hash_b143d97bf92fc66", 1);
		level.var_67599dfe[0] = 1;
		zm_unitrigger::unregister_unitrigger(level.s_fix_server.s_unitrigger);
		var_ae88db53 = getent("server_damage_trigger", "targetname");
		var_ae88db53 function_a546fd97();
		level flag::wait_till(#"server_fixed");
	}
}

/*
	Name: pernell_archive_step1_cleanup
	Namespace: namespace_87e11242
	Checksum: 0x12361BF5
	Offset: 0xE68
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function pernell_archive_step1_cleanup(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"server_fixed");
	}
	s_server_part_pickup = struct::get("server_part_pickup");
	if(isdefined(s_server_part_pickup))
	{
		s_server_part_pickup struct::delete();
	}
	zm_unitrigger::unregister_unitrigger(level.s_fix_server.s_unitrigger);
}

/*
	Name: function_8703c1fe
	Namespace: namespace_87e11242
	Checksum: 0x21D02369
	Offset: 0xF18
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_8703c1fe()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	level.var_2cbf5e38 = 1;
	level flag::set(#"hash_4c30d0428f1d4060");
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_e4fcfb0a
	Namespace: namespace_87e11242
	Checksum: 0x9AB0DB26
	Offset: 0xFA0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_e4fcfb0a()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	level flag::set(#"hash_5516784173c2ee27");
}

/*
	Name: function_a546fd97
	Namespace: namespace_87e11242
	Checksum: 0xF5A0FF78
	Offset: 0xFF8
	Size: 0x2B0
	Parameters: 0
	Flags: Linked
*/
function function_a546fd97()
{
	self endon(#"death");
	var_863c08bb = 0;
	var_c327a579 = 0;
	while(!var_c327a579)
	{
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		add_outtime = s_notify.attacker aat::getaatonweapon(s_notify.weapon);
		if(isdefined(add_outtime) && add_outtime.name === "zm_aat_kill_o_watt")
		{
			var_863c08bb = var_863c08bb + s_notify.amount;
			var_9ce2f88b = var_863c08bb / 15000;
			var_5c3100f7 = int(min(floor(var_9ce2f88b * level.var_9c0c4b0d.size), level.var_9c0c4b0d.size));
			for(i = 0; i < var_5c3100f7; i++)
			{
				if(!level.var_67599dfe[i])
				{
					level.var_67599dfe[i] = 1;
					level clientfield::increment("" + #"hash_b143d97bf92fc66", 1);
					waitframe(1);
				}
			}
			if(var_863c08bb >= 15000)
			{
				var_c327a579 = 1;
				level flag::set(#"server_fixed");
				level clientfield::set("" + #"hash_28f972533bb468fd", 1);
				/#
					iprintlnbold("");
				#/
				self playsound(#"hash_4f1f1f9762add0a3");
				s_notify.attacker thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
			}
		}
	}
}

/*
	Name: pernell_archive_step2_setup
	Namespace: namespace_87e11242
	Checksum: 0x379FD1E3
	Offset: 0x12B0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function pernell_archive_step2_setup(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		function_24510350();
	}
}

/*
	Name: pernell_archive_step2_cleanup
	Namespace: namespace_87e11242
	Checksum: 0x8377A2BA
	Offset: 0x12E0
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function pernell_archive_step2_cleanup(var_5ea5c94d, ended_early)
{
}

/*
	Name: function_e8d6a81b
	Namespace: namespace_87e11242
	Checksum: 0x2136B92D
	Offset: 0x1310
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_e8d6a81b(e_item)
{
	s_punch_card = level.var_5a599dbf[level.var_3d015a65];
	s_punch_card.in_inventory = 1;
	self thread zm_vo::function_a2bd5a0c(#"hash_7e030fccc2c5a121");
	if(isdefined(e_item))
	{
		e_item playsound(#"hash_18f957b8000dd0c6");
	}
	function_2f5993d6();
	level.var_3d015a65++;
}

/*
	Name: function_2f5993d6
	Namespace: namespace_87e11242
	Checksum: 0x6EA27C2
	Offset: 0x13B8
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_2f5993d6()
{
	level.var_fcbb6a6b = undefined;
	for(i = 0; i < level.var_5a599dbf.size; i++)
	{
		if(level.var_5a599dbf[i].in_inventory)
		{
			level.var_fcbb6a6b = level.var_5a599dbf[i];
			break;
		}
	}
}

/*
	Name: function_814ee815
	Namespace: namespace_87e11242
	Checksum: 0x74DA786F
	Offset: 0x1430
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_814ee815(player)
{
	if(self.stub.in_use === 1)
	{
		return false;
	}
	if(!isdefined(level.var_fcbb6a6b))
	{
		return false;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_28806e76718dea47");
	}
	else
	{
		self sethintstring(#"hash_4a380545b9102af9");
	}
	return true;
}

/*
	Name: function_445e3d3d
	Namespace: namespace_87e11242
	Checksum: 0x9A0522C9
	Offset: 0x14D0
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_445e3d3d()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self.stub notify(#"play_audio");
	}
}

/*
	Name: function_54db89ef
	Namespace: namespace_87e11242
	Checksum: 0x95ECC8BC
	Offset: 0x1528
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_54db89ef()
{
	self endon(#"death");
	var_ab007509 = 0;
	while(true)
	{
		self waittill(#"play_audio");
		if(isdefined(level.var_fcbb6a6b))
		{
			s_card = level.var_fcbb6a6b;
			self.in_use = 1;
			s_card.in_inventory = 0;
			function_2f5993d6();
			level thread function_9f206255();
			level flag::wait_till("card_inserted");
			zm_hms_util::function_52c3fe8d(s_card.vo_line, level.s_punch_card_insert.origin);
			if(s_card.vo_line[0] == #"hash_217e6ae56b61ad3b")
			{
				level flag::set(#"hash_5df188993c013698");
			}
			var_ab007509++;
			if(var_ab007509 < 7)
			{
				self.in_use = 0;
			}
			else
			{
				break;
			}
		}
	}
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_24510350
	Namespace: namespace_87e11242
	Checksum: 0xAAA850F2
	Offset: 0x16B8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_24510350()
{
	level.var_af224340 show();
	level clientfield::set("" + #"hash_31a98ee76e835504", 0);
	s_unitrigger = level.s_punch_card_insert zm_unitrigger::create(&function_814ee815, 64, &function_445e3d3d);
	s_unitrigger thread function_54db89ef();
}

/*
	Name: function_9f206255
	Namespace: namespace_87e11242
	Checksum: 0x63E8FBEC
	Offset: 0x1768
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function function_9f206255()
{
	var_453ce50f = getent("punch_card_anim", "targetname");
	/#
		assert(isdefined(var_453ce50f), "");
	#/
	var_453ce50f show();
	v_starting_origin = var_453ce50f.origin;
	var_5287d229 = var_453ce50f.angles;
	v_forward = anglestoforward(var_453ce50f.angles);
	wait(0.5);
	var_453ce50f playsound("evt_ee_punchcard_insert");
	var_453ce50f moveto(var_453ce50f.origin + (v_forward * -14), 3);
	wait(1);
	level flag::set(#"card_inserted");
	var_453ce50f waittill(#"movedone");
	var_453ce50f hide();
	var_453ce50f.origin = v_starting_origin;
	var_453ce50f.angles = var_5287d229;
	level flag::clear(#"card_inserted");
}

/*
	Name: function_fe05ebd7
	Namespace: namespace_87e11242
	Checksum: 0xCB906010
	Offset: 0x1920
	Size: 0x120
	Parameters: 0
	Flags: None
*/
function function_fe05ebd7()
{
	a_e_items = getitemarray();
	foreach(e_item in a_e_items)
	{
		foreach(s_punch_card in level.var_5a599dbf)
		{
			if(e_item.item.name == s_punch_card.name)
			{
				e_item delete();
				break;
			}
		}
	}
}

