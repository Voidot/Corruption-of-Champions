/**
 * ...
 * @author Ormael
 */
package classes.Items
{
	import classes.Items.WeaponsRange.*;
	import classes.PerkLib;
	import classes.PerkType;

	public final class WeaponRangeLib
	{
		public static const DEFAULT_VALUE:Number = 6;	//cena dla broni dyst bazowa to 50 gems a nie 40 gems
		public static const NOTHING:WeaponRange = new Nothing();	//cena broni palnych to: (wart atk * 20) + (ilość naboi w magazynku * 30)
		//pump action shotgun, Lawgiver (wzorowany na broni z Judge Dreed xD), x
		public const ADBSCAT:WeaponRangeWithPerk = new WeaponRangeWithPerk("DBScatt", "A.D.B.Scattergun", "antique double barrel scattergun", "an antique double barrel scattergun", "shot", 28, 920, "This is a double barrel scattergun. It's effective at short range but poor at long range. When fighting multiple enemies it bullet splitting after leaving muzzle cause to deal a bit more damage to enemies.", "Rifle",
				PerkLib.Accuracy2,60,0,0,0);
		public const ADBSHOT:WeaponRangeWithPerk = new WeaponRangeWithPerk("DBShot", "A.D.B.Shotgun", "antique double barrel shotgun", "an antique double barrel shotgun", "shot", 26, 880, "This is a double barrel shotgun. It slug not fracture on many fragmetns after leaving muzzle but it's still not the most accurate weapon. Which it make up by high damage of each slug.", "Rifle",
				PerkLib.Accuracy2,20,0,0,0);
		public const ARTEMIS:Artemis = new Artemis();
		public const AVELYNN:WeaponRangeWithPerk = new WeaponRangeWithPerk("Avelynn", "Avelynn", "Avelynn", "Avelynn", "shot", 40, 6000, "A marvel of goblin prehistory before the time the first firearms were created, Avelynn prototype 3.0 is designed with several chained mechanism in order to allow firing up to 3 bolts all at the same time. Despite being primitive by modern goblin design this exquisite tool of death does its job well.", "Crossbow",
				PerkLib.Accuracy1,60,0,0,0);
		public const BEA_BOW:BeautifulBow = new BeautifulBow();
		public const B_F_BOW:BFBow = new BFBow();
		public const BFXBOW_:WeaponRangeWithPerk = new WeaponRangeWithPerk("BFXBow", "BFXBow", "big fucking crossbow", "a big fucking crossbow", "shot", 60, 3000, "Big Fucking Crossbow - the best solution for a tiny e-pen complex at this side of the Mareth!", "Crossbow",
				PerkLib.Accuracy1,60,0,0,0);
		public const BLUNDER:WeaponRange = new WeaponRange("Blunder", "Blunderbuss", "blunderbuss rifle", "a blunderbuss rifle", "shot", 16, 590, "This is a blunderbuss rifle. It's effective at short range but poor at long range.", "Rifle");
		public const BOWGUID:WeaponRange = new WeaponRange("BowGuid", "BowGuided", "Guided bow", "a Guided bow", "shot", 6, 2400, "A bow ornemented with a small carving representing a target. It seems to never miss no mather how poorly you aim.", "Bow");
		public const BOWHODR:WeaponRangeWithPerk = new WeaponRangeWithPerk("BowHodr", "BowHodr", "Hodr's bow", "a Hodr's bow", "shot", 25, 3000, "Once was a frost giant wielding this bow and boasting to be the best hunter. To punish him Fera cursed him and his weapon rendering him permanently blind. Regardless, arrows drawn by this bow seems to seek out the eyes of its target.", "Bow",
				PerkLib.Accuracy2,10,0,0,0);
		public const BOWHUNT:WeaponRange = new WeaponRange("BowHunt", "BowHunt", "hunter bow", "a hunter bow", "shot", 10, 500, "This is a hunter bow. It allow to attain better accuracy of shooted arrows than long bow at the cost of slight lower damage.", "Bow");
		public const BOWKELT:WeaponRangeWithPerk = new WeaponRangeWithPerk("BowTain", "BowTain", "tainted bow", "a tainted bow", "shot", 30, 1500, "This bow is tainted by corruption in the past. It's quite effective at both short and long range. It balance helps uset to increase shooting accuracy quite a bit compared to other bows.", "Bow",
				PerkLib.Accuracy1,10,0,0,0);
		public const BOWLIGH:WeaponRangeWithPerk = new WeaponRangeWithPerk("BowLigh", "BowLigh", "light bow", "a light bow", "shot", 5, 250, "This is a light bow. It's average in every way.", "Bow",
				PerkLib.Accuracy2,40,0,0,0);
		public const BOWLONG:WeaponRangeWithPerk = new WeaponRangeWithPerk("BowLong", "BowLong", "longbow", "a longbow", "shot", 20, 1000, "This is a longbow. It allows to shoot arrows with greater speed dealing more damage at cost of slight lowered accuracy compared to hunter's bow.", "Bow",
				PerkLib.Accuracy2,30,0,0,0);
		public const BOWOLD_:WeaponRangeWithPerk = new WeaponRangeWithPerk("BowOld ", "BowOld ", "old bow", "an old bow", "shot", 1, 50, "This is an old bow. It's barely effective even at short range not to meantion it poor accuracy.", "Bow",
				PerkLib.Accuracy2,50,0,0,0);
		public const DUEL_P_:WeaponRangeWithPerk = new WeaponRangeWithPerk("DuelP", "DuelingP", "dueling pistol", "a dueling pistol", "shot", 20, 430, "A pistol for duels between gentelmen. Or just for shooting. Can shoot only once before it need reload.", "Pistol",
				PerkLib.Accuracy2,10,0,0,0);
		public const EVELYN_:WeaponRangeWithPerk = new WeaponRangeWithPerk("Evelyn", "Evelyn", "Evelyn", "Evelyn", "shot", 40, 6000, "A marvel of goblin prehistory before the time the first firearms were created, Avelynn prototype 3.0 is designed with several chained mechanism in order to allow firing up to 3 bolts all at the same time. Despite being primitive by modern goblin design this exquisite tool of death does its job well.", "Crossbow",
				PerkLib.Accuracy1,60,0,0,0);
		public const FLINTLK:WeaponRange = new WeaponRange("Flintlk", "Flintlock", "flintlock pistol", "a flintlock pistol", "shot", 14, 310, "A flintlock pistol. Pew pew pew. Can fire once before a reload is required.", "Pistol");
		public const GTHRAXE:WeaponRange = new WeaponRange("GThrAxe", "GThrowAxes", "gnoll throwing axes", "a gnoll throwing axes", "shot", 25, 1250, "A set of throwing axes made and used by the gnoll barbarian, they are actually heavier than standard throwing weapon but all the more effective. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const GTHRSPE:WeaponRange = new WeaponRange("GThrSpe", "GThrowSpear", "gnoll throwing spear", "a gnoll throwing spear", "shot", 18, 900, "A standard javelin for ranged combat made by the gnolls. You can carry up to 20 on you and need to retrieve them after battles.", "Throwing");
		public const HEXBOW_:WeaponRangeWithPerk = new WeaponRangeWithPerk("HeXbow", "HeavyXbow", "heavy crossbow", "a heavy crossbow", "shot", 25, 1250, "This is a heavy crossbow. High penetrative power and good accuracy.", "Crossbow",
				PerkLib.Accuracy1,40,0,0,0);
		public const HUXBOW_:WeaponRangeWithPerk = new WeaponRangeWithPerk("HuXbow", "HuntXbow", "hunter crossbow", "a hunter crossbow", "shot", 15, 750, "This is a hunter crossbow. Slight better one with better accuracy and bolts penetrative power than light crossbow.", "Crossbow",
				PerkLib.Accuracy1,20,0,0,0);
		public const IVIARG_:WeaponRangeWithPerk = new WeaponRangeWithPerk("IvIArq", "Iv.I.Arq", "ivory inlaid arquebus", "an ivory inlaid arquebus", "shot", 24, 840, "Gifted with a superb range and accuracy, this arquebus is truly a piece of art. Its stock has a gold trim and is inlaid with ivory in a pattern of wreath leaves. A layer of gold and ivory also runs through the barrel, giving the rifle a majestic look without compromising its functionality.", "Rifle",
				PerkLib.Accuracy1,40,0,0,0);
		public const KSLHARP:KrakenSlayerHarpoons = new KrakenSlayerHarpoons();
		public const LCROSBW:WeaponRangeWithPerk = new WeaponRangeWithPerk("LCrosbw", "LCrossbow", "light crossbow", "a light crossbow", "shot", 5, 250, "This is a light crossbow. A most basic one that fires bolts at your enemies.", "Crossbow",
				PerkLib.Accuracy1,10,0,0,0);
		public const LEVHARP:LeviathanHarpoons = new LeviathanHarpoons();
		public const SHUNHAR:SeaHuntressHarpoons = new SeaHuntressHarpoons();
		public const TRJAVEL:WeaponRange = new WeaponRange("TrJavel", "Tra.Javelins", "training javelins", "a training javelins", "shot", 5, 250, "A standard training javelin for ranged combat. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const TRSXBOW:WeaponRangeWithPerk = new WeaponRangeWithPerk("TrSXBow", "Tra.S.Xbow", "training soul crossbow", "a training soul crossbow", "shot", 1, 50, "This crossbow was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal range weapon.", "Crossbow",
				PerkLib.Accuracy1,5,0,0,0);
		public const WARDBOW:Wardensbow = new Wardensbow();
		public const WILDHUN:WildHunt = new WildHunt();
		
		//Tomes
		public const I_TOME_:InquisitorsTome = new InquisitorsTome();
		public const SSKETCH:SagesSketchbook = new SagesSketchbook();
		
		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		*/
		public function WeaponRangeLib()
		{
		}
	}
}