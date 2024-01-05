// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_restrict_loadout.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using script_35598499769dbb3d;
#using scripts\core_common\throttle_shared.gsc;

#namespace zm_weap_chakram;

/*
	Name: __init__system__
	Namespace: zm_weap_chakram
	Checksum: 0x8499769D
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_chakram", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_chakram
	Checksum: 0xE7A5018B
	Offset: 0x2D0
	Size: 0xB3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"zombie_slice_right", 1, 2, "counter");
	clientfield::register("actor", "" + #"zombie_slice_left", 1, 2, "counter");
	clientfield::register("allplayers", "" + #"hash_aefa3d014b0fa1b", 1, 1, "counter");
	clientfield::register("actor", "" + #"hash_1e22d429435cc148", 1, 1, "int");
	clientfield::register("vehicle", "" + #"hash_1e22d429435cc148", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2a55372ad04eb0e5", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_302e96545259ba6b", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_56421723ef2ac2fb", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_9d9fb6cf3d5d3a6", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_3c3af9a781191429", 1, 1, "counter");
	clientfield::register("vehicle", "" + #"hash_3c3af9a781191429", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_7287b37a40c4ae6f", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"chakram_rumble", 1, 3, "counter");
	level.hero_weapon[#"chakram"][0] = getweapon(#"hero_chakram_lv1");
	level.hero_weapon[#"chakram"][1] = getweapon(#"hero_chakram_lv2");
	level.hero_weapon[#"chakram"][2] = getweapon(#"hero_chakram_lv3");
	if(!isdefined(level.var_30d2c56e))
	{
		level.var_30d2c56e = [];
	}
	level.var_30d2c56e[#"chakram"] = [];
	level.var_30d2c56e[#"chakram"][#"delay_start"][0] = 0.25;
	level.var_30d2c56e[#"chakram"][#"delay_start"][1] = 0.15;
	level.var_30d2c56e[#"chakram"][#"delay_start"][2] = 0.1;
	level.var_30d2c56e[#"chakram"][#"delay_end"][0] = 0.4;
	level.var_30d2c56e[#"chakram"][#"delay_end"][1] = 0.25;
	level.var_30d2c56e[#"chakram"][#"delay_end"][2] = 0.12;
	level.var_30d2c56e[#"chakram"][#"kill_limit"][0] = 4;
	level.var_30d2c56e[#"chakram"][#"kill_limit"][1] = 4;
	level.var_30d2c56e[#"chakram"][#"kill_limit"][2] = 4;
	level.var_30d2c56e[#"chakram"][#"max_range"][0] = 512;
	level.var_30d2c56e[#"chakram"][#"max_range"][1] = 756;
	level.var_30d2c56e[#"chakram"][#"max_range"][2] = 1024;
	level.var_30d2c56e[#"chakram"][#"seek_range"][0] = 256;
	level.var_30d2c56e[#"chakram"][#"seek_range"][1] = 384;
	level.var_30d2c56e[#"chakram"][#"seek_range"][2] = 512;
	level.var_30d2c56e[#"chakram"][#"travel_time"][0] = 0.4;
	level.var_30d2c56e[#"chakram"][#"travel_time"][1] = 0.5;
	level.var_30d2c56e[#"chakram"][#"travel_time"][2] = 0.7;
	level.var_30d2c56e[#"chakram"][#"throw_model"][0] = "wpn_t8_zm_melee_chakram_lvl1_dw_projectile";
	level.var_30d2c56e[#"chakram"][#"throw_model"][1] = "wpn_t8_zm_melee_chakram_lvl2_dw_projectile";
	level.var_30d2c56e[#"chakram"][#"throw_model"][2] = "wpn_t8_zm_melee_chakram_lvl3_dw_projectile";
	zm_loadout::register_hero_weapon_for_level("hero_chakram_lv1");
	zm_loadout::register_hero_weapon_for_level("hero_chakram_lv2");
	zm_loadout::register_hero_weapon_for_level("hero_chakram_lv3");
	level.var_5d31a5ef = [];
	if(!isdefined(level.var_5d31a5ef))
	{
		level.var_5d31a5ef = [];
	}
	else if(!isarray(level.var_5d31a5ef))
	{
		level.var_5d31a5ef = array(level.var_5d31a5ef);
	}
	level.var_5d31a5ef[level.var_5d31a5ef.size] = "minigun";
	if(!isdefined(level.var_893eb73f))
	{
		level.var_893eb73f = new throttle();
		[[ level.var_893eb73f ]]->initialize(3, 0.1);
	}
	callback::on_connect(&function_1d807685);
	callback::on_disconnect(&on_player_disconnect);
	callback::add_weapon_fired(level.hero_weapon[#"chakram"][0].dualwieldweapon, &function_cec4ebbd);
	callback::add_weapon_fired(level.hero_weapon[#"chakram"][1].dualwieldweapon, &function_cec4ebbd);
	callback::add_weapon_fired(level.hero_weapon[#"chakram"][2].dualwieldweapon, &function_cec4ebbd);
}

/*
	Name: function_1d807685
	Namespace: zm_weap_chakram
	Checksum: 0x38F5F376
	Offset: 0xE18
	Size: 0x3E0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1d807685()
{
	self endon(#"disconnect");
	/#
		var_16409102 = 0;
		var_d0ba279f = 0;
		var_cd7ab272 = 0;
	#/
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(isinarray(level.hero_weapon[#"chakram"], wpn_cur))
		{
			self notify(#"hero_chakram_activated");
			self thread function_c965a5a9(wpn_cur);
			self thread queue_setrotors(wpn_cur);
		}
		else if(isinarray(level.hero_weapon[#"chakram"], wpn_prev))
		{
			self thread function_7bef3ea0(wpn_prev);
		}
		if(wpn_cur == level.hero_weapon[#"chakram"][0])
		{
			self thread chakram_rumble(1);
			if(!self gamepadusedlast())
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_327e81e6ede21cd5");
			}
			else
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_52e079a39f348e1b");
			}
		}
		else
		{
			if(wpn_cur == level.hero_weapon[#"chakram"][1])
			{
				self thread chakram_rumble(1);
				if(!self gamepadusedlast())
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_327e81e6ede21cd5");
				}
				else
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_52e079a39f348e1b");
				}
				self thread function_d5e67082(wpn_cur);
			}
			else if(wpn_cur == level.hero_weapon[#"chakram"][2])
			{
				self thread chakram_rumble(1);
				if(!self gamepadusedlast())
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_3c4637f13f09707");
				}
				else
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_34a417201bd40701");
				}
				self thread function_d5e67082(wpn_cur);
				self thread function_b475223e(wpn_cur);
				self thread function_f9b883ea();
				self thread function_68ff89f7(wpn_cur);
			}
		}
	}
}

/*
	Name: function_7bef3ea0
	Namespace: zm_weap_chakram
	Checksum: 0x5E3CD2BA
	Offset: 0x1200
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7bef3ea0(w_hero)
{
	self endon(#"death");
	s_result = undefined;
	s_result = self waittilltimeout(5, #"seeker_done", #"hero_chakram_activated");
	if(s_result._notify !== #"seeker_done")
	{
		self notify(#"seeker_done");
	}
	if(isdefined(self.e_seeker))
	{
		self.e_seeker clientfield::set("" + #"hash_2a55372ad04eb0e5", 0);
		self.e_seeker delete();
	}
}

/*
	Name: function_c965a5a9
	Namespace: zm_weap_chakram
	Checksum: 0x8065D920
	Offset: 0x12F8
	Size: 0xE8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c965a5a9(weapon)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	while(true)
	{
		if(weapon == level.hero_weapon[#"chakram"][2])
		{
			self waittill(#"weapon_melee_power");
		}
		else
		{
			self waittill(#"weapon_melee_power", #"weapon_melee");
		}
		if(!zm_trial_restrict_loadout::function_5fbf572(weapon, 1))
		{
			continue;
		}
		weapon thread function_eac789ca(self);
	}
}

/*
	Name: blood_death_fx
	Namespace: zm_weap_chakram
	Checksum: 0xD4A7AA49
	Offset: 0x13E8
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
function private blood_death_fx(var_14ef0a6c)
{
	if(self.archetype === #"zombie")
	{
		if(var_14ef0a6c)
		{
			self clientfield::increment("" + #"zombie_slice_left", 1);
		}
		else
		{
			self clientfield::increment("" + #"zombie_slice_right", 1);
		}
	}
}

/*
	Name: function_fe3f086c
	Namespace: zm_weap_chakram
	Checksum: 0x7DA73623
	Offset: 0x1480
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function function_fe3f086c(e_target, leftswing, weapon = level.weaponnone)
{
	if(isactor(e_target))
	{
		self thread chop_actor(e_target, leftswing, weapon);
	}
	else
	{
		self thread function_5e2c9b64(e_target, weapon);
	}
}

/*
	Name: chop_actor
	Namespace: zm_weap_chakram
	Checksum: 0x13399541
	Offset: 0x1510
	Size: 0x244
	Parameters: 3
	Flags: Linked
*/
function chop_actor(e_target, leftswing, weapon = level.weaponnone)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	e_target endon(#"death");
	if(!isdefined(e_target.var_6f84b820))
	{
		return;
	}
	switch(e_target.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		case "enhanced":
		{
			n_damage = e_target.health;
			break;
		}
		case "heavy":
		{
			n_damage = int(e_target.maxhealth * 0.2);
			break;
		}
		case "miniboss":
		{
			n_damage = int(e_target.maxhealth * 0.1);
			break;
		}
		case "boss":
		{
			n_damage = 2500;
		}
	}
	if(n_damage >= e_target.health)
	{
		e_target.ignoremelee = 1;
	}
	self thread function_a5ed760f();
	[[ level.var_893eb73f ]]->waitinqueue(e_target);
	e_target thread zm_hero_weapon::function_acee2761();
	e_target blood_death_fx(leftswing);
	e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
}

/*
	Name: function_5e2c9b64
	Namespace: zm_weap_chakram
	Checksum: 0xB1D30EF1
	Offset: 0x1760
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_5e2c9b64(e_target, weapon)
{
	e_target endon(#"death");
	self endon(#"weapon_change", #"disconnect");
	[[ level.var_893eb73f ]]->waitinqueue(e_target);
	self thread function_a5ed760f();
	e_target dodamage(2500, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
}

/*
	Name: function_a5ed760f
	Namespace: zm_weap_chakram
	Checksum: 0x1D4D4371
	Offset: 0x1820
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_a5ed760f()
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	wait(0.1);
	self clientfield::increment("" + #"hash_aefa3d014b0fa1b", 1);
}

/*
	Name: chop_zombies
	Namespace: zm_weap_chakram
	Checksum: 0xC7D34302
	Offset: 0x1898
	Size: 0x308
	Parameters: 3
	Flags: Linked
*/
function chop_zombies(first_time = 1, leftswing, weapon = level.weaponnone)
{
	view_pos = self getweaponmuzzlepoint();
	forward_view_angles = self getweaponforwarddir();
	var_b9e95436 = zm_hero_weapon::function_7c3681f7();
	a_e_targets = array::get_all_closest(view_pos, var_b9e95436, undefined, undefined, 160);
	foreach(e_target in a_e_targets)
	{
		if(!isalive(e_target))
		{
			continue;
		}
		if(first_time)
		{
			e_target.chopped = 0;
			first_time = 0;
		}
		else if(isdefined(e_target.chopped) && e_target.chopped)
		{
			continue;
		}
		test_origin = e_target getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(dot <= 0)
		{
			continue;
		}
		if(dist_sq <= 1600)
		{
			if(0 == e_target damageconetrace(view_pos, self, forward_view_angles))
			{
				continue;
			}
		}
		else if(0 == e_target damageconetrace(view_pos, self, forward_view_angles, 25))
		{
			continue;
		}
		e_target.chopped = 1;
		if(isdefined(e_target.chop_actor_cb))
		{
			self thread [[e_target.chop_actor_cb]](e_target, self, weapon);
			continue;
		}
		self thread chakram_rumble(3);
		self thread function_fe3f086c(e_target, leftswing, weapon);
	}
}

/*
	Name: function_eac789ca
	Namespace: zm_weap_chakram
	Checksum: 0x7F04BEF4
	Offset: 0x1BA8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_eac789ca(player)
{
	player thread chakram_rumble(4);
	player thread chop_zombies(1, 1, self);
}

/*
	Name: function_cec4ebbd
	Namespace: zm_weap_chakram
	Checksum: 0xD627AA90
	Offset: 0x1BF8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_cec4ebbd(weapon)
{
	player = self;
	if(!zm_trial_restrict_loadout::function_5fbf572(weapon))
	{
		return;
	}
	player thread chakram_rumble(5);
	weapon function_dc7f8e67(player);
}

/*
	Name: queue_setrotors
	Namespace: zm_weap_chakram
	Checksum: 0x26713D2B
	Offset: 0x1C68
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private queue_setrotors(weapon)
{
	self setweaponammoclip(weapon.dualwieldweapon, 1);
}

/*
	Name: function_dc7f8e67
	Namespace: zm_weap_chakram
	Checksum: 0x310BBC77
	Offset: 0x1CA8
	Size: 0x518
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dc7f8e67(player)
{
	player endon(#"death", #"seeker_done");
	player.var_30cbff55 = 1;
	var_e9ada947 = level.var_30d2c56e[#"chakram"][#"delay_start"][player.var_72d6f15d];
	var_9884ff29 = level.var_30d2c56e[#"chakram"][#"delay_end"][player.var_72d6f15d];
	var_fc51fa3d = level.var_30d2c56e[#"chakram"][#"kill_limit"][player.var_72d6f15d];
	var_e68de849 = level.var_30d2c56e[#"chakram"][#"max_range"][player.var_72d6f15d];
	var_931acaa7 = level.var_30d2c56e[#"chakram"][#"seek_range"][player.var_72d6f15d];
	wait(var_e9ada947);
	n_kills = 0;
	if(!isdefined(player.e_seeker))
	{
		e_seeker = util::spawn_model(level.var_30d2c56e[#"chakram"][#"throw_model"][player.var_72d6f15d], player gettagorigin("tag_weapon_left"));
		player.e_seeker = e_seeker;
		e_seeker.var_fee68611 = [];
		e_seeker.var_8d8b7454 = [];
	}
	else
	{
		e_seeker = player.e_seeker;
		e_seeker.var_fee68611 = [];
		e_seeker.var_8d8b7454 = [];
		e_seeker.origin = player gettagorigin("tag_weapon_left");
		e_seeker setmodel(level.var_30d2c56e[#"chakram"][#"throw_model"][player.var_72d6f15d]);
		e_seeker show();
	}
	player.var_fbe120be = 1;
	e_seeker clientfield::set("" + #"hash_2a55372ad04eb0e5", 1);
	b_zombie_killed = player function_e3ad524a();
	if(isdefined(b_zombie_killed) && b_zombie_killed)
	{
		n_kills++;
	}
	e_target = e_seeker function_46f125d(e_seeker.origin, var_931acaa7);
	if(isdefined(e_target))
	{
		while(n_kills < var_fc51fa3d && isdefined(e_target))
		{
			b_zombie_killed = player function_3adb0798(e_target);
			if(isdefined(b_zombie_killed) && b_zombie_killed)
			{
				n_kills++;
			}
			waitframe(1);
			e_target = e_seeker function_46f125d(e_seeker.origin, var_931acaa7);
		}
	}
	player function_3adb0798(undefined, n_kills);
	player thread chakram_rumble(2);
	e_seeker clientfield::set("" + #"hash_2a55372ad04eb0e5", 0);
	waitframe(1);
	if(isdefined(e_seeker))
	{
		e_seeker hide();
	}
	wait(var_9884ff29);
	if(isalive(player))
	{
		player setweaponammoclip(player.slot_weapons[#"hero_weapon"], 1);
	}
	player.var_fbe120be = 0;
	player.var_30cbff55 = undefined;
	player notify(#"seeker_done");
}

/*
	Name: function_e3ad524a
	Namespace: zm_weap_chakram
	Checksum: 0x493FCF5E
	Offset: 0x21C8
	Size: 0x736
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e3ad524a()
{
	self endon(#"death", #"seeker_done");
	self.e_seeker endon(#"death");
	var_e68de849 = level.var_30d2c56e[#"chakram"][#"max_range"][self.var_72d6f15d];
	var_931acaa7 = level.var_30d2c56e[#"chakram"][#"seek_range"][self.var_72d6f15d] / 1.5;
	var_afbf7a56 = level.var_30d2c56e[#"chakram"][#"travel_time"][self.var_72d6f15d];
	v_start = self geteye();
	v_forward = self getweaponforwarddir();
	v_end = v_start + (v_forward * var_e68de849);
	a_trace = bullettrace(v_start, v_end, 0, self);
	if(distancesquared(v_start, v_end) > distancesquared(v_start, a_trace[#"position"]))
	{
		v_end = a_trace[#"position"];
		n_dist = distance(v_start, v_end);
		var_c5eb6fda = (n_dist * var_afbf7a56) / var_e68de849;
		if(var_c5eb6fda <= 0)
		{
			return 0;
		}
		self.e_seeker.angles = vectortoangles(v_forward);
		self.e_seeker moveto(v_end, var_c5eb6fda);
		var_5b08cfa = gettime() / 1000;
	}
	else
	{
		self.e_seeker.angles = vectortoangles(v_forward);
		self.e_seeker moveto(v_end, var_afbf7a56);
	}
	n_time_started = gettime() / 1000;
	var_fcb3d955 = v_start;
	var_28035668 = v_forward;
	do
	{
		n_time_current = gettime() / 1000;
		n_time_elapsed = n_time_current - n_time_started;
		e_target = self.e_seeker function_46f125d(var_fcb3d955, var_931acaa7, var_28035668);
		if(isdefined(e_target))
		{
			if(isdefined(e_target.powerup_name))
			{
				e_target.origin = self.e_seeker.origin;
				e_target linkto(self.e_seeker);
				if(!isdefined(self.e_seeker.var_fee68611))
				{
					self.e_seeker.var_fee68611 = [];
				}
				else if(!isarray(self.e_seeker.var_fee68611))
				{
					self.e_seeker.var_fee68611 = array(self.e_seeker.var_fee68611);
				}
				self.e_seeker.var_fee68611[self.e_seeker.var_fee68611.size] = e_target;
			}
			else if(isalive(e_target))
			{
				b_killed_zombie = self function_3adb0798(e_target);
				self notify(#"hash_146bfa4c4de1779");
				return b_killed_zombie;
			}
		}
		if(isdefined(var_5b08cfa))
		{
			var_9cdda9f7 = n_time_current - var_5b08cfa;
			if(var_9cdda9f7 >= var_c5eb6fda)
			{
				level thread function_8d4b8171(v_end, a_trace[#"normal"]);
				if(isdefined(level.var_2e32e0bb))
				{
					level notify(#"hero_weapon_hit", {#v_position:a_trace[#"position"], #hash_80e17549:self.currentweapon, #e_entity:a_trace[#"entity"], #player:self});
				}
				v_start = v_end;
				v_forward = v_forward - (2 * a_trace[#"normal"]) * vectordot(v_forward, a_trace[#"normal"]);
				n_dist = var_e68de849 - n_dist;
				v_end = v_start + (v_forward * n_dist);
				a_trace = bullettrace(v_start, v_end, 0, self);
				if(distancesquared(v_start, v_end) != distancesquared(v_start, a_trace[#"position"]))
				{
					v_end = a_trace[#"position"];
					n_dist = distance(v_start, v_end);
					var_5b08cfa = gettime() / 1000;
				}
				else
				{
					var_5b08cfa = undefined;
				}
				var_c5eb6fda = (n_dist * var_afbf7a56) / var_e68de849;
				if(var_c5eb6fda <= 0)
				{
					return 0;
				}
				self.e_seeker.angles = vectortoangles(v_forward);
				self.e_seeker moveto(v_end, var_c5eb6fda);
			}
		}
		wait(0.1);
		var_fcb3d955 = self.e_seeker.origin;
	}
	while(n_time_elapsed < var_afbf7a56);
	return 0;
}

/*
	Name: function_46f125d
	Namespace: zm_weap_chakram
	Checksum: 0x41758343
	Offset: 0x2908
	Size: 0x3F2
	Parameters: 3
	Flags: Linked, Private
*/
function private function_46f125d(v_start, var_4d1ea1ad, v_forward)
{
	self endon(#"death");
	var_b9e95436 = zm_hero_weapon::function_7c3681f7();
	a_e_targets = array::get_all_closest(v_start, var_b9e95436, undefined, undefined, var_4d1ea1ad);
	if(isdefined(v_forward))
	{
		foreach(e_powerup in level.active_powerups)
		{
			if(!isdefined(e_powerup))
			{
				continue;
			}
			if(isinarray(self.var_fee68611, e_powerup))
			{
				continue;
			}
			if(isdefined(level.var_5d31a5ef) && isinarray(level.var_5d31a5ef, e_powerup.powerup_name))
			{
				continue;
			}
			if(!isdefined(a_e_targets))
			{
				a_e_targets = [];
			}
			else if(!isarray(a_e_targets))
			{
				a_e_targets = array(a_e_targets);
			}
			a_e_targets[a_e_targets.size] = e_powerup;
		}
	}
	n_traces = 0;
	foreach(e_target in a_e_targets)
	{
		if(!isalive(e_target))
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(e_target))
		{
			continue;
		}
		if(isinarray(self.var_fee68611, e_target))
		{
			continue;
		}
		if(isdefined(e_target.var_6f84b820) && (e_target.var_6f84b820 == #"heavy" || e_target.var_6f84b820 == #"miniboss" || e_target.var_6f84b820 == #"boss"))
		{
			if(isdefined(self.var_8d8b7454) && isinarray(self.var_8d8b7454, e_target))
			{
				continue;
			}
		}
		if(isdefined(v_forward))
		{
			v_to_target = vectornormalize(e_target.origin - v_start);
			if(vectordot(v_to_target, v_forward) < 0.7)
			{
				continue;
			}
		}
		if(isdefined(e_target.powerup_name) || function_ffa5b184(e_target) || isalive(e_target) && bullettracepassed(v_start, e_target getcentroid(), 0, self, e_target))
		{
			return e_target;
		}
		n_traces++;
		if(n_traces > 3)
		{
			n_traces = 0;
			waitframe(1);
		}
	}
	return undefined;
}

/*
	Name: function_3adb0798
	Namespace: zm_weap_chakram
	Checksum: 0x46642C22
	Offset: 0x2D08
	Size: 0x4B0
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3adb0798(e_target, n_kills)
{
	self endon(#"death", #"seeker_done");
	self.e_seeker endon(#"death");
	var_ece935b3 = level.var_30d2c56e[#"chakram"][#"travel_time"][self.var_72d6f15d];
	var_e68de849 = level.var_30d2c56e[#"chakram"][#"max_range"][self.var_72d6f15d];
	if(!isdefined(e_target))
	{
		e_target = self;
		var_fc51fa3d = level.var_30d2c56e[#"chakram"][#"kill_limit"][self.var_72d6f15d];
		var_ece935b3 = var_ece935b3 / 2;
	}
	while(true)
	{
		if(!isdefined(e_target))
		{
			return false;
		}
		if(isplayer(e_target))
		{
			var_2f067119 = e_target gettagorigin("tag_weapon_left");
			if(!isdefined(var_2f067119))
			{
				var_2f067119 = e_target.origin;
			}
			v_target = var_2f067119 + (anglestoforward(e_target.angles) * 24);
			while(isdefined(n_kills) && n_kills < var_fc51fa3d)
			{
				s_trace = bullettrace(self.e_seeker.origin, v_target, 1, self.e_seeker);
				if(isdefined(s_trace[#"entity"]) && isinarray(getaiteamarray(level.zombie_team), s_trace[#"entity"]))
				{
					self thread function_545dcea4(s_trace[#"entity"]);
					n_kills++;
				}
				else
				{
					break;
				}
			}
		}
		else
		{
			v_target = e_target getcentroid();
		}
		if(distancesquared(self.e_seeker.origin, v_target) > 2304)
		{
			var_81b38250 = distance(self.e_seeker.origin, v_target);
			n_travel_time = (var_81b38250 * var_ece935b3) / var_e68de849;
			self.e_seeker moveto(v_target, n_travel_time);
		}
		else
		{
			if(isplayer(e_target))
			{
				self playsound(#"hash_2c86fd203e33ce7c");
				self.e_seeker.origin = self gettagorigin("tag_weapon_left");
				a_e_powerups = array::remove_undefined(self.e_seeker.var_fee68611);
				foreach(e_powerup in a_e_powerups)
				{
					e_powerup unlink();
					e_powerup.origin = self.origin;
				}
				return false;
			}
			self thread function_96835348(e_target);
			return true;
		}
		wait(0.1);
	}
}

/*
	Name: function_545dcea4
	Namespace: zm_weap_chakram
	Checksum: 0xCAF05942
	Offset: 0x31C0
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_545dcea4(e_target)
{
	self endon(#"death", #"seeker_done");
	self.e_seeker endon(#"death");
	e_target endon(#"death");
	while(distance2d(self.e_seeker.origin, e_target getcentroid()) < 25)
	{
		waitframe(1);
	}
	self thread function_96835348(e_target);
}

/*
	Name: function_96835348
	Namespace: zm_weap_chakram
	Checksum: 0xEAF3D1D5
	Offset: 0x3288
	Size: 0x43C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_96835348(e_target)
{
	if(isalive(e_target))
	{
		e_target endon(#"death");
		self endon(#"disconnect");
		if(isdefined(e_target.var_6f84b820))
		{
			switch(e_target.var_6f84b820)
			{
				case "popcorn":
				case "basic":
				case "enhanced":
				{
					gibserverutils::gibhead(e_target);
					e_target clientfield::set("" + #"hash_1e22d429435cc148", 1);
					n_damage = e_target.health;
					break;
				}
				case "heavy":
				case "miniboss":
				{
					e_target clientfield::increment("" + #"hash_56421723ef2ac2fb", 1);
					n_damage = 1000;
					if(!isdefined(self.e_seeker.var_8d8b7454))
					{
						self.e_seeker.var_8d8b7454 = [];
					}
					else if(!isarray(self.e_seeker.var_8d8b7454))
					{
						self.e_seeker.var_8d8b7454 = array(self.e_seeker.var_8d8b7454);
					}
					self.e_seeker.var_8d8b7454[self.e_seeker.var_8d8b7454.size] = e_target;
					break;
				}
				case "boss":
				{
					n_damage = 1000;
					if(!isdefined(self.e_seeker.var_8d8b7454))
					{
						self.e_seeker.var_8d8b7454 = [];
					}
					else if(!isarray(self.e_seeker.var_8d8b7454))
					{
						self.e_seeker.var_8d8b7454 = array(self.e_seeker.var_8d8b7454);
					}
					self.e_seeker.var_8d8b7454[self.e_seeker.var_8d8b7454.size] = e_target;
					break;
				}
				case "inanimate":
				{
					if(!(isdefined(e_target.var_f7f67d2c) && e_target.var_f7f67d2c))
					{
						e_target thread function_20d19d65(0.5);
					}
					n_damage = 1000;
				}
				n_damage = 1000;
			}
		}
		else
		{
			if(!(isdefined(e_target.var_f7f67d2c) && e_target.var_f7f67d2c))
			{
				e_target thread function_20d19d65(0.5);
			}
			n_damage = 1000;
		}
		if(isactor(e_target))
		{
			e_target thread zm_hero_weapon::function_acee2761();
			[[ level.var_893eb73f ]]->waitinqueue(e_target);
		}
		weapon = undefined;
		if(isdefined(self))
		{
			weapon = self.slot_weapons[#"hero_weapon"];
		}
		e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_PROJECTILE", 0, weapon);
	}
}

/*
	Name: function_20d19d65
	Namespace: zm_weap_chakram
	Checksum: 0xFC95DD66
	Offset: 0x36D0
	Size: 0x3E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_20d19d65(n_time)
{
	self endon(#"death");
	self.var_f7f67d2c = 1;
	wait(n_time);
	self.var_f7f67d2c = 0;
}

/*
	Name: function_8d4b8171
	Namespace: zm_weap_chakram
	Checksum: 0xE454561B
	Offset: 0x3718
	Size: 0xA4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8d4b8171(v_position, v_normal)
{
	mdl_fx = util::spawn_model("tag_origin", v_position, v_normal);
	mdl_fx endon(#"death");
	mdl_fx clientfield::set("" + #"hash_302e96545259ba6b", 1);
	wait(1.5);
	mdl_fx delete();
}

/*
	Name: function_d5e67082
	Namespace: zm_weap_chakram
	Checksum: 0x92ED3CD4
	Offset: 0x37C8
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d5e67082(weapon)
{
	self endon(#"disconnect");
	self clientfield::increment_to_player("" + #"hash_7287b37a40c4ae6f", 1);
}

/*
	Name: function_b475223e
	Namespace: zm_weap_chakram
	Checksum: 0xDEB6ED95
	Offset: 0x3820
	Size: 0x108
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b475223e(weapon)
{
	self endon(#"disconnect", #"weapon_change", #"bled_out", #"entering_last_stand");
	level endoncallback(&function_7d1739b8, #"round_reset");
	while(self getcurrentweapon() == weapon)
	{
		self waittill(#"weapon_melee");
		if(!zm_trial_restrict_loadout::function_5fbf572(weapon))
		{
			continue;
		}
		self thread function_f9b883ea();
		self function_481a494b(weapon);
		self function_892bdee2();
		wait(0.5);
	}
}

/*
	Name: function_7d1739b8
	Namespace: zm_weap_chakram
	Checksum: 0xFA5445DB
	Offset: 0x3930
	Size: 0xB0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7d1739b8(var_201c5b1f)
{
	/#
		assert(var_201c5b1f == #"round_reset");
	#/
	foreach(player in getplayers())
	{
		player function_892bdee2();
	}
}

/*
	Name: function_f9b883ea
	Namespace: zm_weap_chakram
	Checksum: 0x7157B662
	Offset: 0x39E8
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f9b883ea()
{
	self endon(#"disconnect");
	self notify("beb94ee3d73772a");
	self endon("beb94ee3d73772a");
	self waittill(#"death", #"weapon_change", #"hash_1c35eb15aa210d6", #"hash_62fb3ab92a1f20cd");
	if(isdefined(self))
	{
		self thread function_892bdee2();
	}
}

/*
	Name: function_892bdee2
	Namespace: zm_weap_chakram
	Checksum: 0x9F199E11
	Offset: 0x3A88
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private function_892bdee2()
{
	self.var_a70d2cfe = undefined;
	if(self clientfield::get("" + #"hash_9d9fb6cf3d5d3a6"))
	{
		self clientfield::set("" + #"hash_9d9fb6cf3d5d3a6", 0);
	}
}

/*
	Name: function_481a494b
	Namespace: zm_weap_chakram
	Checksum: 0x10CDB904
	Offset: 0x3AF8
	Size: 0x41C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_481a494b(var_5f94a2e7)
{
	self endon(#"weapon_melee", #"weapon_change", #"disconnect", #"bled_out", #"entering_last_stand");
	self.var_a70d2cfe = 1;
	self clientfield::set("" + #"hash_9d9fb6cf3d5d3a6", 1);
	self playsound(#"hash_6043c078f3675169");
	while(isdefined(self.var_a70d2cfe) && self.var_a70d2cfe)
	{
		self clientfield::increment_to_player("" + #"chakram_rumble", 6);
		a_e_targets = zm_hero_weapon::function_7c3681f7();
		a_e_targets = arraysortclosest(a_e_targets, self.origin, undefined, undefined, 128);
		foreach(e_target in a_e_targets)
		{
			if(isalive(e_target) && !zm_utility::is_magic_bullet_shield_enabled(e_target))
			{
				var_9a7661ba = 1;
				if(isdefined(e_target.var_6f84b820))
				{
					switch(e_target.var_6f84b820)
					{
						case "popcorn":
						case "basic":
						case "enhanced":
						{
							n_damage = 3594;
							break;
						}
						case "heavy":
						case "miniboss":
						{
							n_damage = 1000;
							break;
						}
						case "boss":
						{
							n_damage = 1000;
							var_9a7661ba = 0;
							break;
						}
						case "inanimate":
						{
							n_damage = 3594;
							var_9a7661ba = 0;
						}
						n_damage = 3594;
					}
				}
				else
				{
					n_damage = 3594;
				}
				if(e_target.health < n_damage && isactor(e_target) && var_9a7661ba)
				{
					gibserverutils::gibhead(e_target);
					e_target clientfield::set("" + #"hash_1e22d429435cc148", 1);
					e_target playsound(#"hash_4332e54b12b06564");
					e_target clientfield::increment("" + #"hash_3c3af9a781191429", 1);
				}
				e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, var_5f94a2e7);
				waitframe(1);
			}
		}
		wait(0.2);
	}
}

/*
	Name: chakram_rumble
	Namespace: zm_weap_chakram
	Checksum: 0x6694FA12
	Offset: 0x3F20
	Size: 0x162
	Parameters: 1
	Flags: Linked
*/
function chakram_rumble(var_b2e05bae)
{
	if(isalive(self) && var_b2e05bae)
	{
		switch(var_b2e05bae)
		{
			case 1:
			{
				self playrumbleonentity("zm_weap_special_activate_rumble");
				break;
			}
			case 2:
			{
				self clientfield::increment_to_player("" + #"chakram_rumble", 2);
				break;
			}
			case 3:
			{
				self playrumbleonentity("zm_weap_chakram_melee_hit_rumble");
				break;
			}
			case 4:
			{
				self clientfield::increment_to_player("" + #"chakram_rumble", 4);
				break;
			}
			case 5:
			{
				self clientfield::increment_to_player("" + #"chakram_rumble", 5);
				break;
			}
		}
	}
}

/*
	Name: function_68ff89f7
	Namespace: zm_weap_chakram
	Checksum: 0x4B8B9CDC
	Offset: 0x4090
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(w_chakram)
{
	self endon(#"disconnect", #"weapon_change", #"bled_out", #"entering_last_stand");
	level endoncallback(&function_7d1739b8, #"round_reset");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee");
	if(s_result.weapon === w_chakram)
	{
		self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"chakram");
	}
}

/*
	Name: on_player_disconnect
	Namespace: zm_weap_chakram
	Checksum: 0xBA26AA42
	Offset: 0x4178
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(isdefined(self.e_seeker))
	{
		self.e_seeker delete();
	}
}

