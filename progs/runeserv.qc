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
    bprint (" This is Artifact Quake version 2.1                         ");
    bprint (" Artifact Quake is (C) Copyright 1997 By Nick 'SiNGE' Bousman ");
    bprint (" E-mail: singe@ix.netcom.com                                  ");
    bprint ("");
    bprint (" Oh, and if you decompiled this, you're a twit.               ");
};

//*------------------------------------------------------------*

//Artifact Quake
//Main runes handling code

void() Rune_Think =
{
    if (self.runetype == RN_REGEN)
    {
        Rune_Regen();
    }
    else if (self.runetype == RN_FIREWALK)
    {
        Rune_Firewalk();
    }
    else   //new
        if (self.runetype == RN_ZAP)
        {
            Rune_Zap();
        }
        else if (self.runetype == RN_BOMB)
        {
            Rune_Bomb();
        }
        else if (self.runetype == RN_CLOAK)
        {
            Rune_Cloak();
        }
        else if (self.runetype == RN_CAMO)
        {
            Rune_Camo();
        }
        else if (self.runetype == RN_JUMP)
        {
            Rune_Jump();
        }
        else if (self.runetype == RN_AMMO)
        {
            Rune_Ammo();
        }
        else if (self.runetype == RN_SHIELD)
        {
            Shield_On();
        }
        else if (self.runetype == RN_REPEL)
        {
            Rune_Repel();
        }
        else if (self.runetype == RN_FLY)
        {
            Rune_Fly();
        }
        else if (self.runetype == RN_WEIRD)
        {
            Rune_Weird();
        }
        else if (self.runetype == RN_BERSERK)
        {
            Berserk_Bleed();
        }
        else if (self.runetype == RN_PHASE)
        {
            Wall_Check();
        }
        else if (self.runetype == RN_HEAD)
        {
            Rune_Head_Float ();
        }

    return;
};

void() Rune_Button =
{
    if (!self.runetype)
    {
        return;
    }
    else if (self.runetype == RN_RECALL)
    {
        Rune_Recall();
    }
    else if (self.runetype == RN_BOMB)
    {
        Bomb_Arm();
    }
    else if (self.runetype == RN_DSPOTS)
    {
        Rune_DSpots();
    }
    else if (self.runetype == RN_HOLO)
    {
        Rune_Holo();
    }
    else if (self.runetype == RN_BLINK)
    {
        Rune_Blink();
    }
    else if (self.runetype == RN_SHIELD)
    {
        Rune_Shield();
    }
    else if (self.runetype == RN_RADIO)
    {
        Rune_Radio();
    }
    else if (self.runetype == RN_SWITCH)
    {
        Rune_Switch();
    }
    else if (self.runetype == RN_FREEZE)
    {
        Rune_Freeze();
    }
    else if (self.runetype == RN_SUCK)
    {
        Suck_Button();
    }
    else if (self.runetype == RN_ENVIRO)
    {
        Enviro_Jump();
    }
    else if (self.runetype == RN_TWALK)
    {
        Rune_Twalk();
    }
    else if (self.runetype == RN_SHAMB)
    {
        Rune_ShamblerReloc();
    }
    else if (self.runetype == RN_DUAL)
    {
        Rune_Dual();
    }
    else if (self.runetype == RN_WEIRD)
    {
        Weird_Throw();
    }
    else if (self.runetype == RN_IMPACT)
    {
        Rune_Impact ();
    }
    else if (self.runetype == RN_GHOST)
    {
        Rune_Ghost_Button ();
    }
    else if (self.runetype == RN_HEAD)
    {
        Rune_Head_Button ();
    }
};

void() Rune_Tell =
{
    if (self.runetype == 0)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\n No Rune ");
    }
    else if (self.runetype == RN_HEALTH)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Good Health \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_REGEN)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Regeneration \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_RESIST)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Resistance \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_HASTE)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Haste \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_ENVIRO)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Environmental Protection \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_FLY)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Flight \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_FIREWALK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Fire Walking \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_RECALL)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Recall \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_ZAP)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Electric Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_CLOAK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Cloaking \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_BOMB)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Divine Wind \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_DSPOTS)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Death Spots \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_HOLO)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n HoloRune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_ORB)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Orb of Death \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_BLINK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Blink Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_CAMO)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Camouflage \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_JUMP)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Uncontrolable Jumping \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_AMMO)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Action Movie Arsenal \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_VAMP)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Vampiric Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_SHIELD)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Shielding \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_STRENGTH)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Strength \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_RADIO)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Radioactivity \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_SWITCH)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Switch Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_FREEZE)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Ice Traps \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_SUCK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Gravity Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_TWALK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n The Teleport Shuffle \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_IMPACT)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Impact Rune \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_VENG)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Vengance \nžžžžžžžžžžžžžžžžžžžžŸ");
    }
    else if (self.runetype == RN_SHUB)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Shub Hat \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_REPEL)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Repulsion \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_CLOUD)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Floating Spiky Death Cloud \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_SHAMB)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Shambler Helper \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_DUAL)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Dual Recall \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_WEIRD)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Rune of Weirdness \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_PHOENIX)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Phoenix Rune \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_BERSERK)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Berserker Rune \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_PHASE)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Phased Rune \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_GHOST)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Egon Rune \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
    else if (self.runetype == RN_HEAD)
    {
        centerprint (self, "\n\n\n\n\n\n\n\n\n\nžžžžžžžžžžžžžžžžžžžžŸ\n Haunted Head \nžžžžžžžžžžžžžžžžžžžžŸ\n");
    }
};

void() Rune_Activate =
{
    stuffcmd (self, "v_cshift 0 0 0 1\n");
    self.max_health = 100;
    self.runevar    = 0;
    self.runent     = world;
    self.runetime   = time;
    self.runevector = '0 0 0';
    self.movetype   = MOVETYPE_WALK;
    self.touch      = SUB_Null;

    // Clear out any possible bad clipping state from Haunted Head.
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
    self.modelindex = modelindex_player;

    if (self.runetype == RN_HEALTH)
    {
        self.max_health = 666;
        self.health = self.health + 100;

        if (self.health > self.max_health)
        {
            self.health = self.max_health;
        }
    }
    else if (self.runetype == RN_RECALL)
    {
        self.runevar = 1;
    }
    else if (self.runetype == RN_ZAP)
    {
        Zap_Spawn();
    }
    else if (self.runetype == RN_BOMB)
    {
        Bomb_Spawn();
    }
    else if (self.runetype == RN_ORB)
    {
        Orb_Spawn();
    }
    else if (self.runetype == RN_BLINK)
    {
        Dot_Spawn();
    }
    else if (self.runetype == RN_SHIELD)
    {
        self.runevar = 0;
    }
    else if (self.runetype == RN_VENG)
    {
        VengHead_Spawn();
    }
    else if (self.runetype == RN_SHUB)
    {
        ShubHat_Spawn();
    }
    else if (self.runetype == RN_CLOUD)
    {
        Cloud_Spawn();
    }
    else if (self.runetype == RN_FLY)
    {
        self.movetype = MOVETYPE_FLY;
    }
    else if (self.runetype == RN_SHAMB)
    {
        Rune_ShamblerSpawn();
    }

    //   else if (self.runetype == RN_FIREWALK) GFire_Spawn();
    else if (self.runetype == RN_DUAL)
    {
        self.runevector = self.origin;
    }
    else if (self.runetype == RN_PHOENIX)
    {
        self.runevar = 3;
    }
    else if (self.runetype == RN_CLOAK)
    {
        Rune_Cloak();
    }
    else if (self.runetype == RN_IMPACT)
    {
        self.touch = Impact_Touch;
    }
    else if (self.runetype == RN_HEAD)
    {
        self.runevar = 0;
    }

    Rune_Tell();
};

void() Rune_PostThink =
{
    if (self.runetype == RN_FLY ||
            (self.runetype == RN_HEAD && self.runevar == 1))
    {
        // Legacy workaround for Darkplaces.  Oldschool quake mods assumed that they could set the
        // FL_ONGROUND flag in PreThink and that it would be carried forward in the physics processing.
        // It turns out that (at least in Darkplaces, possibly original Quake and other variants perhaps?)
        // the code that allows walking-like precision of movement through the air as these oldschool mods
        // expected actually happens BEFORE PreThink.  So there's a need for the FL_ONGROUND flag to also
        // get carried from one frame to the next.  Darkplaces' physics and client handling code is pretty
        // different, and actually clears FL_ONGROUND if the physics processing itself detects no
        // collision with a floor.  So in order to make the rune flight code work as intended in Darkplaces,
        // and retain compatibility with original Quake and other ports, we need to get in there and set
        // FL_ONGROUND again after the physics has run but before the next frame.  We hook PostThink for
        // that.
        self.flags = self.flags | FL_ONGROUND;
    }

};

string() RandMap =
{
    local float rand;
    local string newmap;

    newmap = "";

    rand = ceil (random() * 36.0);
    //   rand = rand + ceil (random () * 21.0);
    //  rand = rand + ceil (random () * 53.0);
    //  rand = rand + ceil (random () * 18.0);
    rand = rand + time;
    rand = ceil (((rand / 35.0) - floor (rand / 35.0)) * 35.0) + 1;
    /*   while (rand > 36)
    	{
    	rand = rand - 36;
    	}
    */
    if (rand == 1)
    {
        newmap = "start";
    }

    if (rand == 2)
    {
        newmap = "dm1";
    }

    if (rand == 3)
    {
        newmap = "dm2";
    }

    if (rand == 4)
    {
        newmap = "dm3";
    }

    if (rand == 5)
    {
        newmap = "dm4";
    }

    if (rand == 6)
    {
        newmap = "dm5";
    }

    if (rand == 7)
    {
        newmap = "dm6";
    }

    if (rand == 8)
    {
        newmap = "e1m1";
    }

    if (rand == 9)
    {
        newmap = "e1m2";
    }

    if (rand == 10)
    {
        newmap = "e1m3";
    }

    if (rand == 11)
    {
        newmap = "e1m4";
    }

    if (rand == 12)
    {
        newmap = "e1m5";
    }

    if (rand == 13)
    {
        newmap = "e1m6";
    }

    if (rand == 14)
    {
        newmap = "e2m1";
    }

    if (rand == 15)
    {
        newmap = "e2m2";
    }

    if (rand == 16)
    {
        newmap = "e2m3";
    }

    if (rand == 17)
    {
        newmap = "e2m4";
    }

    if (rand == 18)
    {
        newmap = "e2m5";
    }

    if (rand == 19)
    {
        newmap = "e2m6";
    }

    if (rand == 20)
    {
        newmap = "e2m7";
    }

    if (rand == 21)
    {
        newmap = "e3m1";
    }

    if (rand == 22)
    {
        newmap = "e3m2";
    }

    if (rand == 23)
    {
        newmap = "e3m3";
    }

    if (rand == 24)
    {
        newmap = "e3m4";
    }

    if (rand == 25)
    {
        newmap = "e3m5";
    }

    if (rand == 26)
    {
        newmap = "e3m6";
    }

    if (rand == 27)
    {
        newmap = "e3m7";
    }

    if (rand == 28)
    {
        newmap = "e4m1";
    }

    if (rand == 29)
    {
        newmap = "e4m1";
    }

    if (rand == 30)
    {
        newmap = "e4m2";
    }

    if (rand == 31)
    {
        newmap = "e4m3";
    }

    if (rand == 32)
    {
        newmap = "e4m4";
    }

    if (rand == 33)
    {
        newmap = "e4m5";
    }

    if (rand == 34)
    {
        newmap = "e4m6";
    }

    if (rand == 35)
    {
        newmap = "e4m7";
    }

    if (rand == 36)
    {
        newmap = "e4m8";
    }

    //Remove these in the not-LAN version. Lagged to hell they are.

    if (rand == 37)
    {
        newmap = "e1m7";
    }

    if (rand == 38)
    {
        newmap = "end";
    }

    if (rand == 39)
    {
        newmap = "e1m8";
    }

    return newmap;
};

void() MOTD =
{
    self.motd_time  = time            + 1;  // By default, the client shows centerprint messages for 2 seconds.  Overlap to avoid a strobing MOTD.
    self.motd_count = self.motd_count + 1;

    if (self.motd_count <= 2)
    {
        //centerprint(self,"Aòôéæáãô Qõáëå 2.1\n€ƒƒƒƒƒƒƒƒ‚\nCollect a rune, get an ability!\n\nIMPULSE “’’ MUST BE BOUND.\nIMPULSE ›› shows your current rune.\nIMPULSE ›š deactivates your rune.\nƒžžžžžžžžžžžƒ\nWritten by ŽÓéÎÇÅ\nE-mail: singe@ix.netcom.com\n€ƒƒƒƒƒƒƒƒ‚");
        centerprint (self, "Artifact Quake  -\nby Singe <singe@ix.netcom.com> \n\nthis server is run and modified by \nMendicant-  jjt@umr.edu");
    }
    else if (self.motd_count <= 8)
    {
        centerprint (self, "Bind these impulses:\n\nimpulse 100 - Use rune               \n\nimpulse 99  - Show rune              \n\nimpulse 98  - Drop rune              \n\nimpulse 97  - Show this message again");
    }
    else
    {
        self.motd_time = 0;
    }
};

void (entity guy) ServerMsg =
{
    if (guy.classname != "player")
    {
        return;
    }

    sprint (guy, "This server running Aòôéæáãô Qõáëå 2.1\n");
    sprint (guy, "Pick up a rune, get an ability!\n");
    sprint (guy, "\n");
    sprint (guy, "Author: ŽÓéÎÇÅ\n");
    sprint (guy, "E-Mail: singe@ix.netcom.com\n");
    sprint (guy, "Web: urbanite.com/web/singe/quake/runeserv.html");
    sprint (guy, "\n");
    sprint (guy, "IMPULSE 100: The Button. Activates some runes. BIND THIS!!\n");
    sprint (guy, "IMPULSE 99: Show which rune you have\n");
    sprint (guy, "IMPULSE 98: Deactivate rune\n");
    sprint (guy, "IMPULSE 97: Server blurb\n");
    sprint (guy, "\n\n\n\n");
};

entity() SelectRuneSpawnPoint =
{
    local float runec, iters;

    // For a long time, Artifact Quake just left runespawn at whatever it found last time, and let nextent deal
    // with the pain of finding the next real ent.  Then Darkplaces decided to drop the ent count during physics
    // processing for removed temp ents.  This creates a window where runespawn can be left beyond the last real
    // ent, which nextent() can't deal with.
    //
    // Now we try to be a little more clever.

    // If there are runes, randomly pick one (or the world) as the starting point for the entity search
    // Otherwise, start with world.
    runespawn = world;

    runec = random() * runecurrent;
    while (runec > 0)
    {
        runespawn = find (runespawn, classname, "rune");
        runec = runec - 1;
    }

    // All this randomness is an attempt to fight clustering...
    runec = 0;
    iters = random() * 100 + 10;

    while (runec < iters)
    {
        runespawn = nextent (runespawn);
        runec = runec + 1;
    }

    runec = 0;
    //Now runec checks for HUGE HUGE loops to prevent crashing

    while ((   (runespawn.classname == "player")
               || (runespawn.classname == "rune")
               || (runespawn           == world)
           )
            && runec < 1500)
    {
        runespawn = nextent (runespawn);
        runec = runec + 1;
    }

    return runespawn;
};

float(entity rune) Rune_Must_Move =
{
    local float i;

    i = pointcontents (rune.origin);

    if ((i == CONTENT_SOLID && ! (self.flags & FL_ONGROUND)) ||
            i == CONTENT_LAVA)
    {
        return i;
    }
    return 0;
};

void() Rune_Recycle =
{
    remove (self);
    runecurrent = runecurrent - 1;
    Rune_SpawnAll (1);
};

void() Rune_Clip_Check =
{
    //DEBUG local string tempstring;
    local float     remove_reason;

    // Debug info:
    //  BRIGHT FIELD = we think it could be a good idea to recycle this rune.
    //  BRIGHT LIGHT = it's on the ground.
    //
    // Idiosyncrasies about rune clipping to world:
    //
    // pointcontents SOLID is unreliable for seeing if we're making contact with the world.  ON GROUND
    // is much better for that.  However, SOLID is useful for detecting if we're outside the world.
    //
    // 1.  Sometimes a rune touches the world with pointcontents NOT SOLID and NOT ON GROUND.
    //      In these cases, the rune is okay, it's just bouncing or flying around.
    // 2.  If the rune touches the world and pointcontents is SOLID but NOT ON GROUND,
    //      it's either hit a wall or floor very briefly, or is falling outside the world.
    //      We allow a brief period to pass in this state before recycling.
    // 3.  If the rune is SOLID and ON GROUND, it's at rest and is okay.
    // 4.  If the rune is NOT SOLID and ON GROUND, that's also okay at rest.
    // 5.  Just delete right away if LAVA.
    //

    //DEBUG if (self.flags & FL_ONGROUND)
    //DEBUG {
    //DEBUG     self.effects = self.effects | EF_BRIGHTLIGHT;
    //DEBUG }
    //DEBUG else
    //DEBUG {
    //DEBUG     self.effects = self.effects - (self.effects & EF_BRIGHTLIGHT);
    //DEBUG }

    remove_reason = Rune_Must_Move (self);
    if (remove_reason)
    {
        // Remove immediately if touching lava.
        // Otherwise, let runevar time elapse first.
        if (self.runevar < time || remove_reason == CONTENT_LAVA)
        {
            // Set touch to null because if the rune is falling outside the map, the Touch
            // will fire and reset think to this function.
            //
            //DEBUG bprint ("Attempting to clean up\n");
            self.think  = Rune_Recycle;
            self.touch  = SUB_Null;
        }

        self.nextthink = time;
    }
    else
    {
        //DEBUG tempstring = ftos (self.runevar - time);
        //DEBUG bprint ("Rune okay with seconds remaining: ");
        //DEBUG bprint (tempstring);
        //DEBUG bprint ("\n");
        //DEBUG self.effects = self.effects - (self.effects & EF_BRIGHTFIELD);
        //DEBUG self.effects = self.effects - (self.effects & EF_BRIGHTLIGHT);

        self.runevar = 0;
        self.think = Rune_Recycle;
        self.nextthink = time + 60 + random() * 60;
    }
};

void() Rune_Touch =
{
    local entity temp;

    if (Rune_Must_Move (self))
    {
        // Check to see if we're still in the same "must move" condition for a short duration.
        self.think      = Rune_Clip_Check;
        self.nextthink  = time;

        if (self.runevar == 0)
        {
            self.runevar = time + 0.1;
        }

        //DEBUG self.effects = self.effects | EF_BRIGHTFIELD;
    }

    if (other == world)
    {
        sound (self, CHAN_WEAPON, "weapons/tink1.wav", 1.0, ATTN_NORM);
        //DEBUG eprint (self);
    }

    if (other.classname != "player")
    {
        return;
    }

    if (other.health <= 0)
    {
        return;
    }

    if (other.runetype != 0)
    {
        return;
    }

    other.runetype = self.runetype;
    runecurrent = runecurrent - 1;

    temp = self;
    self = other;

    Rune_Activate();
    self.dropdelay = time + 5;
    self.effects = self.effects | EF_MUZZLEFLASH;
    sound (self, CHAN_BODY, "buttons/switch21.wav", 1, ATTN_NORM);

    self = temp;
    remove (self);

};

void (vector sorigin, float xmax, float ymax, float zmax) Rune_Spawn =
{
    local entity rune;
    local float rnd;
    local float type;

    type = random() * TOTAL_RUNETYPE;
    type = ceil (type);

    rune = spawn();
    setorigin (rune, sorigin);

    setsize (rune, RN_HULL_MIN, RN_HULL_MAX);
    rune.movetype = MOVETYPE_BOUNCE;
    rune.solid = SOLID_TRIGGER;
    rune.flags = FL_ITEM;
    rune.velocity_x = crandom() * xmax;
    rune.velocity_y = crandom() * ymax;
    rune.velocity_z = random() * zmax;
    rune.classname = "rune";

    rnd = random() * 4;

    setmodel (rune, "progs/end1.mdl");

    if (rnd > 1)
    {
        setmodel (rune, "progs/end2.mdl");
    }

    if (rnd > 2)
    {
        setmodel (rune, "progs/end3.mdl");
    }

    if (rnd > 3)
    {
        setmodel (rune, "progs/end4.mdl");
    }

    rune.runetype   = type;
    rune.runevar    = 0;

    rune.touch = Rune_Touch;
    rune.think = Rune_Recycle;
    rune.nextthink = time + 60 + random() * 60;

    runecurrent = runecurrent + 1;
};

void (float numspawn) Rune_SpawnAll =
{
    local float counter;
    local entity temp;

    counter = 0;

    while (counter < numspawn)
    {
        temp = SelectRuneSpawnPoint();

        Rune_Spawn (temp.origin, 500, 500, 500);
        counter = counter + 1;
    }
};
