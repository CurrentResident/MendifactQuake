/***************************\
*                           *
* Rune Serv main block code *
*                           *
\***************************/

//This is Artifact Quake version 2.1

//(c) Copyright 1997 By Nick "SiNGE" Bousman
//E-Mail: singe@ix.netcom.com

//If you modify this code, please note that if you include this code in your
//mod, you MUST GIVE ME APPROPRIATE CREDIT for the runes. This is my child.
//I worked hard on it.

//*------------------------------------------------------------*

//Runes #1-10 in RUNES10.QC
//Runes #11-20 in RUNES20.QC
//Runes #21-30 in RUNES30.QC
//Runes #31-34 in RUNES40.QC
//Main Code in RUNESERV.QC

void() REAL_Comments =
{
   //These comments stay, even when decompiled
   bprint(" This is Artifact Quake version 2.1                         ");
   bprint(" Artifact Quake is (C) Copyright 1997 By Nick 'SiNGE' Bousman ");
   bprint(" E-mail: singe@ix.netcom.com                                  ");
   bprint("");
   bprint(" Oh, and if you decompiled this, you're a twit.               ");
};

//*------------------------------------------------------------*

//Artifact Quake
//Main runes handling code

void() Rune_Think =
{
   if (self.runetype == RN_REGEN) Rune_Regen(); else
//   if (self.runetype == RN_FIREWALK) Rune_Firewalk(); else //new
   if (self.runetype == RN_ZAP) Rune_Zap(); else
   if (self.runetype == RN_BOMB) Rune_Bomb(); else
   if (self.runetype == RN_CLOAK) Rune_Cloak(); else
   if (self.runetype == RN_CAMO) Rune_Camo(); else
   if (self.runetype == RN_JUMP) Rune_Jump(); else
   if (self.runetype == RN_AMMO) Rune_Ammo(); else
   if (self.runetype == RN_SHIELD) Shield_On(); else
   if (self.runetype == RN_REPEL) Rune_Repel(); else
   if (self.runetype == RN_FLY) Rune_Fly(); else
   if (self.runetype == RN_WEIRD) Rune_Weird(); else
   if (self.runetype == RN_BERSERK) Berserk_Bleed(); else
   if (self.runetype == RN_PHASE) Wall_Check(); else
	if (self.runetype == RN_GHOST) Rune_Ghost_Hold (); else
	if (self.runetype == RN_HEAD) Rune_Head_Float ();
   return;
};

void() Rune_Button =
{     
   if (!self.runetype) return;
   else if (self.runetype == RN_RECALL) Rune_Recall();
   else if (self.runetype == RN_BOMB) Bomb_Arm();
   else if (self.runetype == RN_DSPOTS) Rune_DSpots();
   else if (self.runetype == RN_HOLO) Rune_Holo();
   else if (self.runetype == RN_BLINK) Rune_Blink();
   else if (self.runetype == RN_SHIELD) Rune_Shield();
   else if (self.runetype == RN_RADIO) Rune_Radio();
   else if (self.runetype == RN_SWITCH) Rune_Switch();
   else if (self.runetype == RN_FREEZE) Rune_Freeze();
   else if (self.runetype == RN_SUCK) Suck_Button();
   else if (self.runetype == RN_ENVIRO) Enviro_Jump();
   else if (self.runetype == RN_TWALK) Rune_Twalk();
   else if (self.runetype == RN_SHAMB) Rune_ShamblerReloc();
   else if (self.runetype == RN_DUAL) Rune_Dual();
   else if (self.runetype == RN_WEIRD) Weird_Throw();

//******** new rune code *********

	else if (self.runetype == RN_IMPACT)  Rune_Impact ();
	else if (self.runetype == RN_GHOST)  Rune_Ghost_Button ();
	else if (self.runetype == RN_HEAD)  Rune_Head_Button ();
};

void() Rune_Tell =
{
   if (self.runetype == 0)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\n No Rune ");
   else if (self.runetype == RN_HEALTH)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Good Health \nŸ");
   else if (self.runetype == RN_REGEN)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Regeneration \nŸ");
   else if (self.runetype == RN_RESIST)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Resistance \nŸ");
   else if (self.runetype == RN_HASTE)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Haste \nŸ");
   else if (self.runetype == RN_ENVIRO)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Environmental Protection \nŸ");
   else if (self.runetype == RN_FLY)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Flight \nŸ");
//   else if (self.runetype == RN_FIREWALK)
//      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n
//Rune of Fire Walking \nŸ");
   else if (self.runetype == RN_RECALL)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Recall \nŸ");
   else if (self.runetype == RN_ZAP)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Electric Rune \nŸ");
   else if (self.runetype == RN_CLOAK)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Cloaking \nŸ");
   else if (self.runetype == RN_BOMB)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Divine Wind \nŸ");
   else if (self.runetype == RN_DSPOTS)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Death Spots \nŸ");
   else if (self.runetype == RN_HOLO)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n HoloRune \nŸ");
   else if (self.runetype == RN_ORB)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Orb of Death \nŸ");
   else if (self.runetype == RN_BLINK)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Blink Rune \nŸ");
   else if (self.runetype == RN_CAMO)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Camouflage \nŸ");
   else if (self.runetype == RN_JUMP)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Uncontrolable Jumping \nŸ");
   else if (self.runetype == RN_AMMO)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Action Movie Arsenal \nŸ");
   else if (self.runetype == RN_VAMP)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Vampiric Rune \nŸ");
   else if (self.runetype == RN_SHIELD)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Shielding \nŸ");
   else if (self.runetype == RN_STRENGTH)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Strength \nŸ");
   else if (self.runetype == RN_RADIO)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Radioactivity \nŸ");
   else if (self.runetype == RN_SWITCH)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Switch Rune \nŸ");
   else if (self.runetype == RN_FREEZE)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Ice Traps \nŸ");
   else if (self.runetype == RN_SUCK)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Gravity Rune \nŸ");
   else if (self.runetype == RN_TWALK)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n The Teleport Shuffle \nŸ");
   else if (self.runetype == RN_IMPACT)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Impact Rune \nŸ");
   else if (self.runetype == RN_VENG)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Vengance \nŸ");
   else if (self.runetype == RN_SHUB)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Shub Hat \nŸ\n");
   else if (self.runetype == RN_REPEL)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Repulsion \nŸ\n");
//   else if (self.runetype == RN_CLOUD)
//      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n
//Rune of Floating Spiky Death Cloud \nŸ\n");
   else if (self.runetype == RN_SHAMB)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Shambler Helper \nŸ\n");
   else if (self.runetype == RN_DUAL)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Dual Recall \nŸ\n");
   else if (self.runetype == RN_WEIRD)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Rune of Weirdness \nŸ\n");
   else if (self.runetype == RN_PHOENIX)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Phoenix Rune \nŸ\n");
   else if (self.runetype == RN_BERSERK)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Berserker Rune \nŸ\n");
   else if (self.runetype == RN_PHASE)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Phased Rune \nŸ\n");
	else if (self.runetype == RN_GHOST)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Egon Rune \nŸ\n");
	else if (self.runetype == RN_HEAD)
      centerprint(self,"\n\n\n\n\n\n\n\n\n\nŸ\n Haunted Head \nŸ\n");
};


void() Rune_Activate =
{
   stuffcmd(self,"v_cshift 0 0 0 1\n");
   self.max_health = 100;
   self.runevar = 0;
   self.runetime = time;
   self.runevector = '0 0 0';
   self.movetype = MOVETYPE_WALK;
   self.touch = SUB_Null;

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.modelindex = modelindex_player;

   if (self.runetype == RN_HEALTH)
   {
      self.max_health = 666;
      self.health = self.health + 100;
      if (self.health > self.max_health) self.health = self.max_health;
   }
   else if (self.runetype == RN_RECALL) self.runevar = 1;
   else if (self.runetype == RN_ZAP) Zap_Spawn();
   else if (self.runetype == RN_BOMB) Bomb_Spawn();
   else if (self.runetype == RN_ORB) Orb_Spawn();
   else if (self.runetype == RN_BLINK) Dot_Spawn();
   else if (self.runetype == RN_SHIELD) self.runevar = 0;
   else if (self.runetype == RN_VENG) VengHead_Spawn();
   else if (self.runetype == RN_SHUB) ShubHat_Spawn();
//   else if (self.runetype == RN_CLOUD) Cloud_Spawn();
   else if (self.runetype == RN_FLY) self.movetype = MOVETYPE_FLY;
   else if (self.runetype == RN_SHAMB) Rune_ShamblerSpawn();
//   else if (self.runetype == RN_FIREWALK) GFire_Spawn();
   else if (self.runetype == RN_DUAL) self.runevector = self.origin;
   else if (self.runetype == RN_PHOENIX) self.runevar = 3;
   else if (self.runetype == RN_CLOAK) Rune_Cloak();
   else if (self.runetype == RN_IMPACT) self.touch = Impact_Touch;
	//******** new stuff **********
	else if (self.runetype == RN_GHOST) self.runevar = 0;
	else if (self.runetype == RN_HEAD) self.runevar = 0;

   Rune_Tell();
};

string() RandMap =
{
   local float rand;
   local string newmap;

   rand = ceil(random()*36.0);
   rand = rand + ceil (random () * 21.0);
   rand = rand + ceil (random () * 53.0);
   rand = rand + ceil (random () * 18.0);
   while (rand > 36)
	{
	rand = rand - 36;
	}
   if (rand == 1) newmap = "start";
   if (rand == 2) newmap = "dm1";
   if (rand == 3) newmap = "dm2";
   if (rand == 4) newmap = "dm3";
   if (rand == 5) newmap = "dm4";
   if (rand == 6) newmap = "dm5";
   if (rand == 7) newmap = "dm6";
   if (rand == 8) newmap = "e1m1";
   if (rand == 9) newmap = "e1m2";
   if (rand == 10) newmap = "e1m3";
   if (rand == 11) newmap = "e1m4";
   if (rand == 12) newmap = "e1m5";
   if (rand == 13) newmap = "e1m6";
   if (rand == 14) newmap = "e2m1";
   if (rand == 15) newmap = "e2m2";
   if (rand == 16) newmap = "e2m3";
   if (rand == 17) newmap = "e2m4";
   if (rand == 18) newmap = "e2m5";
   if (rand == 19) newmap = "e2m6";
   if (rand == 20) newmap = "e2m7";
   if (rand == 21) newmap = "e3m1";
   if (rand == 22) newmap = "e3m2";
   if (rand == 23) newmap = "e3m3";
   if (rand == 24) newmap = "e3m4";
   if (rand == 25) newmap = "e3m5";
   if (rand == 26) newmap = "e3m6";
   if (rand == 27) newmap = "e3m7";
   if (rand == 28) newmap = "e4m1";
   if (rand == 29) newmap = "e4m1";
   if (rand == 30) newmap = "e4m2";
   if (rand == 31) newmap = "e4m3";
   if (rand == 32) newmap = "e4m4";
   if (rand == 33) newmap = "e4m5";
   if (rand == 34) newmap = "e4m6";
   if (rand == 35) newmap = "e4m7";
   if (rand == 36) newmap = "e4m8";

//Remove these in the not-LAN version. Lagged to hell they are.

   if (rand == 37) newmap = "e1m7";
   if (rand == 38) newmap = "end";
   if (rand == 39) newmap = "e1m8";

   return newmap;
};

void() MOTD =
{
   if (self.motd_count < 2)
   {
      self.motd_time = time + 1;
      self.motd_count = self.motd_count + 1;

      if (deathmatch)

	centerprint (self, "Artifact Quake  -\nby Singe <singe@ix.netcom.com> \n\nthis server is run and modified by \nMendicant-  jjt@umr.edu"); 
//            centerprint(self,"Aòôéæáãô Qõáëå
//2.1\n€ƒƒƒƒƒƒƒƒ‚\nCollect a rune, get an
//ability!\n\nIMPULSE “’’ MUST BE BOUND.\nIMPULSE ›› shows yourcurrent
//rune.\nIMPULSE ›š deactivates your rune.\nƒƒ\nWrittenby
//ÓéÎÇÅ\n
//E -mail: singe@ix.netcom.com\n€ƒƒƒƒƒƒƒƒ‚");
   }
};

void(entity guy) ServerMsg =
{
   if (guy.classname != "player") return;
   sprint(guy,"This server running Aòôéæáãô Qõáëå 2.1\n");
   sprint(guy,"Pick up a rune, get an ability!\n");
   sprint(guy,"\n");
   sprint(guy,"Author: ÓéÎÇÅ\n");
   sprint(guy,"E-Mail: singe@ix.netcom.com\n");
   sprint(guy,"Web: urbanite.com/web/singe/quake/runeserv.html");
   sprint(guy,"\n");
   sprint(guy,"IMPULSE 100: The Button. Activates some runes. BIND THIS!!\n");
   sprint(guy,"IMPULSE 99: Show which rune you have\n");
   sprint(guy,"IMPULSE 98: Deactivate rune\n");
   sprint(guy,"IMPULSE 97: Server blurb\n");
   sprint(guy,"\n\n\n\n");
};

entity() SelectRuneSpawnPoint =
{
   local float runec;
   local entity e;

//runec is to keep them from clustering
   runec = 0;
   while (runec < random()*100+10)
   {
      runespawn = nextent (runespawn);
      runec = runec + 1;
   }

   runec = 0;
//Now runec checks for HUGE HUGE loops to prevent crashing

   while(((runespawn.classname == "player")
        ||(runespawn.classname == "rune"))
        &&runec<1500)
   {
      runespawn = nextent (runespawn);
      runec = runec + 1;
   }

   return runespawn;
};

void() Rune_Move =
{
   local entity temp;

   temp = SelectRuneSpawnPoint();
   setorigin(self, temp.origin);

   self.nextthink = time + 60 + random()*60;

   self.flags = self.flags-(self.flags & FL_ONGROUND);

   self.velocity_x = crandom()*500;
   self.velocity_y = crandom()*500;
   self.velocity_z = random()*500;
};

void() Rune_Touch =
{
   local entity temp;
   local string temtex1;
   local float rand;

   if (pointcontents(self.origin) == CONTENT_SOLID
    || pointcontents(self.origin) == CONTENT_LAVA)
      self.nextthink = time;

   if (other == world)
      sound (self, CHAN_WEAPON, "weapons/tink1.wav", 1.0, ATTN_NORM);

   if (other.classname != "player") return;
   if (other.health <= 0) return;

   if (other.runetype != 0) return;
                                        
   other.runetype = self.runetype;
   runecurrent = runecurrent - 1;

   remove(self);

   temp = self;
   self = other;

   Rune_Activate();
   self.dropdelay = time + 5;
   self.effects = self.effects | EF_MUZZLEFLASH;
   sound (self, CHAN_BODY, "buttons/switch21.wav", 1, ATTN_NORM);

   self = temp;
};

void(vector sorigin, float xmax, float ymax, float zmax, float type) Rune_Spawn =
{
   local entity rune;
   local float rnd, counter;

   rune = spawn();
   setorigin(rune, sorigin);

   setsize (rune, '-16 -16 0', '16 16 50');
   rune.movetype = MOVETYPE_BOUNCE;
   rune.solid = SOLID_TRIGGER;
   rune.flags = FL_ITEM;
   rune.velocity_x = crandom()*xmax;
   rune.velocity_y = crandom()*ymax;
   rune.velocity_z = random()*zmax;
   rune.classname = "rune";

   rnd = random()*4;
   if (rnd > 0) setmodel (rune, "progs/end1.mdl");
   if (rnd > 1) setmodel (rune, "progs/end2.mdl");
   if (rnd > 2) setmodel (rune, "progs/end3.mdl");
   if (rnd > 3) setmodel (rune, "progs/end4.mdl");

   rune.runetype = type;

   rune.touch = Rune_Touch;
   rune.think = Rune_Move;
};

void(float numspawn) Rune_SpawnAll =
{
   local float counter, type;
   local entity temp;

   counter = 0;
   while (counter < numspawn)
   {
      temp = SelectRuneSpawnPoint();

      type = random()*TOTAL_RUNETYPE;
      type = ceil(type);

      Rune_Spawn(temp.origin, 500, 500, 500, type);
      counter = counter + 1;
   }
   runecurrent = runecurrent + numspawn;
};
