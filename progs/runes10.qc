
//Artifact Quake
//Runes code #1-10
//(C) 1997 Nick "Singe" Bousman
//Give me credit if you modify it. I worked hard on it.

void() Haste_Sound =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 2;
    sound (self, CHAN_AUTO, "boss1/sight1.wav", 1, ATTN_NORM);
};

void() Rune_Enviro =
{
    if (self.watertype == CONTENT_WATER)
    {
        if (self.runetime < time && self.air_finished < time)
        {
            self.runetime = time + 1;

            if (self.health < self.max_health)
            {
                self.health = self.health + 5;
                sound (self, CHAN_AUTO, "items/r_item1.wav", 1, ATTN_NORM);
            }
        }
    }

    if (self.watertype == CONTENT_LAVA)
    {
        if (self.runetime < time)
        {
            self.runetime = time + 0.2;

            if (self.health < self.max_health)
            {
                self.health = self.health + 3 * self.waterlevel;
                sound (self, CHAN_AUTO, "player/inlava.wav", 1, ATTN_NORM);
            }
        }
    }

    if (self.watertype == CONTENT_SLIME)
    {
        if (self.runetime < time && self.radsuit_finished < time)
        {
            self.runetime = time + 0.8;

            if (self.health < self.max_health)
            {
                self.health = self.health + 3 * self.waterlevel;
                sound (self, CHAN_AUTO, "player/slimbrn2.wav", 1, ATTN_NORM);
            }
        }
    }

    if (self.health > self.max_health)
    {
        self.health = self.max_health;
    }
};

void() Enviro_Jump =
{
    makevectors (self.angles);

    if (self.watertype == CONTENT_LAVA)
    {
        self.velocity_z = 700;
        self.velocity = self.velocity + v_forward * 500;
        sound (self, CHAN_AUTO, "doors/airdoor2.wav", 1, ATTN_NORM);
    }

    if (self.watertype == CONTENT_SLIME)
    {
        self.velocity_z = 500;
        self.velocity = self.velocity + v_forward * 500;
        sound (self, CHAN_AUTO, "doors/airdoor2.wav", 1, ATTN_NORM);
    }

    if (self.watertype == CONTENT_WATER)
    {
        self.velocity_z = 500;
        self.velocity = self.velocity + v_forward * 500;
        sound (self, CHAN_AUTO, "doors/airdoor2.wav", 1, ATTN_NORM);
    }
};

void() Rune_Regen =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 0.5;

    if (self.armorvalue < 100 && self.armortype != 0)
    {
        self.armorvalue = self.armorvalue + 5;
    }

    if (self.health < self.max_health)
    {
        self.health = self.health + 5;
        sound (self, CHAN_AUTO, "items/r_item1.wav", 1, ATTN_NORM);
    }
};

void() Rune_Fly =
{
    if (pointcontents (self.origin) != CONTENT_EMPTY)
    {
        if (pointcontents (self.origin) != CONTENT_SOLID)
        {
            self.waterlevel = 3;
            self.watertype = pointcontents (self.origin);
            self.flags = self.flags | FL_INWATER;
        }
    }
    else
    {
        if (self.waterlevel == 3)
        {
            if (pointcontents (self.origin) == CONTENT_EMPTY)
            {
                self.waterlevel = 0;
                self.flags = self.flags - FL_INWATER;
            }
        }
    }

    self.flags = self.flags | FL_ONGROUND;

    local float invcos, nvp, nvpmax, sp, svz;
    local vector f, vp, vs;

    svz = self.velocity_z * 0.75;
    self.velocity_z = 0;

    makevectors (self.v_angle);

    // v_forward is already normalized
    f_x = v_forward_x;
    f_y = v_forward_y;
    f_z = 0;
    invcos = vlen (f);

    if (invcos)
    {
        invcos = 1 / invcos;
    }
    else
    {
        invcos = 0;
    }
    f = f * invcos; // normalize f

    sp = f * self.velocity;
    vp = sp * f;
    nvp = vlen (vp);

    if (sp < 0)
    {
        nvp = nvp * (-1);
    }

    vs = self.velocity - vp;

    vp = v_forward * (nvp * invcos);
    vp_z = vp_z + svz;
    nvp = vlen (vp);
    nvpmax = (320 - 100 * (v_forward * '0 0 1'));

    if (nvp > nvpmax)
    {
        vp = vp * (nvpmax / nvp);
    }

    self.velocity = vp + vs;
};

void() GFire_Touch =
{
    if (other.takedamage != DAMAGE_AIM)
    {
        return;
    }

    if (other == self.owner)
    {
        return;
    }

    if (other.solid == SOLID_BSP)
    {
        return;
    }

    if (other.health < 1)
    {
        return;
    }

    T_Damage (other, self, self.owner, 25);

    remove (self);
};

void() GFire_Spawn =
{
    if (self.velocity == '0 0 0')
    {
        return;
    }

    if (! (self.flags & FL_ONGROUND))
    {
        return;
    }

    if (self.waterlevel > 0)
    {
        return;
    }

    local entity fire;

    fire = spawn();


    setorigin (fire, self.origin - '0 0 10');
    setmodel (fire, "progs/flame2.mdl");

    fire.movetype = MOVETYPE_FLY;
    fire.solid = SOLID_TRIGGER;

    setsize (fire, '-17 -17 -10', '17 17 22');

    fire.classname = "gfire";
    fire.owner = self;

    fire.touch = GFire_Touch;
    fire.nextthink = time + 1.5;
    fire.think = SUB_Remove;

    fire.angles_y = crandom() * 360;

    if (random() > 0.5)
    {
        sound (fire, CHAN_AUTO, "hknight/hit.wav", 1, ATTN_NORM);
        fire.frame = 1;
    }
    else {
        sound (fire, CHAN_AUTO, "weapons/ax1.wav", 1, ATTN_NORM);
        fire.frame = 0;
    }
};

void() Rune_Firewalk =
{
    if (self.runetime > time)
    {
        return;
    }

    self.runetime = time + 0.1;

    GFire_Spawn();
};

void() Rune_Recall =
{
    if (self.runevar == 1)
    {
        self.runevector = self.origin;
        self.runevar = 0;
        centerprint (self, "Recall point set.");
        return;
    }

    if (self.origin == self.runevector)
    {
        self.runevar = 1;
        centerprint (self, "Recall point erased.");
        return;
    }

    spawn_tfog (self.origin);
    spawn_tdeath (self.runevector, self);
    setorigin (self, self.runevector);
    spawn_tfog (self.origin);
    self.velocity = '0 0 0';
};

void() Rune_Zap =
{
    local entity head, selected;
    local float dist;

    if (self.ammo_cells < 1)
    {
        return;
    }

    if (self.runetime > time)
    {
        return;
    }

    if ((random() * 100) > 60)
    {
        self.effects = self.effects | EF_MUZZLEFLASH;
    }

    self.runetime = time + 0.3;
    dist = 200;

    if (pointcontents (self.origin) != CONTENT_EMPTY)
    {
        return;
    }

    selected = world;
    head = findradius (self.origin, dist);

    while (head)
    {
        if ((head.health > 0) && head != self && head.takedamage == DAMAGE_AIM)
        {
            traceline (self.origin, head.origin, TRUE, self);

            if ((trace_fraction >= 1) && (vlen (head.origin - self.origin) < dist) )
            {
                selected = head;
                dist = vlen (head.origin - self.origin);
            }
        }

        head = head.chain;
    }

    if (selected != world && selected.runetype != RN_ENVIRO)
    {
        self.ammo_cells = self.ammo_cells - 1;

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);

        if (random() * 100 > 50)
        {
            WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
        }
        else
        {
            WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
        }

        WriteEntity (MSG_BROADCAST, self);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z + 20);
        WriteCoord (MSG_BROADCAST, selected.origin_x);
        WriteCoord (MSG_BROADCAST, selected.origin_y);
        WriteCoord (MSG_BROADCAST, selected.origin_z);
        sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);

        self.runevar = 10;
        LightningDamage (self.origin, selected.origin, self, 20);
        self.runevar = 0;

        self.effects = self.effects | EF_MUZZLEFLASH;
    }
};

void() Zap_Think =
{
    if (self.owner.health < 1 || self.owner.runetype != RN_ZAP)
    {
        remove (self);
        return;
    }

    setorigin (self, self.owner.origin + '0 0 20');
    self.nextthink = time;

    if (self.owner.ammo_cells < 1)
    {
        self.angles = '90 0 0';
        return;
    }

    self.angles_x = crandom() * 360;
    self.angles_y = crandom() * 360;
    self.angles_z = crandom() * 360;
};

void() Zap_Spawn =
{
    local entity temp;

    self.ammo_cells = self.ammo_cells + 10;

    temp = spawn();
    temp.movetype = MOVETYPE_FLY;
    temp.solid = SOLID_NOT;
    temp.owner = self;
    setorigin (temp, self.origin);
    setsize (temp, '0 0 0', '0 0 0');
    setmodel (temp, "progs/bolt2.mdl");
    temp.angles = '-90 0 0';
    temp.think = Zap_Think;
    temp.nextthink = time;
    self.runent = temp;
    self.runevar = 0;
};

void() Rune_Cloak =
{
    if (self.runevar < 1 && self.runetime < time)
    {
        stuffcmd (self, "v_cshift 0 0 0 120\n");
        sound (self, CHAN_AUTO, "items/inv1.wav", 1, ATTN_NORM);
        sprint (self, "ç Cloaked.\n");
        self.runevar = 1;
    }

    if (self.runevar > 0 && self.runetime > time)
    {
        stuffcmd (self, "v_cshift 0 0 0 0\n");
        sound (self, CHAN_AUTO, "misc/r_tele4.wav", 1, ATTN_NORM);
        sprint (self, "ç Uncloaked.\n");
        self.runevar = 0;
    }
};

