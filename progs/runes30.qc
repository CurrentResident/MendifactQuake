
//Artifact Quake
//Runes code #21-30
//(C) 1997 Nick "Singe" Bousman
//Give me credit if you modify it. I worked hard on it.

void() Strength_Sound =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 1;
    sound (self, CHAN_AUTO, "items/damage3.wav", 1, ATTN_NORM);
};

void() Radio_Think =
{
    local entity head, selected;
    local float dist;

    if (self.runetime < time)
    {
        if (self.owner.runetype == RN_RADIO && self.owner.runevar > 0)
        {
            self.owner.runevar = self.owner.runevar - 1;
        }

        remove (self);
        return;
    }

    if (self.runevar > 0)
    {
        self.runevar = self.runevar - 1;
        particle (self.origin, '0 0 0', 0, 255);
    }

    dist = 1500;

    selected = world;
    head = findradius (self.origin, dist);

    while (head)
    {
        if ((head.health > 0) && (head != self))
        {
            traceline (self.origin, head.origin, TRUE, self);

            if ((trace_fraction >= 1) && (vlen (head.origin - self.origin) < dist) )
            {
                selected = head;

                if (selected != world)
                {
                    T_Damage (selected, self, self.owner, 5);
                    particle (selected.origin, '0 0 10', 104, 150);

                    if (selected.classname == "player")
                    {
                        sprint (selected, " This area is radioactive!\n");
                    }
                }
            }
        }

        head = head.chain;
    }

    self.nextthink = time + 0.8;
};

void() Rune_Radio =
{
    local entity radio;
    local entity head, selected;
    local float dist;

    if (self.health > 0)
    {
        if (self.runevar > 2)
        {
            if (self.health)
            {
                centerprint (self, "You can only irradiate 3 areas");
            }

            return;
        }

        dist = 2000;

        selected = world;
        head = findradius (self.origin, dist);

        while (head)
        {
            if (head.classname == "radioactive")
            {
                traceline (self.origin, head.origin, TRUE, self);

                if ( (trace_fraction >= 1) && (vlen (head.origin - self.origin) < dist) )
                {
                    selected = head;

                    if (selected != world)
                    {
                        centerprint (self, "This area is already radioactive");
                        return;
                    }
                }
            }

            head = head.chain;
        }

        self.runevar = self.runevar + 1;

        centerprint (self, "5 seconds to Irradiation\nGet out!");
    }

    radio = spawn();
    radio.movetype = MOVETYPE_FLY;
    radio.solid = SOLID_TRIGGER;
    radio.owner = self;
    radio.classname = "radioactive";
    setorigin (radio, self.origin);
    self.avelocity_x = crandom() * 360;
    self.avelocity_y = crandom() * 360;
    self.avelocity_z = crandom() * 360;
    setsize (radio, '0 0 0', '0 0 0');

    radio.nextthink = time + 5;
    sound (radio, CHAN_WEAPON, "items/damage.wav", 1, ATTN_NORM);

    radio.runetime = time + 45;
    radio.think = Radio_Think;
    radio.runevar = 1;
};

void() Rune_Switch =
{
    local vector tempv, org;
    local float tempf;
    local entity switch, tempe;

    local vector f, p1, p2;

    org = self.origin + '0 0 15';
    makevectors (self.v_angle);

    p1 = org;
    p2 = org + v_forward * 1000;

    f = p2 - p1;
    normalize (f);
    f_x = 0 - f_y;
    f_y = f_x;
    f_z = 0;
    f = f * 16;

    traceline (p1, p2, FALSE, self);

    switch = trace_ent;

    makevectors (self.angles);

    if (switch.health > 0 && switch.solid != SOLID_BSP)
    {
        spawn_tfog (switch.origin);
        spawn_tfog (self.origin);

        //Switch places
        tempv = switch.origin;
        setorigin (switch, self.origin);
        setorigin (self, tempv);

        //Switch angles
        tempv_y = switch.angles_y;
        switch.angles_y = self.angles_y;
        self.angles_y = tempv_y;
        self.fixangle = 1;
        switch.fixangle = 1;

        //Switch velocity
        tempv = switch.velocity;
        switch.velocity = self.velocity;
        self.velocity = tempv;

        //Lightning zap
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_LIGHTNING3);
        WriteEntity (MSG_BROADCAST, self);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);
        WriteCoord (MSG_BROADCAST, switch.origin_x);
        WriteCoord (MSG_BROADCAST, switch.origin_y);
        WriteCoord (MSG_BROADCAST, switch.origin_z);

        //Switch health
        tempf = switch.health;
        switch.health = self.health;
        self.health = tempf;

        if (switch.classname == "player")
        {
            //Invis vars switch
            if ((switch.items & IT_INVISIBILITY) || (self.items & IT_INVISIBILITY))
            {
                tempf = switch.invisible_finished;
                switch.invisible_finished = self.invisible_finished;
                self.invisible_finished = tempf;

                tempf = switch.invisible_time;
                switch.invisible_time = self.invisible_time;
                self.invisible_time = tempf;
            }

            //Pentagram vars switch
            if ((switch.items & IT_INVULNERABILITY) || (self.items & IT_INVULNERABILITY))
            {
                tempf = switch.invincible_finished;
                switch.invincible_finished = self.invincible_finished;
                self.invincible_finished = tempf;

                tempf = switch.invincible_time;
                switch.invincible_time = self.invincible_time;
                self.invincible_time = tempf;
            }

            //Quad vars switch
            if ((switch.items & IT_QUAD) || (self.items & IT_QUAD))
            {
                tempf = switch.super_damage_finished;
                switch.super_damage_finished = self.super_damage_finished;
                self.super_damage_finished = tempf;

                tempf = switch.super_time;
                switch.super_time = self.super_time;
                self.super_time = tempf;
            }

            //Biosuit vars switch
            if ((switch.items & IT_SUIT) || (self.items & IT_SUIT))
            {
                tempf = switch.radsuit_finished;
                switch.radsuit_finished = self.radsuit_finished;
                self.radsuit_finished = tempf;

                tempf = switch.rad_time;
                switch.rad_time = self.rad_time;
                self.rad_time = tempf;
            }

            //Switch items
            tempf = switch.items;
            switch.items = self.items;
            self.items = tempf;

            //Switch ammo
            tempf = switch.ammo_shells;
            switch.ammo_shells = self.ammo_shells;
            self.ammo_shells = tempf;

            tempf = switch.ammo_nails;
            switch.ammo_nails = self.ammo_nails;
            self.ammo_nails = tempf;

            tempf = switch.ammo_rockets;
            switch.ammo_rockets = self.ammo_rockets;
            self.ammo_rockets = tempf;

            tempf = switch.ammo_cells;
            switch.ammo_cells = self.ammo_cells;
            self.ammo_cells = tempf;

            if (self.ammo_shells < 25)
            {
                self.ammo_shells = 25;
            }

            if (switch.ammo_shells < 25)
            {
                switch.ammo_shells = 25;
            }

            centerprint (switch, "You've switched places!");

            self.weapon = W_BestWeapon();
            W_SetCurrentAmmo();
            CheckPowerups();

            tempe = self;

            self = switch;

        self.weapon = W_BestWeapon();
            W_SetCurrentAmmo();
            CheckPowerups();

            self = tempe;
        }
    }

    particle (trace_endpos, '0 0 0', 36, 100);
    particle (trace_endpos, '0 0 0', 44, 50);
};

void() Freeze_Think =
{
    self.nextthink = time + 1.0;

    particle (self.origin, '0 0 -10', 40, 20);

    if (self.runetime < time)
    {
        if (self.owner.runetype == RN_FREEZE && self.owner.runevar > 0)
        {
            self.owner.runevar = self.owner.runevar - 1;
        }

        remove (self);
    }
};

void() Freeze_Frozen =
{
    setorigin (self.runent, self.origin);

    self.runent.angles = self.angles;
    self.runent.fixangle = 1;
    self.runent.attack_finished = time + 1;
    self.runent.frame = self.runevar;
    self.runent.velocity = '0 0 0';

    self.nextthink = time;

    //frozen particles
    if (self.attack_finished < time)
    {
        self.attack_finished = time + 0.15;
        makevectors (self.angles);
        particle (self.origin + v_up * random() * 30, '0 0 -10' + v_forward * crandom() * 5 + v_right * crandom() * 5, 40, 20);
    }

    //remove if time is out or dead
    if (self.runetime < time || self.runent.health < 1)
    {
        if (self.runent.classname == "player")
        {
            centerprint (self.runent, "Released from Ice Trap");
            stuffcmd (self.runent, "v_cshift 0 0 0 0\n");
        }

        sound (self, CHAN_BODY, "blob/death1.wav", 1, ATTN_NORM);
        self.think = SUB_Remove;
        self.nextthink = time + 3;
    }
};

void() Freeze_Touch =
{
    if (!other.health || other == world)
    {
        return;
    }

    if (other.runetype == RN_ENVIRO)
    {
        return;
    }

    if (self.owner.runetype == RN_FREEZE && self.owner.runevar > 0)
    {
        self.owner.runevar = self.owner.runevar - 1;
    }

    if (other.classname == "player")
    {
        stuffcmd (other, "v_cshift 50 50 256 100\n");
        centerprint (other, "You've been frozen!");
        sprint (self.owner, other.netname);
        sprint (self.owner, " is frozen in your Ice Trap.\n");
    }

    sound (self, CHAN_BODY, "shambler/smack.wav", 1, ATTN_NORM);

    self.runent = other;
    self.runevar = other.frame;
    self.angles = other.angles;
    self.fixangle = 1;
    setorigin (self, other.origin);
    self.touch = SUB_Null;

    //how long frozen
    self.runetime = time + 13;
    self.nextthink = time;
    self.think = Freeze_Frozen;

    //people with firewalking would obviously get out faster
    if (other.runetype == RN_FIREWALK)
    {
        self.runetime = time + 5;
    }
};

void() Freeze_Arm =
{
    self.nextthink = time;
    self.runetime = time + 120;
    self.think = Freeze_Think;
    self.touch = Freeze_Touch;
    setmodel (self, "");
    sound (self, CHAN_BODY, "fish/bite.wav", 1, ATTN_NORM);
};

void() Rune_Freeze =
{
    local entity freeze;

    if (self.runevar > 5)
    {
        centerprint (self, "Only 6 Ice Traps allowed");
        return;
    }

    self.runevar = self.runevar + 1;

    freeze = spawn();
    freeze.movetype = MOVETYPE_FLY;
    freeze.solid = SOLID_TRIGGER;
    freeze.owner = self;
    freeze.classname = "freeze";
    freeze.angles = self.angles;
    freeze.v_angle = self.v_angle;
    setorigin (freeze, self.origin + '0 0 10');
    setmodel (freeze, "progs/s_bubble.spr");
    setsize (freeze, '0 0 0', '0 0 0');

    freeze.think = Freeze_Arm;
    freeze.nextthink = time + 3;
    sound (self, CHAN_AUTO, "enforcer/sight2.wav", 1, ATTN_NORM);
    sound (freeze, CHAN_WEAPON, "buttons/switch04.wav", 1, ATTN_NORM);

    centerprint (self, "Ice Trap created\nRUN!");
};

void (entity sucker) Suck =
{
    local entity suckee;
    local vector suckdir, suckforce;
    local float suckdist, dist;

    dist = 700;

    suckee = findradius (sucker.origin, dist); //find the victims

    while (suckee)
    {
        if (suckee.health || ! (suckee.flags & FL_ONGROUND))
        {
            if (suckee.solid != SOLID_BSP && ! (self.owner == suckee) && sucker != suckee)
            {
                if (suckee.classname != "player")
                {
                    suckee.flags = suckee.flags - (suckee.flags & FL_ONGROUND);
                }

                suckdir = sucker.origin - suckee.origin;
                suckdist = vlen (suckdir);
                suckdir = normalize (suckdir);
                suckforce = suckdir * 0.25 * (dist - suckdist);
                suckee.velocity = suckee.velocity + suckforce;
            }
        }

        suckee = suckee.chain;
    }
};

void() Rune_Suck =
{
    if (self.runetime > time || self.runevar == 1)
    {
        return;
    }

    self.runetime = time + 0.1;
    Suck (self);
};

void() Suck_Think =
{
    if ((self.owner.runevar == 0 && self.owner.runetype == RN_SUCK) || self.runetime < time)
    {
        spawn_tfog (self.origin);
        remove (self);
        return;
    }

    if (self.owner.health && self.owner.runetype == RN_SUCK)
    {
        self.runetime = time + 20;
    }

    self.nextthink = time + 0.1;

    Suck (self);
};

void() Suck_Touch =
{
    if (other.solid == SOLID_BSP)
    {
        return;
    }

    if (other.health < 1)
    {
        return;
    }

    // There used to be an interesting bug here that prevented anything from getting damaged by the gravity
    // well.  For the sake of keeping things consistent, that's commented out here, and no damage can be done,
    // but it really should be fixed.  FIXME.
    //if (other = self.owner)
    //{
    //    return;
    //}

    //T_Damage (other, self, self.owner, 1);
};

void() Suck_Spawn =
{
    local entity suck;

    suck = spawn();
    suck.movetype = MOVETYPE_FLY;
    suck.solid = SOLID_TRIGGER;
    suck.owner = self;
    setorigin (suck, self.origin + '0 0 40');
    setsize (suck, '0 0 0', '0 0 0');
    setmodel (suck, "progs/s_light.spr");
    suck.classname = "sucker";

    sound (suck, CHAN_WEAPON, "buttons/switch04.wav", 1, ATTN_NORM);

    suck.nextthink = time;
    suck.think = Suck_Think;
    suck.runetime = time + 1;
    suck.touch = Suck_Touch;

    centerprint (self, "Gravity Well dropped");
};

void() Suck_Button =
{
    if (self.runevar == 0)
    {
        self.runevar = 1;
        Suck_Spawn();
    }
    else
    {
        self.runevar = 0;
        centerprint (self, "Gravity Well recalled");
    }
};

void() Impact_Touch =
{
    if (other == world)
    {
        return;
    }

    if (other.takedamage != DAMAGE_AIM)
    {
        return;
    }

    //  if (self.runetime > time) return;

    self.runetime = time + 0.5;

    other.flags = other.flags - (other.flags & FL_ONGROUND);
    other.velocity = other.velocity + '0 0 200' + self.velocity * 3;
    self.velocity = '0 0 0' - self.velocity;
    sound (self, CHAN_AUTO, "zombie/z_miss.wav", 1, ATTN_NORM);
    self.runevar = 10;
    T_Damage (other, self, self, (5 + random() * 10));
    self.runevar = 0;
};

void () Rune_Impact =
{

    if (self.runetime < time && self.flags & FL_ONGROUND)
    {
        self.runetime = time + 1.0;
        self.flags = self.flags - FL_ONGROUND;
        makevectors (self.v_angle);
        self.velocity = self.velocity + 1200.0 * v_forward;
        sound (self, CHAN_AUTO, "doors/airdoor2.wav", 1,
        ATTN_NORM);
        self.touch = Impact_Touch;
    }
};

//void() Rune_Impact =
//{
//   if (self.velocity == '0 0 0') return;
//   if (self.runetime > time) return;
//
//   self.runetime = time + 0.1;
//
//   local entity head, selected;
//
//   selected = world;
//   head = findradius(self.origin, 60);
//   while(head)
//   {
//      if(head.health > 0 && head != self)
//      {
//         selected = head;
//
//         if (selected != world && selected.solid != SOLID_BSP)
//         {
//            selected.flags = selected.flags-(selected.flags & FL_ONGROUND);
//            selected.velocity = selected.velocity + '0 0 200' + self.velocity*3;
//            self.velocity = self.velocity * -1;
//            sound (self, CHAN_AUTO, "zombie/z_miss.wav", 1, ATTN_NORM);
//            self.runevar = 10;
//            T_Damage(selected, self, self, (45+random()*10));
//            self.runevar = 0;
//         }
//      }
//      head = head.chain;
//   }
//};

void (vector org) spawn_ntfog =
{
    WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
    WriteByte (MSG_BROADCAST, TE_TELEPORT);
    WriteCoord (MSG_BROADCAST, org_x);
    WriteCoord (MSG_BROADCAST, org_y);
    WriteCoord (MSG_BROADCAST, org_z);
};

float(vector org, vector hull_mins, vector hull_maxes) TestBox =
{
    local float  testpointcontents;
    local vector testpoint0;
    local vector testpoint1;
    local vector testpoint2;
    local vector testpoint3;
    local vector testpoint4;
    local vector testpoint5;
    local vector testpoint6;
    local vector testpoint7;

    testpoint0 = org        + hull_mins;
    testpoint1 = testpoint0;
    testpoint2 = testpoint0;
    testpoint3 = testpoint0;

    testpoint1_x = org_x + hull_maxes_x;
    testpoint2_y = org_y + hull_maxes_y;
    testpoint3_x = org_x + hull_mins_x;

    testpoint4 = org        + hull_maxes;
    testpoint5 = testpoint4;
    testpoint6 = testpoint4;
    testpoint7 = testpoint4;

    testpoint5_x = org_x + hull_mins_x;
    testpoint6_y = org_y + hull_mins_y;
    testpoint7_x = org_x + hull_maxes_x;

    testpointcontents = pointcontents (testpoint0);
    if (testpointcontents != CONTENT_SOLID)
    {
        testpointcontents = pointcontents (testpoint1);
        if (testpointcontents != CONTENT_SOLID)
        {
            testpointcontents = pointcontents (testpoint2);
            if (testpointcontents != CONTENT_SOLID)
            {
                testpointcontents = pointcontents (testpoint3);
                if (testpointcontents != CONTENT_SOLID)
                {
                    testpointcontents = pointcontents (testpoint4);
                    if (testpointcontents != CONTENT_SOLID)
                    {
                        testpointcontents = pointcontents (testpoint5);
                        if (testpointcontents != CONTENT_SOLID)
                        {
                            testpointcontents = pointcontents (testpoint6);
                            if (testpointcontents != CONTENT_SOLID)
                            {
                                testpointcontents = pointcontents (testpoint7);
                                if (testpointcontents != CONTENT_SOLID)
                                {
                                    return 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
};

void() Rune_Twalk =
{
    local vector org, place;

    local entity switch;

    local vector p1, p2;

    org = self.origin + '0 0 15';
    makevectors (self.v_angle);

    p1 = org;
    p2 = org + v_forward * 1500;

    traceline (p1, p2, FALSE, self);

    switch = trace_ent;

    particle (trace_endpos, '0 0 0', 8, 100);

    if (switch == world)
    {
        local vector    destination;
        local float     destinationtest;
        local float     testcount;

        // Probe for a place safe to teleport to.  Where did the trace end?  Step back about 50 units from there
        // and see if any bounding box corners land inside something solid.  If so, step back another 10 units
        // and check again.  Do this 10 times and if we find an okay spot, teleport there.  Otherwise, drop it.
        //
        // Why?  Because darkplaces otherwise sometimes lets us teleport with the bounding box partially into
        // something solid, which results in subsequent teleport shuffles landing WAY outside the map, exiling
        // the player to the outer darkness.  Original Quake just gave up instead.  This algorithm helps avoid
        // the realm of the old gods.
        //
        destination = trace_endpos - v_forward * 50;

        testcount       = 10;
        destinationtest = 0;

        while (testcount > 0 && destinationtest == 0)
        {
            destination = destination - v_forward * 10;

            destinationtest = TestBox (destination, RN_HULL_MIN, RN_HULL_MAX);

            testcount = testcount - 1;
        }

        if (destinationtest > 0)
        {
            spawn_ntfog (self.origin);
            setorigin (self, destination);
            droptofloor();
        }
        return;
    }

    if (switch.flags & FL_ITEM)
    {
        setorigin (self, switch.origin);
        return;
    }

    if (switch.health > 0 && switch.solid != SOLID_BSP && switch.movetype != MOVETYPE_NONE)
    {
        spawn_tfog (self.origin);
        spawn_tfog (switch.origin);

        if (random() < 0.3)
        {
            spawn_tdeath (self.origin, self);
        }

        place = switch.origin;
        setorigin (switch, self.origin);
        setorigin (self, place);

        if (switch.classname == "player")
        {
            centerprint (switch, "Someone stole your place!");
        }

        return;
    }
};

void() VengHead_Think =
{
    if (self.owner.health < 1 || self.owner.runetype != RN_VENG)
    {
        remove (self);
        return;
    }

    makevectors (self.owner.angles);

    setorigin (self, self.owner.origin + v_up * 20 - v_right * 1 - v_forward * 9);
    self.nextthink = time;

    self.angles_y = self.owner.angles_y - 27;
};

void() VengHead_Spawn =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_NOT;
    temp.owner = self;
    setorigin (temp, self.origin);
    setsize (temp, '0 0 0', '0 0 0');
    setmodel (temp, "progs/h_player.mdl");
    temp.think = VengHead_Think;
    temp.nextthink = time;
    temp.angles_x = -60;
    temp.angles_z = -30;
    temp.colormap = self.colormap;
    self.runent = temp;
};

void() ShubHat_Bye =
{
    self.nextthink = time;
    setorigin (self, self.origin + '0 0 15');
    self.angles_y = self.angles_y - 10;

    if (self.runetime > time)
    {
        return;
    }

    remove (self);
};

void() ShubHat_Think =
{
    if (self.owner.health < 1 || self.owner.runetype != RN_SHUB)
    {
        self.nextthink = time;
        self.think = ShubHat_Bye;
        self.flags = self.flags - FL_ONGROUND;
        self.runetime = time + 10;
        return;
    }

    setorigin (self, self.owner.origin);
    self.nextthink = time;
};

void() ShubHat_Spawn =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_NOT;
    temp.owner = self;
    setorigin (temp, self.origin);
    setsize (temp, '-160 -128 -24', '160 128 256');
    setmodel (temp, "progs/oldone.mdl");
    temp.think = ShubHat_Think;
    temp.nextthink = time;

    if (random() > 0.5)
    {
        temp.avelocity_y = 100;
    }
    else
    { temp.avelocity_y = -100; }
    temp.colormap = self.colormap;
    self.runent = temp;
};

void() Rune_Repel =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = self.runetime + 0.1;

    local entity pushee;
    local vector pushdir, pushforce;
    local float pushdist, dist;

    dist = 400;

    pushee = findradius (self.origin, dist); //Find the victims.

    while (pushee)
    {
        if (pushee.health || ! (pushee.flags & FL_ONGROUND))
        {
            if (pushee.solid != SOLID_BSP && self != pushee)
            {
                if (pushee.classname != "player")
                {
                    pushee.flags = pushee.flags - (pushee.flags & FL_ONGROUND);
                }

                pushdir = self.origin - pushee.origin;
                pushdist = vlen (pushdir);
                pushdir = normalize (pushdir);
                pushforce = pushdir * 0.45 * (dist - pushdist);
                pushee.velocity = pushee.velocity - pushforce;
            }
        }

        pushee = pushee.chain;
    }
};
