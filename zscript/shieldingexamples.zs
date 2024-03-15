
Class ExampleShielding : PowerupGiver{
	Default{
		Inventory.MaxAmount 0;
		Inventory.PickupMessage "Example Suit Applied";
		Powerup.Color "RedMap", 0.15;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.FANCYPICKUPSOUND;
		Inventory.UseSound "pickups/slowmo";
		Powerup.Type "PowerExampleShielding";
		Powerup.Duration 0x7FFFFFFF;
	}
	States{Spawn:MEGA ABCD 4 Bright;Loop;}
}
//	This is designed similarly to Halo CE's MJOLNIR Mark V.
Class PowerExampleShielding : PowerShielding{
	Default{
		//	Permanent time. It will last indefinitely.
		Powerup.Duration 0x7FFFFFFF;
		//	Whether or not it recharges itself.
		PowerShielding.ShieldingRechargeable 1;
		//	Initial amount when first obtaining.
		PowerShielding.ShieldingAmount 75;
		//	Maximum shielding.
		PowerShielding.ShieldingMaxAmount 75;
		//	Delay after taking damage to begin recharging.
		PowerShielding.ShieldingRegenDelay 175;
		//	Rate at which the shielding recharges.
		//	A rate of 1 means it'll regen every tick.
		//	There are 35 ticks in a second.
		PowerShielding.ShieldingRegenRate 2;
		//	Amount it recharges.
		PowerShielding.ShieldingRegenAmount 1;
		//	Protection it grants. A value of 0.5 will halve damage taken when it's active.
		PowerShielding.ShieldingProtection 0.5;
		//	Same as above, except this is for when it's empty/deactivated.
		PowerShielding.SuitProtection 0.5;
		//	A collection of sounds to configure.
		PowerShielding.HitSound "shielding/hit";
		PowerShielding.SiphonSound "shielding/siphon";
		PowerShielding.LowSound "shielding/low";
		PowerShielding.DepletedSound "shielding/depleted";
		PowerShielding.ChargeSound "shielding/charge";
	}
}
Class ExampleDemonShielding : Demon{
	Override void PostBeginPlay(){
		//	Give the example suit to this Pinky when it spawns.
		A_GiveInventory("PowerExampleShielding",1);
	}
}
Class ExampleShieldingEventHandler : EventHandler{
	Override void WorldThingSpawned(WorldEvent e){
		//	Don't continue if it isn't a Thing.
		If(!e.Thing) return;
		//	If the Monster Shielding option is true..
		If(cvar.GetCVar('shielding_monstershielding').getbool()){GiveShielding(e.Thing);}
	}
	void GiveShielding(Actor mo){
		//	The 3 following lines are self-explanatory.
		bool isMonster = mo.bIsMonster;
		bool isBoss = mo.bBoss;
		If(isMonster){mo.A_GiveInventory("PowerExampleShielding",1);}
		//	This line gives shielding to a specific monster when spawned in.
		//If(mo is "Zombieman"){mo.A_GiveInventory("PowerExampleShielding",1);}
	}
}
