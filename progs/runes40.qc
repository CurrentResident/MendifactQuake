
//Artifact Quake
//Runes code #31-40
//(C) 1997 Nick "Singe" Bousman
//Give me credit if you modify it. I worked hard on it.

//For the normal balls
void() Ball_Touch =
{
    if (other == self.owner.runent)
    {
        return;
    }

    if (other.classname == "spikeball")
    {
        return;
    }

    if ((other.health > 0) && other != self.owner && other.solid != SOLID_BSP)
    {
        T_Damage (other, self, self.owner, 40);
        other.flags = other.flags - (other.flags & FL_ONGROUND);
        other.velocity_z = other.velocity_z + 270;
        sound (other, CHAN_AUTO, "zombie/z_miss.wav", 1, ATTN_NORM);

        self.touch = SUB_Null;
        setmodel (self, "");
    }
};

//For the final balls
void() Ball_Touch2 =
{
    if (pointcontents (self.origin) == CONTENT_LAVA || pointcontents (self.origin) == CONTENT_SOLID)
    {
        remove (self);
    }

    if (other == self.owner.runent)
    {
        return;
    }

    if (other.classname == "spikeball")
    {
        return;
    }

    if ((other.health > 0) && other != self.owner && other.solid != SOLID_BSP)
    {
        T_Damage (other, self, self.owner, 40);
        other.flags = other.flags - (other.flags & FL_ONGROUND);
        other.velocity_z = other.velocity_z + 270;
        sound (other, CHAN_AUTO, "zombie/z_miss.wav", 1, ATTN_NORM);
        remove (self);
    }
};

void() Ball_Move =
{
    if (self.owner.health < 1 || self.owner.runetype != RN_CLOUD)
    {
        remove (self);
        return;
    }

    self.nextthink = time + 3 + crandom() * 0.3;

    setmodel (self, "");
    setorigin (self, self.owner.runent.origin);
    setmodel (self, "progs/v_spike.mdl");

    self.touch = Ball_Touch;
    self.velocity_x = crandom() * 200;
    self.velocity_y = crandom() * 200;

    self.avelocity_x = crandom() * 360;
    self.avelocity_y = crandom() * 360;
    self.avelocity_z = crandom() * 360;

    self.flags = self.flags - (self.flags & FL_ONGROUND);
};

//For the final balls
void (vector org, entity master) Ball_Spawn =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_BOUNCE;
    temp.solid = SOLID_TRIGGER;
    temp.owner = master;
    setorigin (temp, self.origin);
    setsize (temp, '-15 -15 -15', '15 15 15');
    setmodel (temp, "progs/v_spike.mdl");
    temp.avelocity_x = crandom() * 360;
    temp.avelocity_y = crandom() * 360;
    temp.avelocity_z = crandom() * 360;
    temp.velocity_x = crandom() * 200;
    temp.velocity_y = crandom() * 200;
    temp.classname = "spikeball";
    temp.touch = Ball_Touch2;
    temp.think = SUB_Remove;
    temp.nextthink = time + 1 + random() * 2;

    if (master.health < 1)
    {
        temp.velocity_z = crandom() * 700;
        temp.nextthink = temp.nextthink + 8;
    }
};

//For the normal balls
void() Balls_Spawn =
{
    local entity temp;
    local float n;

    n = 0;

    while (n <= 3)
    {
        n = n + 0.3;

        temp = spawn();
        temp.movetype = MOVETYPE_BOUNCE;
        temp.solid = SOLID_TRIGGER;
        temp.owner = self;
        setorigin (temp, self.runent.origin);
        setsize (temp, '-15 -15 -15', '15 15 15');
        setmodel (temp, "progs/v_spike.mdl");

        temp.flags = temp.flags - (temp.flags & FL_ONGROUND);

        temp.avelocity_x = crandom() * 360;
        temp.avelocity_y = crandom() * 360;
        temp.avelocity_z = crandom() * 360;
        temp.velocity_x = crandom() * 200;
        temp.velocity_y = crandom() * 200;
        temp.classname = "spikeball";
        temp.touch = Ball_Touch;
        temp.think = Ball_Move;
        temp.nextthink = time + n;
    }
};

void() Cloud_Bye =
{
    local float n;

    n = 0;

    while (n < 15)
    {
        Ball_Spawn (self.origin, self.owner);
        n = n + 1;
    }

    WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
    WriteByte (MSG_BROADCAST, TE_TAREXPLOSION);
    WriteCoord (MSG_BROADCAST, self.origin_x);
    WriteCoord (MSG_BROADCAST, self.origin_y);
    WriteCoord (MSG_BROADCAST, self.origin_z);

    remove (self);
};


void() Cloud_Think =
{
    if (self.owner.health < 1 || self.owner.runetype != RN_CLOUD)
    {
        self.think = Cloud_Bye;
        self.nextthink = time + 2;
        self.avelocity = '0 0 0';

        if (self.owner.health > 0)
        {
            remove (self);
        }

        return;
    }

    setorigin (self, self.owner.origin + '0 0 60');
    self.nextthink = time;
};

void() Cloud_Spawn =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_NOT;
    temp.owner = self;
    setorigin (temp, self.origin);
    setsize (temp, '-50 -50 -50', '-50 -50 -50');
    setmodel (temp, "progs/teleport.mdl");
    temp.avelocity_x = crandom() * 360;
    temp.avelocity_y = crandom() * 360;
    temp.avelocity_z = crandom() * 360;
    temp.think = Cloud_Think;
    temp.nextthink = time;
    self.runent = temp;

    Balls_Spawn();
};

//predefs for the Shambler Helper
void() sham_stand1;
void() sham_walk1;
void() sham_run1;
void() sham_die;
void() sham_melee;
void() sham_magic1;
void (entity attacker, float damage) sham_pain;
void() walkmonster_start;

void() Rune_ShamblerDie =
{
    remove (self);
    remove (self.runent);
};

void() Rune_ShamblerReloc =
{
    spawn_tfog (self.runent.origin);
    setorigin (self.runent, self.origin);
    spawn_tfog (self.runent.origin);
    self.runent.angles = self.angles;
    self.runent.fixangle = 1;
};

void() Rune_ShamblerThink =
{
    if (self.owner.runetype != RN_SHAMB || self.owner.health < 1)
    {
        if (self.owner.health < 1)
        {
            self.runent.health = 0;
            Killed (self.runent, self.owner);
            self.think = Rune_ShamblerDie;
            self.nextthink = time + 2;
        }
        else
        {
            spawn_tfog (self.runent.origin);
            remove (self.runent);
            return;
        }

        return;
    }

    //The end to passive shamblers
    if (self.runent.enemy == self.runent.owner ||
            self.runent.enemy.health < 1 ||
            self.runent.enemy.classname == "worldspawn")
    {
        local entity head, selected;
        local float dist;

        dist = 2000;

        selected = world;
        head = findradius (self.runent.origin, dist);

        while (head)
        {
            if ((head.health > 0) && (head != self.runent))
            {
                traceline (self.runent.origin, head.origin, TRUE, self.runent);

                if ((trace_fraction >= 1) && (vlen (head.origin - self.runent.origin) < dist) )
                {
                    selected = head;

                    if (selected != world && selected != self.runent.owner)
                    {
                        self.runent.enemy = selected;
                    }
                }
            }

            head = head.chain;
        }

    }

    self.nextthink = time + 0.5;
};

void() Rune_ShamblerSpawn =
{
    local entity sham;
    local entity temp;
    local entity shamctrl;

    sham = spawn();
    sham.solid = SOLID_SLIDEBOX;
    sham.movetype = MOVETYPE_STEP;
    setmodel (sham, "progs/shambler.mdl");
    setorigin (sham, self.origin);
    setsize (sham, VEC_HULL2_MIN, VEC_HULL2_MAX);
    sham.angles = self.angles;
    sham.fixangle = 1;
    sham.health = 400;
    sham.flags = sham.flags | FL_MONSTER;
    sham.th_stand = sham_stand1;
    sham.th_walk = sham_walk1;
    sham.th_run = sham_run1;
    sham.th_die = sham_die;
    sham.th_melee = sham_melee;
    sham.th_missile = sham_magic1;
    sham.th_pain = sham_pain;
    sham.classname = "shambler_slave";
    self.runent = sham;
    sham.owner = self;

    temp = self;
    self = sham;
    walkmonster_start();
    self = temp;
    spawn_tfog (self.runent.origin);

    shamctrl = spawn();
    shamctrl.solid = SOLID_NOT;
    shamctrl.movetype = MOVETYPE_FLY;
    setorigin (shamctrl, self.origin);
    setsize (shamctrl, '0 0 0', '0 0 0');
    shamctrl.classname = "shambler_control";
    shamctrl.owner = self;
    shamctrl.runent = sham;
    shamctrl.nextthink = time + 1;
    shamctrl.think = Rune_ShamblerThink;
};

void() Rune_Dual =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 0.1;

    local vector tempv;

    spawn_tfog (self.origin);
    tempv = self.origin;
    spawn_tdeath (self.runevector, self);
    setorigin (self, self.runevector);
    self.runevector = tempv;
    spawn_tfog (self.origin);
    self.velocity = '0 0 0';
};

void() Weird_WanderThink =
{
    if (self.runetime < time)
    {
        remove (self);
        return;
    }

    self.velocity_x = self.velocity_x + crandom() * 30;
    self.velocity_y = self.velocity_y + crandom() * 30;
    self.velocity_z = self.velocity_z + crandom() * 30;

    self.flags = self.flags - (self.flags & FL_ONGROUND);

    self.nextthink = time + 0.5;
};

void() Weird_Think =
{
    //Remove the weirder
    if (self.runent.health < 1 || self.runetime < time || intermission_running)
    {
        if (self.runevar == 1)
        {
            stuffcmd (self.runent, "v_idlescale 0\n");
        }

        if (self.runevar == 9)
        {
            stuffcmd (self.runent, "fov 90\n");
        }

        if (self.runevar == 10)
        {
            stuffcmd (self.runent, "v_cshift 0 0 0 0\n");
        }

        self.runent.punchangle = '0 0 0';
        remove (self);
        return;
    }

    self.nextthink = time + 0.1;

    particle (self.runent.origin + '0 0 25', '0 0 1'*crandom() * 500 + '0 1 0'*crandom() * 500 + '1 0 0'*crandom() * 500, random() * 255, 30);

    //The weirdness factors
    if (self.runevar == 1)
    {
        if (self.attack_finished > time)
        {
            return;
        }

        self.attack_finished = time + 0.5;
        stuffcmd (self.runent, "v_idlescale 120\n");
    }
    else if (self.runevar == 2)
    {
        if (self.attack_finished > time)
        {
            return;
        }

        if (self.runent.flags & FL_ONGROUND)
        {
            self.runent.flags = self.runent.flags - FL_ONGROUND;
            sound (self.runent, CHAN_BODY, "player/plyrjmp8.wav", 1, ATTN_NORM);
            self.runent.velocity_z = self.runent.velocity_z + 270;
            self.attack_finished = time + 0.1;
        }
    }
    else if (self.runevar == 3)
    {
        if (self.attack_finished > time)
        {
            return;
        }

        self.attack_finished = time + 0.5;
        self.runent.angles_y = self.runent.angles_y + crandom() * 40;
        self.runent.fixangle = 1;
    }
    else if (self.runevar == 4)
    {
        self.runent.punchangle_z = self.runent.punchangle_z - 5;
        return;
    }
    else if (self.runevar == 5)
    {
        if (random() > 0.3)
        {
            self.runent.velocity_x = self.runent.velocity_x + crandom() * 200;
            self.runent.velocity_y = self.runent.velocity_y + crandom() * 200;
            self.runent.velocity_z = self.runent.velocity_z + crandom() * 200;

            self.runent.flags = self.runent.flags - (self.runent.flags & FL_ONGROUND);
        }
    }
    else if (self.runevar == 6)
    {
        self.runent.velocity = self.runent.velocity * 2;
    }
    else if (self.runevar == 7)
    {
        self.runent.velocity = self.runent.velocity * -1;
    }
    else if (self.runevar == 8)
    {
        self.runent.attack_finished = time + 0.5;
    }
    else if (self.runevar == 9)
    {
        if (self.attack_finished > time)
        {
            return;
        }

        self.attack_finished = time + 0.5;
        stuffcmd (self.runent, "fov 160\n");
    }

    if (self.runevar == 10)
    {
        if (self.attack_finished > time)
        {
            return;
        }

        self.attack_finished = time + 0.5;
        stuffcmd (self.runent, "v_cshift 256 256 256 200\n");
    }
};

void() Weird_Touch =
{
    if (other == world || other.solid == SOLID_BSP)
    {
        self.velocity = self.velocity * -1;
        return;
    }

    if (other.classname == "player" && other.health > 0)
    {
        if (other == self.owner)
        {
            return;
        }

        self.runent = other;
        self.runetime = time + 15;
        self.touch = SUB_Null;
        self.think = Weird_Think;
        self.nextthink = time;
        self.runevar = ceil (random() * 10);
        setmodel (self, "");

        sound (self, CHAN_BODY, "boss2/idle.wav", 1, ATTN_NORM);

        if (self.runevar == 1)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nSHROOM MODE!");
        }

        if (self.runevar == 2)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nUNCONTROLLABLE JUMPING!");
        }

        if (self.runevar == 3)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nDRUNKEN WALK!");
        }

        if (self.runevar == 4)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nTWIRLY HEAD!");
        }

        if (self.runevar == 5)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nRANDOM TWITCHING!");
        }

        if (self.runevar == 6)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nTOO MUCH COFFEE!");
        }

        if (self.runevar == 7)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nSTICKY FEET!");
        }

        if (self.runevar == 8)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nHOW DO I SHOOT?!");
        }

        if (self.runevar == 9)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nVERTIGO!");
        }

        if (self.runevar == 10)
        {
            centerprint (other, " Hit by weirdness! \nžžžžžžžžžžžžžžžžžžžžŸ\nI'M BLIND! I'M BLIND!");
        }
    }
};

void() Spawn_Weird =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_TRIGGER;
    temp.owner = self;
    setorigin   (temp, self.origin + '0 0 15');
    setsize     (temp, '0 0 0', '0 0 0');
    setmodel    (temp, "progs/s_bubble.spr");
    temp.think = Weird_WanderThink;
    temp.touch = Weird_Touch;
    temp.nextthink = time;
    temp.runetime = time + 4 + random() * 3;
    self.runent = temp;
};

void() Rune_Weird =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 2.5;

    Spawn_Weird();

    self.runent.flags = self.runent.flags - (self.runent.flags & FL_ONGROUND);
};

void() Weird_Throw =
{
    if (self.runevar > time)
    {
        return;
    }

    self.runevar = time + 1;
    self.runetime = time + 2;

    Spawn_Weird();

    makevectors (self.v_angle);
    self.runent.velocity = v_forward * 150 + self.velocity;
};

void() Resurrect =
{
    local string num;

    self.runevar = self.runevar - 1;

    self.classname = "player";
    self.max_health = 100;
    self.health = 100;
    self.takedamage = DAMAGE_AIM;
    self.solid = SOLID_SLIDEBOX;
    self.movetype = MOVETYPE_WALK;
    self.show_hostile = 0;
    self.flags = FL_CLIENT;
    self.air_finished = time + 12;
    self.dmg = 2;
    self.super_damage_finished = time + 15;
    self.radsuit_finished = 0;
    self.invisible_finished = 0;
    self.invincible_finished = 0;
    self.effects = EF_DIMLIGHT;
    self.invincible_time = 0;
    self.items = self.items | IT_QUAD;

    self.weapon = W_BestWeapon();
    W_SetCurrentAmmo ();

    setorigin (self, self.origin + '0 0 40');

    if (pointcontents (self.origin) == CONTENT_LAVA)
    {
        local entity startent;
        startent = SelectSpawnPoint();
        setorigin (self, startent.origin);
    }

    self.attack_finished = time;
    self.th_pain = player_pain;
    self.th_die = PlayerDie;

    self.deadflag = DEAD_NO;
    self.pausetime = 0;

    self.modelindex = modelindex_player;

    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

    self.view_ofs = '0 0 22';

    player_stand1 ();

    spawn_tdeath (self.origin, self);

    self.ammo_shells = self.ammo_shells + 25;

    if (self.ammo_shells > 100)
    {
        self.ammo_shells = 100;
    }

    centerprint (self, "You've risen again!");

    sound (self, CHAN_AUTO, "misc/power.wav", 1, ATTN_NORM);

    ThrowGib ("progs/gib1.mdl", (0 - self.health));
    ThrowGib ("progs/gib2.mdl", (0 - self.health));
    ThrowGib ("progs/gib3.mdl", (0 - self.health));

    sprint (self, "You got the Quad Damage\n");
    num = ftos (self.runevar);
    sprint (self, num);
    sprint (self, " resurrections left.\n");
};

void() Berserk_Bleed =
{
    if (self.runevar > time)
    {
        return;
    }

    self.runevar = time + 0.2;

    local float r1, r2;
    r1 = crandom() * 50;
    r2 = crandom() * 50;
    makevectors (self.angles);
    SpawnBlood (self.origin + '0 0 15', (v_right * r1 + v_forward * r2 - '0 0 15'), 30);

    self.punchangle_x = crandom() * 2;
    self.punchangle_y = crandom() * 2;
    self.punchangle_z = crandom() * 2;
};

void() Wall_Check =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 0.2;

    makevectors (self.v_angle);
    traceline (self.origin, self.origin + v_forward * 35, TRUE, self);

    if (trace_fraction == 1)
    {
        return;
    }

    local float n;
    local vector neworg, oldorg;

    n = 36;

    while (n < 400 && (pointcontents (self.origin + v_forward * n) != CONTENT_EMPTY))
    {
        n = n + 60;
    }

    if (n >= 500)
    {
        return;
    }

    neworg = self.origin + v_forward * (n + 45);
    oldorg = self.origin;

    if (pointcontents (neworg) != CONTENT_EMPTY)
    {
        return;
    }

    setorigin (self, neworg);
};


void () Rune_Ghost_Think =
{
    // Release conditions:
    //  * Owner has disowned us / hit the button.
    //  * Owner somehow lost the rune  (suicide or disconnect???)
    //  * Owner has died.
    //  * Grabee has died.
    //  * Grabee's egongrabber points back to world
    //      (indicates sudden respawn, still allows multi grabbers.
    //          Make big assumption that egongrabber ONLY gets reset during respawn.
    //          We can try to fix this by chaining the Egon controllers when grabbing the same entity.)
    if (self.owner.runent != self ||
            self.owner.runetype != RN_GHOST ||
            self.owner.health < 1 ||
            self.runent.health < 1 ||
            self.runent.egongrabber == world)
    {
        if (self.owner.runent == self)
        {
            self.owner.runent = world;
        }
        self.runent.effects = self.runent.effects - (self.runent.effects & EF_BRIGHTFIELD);
        remove (self);
    }
    else
    {
        setorigin (self, self.owner.origin + '0 0 16');
        self.nextthink = time;

        if (self.runetime <= time)
        {
            local vector place;

            self.runent.flags = self.runent.flags - (self.runent.flags & FL_ONGROUND);

            makevectors (self.owner.v_angle);
            place = self.origin + v_forward * self.runevar;

            self.runent.velocity = (place - self.runevector) * 5.0;
            self.runevector = self.runent.origin;

            //This keeps the grabee from firing.
            //self.runent.attack_finished = time + 1;

            // The update interval of this rune is controlled here.  For now, update every time.
            self.runetime = time;

            WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
            WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
            WriteEntity (MSG_BROADCAST, self.owner);
            WriteCoord (MSG_BROADCAST, self.origin_x);
            WriteCoord (MSG_BROADCAST, self.origin_y);
            WriteCoord (MSG_BROADCAST, self.origin_z);
            WriteCoord (MSG_BROADCAST, self.runevector_x);
            WriteCoord (MSG_BROADCAST, self.runevector_y);
            WriteCoord (MSG_BROADCAST, self.runevector_z);

            //bprint ("Holding ");
            //bprint (self.runent.classname);
            //bprint ("\n");
        }
    }
};

void () Rune_Ghost_Button =
{
    local entity grabee;
    local entity controller;
    local vector org;

    //bprint ("Button Hit!\n");

    // Runent is points to the world if nothing is grabbed.  Otherwise it points to the Egon controller entity.
    //
    if (self.runent == world)
    {
        //bprint ("Searching...\n");
        makevectors (self.v_angle);
        org = self.origin + '0 0 16';
        traceline (org, org + v_forward * 1500.0, FALSE, self);
        grabee = trace_ent;

        if (
            grabee.solid     != SOLID_BSP &&
            grabee.solid     != SOLID_TRIGGER &&
            grabee.classname != "trigger_once" &&
            grabee           != world)
        {
            controller = spawn ();
            controller.movetype = MOVETYPE_FLY;
            controller.solid = SOLID_NOT;
            controller.owner = self;
            controller.think = Rune_Ghost_Think;
            controller.nextthink = time;

            setorigin   (controller, self.origin);
            setsize     (controller, '0 0 0', '0 0 0');
            setmodel    (controller, "");

            controller.runent = grabee;
            controller.runevector = grabee.origin;
            controller.runetime = time;
            controller.runevar = vlen (trace_endpos - org) + 18.0;

            grabee.effects = grabee.effects | EF_BRIGHTFIELD;
            grabee.egongrabber = self;

            self.runent = controller;

            //bprint ("Grabbing ");
            //bprint (grabee.classname);
            //bprint ("\n");
            //eprint (grabee);
        }

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
        WriteEntity (MSG_BROADCAST, self);
        WriteCoord (MSG_BROADCAST, org_x);
        WriteCoord (MSG_BROADCAST, org_y);
        WriteCoord (MSG_BROADCAST, org_z);
        WriteCoord (MSG_BROADCAST, trace_endpos_x);
        WriteCoord (MSG_BROADCAST, trace_endpos_y);
        WriteCoord (MSG_BROADCAST, trace_endpos_z);
    }
    else
    {

        //bprint ("Releasing ");
        //bprint (self.runent.classname);
        //bprint ("\n");

        self.runent = world;
    }

    //	bprint ("Finished.\n");

};

void() HauntHead_Think =
{
    if (self.owner.health < 1 ||
            ! (self.owner.runetype == RN_HEAD && self.owner.runevar == 1))
    {
        remove (self);
        return;
    }

    makevectors (self.owner.v_angle);
    //setorigin(self, self.owner.origin + v_up*20 - v_right*1 - v_forward*10);
    setorigin(self, self.owner.origin - v_right*3 - v_forward*9);   // Emperical

    self.nextthink = time;

    self.angles_x = -self.owner.v_angle_x - 60;
    self.angles_y =  self.owner.v_angle_y + 0.9283447;  // Emperical + printing ent angles
    self.angles_z =  self.owner.v_angle_z;
    self.fixangle = TRUE;
};


void() HauntHead_Spawn =
{
    local entity temp;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_NOT;
    temp.owner = self;
    setorigin (temp, self.origin);
    setsize (temp, '0 0 0', '0 0 0');
    setmodel (temp, "progs/h_player.mdl");
    temp.think = HauntHead_Think;
    temp.nextthink = time;
    temp.angles = self.angles;
    temp.colormap = self.colormap;
    self.runent = temp;
};

void () Rune_Head_Button =
{
    if (self.runevar == 0)
    {
        self.runetime = self.modelindex;
        setmodel (self, "");
        self.modelindex = modelindex_none;
        //setsize (self, '-10 -10 -10', '10 10 10');
        setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
        self.runevar = 1;
        self.head_saved_weapon = self.weapon;
        self.weapon = 0;
        self.movetype = MOVETYPE_FLY;
        self.weaponmodel = "";
        HauntHead_Spawn ();
        centerprint (self, "You became a Haunted Head!\n");
    }
    else
    {
        setmodel (self, "progs/player.mdl");
        self.modelindex = self.runetime;
        setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
        self.runevar = 0;
        self.weapon = self.head_saved_weapon;
        self.head_saved_weapon = 0;
        self.movetype = MOVETYPE_WALK;

        centerprint (self, "You are normal again.\n");
        W_SetCurrentAmmo ();
    }
};


void () Rune_Head_Float =
{
    if (self.runevar == 1)
    {
        Rune_Fly ();
    }
};

void (vector bite_dir) Rune_Head_Bite =
{
    local vector des;

    des = self.origin + bite_dir * 30;
    traceline (self.origin, des, FALSE, self);

    if (trace_ent.solid != SOLID_BSP)
    {
        //chomp sound
        //centerprint (self, "CHOMP!!\n");
        sound (self, CHAN_WEAPON, "shambler/smack.wav", 1, ATTN_NORM);
        T_Damage (trace_ent, self, self, 50);
    }
    else
    {
        //centerprint (self, "bite!\n");
        //gnashing sound
        sound (self, CHAN_WEAPON, "knight/idle.wav", 1, ATTN_NORM);
    }

};
