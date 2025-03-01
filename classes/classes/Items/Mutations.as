﻿package classes.Items
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumables.EmberTF;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.SceneLib;

public final class Mutations extends MutationsHelper
	{
		public function Mutations() {}

        public static const gooSkinColors:Array = ["green","purple","blue","cerulean","emerald"];
		public static const oniEyeColors:Array = ["red", "orange", "yellow", "green"];
// import classes.ItemSlotClass;

//const FOX_BAD_END_WARNING:int = 477;
//const TIMES_MET_CHICKEN_HARPY:int = 652;
//const EGGS_BOUGHT:int = 653;
//const BIKINI_ARMOR_BONUS:int = 769;

		public var emberTFchanges:EmberTF = new EmberTF();

		public function DrunkenPowerEmpower():void {
			var bonusempower:Number = 60;
			var bonusdepower:Number = 20;
			var durationhour:Number = 2;
			if (player.spe < 21 || player.inte < 21) {
				if (player.inte < 21) bonusdepower -= (player.inte - 1);
				else bonusdepower -= (player.spe - 1);
			}
			bonusempower += (20 * (1 + player.newGamePlusMod()));
			player.createStatusEffect(StatusEffects.DrunkenPower, durationhour, bonusempower, bonusdepower, 0);
			dynStats("str", player.statusEffectv2(StatusEffects.DrunkenPower));
			dynStats("spe", -player.statusEffectv3(StatusEffects.DrunkenPower));
			dynStats("inte", -player.statusEffectv3(StatusEffects.DrunkenPower));
			dynStats("lib", player.statusEffectv2(StatusEffects.DrunkenPower));
		}
		public function DrunkenPowerEmpowerOni():Number {
			var bonusempoweroni:Number = 12;
			if (player.hasPerk(PerkLib.OniMusculature)) bonusempoweroni -= 6;
			if (player.hasPerk(PerkLib.OniMusculatureEvolved)) bonusempoweroni -= 3;
			return bonusempoweroni;
		}

//ManUp Beer
		public function manUpBeer(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You open the can and “bottom up”, hoping it wasn’t just a scam to buy an overpriced beer. “Whoa, that’s one hell of a manly beverage!” The alcohol in the beer is so strong you actually feel like you could lift bigger things now. No...wait, you actually do as your muscle seems to surge with new raw power.");
			dynStats("str", 1 + rand(2));
			if (rand(3) == 0) outputText(player.modTone(player.maxToneCap(), 3));
			player.refillHunger(10);
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
		}

//Agility Elixir
		public function agilityElixir(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("The elixir tastes foul at first, but you guess it’s how it is with all medicine. As the merchant warned you, you begin to feel your muscles coiling like a spring, ready to allow you to make a swift dash. Your co-ordination definitively improved too, as well as your vision, as you can follow your movement despite the acceleration.");
			dynStats("spe", 1 + rand(2));
			if (rand(3) == 0) outputText(player.modTone(player.maxToneCap(), 3));
			player.refillHunger(5);
		}

		public function incenseOfInsight(player:Player):void
		{
			clearOutput();
			outputText("You use the incense and sit to meditate as the perfume of flowers and fruits fill the area. You see visions of things you could do and things you could’ve done good and bad, and when you open your eyes you realise you found new insight on your goals.");
			if (rand(3) == 0) outputText(player.modTone(15, 1));
			if (player.wis < 50) {
				player.wis += 1 + rand(4);
				dynStats();
			}
			else if (player.wis < 100) {
				player.wis += 1 + rand(3);
				dynStats();
			}
			else {
				player.wis += 1 + rand(2);
				dynStats();
			}
		}
/*
//Dao Dew
		public function daoDew(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("Following the merchant's instructions, you steep and drink the tea. Its sharp taste fires up your palate and in moments, you find yourself more alert and insightful. As your mind wanders, a creative, if somewhat sordid, story comes to mind. It is a shame that you do not have writing implements as you feel you could make a coin or two off what you have conceived. The strange seller was not lying about the power of the tea.");
			if (rand(3) == 0) outputText(player.modTone(10, 1));
			if (player.wis < 100) dynStats("wis", 2 + rand(4));
			else if (player.wis < 200) dynStats("wis", 2 + rand(3));
			else dynStats("wis", 2 + rand(2));
			player.refillHunger(10);
		}
*/
//Vixen Tea
		public function vixenTea(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You prepare the tea and drink it. It would seem that Ayane didn’t lie to you as a pink haze settle in your mind leaving you not only aroused but highly inspired. Images of sensual caresses and passionate lovemaking come and go in your head, making you blush yet smile in anticipation. You can’t wait to try what you learned.");
			if (rand(3) == 0) outputText(player.modTone(15, 1));
			if (player.lib < 50) dynStats("lib", 1 + rand(4));
			else if (player.lib < 100) dynStats("lib", 1 + rand(3));
			else dynStats("lib", 1 + rand(2));
			player.refillHunger(10);
		}
//Cold Fish Soup		
		public function coldFishSoup(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("As you eat the soup you shiver as your bodily temperature drop. Not only that but the last thing on your mind right now is sex as you feel yourself freezing from the inside. The cold crisis eventualy passes but you remain relatively less libidinous afterward.");
			dynStats("lus", -10);
			if (player.lib > 100) dynStats("lib", -(2 + rand(4)));
			else if (player.lib > 50) dynStats("lib", -(2 + rand(3)));
			else dynStats("lib", -(2 + rand(2)));
			player.refillHunger(15);
		}

//Airweed
		public function airweed(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You eat the seaweed. It should allow you to breathe safely underwater for a day.");
			if (player.hasStatusEffect(StatusEffects.Airweed)) {
				player.removeStatusEffect(StatusEffects.Airweed);
				player.createStatusEffect(StatusEffects.Airweed,24,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.Airweed,24,0,0,0);
		}

		public function purePearl(player:Player):void
		{
			clearOutput();
			outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your core.");
			dynStats("lib", -5, "lus", -25, "cor", -10);
			if (player.findPerk(PerkLib.PurityBlessing) < 0) player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
		}

		public function ezekielfruit(player:Player):void
		{
			clearOutput();
			outputText("You take first bite of fruit that Evangeline gave you.  Surprisingly it taste delicious as nothing else you tasted before so without thinking more you ate rest of the fruit.");
			if (player.findPerk(PerkLib.EzekielBlessing) < 0) player.createPerk(PerkLib.EzekielBlessing, 0, 0, 0, 0);
			statScreenRefresh();
			dynStats("str", 5, "tou", 5, "spe", 5, "inte", 5, "wis", 5, "lib", 5, "sen", 5);
			player.refillHunger(50);
		}

		public function smallangrypill(player:Player):void {
			clearOutput();
			outputText("You pop the small pill into your mouth and swallow. You feel bit more angry now. So would you kindly go and kill something now?\n\n(Gained wrath: 20)");
			player.wrath += 20;
			if (player.wrath > player.maxWrath()) player.wrath = player.maxWrath();
			statScreenRefresh();
		}
		public function mediumangrypill(player:Player):void {
			clearOutput();
			outputText("You pop the medium pill into your mouth and swallow. You feel bit more angry now. So would you kindly go and kill something now?\n\n(Gained wrath: 60)");
			player.wrath += 60;
			if (player.wrath > player.maxWrath()) player.wrath = player.maxWrath();
			statScreenRefresh();
		}
		public function bigangrypill(player:Player):void {
			clearOutput();
			outputText("You pop the big pill into your mouth and swallow. You feel bit more angry now. So would you kindly go and kill something now?\n\n(Gained wrath: 180)");
			player.wrath += 180;
			if (player.wrath > player.maxWrath()) player.wrath = player.maxWrath();
			statScreenRefresh();
		}
		
		public function mediumhealpill(player:Player):void {
			clearOutput();
			var rand:int = Math.random() * 100;
			outputText("You pop the medium pill into your mouth and swallow. ");
			if (player.HP < player.maxHP()) {
				HPChange((50 + player.tou) * 3, true);
				outputText("Some of your wounds are healed. ");
			}
			else outputText("You feel an odd sensation. ");
			if (rand < 70 && player.lib < 80) {
				outputText("You feel a sense of warmth spread through your erogenous areas.");
				dynStats("lib", 3);
			}
			if (rand >= 70 && rand <= 90) {
				outputText("Your body tingles and feels more sensitive.");
				dynStats("sens", 3);
			}
			if (rand > 90) {
				outputText("You shudder as a small orgasm passes through you. When you recover you actually feel more aroused.");
				dynStats("lus", 15);
			}
			statScreenRefresh();
		}
		public function bighealpill(player:Player):void {
			var rand:int = Math.random() * 100;
			outputText("You pop the big pill into your mouth and swallow. ");
			if (player.HP < player.maxHP()) {
				HPChange((50 + player.tou) * 9, true);
				outputText("Some of your wounds are healed. ");
			}
			else outputText("You feel an odd sensation. ");
			if (rand < 70 && player.lib < 120) {
				outputText("You feel a sense of warmth spread through your erogenous areas.");
				dynStats("lib", 9);
			}
			if (rand >= 70 && rand <= 90) {
				outputText("Your body tingles and feels more sensitive.");
				dynStats("sens", 9);
			}
			if (rand > 90) {
				outputText("You shudder as a small orgasm passes through you. When you recover you actually feel more aroused.");
				dynStats("lus", 45);
			}
			statScreenRefresh();
		}

		public function lowgradeelementalPearl(player:Player):void
		{
			clearOutput();
			outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a calming sensation of three steams of mystical energies spreading in your body.");
			if (player.findPerk(PerkLib.ElementalConjurerMindAndBodyResolve) < 0) player.createPerk(PerkLib.ElementalConjurerMindAndBodyResolve, 0, 0, 0, 0);
		}
		public function middlegradeelementalPearl(player:Player):void
		{
			clearOutput();
			outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a calming sensation of five steams of mystical energies spreading in your body.");
			if (player.findPerk(PerkLib.ElementalConjurerMindAndBodyDedication) < 0) player.createPerk(PerkLib.ElementalConjurerMindAndBodyDedication, 0, 0, 0, 0);
		}
		public function highgradeelementalPearl(player:Player):void
		{
			clearOutput();
			outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a calming sensation of seven steams of mystical energies spreading in your body.");
			if (player.findPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) < 0) player.createPerk(PerkLib.ElementalConjurerMindAndBodySacrifice, 0, 0, 0, 0);
		}

		public function bagofcosmos(player:Player):void
		{
			if (player.hasKeyItem("Bag of Cosmos") < 0) {
				clearOutput();
				outputText("You hang your bag of cosmos on your belt and bind using small amount of your soulforce.  ");
				player.createKeyItem("Bag of Cosmos", 0, 0, 0, 0);
				outputText("<b>You now have 12 item slots bag.</b>");
				return;
			} else if (player.hasKeyItem("Bag of Cosmos") >= 0) {
				outputText("When binding this bag of cosmos you notice you already have one of such type.  Damn now this one is wasted.  Well next time you will remember to not bind new ones when you got one already.");
			}
		}

		public function skypoisonpearl(player:Player):void
		{
			clearOutput();
			outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your core.\n\n");
			player.createKeyItem("Sky Poison Pearl", 0, 0, 0, 0);
			outputText("<b>You now have 14(98) item slots in your pearl.</b>");
			flags[kFLAGS.SKY_POISON_PEARL] = 2;
		}

		public function lowgradesoulforcerecoverypill(player:Player):void {
			outputText("You cram the pill in your mouth and swallow it.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your soul.\n\n(Recovered soulforce: 100)");
			player.soulforce += 100;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(5);
			statScreenRefresh();
		}
		public function lowgradesoulforcerecoverypill2(player:Player):void {
			outputText("You open the bottle and start to cram the pills in your mouth, then swallowing them all.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your soul.\n\n(Recovered soulforce: 1000)");
			player.soulforce += 1000;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(50);
			statScreenRefresh();
		}
		public function midgradesoulforcerecoverypill(player:Player):void {
			outputText("You cram the pill in your mouth and swallow it.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your soul.\n\n(Recovered soulforce: 600)");
			player.soulforce += 600;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(25);
			statScreenRefresh();
		}
		public function highgradesoulforcerecoverypill(player:Player):void {
			outputText("You cram the pill in your mouth and swallow it.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your soul.\n\n(Recovered soulforce: 3600)");
			player.soulforce += 3600;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(125);
			statScreenRefresh();
		}
	//	public function superiorgradesoulforcerecoverypill(player:Player):void {
	//		outputText("You cram the pill in your mouth and swallow it.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your soul.\n\n(Recovered soulforce: 21600)");
	//		player.soulforce += 21600;
	//		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
	//		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(625);
	//		statScreenRefresh();
	//	}
		public function fasteningpill(player:Player):void {
			outputText("You cram the pill in your mouth and swallow it.  Surprisingly there is no discomfort, only a sensation of your stomach been full.");
			if (player.hasStatusEffect(StatusEffects.FastingPill)) player.addStatusValue(StatusEffects.FastingPill, 1, 24);
			else player.createStatusEffect(StatusEffects.FastingPill,73,0,0,0);
			statScreenRefresh();
		}

		public function triplethrustmanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Triple Thrust.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (!player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Triple Thrust.</b>");
				player.createStatusEffect(StatusEffects.KnowsTripleThrust, 0, 0, 0, 0);
				return;
			}
			if (player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
				outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
				player.soulforce += 20;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			}
		}
		public function dracosweepmanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Draco Sweep.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (!player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Draco Sweep.</b>");
				player.createStatusEffect(StatusEffects.KnowsDracoSweep, 0, 0, 0, 0);
				return;
			}
			if (player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
				outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
				player.soulforce += 25;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			}
		}
		public function manybirdsmanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Many Birds.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (!player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Many Birds.</b>");
				player.createStatusEffect(StatusEffects.KnowsManyBirds, 0, 0, 0, 0);
				return;
			}
			if (player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
				outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
				player.soulforce += 25;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			}
		}
		public function cometmanual(player:Player):void
		{
			clearOutput();
			if (player.hasPerk(PerkLib.SoulWarrior)) {
				outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Comet.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
				if (!player.hasStatusEffect(StatusEffects.KnowsComet)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Comet.</b>");
					player.createStatusEffect(StatusEffects.KnowsComet, 0, 0, 0, 0);
					return;
				}
				if (player.hasStatusEffect(StatusEffects.KnowsComet)) {
					outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
					player.soulforce += 100;
					if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				}
			}
			else outputText("You open the manual, and discover to your horror it's way too complicated soulskill to learn currently.  What makes it worst it's nature of manual that would vanish in a momnet whenever you memorized everything about this soulskill or not.  Moment later it start disappears into thin air before you can put it away.  You should be more carefull next time to not waste any new manual by trying to learn soulskill you can't handle yet.");
		}
		public function violetpupiltransformationmanual(player:Player):void
		{
			clearOutput();
			if (player.hasPerk(PerkLib.SoulWarrior)) {
				outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Violet Pupil Transformation.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
				if (!player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Violet Pupil Transformation.</b>");
					player.createStatusEffect(StatusEffects.KnowsVioletPupilTransformation, 0, 0, 0, 0);
					return;
				}
				if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
					outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
					player.soulforce += 100;
					if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				}
			}
			else outputText("You open the manual, and discover to your horror it's way too complicated soulskill to learn currently.  What makes it worst it's nature of manual that would vanish in a momnet whenever you memorized everything about this soulskill or not.  Moment later it start disappears into thin air before you can put it away.  You should be more carefull next time to not waste any new manual by trying to learn soulskill you can't handle yet.");
		}
		public function soulblastmanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling soulforce while performing Soul Blast.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Soul Blast.</b>");
			player.createStatusEffect(StatusEffects.KnowsSoulBlast, 0, 0, 0, 0);
		}
		public function basicflamesoflovemanual(player:Player):void
		{
			clearOutput();
			if (player.hasPerk(PerkLib.SoulApprentice)) {
				outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling lust into flames.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
				if (!player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Flames of Love (Basic Rank).</b>");
					player.createStatusEffect(StatusEffects.KnowsFlamesOfLove, 1, 0, 0, 0);
					return;
				}
				if (player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
					outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
					player.soulforce += 50;
					if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				}
			}
			else outputText("You open the manual, and discover to your horror it's way too complicated soulskill to learn currently.  What makes it worst it's nature of manual that would vanish in a momnet whenever you memorized everything about this soulskill or not.  Moment later it start disappears into thin air before you can put it away.  You should be more carefull next time to not waste any new manual by trying to learn soulskill you can't handle yet.");
		}
		public function basiciciclesoflovemanual(player:Player):void
		{
			clearOutput();
			if (player.hasPerk(PerkLib.SoulApprentice)) {
				outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling lust into icicles.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
				if (!player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Icicles of Love (Basic Rank).</b>");
					player.createStatusEffect(StatusEffects.KnowsIciclesOfLove, 1, 0, 0, 0);
					return;
				}
				if (player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
					outputText("When you open the manual, it turns out you already know this soul skill.  Having a hunch you read whole manual and when it disappears into thin air you feel it does restored some of your soulforce.");
					player.soulforce += 50;
					if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				}
			}
			else outputText("You open the manual, and discover to your horror it's way too complicated soulskill to learn currently.  What makes it worst it's nature of manual that would vanish in a momnet whenever you memorized everything about this soulskill or not.  Moment later it start disappears into thin air before you can put it away.  You should be more carefull next time to not waste any new manual by trying to learn soulskill you can't handle yet.");
		}
		public function devourermanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it seems to be almost unreadable.  It looks like it would teach reader to use some sort of soul skill but it seems all very fragmentary.  In no time at all you've read the whole thing and like others manuscripts it start to disappears into thin air.  Left without anything you thinking about next action when some new thought start to keep circling in your mind. The more it circle it seems to seemly literaly ");
			outputText("'suck you in'.  You try stop it but it's too late.  last not devoured thought you have before blank out is.. 'would i at least not hit groun...'\n\nAfter unknown amount of time you wakes up on the floor with seared into your mind knowledge on <b>new soul skill: Devourer.</b>");
			player.createStatusEffect(StatusEffects.KnowsHeavensDevourer, 1, 0, 0, 0);
		}
		public function higherrankflamesoflovemanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling lust into (burning hot) flames.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Flames of Love ( Rank).</b>");
			player.createStatusEffect(StatusEffects.KnowsSoulBlast, 0, 0, 0, 0);
		}
		public function higherrankiciclesoflovemanual(player:Player):void
		{
			clearOutput();
			outputText("You open the manual, and discover it to be an instructional on how the use a soul skill.  Most of it is filled with generic information on poses and channeling lust into (freezing cold) icicles.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new soul skill: Icicles of Love ( Rank).</b>");
			player.createStatusEffect(StatusEffects.KnowsSoulBlast, 0, 0, 0, 0);
		}

		public function verydilutedarcaneregenconcotion(player:Player):void {
			outputText("You grab your mana potion, pull the cork off and swiftly chug it down.\n\n(Recovered mana: 200)");
			player.mana += 200;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
		}
		public function dilutedarcaneregenconcotion(player:Player):void {
			outputText("You grab your mana potion, pull the cork off and swiftly chug it down.\n\n(Recovered mana: 1200)");
			player.mana += 1200;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
		}
		public function arcaneregenconcotion(player:Player):void {
			outputText("You grab your mana potion, pull the cork off and swiftly chug it down.\n\n(Recovered mana: 7200)");
			player.mana += 7200;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
			statScreenRefresh();
		}
		
		public function tomeofcleave(player:Player):void
		{
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.KnowsCleave)) {
				outputText("\n\nYou read the tome, enlightening yourself to the art of making your blows properly connect to multiple targets. You gained <b>new physical special: Cleave.</b>");
				player.createStatusEffect(StatusEffects.KnowsCleave, 0, 0, 0, 0);
				return;
			}
			if (player.hasStatusEffect(StatusEffects.KnowsCleave)) {
				outputText("When you open the tome, it turns out you already know this special.  Having a hunch you read whole tome and when it disappears into thin air you feel it does restored some of your fatigue.");
				EngineCore.changeFatigue(-25);
			}
		}
		
		public function additionalTransformationChances():Number {
			var additionalTransformationChancesCounter:Number = 0;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Enhancement) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Fusion) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Enchantment) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Refinement) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Saturation) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Perfection) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.Creationism) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.EzekielBlessing) >= 0) additionalTransformationChancesCounter++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) additionalTransformationChancesCounter--;
			return additionalTransformationChancesCounter;
		}
		
		/* ITEMZZZZZ FUNCTIONS GO HERE */
		public function incubiDraft(tainted:Boolean,player:Player):void
		{
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			rando += (10 * additionalTransformationChances());
			clearOutput();
			outputText("The draft is slick and sticky, ");
			if (player.cor <= 33) outputText("just swallowing it makes you feel unclean.");
			if (player.cor > 33 && player.cor <= 66) outputText("reminding you of something you just can't place.");
			if (player.cor > 66) outputText("deliciously sinful in all the right ways.");
			if (player.cor >= 90) outputText("  You're sure it must be distilled from the cum of an incubus.");
			if (player.findPerk(PerkLib.TransformationImmunity) < 0) {
			//Lowlevel changes
			if (rando < 50) {
				if (player.cocks.length == 1) {
					if (player.cocks[0].cockType != CockTypesEnum.DEMON) outputText("\n\nYour [cock] becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					else outputText("\n\nYour [cock] becomes shockingly hard.  It dribbles hot demon-like cum as it begins to grow.");
					var selectedCock:int;
					if (rand(4) == 0) selectedCock = player.increaseCock(0, 3);
					else selectedCock = player.increaseCock(0, 1);
					dynStats("int", 1, "lib", 2, "sen", 1, "lust", 5 + selectedCock * 3, "cor", tainted ? 1 : 0);
					if (selectedCock < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (selectedCock >= .5 && selectedCock < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (selectedCock >= 1 && selectedCock <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (selectedCock > 2) outputText("  You smile and idly stroke your lengthening [cock] as a few more inches sprout.");
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + selectedCock * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + selectedCock * 3);
					if (player.cocks[0].cockType != CockTypesEnum.DEMON) outputText("  With the transformation complete, your [cock] returns to its normal coloration.");
					else outputText("  With the transformation complete, your [cock] throbs in an almost happy way as it goes flaccid once more.");
				}
				if (player.cocks.length > 1) {
					selectedCock = player.cocks.length;
					temp2 = 0;
					//Find shortest cock
					while (selectedCock > 0) {
						selectedCock--;
						if (player.cocks[selectedCock].cockLength <= player.cocks[temp2].cockLength) {
							temp2 = selectedCock;
						}
					}
					if (int(Math.random() * 4) == 0) temp3 = player.increaseCock(temp2, 3);
					else temp3 = player.increaseCock(temp2, 1);
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + selectedCock * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + selectedCock * 3);
					//Grammar police for 2 cocks
					if (player.cockTotal() == 2) outputText("\n\nBoth of your [cocks] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");
					//For more than 2
					else outputText("\n\nAll of your [cocks] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");

					if (temp3 < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp3 >= .5 && temp3 < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp3 >= 1 && temp3 <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp3 > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(temp2) + " as a few more inches sprout.");
					outputText("  With the transformation complete, your [cocks] return to their normal coloration.");
				}
				//NO CAWKS?
				if (player.cocks.length == 0) {
					player.createCock();
					player.cocks[0].cockLength = rand(3) + 4;
					player.cocks[0].cockThickness = 1;
					outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your [cock] fades to a more normal " + player.skinTone + " tone.");
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//TIT CHANGE 25% chance of shrinkage
				if (rand(4) == 0)
				{
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						player.shrinkTits();
					}
				}
			}
			//Mid-level changes
			if (rando >= 50 && rando < 93) {
				if (player.cocks.length > 1) {
					outputText("\n\nYour cocks fill to full-size... and begin growing obscenely.  ");
					selectedCock = player.cocks.length;
					while (selectedCock > 0) {
						selectedCock--;
						temp2 = player.increaseCock(selectedCock, rand(3) + 2);
						temp3 = player.cocks[selectedCock].thickenCock(1);
						if (temp3 < .1) player.cocks[selectedCock].cockThickness += .05;
					}
					player.lengthChange(temp2, player.cocks.length);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("\n\nYour cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("\n\nYour cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("\n\nYour cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("\n\nYour cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 1) {
					outputText("\n\nYour cock fills to its normal size and begins growing... ");
					temp3 = player.cocks[0].thickenCock(1);
					temp2 = player.increaseCock(0, rand(3) + 2);
					player.lengthChange(temp2, 1);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("  Your cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("  Your cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("  Your cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("  Your cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("  Your cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("  Your cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 0) {
					player.createCock();
					player.cocks[0].cockLength = rand(3) + 4;
					player.cocks[0].cockThickness = 1;
					outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your [cock] fades to a more normal " + player.skinTone + " tone.");
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//Shrink breasts a more
				//TIT CHANGE 50% chance of shrinkage
				if (rand(2) == 0)
				{
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						player.shrinkTits();
					}
				}
			}
			//High level change
			if (rando >= 93) {
				if (player.cockTotal() < 10) {
					if (int(Math.random() * 10) < int(player.cor / 25)) {
						outputText("\n\n");
						growDemonCock(rand(2) + 2);
						if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
						else dynStats("lib", 3, "sen", 5, "lus", 10);
					}
					else {
						growDemonCock(1);
					}
				}
				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					player.shrinkTits();
					player.shrinkTits();
				}
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 2 > 40 && tainted) demonChanges(player);
			}
			if (rand(4) == 0 && tainted) outputText(player.modFem(5, 2));
			if (rand(4) == 0 && tainted) outputText(player.modThickness(30, 2));
			player.refillHunger(10);
		}

		public function growDemonCock(growCocks:Number):void
		{
			var grown:int = 0;
			while (growCocks > 0) {
				player.createCock();
				trace("COCK LENGTH: " + player.cocks[length - 1].cockLength);
				player.cocks[player.cocks.length - 1].cockLength = rand(3) + 4;
				player.cocks[player.cocks.length - 1].cockThickness = .75;
				trace("COCK LENGTH: " + player.cocks[length - 1].cockLength);
				growCocks--;
				grown++;
			}
			outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
			if (grown == 1) {
				outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  In time it fades to a more normal coloration and human-like texture.  ");
			}
			else {
				outputText("The skin bulges obscenely, darkening and splitting around " + num2Text(grown) + " of your new dicks.  For an instant they turn a demonic purple and dribble in thick spasms of scalding demon-cum.  After, they return to a more humanoid coloration.  ");
			}
			if (grown > 4) outputText("Your tender bundle of new cocks feels deliciously sensitive, and you cannot stop yourself from wrapping your hands around the slick demonic bundle and pleasuring them.\n\nNearly an hour later, you finally pull your slick body away from the puddle you left on the ground.  When you look back, you notice it has already been devoured by the hungry earth.");
			player.orgasm('Dick');
		}

		public function minotaurCum(purified:Boolean, player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			//Minotaur cum addiction
			if (!purified) player.minoCumAddiction(7);
			else player.minoCumAddiction(-2);
			outputText("As soon as you crack the seal on the bottled white fluid, a ");
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && (player.findPerk(PerkLib.MinotaurCumResistance) < 0 || player.findPerk(PerkLib.ManticoreCumAddict) < 0)) outputText("potent musk washes over you.");
			else outputText("heavenly scent fills your nostrils.");
			if (!purified) {
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 50) outputText("  It makes you feel dizzy, ditzy, and placid.");
				else outputText("  It makes you feel euphoric, happy, and willing to do ANYTHING to keep feeling this way.");
			}
			else outputText("  You know that the bottle is purified and you're positive you won't get any addiction from this bottle.");
			outputText("  Unbidden, your hand brings the bottle to your lips, and the heady taste fills your mouth as you convulsively swallow the entire bottle.");
			//-Raises lust by 10.
			//-Raises sensitivity
			dynStats("sen", 1, "lus", 10);
			//-Raises corruption by 1 to 50, then by .5 to 75, then by .25 to 100.
			if (!purified) {
				if (player.cor < 50) dynStats("cor", 1);
				else if (player.cor < 75) dynStats("cor", .5);
				else dynStats("cor", .25);
			}
			outputText("\n\nIntermittent waves of numbness wash through your body, turning into a warm tingling that makes you feel sensitive all over.  The warmth flows through you, converging in your loins and bubbling up into lust.");
			if (player.cocks.length > 0) {
				outputText("  ");
				if (player.cockTotal() == 1) outputText("Y");
				else outputText("Each of y");
				outputText("our [cocks] aches, flooding with blood until it's bloating and trembling.");
			}
			if (player.hasVagina()) {
				outputText("  Your [clit] engorges, ");
				if (player.clitLength < 3) outputText("parting your lips.");
				else outputText("bursting free of your lips and bobbing under its own weight.");
				if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_NORMAL) outputText("  Wetness builds inside you as your " + player.vaginaDescript(0) + " tingles and aches to be filled.");
				else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_SLICK) outputText("  A trickle of wetness escapes your " + player.vaginaDescript(0) + " as your body reacts to the desire burning inside you.");
				else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_DROOLING) outputText("  Wet fluids leak down your thighs as your body reacts to this new stimulus.");
				else outputText("  Slick fluids soak your thighs as your body reacts to this new stimulus.");
			}
			//(Minotaur fantasy)
			if (!CoC.instance.inCombat && rand(10) == 1 && (!purified && (player.findPerk(PerkLib.MinotaurCumResistance) < 0) || player.findPerk(PerkLib.ManticoreCumAddict) < 0)) {
				outputText("\n\nYour eyes flutter closed for a second as a fantasy violates your mind.  You're on your knees, prostrate before a minotaur.  Its narcotic scent fills the air around you, and you're swaying back and forth with your belly already sloshing and full of spunk.  Its equine-like member is rubbing over your face, and you submit to the beast, stretching your jaw wide to take its sweaty, glistening girth inside you.  Your tongue quivers happily as you begin sucking and slurping, swallowing each drop of pre-cum you entice from the beastly erection.  Gurgling happily, you give yourself to your inhuman master for a chance to swallow into unthinking bliss.");
				dynStats("lib", 1, "lus", rand(5) + player.cor / 20 + flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] / 5);
			}
			//(Healing – if hurt and uber-addicted (hasperk))
			if (player.HP < player.maxHP() && player.findPerk(PerkLib.MinotaurCumAddict) >= 0) {
				outputText("\n\nThe fire of your arousal consumes your body, leaving vitality in its wake.  You feel much better!");
				HPChange(int(player.maxHP() / 4), false);
			}
			//Uber-addicted status!
			if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] <= 0 && !purified) {
				flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] = 3 + rand(2);
				outputText("\n\n<b>Your body feels so amazing and sensitive.  Experimentally you pinch yourself and discover that even pain is turning you on!</b>");
			}
			//Clear mind a bit
			if (purified && (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 40)) {
				outputText("\n\nYour mind feels a bit clearer just from drinking the purified minotaur cum. Maybe if you drink more of these, you'll be able to rid yourself of your addiction?");
				if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] <= 50) {
					outputText("  Suddenly, you black out and images flash in your mind about getting abducted by minotaurs and the abandonment of your quest that eventually leads to Lethice's success in taking over Mareth. No, it cannot be! You wake up and recover from the blackout, horrified to find out what would really happen if you spend the rest of your life with the Minotaurs! You shake your head and realize that you're no longer dependent on the cum.  ");
					outputText("\n<b>(Lost Perk: Minotaur Cum Addict!)</b>");
					player.removePerk(PerkLib.MinotaurCumAddict);
				}
			}
			player.refillHunger(25);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(25);
		}


		public function succubiMilk(tainted:Boolean,player:Player):void
		{
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = Math.random() * 100;
			rando += (10 * additionalTransformationChances());
			if (rando >= 90 && !tainted) rando -= 10;
			if (player.cor < 35) {
				clearOutput();
				outputText("You wonder why in the gods' names you would drink such a thing, but you have to admit, it is the best thing you have ever tasted.");
			} else if (player.cor >= 35 && player.cor < 70) {
				clearOutput();
				outputText("You savor the incredible flavor as you greedily gulp it down.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  The taste alone makes your [vagina] feel ");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("tingly.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("wet.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("sloppy and wet.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("sopping and juicy.");
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("dripping wet.");
				}
				else if (player.hasCock()) outputText("  You feel a building arousal, but it doesn't affect your cock.");
			}
			if (player.cor >= 70) {
				clearOutput();
				outputText("You pour the milk down your throat, chugging the stuff as fast as you can.  You want more.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  Your " + vaginaDescript(0));
					if (player.vaginas.length > 1) outputText(" quiver in orgasm, ");
					if (player.vaginas.length == 1) outputText(" quivers in orgasm, ");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("becoming slightly sticky.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("leaving your undergarments sticky.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("wet with girlcum.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("staining your undergarments with cum.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("leaving cunt-juice trickling down your leg.");
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLAVERING) outputText("spraying your undergarments liberally with slick girl-cum.");
					player.orgasm();
				}
				else if (player.gender != 0) {
					if (player.cocks.length == 1) outputText("  You feel a strange sexual pleasure, but your " + multiCockDescript() + " remains unaffected.");
					else outputText("  You feel a strange sexual pleasure, but your " + multiCockDescript() + " remain unaffected.");
				}
			}
			if (tainted) dynStats("spe", 1, "lus", 3, "cor", 1);
			else dynStats("spe", 1, "lus", 3);
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Breast growth (maybe cock reduction!)
			if (rando <= 75) {
				var growth:int = 1 + rand(3);
				if (player.breastRows.length > 0) {
					if (player.breastRows[0].breastRating < 2 && rand(3) == 0) growth++;
					if (player.breastRows[0].breastRating < 5 && rand(4) == 0) growth++;
					if (player.breastRows[0].breastRating < 6 && rand(5) == 0) growth++;
				}
				outputText("\n\n");
				player.growTits(growth, player.breastRows.length, true, 3);
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					// Shrink cocks if you have them.
					if (player.cocks.length > 0) {
						var index:int = 0;
						temp2 = player.cocks.length;
						temp3 = 0;
						//Find biggest cock
						while (temp2 > 0) {
							temp2--;
							if (player.cocks[index].cockLength <= player.cocks[temp2].cockLength) index = temp2;
						}
						//Shrink said cock
						if (player.cocks[index].cockLength < 6 && player.cocks[index].cockLength >= 2.9) {
							player.cocks[index].cockLength -= .5;
							temp3 -= .5;
							if (player.cocks[index].cockThickness * 6 > player.cocks[index].cockLength) player.cocks[index].cockThickness -= .2;
							if (player.cocks[index].cockThickness * 8 > player.cocks[index].cockLength) player.cocks[index].cockThickness -= .2;
							if (player.cocks[index].cockThickness < .5) player.cocks[index].cockThickness = .5;
						}
						temp3 += player.increaseCock(index, (rand(3) + 1) * -1);
						outputText("\n\n");
						player.lengthChange(temp3, 1);
						if (player.cocks[index].cockLength < 2) {
							outputText("  ");
							player.killCocks(1);
						}
					}
				}
			}
			if (player.vaginas.length == 0 && (rand(3) == 0 || (rando > 75 && rando < 90))) {
				player.createVagina();
				player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
				player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
				player.vaginas[0].virgin = true;
				player.clitLength = .25;
				if (player.fertility <= 5) player.fertility = 6;
				outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [vagina]</b>!");
			}
			//Increase pussy wetness or grow one!!
			else if (rando > 75 && rando < 90) {
				//Shrink cawk
				if (player.cocks.length > 0 && !flags[kFLAGS.HYPER_HAPPY]) {
					outputText("\n\n");
					index = 0;
					temp2 = player.cocks.length;
					//Find biggest cock
					while (temp2 > 0) {
						temp2--;
						if (player.cocks[index].cockLength <= player.cocks[temp2].cockLength) index = temp2;
					}
					//Shrink said cock
					if (player.cocks[index].cockLength < 6 && player.cocks[index].cockLength >= 2.9) {
						player.cocks[index].cockLength -= .5;
					}
					temp3 = player.increaseCock(index, -1 * (rand(3) + 1));
					player.lengthChange(temp3, 1);
					if (player.cocks[index].cockLength < 3) {
						outputText("  ");
						player.killCocks(1);
					}
				}
				if (player.vaginas.length > 0) {
					outputText("\n\n");
					//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) {
						if (player.vaginas.length == 1) outputText("Your [vagina] gushes fluids down your leg as you spontaneously orgasm.");
						else outputText("Your [vagina]s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
						player.orgasm();
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) {
						if (player.vaginas.length == 1) outputText("Your pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your [vagina].  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
						if (player.vaginas.length > 1) outputText("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your [vagina]s.  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						player.orgasm();
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) {
						if (player.vaginas.length == 1) outputText("You feel a sudden trickle of fluid down your leg.  You smell it and realize it's your pussy-juice.  Your [vagina] now drools lubricant constantly down your leg.");
						if (player.vaginas.length > 1) outputText("You feel sudden trickles of fluids down your leg.  You smell the stuff and realize it's your pussies-juices.  They seem to drool lubricant constantly down your legs.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) {
						outputText("You flush in sexual arousal as you realize how moist your cunt-lips have become.  Once you've calmed down a bit you realize they're still slick and ready to fuck, and always will be.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) {
						if (player.vaginas.length == 1) outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your [vagina] felt much wetter than normal.");
						else outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your [vagina] were much wetter than normal.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) {
						outputText("You feel a tingling in your crotch, but cannot identify it.");
					}
					index = player.vaginas.length;
					while (index > 0) {
						index--;
						if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) player.vaginas[index].vaginalWetness++;
					}
				}
			}
			if (rando >= 90) {
				if (player.skinTone == "blue" || player.skinTone == "purple" || player.skinTone == "indigo" || player.skinTone == "shiny black") {
					if (player.vaginas.length > 0) {
						outputText("\n\nYour heart begins beating harder and harder as heat floods to your groin.  You feel your clit peeking out from under its hood, growing larger and longer as it takes in more and more blood.");
						if (player.clitLength > 3 && player.findPerk(PerkLib.BigClit) < 0) outputText("  After some time it shrinks, returning to its normal aroused size.  You guess it can't get any bigger.");
						if (player.clitLength > 5 && player.findPerk(PerkLib.BigClit) >= 0) outputText("  Eventually it shrinks back down to its normal (but still HUGE) size.  You guess it can't get any bigger.");
						if (((player.findPerk(PerkLib.BigClit) >= 0) && player.clitLength < 6)
								|| player.clitLength < 3) {
							index += 2;
							player.clitLength += (rand(4) + 2) / 10;
						}
						dynStats("sen", 3, "lus", 8);
					}
					else {
						player.createVagina();
						player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
						player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
						player.vaginas[0].virgin = true;
						player.clitLength = .25;
						outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [vagina]</b>!");
					}
				}
				else {
					switch (rand(10)){
						case 0:
							player.skinTone = "shiny black";
							break;

						case 1:
						case 2:
							player.skinTone = "indigo";
							break;

						case 3:
						case 4:
						case 5:
							player.skinTone = "purple";
							break;

						default:
							player.skinTone = "blue";
					}
					outputText("\n\nA tingling sensation runs across your skin in waves, growing stronger as <b>your skin's tone slowly shifts, darkening to become " + player.skinTone + " in color.</b>");
					if (tainted) dynStats("cor", 1);
					else dynStats("cor", 0);
				}
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 2 > 40 && tainted) demonChanges(player);
			if (tainted) {
				outputText(player.modFem(100, 2));
				if (rand(3) == 0) outputText(player.modTone(15, 2));
			}
			else {
				outputText(player.modFem(90, 1));
				if (rand(3) == 0) outputText(player.modTone(20, 2));
			}
			player.refillHunger(20);
		}

		public function chillyPepper(player:Player):void
		{
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Set up changes and changeLimit
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			player.slimeFeed();
			clearOutput();
			outputText("The pepper taste and feels like trying to eat snow and ice. However you eat it anyway still feeling a cold tingling in your mouth.");
			if (rand(3) == 0 && player.tallness < 120 && changes < changeLimit) {
				outputText("\n\nYou suddenly realise the ground is farther down then you remember it to be… did you just grew taller?");
				player.tallness += (1 + rand(5));
				changes++;
			}
			if (player.str < 100 && rand(3) == 0 && changes < changeLimit) {
				dynStats("str", 1);
				outputText("\n\nYou feel raw bestial power coursing through you.");
				changes++;
			}
			if (player.spe < 80 && rand(3) == 0 && changes < changeLimit) {
				dynStats("spe", 1);
				outputText("\n\nYou feel you could run forever enjoying the feeling of the wind on your [skin.type].");
				changes++;
			}
			if (player.tou < 80 && rand(3) == 0 && changes < changeLimit) {
				dynStats("tou", 1);
				outputText("\n\nYou become more... solid. Sinewy. A memory comes unbidden from your youth of a grizzled wolf you encountered while hunting, covered in scars, yet still moving with an easy grace. You imagine that must have felt something like this. You don't feel the cold as much as before either maybe you're just getting used to it.");
				changes++;
			}
			if (player.inte > 30 && rand(3) == 0 && changes < changeLimit) {
				dynStats("int", -1);
				outputText("\n\nYou feel dumber.");
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Male Stuff
			if (player.cocks.length > 0 && rand(2) == 0 && changes < changeLimit) {
				var selectedCockValue:int = -1; //Changed as selectedCock and i caused duplicate var warnings
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
				{
					if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				if (selectedCockValue != -1) {
					outputText("\n\nYour " + cockDescript(indexI) + " clenches painfully, becoming achingly, throbbingly erect. A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ");
					outputText("You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than it ever was before.");
					outputText("  <b>You now have a wolf-cock.</b>");
					player.cocks[selectedCockValue].cockType = CockTypesEnum.WOLF;
					player.cocks[selectedCockValue].knotMultiplier = 1.1;
					player.cocks[selectedCockValue].thickenCock(2);
					changes++;
				}
				if (player.wolfCocks() > 0 && changes < changeLimit && rand(2) == 0) {
					var choice:int = 0;
					//set temp2 to first wolfdick for initialization
					while (choice < player.cocks.length) {
						if (player.cocks[choice].cockType == CockTypesEnum.WOLF) {
							temp2 = choice;
							break;
						}
						else choice++;
					}
					//Reset choice for nex tcheck
					choice = player.cocks.length;
					//Find smallest knot
					while (choice > 0) {
						choice--;
						if (player.cocks[choice].cockType == CockTypesEnum.WOLF && player.cocks[choice].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = choice;
					}
					//Have smallest knotted cock selected.
					temp3 = (rand(2) + 1) / 40;
					if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
					player.cocks[temp2].knotMultiplier += (temp3);
					if (temp3 < .06) outputText("\n\nYour " + cockDescript(temp2) + " feels unusually tight in your sheath as your knot grows.");
					if (temp3 >= .06 && temp3 <= .12) outputText("\n\nYour " + cockDescript(temp2) + " pops free of your sheath, thickening nicely into a bigger knot.");
					if (temp3 > .12) outputText("\n\nYour " + cockDescript(temp2) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
					dynStats("sen", .5, "lus", 10);
					changes++;
				}
			}

			//Female Stuff

		//	outputText("\n\nYour " + cockDescript(choice) + " clenches painfully, becoming achingly, throbbingly erect. A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ");
		//	outputText("You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than it ever was before.");
		//	outputText("  <b>You now have a wolf-cock.</b>");

			//Multiboobages
			if (player.breastRows.length > 0) {
				//if bigger than A cup
				if (player.breastRows[0].breastRating > 0 && player.vaginas.length > 0) {
					//Doggies only get 3 rows of tits! FENOXO HAS SPOKEN
					if (player.breastRows.length < 3 && rand(2) == 0 && changes < changeLimit) {
						player.createBreastRow();
						//Store choice to the index of the newest row
						choice = player.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						//But ONLY if player has a vagina (dont want dudes weirded out)
						if (player.vaginas.length > 0 && player.breastRows[0].breastRating <= player.breastRows.length) {
							outputText("\n\nYour [breasts] feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							player.breastRows[0].breastRating += 2;
							outputText(player.breastCup(0) + " size.  But it doesn't stop there, you feel a tightness beginning lower on your torso...");
							changes++;
						}
						//Had 1 row to start
						if (player.breastRows.length == 2) {
							//1 size below primary breast row!
							player.breastRows[choice].breastRating = player.breastRows[0].breastRating - 1;
							if (player.breastRows[0].breastRating - 1 == 0) outputText("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else outputText("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + player.breastCup(choice) + "s.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							dynStats("sen", 6, "lus", 5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits...
						if (player.breastRows.length > 2 && player.breastRows[0].breastRating > player.breastRows.length) {
							dynStats("sen", 6, "lus", 5);
							//New row's size = the size of the row above -1
							player.breastRows[choice].breastRating = player.breastRows[choice - 1].breastRating - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (player.breastRows[choice].breastRating < 0) player.breastRows[choice].breastRating = 0;
							if (player.breastRows[choice - 1].breastRating < 0) player.breastRows[choice - 1].breastRating = 0;
							if (player.breastRows[choice].breastRating == 0) outputText("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others.  Your new breasts stay flat and masculine, not growing any larger.");
							else outputText("\n\nYour abdomen tingles and twitches as a new row of " + player.breastCup(choice) + " " + breastDescript(choice) + " sprouts below your others.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive or not
						if (rand(3) == 0) {
							if (rand(3) == 0) {
								outputText("  You heft your new chest experimentally, exploring the new flesh with tender touches.  Your eyes nearly roll back in your head from the intense feelings.");
								dynStats("sen", 6, "lus", 15, "cor", 0)
							}
							else {
								outputText("  You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure.  You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								dynStats("sen", 3, "lus", 10);
							}
						}
					}
					//If already has max doggie breasts!
					else if (rand(2) == 0) {
						//Check for size mismatches, and move closer to spec!
						choice = player.breastRows.length;
						temp2 = 0;
						var evened:Boolean = false;
						//Check each row, and if the row above or below it is
						while (choice > 1 && temp2 == 0) {
							choice--;
							//Gimme a sec
							if (player.breastRows[choice].breastRating + 1 < player.breastRows[choice - 1].breastRating) {
								if (!evened) {
									evened = true;
									outputText("\n");
								}
								outputText("\nYour ");
								if (choice == 0) outputText("first ");
								if (choice == 1) outputText("second ");
								if (choice == 2) outputText("third ");
								if (choice == 3) outputText("fourth ");
								if (choice == 4) outputText("fifth ");
								if (choice > 4) outputText("");
								outputText("row of " + breastDescript(choice) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (player.breastRows[choice - 1].breastRating) - player.breastRows[choice].breastRating - 1;
								if (temp2 > 5) temp2 = 5;
								if (temp2 < 1) temp2 = 1;
								player.breastRows[choice].breastRating += temp2;
							}
						}
					}
				}
			}
			//Grow tits if have NO breasts/nipples AT ALL
			else if (rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of B-cup breasts.</b>");
				outputText("  A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				player.createBreastRow();
				player.breastRows[0].breastRating = 2;
				player.breastRows[0].breasts = 2;
				dynStats("sen", 4, "lus", 6);
				changes++;
			}
			//Go into heat
			if (rand(2) == 0 && changes < changeLimit) {
				if(player.goIntoHeat(true)) {
				changes++;
				}
			}
			if (changes < changeLimit && player.wolfScore() >= 3 && rand(4) == 0) {
				changes++;
				outputText("\n\n");
				outputText("Images and thoughts come unbidden to your mind, overwhelming your control as you rapidly lose yourself in them, daydreaming of... ");
				//cawk fantasies
				if (player.gender <= 1 || (player.gender == 3 && rand(2) == 0)) {
					outputText("bounding through the woods, hunting a prey.  Feeling the wind in your fur and the thrill of the hunt coursing through your veins intoxicates you.  You have your nose to the ground, tracking your quarry as you run, until a heavenly scent stops you in your tracks.");
					dynStats("lus", 5 + player.lib / 20);
					//break1
					if (player.cor < 33 || !player.hasCock()) outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					else {
						outputText("  Heart pounding, your shaft pops free of its sheath on instinct, as you take off after the new scent.  ");
						outputText("You burst through a bush, spotting a white-furred female.  She drops, exposing her dripping fem-sex to you, the musky scent of her sex channeling straight through your nose and sliding into your canine cock.");
						dynStats("lus", 5 + player.lib / 20);
						//Break 2
						if (player.cor < 66) outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						else {
							outputText("  Unable to wait any longer, you mount her, pressing your bulging knot against her vulva as she yips in pleasure. The heat of her sex is unreal, the tight passage gripping you like a vice as you jackhammer against her, biting her neck gently in spite of the violent pounding.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								if (player.vaginas.length > 0) outputText("\nYou reluctantly pry your hand from your aching [vagina] as you drag yourself out of your fantasy.");
								else outputText("\nYou reluctantly pry your hand from your aching [cock] as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  At last your knot pops into her juicy snatch, splattering her groin with a smattering of her arousal.  The scents of your mating reach a peak as the velvet vice around your " + Appearance.cockNoun(CockTypesEnum.WOLF) + " quivers in the most indescribably pleasant way.  You clamp down on her hide as your whole body tenses, unleashing a torrent of cum into her sex.  Each blast is accompanied by a squeeze of her hot passage, milking you of the last of your spooge.  Your [legs] give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				//Pure female fantasies
				else if (player.hasVagina()) {
					outputText("wagging your dripping [vagina] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at your fertile scent.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled snatch and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to breed you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching [vagina] as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused wetness, stretching you tightly, every beat of his heart vibrating through your nethers.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				else {
					outputText("wagging your [asshole] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at you after going so long without a female in the pack.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled ass and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to spend his lust on you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching asshole as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused, wet hole, stretching you tightly, every beat of his heart vibrating through your hindquarters.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
			}
			//Wolf face
			if (rand(2) == 0 && changes < changeLimit && player.faceType != Face.WOLF && player.hasFullCoatOfType(Skin.FUR)) {
				outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting reforming into something... different, your screams turning into a howl as the change ends. You go to find a puddle in order to view your reflection...  <b>Your face looks like the one of a feral looking wolf composed of a maw jagged with threatening canines a wet muzzle and a animalistic tongue.</b>");
				setFaceType(Face.WOLF);
				changes++;
			}
			//Winter wolf fur
			if (rand(3) == 0
				&& changes < changeLimit
				&& player.lowerBody == LowerBody.WOLF
				&& player.tailType == Tail.WOLF
				&& player.ears.type == Ears.WOLF
				&& !player.hasFur()
				&& (player.hairColor != "glacial white" || player.coatColor != "glacial white")) {
				player.hairColor = "glacial white";
				if (!player.hasCoat()) outputText("\n\nYour skin itches intensely. You gaze down as more and more hairs break forth from your skin quickly transforming into a coat of glacial white fur which despite its external temperature feels warm inside.  <b>You are now covered in [haircolor] fur from head to toe.</b>");
				else if (player.hasScales()) outputText("\n\nYour scales itch incessantly.  You scratch, feeling them flake off to reveal a coat of [haircolor] fur growing out from below!  <b>You are now covered in [haircolor] fur from head to toe.</b>");
				else outputText("\n\nYour skin itch incessantly.  You scratch, feeling it current form shifting into a coat of glacial white fur which despite its external temperature feels warm inside.  <b>You are now covered in [haircolor] fur from head to toe.</b>");
				player.skin.growCoat(Skin.FUR, {color:player.hairColor});
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			if (rand(2) == 0 && changes < changeLimit && player.lowerBody == LowerBody.WOLF && player.tailType == Tail.WOLF && player.ears.type == Ears.WOLF && player.hasFullCoatOfType(Skin.FUR) && (player.hairColor != "glacial white" || player.coatColor != "glacial white")) {
				outputText("<b>\n\nYour fur and hair tingles, growing in thicker than ever as coldness begins to spread from the roots, turning it glacial white.</b>");
				player.hairColor = "glacial white";
				player.skin.coat.color = player.hairColor;
				changes++;
			}
			if (changes < changeLimit && player.arms.type == Arms.HUMAN && rand(2) == 0) {
				outputText("\n\nYour arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>");
				setArmType(Arms.WOLF);
				changes++;
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE, Arms.WOLF) && rand(4) == 0) {
				humanizeArms();
				changes++;
			}
			//Wolf paws
			if (rand(2) == 0 && player.lowerBody != LowerBody.WOLF && player.tailType == Tail.WOLF && player.ears.type == Ears.WOLF && changes < changeLimit) {
				if (player.isBiped() && player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nYou scream in agony as you feel the bones in your feets break and rearrange into bestial paws. Soon your legs cover up with fur from the waist down. The fur is cold to the touch and yet you feel warm and comfortable under it. <b>You now have wolf paws.</b>");
					setLowerBody(LowerBody.WOLF);
					player.legCount = 2;
					changes++;
				}
				if (player.lowerBody != LowerBody.HUMAN && player.lowerBody != LowerBody.WOLF) {
					humanizeLowerBody();
					changes++;
				}
			}
			//Wolf ears
			if (rand(2) == 0 && player.ears.type != Ears.WOLF && player.tailType == Tail.WOLF && changes < changeLimit) {
				if (player.ears.type == Ears.HUMAN) {
					outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, toward the top of your head. They shift and elongate becoming lupine in nature. You won't have much trouble hearing through the howling blizzards of the glacial rift with <b>your new Lupine ears.</b>  ");
					setEarType(Ears.WOLF);
					changes++;
				}
				if (player.ears.type != Ears.HUMAN && player.ears.type != Ears.WOLF && player.tailType == Tail.WOLF) {
					humanizeEars();
					changes++;
				}
			}
			//Grow tail if not wolf-tailed
			if (rand(2) == 0 && changes < changeLimit && player.tailType != Tail.WOLF && player.tailType != Tail.GARGOYLE) {
				if (player.tailType == Tail.NONE) {
					outputText("\n\nA pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur cold to the touch yet warm on your tail skin cover it entirely from the base to the tip.  ");
					outputText("<b>You now have a wolf-tail.</b>");
					setTailType(Tail.WOLF);
					changes++;
				}
				if (player.tailType != Tail.NONE && player.tailType != Tail.WOLF) {
					outputText("\n\nYou feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground.  <b>You no longer have a tail!</b>");
					setTailType(Tail.NONE, 0);
					player.tailVenom = 0;
					player.tailRecharge = 5;
					changes++;
				}
			}
			// Remove gills
			if (rand(3) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//If no changes yay
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(20, true);
				dynStats("lus", 3);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//1-Oversized Pepper (+size, thickness)
//2-Double Pepper (+grows second cock or changes two cocks to dogcocks)
//3-Black Pepper (Dark Fur, +corruption/libido)
//4-Knotty Pepper (+Knot + Cum Multiplier)
//5-Bulbous Pepper (+ball size or fresh balls)
		public function caninePepper(type:Number,player:Player):void
		{
			var temp2:Number = 0;
			var temp3:Number = 0;
			var crit:Number = 1;
			//Set up changes and changeLimit
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Initial outputs & crit level
			clearOutput();
			if (type == 0) {
				if (rand(100) < 15) {
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("The pepper tastes particularly potent, searingly hot and spicy.");
				}
				else outputText("The pepper is strangely spicy but very tasty.");
			}
			//Oversized pepper
			if (type == 1) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The pepper is so large and thick that you have to eat it in several large bites.  It is not as spicy as the normal ones, but is delicious and flavorful.");
			}
			//Double Pepper
			if (type == 2) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The double-pepper is strange, looking like it was formed when two peppers grew together near their bases.");
			}
			//Black Pepper
			if (type == 3) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("This black pepper tastes sweet, but has a bit of a tangy aftertaste.");
			}
			//Knotty Pepper
			if (type == 4) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The pepper is a bit tough to eat due to the swollen bulge near the base, but you manage to cram it down and munch on it.  It's extra spicy!");
			}
			//Bulbous Pepper
			if (type == 5) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("You eat the pepper, even the two orb-like growths that have grown out from the base.  It's delicious!");
			}
			//OVERDOSE Bad End!
			if (type <= 0 && crit > 1 && player.hasFullCoatOfType(Skin.FUR) && player.faceType == Face.DOG && player.ears.type == Ears.DOG && player.lowerBody == LowerBody.DOG && player.tailType == Tail.DOG && rand(2) == 0 && player.hasStatusEffect(StatusEffects.DogWarning) && player.findPerk(PerkLib.TransformationResistance) < 0) {
				var choice:int = rand(2);
				if (choice == 0) {
					outputText("\n\nAs you swallow the pepper, you note that the spicy hotness on your tongue seems to be spreading. Your entire body seems to tingle and burn, making you feel far warmer than normal, feverish even. Unable to stand it any longer you tear away your clothes, hoping to cool down a little. Sadly, this does nothing to aid you with your problem. On the bright side, the sudden feeling of vertigo you've developed is more than enough to take your mind off your temperature issues. You fall forward onto your hands and knees, well not really hands and knees to be honest. More like paws and knees. That can't be good, you think for a moment, before the sensation of your bones shifting into a quadrupedal configuration robs you of your concentration. After that, it is only a short time before your form is remade completely into that of a large dog, or perhaps a wolf. The distinction would mean little to you now, even if you were capable of comprehending it. ");
					if (player.findPerk(PerkLib.MarblesMilk) >= 0) outputText("All you know is that there is a scent on the wind, it is time to hunt, and at the end of the day you need to come home for your milk.");
					else outputText("All you know is that there is a scent on the wind, and it is time to hunt.");
				}
				if (choice == 1) outputText("\n\nYou devour the sweet pepper, carefully licking your fingers for all the succulent juices of the fruit, and are about to go on your way when suddenly a tightness begins to build in your chest and stomach, horrid cramps working their way first through your chest, then slowly flowing out to your extremities, the feeling soon joined by horrible, blood-curdling cracks as your bones begin to reform, twisting and shifting, your mind exploding with pain. You fall to the ground, reaching one hand forward. No... A paw, you realize in horror, as you try to push yourself back up. You watch in horror, looking down your foreleg as thicker fur erupts from your skin, a [haircolor] coat slowly creeping from your bare flesh to cover your body. Suddenly, you feel yourself slipping away, as if into a dream, your mind warping and twisting, your body finally settling into its new form. With one last crack of bone you let out a yelp, kicking free of the cloth that binds you, wresting yourself from its grasp and fleeing into the now setting sun, eager to find prey to dine on tonight.");
				EventParser.gameOver();
				return;
			}
			//WARNING, overdose VERY close!
			if (type <= 0 && player.hasFullCoatOfType(Skin.FUR) && player.faceType == Face.DOG && player.tailType == Tail.DOG && player.ears.type == Ears.DOG && player.lowerBody == LowerBody.DOG && player.hasStatusEffect(StatusEffects.DogWarning) && rand(3) == 0) {
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			//WARNING, overdose is close!
			if (type <= 0 && player.hasFullCoatOfType(Skin.FUR) && player.faceType == Face.DOG && player.tailType == Tail.DOG && player.ears.type == Ears.DOG && player.lowerBody == LowerBody.DOG && !player.hasStatusEffect(StatusEffects.DogWarning)) {
				player.createStatusEffect(StatusEffects.DogWarning, 0, 0, 0, 0);
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			if (type == 3) {
				dynStats("lib", 2 + rand(4), "lus", 5 + rand(5), "cor", 2 + rand(4));
				outputText("\n\nYou feel yourself relaxing as gentle warmth spreads through your body.  Honestly you don't think you'd mind running into a demon or monster right now, they'd make for good entertainment.");
				if (player.cor < 50) outputText("  You shake your head, blushing hotly.  Where did that thought come from?");
			}
			if (player.str < 50 && rand(3) == 0) {
				dynStats("str", (crit));
				if (crit > 1) outputText("\n\nYour muscles ripple and grow, bulging outwards.");
				else outputText("\n\nYour muscles feel more toned.");
				changes++;
			}
			if (player.spe < 30 && rand(3) == 0 && changes < changeLimit) {
				dynStats("spe", (crit));
				if (crit > 1) outputText("\n\nYou find your muscles responding quicker, faster, and you feel an odd desire to go for a walk.");
				else outputText("\n\nYou feel quicker.");
				changes++;
			}
			if (player.inte > 30 && rand(3) == 0 && changes < changeLimit && type != 3) {
				dynStats("int", (-1 * crit));
				outputText("\n\nYou feel ");
				if (crit > 1) outputText("MUCH ");
				outputText("dumber.");
				changes++;
			}
			//if(type != 2 && type != 4 && type != 5) outputText("\n");
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Double Pepper!
			//Xforms/grows dicks to make you have two dogcocks
			if (type == 2) {
				//If already doubled up, GROWTH
				if (player.dogCocks() >= 2) {
					type = 1;
				}
				//If player doesnt have 2 dogdicks
				else {
					//If player has NO dogdicks
					if (player.dogCocks() == 0) {
						//Dickless - grow two dogpeckers
						if (player.cockTotal() == 0) {
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							outputText("\n\nA painful lump forms on your groin, nearly doubling you over as it presses against your [armor].  You rip open your gear and watch, horrified as the discolored skin splits apart, revealing a pair of red-tipped points.  A feeling of relief, and surprising lust grows as they push forward, glistening red and thickening.  The skin bunches up into an animal-like sheath, while a pair of fat bulges pop free.  You now have two nice thick dog-cocks, with decent sized knots.  Both pulse and dribble animal-pre, arousing you in spite of your attempts at self-control.");
							player.cocks[0].knotMultiplier = 1.7;
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lus", 50);
						}
						//1 dick - grow 1 and convert 1
						else if (player.cockTotal() == 1) {
							outputText("\n\nYour [cock] vibrates, the veins clearly visible as it reddens and distorts.  The head narrows into a pointed tip while a gradually widening bulge forms around the base.  Where it meets your crotch, the skin bunches up around it, forming a canine-like sheath.  ");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.5;
							outputText("You feel something slippery wiggling inside the new sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lib", 2, "lus", 50);
						}
						//2 dicks+ - convert first 2 to doggie-dom
						else {
							outputText("\n\nYour crotch twitches, and you pull open your [armor] to get a better look.  You watch in horror and arousal as your [cock] and " + cockDescript(1) + " both warp and twist, becoming red and pointed, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.4;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
					}
					//If player has 1 dogdicks
					else {
						//if player has 1 total
						if (player.cockTotal() == 1) {
							outputText("\n\nYou feel something slippery wiggling inside your sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
						//if player has more
						if (player.cockTotal() >= 1) {
							//if first dick is already doggi'ed
							if (player.cocks[0].cockType == CockTypesEnum.DOG) {
								outputText("\n\nYour crotch twitches, and you pull open your [armor] to get a better look.  You watch in horror and arousal as your " + cockDescript(1) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[1].cockType = CockTypesEnum.DOG;
								player.cocks[1].knotMultiplier = 1.4;
							}
							//first dick is not dog
							else {
								outputText("\n\nYour crotch twitches, and you pull open your [armor] to get a better look.  You watch in horror and arousal as your [cock] warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[0].cockType = CockTypesEnum.DOG;
								player.cocks[0].knotMultiplier = 1.4;
							}
							dynStats("lib", 2, "lus", 50);
						}
					}
				}
			}
			//Knotty knot pepper!
			if (type == 4) {
				//Cocks only!
				if (player.cockTotal() > 0) {
					//biggify knots
					if (player.dogCocks() > 0) {
						choice = 0;
						//set temp2 to first dogdick for initialization
						while (choice < player.cocks.length) {
							if (player.cocks[choice].cockType == CockTypesEnum.DOG) {
								temp2 = choice;
								break;
							}
							else choice++;
						}
						//Reset choice for nex tcheck
						choice = player.cocks.length;
						//Find smallest knot
						while (choice > 0) {
							choice--;
							if (player.cocks[choice].cockType == CockTypesEnum.DOG && player.cocks[choice].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = choice;
						}
						//Have smallest knotted cock selected.
						temp3 = (rand(2) + 5) / 20 * crit;
						if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
						player.cocks[temp2].knotMultiplier += (temp3);
						outputText("\n\n");
						if (temp3 < .06) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " feels unusually tight in your sheath as your knot grows.");
						if (temp3 >= .06 && temp3 <= .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " pops free of your sheath, thickening nicely into a bigger knot.");
						if (temp3 > .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
						dynStats("sen", .5, "lus", 5 * crit);
					}
					//Grow dogdick with big knot
					else {
						outputText("\n\nYour [cock] twitches, reshaping itself.  The crown tapers down to a point while the base begins swelling.  It isn't painful in the slightest, actually kind of pleasant.  Your dog-like knot slowly fills up like a balloon, eventually stopping when it's nearly twice as thick as the rest.  You touch and shiver with pleasure, oozing pre-cum.");
						player.cocks[0].cockType = CockTypesEnum.DOG;
						player.cocks[0].knotMultiplier = 2.1;
					}
				}
				//You wasted knot pepper!
				else outputText("\n\nA slight wave of nausea passes through you.  It seems this pepper does not quite agree with your body.");
			}
			//GROW BALLS
			if (type == 5) {
				if (player.balls <= 1) {
					outputText("\n\nA spike of pain doubles you up, nearly making you vomit.  You stay like that, nearly crying, as a palpable sense of relief suddenly washes over you.  You look down and realize you now have a small sack, complete with two relatively small balls.");
					player.balls = 2;
					player.ballSize = 1;
					dynStats("lib", 2, "lus", -10);
				}
				else {
					//Makes your balls biggah!
					player.ballSize++;
					//They grow slower as they get bigger...
					if (player.ballSize > 10) player.ballSize -= .5;
					//Texts
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + simpleBallsDescript() + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your [sack].  Walking becomes difficult as you discover your " + simpleBallsDescript() + " have enlarged again.");
					dynStats("lib", 1, "lus", 3);
				}
			}
			//Sexual Stuff Now
			//------------------
			//Man-Parts
			//3 Changes,
			//1. Cock Xform
			//2. Knot Size++
			//3. cumMultiplier++ (to max of 1.5)
			if (player.cocks.length > 0) {
				//Grow knot on smallest knotted dog cock
				if (type != 4 && player.dogCocks() > 0 && ((changes < changeLimit && rand(1.4) == 0) || type == 1)) {
					choice = 0;
					//set temp2 to first dogdick for initialization
					while (choice < player.cocks.length) {
						if (player.cocks[choice].cockType == CockTypesEnum.DOG) {
							temp2 = choice;
							break;
						}
						else choice++;
					}
					//Reset choice for nex tcheck
					choice = player.cocks.length;
					//Find smallest knot
					while (choice > 0) {
						choice--;
						if (player.cocks[choice].cockType == CockTypesEnum.DOG && player.cocks[choice].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = choice;
					}
					//Have smallest knotted cock selected.
					temp3 = (rand(2) + 1) / 20 * crit;
					if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
					player.cocks[temp2].knotMultiplier += (temp3);
					if (temp3 < .06) outputText("\n\nYour " + cockDescript(temp2) + " feels unusually tight in your sheath as your knot grows.");
					if (temp3 >= .06 && temp3 <= .12) outputText("\n\nYour " + cockDescript(temp2) + " pops free of your sheath, thickening nicely into a bigger knot.");
					if (temp3 > .12) outputText("\n\nYour " + cockDescript(temp2) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
					dynStats("sen", .5, "lus", 5 * crit);
					changes++;
				}
				//Cock Xform if player has free cocks.
				if (player.dogCocks() < player.cocks.length && ((changes < changeLimit && rand(1.6)) && type != 6 || type == 1) == 0) {
					//Select first human cock
					choice = player.cocks.length;
					temp2 = 0;
					while (choice > 0 && temp2 == 0) {
						choice--;
						//Store cock index if not a dogCock and exit loop.
						if (player.cocks[choice].cockType != CockTypesEnum.DOG) {
							temp3 = choice;
							//kicking out of tah loop!
							temp2 = 1000;
						}
					}
					//Talk about it
					//Hooooman
					if (player.cocks[temp3].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + cockDescript(temp3) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  You shudder as the crown of your " + cockDescript(temp3) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your " + Appearance.cockNoun(CockTypesEnum.DOG) + " much thicker than it ever was before.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 10, "lus", 5 * crit);
					}
					//Horse
					if (player.cocks[temp3].cockType == CockTypesEnum.HORSE) {
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a dog-cock.</b>");
						//Tweak length/thickness.
						if (player.cocks[temp3].cockLength > 6) player.cocks[temp3].cockLength -= 2;
						else player.cocks[temp3].cockLength -= .5;
						player.cocks[temp3].cockThickness += .5;

						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Tentacular Tuesday!
					if (player.cocks[temp3].cockType == CockTypesEnum.TENTACLE) {
						outputText("\n\nYour " + cockDescript(temp3) + " coils in on itself, reshaping and losing its plant-like coloration as it thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Misc
					if (player.cocks[temp3].cockType.Index > 4) {
						outputText("\n\nYour " + cockDescript(temp3) + " trembles, reshaping itself into a shiny red doggie-dick with a fat knot at the base.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					choice = 0;
					//Demon
					if (player.cocks[temp3].cockType == CockTypesEnum.DEMON) {
						outputText("\n\nYour " + cockDescript(temp3) + " color shifts red for a moment and begins to swell at the base, but within moments it smooths out, retaining its distinctive demonic shape, only perhaps a bit thicker.");
						dynStats("sen", 1, "lus", 2 * crit);
						choice = 1;
					}
					//Xform it!
					player.cocks[temp3].cockType = CockTypesEnum.DOG;
					player.cocks[temp3].knotMultiplier = 1.1;
					player.cocks[temp3].thickenCock(2);
					if (choice == 1) {
						player.cocks[temp3].cockType = CockTypesEnum.DEMON;
					}
					changes++;

				}
				//Cum Multiplier Xform
				if (player.cumMultiplier < 2 && rand(2) == 0 && changes < changeLimit && type != 6) {
					choice = 1.5;
					//Lots of cum raises cum multiplier cap to 2 instead of 1.5
					if (player.findPerk(PerkLib.MessyOrgasms) >= 0) choice = 2;
					if (choice < player.cumMultiplier + .05 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .05 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your [balls].  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your [cocks], pushed out by the change.");
					}
					changes++;
				}
				//Oversized pepper
				if (type == 1) {
					//GET LONGER
					//single cock
					if (player.cocks.length == 1) {
						temp2 = player.increaseCock(0, rand(4) + 3);
						choice = 0;
						dynStats("sen", 1, "lus", 10);
					}
					//Multicock
					else {
						//Find smallest cock
						//Temp2 = smallness size
						//choice = current smallest
						temp3 = player.cocks.length;
						choice = 0;
						while (temp3 > 0) {
							temp3--;
							//If current cock is smaller than saved, switch values.
							if (player.cocks[choice].cockLength > player.cocks[temp3].cockLength) {
								temp2 = player.cocks[temp3].cockLength;
								choice = temp3;
							}
						}
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = player.increaseCock(choice, rand(4) + 3);
						dynStats("sen", 1, "lus", 10);
						if (player.cocks[choice].cockThickness <= 2) player.cocks[choice].thickenCock(1);
					}
					if (temp2 > 2) outputText("\n\nYour " + cockDescript(choice) + " tightens painfully, inches of bulging dick-flesh pouring out from your crotch as it grows longer.  Thick pre forms at the pointed tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) outputText("\n\nAching pressure builds within your crotch, suddenly releasing as an inch or more of extra dick-flesh spills out.  A dollop of pre beads on the head of your enlarged " + cockDescript(choice) + " from the pleasure of the growth.");
					if (temp2 <= 1) outputText("\n\nA slight pressure builds and releases as your " + cockDescript(choice) + " pushes a bit further out of your crotch.");
				}
			}
			//Female Stuff
			//Multiboobages
			if (player.breastRows.length > 0) {
				//if bigger than A cup
				if (player.breastRows[0].breastRating > 0 && player.vaginas.length > 0) {
					//Doggies only get 3 rows of tits! FENOXO HAS SPOKEN
					if (player.breastRows.length < 3 && rand(2) == 0 && changes < changeLimit) {
						player.createBreastRow();
						//Store choice to the index of the newest row
						choice = player.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						//But ONLY if player has a vagina (dont want dudes weirded out)
						if (player.vaginas.length > 0 && player.breastRows[0].breastRating <= player.breastRows.length) {
							outputText("\n\nYour [breasts] feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							player.breastRows[0].breastRating += 2;
							outputText(player.breastCup(0) + " size.  But it doesn't stop there, you feel a tightness beginning lower on your torso...");
							changes++;
						}
						//Had 1 row to start
						if (player.breastRows.length == 2) {
							//1 size below primary breast row!
							player.breastRows[choice].breastRating = player.breastRows[0].breastRating - 1;
							if (player.breastRows[0].breastRating - 1 == 0) outputText("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else outputText("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + player.breastCup(choice) + "s.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							dynStats("sen", 6, "lus", 5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits...
						if (player.breastRows.length > 2 && player.breastRows[0].breastRating > player.breastRows.length) {
							dynStats("sen", 6, "lus", 5);
							//New row's size = the size of the row above -1
							player.breastRows[choice].breastRating = player.breastRows[choice - 1].breastRating - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (player.breastRows[choice].breastRating < 0) player.breastRows[choice].breastRating = 0;
							if (player.breastRows[choice - 1].breastRating < 0) player.breastRows[choice - 1].breastRating = 0;
							if (player.breastRows[choice].breastRating == 0) outputText("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others.  Your new breasts stay flat and masculine, not growing any larger.");
							else outputText("\n\nYour abdomen tingles and twitches as a new row of " + player.breastCup(choice) + " " + breastDescript(choice) + " sprouts below your others.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive if crit
						if (crit > 1 && type != 6) {
							if (crit > 2) {
								outputText("  You heft your new chest experimentally, exploring the new flesh with tender touches.  Your eyes nearly roll back in your head from the intense feelings.");
								dynStats("sen", 6, "lus", 15, "cor", 0)
							}
							else {
								outputText("  You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure.  You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								dynStats("sen", 3, "lus", 10);
							}
						}
					}
					//If already has max doggie breasts!
					else if (rand(2) == 0) {
						//Check for size mismatches, and move closer to spec!
						choice = player.breastRows.length;
						temp2 = 0;
						var evened:Boolean = false;
						//Check each row, and if the row above or below it is
						while (choice > 1 && temp2 == 0) {
							choice--;
							//Gimme a sec
							if (player.breastRows[choice].breastRating + 1 < player.breastRows[choice - 1].breastRating) {
								if (!evened) {
									evened = true;
									outputText("\n");
								}
								outputText("\nYour ");
								if (choice == 0) outputText("first ");
								if (choice == 1) outputText("second ");
								if (choice == 2) outputText("third ");
								if (choice == 3) outputText("fourth ");
								if (choice == 4) outputText("fifth ");
								if (choice > 4) outputText("");
								outputText("row of " + breastDescript(choice) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (player.breastRows[choice - 1].breastRating) - player.breastRows[choice].breastRating - 1;
								if (temp2 > 5) temp2 = 5;
								if (temp2 < 1) temp2 = 1;
								player.breastRows[choice].breastRating += temp2;
							}
						}
					}
				}
			}
			//Grow tits if have NO breasts/nipples AT ALL
			else if (rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of B-cup breasts.</b>");
				outputText("  A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				player.createBreastRow();
				player.breastRows[0].breastRating = 2;
				player.breastRows[0].breasts = 2;
				dynStats("sen", 4, "lus", 6);
				changes++;
			}
			//Go into heat
			if (rand(2) == 0 && changes < changeLimit) {
				if(player.goIntoHeat(true)) {
				changes++;
				}
			}
			if (changes < changeLimit && player.dogScore() >= 3 && rand(4) == 0) {
				changes++;
				outputText("\n\n");
				outputText("Images and thoughts come unbidden to your mind, overwhelming your control as you rapidly lose yourself in them, daydreaming of... ");
				//cawk fantasies
				if (player.gender <= 1 || (player.gender == 3 && rand(2) == 0)) {
					outputText("bounding through the woods, hunting with your master.  Feeling the wind in your fur and the thrill of the hunt coursing through your veins intoxicates you.  You have your nose to the ground, tracking your quarry as you run, until a heavenly scent stops you in your tracks.");
					dynStats("lus", 5 + player.lib / 20);
					//break1
					if (player.cor < 33 || !player.hasCock()) outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					else {
						outputText("  Heart pounding, your shaft pops free of its sheath on instinct, as you take off after the new scent.  Caught firmly in the grip of a female's heat, you ignore your master's cry as you disappear into the wild, " + Appearance.cockNoun(CockTypesEnum.DOG) + " growing harder as you near your quarry.  You burst through a bush, spotting a white-furred female.  She drops, exposing her dripping fem-sex to you, the musky scent of her sex channeling straight through your nose and sliding into your canine cock.");
						dynStats("lus", 5 + player.lib / 20);
						//Break 2
						if (player.cor < 66) outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						else {
							outputText("  Unable to wait any longer, you mount her, pressing your bulging knot against her vulva as she yips in pleasure. The heat of her sex is unreal, the tight passage gripping you like a vice as you jackhammer against her, biting her neck gently in spite of the violent pounding.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								if (player.vaginas.length > 0) outputText("\nYou reluctantly pry your hand from your aching [vagina] as you drag yourself out of your fantasy.");
								else outputText("\nYou reluctantly pry your hand from your aching [cock] as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  At last your knot pops into her juicy snatch, splattering her groin with a smattering of her arousal.  The scents of your mating reach a peak as the velvet vice around your " + Appearance.cockNoun(CockTypesEnum.DOG) + " quivers in the most indescribably pleasant way.  You clamp down on her hide as your whole body tenses, unleashing a torrent of cum into her sex.  Each blast is accompanied by a squeeze of her hot passage, milking you of the last of your spooge.  Your [legs] give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				//Pure female fantasies
				else if (player.hasVagina()) {
					outputText("wagging your dripping [vagina] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at your fertile scent.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled snatch and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to breed you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching [vagina] as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused wetness, stretching you tightly, every beat of his heart vibrating through your nethers.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				else {
					outputText("wagging your [asshole] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at you after going so long without a female in the pack.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled ass and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to spend his lust on you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching asshole as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused, wet hole, stretching you tightly, every beat of his heart vibrating through your hindquarters.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type > Eyes.HUMAN && type != 6) {
				humanizeEyes();
				changes++;
			}
			//Master Furry Appearance Order:
			//Tail -> Ears -> Paws -> Arms -> Fur -> Face
			//Dog-face requires fur & paws  Should be last morph to take place
			if (rand(4) == 0 && changes < changeLimit && player.faceType != Face.DOG && player.hasFullCoatOfType(Skin.FUR) && player.lowerBody == LowerBody.DOG) {
				if (player.faceType == Face.HORSE) outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else.  <b>Your horse-like features rearrange to take on many canine aspects.</b>");
				else outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different.  You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>");
				setFaceType(Face.DOG);
				changes++;
			}
			//-Remove feathery/quill hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) && rand(3) == 0) {
				var word1:String;
				if (player.hairType == Hair.FEATHER) word1 = "feather";
				else word1 = "quill";
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft " + word1 + "-hair droops over your eye.  Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				else outputText("\n\nYou run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your " + word1 + "s.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//-Remove leaf hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && player.hairType == 7 && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your leaf-hair droops over your eye.  Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair.  <b>Your hair is no longer leaf-like!</b>");
				//(short)
				else outputText("\n\nYou run your fingers through your leaf-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your leafs.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer leaf-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			if (type == 3 && player.hairColor != "midnight black" && player.lowerBody != LowerBody.GARGOYLE) {
				if (player.hasFur()) outputText("<b>\n\nYour fur and hair tingles, growing in thicker than ever as darkness begins to spread from the roots, turning it midnight black.</b>");
				else outputText("<b>\n\nYour [skin.type] itches like crazy as fur grows out from it, coating your body.  It's incredibly dense and black as the middle of a moonless night.</b>");
				player.hairColor = "midnight black";
				if (player.hasFur()) {
					player.skin.coat.color = player.hairColor;
					player.skinAdj = "thick";
				}
				else {
					player.skin.growCoat(Skin.FUR, {color:player.hairColor, adj:"thick"});
					if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
						outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
					}
				}
			}
			//Become furred - requires paws and tail
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody == LowerBody.DOG && player.tailType == Tail.DOG && !player.hasFur() && !player.isGargoyle()) {
				if (player.hasScales()) outputText("\n\nYour scales itch incessantly.  You scratch, feeling them flake off to reveal a coat of [skin coat.color] fur growing out from below!");
				else outputText("\n\nYour [skin base] itches intensely.  You gaze down as more and more hairs break forth from your [skin base], quickly transforming into a soft coat of fur.");
				if (rand(3)>0) {
					player.skin.growCoat(Skin.FUR, {
						color: randomChoice([
							"brown", "chocolate", "auburn", "caramel", "orange", "black", "dark gray", "gray",
							"light gray", "silver", "white"])
					});
				} else {
					player.skin.growCoat(Skin.FUR, {
						color  : randomChoice(["orange", "brown", "black"]),
						pattern: Skin.PATTERN_SPOTTED,
						color2 : "white"
					});
				}
				outputText("  <b>You are now covered in [skin coat.color] fur from head to toe.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//Change to paws - requires tail and ears
			if (rand(3) == 0 && player.lowerBody != LowerBody.DOG && player.tailType == Tail.DOG && player.ears.type == Ears.DOG && changes < changeLimit) {
				//Feet -> paws
				if (player.lowerBody == LowerBody.HUMAN) outputText("\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.");
				//Hooves -> Paws
				else if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.");
				else outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have paws</b>.");
				setLowerBody(LowerBody.DOG);
				player.legCount = 2;
				changes++;
			}
			//Change to dog-ears!  Requires dog-tail
			if (rand(2) == 0 && player.ears.type != Ears.DOG && player.tailType == Tail.DOG && changes < changeLimit) {
				if (player.ears.type == -1) outputText("\n\nTwo painful nubs begin sprouting from your head, growing and opening into canine ears.  ");
				if (player.ears.type == Ears.HUMAN) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head.  They shift and elongate, becoming canine in nature.  ");
				if (player.ears.type == Ears.HORSE) outputText("\n\nYour equine ears twist as they transform into canine versions.  ");
				if (player.ears.type > Ears.DOG) outputText("\n\nYour ears transform, becoming more canine in appearance.  ");
				setEarType(Ears.DOG);
				outputText("<b>You now have dog ears.</b>");
				changes++;
			}
			//Grow tail if not dog-tailed
			if (rand(3) == 0 && changes < changeLimit && player.tailType != Tail.GARGOYLE && ((player.tailType != Tail.DOG && type != 6) || (player.tailType != Tail.WOLF && type == 6))) {
				if (player.tailType == Tail.NONE) {
					outputText("\n\nA pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur springs up to cover your new tail.  ");
				}
				if (player.tailType == Tail.HORSE && type != 6) outputText("\n\nYou feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur.  ");
				if (player.tailType == Tail.DEMONIC && type != 6) outputText("\n\nThe tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail.  ");
				//Generic message for now
				if (player.tailType >= Tail.COW && type != 6) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long puffy tail!  ");
				changes++;
				outputText("<b>You now have a dog-tail.</b>");
				setTailType(Tail.DOG);
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			if (player.hasFullCoatOfType(Skin.FUR) && changes < changeLimit && rand(3) == 0 && type != 6) {
				outputText("\n\nYou become more... solid.  Sinewy.  A memory comes unbidden from your youth of a grizzled wolf you encountered while hunting, covered in scars, yet still moving with an easy grace.  You imagine that must have felt something like this.");
				dynStats("tou", 4, "sen", -3);
				changes++;
			}
			//If no changes yay
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(20, true);
				dynStats("lus", 3);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function impFood(player:Player):void
		{
			clearOutput();
			if (player.cocks.length > 0) {
				outputText("The food tastes strange and corrupt - you can't really think of a better word for it, but it's unclean.");
				player.refillHunger(20);
				if (player.cocks[0].cockLength < 12) {
					var cIdx:int = player.increaseCock(0, rand(2) + 2);
					outputText("\n\n");
					player.lengthChange(cIdx, 1);
				}
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(30 + player.tou / 3, true);
				dynStats("lus", 3, "cor", 1);
				//Shrinkage!
				if (rand(2) == 0 && player.tallness > 42) {
					outputText("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!\n");
					player.tallness -= 1 + rand(3);
				}
				//Red skin!
				if (rand(30) == 0 && player.skinTone != "red" && !player.isGargoyle()) {
					if (player.hasFur()) outputText("\n\nUnderneath your fur, your skin ");
					else outputText("\n\nYour [skin.type] ");
					if (rand(2) == 0) player.skinTone = "red";
					else player.skinTone = "orange";
					outputText("begins to lose its color, fading until you're as white as an albino.  Then, starting at the crown of your head, a reddish hue rolls down your body in a wave, turning you completely " + player.skinTone + ".");
				}
				return;
			}
			else {
				outputText("The food tastes... corrupt, for lack of a better word.\n");
				player.refillHunger(20);
				HPChange(20 + player.tou / 3, true);
				dynStats("lus", 3, "cor", 1);
			}
			//Red skin!
			if (rand(30) == 0 && player.skinTone != "red" && !player.isGargoyle()) {
				if (player.hasFur()) outputText("\n\nUnderneath your fur, your skin ");
				else outputText("\n\nYour [skin.type] ");
				if (rand(2) == 0) player.skinTone = "red";
				else player.skinTone = "orange";
				outputText("begins to lose its color, fading until you're as white as an albino.  Then, starting at the crown of your head, a reddish hue rolls down your body in a wave, turning you completely " + player.skinTone + ".");
			}

			//Shrinkage!
			if (rand(2) == 0 && player.tallness > 42) {
				outputText("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!");
				player.tallness -= 1 + rand(3);
			}
		}

		//pureHoney moved to BeeHoney.as

		public function succubisDelight(tainted:Boolean,player:Player):void
		{
			player.slimeFeed();
			var changes:Number = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			if (rand(4) == 0) crit += rand(2) + 1;
			var changeLimit:Number = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Generic drinking text
			clearOutput();
			outputText("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (player.cor < 33) outputText("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (player.cor >= 66) outputText("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if ((player.cor < 50 || rand(2)) && tainted) {
				outputText("\n\nThe drink makes you feel... dirty.");
				var mult:Number = 1;
				//Corrupts the uncorrupted faster
				if (player.cor < 50) mult++;
				if (player.cor < 40) mult++;
				if (player.cor < 30) mult++;
				//Corrupts the very corrupt slower
				if (player.cor >= 90) mult = .5;
				if (tainted) dynStats("cor", mult);
				else dynStats("cor", 0);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) == 0 && changes < changeLimit && player.balls > 0) {
				player.ballSize++;
				//They grow slower as they get bigger...
				if (player.ballSize > 10) player.ballSize -= .5;
				//Texts
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your [sack].  Walking becomes difficult as you discover your " + simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
				changes++;
			}
			//Grow new balls!
			if (player.balls < 2 && changes < changeLimit && rand(4) == 0) {
				if (player.balls == 0) {
					player.balls = 2;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [armor].  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					player.ballSize = 1;
				}
				changes++;
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) == 0 && player.cocks.length > 0) {
				if (player.cumMultiplier < 6 && rand(2) == 0 && changes < changeLimit) {
					var max:int = 3;
					//Lots of cum raises cum multiplier cap to 6 instead of 3
					if (player.findPerk(PerkLib.MessyOrgasms) >= 0) max = 6;
					if (max < player.cumMultiplier + .4 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .4 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your body as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your [balls].  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your [cocks], pushed out by the change.");
						dynStats("lib", 1);
					}
					changes++;
				}
			}
			//Fail-safe
			if (changes == 0) {
				outputText("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				player.hoursSinceCum += 100;
				changes++;
			}
			if (player.balls > 0 && rand(3) == 0) {
				outputText(player.modFem(12, 3));
			}
			player.refillHunger(10);
		}

		public function succubisDream(player:Player):void
		{
			player.slimeFeed();
			var changes:Number = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			crit += rand(2) + 1;
			var changeLimit:Number = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Generic drinking text
			clearOutput();
			outputText("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (player.cor < 33) outputText("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (player.cor >= 66) outputText("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if (player.cor < 50 || rand(2)) {
				outputText("\n\nThe drink makes you feel... dirty.");
				var mult:Number = 1;
				//Corrupts the uncorrupted faster
				if (player.cor < 50) mult++;
				if (player.cor < 40) mult++;
				if (player.cor < 30) mult++;
				//Corrupts the very corrupt slower
				if (player.cor >= 90) mult = .5;
				dynStats("cor", mult + 2);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//NEW BALLZ
			if (player.balls < 4) {
				if (player.balls > 0) {
					player.balls = 4;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [armor].  In shock, you barely register the sight before your eyes: <b>You have four balls.</b>");
				}
				if (player.balls == 0) {
					player.balls = 2;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [armor].  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					player.ballSize = 1;
				}
				changes++;
			}
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) == 0 && changes < changeLimit && player.balls > 0 && player.cocks.length > 0) {
				player.ballSize++;
				//They grow slower as they get bigger...
				if (player.ballSize > 10) player.ballSize -= .5;
				//Texts
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your [sack].  Walking becomes difficult as you discover your " + simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) == 0 && player.cocks.length > 0) {
				if (player.cumMultiplier < 6 && rand(2) == 0 && changes < changeLimit) {
					//Temp is the max it can be raised to
					var max:int = 3;
					//Lots of cum raises cum multiplier cap to 6 instead of 3
					if (player.findPerk(PerkLib.MessyOrgasms) >= 0) max = 6;
					if (max < player.cumMultiplier + .4 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .4 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your body as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your [balls].  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your [cocks], pushed out by the change.");
						dynStats("lib", 1);
					}
					changes++;
				}
			}
			//Fail-safe
			if (changes == 0) {
				outputText("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				player.hoursSinceCum += 100;
				changes++;
			}
			if (player.balls > 0 && rand(3) == 0) {
				outputText(player.modFem(12, 5));
			}
			player.refillHunger(15);
		}

		//Oviposition Elixer!
		/*
		 v1 = egg type.
		 v2 = size - 0 for normal, 1 for large
		 v3 = quantity
		 EGG TYPES-
		 0 - brown - ass expansion
		 1 - purple - hip expansion
		 2 - blue - vaginal removal and/or growth of existing maleness
		 3 - pink - dick removal and/or fertility increase.
		 4 - white - breast growth.  If lactating increases lactation.
		 5 - rubbery black
		 6 -
		 */
/* Now handled by OvipositionElixir.as
		public function ovipositionElixer(player:Player):void
		{
			player.slimeFeed();
			var changes:Number = 0;
			//Females!
			clearOutput();
			outputText("You pop the cork and gulp down the thick greenish fluid.  The taste is unusual and unlike anything you've tasted before.");
			if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED) {
				outputText("\n\nFor a moment you feel even more bloated than you already are. That feeling is soon replaced by a dull throbbing pain. It seems that with Valeria's goo filling your womb the ovielixir is unable to work its magic on you.");
				return;
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_WORM_STUFFED) {
				outputText("\n\nFor a moment you feel even more bloated than you already are. That feeling is soon replaced by a dull throbbing pain. It seems that with the worms filling your womb the ovielixir is unable to work its magic on you.");
				return;
			}
			//If player already has eggs, chance of size increase!
			if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				if (player.hasStatusEffect(StatusEffects.Eggs)) {
					//If eggs are small, chance of increase!
					if (player.statusEffectv2(StatusEffects.Eggs) == 0) {
						//1 in 2 chance!
						if (rand(3) == 0) {
							player.addStatusValue(StatusEffects.Eggs,2,1);
							outputText("\n\nYour pregnant belly suddenly feels heavier and more bloated than before.  You wonder what the elixir just did.");
							changes++;
						}
					}
					//Chance of quantity increase!
					if (rand(2) == 0) {
						outputText("\n\nA rumble radiates from your uterus as it shifts uncomfortably and your belly gets a bit larger.");
						player.addStatusValue(StatusEffects.Eggs,3,rand(4) + 1);
						changes++;
					}
				}
			}
			//If the player is not pregnant, get preggers with eggs!
			if (player.pregnancyIncubation == 0) {
				outputText("\n\nThe elixir has an immediate effect on your belly, causing it to swell out slightly as if pregnant.  You guess you'll be laying eggs sometime soon!");
				player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
				//v1 = egg type.
				//v2 = size - 0 for normal, 1 for large
				//v3 = quantity
				player.createStatusEffect(StatusEffects.Eggs, rand(6), 0, (5 + rand(3)), 0);
				changes++;
			}
			//If no changes, speed up pregnancy.
			if (changes == 0 && player.pregnancyIncubation > 20 && player.pregnancyType != PregnancyStore.PREGNANCY_BUNNY) {
				outputText("\n\nYou gasp as your pregnancy suddenly leaps forwards, your belly bulging outward a few inches as it gets closer to time for birthing.");
				var newIncubation:int = player.pregnancyIncubation - int(player.pregnancyIncubation * .3 + 10);
				if (newIncubation < 2) newIncubation = 2;
				player.knockUpForce(player.pregnancyType, newIncubation);
				trace("Pregger Count New total:" + player.pregnancyIncubation);
			}
			player.refillHunger(10);
		}
*/

//butt expansion
		public function brownEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				outputText("You feel a bit of additional weight on your backside as your " + buttDescript() + " gains a bit more padding.");
				player.butt.type++;
				player.refillHunger(20);
			}
			else {
				outputText("Your " + buttDescript() + " wobbles, nearly throwing you off balance as it grows much bigger!");
				player.butt.type += 2 + rand(3);
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modThickness(player.maxThicknessCap(), 8));
				else outputText(player.modThickness((player.maxThicknessCap() * 0.9), 3));
			}

		}

//hip expansion
		public function purpleEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large || player.hips.type > 20) {
				outputText("You stumble as you feel your [hips] widen, altering your gait slightly.");
				player.hips.type++;
				player.refillHunger(20);
			}
			else {
				outputText("You stagger wildly as your hips spread apart, widening by inches.  When the transformation finishes you feel as if you have to learn to walk all over again.");
				player.hips.type += 2 + rand(2);
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modThickness(80, 8));
				else outputText(player.modThickness(80, 3));
			}
		}

//Femminess
		public function pinkEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(1);
					outputText("\n\n");
				}
				//remove balls
				if (player.balls > 0) {
					if (player.ballSize > 15) {
						player.ballSize -= 8;
						outputText("Your scrotum slowly shrinks, settling down at a MUCH smaller size.  <b>Your [balls] are much smaller.</b>\n\n");
					}
					else {
						player.balls = 0;
						player.ballSize = 1;
						outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
					}
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 40) {
					outputText("You feel a tingle deep inside your body, just above your [vagina], as if you were becoming more fertile.\n\n");
					player.fertility += 5;
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(-1);
					outputText("\n\n");
				}
				if (player.balls > 0) {
					player.balls = 0;
					player.ballSize = 1;
					outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 70) {
					outputText("You feel a powerful tingle deep inside your body, just above your [vagina]. Instinctively you know you have become more fertile.\n\n");
					player.fertility += 10;
				}
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modFem(100, 8));
				else outputText(player.modFem(95, 3));
			}
		}

//Maleness
		public function blueEgg(large:Boolean,player:Player):void
		{
			var temp2:Number = 0;
			var temp3:Number = 0;
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Kill pussies!
				if (player.vaginas.length > 0) {
					outputText("\n\nYour vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it! <b> Your vagina is gone!</b>");
					player.removeVagina(0, 1);
					player.clitLength = .5;
				}
				//Dickz
				if (player.cocks.length > 0) {
					//Multiz
					if (player.cocks.length > 1) {
						outputText("\n\nYour " + multiCockDescript() + " fill to full-size... and begin growing obscenely.");
						var cockCount:int = player.cocks.length;
						while (cockCount > 0) {
							cockCount--;
							temp2 = player.increaseCock(cockCount, rand(3) + 2);
							temp3 = player.cocks[cockCount].thickenCock(1);
						}
						player.lengthChange(temp2, player.cocks.length);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("\n\nYour [cocks] spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("\n\nYour [cocks] spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("\n\nYour [cocks] feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("\n\nYour [cocks] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("\n\nYour [cocks] seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("\n\nYour [cocks] seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (player.cocks.length == 1) {
						outputText("\n\nYour [cocks] fills to its normal size... and begins growing... ");
						temp3 = player.cocks[0].thickenCock(1);
						temp2 = player.increaseCock(0, rand(3) + 2);
						player.lengthChange(temp2, 1);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("  Your [cocks] spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("  Your [cocks] spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("  Your [cocks] feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("  Your [cocks] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("  Your [cocks] seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("  Your [cocks] seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}

				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//New lines if changes
				if (player.bRows() > 1 || player.butt.type > 5 || player.hips.type > 5 || player.hasVagina()) outputText("\n\n");
				//Kill pussies!
				if (player.vaginas.length > 0) {
					outputText("Your vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it!\n\n");
					if (player.bRows() > 1 || player.butt.type > 5 || player.hips.type > 5) outputText("  ");
					player.removeVagina(0, 1);
					player.clitLength = .5;
				}
				//Kill extra boobages
				if (player.bRows() > 1) {
					outputText("Your back relaxes as extra weight vanishes from your chest.  <b>Your lowest " + breastDescript(player.bRows() - 1) + " have vanished.</b>");
					if (player.butt.type > 5 || player.hips.type > 5) outputText("  ");
					//Remove lowest row.
					player.removeBreastRow((player.bRows() - 1), 1);
				}
				//Ass/hips shrinkage!
				if (player.butt.type > 5) {
					outputText("Muscles firm and tone as you feel your " + buttDescript() + " become smaller and tighter.");
					if (player.hips.type > 5) outputText("  ");
					player.butt.type -= 2;
				}
				if (player.hips.type > 5) {
					outputText("Feeling the sudden burning of lactic acid in your [hips], you realize they have slimmed down and firmed up some.");
					player.hips.type -= 2;
				}
				//Shrink tits!
				if (player.biggestTitSize() > 0)
				{
					player.shrinkTits();
				}
				if (player.cocks.length > 0) {
					//Multiz
					if (player.cocks.length > 1) {
						outputText("\n\nYour " + multiCockDescript() + " fill to full-size... and begin growing obscenely.  ");
						cockCount = player.cocks.length;
						while (cockCount > 0) {
							cockCount--;
							temp2 = player.increaseCock(cockCount, rand(3) + 5);
							temp3 = player.cocks[cockCount].thickenCock(1.5);
						}
						player.lengthChange(temp2, player.cocks.length);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("\n\nYour [cocks] spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("\n\nYour [cocks] spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("\n\nYour [cocks] feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("\n\nYour [cocks] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("\n\nYour [cocks] seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("\n\nYour [cocks] seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (player.cocks.length == 1) {
						outputText("\n\nYour [cocks] fills to its normal size... and begins growing...");
						temp3 = player.cocks[0].thickenCock(1.5);
						temp2 = player.increaseCock(0, rand(3) + 5);
						player.lengthChange(temp2, 1);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("  Your [cocks] spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("  Your [cocks] spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("  Your [cocks] feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("  Your [cocks] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("  Your [cocks] seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("  Your [cocks] seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
				}
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modFem(0, 8));
				else outputText(player.modFem(5, 3));
			}
		}

//Nipplezzzzz
		public function whiteEgg(large:Boolean,player:Player):void
		{
			var temp2:Number = 0;
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your [armor].  Abruptly you realize they've gotten almost a quarter inch longer.");
					player.nippleLength += .2;
					dynStats("lus", 15);
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your [armor].  Abruptly you realize they've grown more than an additional quarter-inch.");
					player.nippleLength += (rand(2) + 3) / 10;
					dynStats("lus", 15);
				}
				//NIPPLECUNTZZZ
				var index:int = player.breastRows.length;
				//Set nipplecunts on every row.
				while (index > 0) {
					index--;
					if (!player.breastRows[index].fuckable && player.nippleLength >= 2) {
						player.breastRows[index].fuckable = true;
						//Keep track of changes.
						temp2++;
					}
				}
				//Talk about if anything was changed.
				if (temp2 > 0) outputText("\n\nYour [allbreasts] tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>");
				player.refillHunger(60);
			}
		}

		public function blackRubberEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.");
			//Small
			if (!large) {
				//Change skin to normal if not flawless!
				if ((player.skinAdj != "smooth" && player.skinAdj != "latex" && player.skinAdj != "rubber") || player.skinDesc != "skin") {
					outputText("\n\nYour [skin.type] tingles delightfully as it ");
					if (player.hasPlainSkinOnly()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					else if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					else if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					else outputText(" shifts and changes into flawless smooth skin.");
					player.skin.setBaseOnly({type:Skin.PLAIN,adj:"smooth"});
					if (player.skin.base.color == "rough gray") player.skin.base.color = "gray";
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") && player.hairLength != 0) {
						//if skin is already one...
						if (player.skinDesc == "skin" && player.skinAdj == "rubber") {
							outputText("\n\nYour scalp tingles and your [hair] thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hairColor = "rubbery " + player.hairColor;
							dynStats("cor", 2);
						}
						if (player.skinDesc == "skin" && player.skinAdj == "latex") {
							outputText("\n\nYour scalp tingles and your [hair] thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hairColor = "latex-textured " + player.hairColor;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(20);
			}
			//Large
			if (large) {
				//Change skin to latex if smooth.
				if (player.skinDesc == "skin" && player.skinAdj == "smooth") {
					outputText("\n\nYour already flawless smooth skin begins to tingle as it changes again.  It becomes shinier as its texture changes subtly.  You gasp as you touch yourself and realize your skin has become ");
					if (rand(2) == 0) {
						player.skinDesc = "skin";
						player.skinAdj = "latex";
						outputText("a layer of pure latex.  ");
					}
					else {
						player.skinDesc = "skin";
						player.skinAdj = "rubber";
						outputText("a layer of sensitive rubber.  ");
					}
					flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
					if (player.cor < 66) outputText("You feel like some kind of freak.");
					else outputText("You feel like some kind of sexy [skin.type] love-doll.");
					dynStats("spe", -3, "sen", 8, "lus", 10, "cor", 2);
				}
				//Change skin to normal if not flawless!
				if ((player.skinAdj != "smooth" && player.skinAdj != "latex" && player.skinAdj != "rubber") || player.skinDesc != "skin") {
					outputText("\n\nYour [skin.type] tingles delightfully as it ");
					if (player.hasPlainSkinOnly()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					else if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					else if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					else outputText(" shifts and changes into flawless smooth skin.");
					player.skin.setBaseOnly({type:Skin.PLAIN,adj:"smooth"});
					if (player.skin.base.color == "rough gray") player.skin.base.color = "gray";
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") && player.hairLength != 0) {
						//if skin is already one...
						if (player.skinAdj == "rubber" && player.skinDesc == "skin") {
							outputText("\n\nYour scalp tingles and your [hair] thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hairColor = "rubbery " + player.hairColor;
							dynStats("cor", 2);
						}
						if (player.skinAdj == "latex" && player.skinDesc == "skin") {
							outputText("\n\nYour scalp tingles and your [hair] thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hairColor = "latex-textured " + player.hairColor;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(60);
			}
		}

		public function useMarbleMilk(player:Player):void
		{
			player.slimeFeed();
			//Bottle of Marble's milk - item
			//Description: "A clear bottle of milk from Marble's breasts.  It smells delicious.  "
			clearOutput();
			//Text for when the player uses the bottle:
			//[before the player is addicted, Addiction < 30]
			if (player.statusEffectv2(StatusEffects.Marble) < 30 && player.statusEffectv3(StatusEffects.Marble) == 0) outputText("You gulp down the bottle's contents; Marble makes some good tasting milk.\n\n");
			//[before the player is addicted, Addiction < 50]
			else if (player.statusEffectv3(StatusEffects.Marble) <= 0) outputText("You gulp down the bottle's contents; Marble makes some really good tasting milk.\n\n");
			else if (player.statusEffectv3(StatusEffects.Marble) > 0) {
				//[player is completely addicted]
				if (player.findPerk(PerkLib.MarblesMilk) >= 0) outputText("You gulp down the bottle's contents; it's no substitute for the real thing, but it's a nice pick me up.\n\n");
				else {
					//[player is no longer addicted]
					if (player.findPerk(PerkLib.MarbleResistant) >= 0) outputText("You gulp down the bottle's contents; you're careful not to get too attached to the taste.\n\n");
					//[player is addicted]
					else outputText("You gulp down the bottle's contents; you really needed that.\n\n");
				}
			}
			//Increases addiction by 5, up to a max of 50 before the player becomes addicted, no max after the player is addicted.
			SceneLib.marbleScene.marbleStatusChange(0, 5);
			//Does not apply the 'Marble's Milk' effect
			//Purge withdrawl
			if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
				player.removeStatusEffect(StatusEffects.MarbleWithdrawl);
				dynStats("tou", 5, "int", 5);
				outputText("You no longer feel the symptoms of withdrawal.\n\n");
			}
			//Heals the player 70-100 health
			HPChange(70 + rand(31), true);
			//Restores a portion of fatigue (once implemented)
			EngineCore.changeFatigue(-25);
			//If the player is addicted, this item negates the withdrawal effects for a few hours (suggest 6), there will need to be a check here to make sure the withdrawal effect doesn't reactivate while the player is under the effect of 'Marble's Milk'.
			if (player.hasStatusEffect(StatusEffects.BottledMilk)) {
				player.addStatusValue(StatusEffects.BottledMilk, 1, (6 + rand(6)));
			}
			else player.createStatusEffect(StatusEffects.BottledMilk, 12, 0, 0, 0);
			player.refillHunger(20);
		}

		/*Purified LaBova:
		 This will be one of the items that the player will have to give Marble to purify her, but there is a limit on how much she can be purified in this way.
		 Effects on the player:
		 Mostly the same, but without animal transforms, corruption, and lower limits on body changes
		 Hips and ass cap at half the value for LaBova
		 Nipple growth caps at 1 inch
		 Breasts cap at E or DD cup
		 Raises lactation to a relatively low level, reduces high levels: \"Your breasts suddenly feel less full, it seems you aren't lactating at quite the level you where.\"  OR  \"The insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.\"
		 Does not apply the addictive quality
		 If the player has the addictive quality, this item can remove that effect

		 Enhanced LaBova:
		 Something that the player can either make or find later; put it in whenever you want, or make your own item.  This is just a possible suggestion.  If it is given to Marble, she only gains the quad nipples.
		 Effects on the player
		 Mostly the same, but some of the effects can be more pronounced.  Ie, more str gain from one dose, or more breast growth.
		 If the player's nipples are larger than 1 inch in length, this item is guaranteed to give them quad nipples.  This applies to all their breasts; seems like it ould be a good compromise on whether or not cowgirls should have 4 breasts.
		 Very small chance to increase fertility (normally this increase would only happen when the player forces a creature to drink their milk).
		 */
		public function laBova(tainted:Boolean,enhanced:Boolean,player:Player):void
		{
			player.slimeFeed();
			//Changes done
			var changes:Number = 0;
			//Change limit
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			if (enhanced) changeLimit += 2;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//LaBova:
			//ItemDesc: "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.  "
			//ItemUseText:
			clearOutput();
			outputText("You drink the ");
			if (enhanced) outputText("Pro Bova");
			else outputText("La Bova");
			outputText(".  The drink has an odd texture, but is very sweet.  It has a slight aftertaste of milk.");
			//Possible Item Effects:
			//STATS
			//Increase player str:
			if (changes < changeLimit && rand(3) == 0) {
				temp = 60 - player.str;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) == 0) outputText("\n\nThere is a slight pain as you feel your muscles shift somewhat.  Their appearance does not change much, but you feel much stronger.");
					else outputText("\n\nYou feel your muscles tighten and clench as they become slightly more pronounced.");
					dynStats("str", temp / 10);
					changes++;
				}
			}
			//Increase player tou:
			if (changes < changeLimit && rand(3) == 0) {
				temp = 60 - player.tou;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) == 0) outputText("\n\nYou feel your insides toughening up; it feels like you could stand up to almost any blow.");
					else outputText("\n\nYour bones and joints feel sore for a moment, and before long you realize they've gotten more durable.");
					dynStats("tou", temp / 10);
					changes++;
				}
			}
			//Decrease player spd if it is over 30:
			if (changes < changeLimit && rand(3) == 0) {
				if (player.spe > 30) {
					outputText("\n\nThe body mass you've gained is making your movements more sluggish.");
					changes++;
					temp = (player.spe - 30) / 10;
					dynStats("spe", -temp);
				}
			}
			//Increase Corr, up to a max of 50.
			if (tainted) {
				temp = 50 - player.cor;
				if (temp < 0) temp = 0;
				dynStats("cor", temp / 10);
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sex bits - Duderiffic
			if (player.cocks.length > 0 && rand(2) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				//If the player has at least one dick, decrease the size of each slightly,
				outputText("\n\n");
				temp = 0;
				temp2 = player.cocks.length;
				temp3 = 0;
				//Find biggest cock
				while (temp2 > 0) {
					temp2--;
					if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
				}
				//Shrink said cock
				if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
					player.cocks[temp].cockLength -= .5;
					temp3 -= .5;
				}
				temp3 += player.increaseCock(temp, (rand(3) + 1) * -1);
				player.lengthChange(temp3, 1);
				if (player.cocks[temp].cockLength < 2) {
					outputText("  ");
					if (player.cockTotal() == 1 && !player.hasVagina()) {
						outputText("Your [cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.");
						if (player.balls > 0) outputText("  At the same time, your [balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.");
						outputText("  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>");
						player.balls = 0;
						player.ballSize = 1;
						player.createVagina();
						player.clitLength = .25;
						player.removeCock(0, 1);
					}
					else {
						player.killCocks(1);
					}
				}
				//if the last of the player's dicks are eliminated this way, they gain a virgin vagina;
				if (player.cocks.length == 0 && !player.hasVagina()) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.clitLength = .25;
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [vagina]</b>!");
					changes++;
					dynStats("lus", 10);
				}
			}
			//Sex bits - girly
			var boobsGrew:Boolean = false;
			//Increase player's breast size, if they are HH or bigger
			//do not increase size, but do the other actions:
			if (((tainted && player.biggestTitSize() <= 11) || (!tainted && player.biggestTitSize() <= 5)) && changes < changeLimit && (rand(3) == 0 || enhanced)) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
			//-Remove feathery/quill hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) && rand(3) == 0) {
				var word1:String;
				if (player.hairType == Hair.FEATHER) word1 = "feather";
				else word1 = "quill";
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft " + word1 + "-hair droops over your eye.  Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				else outputText("\n\nYou run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your " + word1 + "s.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//-Remove leaf hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && player.hairType == 7 && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your leaf-hair droops over your eye.  Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair.  <b>Your hair is no longer leaf-like!</b>");
				//(short)
				else outputText("\n\nYou run your fingers through your leaf-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your leafs.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer leaf-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//If breasts are D or bigger and are not lactating, they also start lactating:
			if (player.biggestTitSize() >= 4 && player.breastRows[0].lactationMultiplier < 1 && changes < changeLimit && (rand(3) == 0 || boobsGrew || enhanced)) {
				outputText("\n\nYou gasp as your [breasts] feel like they are filling up with something.  Within moments, a drop of milk leaks from your [breasts]; <b> you are now lactating</b>.");
				player.breastRows[0].lactationMultiplier = 1.25;
				changes++;
				dynStats("sen", .5);
			}
			//Quad nipples and other 'special enhanced things.
			if (enhanced) {
				//QUAD DAMAGE!
				if (player.breastRows[0].nipplesPerBreast == 1) {
					changes++;
					player.breastRows[0].nipplesPerBreast = 4;
					outputText("\n\nYour " + nippleDescript(0) + "s tingle and itch.  You pull back your [armor] and watch in shock as they split into four distinct nipples!  <b>You now have four nipples on each side of your chest!</b>");
					if (player.breastRows.length >= 2 && player.breastRows[1].nipplesPerBreast == 1) {
						outputText("A moment later your second row of " + breastDescript(1) + " does the same.  <b>You have sixteen nipples now!</b>");
						player.breastRows[1].nipplesPerBreast = 4;
					}
					if (player.breastRows.length >= 3 && player.breastRows[2].nipplesPerBreast == 1) {
						outputText("Finally, your ");
						if (player.bRows() == 3) outputText("third row of " + breastDescript(2) + " mutates along with its sisters, sprouting into a wonderland of nipples.");
						else if (player.bRows() >= 4) {
							outputText("everything from the third row down mutates, sprouting into a wonderland of nipples.");
							player.breastRows[3].nipplesPerBreast = 4;
							if (player.bRows() >= 5) player.breastRows[4].nipplesPerBreast = 4;
							if (player.bRows() >= 6) player.breastRows[5].nipplesPerBreast = 4;
							if (player.bRows() >= 7) player.breastRows[6].nipplesPerBreast = 4;
							if (player.bRows() >= 8) player.breastRows[7].nipplesPerBreast = 4;
							if (player.bRows() >= 9) player.breastRows[8].nipplesPerBreast = 4;
						}
						player.breastRows[2].nipplesPerBreast = 4;
						outputText("  <b>You have a total of " + num2Text(player.totalNipples()) + " nipples.</b>");
					}
				}
				//QUAD DAMAGE IF WEIRD SHIT BROKE BEFORE
				else if (player.breastRows.length > 1 && player.breastRows[1].nipplesPerBreast == 1) {
					if (player.breastRows[1].nipplesPerBreast == 1) {
						outputText("\n\nYour second row of " + breastDescript(1) + " tingle and itch.  You pull back your [armor] and watch in shock as your " + nippleDescript(1) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your second row of breasts</b>.");
						player.breastRows[1].nipplesPerBreast = 4;
					}
				}
				else if (player.breastRows.length > 2 && player.breastRows[2].nipplesPerBreast == 1) {
					if (player.breastRows[2].nipplesPerBreast == 1) {
						outputText("\n\nYour third row of " + breastDescript(2) + " tingle and itch.  You pull back your [armor] and watch in shock as your " + nippleDescript(2) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your third row of breasts</b>.");
						player.breastRows[2].nipplesPerBreast = 4;
					}
				}
				else if (player.breastRows.length > 3 && player.breastRows[3].nipplesPerBreast == 1) {
					if (player.breastRows[3].nipplesPerBreast == 1) {
						outputText("\n\nYour fourth row of " + breastDescript(3) + " tingle and itch.  You pull back your [armor] and watch in shock as your " + nippleDescript(3) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your fourth row of breasts</b>.");
						player.breastRows[3].nipplesPerBreast = 4;
					}
				}
				else if (player.biggestLactation() > 1) {
					if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your [breasts] start leaking milk from a massive jump in production.");
					else outputText("\n\nSomething shifts inside your [breasts] and they feel MUCH fuller and riper.  You know that you've started producing much more milk.");
					player.boostLactation(2.5);
					if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
						outputText("  Your " + nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
						player.nippleLength += .25;
						dynStats("sen", .5);
					}
					changes++;
				}
			}
			//If breasts are already lactating and the player is not lactating beyond a reasonable level, they start lactating more:
			else {
				if (tainted && player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 5 && changes < changeLimit && (rand(3) == 0 || enhanced)) {
					if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your [breasts] start producing more milk.");
					else outputText("\n\nSomething shifts inside your [breasts] and they feel fuller and riper.  You know that you've started producing more milk.");
					player.boostLactation(0.75);
					if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
						outputText("  Your " + nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
						player.nippleLength += .25;
						dynStats("sen", .5);
					}
					changes++;
				}
				if (!tainted) {
					if (player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 3.2 && changes < changeLimit && rand(3) == 0) {
						if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your [breasts] start producing more milk.");
						else outputText("\n\nSomething shifts inside your [breasts] and they feel fuller and riper.  You know that you've started producing more milk.");
						player.boostLactation(0.75);
						if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
							outputText("  Your " + nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
							player.nippleLength += .25;
							dynStats("sen", .5);
						}
						changes++;
					}
					if ((player.breastRows[0].lactationMultiplier > 2 && player.hasStatusEffect(StatusEffects.Feeder)) || player.breastRows[0].lactationMultiplier > 5) {
						if (rand(2) == 0) outputText("\n\nYour breasts suddenly feel less full, it seems you aren't lactating at quite the level you were.");
						else outputText("\n\nThe insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.");
						changes++;
						dynStats("sen", .5);
						player.boostLactation(-1);
					}
				}
			}
			//If breasts are lactating at a fair level
			//and the player has not received this status,
			//apply an effect where the player really wants
			//to give their milk to other creatures
			//(capable of getting them addicted):
			if (!player.hasStatusEffect(StatusEffects.Feeder) && player.biggestLactation() >= 3 && rand(2) == 0 && player.biggestTitSize() >= 5 && player.cor >= 35) {
				outputText("\n\nYou start to feel a strange desire to give your milk to other creatures.  For some reason, you know it will be very satisfying.\n\n<b>(You have gained the 'Feeder' perk!)</b>");
				player.createStatusEffect(StatusEffects.Feeder, 0, 0, 0, 0);
				player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
				changes++;
			}
			//UNFINISHED
			//If player has addictive quality and drinks pure version, removes addictive quality.
			//if the player has a vagina and it is tight, it loosens.
			if (player.hasVagina()) {
				if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYou feel a relaxing sensation in your groin.  On further inspection you discover your [vagina] has somehow relaxed, permanently loosening.");
					player.vaginas[0].vaginalLooseness++;
					//Cunt Stretched used to determine how long since last enlargement
					if (!player.hasStatusEffect(StatusEffects.CuntStretched)) player.createStatusEffect(StatusEffects.CuntStretched, 0, 0, 0, 0);
					//Reset the timer on it to 0 when restretched.
					else player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
					player.vaginas[0].vaginalLooseness++;
					changes++;
					dynStats("lus", 10);
				}
			}
			//General Appearance (Tail -> Ears -> Paws(fur stripper) -> Face -> Horns
			//Give the player a bovine tail, same as the minotaur
			if (tainted && player.tailType != Tail.COW && player.tailType != Tail.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.tailType == Tail.NONE) outputText("\n\nYou feel the flesh above your " + buttDescript() + " knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				else {
					if (player.tailType < Tail.SPIDER_ADBOMEN || player.tailType > Tail.BEE_ABDOMEN) {
						outputText("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
					}
					//insect
					if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
						outputText("\n\nYour insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.");
					}
				}
				setTailType(Tail.COW);
				changes++;
			}
			//Give the player bovine ears, same as the minotaur
			if (tainted && player.ears.type != Ears.COW && changes < changeLimit && rand(4) == 0 && player.tailType == Tail.COW) {
				outputText("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
				setEarType(Ears.COW);
				changes++;
			}
			//If the player is under 7 feet in height, increase their height, similar to the minotaur
			if (((enhanced && player.tallness < 96) || player.tallness < 84) && changes < changeLimit && rand(2) == 0) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 74) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			//Give the player hoofs, if the player already has hoofs STRIP FUR
			if (tainted && player.lowerBody != LowerBody.HOOFED && player.ears.type == Ears.COW) {
				if (changes < changeLimit && rand(3) == 0) {
					changes++;
					if (player.lowerBody == LowerBody.HUMAN) outputText("\n\nYou stagger as your feet change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					if (player.lowerBody == LowerBody.DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					if (player.lowerBody == LowerBody.NAGA) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
					//Catch-all
					if (player.lowerBody > LowerBody.NAGA) outputText("\n\nYou stagger as your [feet] change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
					setLowerBody(LowerBody.HOOFED);
					player.legCount = 2;
					dynStats("cor", 0);
					changes++;
				}
			}
			//Give the player bovine horns, or increase their size, same as the minotaur
			//New horns or expanding mino horns
			if (tainted && changes < changeLimit && rand(3) == 0 && player.tailType != Tail.GARGOYLE && player.lowerBody == LowerBody.HOOFED) {
				//Get bigger or change horns
				if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.NONE) {
					//Get bigger if player has horns
					if (player.horns.type == Horns.COW_MINOTAUR) {
						if (player.horns.count < 5) {
							//Fems horns don't get bigger.
							outputText("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
							player.horns.count += 1 + rand(2);
							changes++;
						}
					}
					//If no horns yet..
					if (player.horns.type == Horns.NONE || player.horns.count == 0) {
						outputText("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
						setHornType(Horns.COW_MINOTAUR, 1);
						changes++;
					}
					//TF other horns
					if (player.horns.type != Horns.NONE && player.horns.type != Horns.COW_MINOTAUR && player.horns.type != Horns.ORCHID && player.horns.count > 0) {
						outputText("\n\nYour horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.");
						setHornType(Horns.COW_MINOTAUR);
					}
				}
				//Not mino horns, change to cow-horns
				if ((player.horns.type == Horns.DEMON || player.horns.type > Horns.COW_MINOTAUR) && player.horns.type != Horns.ORCHID) {
					outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into two small bovine nubs.");
					setHornType(Horns.COW_MINOTAUR, 2);
					changes++;
				}
			}
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(4) == 0) {
				humanizeArms();
				changes++;
			}
			//If the player's face is non-human, they gain a human face
			if (!enhanced && player.horns.type != Horns.COW_MINOTAUR && player.faceType != Face.HUMAN && changes < changeLimit && rand(4) == 0) {
				//Remove face before fur!
				outputText("\n\nYour visage twists painfully, returning to a normal human shape.  <b>Your face is human again!</b>");
				setFaceType(Face.HUMAN);
				changes++;
			}
			//enhanced get shitty fur
			if (enhanced && (player.skinDesc != "fur" || player.coatColor != "black and white spotted") && player.horns.type != Horns.COW_MINOTAUR && player.lowerBody != LowerBody.GARGOYLE) {
				if (player.skinDesc != "fur") outputText("\n\nYour [skin.type] itches intensely.  You scratch and scratch, but it doesn't bring any relief.  Fur erupts between your fingers, and you watch open-mouthed as it fills in over your whole body.  The fur is patterned in black and white, like that of a cow.  The color of it even spreads to your hair!  <b>You have cow fur!</b>");
				else outputText("\n\nA ripple spreads through your fur as some patches darken and others lighten.  After a few moments you're left with a black and white spotted pattern that goes the whole way up to the hair on your head!  <b>You've got cow fur!</b>");
				player.hairColor = "black";
//				player.hairColor2 = "white"; // TODO 2-color hair
				player.skin.growCoat(Skin.FUR,{
					color:"black",
					color2:"white",
					pattern:Skin.PATTERN_SPOTTED
				});
			}
			//if enhanced to probova give a shitty cow face
			else if (enhanced && player.faceType != Face.COW_MINOTAUR && player.tailType != Tail.GARGOYLE) {
				outputText("\n\nYour visage twists painfully, warping and crackling as your bones are molded into a new shape.  Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>");
				setFaceType(Face.COW_MINOTAUR);
				changes++;
			}
			//Increase the size of the player's hips, if they are not already childbearing or larger
			if (rand(2) == 0 && player.hips.type < 15 && changes < changeLimit) {
				if (!tainted && player.hips.type < 8 || tainted) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.type += 1 + rand(4);
					changes++;
				}
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			//Increase the size of the player's ass (less likely then hips), if it is not already somewhat big
			if (rand(2) == 0 && player.butt.type < 13 && changes < changeLimit) {
				if (!tainted && player.butt.type < 8 || tainted) {
					outputText("\n\nA sensation of being unbalanced makes it difficult to walk.  You pause, paying careful attention to your new center of gravity before understanding dawns on you - your ass has grown!");
					player.butt.type += 1 + rand(2);
					changes++;
				}
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && (player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes < changeLimit && rand(2) == 0) outputText(player.modFem(79, 3));
			if (changes < changeLimit && rand(2) == 0) outputText(player.modThickness(70, 4));
			if (changes < changeLimit && rand(2) == 0) outputText(player.modTone(10, 5));
			player.refillHunger(20);
		}


		public function blackSpellbook(player:Player):void
		{
			clearOutput();
			outputText("You open the small black book, and discover it to be an instructional book on the use of black magic.  Most of it is filled with generic information about black magic - how it is drawn from emotions (typically lust), and how it has the power to affect bodies and emotions.  It also warns against using it on oneself, as it is difficult to draw on your emotions while meddling with your own body.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (player.inte < 30) {
				outputText("\n\nYou feel greatly enlightened by your time spent reading.");
				dynStats("int", 4);
			}
			else if (player.inte < 60) {
				outputText("\n\nSpending some time reading was probably good for you, and you definitely feel smarter for it.");
				dynStats("int", 2);
			}
			else if (player.inte < 90) {
				outputText("\n\nAfter reading the small tome your already quick mind feels invigorated.");
				dynStats("int", 1);
			}
			else {
				outputText("\n\nThe contents of the book did little for your already considerable intellect.");
				dynStats("int", .6);
			}
			//Smart enough for ice spike and doesnt have it
			if (player.inte >= 20 && !player.hasStatusEffect(StatusEffects.KnowsIceSpike)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Ice Spike.</b>");
				player.createStatusEffect(StatusEffects.KnowsIceSpike, 0, 0, 0, 0);
				return;
			}
			//Smart enough for darkness shard and doesnt have it
			if (player.inte >= 25 && !player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Darkness Shard.</b>");
				player.createStatusEffect(StatusEffects.KnowsDarknessShard, 0, 0, 0, 0);
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsArouse)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Arouse.</b>");
				player.createStatusEffect(StatusEffects.KnowsArouse, 0, 0, 0, 0);
				return;
			}
			//Smart enough for regenerate and doesnt have it
			if (player.inte >= 35 && !player.hasStatusEffect(StatusEffects.KnowsRegenerate)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Regenerate.</b>");
				player.createStatusEffect(StatusEffects.KnowsRegenerate, 0, 0, 0, 0);
				return;
			}
			//Smart enough for might and doesnt have it
			if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsMight)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Might.</b>");
				player.createStatusEffect(StatusEffects.KnowsMight, 0, 0, 0, 0);
				return;
			}
			//Smart enough for blink and doesnt have it
			if (player.inte >= 45 && !player.hasStatusEffect(StatusEffects.KnowsBlink)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blink.</b>");
				player.createStatusEffect(StatusEffects.KnowsBlink, 0, 0, 0, 0);
				return;
			}
			//Smart enough for arctic gale and doesnt have it
			if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsArcticGale)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Arctic Gale.</b>");
				player.createStatusEffect(StatusEffects.KnowsArcticGale, 0, 0, 0, 0);
				return;
			}
			//Smart enough for dusk wave and doesnt have it
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsDuskWave)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Dusk Wave.</b>");
				player.createStatusEffect(StatusEffects.KnowsDuskWave, 0, 0, 0, 0);
			}
			//Smart enough for wave of ecstasy and doesnt have it
			if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsWaveOfEcstasy)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Wave of Ecstasy.</b>");
				player.createStatusEffect(StatusEffects.KnowsWaveOfEcstasy, 0, 0, 0, 0);
				return;
			}
		}
		
		public function blackPolarMidnight(player:Player):void
		{
			clearOutput();
			outputText("You open the small scroll, and discover it to be an instructional scroll on the use of grey magic.  Most of it is filled with generic information about grey magic - how it is drawn from both mental focus and emotions (typically lust), is difficult to use when tired and too little or too much aroused, and is used to at the same time create or control energy and affect bodies or emotions to create final effect.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Polar Midnight.</b>");
			player.createStatusEffect(StatusEffects.KnowsPolarMidnight, 0, 0, 0, 0);
		}

		public function greySpellbook(player:Player):void
		{
			clearOutput();
			outputText("You open the grey volume, and discover it to be an instructional book on the use of grey magic.  Most of it is filled with generic information about grey magic - how it is drawn from both mental focus and emotions (typically lust), is difficult to use when tired and too little or too much aroused, and is used to at the same time create or control energy and affect bodies or emotions to create final effect.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (player.inte < 100) {
				outputText("\n\nYou feel greatly enlightened by your time spent reading.");
				dynStats("int", 4);
			}
			else if (player.inte < 150) {
				outputText("\n\nSpending some time reading was probably good for you, and you definitely feel smarter for it.");
				dynStats("int", 2);
			}
			else if (player.inte < 200) {
				outputText("\n\nAfter reading the small tome your already quick mind feels invigorated.");
				dynStats("int", 1);
			}
			else {
				outputText("\n\nThe contents of the book did little for your already considerable intellect.");
				dynStats("int", .6);
			}
			if (player.hasPerk(PerkLib.PrestigeJobGreySage)) {
				//Smart enough for (single target fire spell) and doesnt have it (player.inte >= 120)
				/*if (player.inte >= 150 && !player.hasStatusEffect(StatusEffects.)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: .</b>");
					player.createStatusEffect(StatusEffects., 0, 0, 0, 0);
					return;
				}*/
				//Smart enough for fire storm and doesnt have it
				if (player.inte >= 170 && !player.hasStatusEffect(StatusEffects.KnowsFireStorm)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Fire Storm.</b>");
					player.createStatusEffect(StatusEffects.KnowsFireStorm, 0, 0, 0, 0);
					return;
				}
				//Smart enough for (single target ice spell) and doesnt have it (player.inte >= 120)
				/*if (player.inte >= 150 && !player.hasStatusEffect(StatusEffects.)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: .</b>");
					player.createStatusEffect(StatusEffects., 0, 0, 0, 0);
					return;
				}*/
				//Smart enough for ice rain and doesnt have it
				if (player.inte >= 170 && !player.hasStatusEffect(StatusEffects.KnowsIceRain)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Ice Rain.</b>");
					player.createStatusEffect(StatusEffects.KnowsIceRain, 0, 0, 0, 0);
					return;
				}
				//Smart enough for nosferatu and doesnt have it
				if (player.inte >= 170 && !player.hasStatusEffect(StatusEffects.KnowsNosferatu)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Nosferatu.</b>");
					player.createStatusEffect(StatusEffects.KnowsNosferatu, 0, 0, 0, 0);
					return;
				}
				//Smart enough for mana shield and doesnt have it
				if (player.inte >= 190 && !player.hasStatusEffect(StatusEffects.KnowsManaShield)) {
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Mana Shield.</b>");
					player.createStatusEffect(StatusEffects.KnowsManaShield, 0, 0, 0, 0);
				}
			}
		}

		public function whiteSpellbook(player:Player):void
		{
			clearOutput();
			outputText("You open the white tome, and discover it to be an instructional book on the use of white magic.  Most of it is filled with generic information about white magic - how it is drawn for mental focus, is difficult to use when tired or aroused, and can be used to create and control energy.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (player.inte < 30) {
				outputText("\n\nYou feel greatly enlightened by your time spent reading.");
				dynStats("int", 4);
			}
			else if (player.inte < 60) {
				outputText("\n\nSpending some time reading was probably good for you, and you definitely feel smarter for it.");
				dynStats("int", 2);
			}
			else if (player.inte < 90) {
				outputText("\n\nAfter reading the small tome your already quick mind feels invigorated.");
				dynStats("int", 1);
			}
			else {
				outputText("\n\nThe contents of the book did little for your already considerable intellect.");
				dynStats("int", .6);
			}
			//Smart enough for whitefire and doesnt have it
			if (player.inte >= 20 && !player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Whitefire.</b>");
				player.createStatusEffect(StatusEffects.KnowsWhitefire, 0, 0, 0, 0);
				return;
			}
			//Smart enough for lightning bolt and doesnt have it
			if (player.inte >= 25 && !player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Lightning Bolt.</b>");
				player.createStatusEffect(StatusEffects.KnowsLightningBolt, 0, 0, 0, 0);
				return;
			}
			//Smart enough for charge weapon and doesnt have it
			if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsCharge)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Weapon.</b>");
				player.createStatusEffect(StatusEffects.KnowsCharge, 0, 0, 0, 0);
				return;
			}
			//Smart enough for charge armor and doesnt have it
			if (player.inte >= 35 && !player.hasStatusEffect(StatusEffects.KnowsChargeA)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Armor.</b>");
				player.createStatusEffect(StatusEffects.KnowsChargeA, 0, 0, 0, 0);
				return;
			}
			//Smart enough for heal and doesnt have it
			if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsHeal)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Heal.</b>");
				player.createStatusEffect(StatusEffects.KnowsHeal, 0, 0, 0, 0);
				return;
			}
			//Smart enough for blind and doesnt have it
			if (player.inte >= 45 && !player.hasStatusEffect(StatusEffects.KnowsBlind)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blind.</b>");
				player.createStatusEffect(StatusEffects.KnowsBlind, 0, 0, 0, 0);
				return;
			}
			//Smart enough for pyre burst and doesnt have it
			if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsPyreBurst)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Pyre Burst.</b>");
				player.createStatusEffect(StatusEffects.KnowsPyreBurst, 0, 0, 0, 0);
				return;
			}
			//Smart enough for chain lightning and doesnt have it
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsChainLighting)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Chain Lighting.</b>");
				player.createStatusEffect(StatusEffects.KnowsChainLighting, 0, 0, 0, 0);
				return;
			}
			//Smart enough for blizzard and doesnt have it
			if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsBlizzard)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blizzard.</b>");
				player.createStatusEffect(StatusEffects.KnowsBlizzard, 0, 0, 0, 0);
			}
		}

		public function lustDraft(fuck:Boolean,player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You drink the ");
			if (fuck) outputText("red");
			else outputText("pink");
			outputText(" potion, and its unnatural warmth immediately flows to your groin.");
			dynStats("lus", (30 + rand(player.lib / 10)), "scale", false);

			//Heat/Rut for those that can have them if "fuck draft"
			if (fuck) {
				//Try to go into intense heat.
				player.goIntoHeat(true, 2);
				//Males go into rut
				player.goIntoRut(true);
			}
			//ORGAZMO
			if (player.lust >= player.maxLust() && !CoC.instance.inCombat) {
				outputText("\n\nThe arousal from the potion overwhelms your senses and causes you to spontaneously orgasm.  You rip off your [armor] and look down as your ");
				if (player.cocks.length > 0) {
					outputText(multiCockDescriptLight() + " erupts in front of you, liberally spraying the ground around you");
				}
				if (player.cocks.length > 0 && player.vaginas.length > 0) {
					outputText("At the same time your ");
				}
				if (player.vaginas.length > 0) {
					outputText(vaginaDescript(0) + " soaks your thighs");
				}
				if (player.gender == 0) outputText("body begins to quiver with orgasmic bliss");
				if (player.findPerk(PerkLib.ElectrifiedDesire) >= 0 || player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) outputText(" with charged, glowing, plasma");
				outputText(".  Once you've had a chance to calm down, you notice that the explosion of pleasure you just experienced has rocked you to your core.  You are a little hornier than you were before.");
				//increase player libido, and maybe sensitivity too?
				player.orgasm();
				dynStats("lib", 2, "sen", 1);
				if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) player.addStatusValue(StatusEffects.RaijuLightningStatus,1,24);
			}
			if (player.lust > player.maxLust()) player.lust = player.maxLust();
			outputText("\n\n");
			player.refillHunger(5);
		}

		public function goblinAle(player:Player):void
		{
			player.slimeFeed();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			if (rand(5) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			clearOutput();
			outputText("You drink the ale, finding it to have a remarkably smooth yet potent taste.  You lick your lips and sneeze, feeling slightly tipsy.");
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			dynStats("lus", 15);
			//Stronger
			if (player.str > 50 && rand(3) == 0 && changes < changeLimit) {
				dynStats("str", -1);
				if (player.str > 70) dynStats("str", -1);
				if (player.str > 90) dynStats("str", -2);
				outputText("\n\nYou feel a little weaker, but maybe it's just the alcohol.");
				changes++;
			}
			///Less tough
			if (player.tou > 50 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nGiggling, you poke yourself, which only makes you giggle harder when you realize how much softer you feel.");
				dynStats("tou", -1);
				if (player.tou > 70) dynStats("tou", -1);
				if (player.tou > 90) dynStats("tou", -2);
				changes++;
			}
			//Speed boost
			if (player.spe < 50 && rand(3) == 0 && changes < changeLimit) {
				dynStats("spe", 1 + rand(2));
				outputText("\n\nYou feel like dancing, and stumble as your legs react more quickly than you'd think.  Is the alcohol slowing you down or are you really faster?  You take a step and nearly faceplant as you go off balance.  It's definitely both.");
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Shrink
			if (rand(2) == 0 && player.tallness > 42) {
				changes++;
				outputText("\n\nThe world spins, and not just from the strength of the drink!  Your viewpoint is closer to the ground.  How fun!");
				player.tallness -= (1 + rand(5));
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//SEXYTIEMS
			//Multidick killa!
			if (player.cocks.length > 1 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				player.killCocks(1);
				changes++;
			}
			//Shrink primary dick to no longer than 12 inches
			else if (player.cocks.length == 1 && rand(2) == 0 && changes < changeLimit && !flags[kFLAGS.HYPER_HAPPY]) {
				if (player.cocks[0].cockLength > 12) {
					changes++;
					var temp3:Number = 0;
					outputText("\n\n");
					//Shrink said cock
					if (player.cocks[0].cockLength < 6 && player.cocks[0].cockLength >= 2.9) {
						player.cocks[0].cockLength -= .5;
						temp3 -= .5;
					}
					temp3 += player.increaseCock(0, (rand(3) + 1) * -1);
					player.lengthChange(temp3, 1);
				}
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && (player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes < changeLimit && rand(4) == 0 && ((player.ass.analWetness > 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) || player.ass.analWetness > 1)) {
				outputText("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				player.ass.analWetness--;
				if (player.ass.analLooseness > 1) player.ass.analLooseness--;
				changes++;
			}
			//Boost vaginal capacity without gaping
			if (changes < changeLimit && rand(3) == 0 && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 40) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				outputText("\n\nThere is a sudden... emptiness within your [vagina].  Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Boost fertility
			if (changes < changeLimit && rand(4) == 0 && player.fertility < 40 && player.hasVagina()) {
				player.fertility += 2 + rand(5);
				changes++;
				outputText("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you're ready to be a mother.");
			}
			//GENERAL APPEARANCE STUFF BELOW
			//antianemone corollary:
			if (changes < changeLimit && player.hairType == 4 && rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the potent ale, your head begins to feel heavier - and not just from the alcohol!  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels smooth, silky, and fibrous; you watch as it dissolves into many thin, hair-like strands.  <b>Your hair is now back to normal!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(4) == 0) {
				humanizeArms();
				changes++;
			}
			//Removes wings!
			if ((player.wings.type == Wings.BEE_LIKE_SMALL || player.wings.type == Wings.BEE_LIKE_LARGE || player.wings.type >= Wings.HARPY) && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour shoulders tingle, feeling lighter.  Something lands behind you with a 'thump', and when you turn to look you see your wings have fallen off.  This might be the best (and worst) booze you've ever had!  <b>You no longer have wings!</b>");
				setWingType(Wings.NONE, "non-existant");
				changes++;
			}
			//Removes antennaes!
			if (player.antennae.type > Antennae.NONE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour [hair] itches so you give it a scratch, only to have your antennae.type fall to the ground.  What a relief.  <b>You've lost your antennae.type!</b>");
				changes++;
				player.antennae.type = Antennae.NONE;
			}
			var goblin_eyes_color:Array = ["red", "yellow", "purple"];
			if (player.eyes.type == Eyes.HUMAN && (player.eyes.colour != "red" || player.eyes.colour != "yellow" || player.eyes.colour != "purple") && changes < changeLimit && rand(3) == 0) {
				player.eyes.colour = randomChoice(goblin_eyes_color);
				outputText("\n\nBright lights flash into your vision as your eyes glow with light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>[eyecolor] human eyes staring back at you.</b>");
				changes++;
			}
			var goblin_hair_color:Array = ["red", "purple", "green", "blue", "pink"];
			if ((player.hairColor != "red" || player.hairColor != "yellow" || player.hairColor != "purple") && (player.hairColor.indexOf("rubbery") != -1 || player.hairColor.indexOf("latex-textured") != -1) && changes < changeLimit && rand(3) == 0) {
				player.hairColor = randomChoice(goblin_hair_color);
				outputText("\n\nYour scalp tingles and when you check yourself in nearby steam it seems your <b>[hair] become " + player.hairColor + ".</b>");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.bRows() > 1 && rand(3) == 0) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//Skin/fur
			if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(4) == 0 && player.faceType == Face.HUMAN) {
				humanizeSkin();
				changes++;
			}
			//skinTone
			if (player.skinTone != "green" && player.skinTone != "grayish-blue" && player.skinTone != "dark green" && player.skinTone != "pale yellow" && !player.isGargoyle() && changes < changeLimit && rand(2) == 0) {
				if (rand(10) != 0) {
					if (rand(4) != 0) player.skinTone = "dark green";
					else player.skinTone = "green";
				}
				else {
					if (rand(2) == 0) player.skinTone = "pale yellow";
					else player.skinTone = "grayish-blue";
				}
				changes++;
				outputText("\n\nWhoah, that was weird.  You just hallucinated that your ");
				if (player.hasFur()) outputText("skin");
				else outputText(player.skinDesc);
				outputText(" turned " + player.skinTone + ".  No way!  It's staying, it really changed color!");
			}
			//Face!
			if ((player.faceType != Face.HUMAN || player.faceType != Face.ANIMAL_TOOTHS) && changes < changeLimit && rand(4) == 0 && player.ears.type == Ears.ELFIN) {
				if (player.faceType != Face.ANIMAL_TOOTHS) {
					outputText("You feel your some of your tooths changing, elongating into sharper dagger like form. Funnily, your face remained fully human even after the change.  <b>Your mouth is now a cross over between animal and human!</b>");
					setFaceType(Face.ANIMAL_TOOTHS);
				}
				else {
					outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look.  <b>You have a human looking face again!</b>");
					setFaceType(Face.HUMAN);
				}
				changes++;
			}
			//Ears!
			if (player.ears.type != Ears.ELFIN && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
				setEarType(Ears.ELFIN);
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			if (changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) player.modFem(85, 3);
				if (rand(2) == 0) player.modThickness(20, 3);
				if (rand(2) == 0) player.modTone(15, 5);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function gooGasmic(player:Player):void
		{
			clearOutput();
			outputText("You take the wet cloth in hand and rub it over your body, smearing the strange slime over your [skin.type] slowly.");
			//Stat changes
			//libido up to 80
			if (player.lib < 80) {
				dynStats("lib", (.5 + (90 - player.lib) / 10), "lus", player.lib / 2);
				outputText("\n\nBlushing and feeling horny, you make sure to rub it over your chest and erect nipples, letting the strange slimy fluid soak into you.");
			}
			//sensitivity moves towards 50
			if (player.sens < 50) {
				outputText("\n\nThe slippery slime soaks into your [skin.type], making it tingle with warmth, sensitive to every touch.");
				dynStats("sen", 1);
			}
			else if (player.sens > 50) {
				outputText("\n\nThe slippery slime numbs your [skin.type] slightly, leaving behind only gentle warmth.");
				dynStats("sen", -1);
			}
			/*Calculate goopiness
			 var goopiness:Number = 0;
			 if(player.skinType == GOO) goopiness+=2;
			 if(player.hair.indexOf("gooey") != -1) goopiness++;
			 if(player.hasVagina()) {
			 if(player.vaginalCapacity() >= 9000) goopiness++;
			 }*/
			//Cosmetic changes based on 'goopyness'
			//Remove wings
			if (player.wings.type > Wings.NONE) {
				outputText("\n\nYou sigh, feeling a hot wet tingling down your back.  It tickles slightly as you feel your wings slowly turn to sludge, dripping to the ground as your body becomes more goo-like.");
				setWingType(Wings.NONE, "non-existant");
				return;
			}
			//Human face
			if (player.faceType != Face.HUMAN && rand(2) == 0) {
				outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look.  <b>You have a human looking face again!</b>");
				setFaceType(Face.HUMAN);
				return;
			}
			//Goopy hair
			if (player.hairType != 3 && !player.isGargoyle()) {
				setHairType(Hair.GOO);
				//if bald
				if (player.hairLength <= 0) {
					outputText("\n\nYour head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover you've grown some kind of gooey hair.  From time to time it drips, running down your back to the crack of your " + buttDescript() + ".");
					player.hairLength = 5;
				}
				else {
					//if hair isnt rubbery or latexy
					if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") == -1) {
						outputText("\n\nYour head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover your hair has become a slippery, gooey mess.  From time to time it drips, running down your back to the crack of your " + buttDescript() + ".");
					}
					//Latexy stuff
					else {
						outputText("\n\nYour oddly inorganic hair shifts, becoming partly molten as rivulets of liquid material roll down your back.  How strange.");
					}
				}
				if (player.hairColor != "green" && player.hairColor != "purple" && player.hairColor != "blue" && player.hairColor != "cerulean" && player.hairColor != "emerald") {
					outputText("  Stranger still, the hue of your semi-liquid hair changes to ");
					var blah:int = rand(10);
					if (blah <= 2) player.hairColor = "green";
					else if (blah <= 4) player.hairColor = "purple";
					else if (blah <= 6) player.hairColor = "blue";
					else if (blah <= 8) player.hairColor = "cerulean";
					else player.hairColor = "emerald";
					outputText(player.hairColor + ".");
				}
				dynStats("lus", 10);
				return;
			}
			//1.Goopy skin
			if (player.hairType == 3 && !player.hasGooSkin()) {
				if (player.hasPlainSkinOnly()) outputText("\n\nYou sigh, feeling your [armor] sink into you as your skin becomes less solid, gooey even.  You realize your entire body has become semi-solid and partly liquid!");
				else if (player.hasFur()) outputText("\n\nYou sigh, suddenly feeling your fur become hot and wet.  You look down as your [armor] sinks partway into you.  With a start you realize your fur has melted away, melding into the slime-like coating that now serves as your skin.  You've become partly liquid and incredibly gooey!");
				else if (player.hasScales()) outputText("\n\nYou sigh, feeling slippery wetness over your scales.  You reach to scratch it and come away with a slippery wet coating.  Your scales have transformed into a slimy goop!  Looking closer, you realize your entire body has become far more liquid in nature, and is semi-solid.  Your [armor] has even sunk partway into you.");
				else if (player.skin.base.type != Skin.GOO) outputText("\n\nYou sigh, feeling your [armor] sink into you as your [skin] becomes less solid, gooey even.  You realize your entire body has become semi-solid and partly liquid!");
				player.skin.setBaseOnly({adj:"slimy",type:Skin.GOO});
				if (!InCollection(player.skin.base.color,gooSkinColors)) {
					player.skin.base.color = randomChoice(gooSkinColors);
					outputText("  Stranger still, your skintone changes to [skin color]!");
				}
				return;
			}
			////1a.Make alterations to dick/vaginal/nippular descriptors to match
			//DONE EXCEPT FOR TITS & MULTIDICKS (UNFINISHED KINDA)
			//2.Goo legs
			if (player.skinAdj == "slimy" && player.skinDesc == "skin" && player.lowerBody != LowerBody.GOO && player.lowerBody != LowerBody.GARGOYLE) {
				outputText("\n\nYour viewpoint rapidly drops as everything below your " + buttDescript() + " and groin melts together into an amorphous blob.  Thankfully, you discover you can still roll about on your new slimey undercarriage, but it's still a whole new level of strange.");
				player.tallness -= 3 + rand(2);
				if (player.tallness < 36) {
					player.tallness = 36;
					outputText("  The goo firms up and you return to your previous height.  It would truly be hard to get any shorter than you already are!");
				}
				setLowerBody(LowerBody.GOO);
				player.legCount = 1;
				return;
			}
			//3a. Grow vagina if none
			if (!player.hasVagina() && player.lowerBody != LowerBody.GARGOYLE) {
				outputText("\n\nA wet warmth spreads through your slimey groin as a narrow gash appears on the surface of your groin.  <b>You have grown a vagina.</b>");
				player.createVagina();
				player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_DROOLING;
				player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;
				player.clitLength = .4;
				return;

			}
			//3b.Infinite Vagina
			if (player.vaginalCapacity() < 9000) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 9000, 0, 0, 0);
				else player.addStatusValue(StatusEffects.BonusVCapacity, 1, 9000);
				outputText("\n\nYour [vagina]'s internal walls feel a tingly wave of strange tightness.  Experimentally, you slip a few fingers, then your hand, then most of your forearm inside yourself.  <b>It seems you're now able to accommodate just about ANYTHING inside your sex.</b>");
				return;
			}
			else if (player.tallness < 100 && rand(3) <= 1) {
				outputText("\n\nYour gel-like body swells up from the intake of additional slime.  If you had to guess, you'd bet you were about two inches taller.");
				player.tallness += 2;
				dynStats("str", 1, "tou", 1);
			}
			//Big slime girl
			else {
				if (!player.hasStatusEffect(StatusEffects.SlimeCraving)) {
					outputText("\n\nYou feel a growing gnawing in your gut.  You feel... hungry, but not for food.  No, you need something wet and goopy pumped into you.  You NEED it.  You can feel it in your bones.  <b>If you don't feed that need... you'll get weaker and maybe die.</b>");
					player.createStatusEffect(StatusEffects.SlimeCraving, 0, 0, 0, 1); //Value four indicates this tracks strength and speed separately
				}
				else {
					outputText("\n\nYou feel full for a moment, but you know it's just a temporary respite from your constant need to be 'injected' with fluid.");
					player.changeStatusValue(StatusEffects.SlimeCraving, 1, 0);
				}
			}
			if (rand(2) == 0) outputText(player.modFem(85, 3));
			if (rand(2) == 0) outputText(player.modThickness(20, 3));
			if (rand(2) == 0) outputText(player.modTone(15, 5));
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}


		public function sharkTooth(type:Number,player:Player):void
		{
			var changes:Number = 0;
			var changeLimit:Number = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			if (type == 0) {
				clearOutput();
				outputText("You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.");
			}else if (type == 1) {
				clearOutput();
				outputText("You have no idea why, but you decide to eat the pointed, glowing tooth. To your surprise, it's actually quite brittle, crumbling into a fishy-tasting dust. Maybe it's just a tablet made to look like a shark's tooth.");
			}
			//STATS
			//Increase strength 1-2 points (Up to 50) (60 for tiger)
			if (((player.str < 60 && type == 1) || player.str < 50) && rand(3) == 0) {
				dynStats("str", 1 + rand(2));
				outputText("\n\nA painful ripple passes through the muscles of your body.  It takes you a few moments, but you quickly realize you're a little bit stronger now.");
				changes++;
			}
			//Increase Speed 1-3 points (Up to 75) (100 for tigers)
			if (((player.spe < 100 && type == 1) || player.spe < 75) && rand(3) == 0) {
				dynStats("spe", 1 + rand(3));
				changes++;
				outputText("\n\nShivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.");
			}
			//Reduce sensitivity 1-3 Points (Down to 25 points)
			if (player.sens > 25 && rand(1.5) == 0 && changes < changeLimit) {
				dynStats("sen", (-1 - rand(3)));
				changes++;
				outputText("\n\nIt takes a while, but you eventually realize your body has become less sensitive.");
			}
			//Increase Libido 2-4 points (Up to 75 points) (100 for tigers)
			if (((player.lib < 100 && type == 1) || player.lib < 75) && rand(3) == 0 && changes < changeLimit) {
				dynStats("lib", (1 + rand(3)));
				changes++;
				outputText("\n\nA blush of red works its way across your skin as your sex drive kicks up a notch.");
			}
			//Decrease intellect 1-3 points (Down to 40 points)
			if (player.inte > 40 && rand(3) == 0 && changes < changeLimit) {
				dynStats("int", -(1 + rand(3)));
				changes++;
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
			}
			//Smexual stuff!
			//-TIGGERSHARK ONLY: Grow a cunt (guaranteed if no gender)
			if (type == 1 && (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) == 0))) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.clitLength = .25;
				dynStats("sen", 10);
			}
			//WANG GROWTH - TIGGERSHARK ONLY
			if (type == 1 && (!player.hasCock()) && changes < changeLimit && rand(3) == 0) {
				//Genderless:
				if (!player.hasVagina()) outputText("\n\nYou feel a sudden stabbing pain in your featureless crotch and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of a new human-shaped penis");
				//Female:
				else outputText("\n\nYou feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of not only a [vagina], but a new human-shaped penis");
				if (player.balls == 0) {
					outputText(" and a pair of balls");
					player.balls = 2;
					player.ballSize = 2;
				}
				outputText("!");
				player.createCock(7, 1.4);
				dynStats("lib", 4, "sen", 5, "lus", 20);
				changes++;
			}
			//(Requires the player having two testicles)
			if (type == 1 && (player.balls == 0 || player.balls == 2) && player.hasCock() && changes < changeLimit && rand(3) == 0) {
				if (player.balls == 2) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your [sack], your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>");
					player.balls = 4;
				}
				else if (player.balls == 0) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>");
					player.balls = 2;
					player.ballSize = 2;
				}
				dynStats("lib", 2, "sen", 3, "lus", 10);
				changes++;
			}
			//Transformations:
			//Mouth TF
			if (player.faceType != Face.SHARK_TEETH && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.faceType > Face.HUMAN && player.faceType != Face.SHARK_TEETH) outputText("Your [face] explodes with agony, reshaping into a more human-like visage.  ");
				outputText("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.\n(Gain: 'Bite' special attack)");
				setFaceType(Face.SHARK_TEETH);
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type != Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//Tail TF
			if (player.tailType != Tail.SHARK && player.tailType != Tail.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.tailType == Tail.NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.");
				else outputText("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.");
				setTailType(Tail.SHARK);
			}
			//Gills TF
			if (player.gills.type != Gills.FISH && player.tailType == Tail.SHARK && player.faceType == Face.SHARK_TEETH && changes < changeLimit && rand(3) == 0)
				updateGills(Gills.FISH);
			//Hair
			if (player.hairColor != "silver" && player.tailType != Tail.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				changes++;
				outputText("\n\nYou feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!");
				player.hairColor = "silver";
			}
			//Skin
			if (((player.skinTone != "rough gray" && player.skinTone != "orange and black striped") || !player.hasScales()) && !player.isGargoyle() && rand(7) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.hasFur()) outputText("Your [skin.type] falls out, collecting on the floor and exposing your scale covered skin underneath.  ");
				else if (player.hasGooSkin()) outputText("Your gooey skin solidifies, thickening up as your body starts to solidy into a more normal form. ");
				else if (player.hasScales()) outputText("Your skin itches and tingles starting to sheed your current scales. Underneath them you can see new smaller gray colored scales.  ");
				else if (player.hasCoat()) outputText("Your skin itches and tingles starting to sheed your [skin coat]. Underneath them you can see new smaller gray colored scales.  ");
				else outputText("You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and became covered with a tiny shiny grey scales.  ");
				if (type == 0) {
					outputText("It feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.");
					player.skin.growCoat(Skin.SCALES,{color:"rough gray"});
					changes++;
				}
				else {
					outputText("Your scales begins to tingle and itch, before rapidly shifting to a shiny orange color, marked by random black scales looking like a stripes. You take a quick look in a nearby pool of water, to see your skin has morphed in appearance and texture to become more like a tigershark!");
					player.skin.growCoat(Skin.SCALES,{color:"orange and black"});
					changes++;
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedScales)) {
					outputText("\n\n<b>Genetic Memory: Scales - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedScales, 0, 0, 0, 0);
				}
			}
			//Legs
			if (player.lowerBody == LowerBody.HUMAN && player.lowerBody != LowerBody.SHARK && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel something change in your feets as webing form between your toes. Well this is sure to help you swim faster. <b>You now have webed feet!</b>");
				setLowerBody(LowerBody.SHARK);
				changes++;
			}
			if (player.lowerBody != LowerBody.SHARK && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				humanizeLowerBody();
				changes++;
			}
			//Arms
			if (player.lowerBody == LowerBody.SHARK && !InCollection(player.arms.type, Arms.SHARK, Arms.GARGOYLE) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form with exception places between your finger which starting show signs to growing webbing. Soon after you start sweating profusely and panting loudly, feeling the space near your elbows shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from your forearms. You examine them carefully and make a few modifications to your [armor] to accommodate your new fins. <b>You now have shark arms.</b>");
				setArmType(Arms.SHARK);
				changes++;
			}
			//FINZ
			if (player.rearBody.type != RearBody.SHARK_FIN && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				outputText("You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [armor] to accommodate your new fin.");
				setRearBody(RearBody.SHARK_FIN);
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nNothing happened.  Weird.");
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//9)  Transformation Item - Snake Oil (S. Oil)
		/*Effects:
		  Boosts Speed stat
		  Ass reduction
		  Testicles return inside your body (could be reverted by the use of succubi delight)
		  Can change penis into reptilian form  (since there's a lot of commentary here not knowing where to go, let me lay it out.)
		 the change will select one cock (randomly if you have multiple)
		 said cock will become two reptilian cocks
		 these can then be affected separately, so if someone wants to go through the effort of removing one and leaving themselves with one reptile penis, they have the ability to do that
		 This also means that someone who's already reached the maximum numbers of dicks cannot get a reptilian penis unless they remove one first
		 "Your reptilian penis is X.X inches long and X.X inches thick.  The sheath extends halfway up the shaft, thick and veiny, while the smooth shaft extends out of the sheath coming to a pointed tip at the head. "
		  Grow poisonous fangs (grants Poison Bite ability to player, incompatible with the sting ability, as it uses the same poison-meter)
		  Causes your tongue to fork
		  Legs fuse together and dissolve into snake tail  (grants Constrict ability to player, said tail can only be covered in scales, independently from the rest of the body)
		  If snake tail exists:
		    Make it longer, possibly larger (tail length is considered independently of your height, so it doesn't enable you to use the axe, for instance.
		    Change tail's color according to location
		      [Smooth] Beige and Tan (Desert), [Rough] Brown and Rust (Mountains), [Lush]  Forest Green and Yellow (Forest), [Cold] Blue and White (ice land?), [Fresh] Meadow Green [#57D53B - #7FFF00] and Dark Teal [#008080] (lake) , [Menacing] Black and Red (Demon realm, outside encounters), [Distinguished] Ivory (#FFFFF0) and Royal Purple/Amethyst (#702963) (Factory), [Mossy] Emerald and Chestnut (Swamp), [Arid] Orange and Olive pattern (Tel' Adre)

		 9a) Item Description
		 "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable."
		 */

		public function snakeOil(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//b) Description while used
			outputText("Pinching your nose, you quickly uncork the vial and bring it to your mouth, determined to see what effects it might have on your body. Pouring in as much as you can take, you painfully swallow before going for another shot, emptying the bottle.");
			//(if outside combat)
			if (!CoC.instance.inCombat) outputText("  Minutes pass as you start wishing you had water with you, to get rid of the aftertaste.");
			//+ speed to 70!
			if (player.spe < 70 && rand(2) == 0) {
				dynStats("spe", (2 - (player.spe / 10 / 5)));
				outputText("\n\nYour muscles quiver, feeling ready to strike as fast as a snake!");
				if (player.spe < 40) outputText("  Of course, you're nowhere near as fast as that.");
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Removes wings
			if (!InCollection(player.wings.type, Wings.NONE, Wings.GARGOYLE_LIKE_LARGE) && rand(3) == 0 && changes < changeLimit) {
				removeWings();
				changes++;
			}
			//Removes antennae.type
			if (player.antennae.type > Antennae.NONE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae.type have vanished!");
				player.antennae.type = Antennae.NONE;
				changes++;
			}
			//9c) II The tongue (sensitivity bonus, stored as a perk?)
			if (changes == 0 && player.tongue.type != Tongue.SNAKE && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && rand(3) == 0 && changes < changeLimit) {
				if (player.tongue.type == Tongue.HUMAN) outputText("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.");
				else outputText("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.  By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.");
				setTongueType(Tongue.SNAKE);
				dynStats("sen", 5);
				changes++;
			}
			//9c) III The fangs
			if (changes == 0 && player.tongue.type == Tongue.SNAKE && player.faceType != Face.SNAKE_FANGS && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWithout warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid.  Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>");
				if (player.faceType != Face.HUMAN && player.faceType != Face.SHARK_TEETH && player.faceType != Face.BUNNY && player.faceType != Face.SPIDER_FANGS) {
					outputText("  As the change progresses, your [face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>");
				}
				setFaceType(Face.SNAKE_FANGS);
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				changes++;
			}
			//9c) I The tail ( http://tvtropes.org/pmwiki/pmwiki.php/Main/TransformationIsAFreeAction ) (Shouldn't we try to avert this? -Ace)
			//Should the enemy "kill" you during the transformation, it skips the scene and immediately goes to tthe rape scene. (Now that I'm thinking about it, we should add some sort of appendix where the player realizes how much he's/she's changed. -Ace)
			if (changes == 0 && player.faceType == Face.SNAKE_FANGS && player.lowerBody != LowerBody.NAGA && rand(4) == 0 && changes < changeLimit) {
				if (player.lowerBody == LowerBody.SCYLLA) {
				outputText("\n\nYou collapse as your tentacle legs starts to merge and the pain is immense.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
				}
				else {
				outputText("\n\nYou find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight.");
				//(If used in combat, you lose a turn here. Half-corrupted Jojo and the Naga won't attack you during that period, but other monsters will)
				//FUCK NO
				outputText("\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle.");
				outputText("  The process continues through the length of your [legs], eventually reaching your [feet].  Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
				}
				outputText("\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.");
				if (player.balls > 0 && player.ballSize > 10) outputText("  You're happy not to have to drag those testicles around with you anymore.");
				outputText("  But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.");
				setLowerBody(LowerBody.NAGA);
				player.legCount = 1;
				changes++;
			}
			//Partial scales with color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (!player.hasPartialCoat(Skin.SCALES) && player.lowerBody == LowerBody.NAGA && changes < changeLimit && rand(5) == 0) {
				//(fur)
				var color:String;
				if (rand(10) == 0) {
					color = randomChoice("purple","silver");
				} else {
					color = randomChoice("red","green","white","blue","black");
				}
				if (player.hasFur()) {
					//set new skinTone
					outputText("\n\nYou scratch yourself, and come away with a large clump of [skin coat.color] fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  You feel your skin shift as " + color + " scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.  The rest of the fur is easy to remove.  <b>Your body is now partially covered with small patches of scales!</b>");
				}
				//(no fur)
				else {
					outputText("\n\nYou feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.  <b>Your body is now partially covered with small patches of "+color+" scales.</b>");
				}
				player.skin.growCoat(Skin.SCALES,{color:color},Skin.COVERAGE_LOW);
				changes++;
			}
			//Snake eyes
			if (player.hasPartialCoat(Skin.SCALES) && player.eyes.type != Eyes.SNAKE && rand(4) == 0 && changes < changeLimit) {
				setEyeType(Eyes.SNAKE);
				outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake.  <b>You now have snake eyes!</b>.");
				changes++;
			}
			//Ears!
			if (player.ears.type != Ears.SNAKE && player.eyes.type == Eyes.SNAKE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed ears covered in small scales</b>.  You bet they look cute!");
				changes++;
				setEarType(Ears.SNAKE);
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			//9e) Penis
			/*
			 if(player.cockTotal() > 0) {
			 //(If multiple penis, insert "one of your")
			 outputText("\n\nAs the liquid takes effect, ");
			 //(if multicock)
			 if(player.cockTotal() > 1) outputText("one of ");
			 outputText("your [cocks] starts to throb painfully and swell to its full size.  With a horrifying ripping sensation, your cock splits down the middle, the pain causing you to black out momentarily.");
			 outputText("When you awaken, you quickly look down to see that where ");
			 //(if multicock)
			 if(player.cockTotal() > 1) outputText("one of ");
			 outputText("your [cocks] was, you now have two pointed reptilian cocks, still stiff and pulsing.");
			 }*/
			//Default change - blah
			if (changes == 0) outputText("\n\nRemakarbly, the snake-oil has no effect.  Should you really be surprised at snake-oil NOT doing anything?");
			player.refillHunger(5);
		}

		public function evolvedNagaOil(type:Number,player:Player):void
		{
			//'type' refers to the variety of oil.
			//0 == gorgon oil
			//1 == vouivre oil
			//2 == couatl oil
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("Pinching your nose, you quickly uncork the vial and bring it to your mouth, determined to see what effects it might have on your body. Pouring in as much as you can take, you painfully swallow before going for another shot, emptying the bottle.  Minutes pass as you start wishing you had water with you, to get rid of the ");
			if (type == 0) outputText("aftertaste.");
			if (type == 1 || type == 2) outputText("strange mixed taste.");
			//Speed up to 80!
			if (player.spe < 80 && rand(2) == 0) {
				dynStats("spe", 3);
				outputText("\n\nYour muscles quiver, feeling ready to strike as fast as a snake!");
				if (player.spe < 40) outputText("  Of course, you're nowhere near as fast as that.");
				changes++;
			}
			//Toughness up to 70!
			if (player.tou < 70 && rand(2) == 0) {
				dynStats("tou", 2);
				outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Snake tounge
			if (player.tongue.type != Tongue.SNAKE && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && rand(3) == 0 && changes < changeLimit) {
				if (player.tongue.type == Tongue.HUMAN) outputText("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.");
				else outputText("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.  By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.");
				setTongueType(Tongue.SNAKE);
				dynStats("sen", 5);
				changes++;
			}
			//Dragon tongue
			if (type == 1 && player.tongue.type != Tongue.DRACONIC && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour tongue suddenly falls out of your mouth and begins undulating as it grows longer.  For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb.  You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue.  <b>You now have a draconic tongue.</b>");
				setTongueType(Tongue.DRACONIC);
				changes++;
			}
			//Face with snake fangs
			if (player.tongue.type == Tongue.SNAKE && player.faceType != Face.SNAKE_FANGS && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWithout warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid.  Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>");
				if (player.faceType != Face.HUMAN && player.faceType != Face.SHARK_TEETH && player.faceType != Face.BUNNY && player.faceType != Face.SPIDER_FANGS) {
					outputText("  As the change progresses, your [face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>");
				}
				setFaceType(Face.SNAKE_FANGS);
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				changes++;
			}
			//Snake lower body
			if (player.faceType == Face.SNAKE_FANGS && player.lowerBody != LowerBody.NAGA && rand(4) == 0 && changes < changeLimit) {
				if (player.lowerBody == LowerBody.SCYLLA) {
				outputText("\n\nYou collapse as your tentacle legs starts to merge and the pain is immense.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
				}
				else {
				outputText("\n\nYou find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight.");
				outputText("\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle.");
				outputText("  The process continues through the length of your [legs], eventually reaching your [feet].  Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
				}
				outputText("\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.");
				if (player.balls > 0 && player.ballSize > 10) outputText("  You're happy not to have to drag those testicles around with you anymore.");
				outputText("  But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your <b>newly formed snake tail.</b> You can't help feeling proud of this majestic new body of yours.");
				setLowerBody(LowerBody.NAGA);
				player.legCount = 1;
				changes++;
			}
			//Partial scales with color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (!player.hasPartialCoat(Skin.SCALES) && player.lowerBody == LowerBody.NAGA && changes < changeLimit && rand(5) == 0) {
				//(fur)
				var color:String;
				if (rand(10) == 0) {
					color = randomChoice("purple","silver");
				} else {
					color = randomChoice("red","green","white","blue","black");
				}
				if (player.hasFur()) {
					outputText("\n\nYou scratch yourself, and come away with a large clump of [skin coat.color] fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  You feel your skin shift as " + color + " scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.  The rest of the fur is easy to remove.  <b>Your body is now partially covered with small patches of scales!</b>");
				}
				//(no fur)
				else {
					outputText("\n\nYou feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.  <b>Your body is now partially covered with small patches of "+color+" scales.</b>");
				}
				player.skin.growCoat(Skin.SCALES,{color:color},Skin.COVERAGE_LOW);
				changes++;
			}
			//Snake eyes
			if (player.hasPartialCoat(Skin.SCALES) && player.eyes.type != Eyes.SNAKE && player.eyes.type != Eyes.GORGON && rand(4) == 0 && changes < changeLimit) {
				setEyeType(Eyes.SNAKE);
				outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake.  <b>You now have snake eyes!</b>.");
				changes++;
			}
			//Ears!
			if ((type == 0 || type == 2) && player.ears.type != Ears.SNAKE && player.eyes.type == Eyes.SNAKE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed ears covered in small scales</b>.  You bet they look cute!");
				changes++;
				setEarType(Ears.SNAKE);
			}
			//Gorgon hair
			if (type == 0 && player.ears.type == Ears.SNAKE && player.hairType != Hair.GORGON && changes < changeLimit && rand(4) == 0) {
				if (player.hairLength == 0) outputText("\n\nAt first nothing happening. Then you start to feel tingling at your head scalp.  You run your fingers over head you feel small numbs fast growning up forming something akin to dull spikes.  After brief pause those nubs starts to slowly grown and covered gradualy with....sclaes?");
				else {
					outputText("\n\nYou run your fingers through your [hair] while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your hair.  They're completely changing becoming more thick and slowly covered with delicate....scales?");
					if (player.hairLength < 6) outputText("  Additionaly they seems to lenghten.");
				}
				outputText(" What even more worrisome seems at the ends of each strands form something that is similar to very small snake head.  Taking one of your hair 'strands' confirm your suspicions.  Your hair turned into bunch of tiny snakes similary to those possesed normaly by gorgons.  <b>Your hair turned into thin snakes replacing your current hair!</b>");
				if (player.hairLength < 6) player.hairLength = 6;
				setHairType(Hair.GORGON);
				changes++;
			}
			//Gorgon eyes
			if (type == 0 && player.hairType == Hair.GORGON && player.eyes.type == Eyes.SNAKE && player.eyes.type != Eyes.GORGON && rand(4) == 0 && changes < changeLimit) {
				setEyeType(Eyes.GORGON);
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, all seems to be fine until at least it seems so. But when moment later, when you casualy look at your hands pondering if there is drinking this vial of oil maybe have some other effect the numbing sensation starts to spread starting from your hands fingers. Worried you focus your gaze at them to notice, that they typical texture becoming grey colored much similar to that of... stone? And slowy you realize the more you look at them, the faster change. Panicked for a moment you look away and then this numbing feeling starting to slowly receed. But looking back at them causing it to return. After moment, and closing eyelids, you conclude that your eyes must have gained an useful ability.  <b>Your eyes has turned into gorgon eyes.</b>");
				changes++;
			}
			//-Existing horns become draconic, max of 4, max length of 1'
			if (type == 1 && player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG && player.eyes.type == Eyes.SNAKE && changes < changeLimit && rand(5) == 0) {
				//No dragon horns yet.
				if (player.horns.type != Horns.DRACONIC_X2 && player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG && player.horns.type != Horns.ORCHID) {
					//Already have horns
					if (player.horns.count > 0) {
						//High quantity demon horns
						if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
							outputText("\n\nYour horns condense, twisting around each other and merging into larger, pointed protrusions.  By the time they finish you have four draconic-looking horns, each about twelve inches long.");
							setHornType(Horns.DRACONIC_X4_12_INCH_LONG, 12);
						}
						else {
							outputText("\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
							setHornType(Horns.DRACONIC_X2);
							if (player.horns.count > 13) {
								outputText("  The change seems to have shrunken the horns, they're about a foot long now.");
								player.horns.count = 12;
							}
						}
						changes++;
					}
					//No horns
					else {
						//-If no horns, grow a pair
						outputText("\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horns sprout from your head before stopping.  <b>You have about four inches of dragon-like horns.</b>");
						setHornType(Horns.DRACONIC_X2, 4);
						changes++;
					}
				}
				//ALREADY DRAGON
				else {
					if (player.horns.type == Horns.DRACONIC_X2) {
						if (player.horns.count < 12) {
							if (rand(2) == 0) {
								outputText("\n\nYou get a headache as an inch of fresh horns escapes from your pounding skull.");
								player.horns.count += 1;
							}
							else {
								outputText("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
								player.horns.count += 2 + rand(4);
							}
							if (player.horns.count >= 12) outputText("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
							changes++;
						}
						//maxxed out, new row
						else {
							//--Next horns growth adds second row and brings length up to 12\"
							outputText("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a vouivre can grow.</b>");
							setHornType(Horns.DRACONIC_X4_12_INCH_LONG);
							changes++;
						}
					}
				}
			}
			//Gain Dragon Ears
			if (type == 1 && changes < changeLimit && rand(3) == 0 && player.eyes.type == Eyes.SNAKE && player.ears.type != Ears.DRAGON) {
				setEarType(Ears.DRAGON);
				outputText("\n\nA prickling sensation suddenly fills your ears; unpleasant, but hardly painful.  It grows and grows until you can't stand it any more, and reach up to scratch at them.  To your surprise, you find them melting away like overheated candles.  You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion.  Then, all of a sudden, hearing returns to you.  Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head.  A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins.  With a little patience, you begin to adjust these fins just like ears to aid your hearing.  <b>You now have dragon ears!</b>");
				changes++;
			}
			//Grow Dragon Wings
			if (type == 1 && player.wings.type != Wings.DRACONIC_HUGE && player.ears.type == Ears.DRAGON && changes < changeLimit && rand(3) == 0) {
				if (player.wings.type == Wings.NONE) {
					outputText("\n\nYou double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning.  A sudden sound of tearing brings with it relief and you straighten up.  Upon your back now sit small, leathery wings, not unlike a bat's. <b>You now have small dragon wings.  They're not big enough to fly with, but they look adorable.</b>");
					setWingType(Wings.DRACONIC_SMALL, "small, draconic");
				}
				//(If Small Dragon Wings Present)
				else if (player.wings.type == Wings.DRACONIC_SMALL) {
					outputText("\n\nA not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger.  You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet.  <b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>");
					setWingType(Wings.DRACONIC_LARGE, "large, draconic");
				}
				//even larger dragon wings ^^
				else if (player.wings.type == Wings.DRACONIC_LARGE) {
					outputText("\n\nA not-unpleasant tingling sensation again fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger than before.  You spread them wide - they stretch now more than twice further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and lifting you off your feet effortlesly.  <b>You now have fully-grown majestic dragon wings, capable of winging you through the air elegantly!</b>");
					setWingType(Wings.DRACONIC_HUGE, "large, majestic draconic");
				}
				//(If other wings present)
				else {
					outputText("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your wings have changed into dragon wings.</b>");
					setWingType(Wings.DRACONIC_SMALL, "small, draconic");
				}
				changes++;
			}
			if (type == 1 && player.dragonScore() >= 4 && changes < changeLimit && player.findPerk(PerkLib.DragonFireBreath) < 0) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				outputText("\n\nIt seems vouivre oil has awaked some kind of power within you... your throat and chest feel very sore, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon fire breath!</b>)");
				player.createPerk(PerkLib.DragonFireBreath, 0, 0, 0, 0);
				changes++;
			}
			if (type == 1 && player.dragonScore() >= 4 && changes < changeLimit && player.findPerk(PerkLib.DragonIceBreath) < 0) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				outputText("\n\nIt seems vouivre oil has awaked some kind of power within you... your throat and chest feel very cold, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon ice breath!</b>)");
				player.createPerk(PerkLib.DragonIceBreath, 0, 0, 0, 0);
				changes++;
			}
			if (type == 1 && player.dragonScore() >= 4 && changes < changeLimit && player.findPerk(PerkLib.DragonLightningBreath) < 0) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				outputText("\n\nIt seems vouivre oil has awaked some kind of power within you... your throat and chest feel like it was electrocuted, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon fire breath!</b>)");
				player.createPerk(PerkLib.DragonLightningBreath, 0, 0, 0, 0);
				changes++;
			}
			if (type == 1 && player.dragonScore() >= 4 && changes < changeLimit && player.findPerk(PerkLib.DragonDarknessBreath) < 0) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				outputText("\n\nIt seems vouivre oil has awaked some kind of power within you... your throat and chest feel very... strange and you can't put a finger what this feeling exactly is, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon ice breath!</b>)");
				player.createPerk(PerkLib.DragonDarknessBreath, 0, 0, 0, 0);
				changes++;
			}
			//Propah Wings
			if (type == 2 && player.wings.type == Wings.NONE && changes < changeLimit && (type == 1 || player.arms.type == Arms.HARPY) && rand(4) == 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>");
				setWingType(Wings.FEATHERED_LARGE, "large, feathered");
				changes++;
			}
			//Remove old wings
			if (type == 2 && player.wings.type != Wings.FEATHERED_LARGE && player.wings.type > Wings.NONE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				removeWings();
				changes++;
			}
			//Dragon Arms
			if (type == 1 && player.wings.type == Wings.DRACONIC_HUGE && player.arms.type != Arms.DRAGON && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of dragon one with leathery scales and short claws replacing your fingernails.  <b>You now have a dragon arms.</b>");
				setArmType(Arms.DRAGON);
				changes++;
			}
			//Feathery Arms
			if (type == 2 && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.HARPY) && player.ears.type == Ears.SNAKE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nWhen you go to wipe your mouth form remains of the oil, instead of the usual texture of your [skin.type] on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				setArmType(Arms.HARPY);
				changes++;
			}
			//Feathery Hair
			if (type == 2 && player.hairType != 1 && player.wings.type == Wings.FEATHERED_LARGE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a couatl!");
				setHairType(Hair.FEATHER);
				changes++;
			}
			//Scales with color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (!player.hasFullCoatOfType(Skin.SCALES) && ((type == 0 && player.eyes.type == Eyes.GORGON) || (type == 2 && player.hairType == 1)) && changes < changeLimit && rand(5) == 0) {
				//set new skinTone
				if (rand(10) == 0) {
					color = randomChoice("purple", "silver");
				}
				//non rare skinTone
				else {
					color = randomChoice("red", "green", "white", "blue", "black");
				}
				if (player.hasFur()) {
					outputText("\n\nYou scratch yourself, and come away with a large clump of [skin coat.color] fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + color + " scales covering most of your body.  The rest of the fur is easy to remove.  <b>You're now covered in scales from head to waist.</b>");
				}
				//(no fur)
				else {
					outputText("\n\nYou idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard.  A quick glance down reveals that scales are growing out of your " + color + " skin with alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body.  <b>You're covered from head to waist in shiny scales.</b>");
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedScales)) {
					outputText("\n\n<b>Genetic Memory: Scales - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedScales, 0, 0, 0, 0);
				}
				player.skin.growCoat(Skin.SCALES,{color:color});
				changes++;
			}
			if (type == 1 && player.wings.type == Wings.DRACONIC_LARGE && player.hasPartialCoat(Skin.DRAGON_SCALES) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, as new scales grew up filling the gaps. ");
				player.skin.growCoat(Skin.DRAGON_SCALES,{},Skin.COVERAGE_COMPLETE);
				outputText("<b>Your body is now fully covered in " + color + " shield-shaped dragon scales.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedDragonScales)) {
					outputText("\n\n<b>Genetic Memory: Dragon Scales - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedDragonScales, 0, 0, 0, 0);
				}
				changes++;
			}
			if (type == 1 && player.wings.type == Wings.DRACONIC_LARGE && !player.hasDragonScales() && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". It doesn’t cover your skin entirely but should provide excellent protection regardless.  They are smooth and look nearly as tough as iron. ");
				var color2:String;
				if (rand(10) == 0) {
					color2 = randomChoice("purple","silver");
				} else {
					color2 = randomChoice("red","green","white","blue","black");
				}
				player.skin.growCoat(Skin.DRAGON_SCALES,{color:color2},Skin.COVERAGE_LOW);
				outputText("<b>Your body is now partially covered in " + color2 + " shield-shaped dragon scales.</b>");
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nRemakarbly, the ");
				if (type == 0) outputText("gorgon");
				if (type == 1) outputText("vouivre");
				if (type == 2) outputText("couatl");
				outputText("-oil has no effect.  Should you really be surprised at ");
				if (type == 0) outputText("gorgon");
				if (type == 1) outputText("vouivre");
				if (type == 2) outputText("couatl");
				outputText("-oil NOT doing anything?");
			}
			player.refillHunger(5);
		}
/*
		public function extensionSerum(player:Player):void
		{
			clearOutput();
			if (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] > 2) {
				outputText("<b>No way!</b>  Your head itches like mad from using the rest of these, and you will NOT use another.\n");
				if (!debug) {
					inventory.takeItem(consumables.EXTSERM);
				}
				return;
			}
			outputText("You open the bottle of hair extension serum and follow the directions carefully, massaging it into your scalp and being careful to keep it from getting on any other skin.  You wash off your hands with lakewater just to be sure.");
			if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] <= 0) {
				outputText("\n\nThe tingling on your head lets you know that it's working!");
				flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 7;
				flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 1;
			}
			else if (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] == 1) {
				outputText("\n\nThe tingling intensifies, nearly making you feel like tiny invisible faeries are massaging your scalp.");
				flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]++;
			}
			else if (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] == 2) {
				outputText("\n\nThe tingling on your scalp is intolerable!  It's like your head is a swarm of angry ants, though you could swear your hair is growing so fast that you can feel it weighing you down more and more!");
				flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]++;
			}
			if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0 && player.hairType != 4) {
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				outputText("\n\n<b>Somehow you know that your [hair] is growing again.</b>");
			}
			if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] < 7) flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 7;
		}
		*/

		public function superHummus(player:Player):void
		{
			clearOutput();
			if (debug) {
				outputText("You're about to eat the humus when you see it has bugs in it. Not wanting to eat bugged humus or try to debug it you throw it into the portal and find something else to eat.");
				player.destroyItems(consumables.HUMMUS_, 1);
				return;
			}
			outputText("You shovel the stuff into your face, not sure WHY you're eating it, but once you start, you just can't stop.  It tastes incredibly bland, and with a slight hint of cheese.");
			player.refillHunger(100);
			player.str = 30;
			player.spe = 30;
			player.tou = 30;
			player.inte = 30;
			player.wis = 30;
			player.sens = 20;
			player.lib = 25;
			player.cor = 5;
			player.lust = 10;
			player.hairType = Hair.NORMAL;
			if (player.humanScore() > 4) {
				outputText("\n\nYou blink and the world twists around you.  You feel more like yourself than you have in a while, but exactly how isn't immediately apparent.  Maybe you should take a look at yourself?");
			}
			else {
				outputText("\n\nYou cry out as the world spins around you.  You're aware of your entire body sliding and slipping, changing and morphing, but in the sea of sensation you have no idea exactly what's changing.  You nearly black out, and then it's over.  Maybe you had best have a look at yourself and see what changed?");
			}
			player.arms.type = Arms.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			player.antennae.type = Antennae.NONE;
			player.faceType = Face.HUMAN;
			player.lowerBody = LowerBody.HUMAN;
			player.legCount = 2;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			player.tailType = Tail.NONE;
			player.tailRecharge = 0;
			player.horns.count = 0;
			player.horns.type = Horns.NONE;
			player.ears.type = Ears.HUMAN;
			player.skin.setBaseOnly();
			player.skinAdj = "";
			player.tongue.type = Tongue.HUMAN;
			if (player.fertility > 15) player.fertility = 15;
			if (player.cumMultiplier > 50) player.cumMultiplier = 50;
			var virgin:Boolean = false;
			//Clear cocks
			while (player.cocks.length > 0) {
				player.removeCock(0, 1);
				trace("1 cock purged.");
			}
			//Reset dongs!
			if (player.gender == 1 || player.gender == 3) {
				player.createCock();
				player.cocks[0].cockLength = 6;
				player.cocks[0].cockThickness = 1;
				player.ballSize = 2;
				if (player.balls > 2) player.balls = 2;
			}
			//Non duders lose any nuts
			else {
				player.balls = 0;
				player.ballSize = 2;
			}
			//Clear vaginas
			while (player.vaginas.length > 0) {
				virgin = player.vaginas[0].virgin;
				player.removeVagina(0, 1);
				trace("1 vagina purged.");
			}
			//Reset vaginal virginity to correct state
			if (player.gender >= 2) {
				player.createVagina();
				player.vaginas[0].virgin = virgin;
			}
			player.clitLength = .25;
			//Tighten butt!
			player.butt.type = 2;
			player.hips.type = 2;
			if (player.ass.analLooseness > 1) player.ass.analLooseness = 1;
			if (player.ass.analWetness > 1) player.ass.analWetness = 1;
			//Clear breasts
			player.breastRows = [];
			player.createBreastRow();
			player.nippleLength = .25;
			//Girls and herms get bewbs back
			if (player.gender > 2) {

				player.breastRows[0].breastRating = 2;
			}
			else player.breastRows[0].breastRating = 0;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			player.removeStatusEffect(StatusEffects.Uniball);
			player.removeStatusEffect(StatusEffects.BlackNipples);
			player.removeStatusEffect(StatusEffects.GlowingNipples);
			player.vaginaType(0);
		}

		//Normal hummus
		public function regularHummus(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			var heightGain:int;
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			clearOutput();
			outputText("You shovel the stuff into your face, not sure WHY you're eating it, but once you start, you just can't stop.  It tastes incredibly bland, and with a slight hint of cheese.");
			player.refillHunger(5);
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			if (player.humanScore() > 6) {
				outputText("\n\nYou blink and the world twists around you.  You feel more like yourself than you have in a while, but exactly how isn't immediately apparent.  Maybe you should take a look at yourself?");
			}
			else {
				outputText("\n\nYou cry out as the world spins around you.  You're aware of your entire body sliding and slipping, changing and morphing, but in the sea of sensation you have no idea exactly what's changing.  You nearly black out, and then it's over.  Maybe you had best have a look at yourself and see what changed?");
			}
			//-----------------------
			// MAJOR TRANSFORMATIONS
			//-----------------------
			//1st priority: Change lower body to bipedal.
			if (player.lowerBody != LowerBody.HUMAN && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				humanizeLowerBody();
				changes++;
			}
			//Remove Incorporeality Perk
			if (player.findPerk(PerkLib.Incorporeality) >= 0 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel a strange sensation in your [legs] as they start to feel more solid. They become more opaque until finally, you can no longer see through your [legs]. \n<b>(Perk Lost: Incorporeality!)</b>");
				player.removePerk(PerkLib.Incorporeality);
				changes++;
			}
			//-Skin color change – tan, olive, dark, light
			if ((player.skinTone != "tan" && player.skinTone != "olive" && player.skinTone != "dark" && player.skinTone != "light") && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your [skin coat.color] " + player.skinDesc);
				else outputText("your " + player.skinDesc);
				outputText(" has changed to become ");
				switch (rand(4)) {
					case 0:
						player.skinTone = "tan";
						break;
					case 1:
						player.skinTone = "olive";
						break;
					case 2:
						player.skinTone = "dark";
						break;
					case 3:
						player.skinTone = "light";
						break;
				}
				outputText(player.skinTone + " colored.</b>");
			}
			//Change skin to normal
			if (!player.hasPlainSkinOnly() && rand(3) == 0 && changes < changeLimit) {
				if (player.skinAdj != "") player.skinAdj = "";
				humanizeSkin();
				changes++;
			}
			//Raiju / Other skin pattern removal
			if (player.skin.base.pattern != Skin.PATTERN_NONE) {
				if (player.skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO) outputText("\n\nYour skin tingle and you look down just in time to see your tatoo fades to nothingness back into your now uniform skin.");
				else outputText("\n\nYour skin tingle and you look down just in time to see your skin color patterns fade and back into the color of your " + player.skinTone + " skin leaving you with a uniform skin coloration.");
				player.skin.base.pattern = Skin.PATTERN_NONE;
				player.skin.base.adj = "";
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern)) {
					outputText("\n\n<b>Genetic Memory: No Skin Patterns - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern, 0, 0, 0, 0);
				}
				changes++;
			}
			//-----------------------
			// MINOR TRANSFORMATIONS
			//-----------------------
			//-Human arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(3) == 0) {
				humanizeArms();
				changes++;
			}
			//-Human face
			if (player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
				humanizeFace();
				changes++;
			}
			//-Human tongue
			if (player.tongue.type != Tongue.HUMAN && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
				setTongueType(Tongue.HUMAN);
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(3) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//-Gain human ears (If you have human face)
			if ((player.ears.type != Ears.HUMAN && player.faceType == Face.HUMAN) && changes < changeLimit && rand(3) == 0) {
				humanizeEars();
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//Black Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Glowing Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.GlowingNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour nipple tingle before their coloration turns back to normal.");
				changes++;
				player.removeStatusEffect(StatusEffects.GlowingNipples);
			}
			//Remove feathery/quill hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) && rand(3) == 0) {
				var word1:String;
				if (player.hairType == Hair.FEATHER) word1 = "feather";
				else word1 = "quill";
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft " + word1 + "-hair droops over your eye.  Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				else outputText("\n\nYou run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your " + word1 + "s.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//Remove anemone hair
			if (changes < changeLimit && player.hairType == Hair.ANEMONE && rand(3) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove goo hair
			if (changes < changeLimit && player.hairType == Hair.GOO && rand(3) == 0) {
				outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of hair sprouts from the skin of your scalp.  <b>Your hair is normal again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove gorgon hair
			if (changes < changeLimit && player.hairType == Hair.GORGON && rand(3) == 0) {
				player.hairLength = 1;
				outputText("\n\nAs you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes start hissing uncontrollably. Many of them go rigid, any kind of life that they could had taken away by the root effects. Soon all the snakes that made your hair are limp and lifeless.");
				outputText("\n\nTheir dead bodies are separated from you head by a scorching sensation, and start falling to the ground, turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.");
				outputText("\n\nThe effects don’t end here, though as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove ghost hair
			if (changes < changeLimit && player.hairType == Hair.GHOST && rand(3) == 0) {
				outputText("\n\nA sensation of weight assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming heavier in your grasp.  Plucking a strand, you hold it up before you, surprised to see... it's no longer transparent!  You have normal hair!");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove leaf hair
			if (changes < changeLimit && player.hairType == Hair.LEAF && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your leaf-hair droops over your eye.  Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair.  <b>Your hair is no longer leaf-like!</b>");
				//(short)
				else outputText("\n\nYou run your fingers through your leaf-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your leafs.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer leaf-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//Remove fluffy hair
			if (changes < changeLimit && player.hairType == Hair.FLUFFY && rand(3) == 0) {
				outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your fluffy hair, only to find out that they have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove grass hair
			if (changes < changeLimit && player.hairType == Hair.GRASS && rand(3) == 0) {
				outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your grass-hair, only to find out that the long, soft and leafy blades have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove silken hair
			if (changes < changeLimit && player.hairType == Hair.SILKEN && rand(3) == 0) {
				outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your silken-hair, only to find out that they have changed back to normal hair.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove storm hair
			if (changes < changeLimit && player.hairType == Hair.STORM && rand(3) == 0) {
				outputText("\n\nYour charged up hairs begins to lose of their lusters, the fizzling bolts glows dying out as the current dies down before vanishing entirely leaving you with normal human hairs.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Remove burning hair
			if (changes < changeLimit && player.hairType == Hair.BURNING && rand(3) == 0) {
				outputText("\n\nYou're head begins to cool down until the flames entirely disapears leaving you with ordinary hairs.  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//Restart hair growth
			if(flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel an itching sensation in your scalp as you realize the change. <b>Your hair is growing normally again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				//setHairType(Hair.NORMAL);
				changes++;
			}
			//-----------------------
			// EXTRA PARTS REMOVAL
			//-----------------------
			//Removes antennae.type
			if (player.antennae.type > Antennae.NONE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae.type have vanished!");
				player.antennae.type = Antennae.NONE;
				changes++;
			}
			//Removes horns
			if (changes < changeLimit && player.horns.count > 0 && player.horns.type != Horns.GARGOYLE && rand(3) == 0) {
				if (player.horns.type == Horns.ORCHID) outputText("\n\nYour orchid flowers crumble, falling apart");
				else outputText("\n\nYour horns crumble, falling apart in large chunks");
				outputText(" until they flake away to nothing.");
				setHornType(Horns.NONE, 0);
				changes++;
			}
			//Removes wings
			if (!InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.NONE) && rand(3) == 0 && changes < changeLimit) {
			//	if (player.wings.type == SHARK_FIN) outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine.  After a moment the pain passes, though your fin is gone!");
				outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
				setWingType(Wings.NONE, "non-existant");
				changes++;
			}
			//Removes tail
			if(player.tailType > Tail.NONE && player.tailType != Tail.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground.  <b>You no longer have a tail!</b>");
				setTailType(Tail.NONE, 0);
				player.tailVenom = 0;
				player.tailRecharge = 5;
				changes++;
			}
			//Revert rear body to normal
			if (player.rearBody.type != RearBody.NONE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it.  After a moment the pain passes, though your back is back to what you looked like when you entered this realm!");
				setRearBody(RearBody.NONE);
				changes++;
			}
			//Increase height up to 5 feet.
			if (rand(2) == 0 && changes < changeLimit && player.tallness < 60) {
				heightGain = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 90) heightGain = Math.floor(heightGain / 2);
				//Never 0
				if (heightGain == 0) heightGain = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (heightGain < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (heightGain >= 5 && heightGain < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (heightGain == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += heightGain;
				changes++;
			}
			//Decrease height down to a minimum of 7 feet.
			if (rand(2) == 0 && changes < changeLimit && player.tallness > 84) {
				outputText("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!\n");
				player.tallness -= 1 + rand(3);
				changes++;
			}
			//-----------------------
			// SEXUAL TRANSFORMATIONS
			//-----------------------
			//Remove additional cocks
			if (player.cocks.length > 1 && rand(3) == 0 && changes < changeLimit) {
				player.killCocks(1);
				outputText("\n\nYou have a strange feeling as your crotch tingles.  Opening your [armor], <b>you realize that one of your cocks have vanished completely!</b>");
				changes++;
			}
			//Remove additional balls
			if (player.balls > 2 && rand(3) == 0 && changes < changeLimit) {
				if (player.ballSize > 2) {
					if (player.ballSize > 5) player.ballSize -= 1 + rand(3);
					player.ballSize -= 1;
					outputText("\n\nYour scrotum slowly shrinks, settling down at a smaller size.  <b>Your [balls] are smaller now.</b>\n\n");
				}
				else {
					player.balls = 2;
					outputText("\n\nYour scrotum slowly shrinks until they seem to have reached a normal size. <b>You can feel as if your extra balls fused together, leaving you with a pair of balls.</b>\n\n");
				}
				changes++;
			}
			//Change cock back to normal
			if (player.hasCock() && changes < changeLimit) {
				if (rand(3) == 0 && player.cocks[0].cockType != CockTypesEnum.HUMAN) {
					outputText("\n\nA strange tingling begins behind your [cock], slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your [armor] to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, <b>leaving you with a completely human penis.</b>");
					player.cocks[0].cockType = CockTypesEnum.HUMAN;
					changes++;
				}
			}
			//Shrink oversized cocks
			if (player.hasCock() && player.biggestCockLength() > 12 && rand(3) == 0 && changes < changeLimit) {
				var idx:int = player.biggestCockIndex();
				if (player.cocks.length == 1) outputText("\n\nYou feel a tingling sensation as your cock shrinks to a smaller size!");
				else outputText("\n\nYou feel a tingling sensation as the largest of your cocks shrinks to a smaller size!");
				player.cocks[idx].cockLength -= (rand(10) + 2) / 10;
				if (player.cocks[idx].cockThickness > 1.5) {
					outputText(" Your " + cockDescript(idx) + " definitely got a bit thinner as well.");
					player.cocks[idx].cockThickness -= (rand(4) + 1) / 10;
				}
				changes++;
			}
			//Remove additional breasts
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.breastRows.length >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
				changes++;
			}
			//Remove extra nipples
			if(player.averageNipplesPerBreast() > 1 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts.  <b>You are left with only one nipple on each breast.</b>");
				for(var x:int = 0; x < player.bRows(); x++)
				{
					player.breastRows[x].nipplesPerBreast = 1;
				}
				changes++;
			}
			//Shrink tits!
			if (changes < changeLimit && rand(3) == 0 && player.biggestTitSize() > 6)
			{
				player.shrinkTits();
				changes++;
			}
			//Change vagina back to normal
			if (changes < changeLimit && rand(3) == 0 && (player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			//Fertility Decrease:
			if (player.hasVagina() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nThe vague numbness in your skin sinks slowly downwards, and you put a hand on your lower stomach as the sensation centers itself there.  ");
				dynStats("sen", -2);
				//High fertility:
				if (player.fertility >= 30) outputText("It feels like your overcharged reproductive organs have simmered down a bit.");
				//Average fertility:
				else if (player.fertility >= 10) outputText("You feel like you have dried up a bit inside; you are left feeling oddly tranquil.");
				//[Low/No fertility:
				else {
					outputText("Although the numbness makes you feel serene, the hummus has no effect upon your ");
					if (player.fertility > 0) outputText("mostly ");
					outputText("sterile system.");
					if (player.cor > 70) outputText("  For some reason the fact that you cannot function as nature intended makes you feel helpless and submissive.  Perhaps the only way to be a useful creature now is to find a dominant, fertile being willing to plow you full of eggs? You shake the alien, yet oddly alluring thought away.");
				}
				player.fertility -= 1 + rand(3);
				if (player.fertility < 10 && player.gender >= 2) player.fertility = 10;
				if (player.fertility < 5) player.fertility = 5;
				changes++;
			}
			//Cum Multiplier Decrease:
			if (player.hasCock() && player.cumMultiplier > 5 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel a strange tingling sensation in your ");
				if (player.balls > 0) outputText("balls");
				else outputText("groin");
				outputText(" as you can feel the density reducing. You have a feeling you're going to produce less cum now.");
				player.cumMultiplier -= (1 + (rand(20) / 10));
				if (player.cumMultiplier < 1) player.cumMultiplier = 1;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function catTransformation(type:Number,player:Player):void
		{
			//'type' refers to the variety of cat TF's.
			//0 == normal cat
			//1 == nekomata
			//2 == cheshire
			//3 == displacer beast
			var choice:int;
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			var temp3:Number = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Text go!
			clearOutput();
			if (type == 0) outputText("You take a bite of the fruit and gulp it down. It's thick and juicy and has an almost overpowering sweetness. Nevertheless, it is delicious and you certainly could use a meal.  You devour the fruit, stopping only when the hard, nubby pit is left; which you toss aside.");
			if (type == 1) outputText("I know you expected text here but *cough* someone said she will write it...eventualy so till then there is nice placeholder text here.");
			if (type == 2) outputText("");
			if (type == 3) outputText("As you close your eyes and savor the fruit you feel somewhat weird. Looking around you realise you unconsciously moved 10 feet from your original location. Well you have seen weirder things.");
			//Speed raises up to 75
			if (player.spe < 75 && rand(3) == 0 && changes < changeLimit) {
				//low speed
				if (player.spe <= 30) {
					outputText("\n\nYou feel... more balanced, sure of step. You're certain that you've become just a little bit faster.");
					dynStats("spe", 2);
				}
				//medium speed
				else if (player.spe <= 60) {
					outputText("\n\nYou stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.");
					dynStats("spe", 1);
				}
				//high speed
				else {
					outputText("\n\nYou pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.");
					dynStats("spe", .5);
				}
				changes++;
			}
			//Strength raises to 40
			if (player.str < 40 && rand(3) == 0 && changes < changeLimit) {
				if (rand(2) == 0) outputText("\n\nYour muscles feel taut, like a coiled spring, and a bit more on edge.");
				else outputText("\n\nYou arch your back as your muscles clench painfully.  The cramp passes swiftly, leaving you feeling like you've gotten a bit stronger.");
				dynStats("str", 1);
				changes++;
			}
			//Strength ALWAYS drops if over 60
			//Does not add to change total
			else if (player.str > 60 && rand(3) == 0) {
				outputText("\n\nShivers run from your head to your toes, leaving you feeling weak.  Looking yourself over, your muscles seemed to have lost some bulk.");
				dynStats("str", -2);
			}
			//Toughness drops if over 50
			//Does not add to change total
			if (player.tou > 50 && rand(3) == 0) {
				outputText("\n\nYour body seems to compress momentarily, becoming leaner and noticeably less tough.");
				dynStats("tou", -2);
			}
			//Intelliloss
			if (type == 0 && rand(3) == 0 && changes < changeLimit) {
				//low intelligence
				if (player.inte < 15) outputText("\n\nYou feel like something is slipping away from you but can't figure out exactly what's happening.  You scrunch up your [face], trying to understand the situation.  Before you can reach any kind of conclusion, something glitters in the distance, distracting your feeble mind long enough for you to forget the problem entirely.");
				//medium intelligence
				else if (player.inte < 50) {
					outputText("\n\nYour mind feels somewhat sluggish, and you wonder if you should just lie down ");
					if (rand(2) == 0) {
						outputText("somewhere and ");
						switch (rand(3)) {
							case 0:
								outputText("toss a ball around or something");
								break;
							case 1:
								outputText("play with some yarn");
								break;
							case 2:
								outputText("take a nap and stop worrying");
								break;
						}
					}
					else outputText("in the sun and let your troubles slip away");
					outputText(".");
				}
				//High intelligence
				else outputText("\n\nYou start to feel a bit dizzy, but the sensation quickly passes.  Thinking hard on it, you mentally brush away the fuzziness that seems to permeate your brain and determine that this fruit may have actually made you dumber.  It would be best not to eat too much of it.");
				dynStats("int", -1);
				changes++;
			}
			if ((type == 1 || type == 2) && player.inte < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly feel more cunning and by far way smarter.");
				dynStats("int", 2);
				changes++;
			}
			if (type == 3 && player.inte > 12 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nSomething alerts your senses. You walk on all "+(player.arms.type == Arms.DISPLACER ? "six":"four")+" sniffing the air around you and growling as your mind regresses into a feral state not unlike that of a beast or rather in your case that of a displacer beast.");
				dynStats("int", -3);
				changes++;
			}
			//Libido gain
			if (type == 0 && player.lib < 80 && changes < changeLimit && rand(3) == 0) {
				//Cat dicked folks
				if (player.catCocks() > 0) {
					choice = player.findFirstCockType(CockTypesEnum.CAT);
					outputText("\n\nYou feel your " + cockDescript(choice) + " growing hard, the barbs becoming more sensitive. You gently run your hands down them and imagine the feeling of raking the insides of a cunt as you pull.  The fantasy continues, and after ejaculating and hearing the female yowl with pleasure, you shake your head and try to drive off the image.  ");
					if (player.cor < 33) outputText("You need to control yourself better.");
					else if (player.cor < 66) outputText("You're not sure how you feel about the fantasy.");
					else outputText("You hope to find a willing partner to make this a reality.");
				}
				//Else –
				else {
					outputText("\n\nA rush of tingling warmth spreads through your body as it digests the fruit.  You can feel your blood pumping through your extremities, making them feel sensitive and surprisingly sensual.  It's going to be hard to resist getting ");
					if (player.lust > 60) outputText("even more ");
					outputText("turned on.");
				}
				dynStats("lib", 1, "sen", .25);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual changes would go here if I wasn't a tard.
			//Heat
			if (rand(4) == 0 && changes < changeLimit)
			{
				var intensified:Boolean = player.inHeat;
				if (player.goIntoHeat(false))
				{
					if (intensified)
					{
						if (rand(2) == 0) outputText("\n\nThe itch inside your [vagina] is growing stronger, and you desperately want to find a nice cock to massage the inside.");
						else outputText("\n\nThe need inside your [vagina] grows even stronger.  You desperately need to find a mate to 'scratch your itch' and fill your womb with kittens.  It's difficult NOT to think about a cock slipping inside your moist fuck-tunnel, and at this point you'll have a hard time resisting ANY male who approaches.");
					}
					else
					{
						outputText("\n\nThe interior of your [vagina] clenches tightly, squeezing with reflexive, aching need.  Your skin flushes hot ");
						if (player.hasFur()) outputText("underneath your fur ");
						outputText("as images and fantasies ");
						if (player.cor < 50) outputText("assault ");
						else outputText("fill ");
						outputText(" your mind.  Lithe cat-boys with their perfect, spine-covered cocks line up behind you, and you bend over to present your needy pussy to them.  You tremble with the desire to feel the exotic texture of their soft barbs rubbing your inner walls, smearing your [vagina] with their cum as you're impregnated.  Shivering, you recover from the fantasy and pull your fingers from your aroused sex.  <b>It would seem you've gone into heat!</b>");
					}
					changes++;
				}
			}

			//Shrink the boobalies down to A for men or C for girls.
			if (changes < changeLimit && rand(4) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				temp2 = 0;
				temp3 = 0;
				//Determine if shrinkage is required
				//and set temp2 to threshold
				if (!player.hasVagina() && player.biggestTitSize() > 2) temp2 = 2;
				else if (player.biggestTitSize() > 4) temp2 = 4;
				//IT IS!
				if (temp2 > 0) {
					//temp3 stores how many rows are changed
					temp3 = 0;
					for (var k:Number = 0; k < player.breastRows.length; k++) {
						//If this row is over threshhold
						if (player.breastRows[k].breastRating > temp2) {
							//Big change
							if (player.breastRows[k].breastRating > 10) {
								player.breastRows[k].breastRating -= 2 + rand(3);
								if (temp3 == 0) outputText("\n\nThe [breasts] on your chest wobble for a second, then tighten up, losing several cup-sizes in the process!");
								else outputText("  The change moves down to your " + num2Text2(k + 1) + " row of [breasts]. They shrink greatly, losing a couple cup-sizes.");
							}
							//Small change
							else {
								player.breastRows[k].breastRating -= 1;
								if (temp3 == 0) outputText("\n\nAll at once, your sense of gravity shifts.  Your back feels a sense of relief, and it takes you a moment to realize your " + breastDescript(k) + " have shrunk!");
								else outputText("  Your " + num2Text2(k + 1) + " row of " + breastDescript(k) + " gives a tiny jiggle as it shrinks, losing some off its mass.");
							}
							//Increment changed rows
							temp3++;
						}
					}
				}
				//Count that tits were shrunk
				if (temp3 > 0) changes++;
			}
			//Cat dangly-doo.
			if (player.cockTotal() > 0 && player.catCocks() < player.cockTotal() && (player.ears.type == Ears.CAT || rand(3) > 0) && (player.tailType == Tail.CAT || rand(3) > 0) && changes < changeLimit && rand(4) == 0) {
				//loop through and find a non-cat wang.
				for (var i:Number = 0; i < (player.cockTotal()) && player.cocks[i].cockType == CockTypesEnum.CAT; i++) { }
				outputText("\n\nYour " + cockDescript(i) + " swells up with near-painful arousal and begins to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.  ");
				if (!player.hasSheath()) {
					outputText("Then, it begins to shrink and sucks itself inside your body.  Within a few moments, a fleshy sheath is formed.");
					if (player.balls > 0) outputText("  Thankfully, your balls appear untouched.");
				}
				else outputText("Then, it disappears back into your sheath.");
				player.cocks[i].cockType = CockTypesEnum.CAT;
				player.cocks[i].knotMultiplier = 1;
				changes++;
			}
			//Cat penorz shrink
			if (player.catCocks() > 0 && rand(4) == 0 && changes < changeLimit && !flags[kFLAGS.HYPER_HAPPY]) {
				//loop through and find a cat wang.
				choice = 0;
				for (var j:Number = 0; j < (player.cockTotal()); j++) {
					if (player.cocks[j].cockType == CockTypesEnum.CAT && player.cocks[j].cockLength > 6) {
						choice = 1;
						break;
					}
				}
				if (choice == 1) {
					//lose 33% size until under 10, then lose 2" at a time
					if (player.cocks[j].cockLength > 16) {
						outputText("\n\nYour " + cockDescript(j) + " tingles, making your sheath feel a little less tight.  It dwindles in size, losing a full third of its length and a bit of girth before the change finally stops.");
						player.cocks[j].cockLength *= .66;
					}
					else if (player.cocks[j].cockLength > 6) {
						outputText("\n\nYour " + cockDescript(j) + " tingles and withdraws further into your sheath.  If you had to guess, you'd say you've lost about two inches of total length and perhaps some girth.");
						player.cocks[j].cockLength -= 2;
					}
					if (player.cocks[j].cockLength / 5 < player.cocks[j].cockThickness && player.cocks[j].cockThickness > 1.25) player.cocks[j].cockThickness = player.cocks[j].cockLength / 6;
					//Check for any more!
					temp2 = 0;
					j++;
					for (j; j < player.cocks.length; j++) {
						//Found another cat wang!
						if (player.cocks[j].cockType == CockTypesEnum.CAT) {
							//Long enough - change it
							if (player.cocks[j].cockLength > 6) {
								if (player.cocks[j].cockLength > 16)
									player.cocks[j].cockLength *= .66;
								else if (player.cocks[j].cockLength > 6)
									player.cocks[j].cockLength -= 2;
								//Thickness adjustments
								if (player.cocks[j].cockLength / 5 < player.cocks[j].cockThickness && player.cocks[j].cockThickness > 1.25) player.cocks[j].cockThickness = player.cocks[j].cockLength / 6;
								temp2 = 1;
							}
						}
					}
					//(big sensitivity boost)
					outputText("  Although the package is smaller, it feels even more sensitive – as if it retained all sensation of its larger size in its smaller form.");
					dynStats("sen", 5);
					//Make note of other dicks changing
					if (temp2 == 1) outputText("  Upon further inspection, all your " + Appearance.cockNoun(CockTypesEnum.CAT) + "s have shrunk!");
					changes++;
				}
			}
			//Body type changes
			//DA EARZ
			if (player.ears.type != Ears.CAT && player.tailType != Tail.GARGOYLE && type != 3 && rand(3) == 0 && changes < changeLimit) {
				//human to cat:
				if (player.ears.type == Ears.HUMAN) {
					if (rand(2) == 0) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have cat ears.</b>");
					else outputText("\n\nYour ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have cat ears.</b>");
				}
				//non human to cat:
				else {
					if (rand(2) == 0) outputText("\n\nYour ears change shape, morphing into pointed, feline ears!  They swivel about reflexively as you adjust to them.  <b>You now have cat ears.</b>");
					else outputText("\n\nYour ears tingle and begin to change shape. Within a few moments, they've become long and feline.  Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have cat ears.</b>");
				}
				setEarType(Ears.CAT);
				changes++;
			}
			if (player.ears.type != Ears.LION && player.tailType != Tail.GARGOYLE && type == 3 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have lion ears.</b>");
				setEarType(Ears.LION);
				changes++;
			}
			//DA TAIL (IF ALREADY HAZ URZ)
			if (player.tailType != Tail.CAT && player.ears.type == Ears.CAT && type != 1 && rand(3) == 0 && changes < changeLimit) {
				if (player.tailType == Tail.NONE) {
					choice = rand(3);
					if (choice == 0) outputText("\n\nA pressure builds in your backside. You feel under your [armor] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>");
					if (choice == 1) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long, flexible tail! <b>You now have a cat tail.</b>");
					if (choice == 2) outputText("\n\nYou feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [skin coat.color] fur. <b>You now have a cat tail.</b>");
				}
				else outputText("\n\nYou pause and tilt your head... something feels different.  Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>");
				setTailType(Tail.CAT);
				changes++;
			}
			if (player.tailType != Tail.CAT && player.tailType != Tail.NEKOMATA_FORKED_1_3 && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.ears.type == Ears.CAT && type == 1 && rand(3) == 0 && changes < changeLimit) {
				if (player.tailType == Tail.NONE) {
					choice = rand(3);
					if (choice == 0) outputText("\n\nA pressure builds in your backside. You feel under your [armor] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>");
					if (choice == 1) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long, flexible tail! <b>You now have a cat tail.</b>");
					if (choice == 2) outputText("\n\nYou feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [skin coat.color] fur. <b>You now have a cat tail.</b>");
				}
				else outputText("\n\nYou pause and tilt your head... something feels different.  Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>");
				setTailType(Tail.CAT,1);
				changes++;
			}
			if (player.tailType == Tail.CAT && player.tailCount == 1 && player.ears.type == Ears.CAT && type == 1 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, it starts splitting into two, stopping once the split reaches a third of the way down the length!  <b>You now have a cat tail that is forked on the last third of its length.</b>");
				setTailType(Tail.NEKOMATA_FORKED_1_3);
				changes++;
			}
			if (player.tailType == Tail.NEKOMATA_FORKED_1_3 && player.level >= 6 && player.inte >= 10 && player.wis >= 25 && type == 1 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, it starts splitting into two, stopping as another third of its length becomes forked!  <b>You now have a cat tail that is forked at two thirds of its length.</b>");
				setTailType(Tail.NEKOMATA_FORKED_2_3);
				changes++;
			}
			if (player.tailType == Tail.NEKOMATA_FORKED_2_3 && player.level >= 12 && player.inte >= 20 && player.wis >= 50 && type == 1 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail finishes splitting in two!  <b>You now have a pair of cat-tails.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd)) {
					outputText("\n\n<b>Genetic Memory: 2nd Cat Tail - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedCatTail2nd, 0, 0, 0, 0);
				}
				setTailType(Tail.CAT,2);
				changes++;
			}
			//Da paws (if already haz tail)
			if ((player.tailType == Tail.CAT || player.tailType == Tail.NEKOMATA_FORKED_1_3 || player.tailType == Tail.NEKOMATA_FORKED_2_3) && rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.CAT) {
				//hoof to cat:
				if (player.lowerBody == LowerBody.HOOFED) {
					outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>");
					if (player.isTaur()) outputText("  You feel woozy and collapse on your side.  When you wake, you're no longer a centaur and your body has returned to a humanoid shape.");
				}
				//Goo to cat
				else if (player.lowerBody == LowerBody.GOO) {
					outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into digitigrade legs, complete with soft, padded cat-paws.  <b>You now have cat-paws!</b>");
				}
				//non hoof to cat:
				else outputText("\n\nYou scream in agony as you feel the bones in your [feet] break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>");
				setLowerBody(LowerBody.CAT);
				player.legCount = 2;
				changes++;
			}
			//Da cat arm
			if (player.lowerBody == LowerBody.CAT && type != 3 && rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.CAT) {
				if (player.arms.type != Arms.HUMAN) {
					humanizeArms();
					outputText(" ");
				}
				else outputText("\n\n");
				outputText("Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have cat paw hands.</b>");
				setArmType(Arms.CAT);
				changes++;
			}
			if (player.lowerBody == LowerBody.CAT && type == 3 && rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.DISPLACER) {
				if (player.arms.type != Arms.HUMAN) {
					humanizeArms();
					outputText(" ");
				}
				else outputText("\n\n");
				outputText("Something weird is happening around the level of your ribcage. Painfully large bumps start expanding on the side of your body. You fall on all fours panting heavily from the pain as two new limbs surge under your arms. As you sit, trying to grab these new limbs to check them out, you grab your arms instead. No wait your arm grabbed your arm that grabs another arm?! As you examine yourself you discover a second set of limbs grew under your arms. <b>Guess if your mind actually managed to process the action correctly you could actually use four weapons at once, instead you move around on your three set of limbs not unlike a displacer beast.</b>");
				setArmType(Arms.DISPLACER);
				changes++;
			}
			if (player.rearBody.type != RearBody.DISPLACER_TENTACLES && type == 3 && rand(3) == 0 && changes < changeLimit && player.arms.type == Arms.DISPLACER) {
				if (player.rearBody.type != RearBody.NONE) outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it.  After a moment the pain passes, though your back is back to what you looked like when you entered this realm! ");
				else outputText("\n\n");
				outputText("Two large fleshy lumps explode from your shoulders and you scream in pain. These fleshy appendages weave and move like whips in your back and only stop doing so when you finally manage to calm yourself. <b>As you look back to see what's going on, you notice you now have a pair of tentacles with thick, fleshy heads. You can feel the air brushing over the sensitive needles and suction cups that cover both of them, your new venom glistening on the tips.</b>");
				setRearBody(RearBody.DISPLACER_TENTACLES);
				changes++;
			}
			if (player.arms.type == Arms.CAT && type == 1 && player.rearBody.type != RearBody.LION_MANE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>");
				setRearBody(RearBody.LION_MANE);
				changes++;
			}
			if ((player.faceType == Face.CAT || player.faceType == Face.CAT_CANINES) && type == 2 && rand(3) == 0 && changes < changeLimit && player.faceType != Face.CHESHIRE && player.faceType != Face.CHESHIRE_SMILE) {
				outputText("\n\nYou suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>");
				if (player.faceType == Face.CAT) setFaceType(Face.CHESHIRE);
				if (player.faceType == Face.CAT_CANINES) setFaceType(Face.CHESHIRE_SMILE);
				changes++;
			}
			//CAT-FACE!
			if (player.lowerBody == LowerBody.CAT && rand(3) == 0 && changes < changeLimit && type != 1 && (player.faceType != Face.CAT || player.faceType != Face.CAT_CANINES || player.faceType != Face.CHESHIRE || player.faceType != Face.CHESHIRE_SMILE)) {
				if (player.faceType != Face.CAT) {
					choice = rand(3);
					if (choice == 0) outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>");
					else if (choice == 1) outputText("\n\nMind-numbing pain courses through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>");
					else outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>");
					setFaceType(Face.CAT);
				}
				else {
					outputText("\n\n");
					if (player.faceType != Face.HUMAN) outputText("Your face suddenly mold back into its former human shape. However you feel your canine changing elongating into sharp dagger-like teeth capable of causing severe injuries. ");
					outputText("You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>");
					setFaceType(Face.CAT_CANINES);
				}
				changes++;
			}
			if (player.lowerBody == LowerBody.CAT && rand(3) == 0 && changes < changeLimit && type == 1 && player.faceType != Face.CAT_CANINES) {
				outputText("\n\n");
				if (player.faceType != Face.HUMAN) outputText("Your face suddenly mold back into its former human shape. However you feel your canine changing elongating into sharp dagger-like teeth capable of causing severe injuries. ");
				outputText("You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>");
				setFaceType(Face.CAT_CANINES);
				changes++;
			}
			//CAT TOUNGE CUZ WHY NOT?
			if ((player.faceType == Face.CAT || player.faceType == Face.CAT_CANINES || player.faceType == Face.CHESHIRE || player.faceType == Face.CHESHIRE_SMILE) && player.tongue.type != Tongue.CAT && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour tongue suddenly feel weird. You try to stick it out to see what’s going on and discover it changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>");
				setTongueType(Tongue.CAT);
				changes++;
			}
			//DAT EYES
			if (rand(3) == 0 && changes < changeLimit && player.tongue.type == Tongue.CAT && player.eyes.type != Eyes.CAT_SLITS) {
				//Gain cat-like eyes
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.  <b>Your eyes has turned into those of cat with vertical slit.</b>");
				setEyeType(Eyes.CAT_SLITS);
				changes++;
			}
			//cheshire fur color
			if (type == 2 && rand(4) == 0 && changes < changeLimit && player.hasCoatOfType(Skin.FUR)) {
				outputText("\n\nYour fur and hair color are suddenly changing as lilac fur covered with white stripe begins to cover every area you have fur on. Your hair also changed color to match it turning to lilac strands separated by white strands every now and then. This change makes you feel like smiling at the absurdity of it all.");
				player.hairColor = "lilac and white striped";
				player.coatColor = "lilac and white striped";
				changes++;
			}
			//switching between low and high coverage of fur
			if (player.hasFur() && rand(3) == 0 && changes < changeLimit && type != 1) {
				if (player.skin.coverage == Skin.COVERAGE_COMPLETE || player.skin.coverage == Skin.COVERAGE_HIGH) {
					outputText("\n\nWhat used to be a dense coat of fur begins to fall in patches on the ground leaving you with just enough fur to cover some area of your body.  <b>Some area of your body are now partially covered with fur!</b>");
					player.skin.coverage = Skin.COVERAGE_LOW;
					changes++;
				}
				else {
					outputText("\n\nYou feel your skin tickle as more fur grows to cover the areas you did not already had fur at. Guess you have truly joined the furry club now.  <b>Your skin is now entirely coated with fur.</b>");
					player.skin.coverage = Skin.COVERAGE_COMPLETE;
					changes++;
				}
			}
			//TURN INTO A FURRAH!  OH SHIT
			if (player.eyes.type == Eyes.CAT_SLITS && rand(3) == 0 && changes < changeLimit && !player.hasCoatOfType(Skin.FUR)) {
				humanizeSkin();
				if (type == 1) {
					player.skin.growCoat(Skin.FUR,{color:randomChoice(["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white"])},Skin.COVERAGE_LOW);
					outputText("\n\nYou feel your skin tickle as fur grow in various place over your body. It doesn’t cover your skin entirely but sure feels nice and silky to the touch wherever it has grown. Funnily the fur patterns looks nice on you and only helps your animalistic charm. <b>Some area of your body are now partially covered with fur!</b>");
				}
				else {
					outputText("\n\nYour [skin.type] begins to tingle, then itch. ");
					if (type == 3) player.skin.growCoat(Skin.FUR,{color:randomChoice(["black", "midnight black"])},Skin.COVERAGE_COMPLETE);
					else player.skin.growCoat(Skin.FUR,{color:randomChoice(["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white"])},Skin.COVERAGE_COMPLETE);
					outputText("You reach down to scratch your arm absent-mindedly and pull your fingers away to find strands of [skin coat.color] fur. Wait, fur?  What just happened?! You spend a moment examining yourself and discover that <b>you are now covered in glossy, soft fur.</b>");
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			if (changes < changeLimit) {
				if (rand(2) == 0) outputText(player.modThickness(5, 2));
				if (rand(2) == 0) outputText(player.modTone(76, 2));
				if (player.gender < 2) if (rand(2) == 0) outputText(player.modFem(65, 1));
				else outputText(player.modFem(85, 2));
			}
			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(50, true);
				dynStats("lus", 3);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function reptilum(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You uncork the vial of fluid and drink it down.  The taste is sour, like a dry wine with an aftertaste not entirely dissimilar to alcohol.  Instead of the warmth you'd expect, it leaves your throat feeling cold and a little numb.");

			//Statistical changes:
			//-Reduces speed down to 50.
			if (player.spe > 50 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
				dynStats("spe", -1);
				changes++;
			}
			//-Reduces sensitivity.
			if (player.sens > 20 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe sensation of prickly pins and needles moves over your body, leaving your senses a little dulled in its wake.");
				dynStats("sen", -1);
				changes++;
			}
			//Raises libido greatly to 50, then somewhat to 75, then slowly to 100.
			if (player.lib < 100 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender != 3 || rand(2) == 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your [cocks] with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your [vagina].  An instinctive desire to mate and lay eggs spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				//+3 lib if less than 50
				if (player.lib < 50) dynStats("lib", 1);
				//+2 lib if less than 75
				if (player.lib < 75) dynStats("lib", 1);
				//+1 if above 75.
				dynStats("lib", 1);
				changes++;
			}
			//-Raises toughness to 70
			//(+3 to 40, +2 to 55, +1 to 70)
			if (player.tou < 70 && changes < changeLimit && rand(3) == 0) {
				//(+3)
				if (player.tou < 40) {
					outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher your hide has gotten.");
					dynStats("tou", 3);
				}
				//(+2)
				else if (player.tou < 55) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your [skin.type] getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				changes++;
			}

			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual Changes:
			//-Lizard dick - first one
			if (player.lizardCocks() == 0 && player.cockTotal() > 0 && changes < changeLimit && rand(4) == 0) {
				//Find the first non-lizzy dick
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				outputText("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate.  Your " + cockDescript(temp2) + " is changing!  It ripples loosely from ");
				if (player.hasSheath()) outputText("sheath ");
				else outputText("base ");
				outputText("to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker ");
				if (player.cor < 33) outputText("horrifies you.");
				else if (player.cor < 66) outputText("is a little strange for your tastes.");
				else {
					outputText("looks like it might be more fun to receive than use on others.  ");
					if (player.hasVagina()) outputText("Maybe you could find someone else with one to ride?");
					else outputText("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				outputText("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (player.cockTotal() > 1 && player.lizardCocks() > 0 && player.cockTotal() > player.lizardCocks() && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor].  As if operating on a cue, ");
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("another one of your dicks");
				outputText(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  ");
				if (player.cumQ() < 50) outputText("pre-cum oozes from the tip");
				else if (player.cumQ() < 700) outputText("Thick pre-cum rains from the tip");
				else outputText("A wave of pre-cum splatters on the ground");
				outputText(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//-Grows second lizard dick if only 1 dick
			if (player.lizardCocks() == 1 && player.cocks.length == 1 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA knot of pressure forms in your groin, forcing you off your [feet] as you try to endure it.  You examine the affected area and see a lump starting to bulge under your [skin.type], adjacent to your [cock].  The flesh darkens, turning purple");
				if (player.hasCoat())
					outputText(" and shedding " + player.coatColor);
				outputText(" as the bulge lengthens, pushing out from your body.  Too surprised to react, you can only pant in pain and watch as the fleshy lump starts to take on a penis-like appearance.  <b>You're growing a second lizard-cock!</b>  It doesn't stop growing until it's just as long as its brother and the same shade of shiny purple.  A dribble of cum oozes from its tip, and you feel relief at last.");

				player.createCock();
				player.cocks[1].cockType = CockTypesEnum.LIZARD;
				player.cocks[1].cockLength = player.cocks[0].cockLength;
				player.cocks[1].cockThickness = player.cocks[0].cockThickness;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//--Worms leave if 100% lizard dicks?
			//Require mammals?
			if (player.lizardCocks() == player.cockTotal() && changes < changeLimit && player.hasStatusEffect(StatusEffects.Infested)) {
				outputText("\n\nLike rats from a sinking ship, worms escape from your body in a steady stream.  Surprisingly, the sensation is remarkably pleasant, similar to the pleasure of sexual release in a way.  Though they seem inexhaustible, the tiny, cum-slimed invertebrates slow to a trickle.  The larger worm-kin inside you stirs as if disturbed from a nap, coming loose from whatever moorings it had attached itself to in the interior of your form.  It slowly works its way up your urethra, stretching to an almost painful degree with every lurching motion.  Your dick bloats out around the base, stretched like the ovipositor on a bee-girl in order to handle the parasitic creature, but thankfully, the ordeal is a brief one.");
				if (player.balls > 1) outputText("  The remaining " + num2Text(player.balls - 1) + " slither out the pre-stretched holes with ease, though the last one hangs from your tip for a moment before dropping to the ground.");
				outputText("  The white creature joins its kin on the ground and slowly slithers away.  Perhaps they prefer mammals? In any event, <b>you are no longer infected with worms</b>.");
				player.removeStatusEffect(StatusEffects.Infested);
				changes++;
			}
			//-Breasts vanish to 0 rating if male
			if (player.biggestTitSize() >= 1 && player.gender == 1 && changes < changeLimit && rand(3) == 0) {
				//(HUEG)
				if (player.biggestTitSize() > 8) {
					outputText("\n\nThe flesh on your chest tightens up, losing nearly half its mass in the span of a few seconds.  With your center of balance shifted so suddenly, you stagger about trying not to fall on your ass.  You catch yourself and marvel at the massive change in breast size.");
					//Half tit size
				}
				//(NOT HUEG < 4)
				else outputText("\n\nIn an instant, your chest compacts in on itself, consuming every ounce of breast-flesh.  You're left with a  smooth, masculine torso, though your nipples remain.");
				//(BOTH – no new PG)
				outputText("  With the change in weight and gravity, you find it's gotten much easier to move about.");
				//Loop through behind the scenes and adjust all tits.
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					if (player.breastRows[temp2].breastRating > 8) player.breastRows[temp2].breastRating /= 2;
					else player.breastRows[temp2].breastRating = 0;
				}
				//(+2 speed)
				dynStats("lib", 2);
				changes++;
			}
			//-Lactation stoppage.
			if (player.biggestLactation() >= 1 && changes < changeLimit && rand(4) == 0) {
				if (player.totalNipples() == 2) outputText("\n\nBoth of your");
				else outputText("\n\nAll of your many");
				outputText(" nipples relax.  It's a strange feeling, and you pull back your top to touch one.  It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel when nothing ");
				if (player.hasFuckableNipples()) outputText("but sexual fluid ");
				outputText("escapes it.  <b>You are no longer lactating.</b>  That makes sense, only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.");
				if (player.findPerk(PerkLib.Feeder) >= 0 || player.hasStatusEffect(StatusEffects.Feeder)) {
					outputText("\n\n(<b>Feeder perk lost!</b>)");
					player.removePerk(PerkLib.Feeder);
					player.removeStatusEffect(StatusEffects.Feeder);
				}
				changes++;
				//Loop through and reset lactation
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					player.breastRows[temp2].lactationMultiplier = 0;
				}
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA chill runs over your [allbreasts] and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					player.breastRows[temp2].nipplesPerBreast = 1;
				}
			}
			//-VAGs
			if (player.hasVagina() && player.findPerk(PerkLib.Oviposition) < 0 && changes < changeLimit && rand(5) == 0 && player.lizardScore() > 3) {
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n");
				outputText("(<b>Perk Gained: Oviposition</b>)");
				player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
				changes++;
			}

			//Physical changes:
			//-Existing horns become draconic, max of 4, max length of 1'
			if (player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG && player.horns.type != Horns.ORCHID && player.horns.type != Horns.GARGOYLE && changes < changeLimit && rand(5) == 0) {
				//No dragon horns yet.
				if (player.horns.type != Horns.DRACONIC_X2 && player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG) {
					//Already have horns
					if (player.horns.count > 0) {
						//High quantity demon horns
						if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
							outputText("\n\nYour horns condense, twisting around each other and merging into larger, pointed protrusions.  By the time they finish you have four draconic-looking horns, each about twelve inches long.");
							setHornType(Horns.DRACONIC_X4_12_INCH_LONG, 12);
						}
						else {
							outputText("\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
							setHornType(Horns.DRACONIC_X2);
							if (player.horns.count > 13) {
								outputText("  The change seems to have shrunken the horns, they're about a foot long now.");
								player.horns.count = 12;
							}
						}
						changes++;
					}
					//No horns
					else {
						//-If no horns, grow a pair
						outputText("\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horns sprout from your head before stopping.  <b>You have about four inches of dragon-like horns.</b>");
						setHornType(Horns.DRACONIC_X2, 4);
						changes++;
					}
				}
				//ALREADY DRAGON
				else {
					if (player.horns.type == Horns.DRACONIC_X2) {
						if (player.horns.count < 12) {
							if (rand(2) == 0) {
								outputText("\n\nYou get a headache as an inch of fresh horns escapes from your pounding skull.");
								player.horns.count += 1;
							}
							else {
								outputText("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
								player.horns.count += 2 + rand(4);
							}
							if (player.horns.count >= 12) outputText("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
							changes++;
						}
						//maxxed out, new row
						else {
							//--Next horns growth adds second row and brings length up to 12\"
							outputText("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a lizan can grow.</b>");
							setHornType(Horns.DRACONIC_X4_12_INCH_LONG);
							changes++;
						}
					}
				}
			}
			//-Hair stops growing!
			if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0 && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour scalp tingles oddly.  In a panic, you reach up to your [hair], but thankfully it appears unchanged.\n\n");
				outputText("(<b>Your hair has stopped growing.</b>)");
				changes++;
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD]++;
			}
			//Remove beard!
			if (player.hasBeard() && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour " + beardDescript() + " feels looser and looser until finally, your beard falls out.  ");
				outputText("(<b>You no longer have a beard!</b>)");
				player.beardLength = 0;
				player.beardStyle = 0;
			}
			//Big physical changes:
			//-Legs – Draconic, clawed feet
			if (player.lowerBody != LowerBody.LIZARD && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(5) == 0) {
				//Hooves -
				if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with lizard-like claws.");
				//feet types -
				else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.PLANT_ROOT_CLAWS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have reptilian legs and claws!</b>");
				setLowerBody(LowerBody.LIZARD);
				player.legCount = 2;
				changes++;
			}
			//Arms
			if (player.arms.type != Arms.LIZARD && player.lowerBody == LowerBody.LIZARD && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of lizard one with leathery scales and short claws replacing your fingernails.  <b>You now have lizard arms.</b>");
				setArmType(Arms.LIZARD);
				changes++;
			}
			//-Tail – sinuous lizard tail
			if (player.tailType != Tail.LIZARD && player.arms.type == Arms.LIZARD && changes < changeLimit && rand(5) == 0) {
				//No tail
				if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>");
				//Yes tail
				else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>");
				setTailType(Tail.LIZARD);
				changes++;
			}
			//Lizard eyes
			if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.eyes.type == Eyes.HUMAN) {
				outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a reptile taking on a yellow hue.  <b>You now have reptilian eyes!</b>");
				setEyeTypeAndColor(Eyes.REPTILIAN, "yellow");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type > Eyes.HUMAN && player.eyes.type != Eyes.REPTILIAN) {
				humanizeEyes();
				changes++;
			}
			//-Ears become smaller nub-like openings?
			if (player.ears.type != Ears.LIZARD && player.tailType == Tail.LIZARD && player.lowerBody == LowerBody.LIZARD && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nTightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers.  <b>You have reptilian ears!</b>");
				setEarType(Ears.LIZARD);
				changes++;
			}
			//-Scales – color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (!player.hasFullCoatOfType(Skin.SCALES) && player.ears.type == Ears.LIZARD && player.tailType == Tail.LIZARD && player.lowerBody == LowerBody.LIZARD && changes < changeLimit && rand(5) == 0) {
				var color:String;
				if (rand(10) == 0) {
					color = randomChoice("purple","silver");
				} else {
					color = randomChoice("red","green","white","blue","black");
				}
				//(fur)
				if (player.hasFur()) {
					outputText("\n\nYou scratch yourself, and come away with a large clump of [skin coat.color] fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + color + " scales covering most of your body.  The rest of the fur is easy to remove.  <b>You're now covered in scales from head to toe.</b>");
				}
				//(no fur)
				else {
					outputText("\n\nYou idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard.  A quick glance down reveals that scales are growing out of your " + player.skinTone + " skin with alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body.  <b>You're covered from head to toe in shiny " + color + " scales.</b>");
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedScales)) {
					outputText("\n\n<b>Genetic Memory: Scales - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedScales, 0, 0, 0, 0);
				}
				player.skin.growCoat(Skin.SCALES,{color:color});
				changes++;
			}
			//-Lizard-like face.
			if (player.faceType != Face.LIZARD && player.hasScales() && player.ears.type == Ears.LIZARD && player.tailType == Tail.LIZARD && player.lowerBody == LowerBody.LIZARD && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nTerrible agony wracks your [face] as bones crack and shift.  Your jawbone rearranges while your cranium shortens.  The changes seem to last forever; once they've finished, no time seems to have passed.  Your fingers brush against your toothy snout as you get used to your new face.  It seems <b>you have a toothy, reptilian visage now.</b>");
				setFaceType(Face.LIZARD);
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(50, true);
				dynStats("lus", 3);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}


		public function salamanderfirewater(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You uncork the hip flash and drink it down.  The taste is actualy quite good, like an alcohol but with a little fire within.  Just as you expected it makes you feel all hot and ready to take whole world head on.");
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			//Statistical changes:
			//-Reduces speed down to 70.
			if (player.spe > 70 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou start to feel sluggish.  Lying down and enjoying liquor might make you feel better.");
				dynStats("spe", -1);
				changes++;
			}
			//-Reduces intelligence down to 60.
			if (player.inte > 60 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou start to feel a bit dizzy, but the sensation quickly passes.  Thinking hard on it, you mentally brush away the fuzziness that seems to permeate your brain and determine that this firewater may have actually made you dumber.  It would be best not to drink too much of it.");
				dynStats("int", -1);
				changes++;
			}
			//-Raises libido up to 90.
			if (player.lib < 90 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender != 3 || rand(2) == 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your [cocks] with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your [vagina].  An instinctive desire to mate spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				dynStats("lib", 2);
				changes++;
			}
			//-Raises toughness up to 90.
			//(+3 to 50, +2 to 70, +1 to 90)
			if (player.tou < 90 && changes < changeLimit && rand(3) == 0) {
				//(+3)
				if (player.tou < 50) {
					outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it is now.");
					dynStats("tou", 3);
				}
				//(+2)
				else if (player.tou < 70) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your [skin.type] getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				changes++;
			}
			//-Raises strength to 80.
			if (player.str < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWhile heat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength than before.");
				dynStats("str", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual Changes:
			//-Lizard dick - first one
			if (player.lizardCocks() == 0 && player.cockTotal() > 0 && changes < changeLimit && rand(4) == 0) {
				//Find the first non-lizzy dick
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				outputText("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate.  Your " + cockDescript(temp2) + " is changing!  It ripples loosely from ");
				if (player.hasSheath()) outputText("sheath ");
				else outputText("base ");
				outputText("to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker ");
				if (player.cor < 33) outputText("horrifies you.");
				else if (player.cor < 66) outputText("is a little strange for your tastes.");
				else {
					outputText("looks like it might be more fun to receive than use on others.  ");
					if (player.hasVagina()) outputText("Maybe you could find someone else with one to ride?");
					else outputText("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				outputText("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (player.cockTotal() > 1 && player.lizardCocks() > 0 && player.cockTotal() > player.lizardCocks() && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor].  As if operating on a cue, ");
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("another one of your dicks");
				outputText(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  ");
				if (player.cumQ() < 50) outputText("pre-cum oozes from the tip");
				else if (player.cumQ() < 700) outputText("Thick pre-cum rains from the tip");
				else outputText("A wave of pre-cum splatters on the ground");
				outputText(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//-Breasts vanish to 0 rating if male
			if (player.biggestTitSize() >= 1 && player.gender == 1 && changes < changeLimit && rand(3) == 0) {
				//(HUEG)
				if (player.biggestTitSize() > 8) {
					outputText("\n\nThe flesh on your chest tightens up, losing nearly half its mass in the span of a few seconds.  With your center of balance shifted so suddenly, you stagger about trying not to fall on your ass.  You catch yourself and marvel at the massive change in breast size.");
					//Half tit size
				}
				//(NOT HUEG < 4)
				else outputText("\n\nIn an instant, your chest compacts in on itself, consuming every ounce of breast-flesh.  You're left with a  smooth, masculine torso, though your nipples remain.");
				//(BOTH – no new PG)
				outputText("  With the change in weight and gravity, you find it's gotten much easier to move about.");
				//Loop through behind the scenes and adjust all tits.
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					if (player.breastRows[temp2].breastRating > 8) player.breastRows[temp2].breastRating /= 2;
					else player.breastRows[temp2].breastRating = 0;
				}
				//(+2 speed)
				dynStats("lib", 2);
				changes++;
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA chill runs over your [allbreasts] and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					player.breastRows[temp2].nipplesPerBreast = 1;
				}
			}
			//Increase player's breast size, if they are big DD or smaller
			if (player.smallestTitSize() <= 5 && player.gender == 2 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//Physical changes:
			//Tail - unlocks enhanced with fire tail whip attack
			if (player.tailType != Tail.SALAMANDER && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				//No tail
				if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail!</b>");
				//Yes tail
				else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail.</b>");
				setTailType(Tail.SALAMANDER);
				changes++;
			}
			//Legs
			if (player.lowerBody != LowerBody.SALAMANDER && player.tailType == Tail.SALAMANDER && changes < changeLimit && rand(3) == 0) {
				//Hooves -
				if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with salamander-like claws.");
				//feet types -
				else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have salamander legs and claws!</b>");
				setLowerBody(LowerBody.SALAMANDER);
				player.legCount = 2;
				changes++;
			}
			//Arms
			if (player.arms.type != Arms.SALAMANDER && player.arms.type != Arms.GARGOYLE && player.lowerBody == LowerBody.SALAMANDER && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of salamander one with leathery, red scales and short claws replacing your fingernails.  <b>You now have a salamander arms.</b>");
				setArmType(Arms.SALAMANDER);
				changes++;
			}
			//Lizard eyes
			if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.eyes.type == Eyes.HUMAN) {
				outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a reptile taking on a yellow hue.  <b>You now have reptilian eyes!</b>");
				setEyeTypeAndColor(Eyes.REPTILIAN, "ember");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(4) == 0 && player.eyes.type > Eyes.HUMAN && player.eyes.type != Eyes.REPTILIAN) {
				humanizeEyes();
				changes++;
			}
			//Fanged face
			if (player.faceType == Face.HUMAN && player.faceType != Face.SALAMANDER_FANGS && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour tooth's suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat.  <b>You now have fangs.</b>");
				setFaceType(Face.SALAMANDER_FANGS);
				changes++;
			}
			if (player.faceType != Face.HUMAN && player.faceType != Face.SALAMANDER_FANGS && changes < changeLimit && rand(4) == 0) {
				humanizeFace();
				changes++;
			}
			//Human ears
			if (player.faceType == Face.SALAMANDER_FANGS && player.ears.type != Ears.HUMAN && changes < changeLimit && rand(4) == 0) {
				humanizeEars();
				changes++;
			}
			//Partial scaled skin
			if (player.hasPlainSkinOnly() && rand(3) == 0) {
				outputText("\n\nYou feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.");
				outputText("  <b>Your body is now partially covered with small patches of scales!</b>");
				player.skin.growCoat(Skin.SCALES,{color:"red"},Skin.COVERAGE_LOW);
				changes++;
			}
			if (!player.hasPartialCoat(Skin.SCALES) && !player.isGargoyle() && rand(4) == 0) {
				humanizeSkin();
				changes++;
			}
			//Removing gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(100, true);
				dynStats("lus", 5);
			}
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function methircrystal(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You chew on the weird glowy crystal, which begins to melt in your mouth like sugar. Your head spin for a moment as you begin to have hallucinations. This leaves you with weird feeling in your entire body, filling you with changes.");
			//-Raises toughness up to 70.
			//(+2 to 50, +1 to 70)
			if (player.tou < 70 && changes < changeLimit && rand(3) == 0) {
				//(+2)
				if (player.tou < 50) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your [skin.type] getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				changes++;
			}
			//-Raises strength to 60.
			if (player.str < 60 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWhile heat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength than before.");
				dynStats("str", 1);
				changes++;
			}
			//Raises libido to 80.
			if (player.lib < 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender != 3 || rand(2) == 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your [cocks] with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your [vagina].  An instinctive desire to mate and lay eggs spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				//+2 lib if less than 60
				if (player.lib < 60) dynStats("lib", 1);
				//+1 if above 60.
				dynStats("lib", 1);
				changes++;
			}
			//Lower wisdom down to 40
			
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			
			//-Grow hips out if narrow.
			if (player.hips.type < 10 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour [hips] widens into a larger shape likely to fit your ass better.");
				player.hips.type++;
				changes++;
			}
			//-Big booty
			if (player.butt.type < 8 && changes < changeLimit && rand(3) == 0) {
				player.butt.type++;
				changes++;
				outputText("\n\nYour butt cheeks itch as they inflates to a larger plumper size. When it stops, you find yourself the proud owner of a " + buttDescript() + ".");
			}
			//Glowing Lizard Cock:
			if (player.cockTotal() > 1 && player.lizardCocks() > 0 && player.cockTotal() > player.lizardCocks() && rand(4) == 0 && changes < changeLimit) {
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.CAVE_WYRM) break;
				}
				outputText("\n\nYou feel a sudden itch in your cock and undress as an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your “cock descript” you discover it has not only changed color to neon blue but reshaped into a lizard cock. Furthermore it seems to naturally glow in the dark like the fluids that comes out of it. <b>You now have a neon blue lizard cock that glow in the dark.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.CAVE_WYRM;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.CAVE_WYRM;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//Vagina Turns Glowing:
			if (player.hasVagina() && player.vaginaType() != 6 && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel a sudden jolt in your pussy and undress as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue fluids. Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  <b>You now have a neon blue pussy that glow in the dark.</b>");
				dynStats("sen", 2, "lus", 10);
				player.vaginaType(6);
				changes++;
			}
			//Physical changes:
			//Nipples Start Glowing:
			if (!player.hasStatusEffect(StatusEffects.GlowingNipples) && !player.hasStatusEffect(StatusEffects.BlackNipples) && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly feel an itch in your nipples and undress to check up on them. To your surprise they begin to glow with a fluorescent blue light. Well, this will be interesting.  <b>You now have neon blue nipples that glow in the dark.</b>");
				player.createStatusEffect(StatusEffects.GlowingNipples, 0, 0, 0, 0);
				changes++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Tail
			if (player.tailType != Tail.CAVE_WYRM && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				if (player.tailType != Tail.NONE) outputText("You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground.  ");
				outputText("A large bump starts to grow out of your " + assDescript() + ", making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail with patches of black scales which taper on the ground. Its fat and chubby like that of a newt and its heavy weight helps you keep your balance not to mention that people will just want to outright hug it.  <b>You have grown a large earth wyrm tail.</b>");
				setTailType(Tail.CAVE_WYRM);
				changes++;
			}
			//Legs
			if (player.lowerBody != LowerBody.CAVE_WYRM && player.tailType == Tail.CAVE_WYRM && changes < changeLimit && rand(3) == 0) {
				//Hooves -
				if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with cave wyrm-like claws.");
				//feet types -
				else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have cave wyrm legs and claws!</b>");
				setLowerBody(LowerBody.CAVE_WYRM);
				player.legCount = 2;
				changes++;
			}
			//Arms
			if (player.arms.type != Arms.CAVE_WYRM && player.arms.type != Arms.GARGOYLE && player.lowerBody == LowerBody.CAVE_WYRM && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of cave wyrm one with leathery, black scales and short claws replacing your fingernails.  <b>You now have a cave wyrm arms.</b>");
				setArmType(Arms.CAVE_WYRM);
				changes++;
			}
			//Fanged face
			if (player.faceType == Face.HUMAN && player.faceType != Face.SALAMANDER_FANGS && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour tooth's suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat.  <b>You now have fangs.</b>");
				setFaceType(Face.SALAMANDER_FANGS);
				changes++;
			}
			if (player.faceType != Face.HUMAN && player.faceType != Face.SALAMANDER_FANGS && changes < changeLimit && rand(4) == 0) {
				humanizeFace();
				changes++;
			}
			//Lizard eyes
			if (changes < changeLimit && rand(3) == 0 && player.faceType == Face.SALAMANDER_FANGS && player.eyes.type == Eyes.HUMAN) {
				outputText("\n\nSomething shift in your eyes as the level of light around you seems to increase. You go to check on what happened and discover your pupils not only changed to reptilian slits but now glow with a neon blue light. Well seeing in the dark will be easy with your <b>new dark blue iris with reptilian neon blue pupils that glow in the dark.</b>");
				setEyeTypeAndColor(Eyes.CAVE_WYRM, "dark blue");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(4) == 0 && player.eyes.type > Eyes.HUMAN && player.eyes.type != Eyes.CAVE_WYRM) {
				humanizeEyes();
				changes++;
			}
			//Ears
			if (player.faceType == Face.SALAMANDER_FANGS && player.ears.type != Ears.CAVE_WYRM && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour ears suddenly start to tingle. Strangely they change shape into something entirely different from what you would expect on a reptile covering in fur like those of cave wyrms. You can hear sound more acutely with your <b>new cave wyrm furry ears.</b>");
				setEarType(Ears.CAVE_WYRM);
				changes++;
			}
			//Tongue
			if (player.tongue.type == Tongue.HUMAN && player.tongue.type != Tongue.CAVE_WYRM && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething change in your mouth and you feel like you are about to choke! You stick your tongue out and discover to your surprise that it now glows with a neon blue light. Furthermore it stick out way further then it should, just like a lizard.  <b>You now have a neon blue lizard tongue that glow in the dark.</b>");
				setTongueType(Tongue.CAVE_WYRM);
				changes++;
			}
			if (player.tongue.type != Tongue.HUMAN && player.tongue.type != Tongue.CAVE_WYRM && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
				setTongueType(Tongue.HUMAN);
				changes++;
			}
			//Partial scaled skin
			if (player.hasPlainSkinOnly() && rand(3) == 0) {
				outputText("\n\nYou feel your skin shift as black scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.");
				outputText("  <b>Your body is now partially covered with small patches of black scales!</b>");
				player.skin.growCoat(Skin.SCALES,{color:"black"},Skin.COVERAGE_LOW);
				changes++;
			}
			if (!player.hasPartialCoat(Skin.SCALES) && !player.isGargoyle() && rand(4) == 0) {
				humanizeSkin();
				changes++;
			}
			//Skin color change
			if (player.skinTone != "greyish blue" && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou skin begin to itch as it darkens taking on <b>a greyish blue color.</b>");
				player.skinTone = "greyish blue";
				changes++;
			}
			//Acid Spit
			if (player.findPerk(PerkLib.AcidSpit) < 0 && changes < changeLimit && rand(5) == 0 && player.cavewyrmScore() > 4) {
				outputText("\n\nYour endowment begins to feel increasingly pleasurable to the point you drool small glowing blue drop of saliva on the ground lost in the pleasure of your oozing vagina/ and / dripping penis. You lose all desire as your eyes zero in on the smoking vegetation progressively corroded by your fluorescent drool. <b>It seems you now can drool acid!</b>\n");
				outputText("(<b>Perk Gained: Acid Spit</b>)");
				player.createPerk(PerkLib.AcidSpit, 0, 0, 0, 0);
				changes++;
			}
			//Azureflame Breath
			if (player.findPerk(PerkLib.AzureflameBreath) < 0 && changes < changeLimit && rand(5) == 0 && player.cavewyrmScore() > 4) {
				outputText("\n\nYou suddenly belch a long neon blue flame in front of you roasting the nearby vegetation. It didn't hurt your throat however so you shrug. <b>Well you will have to control your blue fire breath better not to set fire to your own camp.</b>\n");
				outputText("(<b>Perk Gained: Azureflame Breath</b>)");
				player.createPerk(PerkLib.AzureflameBreath, 0, 0, 0, 0);
				changes++;
			}
			//Removing gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(100, true);
				dynStats("lus", 5);
			}
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function nocelloliquer(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You uncork the bottle and drink it down.  The taste is actualy quite sweet, like an alcohol but with a hint of hazelnuts flavor.  Would it change anything about you than making feeling of warmth spreading inside?");
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			//Statistical changes:
			//-Raises speed up to 90.
			if (changes < changeLimit && rand(3) == 0 && player.spe < 90) {
				if (player.spe < 30) outputText("\n\nTingles run through your muscles, and your next few movements seem unexpectedly fast.  The liqueur somehow made you faster!");
				else if (player.spe < 50) outputText("\n\nYou feel tingles running through your body, and after a moment, it's clear that you're getting faster.");
				else if (player.spe < 65) outputText("\n\nThe tight, ready feeling you've grown accustomed to seems to intensify, and you know in the back of your mind that you've become even faster.");
				else outputText("\n\nSomething changes in your physique, and you grunt, chopping an arm through the air experimentally.  You seem to move even faster than before, confirming your suspicions.");
				dynStats("spe", 1);
				changes++;
			}
			//-Reduces intelligence down to 60.
			if (player.inte > 60 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou start to feel a bit dizzy, but the sensation quickly passes.  Thinking hard on it, you mentally brush away the fuzziness that seems to permeate your brain and determine that this firewater may have actually made you dumber.  It would be best not to drink too much of it.");
				dynStats("int", -1);
				changes++;
			}
			//-Raises libido up to 80.
			if (player.lib < 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender != 3 || rand(2) == 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your [cocks] with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your [vagina].  An instinctive desire to mate spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				dynStats("lib", 2);
				changes++;
			}
			//-Raises toughness up to 90.
			//(+3 to 50, +2 to 70, +1 to 90)
			if (player.tou < 90 && changes < changeLimit && rand(3) == 0) {
				//(+3)
				if (player.tou < 50) {
					outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it is now.");
					dynStats("tou", 3);
				}
				//(+2)
				else if (player.tou < 70) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your [skin.type] getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				changes++;
			}
			//-Reduces strength down to 70.
			if (player.str > 70) {
				dynStats("str", -1);
				if (player.str > 80) dynStats("str", -1);
				if (player.str > 90) dynStats("str", -1);
				outputText("\n\nYou feel a little weaker, but maybe it's just the liqueur.");
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual Changes:
			//-Lizard dick - first one
			if (player.lizardCocks() == 0 && player.cockTotal() > 0 && changes < changeLimit && rand(4) == 0) {
				//Find the first non-lizzy dick
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				outputText("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate.  Your " + cockDescript(temp2) + " is changing!  It ripples loosely from ");
				if (player.hasSheath()) outputText("sheath ");
				else outputText("base ");
				outputText("to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker ");
				if (player.cor < 33) outputText("horrifies you.");
				else if (player.cor < 66) outputText("is a little strange for your tastes.");
				else {
					outputText("looks like it might be more fun to receive than use on others.  ");
					if (player.hasVagina()) outputText("Maybe you could find someone else with one to ride?");
					else outputText("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				outputText("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (player.cockTotal() > 1 && player.lizardCocks() > 0 && player.cockTotal() > player.lizardCocks() && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor].  As if operating on a cue, ");
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType != CockTypesEnum.LIZARD) break;
				}
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("another one of your dicks");
				outputText(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  ");
				if (player.cumQ() < 50) outputText("pre-cum oozes from the tip");
				else if (player.cumQ() < 700) outputText("Thick pre-cum rains from the tip");
				else outputText("A wave of pre-cum splatters on the ground");
				outputText(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//Grow a cunt (guaranteed if no gender)
			if (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) == 0)) {
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.clitLength = .25;
				dynStats("sen", 10);
				changes++;
			}
			//WANG GROWTH
			if (!player.hasCock() && changes < changeLimit && rand(3) == 0) {
				//Genderless:
				if (!player.hasVagina()) outputText("\n\nYou feel a sudden stabbing pain in your featureless crotch and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of a new human-shaped penis");
				//Female:
				else outputText("\n\nYou feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of not only a [vagina], but a new human-shaped penis");
				if (player.balls == 0) {
					outputText(" and a pair of balls");
					player.balls = 2;
					player.ballSize = 2;
				}
				outputText("!");
				player.createCock(7, 1.4);
				dynStats("lib", 4, "sen", 5, "lus", 20);
				changes++;
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && player.breastRows.length == 1 && rand(4) == 0 && player.breastRows[0].breastRating >= 7)
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (player.breastRows[0].breastRating < 19)
				{
					player.shrinkTits();
				}
				//(H+)
				else {
					player.breastRows[0].breastRating -= (4 + rand(4));
					outputText("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + player.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && player.breastRows[0].breastRating < 2 && rand(4) == 0) {
				changes++;
				outputText("\n\nYour chest starts to tingle, the [skin.type] warming under your [armor]. Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (player.breastRows[0].breastRating < 1) outputText("  <b>You have breasts now!</b>");
				player.breastRows[0].breastRating = 2;
			}
			//-Grow hips out if narrow.
			if (player.hips.type < 10 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hips.type++;
				changes++;
			}
			//-Narrow hips if crazy wide
			if (player.hips.type >= 15 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour gait shifts inward, your [hips] narrowing significantly. They remain quite thick, but they're not as absurdly wide as before.");
				player.hips.type--;
				changes++;
			}
			//-Big booty
			if (player.butt.type < 8 && changes < changeLimit && rand(4) == 0) {
				player.butt.type++;
				changes++;
				outputText("\n\nA slight jiggle works through your rear, but instead of stopping it starts again. You can actually feel your [armor] being filled out by the growing cheeks. When it stops, you find yourself the proud owner of a " + buttDescript() + ".");
			}
			//-Narrow booty if crazy huge.
			if (player.butt.type >= 14 && changes < changeLimit && rand(4) == 0) {
				changes++;
				player.butt.type--;
				outputText("\n\nA feeling of tightness starts in your " + buttDescript() + ", increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your massive booty is shrinking into a more manageable size.");
			}
			//Physical changes:
			//Tail - unlocks enhanced with fire tail whip attack
			if (player.tailType != Tail.SALAMANDER && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				//No tail
				if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail!</b>");
				//Yes tail
				else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail.</b>");
				setTailType(Tail.SALAMANDER);
				changes++;
			}
			//Legs
			if (player.lowerBody != LowerBody.SALAMANDER && player.tailType == Tail.SALAMANDER && changes < changeLimit && rand(3) == 0) {
				//Hooves -
				if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with salamander-like claws.");
				//feet types -
				else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have salamander legs and claws!</b>");
				setLowerBody(LowerBody.SALAMANDER);
				player.legCount = 2;
				changes++;
			}
			//Arms
			if (!InCollection(Arms.GARGOYLE, Arms.PHOENIX) && changes < changeLimit && player.lowerBody == LowerBody.SALAMANDER && rand(4) == 0) {
				outputText("\n\nYou smile impishly as you lick the remains of the liqueur from your teeth, but when you go to wipe your mouth, instead of the usual texture of your [skin.type] on your lips, you feel feathers! You look on in horror while more of the crimson colored avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				changes++;
				setArmType(Arms.PHOENIX);
			}
			//Wings
			if (player.wings.type == Wings.NONE && changes < changeLimit && player.arms.type == Arms.PHOENIX && rand(4) == 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, crimson wings.</b>");
				setWingType(Wings.FEATHERED_PHOENIX, "large crimson feathered");
				changes++;
			}
			//Remove old wings
			if (player.wings.type != Wings.FEATHERED_PHOENIX && player.wings.type > Wings.NONE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				removeWings();
				changes++;
			}
			//-Feathery Hair
			if (player.hairType != 1 && changes < changeLimit && player.faceType == Face.HUMAN && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!");
				setHairType(Hair.FEATHER);
				changes++;
			}
			//Lizard eyes
			if (changes < changeLimit && rand(4) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.eyes.type == Eyes.HUMAN) {
				outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a reptile taking on a yellow hue.  <b>You now have reptilian eyes!</b>");
				setEyeTypeAndColor(Eyes.REPTILIAN, "yellow");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(4) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//Human face
			if (player.faceType != Face.HUMAN && changes < changeLimit && rand(4) == 0) {
				humanizeFace();
				changes++;
			}
			//Human ears
			if (player.faceType == Face.HUMAN && player.ears.type != Ears.HUMAN && changes < changeLimit && rand(4) == 0) {
				humanizeEars();
				changes++;
			}
			//Partial scaled skin
			if (player.hasPlainSkinOnly() && rand(4) == 0) {
				outputText("\n\nYou feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you.");
				outputText("  <b>Your body is now partially covered with small patches of scales!</b>");
				player.skin.growCoat(Skin.SCALES,{color:"red"},Skin.COVERAGE_LOW);
				changes++;
			}
			if (!player.hasPartialCoat(Skin.SCALES) && rand(4) == 0) {
				humanizeSkin();
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//Phoenix Fire Breath
			if (player.phoenixScore() >= 5 && changes < changeLimit && player.findPerk(PerkLib.PhoenixFireBreath) < 0) {
				outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself.  It had enough force to sent a little bit of dirt and shattered gravel all around.");
				outputText("\n\nIt seems Nocello liqueur has awaked some kind of power within you... your throat feel quite dry.  (<b>Gained Perk: Phoenix fire breath!</b>)");
				player.createPerk(PerkLib.PhoenixFireBreath, 0, 0, 0, 0);
				changes++;
			}
			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(100, true);
				dynStats("lus", 5);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

/*
		public function wingStick(player:Player):void
		{
			clearOutput();
			outputText("You toss a wingstick at your foe!  It flies straight and true, almost as if it has a mind of its own as it arcs towards " + monster.a + monster.short + "!\n");
			//1% dodge for each point of speed over 80
			if (monster.spe - 80 > rand(100) + 1 || monster.short == "lizan rogue") {
				outputText("Somehow " + monster.a + monster.short + "'");
				if (!monster.plural) outputText("s");
				outputText(" incredible speed allows " + monster.pronoun2 + " to avoid the spinning blades!  The deadly device shatters when it impacts something in the distance.");
			}
			//Not dodged
			else {
				var damage:Number = 40 + rand(61);
				outputText(monster.capitalA + monster.short + " is hit with the wingstick!  It breaks apart as it lacerates " + monster.pronoun2 + ". (" + damage + ")");
				monster.HP -= damage;
				if (monster.HP < 0) monster.HP = 0;
			}
			if (monster.short == "lizan rogue") {
				outputText("You fling the wingstick with all your might and its aim is true. The moment it nears the lizan, though, he catches it with a flick of his wrist.  It appears he is too fast and well trained for normal projectile attacks.");
			}
		}
*/

		public function neonPinkEgg(pregnantChange:Boolean,player:Player):void
		{
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//If this is a pregnancy change, only 1 change per proc.
			if (pregnantChange) changeLimit = 1;
			else clearOutput();
			//If not pregnancy, mention eating it.
			if (!pregnantChange) outputText("You eat the neon pink egg, and to your delight it tastes sweet, like candy.  In seconds you've gobbled down the entire thing, and you lick your fingers clean before you realize you ate the shell – and it still tasted like candy.");
			//If pregnancy, warning!
			if (pregnantChange) {
				outputText("\n<b>Your egg-stuffed ");
				if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					outputText("womb ");
					if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("and ");
				}
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("backdoor ");
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY && player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("rumble");
				else outputText("rumbles");
				outputText(" oddly, and you have a hunch that something's about to change</b>.");
			}
			//STATS CHANGURYUUUUU
			//Boost speed (max 80!)
			if (changes < changeLimit && rand(3) == 0 && player.spe < 80) {
				if (player.spe < 30) outputText("\n\nTingles run through your muscles, and your next few movements seem unexpectedly fast.  The egg somehow made you faster!");
				else if (player.spe < 50) outputText("\n\nYou feel tingles running through your body, and after a moment, it's clear that you're getting faster.");
				else if (player.spe < 65) outputText("\n\nThe tight, ready feeling you've grown accustomed to seems to intensify, and you know in the back of your mind that you've become even faster.");
				else outputText("\n\nSomething changes in your physique, and you grunt, chopping an arm through the air experimentally.  You seem to move even faster than before, confirming your suspicions.");
				changes++;
				if (player.spe < 35) dynStats("spe", 1);
				dynStats("spe", 1);
			}
			//Boost libido
			if (changes < changeLimit && rand(5) == 0) {
				changes++;
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib < 30) dynStats("lib", 1);
				if (player.lib < 40) dynStats("lib", 1);
				if (player.lib < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) == 0)) {
						if (player.lib < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to squeeze it, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skinTone + " skin begins to flush red with heat");
					if (player.hasCoat()) outputText(" through your " + player.skinDesc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + sMultiCockDesc() + " as it strains against your [armor].  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your [asshole], demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + sMultiCockDesc() + " starts to strain against your [armor].  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			//BIG sensitivity gains to 60.
			if (player.sens < 60 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText("\n\n");
				//(low)
				if (rand(3) != 2) {
					outputText("The feeling of small breezes blowing over your [skin.type] gets a little bit stronger.  How strange.  You pinch yourself and nearly jump when it hurts a tad more than you'd think. You've gotten more sensitive!");
					dynStats("sen", 5);
				}
				//(BIG boost 1/3 chance)
				else {
					dynStats("sen", 15);
					outputText("Every movement of your body seems to bring heightened waves of sensation that make you woozy.  Your [armor] rubs your " + nippleDescript(0) + "s deliciously");
					if (player.hasFuckableNipples()) {
						outputText(", sticking to the ");
						if (player.biggestLactation() > 2) outputText("milk-leaking nipple-twats");
						else outputText("slippery nipple-twats");
					}
					else if (player.biggestLactation() > 2) outputText(", sliding over the milk-leaking teats with ease");
					else outputText(" catching on each of the hard nubs repeatedly");
					outputText(".  Meanwhile, your crotch... your crotch is filled with such heavenly sensations from ");
					if (player.gender == 1) {
						outputText(sMultiCockDesc() + " and your ");
						if (player.balls > 0) outputText(ballsDescriptLight());
						else outputText(assholeDescript());
					}
					else if (player.gender == 2) outputText("your [vagina] and " + clitDescript());
					else if (player.gender == 3) {
						outputText(sMultiCockDesc() + ", ");
						if (player.balls > 0) outputText(ballsDescriptLight() + ", ");
						outputText(vaginaDescript(0) + ", and " + clitDescript());
					}
					//oh god genderless
					else outputText("you " + assholeDescript());
					outputText(" that you have to stay stock-still to keep yourself from falling down and masturbating on the spot.  Thankfully the orgy of tactile bliss fades after a minute, but you still feel way more sensitive than your previous norm.  This will take some getting used to!");
				}
			}
			//Makes girls very girl(90), guys somewhat girly (61).
			if (changes < changeLimit && rand(2) == 0) {
				var buffer:String = "";
				if (player.gender < 2) buffer += player.modFem(61, 4);
				else buffer += player.modFem(90, 4);
				if (buffer != "") {
					outputText(buffer);
					changes++;
				}
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Shrink
			if (rand(3) == 0 && player.tallness > 72) {
				changes++;
				outputText("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!\n");
				player.tallness -= (1 + rand(5));
			}
			//De-wettification of cunt (down to 3?)!
			if (player.wetness() > 3 && changes < changeLimit && rand(3) == 0) {
				//Just to be safe
				if (player.hasVagina()) {
					outputText("\n\nThe constant flow of fluids that sluice from your [vagina] slow down, leaving you feeling a bit less like a sexual slip-'n-slide.");
					player.vaginas[0].vaginalWetness--;
					changes++;
				}
			}
			//Fertility boost!
			if (changes < changeLimit && rand(4) == 0 && player.fertility < 50 && player.hasVagina()) {
				player.fertility += 2 + rand(5);
				changes++;
				outputText("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you know your body is just aching to be pregnant and give birth.");
			}
			//-VAGs
			if (player.hasVagina() && player.findPerk(PerkLib.BunnyEggs) < 0 && changes < changeLimit && rand(4) == 0 && player.bunnyScore() > 3) {
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n\n");
				outputText("(<b>Perk Gained: Bunny Eggs</b>)");
				player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
				changes++;
			}
			//Shrink Balls!
			if (player.balls > 0 && player.ballSize > 5 && rand(3) == 0 && changes < changeLimit) {
				if (player.ballSize < 10) {
					outputText("\n\nRelief washes through your groin as your " + ballsDescript() + " lose about an inch of their diameter.");
					player.ballSize--;
				}
				else if (player.ballSize < 25) {
					outputText("\n\nRelief washes through your groin as your " + ballsDescript() + " lose a few inches of their diameter.  Wow, it feels so much easier to move!");
					player.ballSize -= (2 + rand(3));
				}
				else {
					outputText("\n\nRelief washes through your groin as your " + ballsDescript() + " lose at least six inches of diameter.  Wow, it feels SOOOO much easier to move!");
					player.ballSize -= (6 + rand(3));
				}
				changes++;
			}
			//Get rid of extra balls
			if (player.balls > 2 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText("\n\nThere's a tightening in your [sack] that only gets higher and higher until you're doubled over and wheezing.  When it passes, you reach down and discover that <b>two of your testicles are gone.</b>");
				player.balls -= 2;
			}
			//Boost cum production
			if ((player.balls > 0 || player.hasCock()) && player.cumQ() < 3000 && rand(3) == 0 && changeLimit > 1) {
				changes++;
				player.cumMultiplier += 3 + rand(7);
				if (player.cumQ() >= 250) dynStats("lus", 3);
				if (player.cumQ() >= 750) dynStats("lus", 4);
				if (player.cumQ() >= 2000) dynStats("lus", 5);
				//Balls
				if (player.balls > 0) {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your [balls], but quickly vanishes.  You heft your orbs but they haven't changed in size – they just feel a little bit denser.");
					//(medium cum quantity) < 250
					else if (player.cumQ() < 250) {
						outputText("\n\nA ripple of discomfort runs through your [balls], but it fades into a pleasant tingling.  You reach down to heft the orbs experimentally but they don't seem any larger.");
						if (player.hasCock()) outputText("  In the process, you brush " + sMultiCockDesc() + " and discover a bead of pre leaking at the tip.");
					}
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) {
						outputText("\n\nA strong contraction passes through your [sack], almost painful in its intensity.  ");
						if (player.hasCock()) outputText(SMultiCockDesc() + " leaks and dribbles pre-cum down your [legs] as your body's cum production kicks up even higher.");
						else outputText("You wince, feeling pent up and yet unable to release.  You really wish you had a cock right about now.");
					}
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) {
						outputText("\n\nAn orgasmic contraction wracks your [balls], shivering through the potent orbs and passing as quickly as it came.  ");
						if (player.hasCock()) outputText("A thick trail of slime leaks from " + sMultiCockDesc() + " down your [leg], pooling below you.");
						else outputText("You grunt, feeling terribly pent-up and needing to release.  Maybe you should get a penis to go with these balls...");
						outputText("  It's quite obvious that your cum production has gone up again.");
					}
					//(XXL cum quantity)
					else {
						outputText("\n\nA body-wrenching contraction thrums through your [balls], bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  ");
						if (player.hasCock()) outputText("pre-cum explodes from " + sMultiCockDesc() + ", running down your [leg] and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
						else outputText("You pant and groan but the pleasure just turns to pain.  You're so backed up – if only you had some way to vent all your seed!");
					}
				}
				//NO BALLZ (guaranteed cock tho)
				else {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your body, but passes before you have any chance to figure out exactly what it did.");
					//(Medium cum quantity) < 250)
					else if (player.cumQ() < 250) outputText("\n\nA ripple of discomfort runs through your body, but it fades into a pleasant tingling that rushes down to " + sMultiCockDesc() + ".  You reach down to heft yourself experimentally and smile when you see pre-beading from your maleness.  Your cum production has increased!");
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) outputText("\n\nA strong contraction passes through your body, almost painful in its intensity.  " + SMultiCockDesc() + " leaks and dribbles pre-cum down your [legs] as your body's cum production kicks up even higher!  Wow, it feels kind of... good.");
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) outputText("\n\nAn orgasmic contraction wracks your abdomen, shivering through your midsection and down towards your groin.  A thick trail of slime leaks from " + sMultiCockDesc() + "  and trails down your [leg], pooling below you.  It's quite obvious that your body is producing even more cum now.");
					//(XXL cum quantity)
					else outputText("\n\nA body-wrenching contraction thrums through your gut, bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  pre-cum explodes from " + sMultiCockDesc() + ", running down your [legs] and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
				}
			}
			//Bunny feet! - requirez earz
			if (player.lowerBody != LowerBody.BUNNY && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0 && player.ears.type == Ears.BUNNY) {
				//Taurs
				if (player.isTaur()) outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!");
				//Non-taurs
				else {
					outputText("\n\nNumbness envelops your [legs] as they pull tighter and tighter.  You overbalance and drop on your " + assDescript());
					if (player.tailType > Tail.NONE) outputText(", nearly smashing your tail flat");
					else outputText(" hard enough to sting");
					outputText(" while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs</b>!");
				}
				changes++;
				setLowerBody(LowerBody.BUNNY);
				player.legCount = 2;
			}
			//BUN FACE!  REQUIREZ EARZ
			if (player.ears.type == Ears.BUNNY && player.faceType != Face.BUNNY && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				changes++;
				//Human(ish) face
				if (player.faceType == Face.HUMAN || player.faceType == Face.SHARK_TEETH) outputText("You catch your nose twitching on its own at the bottom of your vision, but as soon as you focus on it, it stops.  A moment later, some of your teeth tingle and brush past your lips, exposing a white pair of buckteeth!  <b>Your face has taken on some rabbit-like characteristics!</b>");
				//Crazy furry TF shit
				else outputText("You grunt as your [face] twists and reforms.  Even your teeth ache as their positions are rearranged to match some new, undetermined order.  When the process finishes, <b>you're left with a perfectly human looking face, save for your constantly twitching nose and prominent buck-teeth.</b>");
				setFaceType(Face.BUNNY);
			}
			//DAH BUNBUN EARZ - requires poofbutt!
			if (player.ears.type != Ears.BUNNY && changes < changeLimit && rand(3) == 0 && player.tailType == Tail.RABBIT) {
				outputText("\n\nYour ears twitch and curl in on themselves, sliding around on the flesh of your head.  They grow warmer and warmer before they finally settle on the top of your head and unfurl into long, fluffy bunny-ears.  <b>You now have a pair of bunny ears.</b>");
				setEarType(Ears.BUNNY);
				changes++;
			}
			//DAH BUNBUNTAILZ
			if (player.tailType != Tail.RABBIT && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				if (player.tailType > Tail.NONE) outputText("\n\nYour tail burns as it shrinks, pulling tighter and tighter to your backside until it's the barest hint of a stub.  At once, white, poofy fur explodes out from it.  <b>You've got a white bunny-tail!  It even twitches when you aren't thinking about it.</b>");
				else outputText("\n\nA burning pressure builds at your spine before dissipating in a rush of relief. You reach back and discover a small, fleshy tail that's rapidly growing long, poofy fur.  <b>You have a rabbit tail!</b>");
				setTailType(Tail.RABBIT);
				changes++;
			}
			//Partial and full fur
			if (rand(3) == 0 && changes < changeLimit && !player.hasCoatOfType(Skin.FUR)) {
				humanizeSkin();
				if (player.coatColor == "") player.coatColor = player.hairColor;
				if (rand(2) == 0) {
					player.skin.growCoat(Skin.FUR,{color:player.skin.coat.color},Skin.COVERAGE_LOW);
					outputText("\n\nYou feel your skin tickle as fur grow in various place over your body. It doesn’t cover your skin entirely but sure feels nice and silky to the touch wherever it has grown. Funnily the fur patterns looks nice on you and only helps your animalistic charm. <b>Some area of your body are now partially covered with fur!</b>");
				}
				else {
					outputText("\n\nYour [skin.type] begins to tingle, then itch. ");
					player.skin.growCoat(Skin.FUR,{color:player.skin.coat.color},Skin.COVERAGE_COMPLETE);
					outputText("You reach down to scratch your arm absent-mindedly and pull your fingers away to find strands of [skin coat.color] fur. Wait, fur?  What just happened?! You spend a moment examining yourself and discover that <b>you are now covered in glossy, soft fur.</b>");
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//-Human arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(3) == 0) {
				humanizeArms();
				changes++;
			}
			//-Human face
			if (player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
				humanizeFace();
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(3) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//Bunny Breeder Perk?
			//FAILSAAAAFE
			if (changes == 0) {
				if (player.lib < 100) changes++;
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib < 30) dynStats("lib", 1);
				if (player.lib < 40) dynStats("lib", 1);
				if (player.lib < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) == 0)) {
						if (player.lib < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to have it squeezed, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skinTone + " skin begins to flush red with heat");
					if (player.hasCoat()) outputText(" through your " + player.skinDesc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + sMultiCockDesc() + " as it strains against your [armor].  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your [asshole], demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + sMultiCockDesc() + " starts to strain against your [armor].  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			player.refillHunger(20);
		}

		public function goldenSeed(type:Number,player:Player):void
		{
			//'type' refers to the variety of seed.
			//0 == standard.
			//1 == enhanced - increase change limit and no pre-reqs for TF
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (type == 1) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Generic eating text:
			clearOutput();
			outputText("You pop the nut into your mouth, chewing the delicious treat and swallowing it quickly.  No wonder harpies love these things so much!");
			//****************
			//Stats:
			//****************
			//-Speed increase to 100.
			if (player.spe < 100 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.spe >= 75) outputText("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else outputText("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				//Speed gains diminish as it rises.
				if (player.spe < 40) dynStats("spe", .5);
				if (player.spe < 75) dynStats("spe", .5);
				dynStats("spe", .5);
			}
			//-Toughness decrease to 50
			if (player.tou > 50 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (rand(2) == 0) outputText("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.");
				else outputText("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more harpy-like in structure?");
				dynStats("tou", -1);
			}
			//-Strength increase to 70
			if (player.str < 70 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//(low str)
				if (player.str < 40) outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
				//(hi str – 50+)
				else outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				//Faster until 40 str.
				if (player.str < 40) dynStats("str", .5);
				dynStats("str", .5);
			}
			//-Libido increase to 90
			if ((player.lib < 90 || rand(3) == 0) && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.lib < 90) dynStats("lib", 1);
				//(sub 40 lib)
				if (player.lib < 40) {
					outputText("\n\nA passing flush colors your [face] for a second as you daydream about sex. You blink it away, realizing the item seems to have affected your libido.");
					if (player.hasVagina()) outputText(" The moistness of your [vagina] seems to agree.");
					else if (player.hasCock()) outputText(" The hardness of " + sMultiCockDesc() + " seems to agree.");
					dynStats("lus", 5);
				}
				//(sub 75 lib)
				else if (player.lib < 75) outputText("\n\nHeat, blessed heat, works through you from head to groin, leaving you to shudder and fantasize about the sex you could be having right now.\n\n");
				//(hi lib)
				else if (player.lib < 90) outputText("\n\nSexual need courses through you, flushing your skin with a reddish hue while you pant and daydream of the wondrous sex you should be having right now.\n\n");
				//(90+)
				else outputText("\n\nYou groan, something about the seed rubbing your libido in just the right way to make you horny. Panting heavily, you sigh and fantasize about the sex you could be having.\n\n");
				//(fork to fantasy)
				if (player.lib >= 40) {
					dynStats("lus", (player.lib / 5 + 10));
					//(herm – either or!)
					//Cocks!
					if (player.hasCock() && (player.gender != 3 || rand(2) == 0)) {
						//(male 1)
						if (rand(2) == 0) {
							outputText("In your fantasy you're winging through the sky, " + sMultiCockDesc() + " already hard and drizzling with male moisture while you circle an attractive harpy's nest. Her plumage is as blue as the sky, her eyes the shining teal of the sea, and legs splayed in a way that shows you how ready she is to be bred. You fold your wings and dive, wind whipping through your [hair] as she grows larger and larger. With a hard, body-slapping impact you land on top of her, plunging your hard, ready maleness into her hungry box. ");
							if (player.cockTotal() > 1) {
								outputText("The extra penis");
								if (player.cockTotal() > 2) outputText("es rub ");
								else outputText("rubs ");
								outputText("the skin over her taut, empty belly, drooling your need atop her.  ");
								outputText("You jolt from the vision unexpectedly, finding your " + sMultiCockDesc() + " is as hard as it was in the dream. The inside of your [armor] is quite messy from all the pre-cum you've drooled. Perhaps you can find a harpy nearby to lie with.");
							}
						}
						//(male 2)
						else {
							outputText("In your fantasy you're lying back in the nest your harem built for you, stroking your dick and watching the sexy bird-girl spread her thighs to deposit another egg onto the pile. The lewd moans do nothing to sate your need, and you beckon for another submissive harpy to approach. She does, her thick thighs swaying to show her understanding of your needs. The bird-woman crawls into your lap, sinking down atop your shaft to snuggle it with her molten heat. She begins kissing you, smearing your mouth with her drugged lipstick until you release the first of many loads. You sigh, riding the bliss, secure in the knowledge that this 'wife' won't let up until she's gravid with another egg. Then it'll be her sister-wife's turn. The tightness of " + sMultiCockDesc() + " inside your [armor] rouses you from the dream, reminding you that you're just standing there, leaking your need into your gear.");
						}
					}
					//Cunts!
					else if (player.hasVagina()) {
						//(female 1)
						if (rand(2) == 0) {
							outputText("In your fantasy you're a happy harpy mother, your womb stretched by the sizable egg it contains. The surging hormones in your body arouse you again, and you turn to the father of your children, planting a wet kiss on his slobbering, lipstick-gilt cock. The poor adventurer writhes, hips pumping futilely in the air. He's been much more agreeable since you started keeping his cock coated with your kisses. You mount the needy boy, fantasizing about that first time when you found him near the portal, in the ruins of your old camp. The feeling of your stiff nipples ");
							if (player.hasFuckableNipples()) outputText("and pussy leaking over ");
							else if (player.biggestLactation() >= 1.5) outputText("dripping milk inside ");
							else outputText("rubbing inside ");
							outputText("your [armor] shocks you from the dream, leaving you with nothing but the moistness of your loins for company. Maybe next year you'll find the mate of your dreams?");
						}
						//(female 2)
						else {
							outputText("In your fantasy you're sprawled on your back, thick thighs splayed wide while you're taken by a virile male. The poor stud was wandering the desert all alone, following some map, but soon you had his bright red rod sliding between your butt-cheeks, the pointed tip releasing runnels of submission to lubricate your loins. You let him mount your pussy before you grabbed him with your powerful thighs and took off. He panicked at first, but the extra blood flow just made him bigger. He soon forgot his fear and focused on the primal needs of all males – mating with a gorgeous harpy. You look back at him and wink, feeling his knot build inside you. Your aching, tender " + nippleDescript(0) + "s pull you out of the fantasy as they rub inside your [armor]. Maybe once your quest is over you'll be able to find a shy, fertile male to mold into the perfect cum-pump.");
						}
					}
				}
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//antianemone corollary:
			if (changes < changeLimit && player.hairType == 4 && rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the seed, your head begins to feel heavier.  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels soft and fluffy, almost feathery; you watch as it dissolves into many thin, feathery strands.  <b>Your hair is now like that of a harpy!</b>");
				setHairType(Hair.FEATHER);
				changes++;
			}
			//****************
			//   Sexual:
			//****************
			//-Grow a cunt (guaranteed if no gender)
			if (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) == 0)) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your [cocks]. You pull your manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.clitLength = .25;
				dynStats("sen", 10);
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.breastRows.length >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && player.breastRows.length == 1 && rand(3) == 0 && player.breastRows[0].breastRating >= 7 && !flags[kFLAGS.HYPER_HAPPY])
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (player.breastRows[0].breastRating < 19)
				{
					player.shrinkTits();
				}
				//(H+)
				else {
					player.breastRows[0].breastRating -= (4 + rand(4));
					outputText("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + player.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && player.breastRows[0].breastRating < 2 && rand(3) == 0) {
				changes++;
				outputText("\n\nYour chest starts to tingle, the [skin.type] warming under your [armor]. Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (player.breastRows[0].breastRating < 1) outputText("  <b>You have breasts now!</b>");
				player.breastRows[0].breastRating = 2;
			}
			//Change cock if you have a penis.
			if (changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.AVIAN) < player.cockTotal() && rand(type == 1 ? 4 : 10) == 0 ) { //2.5x chance if magic seed.
				changes++;
				outputText("\n\nYou feel a strange tingling sensation in your cock as erection forms. You " + player.clothedOrNakedLower("open up your [armor] and", "") + " look down to see " + (player.cockTotal() == 1 ? "your cock" : "one of your cocks") + " shifting! By the time the transformation's complete, you notice it's tapered, red, and ends in a tip. When you're not aroused, your cock rests nicely in a newly-formed sheath. <b>You now have an avian penis!</b>");
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.AVIAN) {
						player.cocks[i].cockType = CockTypesEnum.AVIAN;
						break;
					}
				}
			}
			//****************
			//General Appearance:
			//****************
			//-Femininity to 85
			if (player.femininity < 85 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText(player.modFem(85, 3 + rand(5)));
			}
			//-Skin color change – tan, olive, dark, light
			if ((player.skinTone != "tan" && player.skinTone != "olive" && player.skinTone != "dark" && player.skinTone != "light") && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(5) == 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your " + player.coatColor + " " + player.skinDesc);
				else outputText("your " + player.skinDesc);
				outputText(" has changed to become ");
				switch (rand(4)) {
					case 0:
						player.skinTone = "tan";
						break;

					case 1:
						player.skinTone = "olive";
						break;

					case 2:
						player.skinTone = "dark";
						break;

					case 3:
						player.skinTone = "light";
						break;
				}
				outputText(player.skinTone + " colored.</b>");
			}
			//-Grow hips out if narrow.
			if (player.hips.type < 10 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hips.type++;
				changes++;
			}
			//-Narrow hips if crazy wide
			if (player.hips.type >= 15 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour gait shifts inward, your [hips] narrowing significantly. They remain quite thick, but they're not as absurdly wide as before.");
				player.hips.type--;
				changes++;
			}
			//-Big booty
			if (player.butt.type < 8 && changes < changeLimit && rand(3) == 0) {
				player.butt.type++;
				changes++;
				outputText("\n\nA slight jiggle works through your rear, but instead of stopping it starts again. You can actually feel your [armor] being filled out by the growing cheeks. When it stops, you find yourself the proud owner of a " + buttDescript() + ".");
			}
			//-Narrow booty if crazy huge.
			if (player.butt.type >= 14 && changes < changeLimit && rand(4) == 0) {
				changes++;
				player.butt.type--;
				outputText("\n\nA feeling of tightness starts in your " + buttDescript() + ", increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your massive booty is shrinking into a more manageable size.");
			}
			//-Body thickness to 25ish
			if (player.thickness > 25 && changes < changeLimit && rand(3) == 0) {
				outputText(player.modThickness(25, 3 + rand(4)));
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//****************
			//Harpy Appearance:
			//****************
			//-Harpy legs
			if (player.lowerBody != LowerBody.HARPY && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && (type == 1 || player.tailType == Tail.HARPY) && rand(4) == 0) {
				//(biped/taur)
				if (!player.isGoo()) outputText("\n\nYour [legs] creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your [feet] have changed.  ");
				//goo
				else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ");
				setLowerBody(LowerBody.HARPY);
				player.legCount = 2;
				changes++;
				//(cont)
				outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in [haircolor] feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>");
			}
			//-Feathery Tail
			if (player.tailType != Tail.HARPY && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && (type == 1 || player.wings.type == Wings.FEATHERED_LARGE) && rand(4) == 0) {
				//(tail)
				if (player.tailType > Tail.NONE) outputText("\n\nYour tail shortens, folding into the crack of your " + buttDescript() + " before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>");
				//(no tail)
				else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your [skin.type] in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>");
				setTailType(Tail.HARPY);
				changes++;
			}
			//-Propah Wings
			if (player.wings.type == Wings.NONE && changes < changeLimit && (type == 1 || player.arms.type == Arms.HARPY) && rand(4) == 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>");
				setWingType(Wings.FEATHERED_LARGE, "large, feathered");
				changes++;
			}
			//-Remove old wings
			if (player.wings.type != Wings.FEATHERED_LARGE && player.wings.type > Wings.NONE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				removeWings();
				changes++;
			}
			//-Feathery Arms
			if (!InCollection(player.arms.type, Arms.GARGOYLE, Arms.HARPY) && changes < changeLimit && (type == 1 || player.hairType == 1) && rand(4) == 0) {
				outputText("\n\nYou smile impishly as you lick the last bits of the nut from your teeth, but when you go to wipe your mouth, instead of the usual texture of your [skin.type] on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				setArmType(Arms.HARPY);
				changes++;
			}
			//-Feathery Hair
			if (player.hairType != 1 && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && (type == 1 || player.faceType == Face.HUMAN) && rand(4) == 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!");
				setHairType(Hair.FEATHER);
				changes++;
			}
			//-Human face
			if (player.faceType != Face.HUMAN && changes < changeLimit && (type == 1 || (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN)) && rand(4) == 0) {
				humanizeFace();
				changes++;
			}
			//-Gain human ears (keep elf ears)
			if ((player.ears.type != Ears.HUMAN && player.ears.type != Ears.ELFIN) && changes < changeLimit && rand(4) == 0) {
				humanizeEars();
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//SPECIAL:
			//Harpy Womb – All eggs are automatically upgraded to large, requires legs + tail to be harpy.
			if (player.findPerk(PerkLib.HarpyWomb) < 0 && player.lowerBody == LowerBody.HARPY && player.tailType == Tail.HARPY && rand(4) == 0 && changes < changeLimit) {
				player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
				outputText("\n\nThere's a rumbling in your womb, signifying that some strange change has taken place in your most feminine area. No doubt something in it has changed to be more like a harpy. (<b>You've gained the Harpy Womb perk! All the eggs you lay will always be large so long as you have harpy legs and a harpy tail.</b>)");
				changes++;
			}
			if (changes < changeLimit && rand(4) == 0 && ((player.ass.analWetness > 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) || player.ass.analWetness > 1)) {
				outputText("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				player.ass.analWetness--;
				if (player.ass.analLooseness > 1) player.ass.analLooseness--;
				changes++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && (player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes == 0) outputText("\n\nAside from being a tasty treat, it doesn't seem to do anything to you this time.");
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function skybornSeed(type:Number,player:Player):void
		{
			//'type' refers to the variety of seed.
			//0 == Avian TF
			//1 == Gryphon TF
			//2 == Peacock TF
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Generic eating text:
			clearOutput();
			if (type == 0) outputText("You crack open the seed easily, and eat the fruit inside. A bit dry, as you expected, but with a sweet and aromatic taste that leaves you wanting another one.");
			if (type == 1) outputText("Looking again at the fierce gryphon sculpted on brass and bronze that you found on that strange alcove, your curiosity gets the best of you, and you start examining it. As you do so, the magic stored long ago within the artifact pours out, and starts changing your body!");
			if (type == 2) outputText("Looking again at the wonderful peacock carved in alabaster and ruby that you found on that strange alcove, your curiosity gets the best of you, and you start examining it. As you do so, the magic stored long ago within the artifact pours out, and starts changing your body!");
			//Stats changes
			//-Speed increase to 100.
			if (player.spe < 100 && type == 0 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.spe >= 75) outputText("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else outputText("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				//Speed gains diminish as it rises.
				if (player.spe < 40) dynStats("spe", .5);
				if (player.spe < 75) dynStats("spe", .5);
				dynStats("spe", .5);
			}
			//-Toughness decrease to 50
			if (player.tou > 50 && type == 0 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (rand(2) == 0) outputText("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.");
				else outputText("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more avian-like in structure?");
				dynStats("tou", -1);
			}
			//-Strength increase to 70
			if (player.str < 70 && type == 0 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//(low str)
				if (player.str < 40) outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
				//(hi str – 50+)
				else outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				//Faster until 40 str.
				if (player.str < 40) dynStats("str", .5);
				dynStats("str", .5);
			}
			if (type == 1 || type == 2) changeLimit = 1;
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual changes
			if (player.avianCocks() == 0 && player.cockTotal() > 0 && changes < changeLimit && type == 0 && rand(3) == 0) {
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					if (player.cocks[temp2].cockType != CockTypesEnum.AVIAN) break;
				}
				outputText("\n\nA warm tingling on your nethers makes you check down if the transformative had an effect on your genitals. Giving them a thorough check, you notice that, effectively, your " + cockDescript(temp2) + " has changed.");
				outputText("\n\nIt has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>");
				player.cocks[temp2].cockType = CockTypesEnum.AVIAN;
				changes++;
			}
			if (player.cockTotal() > 1 && player.avianCocks() > 0 && player.cockTotal() > player.avianCocks() && type == 0 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA warm tingling on your nethers makes you check down if the transformative had an effect on your genitals. Giving them a thorough check, you notice that, effectively, your " + cockDescript(temp2) + " has changed.");
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					if (player.cocks[temp2].cockType != CockTypesEnum.AVIAN) break;
				}
				outputText("\n\nIt has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>");
				player.cocks[temp2].cockType = CockTypesEnum.AVIAN;
				changes++;
			}
			if (player.gryphonCocks() == 0 && player.cockTotal() > 0 && changes < changeLimit && type == 1 && rand(3) == 0) {
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					if (player.cocks[temp2].cockType != CockTypesEnum.GRYPHON) break;
				}
				outputText("\n\nThe magic of the statue feels more focused now, as it were to change a small but specific area of your body, and it does, as your nethers tinge under its effect.\n\nGiving them a glimpse, the first thing that becomes obvious if that your " + cockDescript(temp2) + " became a bit ticker, but albeit it retained it’s avian, tapered shape, it’s slightly wavy form became more straight. ");
				outputText("It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how’ they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.");
				player.cocks[temp2].cockType = CockTypesEnum.GRYPHON;
				changes++;
			}
			if (player.cockTotal() > 1 && player.gryphonCocks() > 0 && player.cockTotal() > player.gryphonCocks() && type == 1 && rand(3) == 0 && changes < changeLimit) {
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					if (player.cocks[temp2].cockType != CockTypesEnum.GRYPHON) break;
				}
				outputText("\n\nThe magic of the statue feels more focused now, as it were to change a small but specific area of your body, and it does, as your nethers tinge under its effect.\n\nGiving them a glimpse, the first thing that becomes obvious if that your " + cockDescript(temp2) + " became a bit ticker, but albeit it retained it’s avian, tapered shape, it’s slightly wavy form became more straight. ");
				outputText("It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how’ they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.");
				player.cocks[temp2].cockType = CockTypesEnum.GRYPHON;
				changes++;
			}
			//Legs
			if (player.lowerBody != LowerBody.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				if (player.isGoo()) {
					outputText("\n\nTrying to advance, you see your goo pseudopod stuck on the ground. Reaching around to look for the cause, you’re surprised to find the goo solidifying, turning into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.");
					outputText("\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.isTaur()) {
					outputText("\n\nAn strange sensation overcomes your front legs, and even before you realize it, you found them receding on your body! Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.");
					outputText("\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.isNaga()) {
					outputText("\n\nYour tail splits in two, and eventually reshapes into the more familiar form of two legs. These are far different from the ones that you expected, however; instead of the usual human legs, these have an array of small, shiny golden scales from the knee down, with " + player.skin.coat.color + "-colored feathers taking over the area between your knees and crotch, looking not unlike a bird’s.");
					outputText("\n\nYour toes are unusually shaped, too; four of them are in the front, and one of them is on the back of each foot. The toenails have become sharp, menacing talons, best used for snatching prey and the occasional unwilling partner. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.isScylla()) {
					outputText("\n\nAn strange sensation overcomes your " + player.legCount + " tentacles, and even before you realize it, you found that " + (player.legCount - 2) + " of them are receding on your body! Not only that, the ones that remain normal are reshaping themselves into something resembling more an average set of legs. Standing against a rock to not fall at this change to a more bipedal posture, you contemplate how your spine rearranges itself, and soon, you’re left with the usual set of two legs and a standing spine.");
					outputText("\n\nBut the changes continue, as your rearranged pair of feet feel strangely tired, so you sit down and let them rest, noticing that you’ve now a set of human-looking feet. They don’t last that way long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.isAlraune()) {
					outputText("\n\nTrying to advance, you see your floral appendage stuck on the ground. Reaching around to look for the cause, you’re surprised to find the verdant foliage decaying, leaving behind mellified shapes that turn quickly into flesh and skin before your eyes.Bones occupy their places on your new legs and feet, and the excess goo evaporates, leaving you with a duo of fully functional, normal legs.");
					outputText("\n\nBut, the changes continue as your rearranged pair of feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.lowerBody == LowerBody.HOOFED) {
					outputText("\n\nYour feet feel strangely tired, so you sit down and let them rest.  As you shift your attention to them, you realize that they are changing. Before your eyes, your hooves seem to recede, turning back into regular human feet. They don’t last long, though, as your toes reshape again, four of them remaining in the the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage, while the skin below your knees grows an array of small, shiny golden scales. Looks like <b>you have a new set of avian legs!</b>");
				}
				else if (player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS) {
					outputText("\n\nYour feet feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The skin below your knees grows an array of small, shiny golden scales and your demonic high-heels recede into your body. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers sprouting all over the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>");
				}
				else {
					outputText("\n\nYour [feet] feel strangely tired, so you sit down and let them rest. As you shift your attention to them, you realize that they are changing. The fur on them below your knees falls off, but is quickly replaced by an array of small, shiny golden scales. Your toes reshape, four of them remaining in the front and one of them going to the back of each foot. Your toenails lengthen, turning into sharp, menacing talons, best used for snatching prey and the occasional unwilling partner.");
					outputText("\n\nThe rest of your legs change too, " + player.skin.coat.color + "-colored feathers taking over the fur covering the area between your knees and crotch, giving them a more avian visage. Looks like <b>you have a new set of avian legs!</b>");
				}
				setLowerBody(LowerBody.AVIAN);
				player.legCount = 2;
				changes++;
			}
			if (player.lowerBody != LowerBody.GRYPHON && player.eyes.type == Eyes.GRYPHON && changes < changeLimit && type == 1 && rand(3) == 0) {
				outputText("\n\nTaking a seat while you see how the magic within the statue affects you, a familiar numbness reaches your legs. The rough skin covering your lower legs and feet change into more usual, soft skin, and shortly after, it starts sprouting " + player.skin.coat.color2 + " colored fur over them.");
				outputText("\n\nYour feet themselves reshape, losing their avian stance and gaining one much more feline, complete with soft pink paw pads. The talons at the end of each toe become retractile feline claws. Albeit walking with those seems initially tricky, you easily gain a hold on how using your <b>new gryphon-like legs.</b>");
				setLowerBody(LowerBody.GRYPHON);
				player.legCount = 2;
				changes++;
			}
			//Tail
			if (player.tailType != Tail.AVIAN && player.lowerBody == LowerBody.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				if (player.tailType > Tail.NONE) {
					if (player.tailCount > 1) {
						outputText("\n\nThe nutty fruit after effects show again, this time as an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tails, as they tense and twitch, so you look back to examine what’s happening to them.");
						outputText("\n\nWhen you lay your eyes on them, the first thing that you notice if that is they’re entwining in a mess of curls and knots, the flesh on them merging until you have a single one. Then, the lone tail left starts shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.");
					}
					else {
						outputText("\n\nThe nutty fruit after effects show again, this time as an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tail, as it tenses and twitches, so you look back to examine what’s happening.");
						outputText("\n\nWhen you lay your eyes on it, the first thing that you notice if that is shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.");
					}
				}
				else {
					outputText("\n\nThe nutty fruit after effects show again, this time as an odd itch down your spine. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something sprouts just above your butt and you take of your lower clothing so you can examine it.");
					outputText("\n\nWhen you lay your eyes on it, you notice a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, " + player.skin.coat.color + " colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.");
				}
				outputText(" <b>In any case, you have now a full, fan-shaped avian tail above your " + buttDescript() + "!</b>");
				setTailType(Tail.AVIAN);
				changes++;
			}
			if (player.tailType != Tail.GRIFFIN && player.lowerBody == LowerBody.GRYPHON && changes < changeLimit && type == 1 && rand(3) == 0) {
				outputText("\n\nThe fan of feathers at your backside reacts under the statue magic effects. An otherworldly magic envelopes it, making the feathers twist and converge in an odd fashion, at the same time that the small bump of your tail elongates until becoming long enough to reach far past your knee.");
				outputText("\n\nBefore you notice it, the long feathers have merged into a tuft of " + player.skin.coat.color + " at the end of your now long tail, while the short, downy ones now cover every inch of bare skin that the elongated appendage now have. <b>Well, seems like you gained a griffin-like tail!</b> It’s quite leonine in shape, but its appearance remains a bit avian.");
				setTailType(Tail.GRIFFIN);
				changes++;
			}
			//Arms
			if (player.arms.type != Arms.AVIAN && player.tailType == Tail.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				if (player.skin.hasChitin()) {
					outputText("\n\nUghh, was that seed good for your body? You wince in pain, as some part of you is obviously not happy of being subjected to the fruit mysterious properties. As you direct your attention to your arms, you’re alarmed by their increasingly rigid feeling, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.");
					outputText("\n\nJust when you thought that nothing could feel worse, you see how the chitin on your arms fissures, falling to the ground like pieces of a broken vase and leaving a mellified tissue beneath. To you relief, the ‘jelly’ also fall, leaving only normal skin on your arms.");
					outputText("\n\nThen, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, tough your fingernails turn into short talons.");
				}
				else if (player.hasFur()) {
					outputText("\n\nA bit weary about the possible effects of the seed on your body, you quickly notice when the fur covering your starts thickening, some patches merging an thickening, first forming barbs, and then straight-out feathers. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.");
					outputText("\n\nThe newly formed feathers keep growing making the excess fur fall, until you’ve gained a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. Once the effects on that area end, the fur over your hands changes too, falling quickly and leaving behind soft, bare skin, that quickly turns into a layer of [skin], skin, ");
					outputText("albeit rougher than the usual, made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.");
				}
				else if (player.hasScales()) {
					outputText("\n\nUndoubtedly affected by the dry fruit reactives, the layer of scales covering your arms falls like snowflakes, leaving only a soft layer of [skin] behind. To your surprise, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.");
					outputText("\n\nThen, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.");
				}
				else {
					outputText("\n\nJust after finishing the fruit, your hand and forearms become strangely numb, and, to make things worse, the process continues, as the worrying sensation creeps up your arms until it reaches your shoulders. Soon, no matter how much you try, you aren’t able to move your arms in any way.");
					outputText("\n\nThen, a cloak of soft, " + player.skin.coat.color + ", colored feathers start sprouting from your armpits, covering every bare inch of skin up your elbows, stopping a few inches before your hands. When the growing stops, the skin over your hands changes too, turning into a layer of [skin], skin, albeit rougher than the usual, and made of thousands of diminutive scales. The structure of your palm and fingers remain the same, though your fingernails turn into short talons.");
				}
				outputText("\n\nLuckily, the sensation returns to your arms, and you’re able to use them with normalcy, with the difference that <b>they’re now avian looking ones!</b>.");
				setArmType(Arms.AVIAN);
				changes++;
			}
			if (player.arms.type != Arms.GRYPHON && changes < changeLimit && type == 1 && rand(3) == 0) {
				outputText("\n\nThe skin on your arms change a bit, as the " + player.skin.coat.color2 + " turning into soft, feline fur. Your palms and fingers acquire pink paw pads, while at the end of each one of your fingers, the talons sharpen and become prehensile, adopting a posture better suited to pounce over a unsuspecting victim.");
				outputText("\n\nFrom the fringe on your elbows to your armpits, your " + player.skin.coat.color + " colored plumage remains the same. <b>At the end, you’ve gotten gryphon-like arms!</b>.");
				setArmType(Arms.GRYPHON);
				changes++;
			}
			//Wings
			if (player.wings.type != Wings.FEATHERED_AVIAN && player.arms.type == Arms.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.DRACONIC_HUGE || player.wings.type == Wings.BAT_LIKE_TINY || player.wings.type == Wings.BAT_LIKE_LARGE || player.wings.type == Wings.BAT_LIKE_LARGE_2 || player.wings.type == Wings.BAT_ARM || player.wings.type == Wings.VAMPIRE) {
					outputText("\n\nYour wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the scales covering them are falling!");
					outputText("\n\nA bit alarmed, you’re surprised when, not much later, feathers started sprouting everywhere on them. t all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.");
					outputText("\n\n<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>");
				}
				else if (player.wings.type > Wings.NONE) {
					outputText("\n\nYour wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the delicate tissue of them is becoming skin and flesh, with bones sprouting inside and placing themselves to support the added weight.");
					outputText("\n\nOnce the muscles and bones are correctly formed, feathers start sprouting everywhere on them. Not all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.");
					outputText("\n\n<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>");
				}
				else {
					outputText("\n\nA sudden ache overcomes your back, when you’re at the middle of your daily routine. Knowing from before how hazardous is the food found on the wilds of Mareth, you curse the strange seed that you’ve just eat for this painful state.");
					outputText("\n\nBefore you can find something to soothe the pain, a piercing sensation of something tearing its way of of your flesh and skin makes you lose the balance and fall. Instinctively, you take off the upper part of your [armor] so anything that it’s growing from back there makes they way out without any trouble.");
					outputText("\n\nWhen everything finishes, you take a look at your backside, noticing two shapes sprouting from your upper back. They grow and grow, and when you recognize them as wings, they’ve already grown to carry with your body ease through the skies. Once the growth stops, you extend them and flex your newly gained bones and muscles. <b>Seems like you’ve gained a pair of avian wings!</b>");
				}
				setWingType(Wings.FEATHERED_AVIAN, "large, feathered");
				changes++;
			}
			if (player.wings.type != Wings.FEATHERED_AVIAN && player.wings.type != Wings.NONE && changes < changeLimit && rand(3) == 0) {
				removeWings();
				changes++;
			}
			//Hair
			if (player.hairType != 1 && player.hairLength > 0 && changes < changeLimit && type == 0 && rand(3) == 0) {
				setHairType(Hair.FEATHER);
				outputText("\n\nWhile you’re yet processing the taste of that odd seed, you suddenly start feeling an annoying itching coming from your scalp, without a doubt a change brought by the transformative nature of the seed.");
				outputText("\n\nThe base of each one of your hairs thicken noticeably, and from every one of them, small hairy filament start sprouting of each side. Soon you realize that your hairs are becoming feathers, and in a question of minute, <b>you’re left with a mane of [hair]!</b>");
				changes++;
			}
			//Face
			if (player.faceType != Face.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				if (player.faceType == Face.HUMAN) {
					outputText("\n\nWith the nutty flavor of the fruit still lingering, you gasp as your face feels weird and tingling, and aware of the transformative nature of the food on this strange land, you quickly associate it with the strange fruit that you’ve just eaten. Your mouth and nose feels numb, and you’re left a bit confused, dizzy even, so your sit until your head clears. As you do so, several feathers start sprouting on your head, those ones small and downy, and cover every bit of skin.");
					outputText("\n\nToo busy giving attention to this, you don’t notice when something big and hard suddenly obscures your vision. Sensing it with your hands, you feel it attached to your face. Rushing to the nearest pool of water, you look up your reflection, only to realize that you have a full avian, face, covered in feathers and complete with a hooked beak.");
					outputText("\n\nA bit worried about the new…implications of this on your sexual life, you test the borders on your beak, fearing it sharp and dangerous, only to happily discover that it's not sharpened in any way, only not as soft as an usual set of lips. If you wanted to damage someone with it, you’ll had to apply pressure, not unlike on an usual set of tooth. Even with that, kisses would be…interesting from now on, to say the least.");
					outputText("\n\nThis isn’t the only major change, as you feel your ears twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always. <b>Anyways, after a lot of changes, you’re left with an avian head!</b>");
				}
				else {
					outputText("\n\nWith the nutty flavor of the fruit still lingering, you gasp as your face feels weird and tingling, and aware of the transformative nature of the food on this strange land, you quickly associate it with the strange fruit that you’ve just eaten. Your [face] feels numb, and you’re left a bit confused, dizzy even, so your sit until your head clears. As you do so, several feathers start sprouting on your head, those ones small and downy, and cover every bit of skin.");
					outputText("\n\nToo busy giving attention to this, you don’t notice when something big and hard suddenly obscures your vision. Sensing it with your hands, you feel it attached to your face. Rushing to the nearest pool of water, you look up your reflection, only to realize that you have a full avian, face, covered in feathers and complete with a hooked beak. That's quite the change, even for your [face].");
					outputText("\n\nA bit worried about the new…implications of this on your sexual life, you test the borders on your beak, fearing it sharp and dangerous, only to happily discover that it's not sharpened in any way, only not as soft as an usual set of lips. If you wanted to damage someone with it, you’ll had to apply pressure, not unlike of an usual set of tooth. Even with that, kisses would be…interesting from now on, to say the least.");
					outputText("\n\nThis isn’t the only major change, as you feel your [ears] twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always. <b>Anyways, after a lot of changes, you’re left with an avian head!</b>");
				}
				setFaceType(Face.AVIAN);
				changes++;
			}
			//Ears
			if (player.ears.type != Ears.AVIAN && changes < changeLimit && type == 0 && rand(3) == 0) {
				outputText("\n\nYou feel your ears twitching, and before you can realize, they recede on your body, leaving behind two holes, almost completely hidden by feathers and your [hair]. Fearing that most of your hearing range and ability was damaged or is blocked by the feathers, you test the sounds around your, and breathe on relief at the realization that your hearing is as good as always.");
				setEarType(Ears.AVIAN);
				changes++;
			}
			if (player.ears.type != Ears.GRYPHON && player.tailType == Tail.GRIFFIN && changes < changeLimit && type == 1 && rand(3) == 0) {
				outputText("\n\nAfter another session under the statue magic, the lingering effects seem to having taken a toll on you, as your ears buzz. The sound turns worse for a second, and then vanish. You hear for a second a light flapping sound, and then, nothing.\n\nWhen everything seems to have finished, you realize that your hearing range has changed, and while your overall sense of hearing remains the same, pinpointing the source of a sounds is much easier. On a nearby reflection you discover the reason: ");
				outputText("two triangular ears have sprouted at your head, streamlined to flight and with a gryphon like appearance. A short layer of downy feathers covers them, the tip having a distinctive tuft. Checking that your ears are rightly placed on the new auricles, <b>you smile happily at the sight of your gryphon ears,</b> noting how well they compliment your looks.");
				setEarType(Ears.GRYPHON);
				changes++;
			}
			//Skin
			if (!player.hasFeather() && changes < changeLimit && type == 0 && rand(4) == 0) {
				if (player.hasFur()) {
					outputText("\n\nAfter having gulp down the seed, your coat of " + player.skin.coat.color + " fur tingles unpleasantly, so you begin to scratch it, hoping to remove the itch as soon as possible. Despite your futile attempts, the itch only gets worse.");
					outputText("\n\nA particularly strong itch diverts your attention to your left arm. The fur on seems to be falling off, except for a few tufts that start joining together. The same process begins happening all over your body, leaving your thoroughly confused.The hairs that formed into tufts slowly combine and elongate, and you’re left with thousands of quills covering your body.");
					outputText("\n\nShortly after, barbs begin sprouting from the sides of the quills. You realize that each one of the quills formed from the remains of your fur is turning into a brand new feather!");
					outputText("\n\nAs you ponder this, the barbs finish growing. The feathers on your chest, face, belly, and other soft spots are fluffy and short, like a kind of down feathers. They all gain color, turning into a warm coat of " + player.skin.coat.color + " colored feathers. <b>Looks like you’re about ready to take flight with your new coat of feathers!</b>");
				}
				else if (player.hasScales()) {
					outputText("\n\nAfter having gulp down the seed, the scales covering your body feel weird for a second, almost like they’re moving on their own, and that is when you realize that they’re changing! The feeling is quite odd, as an slight itch from the place where they join your skin that quickly becomes more intense as their transformation advances.");
					outputText("\n\nThey elongate until they become thin and light, and soon enough you realize that they’re becoming feathers as more and more barbs start sprouting from their sides. In a couple of minutes, most of your body is left covered in " + player.skin.coat.color + " feathers.");
					outputText("\n\nNot all of them became long, though. The feathers on your chest and belly, and...other soft spots, became fluffy and short instead of like the feathers on your arms and legs, like some kind of down feathers. <b>Seems like you’re covered from head to toe in a feathered coat!</b>");
				}
				else {
					if (player.hasChitin()) {
						outputText("\n\nA sudden crack over your chitin-covered body scares you, fearing that the fruit could’ve had noxious effects on your body. The effect only worsened as all the chiting covering your skin starts falling like pieces of broken glass, leaving behind a thick layer of mellified tissue.");
						outputText("\n\nThe jelly falls to the ground too, in a gross, sticky, orange rain, but to your relief, it leaves behind " + player.skin.base.color + " colored, healthy, normal skin, with no trace of your former chitin remaining on your body.");
					}
					else if (player.hasGooSkin()) {
						outputText("\n\nYour usually wet and gooey skin feels suddenly a bit dry. Thinking that maybe the reason could be the dry weather on the wastelands, you rush to the stream, washing your skin on the refreshing water.");
						outputText("\n\nThat has the opposite effect, as you realize that a layer of " + player.skin.base.color + " colored goop of goo falls from your arm. Alarmed, you try to put it back, to no avail. Soon all the goo on your arm falls, leaving behind a layer of healthy, normal, [skin] behind. ");
						outputText("The process follows the rest of your body, and before you can call it, the goo is cleansed from your body, and your skin returns to the normalcy, as your body, normal flesh taking again over the goo, as your core is expelled from your now perfectly solid body, now covered by the usual layer of skin.");
					}
					else if (player.skinAdj == "rubber" || player.skinAdj == "latex") {
						outputText("\n\nYour usually oily and rubberish skins feels suddenly a bit dry. Thinking that maybe the reason could be the dry weather on the wastelands, you rush to the stream, washing your skin on the refreshing water.");
						outputText("\n\nThat has the opposite effect, as you realize that a layer of " + player.skin.base.color + " colored goop of rubber falls from your arm. Soon all the rubber on your arm falls, leaving behind a layer of healthy, normal, [skin] behind. The process follows the rest of your body, and before you can call it, the rubber is cleansed from your body, and your skin returns to the normalcy.");
					}
					outputText("\n\nAfter having gulp down the seed, you start to scratch your [skin], as an uncomfortable itching overcomes you. It’s quite annoying, like being bitten by a bug, only in many spots at the same time.");
					outputText("\n\nSooner than later, you realize that the sensation is coming from <i>under</i> your skin. After rubbing one of your arms, feeling annoyed, you feel something different. When you lay your eyes on your skin, you realize that a long hair is growing out of it. No, that’s not a hair; it’s far harder than a hair should be, and too thick to be one either. Besides, its creamy-white color doesn’t match your hair.");
					outputText("\n\nA bit alarmed at this, you then realize that many like it are coming from your skin, finding its way up, gently enough to not harm the soft tissues around them. In the end, you’re left with thousands of those long and thin thing protruding from your body.");
					outputText("\n\nShortly after, what seems to be barbs start sprouting from its sides, and they branch on smaller barbs. Then you realize that each one of the things that emerged from your skin is a brand new feather!");
					outputText("\n\nAs you ponder this, the barbs have finished growing, and the new feather on your arms, legs back and shoulder elongate a bit, while the ones on your chest, face and belly, and...another soft spots, instead of becoming like the usual feather,  becomes fluffy and short, as a kind of down feathers. They all gain color, turning into a warm coat of " + player.skin.coat.color + " colored feathers. <b>Looks like you’re about ready to take flight with your new coat of feathers!</b>");
				}
				player.skin.growCoat(Skin.FEATHER,{color:player.skin.coat.color});
				changes++;
			}
			//Eyes
			if (player.eyes.type != Eyes.GRYPHON && player.arms.type == Arms.GRYPHON && changes < changeLimit && type == 1 && rand(3) == 0) {
				outputText("\n\nThe mysterious energy coming from the statue continues adapting your body into a more fierce, strong shape. This time, it has affected you eyesight, as you suddenly notice how the long distances that you once had trouble seeing are clear as if you were in front of them, and that you can perceive even the minimal move even from several miles afar.");
				outputText("\n\nChecking your changes on the river, you see clearly how your sclera has acquired a golden-orange coloration, as well as your outer iris, separated from the former by a thin circle of black. Both your pupil and your inner iris, which now has enlarged, are solid black. <b>Now you’ll have a blessed vision due those raptor, gryphon-like eyes.</b>");
				setEyeTypeAndColor(Eyes.GRYPHON, "golden-orange");
				changes++;
			}
			if (changes == 0 && type == 0) outputText("\n\nIt seems like the fruit had no effect this time. Maybe it was spoiled, or kept in storage for too much time?");
			if (type == 0) player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		/*
		 General Effects:
		 -Speed to 70
		 -Int to 10

		 Appearance Effects:
		 -Hip widening funtimes
		 -Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
		 -Remove feathery hair (copy for equinum, canine peppers, Labova)

		 Sexual:
		 -Shrink balls down to reasonable size (3?)
		 -Shorten clits to reasonable size
		 -Shrink dicks down to 8\" max.
		 -Rut/heat

		 Big Roo Tfs:
		 -Roo ears
		 -Roo tail
		 -Roo footsies
		 -Fur
		 -Roo face*/
		public function kangaFruit(type:Number,player:Player):void
		{
			clearOutput();
			outputText("You squeeze the pod around the middle, forcing the end open.  Scooping out a handful of the yeasty-smelling seeds, you shovel them in your mouth.  Blech!  Tastes like soggy burnt bread... and yet, you find yourself going for another handful...");
			//Used to track changes and the max
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (type == 1) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Used as a holding variable for biggest dicks and the like
			var biggestCock:Number;
			//****************
			//General Effects:
			//****************
			//-Int less than 10
			if (player.inte < 10 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				if (player.inte < 8 && player.kangaScore() >= 5) {
					outputText("\n\nWhile you gnaw on the fibrous fruit, your already vacant mind continues to empty, leaving nothing behind but the motion of your jaw as you slowly chew and swallow your favorite food.  Swallow.  Chew.  Swallow.  You don't even notice your posture worsening or your arms shortening.  Without a single thought, you start to hunch over but keep munching on the food in your paws as if were the most normal thing in the world.  Teeth sink into one of your fingers, leaving you to yelp in pain.  With the last of your senses, you look at your throbbing paw to notice you've run out of kanga fruit!");
					outputText("\n\nStill hungry and licking your lips in anticipation, you sniff in deep lungfuls of air.  There's more of that wonderful fruit nearby!  You bound off in search of it on your incredibly muscular legs, their shape becoming more and more feral with every hop.  Now guided completely by instinct, you find a few stalks that grow from the ground.  Your belly rumbles, reminding you of your hunger, as you begin to dig into the kanga fruits...");
					outputText("\n\nLosing more of what little remains of yourself, your body is now entirely that of a feral kangaroo and your mind has devolved to match it.  After you finish the handful of fruits you found, you move on in search for more of the tasty treats.  Though you pass by your camp later on, there's no memory, no recognition, just a slight feeling of comfort and familiarity.  There's no food here so you hop away.");
					//[GAME OVER]
					EventParser.gameOver();
					return;
				}
				outputText("\n\nWhile chewing, your mind becomes more and more tranquil.  You find it hard to even remember your mission, let alone your name.  <b>Maybe more kanga fruits will help?</b>");
			}
			//-Speed to 70
			if (player.spe < 70 && rand(3) == 0) {
				//2 points up if below 40!
				if (player.spe < 40) dynStats("spe", 1);
				dynStats("spe", 1);
				outputText("\n\nYour legs fill with energy as you eat the kanga fruit.  You feel like you could set a long-jump record!  You give a few experimental bounds, both standing and running, with your newfound vigor.  Your stride seems longer too; you even catch a bit of air as you push off with every powerful step.");
				changes++;
			}
			//-Int to 10
			if (player.inte > 2 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//Gain dumb (smart!)
				if (player.inte > 30) outputText("\n\nYou feel... antsy. You momentarily forget your other concerns as you look around you, trying to decide which direction you'd be most likely to find more food in.  You're about to set out on the search when your mind refocuses and you realize you already have some stored at camp.");
				//gain dumb (30-10 int):
				else if (player.inte > 10) outputText("\n\nYour mind wanders as you eat; you think of what it would be like to run forever, bounding across the wastes of Mareth in the simple joy of movement.  You bring the kanga fruit to your mouth one last time, only to realize there's nothing edible left on it.  The thought brings you back to yourself with a start.");
				//gain dumb (10-1 int):
				else outputText("\n\nYou lose track of everything as you eat, staring at the bugs crawling across the ground.  After a while you notice the dull taste of saliva in your mouth and realize you've been sitting there, chewing the same mouthful for five minutes.  You vacantly swallow and take another bite, then go back to staring at the ground.  Was there anything else to do today?");
				dynStats("int", -1);
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//****************
			//Appearance Effects:
			//****************
			//-Hip widening funtimes
			if (changes < changeLimit && rand(4) == 0 && player.hips.type < 40) {
				outputText("\n\nYou weeble and wobble as your hipbones broaden noticeably, but somehow you don't fall down.  Actually, you feel a bit MORE stable on your new widened stance, if anything.");
				player.hips.type++;
				changes++;
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(4) == 0) {
				humanizeArms();
				changes++;
			}
			//-Remove feathery/quill hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) && rand(3) == 0) {
				var word1:String;
				if (player.hairType == Hair.FEATHER) word1 = "feather";
				else word1 = "quill";
				if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft " + word1 + "-hair droops over your eye.  Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				else outputText("\n\nYou run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your " + word1 + "s.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//-Remove leaf hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && player.hairType == 7 && rand(4) == 0) {
				//(long):
				if (player.hairLength >= 6) outputText("\n\nA lock of your leaf-hair droops over your eye.  Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair.  <b>Your hair is no longer leaf-like!</b>");
				//(short)
				else outputText("\n\nYou run your fingers through your leaf-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your leafs.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer leaf-like!</b>");
				changes++;
				setHairType(Hair.NORMAL);
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//****************
			//Sexual:
			//****************
			//-Shrink balls down to reasonable size (3?)
			if (player.ballSize >= 4 && changes < changeLimit && rand(2) == 0) {
				player.ballSize--;
				player.cumMultiplier++;
				outputText("\n\nYour [sack] pulls tight against your groin, vibrating slightly as it changes.  Once it finishes, you give your [balls] a gentle squeeze and discover they've shrunk.  Even with the reduced volume, they feel just as heavy.");
				changes++;
			}
			//-Shorten clits to reasonable size
			if (player.clitLength >= 4 && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nPainful pricks work through your " + clitDescript() + ", all the way into its swollen clitoral sheath.  Gods, it feels afire with pain!  Agony runs up and down its length, and by the time the pain finally fades, the feminine organ has lost half its size.");
				player.clitLength /= 2;
				changes++;
			}
			//Find biggest dick!
			biggestCock = player.biggestCockIndex();
			//-Shrink dicks down to 8\" max.
			if (player.hasCock()) {
				if (player.cocks[biggestCock].cockLength >= 16 && changes < changeLimit && rand(5) == 0) {
					outputText("\n\nA roiling inferno of heat blazes in your " + cockDescript(biggestCock) + ", doubling you over in the dirt.  You rock back and forth while tears run unchecked down your cheeks.  Once the pain subsides and you're able to move again, you find the poor member has lost nearly half its size.");
					player.cocks[biggestCock].cockLength /= 2;
					player.cocks[biggestCock].cockThickness /= 1.5;
					if (player.cocks[biggestCock].cockThickness * 6 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness * 8 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness < .5) player.cocks[biggestCock].cockThickness = .5;
					changes++;
				}
				//COCK TF!
				if (player.kangaCocks() < player.cockTotal() && (type == 1 && rand(2) == 0) && changes < changeLimit) {
					outputText("\n\nYou feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ");
					if (player.hasSheath()) outputText("your sheath");
					else outputText("a sheath that forms at the base of it");
					outputText(".  <b>You now have a kangaroo-penis!</b>");
					var cockIdx:int = 0;
					//Find first non-roocock!
					while (cockIdx < player.cockTotal()) {
						if (player.cocks[cockIdx].cockType != CockTypesEnum.KANGAROO) {
							player.cocks[cockIdx].cockType = CockTypesEnum.KANGAROO;
							player.cocks[cockIdx].knotMultiplier = 1;
							break;
						}
						cockIdx++;
					}
					changes++;
				}
			}
			//****************
			//Big Kanga Morphs
			//type 1 ignores normal restrictions
			//****************
			//-Face (Req: Fur + Feet)
			if (player.faceType != Face.KANGAROO && ((player.hasFur() && player.lowerBody == LowerBody.KANGAROO) || type == 1) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				//gain roo face from human/naga/shark/bun:
				if (player.faceType == Face.HUMAN || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SHARK_TEETH || player.faceType == Face.BUNNY) outputText("\n\nThe base of your nose suddenly hurts, as though someone were pinching and pulling at it.  As you shut your eyes against the pain and bring your hands to your face, you can feel your nose and palate shifting and elongating.  This continues for about twenty seconds as you stand there, quaking.  When the pain subsides, you run your hands all over your face; what you feel is a long muzzle sticking out, whiskered at the end and with a cleft lip under a pair of flat nostrils.  You open your eyes and receive confirmation. <b>You now have a kangaroo face!  Crikey!</b>");
				//gain roo face from other snout:
				else outputText("\n\nYour nose tingles. As you focus your eyes toward the end of it, it twitches and shifts into a muzzle similar to a stretched-out rabbit's, complete with harelip and whiskers.  <b>You now have a kangaroo face!</b>");
				changes++;
				setFaceType(Face.KANGAROO);
			}
			//-Fur (Req: Footsies)
			if (!player.hasFur() && (player.lowerBody == LowerBody.KANGAROO || type == 1) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				changes++;
				outputText("\n\nYour [skin.type] itches terribly all over and you try cartoonishly to scratch everywhere at once.  ");
				player.skin.growCoat(Skin.FUR,{color:"brown"});
				outputText("As you pull your hands in, you notice [skin coat.color] fur growing on the backs of them.  All over your body the scene is repeated, covering you in the stuff.  <b>You now have fur!</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
			}
			//-Roo footsies (Req: Tail)
			if (player.lowerBody != LowerBody.KANGAROO && player.lowerBody != LowerBody.GARGOYLE && (type == 1 || player.tailType == Tail.KANGAROO) && changes < changeLimit && rand(4) == 0) {
				//gain roo feet from centaur:
				if (player.isTaur()) outputText("\n\nYour backlegs suddenly wobble and collapse, causing you to pitch over onto your side.  Try as you might, you can't get them to stop spasming so you can stand back up; you thrash your hooves wildly as a pins-and-needles sensation overtakes your lower body.  A dull throbbing along your spine makes you moan in agony; it's as though someone had set an entire bookshelf on your shoulders and your spine were being compressed far beyond its limit.  After a minute of pain, the pressure evaporates and you look down at your legs.  Not only are your backlegs gone, but your forelegs have taken on a dogleg shape, with extremely long feet bearing a prominent middle toe!  You set about rubbing the feeling back into your legs and trying to move the new feet.  <b>You now have kangaroo legs!</b>");
				//gain roo feet from naga:
				else if (player.lowerBody == LowerBody.NAGA) outputText("\n\nYour tail quivers, then shakes violently, planting you on your face.  As you try to bend around to look at it, you can just see the tip shrinking out of your field of vision from the corner of your eye.  The scaly skin below your waist tightens intolerably, then splits; you wriggle out of it, only to find yourself with a pair of long legs instead!  A bit of hair starts to grow in as you stand up unsteadily on your new, elongated feet.  <b>You now have kangaroo legs!</b>  Now, what are you going to do with a giant shed snakeskin?");
				//gain roo feet from slime:
				else if (player.lowerBody == LowerBody.GOO) outputText("\n\nYour mounds of goo shrink and part involuntarily, exposing your crotch.  Modesty overwhelms you and you try to pull them together, but the shrinkage is continuing faster than you can shift your gooey body around.  Before long you've run out of goo to move, and your lower body now ends in a pair of slippery digitigrade legs with long narrow feet.  They dry in the air and a bit of fur begins to sprout as you look for something to cover up with.  <b>You now have kangaroo legs!</b> You sigh.  Guess this means it's back to wearing underpants again.");
				//gain roo feet from human/bee/demon/paw/lizard:
				else outputText("\n\nYour feet begin to crack and shift as the metatarsal bones lengthen.  Your knees buckle from the pain of your bones rearranging themselves, and you fall over.  After fifteen seconds of what feels like your feet being racked, the sensation stops.  You look down at your legs; they've taken a roughly dog-leg shape, but they have extremely long feet with a prominent middle toe!  As you stand up you find that you're equally comfortable standing flat on your feet as you are on the balls of them!  <b>You now have kangaroo legs!</b>");
				setLowerBody(LowerBody.KANGAROO);
				player.legCount = 2;
				changes++;
			}
			//-Roo tail (Req: Ears)
			if (player.tailType != Tail.KANGAROO && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0 && (type != 1 || player.ears.type == Ears.KANGAROO)) {
				//gain roo tail:
				if (player.tailType == Tail.NONE) outputText("\n\nA painful pressure in your lower body causes you to stand straight and lock up.  At first you think it might be gas.  No... something is growing at the end of your tailbone.  As you hold stock still so as not to exacerbate the pain, something thick pushes out from the rear of your garments.  The pain subsides and you crane your neck around to look; a long, tapered tail is now attached to your butt and a thin coat of fur is already growing in!  <b>You now have a kangaroo tail!</b>");
				//gain roo tail from bee tail:
				else if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
					outputText("\n\nYour chitinous backside shakes and cracks once you finish eating.  Peering at it as best you can, it appears as though the fuzz is falling out in clumps and the chitin is flaking off.  As convulsions begin to wrack your body and force you to collapse, the ");
					if (player.tailType == Tail.BEE_ABDOMEN) outputText("hollow stinger drops out of the end, taking the venom organ with it.");
					else outputText("spinnerets drop out of the end, taking the last of your webbing with it.");
					outputText("  By the time you're back to yourself, the insectile carapace has fallen off completely, leaving you with a long, thick, fleshy tail in place of your proud, insectile abdomen.  <b>You now have a kangaroo tail!</b>  You wipe the errant spittle from your mouth as you idly bob your new tail about.");
				}
				//gain roo tail from other tail:
				else {
					outputText("\n\nYour tail twitches as you eat.  It begins to feel fat and swollen, and you try to look at your own butt as best you can.  What you see matches what you feel as your tail thickens and stretches out into a long cone shape.  <b>You now have a kangaroo tail!</b>");
				}
				setTailType(Tail.KANGAROO);
				changes++;
			}
			//-Roo ears
			if (player.ears.type != Ears.KANGAROO && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				//Bunbun ears get special texts!
				if (player.ears.type == Ears.BUNNY) outputText("\n\nYour ears stiffen and shift to the sides!  You reach up and find them pointed outwards instead of up and down; they feel a bit wider now as well.  As you touch them, you can feel them swiveling in place in response to nearby sounds.  <b>You now have a pair of kangaroo ears!</b>");
				//Everybody else?  Yeah lazy.
				else outputText("\n\nYour ears twist painfully as though being yanked upwards and you clap your hands to your head.  Feeling them out, you discover them growing!  They stretch upwards, reaching past your fingertips, and then the tugging stops.  You cautiously feel along their lengths; they're long and stiff, but pointed outwards now, and they swivel around as you listen.  <b>You now have a pair of kangaroo ears!</b>");
				changes++;
				setEarType(Ears.KANGAROO);
			}
			//UBEROOOO
			//kangaroo perk: - any liquid or food intake will accelerate a pregnancy, but it will not progress otherwise
			if (player.findPerk(PerkLib.Diapause) < 0 && player.kangaScore() > 4 && rand(4) == 0 && changes < changeLimit && player.hasVagina()) {
				//Perk name and description:
				player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
				outputText("\n\nYour womb rumbles as something inside it changes.\n<b>(You have gained the Diapause perk.  Pregnancies will not progress when fluid intake is scarce, and will progress much faster when it isn't.)</b>");
				changes++;
				//trigger effect: Your body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			if (changes == 0) {
				outputText("\n\nIt did not seem to have any effects, but you do feel better rested.");
				fatigue(-40);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//[Giant Chocolate Cupcake] – 500 gems
		public function giantChocolateCupcake(player:Player):void
		{
			clearOutput();
			outputText("You look down at the massive chocolate cupcake and wonder just how you can possibly eat it all.  It fills the over-sized wrapper and bulges out over the top, somehow looking obscene even though it's merely a baked treat.  There is a single candle positioned atop its summit, and it bursts into flame as if by magic.  Eight red gumdrops ring the outer edge of the cupcake, illuminated by the flame.\n\n");
			outputText("You hesitantly take a bite.  It's sweet, as you'd expect, but there's also a slightly salty, chocolaty undercurrent of flavor.  Even knowing what the minotaur put in Maddie's mix, you find yourself grateful that this new creation doesn't seem to have any of his 'special seasonings'.  It wouldn't do to be getting drugged up while you're slowly devouring the massive, muffin-molded masterpiece. Before you know it, most of the cupcake is gone and you polish off the last chocolaty bites before licking your fingers clean.\n\n");
			outputText("Gods, you feel heavy!  You waddle slightly as your body begins thickening, swelling until you feel as wide as a house.  Lethargy spreads through your limbs, and you're forced to sit still a little while until you let out a lazy burp.\n\n");
			outputText("As you relax in your sugar-coma, you realize your muscle definition is fading away, disappearing until your [skin.type] looks nearly as soft and spongy as Maddie's own.  You caress the soft, pudgy mass and shiver in delight, dimly wondering if this is how the cupcake-girl must feel all the time.");
			outputText(player.modTone(0, player.maxToneCap()));
			outputText(player.modThickness(player.maxThicknessCap(), player.maxThicknessCap()));
			player.refillHunger(100);
		}

		public function sweetGossamer(type:Number,player:Player):void
		{
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Consuming Text
			if (type == 0) outputText("You wad up the sweet, pink gossamer and eat it, finding it to be delicious and chewy, almost like gum.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");
			else if (type == 1) outputText("You wad up the sweet, black gossamer and eat it, finding it to be delicious and chewy, almost like licorice.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");

			//*************
			//Stat Changes
			//*************
			//(If speed<70, increases speed)
			if (player.spe < 70 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?");
				dynStats("spe", 1.5);
				changes++;
			}
			//(If speed>80, decreases speed down to minimum of 80)
			if (player.spe > 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel like resting high in the trees and waiting for your unsuspecting prey to wander below so you can take them without having to exert yourself.  What an odd thought!");
				dynStats("spe", -1.5);
				changes++;
			}
			//(increases sensitivity)
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on.");
				dynStats("sen", 1);
				changes++;
			}
			//(Increase libido)
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more.");
				dynStats("lib", 1);
				changes++;
			}
			//(increase toughness to 60)
			if (changes < changeLimit && rand(3) == 0 && player.tou < 60) {
				outputText("\n\nStretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your " + player.skinFurScales() + " doesn't feel much different, the underlying flesh does seem tougher.");
				dynStats("tou", 1);
				changes++;
			}
			//(decrease strength to 70)
			if (player.str > 70 && rand(3) == 0) {
				outputText("\n\nLethargy rolls through you while you burp noisily.  You rub at your muscles and sigh, wondering why you need to be strong when you could just sew up a nice sticky web to catch your enemies.  ");
				if (player.spiderScore() < 4) outputText("Wait, you're not a spider, that doesn't make any sense!");
				else outputText("Well, maybe you should put your nice, heavy abdomen to work.");
				dynStats("str", -1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//****************
			//Sexual Changes
			//****************
			//Increase venom recharge
			if (player.tailType == Tail.SPIDER_ADBOMEN && player.tailRecharge < 25 && changes < changeLimit) {
				changes++;
				outputText("\n\nThe spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.");
				player.tailRecharge += 5;
			}
			//(tightens vagina to 1, increases lust/libido)
			if (player.hasVagina()) {
				if (player.looseness() > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!");
					dynStats("lib", 2, "lus", 25);
					changes++;
					player.vaginas[0].vaginalLooseness--;
				}
			}
			//(tightens asshole to 1, increases lust)
			if (player.ass.analLooseness > 1 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				dynStats("lib", 2, "lus", 25);
				changes++;
				player.ass.analLooseness--;
			}
			//[Requires penises]
			//(Thickens all cocks to a ratio of 1\" thickness per 5.5\"
			if (player.hasCock() && changes < changeLimit && rand(4) == 0) {
				//Use chosen to see if any dicks can be thickened
				var chosen:int = 0;
				counter = 0;
				while (counter < player.cockTotal()) {
					if (player.cocks[counter].cockThickness * 5.5 < player.cocks[counter].cockLength) {
						player.cocks[counter].cockThickness += .1;
						chosen = 1;
					}
					counter++;
				}
				//If something got thickened
				if (chosen == 1) {
					outputText("\n\nYou can feel your [cocks] filling out in your [armor]. Pulling ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" out, you look closely.  ");
					if (player.cockTotal() == 1) outputText("It's");
					else outputText("They're");
					outputText(" definitely thicker.");
					var counter:Number;
					changes++;
				}
			}
			//[Increase to Breast Size] - up to Large DD
			if (player.smallestTitSize() < 6 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//[Increase to Ass Size] - to 11
			if (player.butt.type < 11 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou look over your shoulder at your " + buttDescript() + " only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!");
				player.butt.type++;
				changes++;
			}
			//***************
			//Appearance Changes
			//***************
			//(Ears become pointed if not human)
			if (player.ears.type != Ears.HUMAN && player.ears.type != Ears.ELFIN && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
				setEarType(Ears.ELFIN);
				changes++;
			}
			//(Fur/Scales fall out replaced by chitin)
			if (!player.hasCoatOfType(Skin.CHITIN) && (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN) && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				if (player.hasCoat()) {
					outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, almost pearly-white chitin underneath.");
				} else outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.");
				outputText("  <b>You now have pale white chitin exoskeleton covering your body.</b>");
				player.skin.growCoat(Skin.CHITIN,{color:"pale white"});
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedChitin)) {
					outputText("\n\n<b>Genetic Memory: Chitin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedChitin, 0, 0, 0, 0);
				}
				changes++;
			}
			//(Gain human face)
			if (player.hasCoatOfType(Skin.CHITIN) && (player.faceType != Face.SPIDER_FANGS && player.faceType != Face.HUMAN) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nWracked by pain, your face slowly reforms into a perfect human shape.  Awed by the transformation, you run your fingers delicately over the new face, marvelling at the change.  <b>You have a human face again!</b>");
				setFaceType(Face.HUMAN);
				changes++;
			}
			//-Remove breast rows over 2.
			if (changes < changeLimit && player.bRows() > 2 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA chill runs over your [allbreasts] and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (chosen = 0; chosen < player.breastRows.length; chosen++) {
					player.breastRows[chosen].nipplesPerBreast = 1;
				}
			}
			//Nipples Turn Black:
			if (!player.hasStatusEffect(StatusEffects.BlackNipples) && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				changes++;
			}
			//eyes!
			if (player.hasCoatOfType(Skin.CHITIN) && (player.faceType != Face.SPIDER_FANGS || player.faceType != Face.HUMAN) && player.eyes.type == Eyes.HUMAN && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!");
				setEyeType(Eyes.FOUR_SPIDER_EYES);
				dynStats("int", 5);
				changes++;
			}
			//(Gain spider fangs)
			if (player.faceType == Face.HUMAN && player.hasCoatOfType(Skin.CHITIN) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>");
				setFaceType(Face.SPIDER_FANGS);
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				changes++;
			}
			//(Arms to carapace-covered arms)
			if (!InCollection(Arms.GARGOYLE, Arms.SPIDER) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\n");
				if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
					//(Bird pretext)
					if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
					outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
				}
				else {
					if (player.arms.type == Arms.BEE) outputText("The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
					else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) outputText("The scales covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
					else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.");
					else outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
				}
				setArmType(Arms.SPIDER);
				changes++;
			}
			if ((player.isTaur() || player.isGoo() || player.isNaga() || player.isScylla() || player.isAlraune())
				&& changes < changeLimit && rand(4) == 0) {
				humanizeLowerBody();
				changes++;
			}
			//Drider butt
			if (type == 1 && player.findPerk(PerkLib.SpiderOvipositor) < 0 && player.isDrider() && player.tailType == Tail.SPIDER_ADBOMEN && changes < changeLimit && rand(3) == 0 && (player.hasVagina || rand(2) == 0)) {
				outputText("\n\nAn odd swelling sensation floods your spider half.  Curling your abdomen underneath you for a better look, you gasp in recognition at your new 'equipment'!  Your semi-violent run-ins with the swamp's population have left you <i>intimately</i> familiar with the new appendage.  <b>It's a drider ovipositor!</b>  A few light prods confirm that it's just as sensitive as any of your other sexual organs.  You idly wonder what laying eggs with this thing will feel like...");
				outputText("\n\n(<b>Perk Gained:  Spider Ovipositor - Allows you to lay eggs in your foes!</b>)");
				//V1 - Egg Count
				//V2 - Fertilized Count
				player.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0);
				//Opens up drider ovipositor scenes from available mobs. The character begins producing unfertilized eggs in their arachnid abdomen. Egg buildup raises minimum lust and eventually lowers speed until the player has gotten rid of them.  This perk may only be used with the drider lower body, so your scenes should reflect that.
				//Any PC can get an Ovipositor perk, but it will be much rarer for characters without vaginas.
				//Eggs are unfertilized by default, but can be fertilized:
				//-female/herm characters can fertilize them by taking in semen; successfully passing a pregnancy check will convert one level of unfertilized eggs to fertilized, even if the PC is already pregnant.
				//-male/herm characters will have a sex dream if they reach stage three of unfertilized eggs; this will represent their bee/drider parts drawing their own semen from their body to fertilize the eggs, and is accompanied by a nocturnal emission.
				//-unsexed characters cannot currently fertilize their eggs.
				//Even while unfertilized, eggs can be deposited inside NPCs - obviously, unfertilized eggs will never hatch and cannot lead to any egg-birth scenes that may be written later.
				changes++;
			}
			//(Normal Biped Legs -> Carapace-Clad Legs)
			if (((type == 1 && player.lowerBody != LowerBody.DRIDER && player.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS) || (type != 1 && player.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS)) && (!player.isGoo() && !player.isNaga() && !player.isTaur() && !player.isScylla()) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nStarting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your " + buttDescript() + " in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>");
				setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
				player.legCount = 2;
				changes++;
			}
			//(Tail becomes spider abdomen GRANT WEB ATTACK)
			if (player.tailType != Tail.SPIDER_ADBOMEN && (player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || player.lowerBody == LowerBody.DRIDER) && player.arms.type == Arms.SPIDER && rand(4) == 0) {
				outputText("\n\n");
				//(Pre-existing tails)
				if (player.tailType > Tail.NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>\n\n");
				//(No tail)
				else outputText("A burst of pain hits you just above your " + buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>");
				setTailType(Tail.SPIDER_ADBOMEN);
				player.tailVenom = 5;
				player.tailRecharge = 5;
				changes++;
			}
			//(Drider Item Only: Carapace-Clad Legs to Drider Legs)
			if (type == 1 && player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS && rand(4) == 0 && player.tailType == Tail.SPIDER_ADBOMEN) {
				outputText("\n\nJust like when your legs changed to those of a spider-morph, you find yourself suddenly paralyzed below the waist.  Your dark, reflective legs splay out and drop you flat on your back.   Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them.  Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down.  As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs.  Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.  Your abdomen has gotten even larger as well.  Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance.  As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance.  That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your " + buttDescript() + " is still positioned just above the start of your arachnid half.  <b>You're now a drider.</b>");
				setLowerBody(LowerBody.DRIDER);
				player.legCount = 8;
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			if (changes == 0) {
				outputText("\n\nThe sweet silk energizes you, leaving you feeling refreshed.");
				fatigue(-33);
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

/*
		public function applyLustStick(player:Player):void
		{
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.LustStickApplied)) {
				player.addStatusValue(StatusEffects.LustStickApplied, 1, 12 + rand(12));
				outputText("You carefully open the sweet-smelling tube and smear the lipstick over the coat you already have on your lips.  <b>No doubt another layer will make it last even longer!</b>  ");
				outputText("You finish and pucker your lips, feeling fairly sexy with your new, thicker makeup on.\n\n");
			}
			else {
				player.createStatusEffect(StatusEffects.LustStickApplied, 24, 0, 0, 0);
				outputText("You carefully open the sweet-smelling tube and smear the lipstick over your lips.  ");
				if (player.hasCock()) outputText("It tingles a little, but the drugs have little to no effect on you now.");
				else outputText("Honestly, it amazes you that something as little as a kiss can make a man putty in your hands.");
				outputText("  You finish and pucker your lips, feeling fairly sexy with your new makeup on.\n\n");
			}
			dynStats("lus", 1);

		}
*/

		public function broBrew(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			//no drink for bimbos!
			if (player.findPerk(PerkLib.BimboBody) >= 0) {
				outputText("The stuff hits you like a giant cube, nearly staggering you as it begins to settle.");
				if (player.tallness < 77) {
					player.tallness = 77;
					outputText(".. Did the ground just get farther away?  You glance down and realize, you're growing!  Like a sped-up flower sprout, you keep on getting taller until finally stopping around... six and a half feet, you assume.  Huh.  You didn't expect that to happen!");
				}
				if (player.tone < 100) {
					outputText("  A tingling in your arm draws your attention just in time to see your biceps and triceps swell with new-found energy, skin tightening until thick cords of muscle run across the whole appendage.  Your other arm surges forward with identical results.  To compensate, your shoulders and neck widen to bodybuilder-like proportions while your chest and abs tighten to a firm, statuesque physique.  Your [legs] and glutes are the last to go, bulking up to proportions that would make any female martial artist proud.  You feel like you could kick forever with legs this powerful.");
					player.tone = 100;
				}
				outputText("\n\n");

				//female
				if (!player.hasCock()) {
					outputText("The beverage isn't done yet, however, and it makes it perfectly clear with a building pleasure in your groin.  You can only cry in ecstasy and loosen the bottoms of your [armor] just in time for a little penis to spring forth.  You watch, enthralled, as blood quickly stiffens the shaft to its full length – then keeps on going!  Before long, you have a quivering 10-inch maleness, just ready to stuff into a welcoming box.");
					player.createCock();
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2;
					if (player.balls == 0) {
						outputText("  Right on cue, two cum-laden testicles drop in behind it, their contents swirling and churning.");
						player.balls = 2;
						player.ballSize = 3;
					}
					outputText("\n\n");
				}
				else if (player.balls == 0) {
					outputText("A swelling begins behind your man-meat, and you're assailed with an incredibly peculiar sensation as two sperm-filled balls drop into a newly-formed scrotum.  Frikkin' sweet!\n\n");
					player.balls = 2;
					player.ballSize = 3;
				}
				outputText("Finally, you feel the transformation skittering to a halt, leaving you to openly roam your new chiseled and sex-ready body.  So what if you can barely form coherent sentences anymore?  A body like this does all the talking you need, you figure!");
				if (player.inte > 35) {
					var boost:Number = (player.inte-35) / 5;
					player.inte = 35 + boost;
					dynStats("int", -0.1);

				}
				if (player.lib < 50) {
					player.lib = 50;
					dynStats("lib", .1);
				}
				outputText("\n\n<b>(Lost Perk - ");
				if (player.findPerk(PerkLib.BimboBrains) >= 0) outputText("Bimbo Brains, ");
				outputText("Bimbo Body)\n");
				player.removePerk(PerkLib.BimboBrains);
				player.removePerk(PerkLib.BimboBody);
				player.createPerk(PerkLib.FutaForm, 0, 0, 0, 0);
				player.createPerk(PerkLib.FutaFaculties, 0, 0, 0, 0);
				outputText("(Gained Perks - Futa Form, Futa Faculties)</b>");
				return;
			}
			//HP restore for bros!
			if (player.findPerk(PerkLib.BroBody) >= 0 || player.findPerk(PerkLib.FutaForm) >= 0) {
				outputText("You crack open the can and guzzle it in a hurry.  Goddamn, this shit is the best.  As you crush the can against your forehead, you wonder if you can find a six-pack of it somewhere?\n\n");
				fatigue(-33);
				HPChange(100, true);
				player.refillHunger(30);
				return;
			}
			outputText("Well, maybe this will give you the musculature that you need to accomplish your goals.  You pull on the tab at the top and hear the distinctive snap-hiss of venting, carbonating pressure.  A smoky haze wafts from the opened container, smelling of hops and alcohol.  You lift it to your lips, the cold, metallic taste of the can coming to your tongue before the first amber drops of beer roll into your waiting mouth.  It tingles, but it's very, very good.  You feel compelled to finish it as rapidly as possible, and you begin to chug it.  You finish the entire container in seconds.\n\n");

			outputText("A churning, full sensation wells up in your gut, and without thinking, you open wide to release a massive burp. It rumbles through your chest, startling birds into flight in the distance.  Awesome!  You slam the can into your forehead hard enough to smash the fragile aluminum into a flat, crushed disc.  Damn, you feel stronger already");
			if (player.inte > 50) outputText(", though you're a bit worried by how much you enjoyed the simple, brutish act");
			outputText(".\n\n");

			//(Tits b' gone)
			if (player.biggestTitSize() >= 1) {
				outputText("A tingle starts in your " + nippleDescript(0) + "s before the tight buds grow warm, hot even.  ");
				if (player.biggestLactation() >= 1) outputText("Somehow, you know that the milk you had been producing is gone, reabsorbed by your body.  ");
				outputText("They pinch in towards your core, shrinking along with your flattening " + allChestDesc() + ".  You shudder and flex in response.  Your chest isn't just shrinking, it's reforming, sculping itself into a massive pair of chiseled pecs.  ");
				if (player.breastRows.length > 1) {
					outputText("The breasts below vanish entirely.  ");
					while (player.breastRows.length > 1) {
						player.removeBreastRow(player.breastRows.length - 1, 1);
					}
				}
				player.breastRows[0].breastRating = 0;
				player.breastRows[0].nipplesPerBreast = 1;
				player.breastRows[0].fuckable = false;
				if (player.nippleLength > .5) player.nippleLength = .25;
				player.breastRows[0].lactationMultiplier = 0;
				player.removeStatusEffect(StatusEffects.Feeder);
				player.removePerk(PerkLib.Feeder);
				outputText("All too soon, your boobs are gone.  Whoa!\n\n");
			}

			outputText("Starting at your hands, your muscles begin to contract and release, each time getting tighter, stronger, and more importantly - larger.  The oddness travels up your arms, thickens your biceps, and broadens your shoulders.  Soon, your neck and chest are as built as your arms.  You give a few experimental flexes as your abs ");
			if (player.tone >= 70) outputText("further define themselves");
			else outputText("become extraordinarily visible");
			outputText(".  The strange, muscle-building changes flow down your [legs], making them just as fit and strong as the rest of you.  You curl your arm and kiss your massive, flexing bicep.  You're awesome!\n\n");

			outputText("Whoah, you're fucking ripped and strong, not at all like the puny weakling you were before.  Yet, you feel oddly wool-headed.  Your thoughts seem to be coming slower and slower, like they're plodding through a marsh.  You grunt in frustration at the realization.  Sure, you're a muscle-bound hunk now, but what good is it if you're as dumb as a box of rocks?  Your muscles flex in the most beautiful way, so you stop and strike a pose, mesmerized by your own appearance.  Fuck thinking, that shit's for losers!\n\n");

			//(has dick less than 10 inches)
			if (player.hasCock()) {
				if (player.cocks[0].cockLength < 10) {
					outputText("As if on cue, the familiar tingling gathers in your groin, and you dimly remember you have one muscle left to enlarge.  If only you had the intelligence left to realize that your penis is not a muscle.  In any event, your [cock] swells in size, ");
					if (player.cocks[0].cockThickness < 2.75) {
						outputText("thickening and ");
						player.cocks[0].cockThickness = 2.75;
					}
					outputText("lengthening until it's ten inches long and almost three inches wide.  Fuck, you're hung!  ");
					player.cocks[0].cockLength = 10;
				}
				//Dick already big enough! BALL CHECK!
				if (player.balls > 0) {
					outputText("Churning audibly, your [sack] sways, but doesn't show any outward sign of change.  Oh well, it's probably just like, getting more endurance or something.");
				}
				else {
					outputText("Two rounded orbs drop down below, filling out a new, fleshy sac above your [legs].  Sweet!  You can probably cum buckets with balls like these.");
					player.balls = 2;
					player.ballSize = 3;
				}
				outputText("\n\n");
			}
			//(No dick)
			else {
				outputText("You hear a straining, tearing noise before you realize it's coming from your underwear.  Pulling open your [armor], you gasp in surprise at the huge, throbbing manhood that now lies between your [hips].  It rapidly stiffens to a full, twelve inches, and goddamn, it feels fucking good.  You should totally find a warm hole to fuck!");
				if (player.balls == 0) outputText("  Two rounded orbs drop down below, filling out a new, fleshy sac above your [legs].  Sweet!  You can probably cum buckets with balls like these.");
				outputText("\n\n");
				player.createCock();
				player.cocks[0].cockLength = 12;
				player.cocks[0].cockThickness = 3;
				if (player.balls == 0) {
					player.balls = 2;
					player.ballSize = 3;
				}
			}
			//(Pussy b gone)
			if (player.hasVagina()) {
				outputText("At the same time, your [vagina] burns hot, nearly feeling on fire.  You cuss in a decidedly masculine way for a moment before the pain fades to a dull itch.  Scratching it, you discover your lady-parts are gone.  Only a sensitive patch of skin remains.\n\n");
				player.removeVagina(0, 1);
			}
			//(below max masculinity)
			if (player.femininity > 0) {
				outputText("Lastly, the change hits your face.  You can feel your jawbones shifting and sliding around, your skin changing to accommodate your face's new shape.  Once it's finished, you feel your impeccable square jaw and give a wide, easy-going grin.  You look awesome!\n\n");
				player.modFem(0, 100);
			}
			outputText("You finish admiring yourself and adjust your [armor] to better fit your new physique.  Maybe there's some bitches around you can fuck.  Hell, as good as you look, you might have other dudes wanting you to fuck them too, no homo.\n\n");
			//max tone.  Thickness + 50
			player.modTone(player.maxToneCap(), player.maxToneCap());
			player.modThickness(player.maxThicknessCap(), (player.maxThicknessCap() * 0.5));
			//Bonus cum production!
			player.createPerk(PerkLib.BroBrains, 0, 0, 0, 0);
			player.createPerk(PerkLib.BroBody, 0, 0, 0, 0);
			outputText("<b>(Bro Body - Perk Gained!)\n");
			outputText("(Bro Brains - Perk Gained!)</b>\n");//int to 20.  max int 50)
			if (player.findPerk(PerkLib.Feeder) >= 0) {
				outputText("<b>(Perk Lost - Feeder!)</b>\n");
				player.removePerk(PerkLib.Feeder);
			}
			if (player.inte > 21) {
				boost = (player.inte-20) / 4;
				player.inte = 21 + boost;
			}
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			dynStats("str", 35, "tou", 35, "int", -1, "lib", 5, "lus", 40);
			player.refillHunger(30);
		}


//Miscellaneous
//ITEM GAINED FROM LUST WINS
//bottle of ectoplasm. Regular stat-stuff include higher speed, (reduced libido?), reduced sensitivity, and higher intelligence. First-tier effects include 50/50 chance of sable skin with bone-white veins or ivory skin with onyx veins. Second tier, \"wisp-like legs that flit back and forth between worlds,\" or \"wisp-like legs\" for short. Third tier gives an \"Ephemeral\" perk, makes you (10%, perhaps?) tougher to hit, and gives you a skill that replaces tease/seduce—allowing the PC to possess the creature and force it to masturbate to gain lust. Around the same effectiveness as seduce.
//Mouseover script: \"The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel...uncomfortable, as you observe it.\"

//Bottle of Ectoplasm Text
		public function ectoplasm(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You grimace and uncork the bottle, doing your best to ignore the unearthly smell drifting up to your nostrils. Steeling yourself, you raise the container to your lips and chug the contents, shivering at the feel of the stuff sliding down your throat.  Its taste, at least, is unexpectedly pleasant.  Almost tastes like oranges.");
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Effect script 1:  (higher intelligence)
			if (player.inte < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou groan softly as your head begins pounding something fierce.  Wincing in pain, you massage your temples as the throbbing continues, and soon, the pain begins to fade; in its place comes a strange sense of sureness and wit.");
				dynStats("int", 1);
				if (player.inte < 50) dynStats("int", 1);
				changes++;
			}
			//Effect script 2:  (lower sensitivity)
			if (player.sens >= 20 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWoah, what the... you pinch your " + player.skinFurScales() + " to confirm your suspicions; the ghostly snack has definitely lowered your sensitivity.");
				dynStats("sen", -2);
				if (player.sens >= 75) dynStats("sen", -2);
				changes++;
			}
			//Effect script 3:  (higher libido)
			if (player.lib < 100 && rand(3) == 0 && changes < changeLimit) {
				//([if libido >49]
				if (player.lib < 50) outputText("\n\nIdly, you drop a hand to your crotch as");
				else outputText("\n\nWith a substantial amount of effort, you resist the urge to stroke yourself as");
				outputText(" a trace amount of the ghost girl's lust is transferred into you.  How horny IS she, you have to wonder...");
				dynStats("lib", 1);
				if (player.lib < 50) dynStats("lib", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Effect script a:  (human wang)
			if (player.hasCock() && changes < changeLimit) {
				if (rand(3) == 0 && player.cocks[0].cockType != CockTypesEnum.HUMAN) {
					outputText("\n\nA strange tingling begins behind your [cock], slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your [armor] to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, <b>leaving you with a completely human penis.</b>");
					player.cocks[0].cockType = CockTypesEnum.HUMAN;
					changes++;
				}
			}
			//Appearnace Change
			//Hair
			if (rand(4) == 0 && changes < changeLimit && player.hairType != 2) {
				outputText("\n\nA sensation of weightlessness assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming lighter in your grasp, before you can hardly tell you're holding anything.  Plucking a strand, you hold it up before you, surprised to see... it's completely transparent!  You have transparent hair!");
				setHairType(Hair.GHOST);
				changes++;
			}
			//Skin
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && (player.skinTone != "sable" && player.skinTone != "white")) {
				outputText("\n\nA warmth begins in your belly, slowly spreading through your torso and appendages. The heat builds, becoming uncomfortable, then painful, then nearly unbearable. Your eyes unfocus from the pain, and by the time the burning sensation fades, you can already tell something's changed. ");
				var tone:String;
				var adj:String;
				if (rand(2) == 0) {
					tone = "white";
					adj = "milky";
					outputText("You raise a hand, staring at the milky-white flesh. Your eyes are drawn to the veins in the back of your hand, darkening to a jet black as you watch. <b>You have white skin, with black veins!</b>");
				} else {
					outputText("You raise a hand, staring at the sable flesh. Your eyes are drawn to the veins in the back of your hand, brightening to an ashen tone as you watch.  <b>You have black skin, with white veins!</b>");
					tone = "sable";
					adj = "ashen";
				}
				player.skin.setBaseOnly({type:Skin.PLAIN,color:tone,adj:adj});
				changes++;
			}
			//Legs
			if (changes < changeLimit && player.findPerk(PerkLib.Incorporeality) < 0 && (player.skinTone == "white" || player.skinTone == "sable") && player.hairType == 2) {
				//(ghost-legs!  Absolutely no problem with regular encounters, though! [if you somehow got this with a centaur it'd probably do nothing cuz you're not supposed to be a centaur with ectoplasm ya dingus])
				outputText("\n\nAn otherworldly sensation begins in your belly, working its way to your [hips]. Before you can react, your [legs] begin to tingle, and you fall on your rump as a large shudder runs through them. As you watch, your lower body shimmers, becoming ethereal, wisps rising from the newly ghost-like [legs]. You manage to rise, surprised to find your new, ghostly form to be as sturdy as its former corporeal version. Suddenly, like a dam breaking, fleeting visions and images flow into your head, never lasting long enough for you to concentrate on one. You don't even realize it, but your arms fly up to your head, grasping your temples as you groan in pain. As fast as the mental bombardment came, it disappears, leaving you with a surprising sense of spiritual superiority.  <b>You have ghost legs!</b>\n\n");
				outputText("<b>(Gained Perk: Incorporeality</b>)");
				player.createPerk(PerkLib.Incorporeality, 0, 0, 0, 0);
			}
			//Effect Script 8: 100% chance of healing
			if (changes == 0) {
				outputText("You feel strangely refreshed, as if you just gobbled down a bottle of sunshine.  A smile graces your lips as vitality fills you.  ");
				HPChange(player.level * 5 + 10, true);
				changes++;
			}
			//Incorporeality Perk Text:  You seem to have inherited some of the spiritual powers of the residents of the afterlife!  While you wouldn't consider doing it for long due to its instability, you can temporarily become incorporeal for the sake of taking over enemies and giving them a taste of ghostly libido.

			//Sample possession text (>79 int, perhaps?):  With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.
			//Failure:  With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function elfears(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("You really should’ve brought this to someone who knew about it first!  Your stomach grumbles, and you feel a short momentaneous pain in your head.  As you swallow you feel your body start to change into something else.");
			//Stats
			if (player.str > 40 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA sense of helplessness settles upon you as your limbs lose mass, leaving you feeling weaker and punier.");
				dynStats("str", -1);
				changes++;
			}
			if (player.spe < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel fleet and lighter on your toes; you sense you could dodge, dart or skip away from anything.");
				dynStats("spe", 1);
				changes++;
			}
			if (player.inte < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou groan softly as your head begins pounding something fierce.  Wincing in pain, you massage your temples as the throbbing continues, and soon, the pain begins to fade; in its place comes a strange sense of sureness and wit.");
				dynStats("int", 1);
				if (player.inte < 50) dynStats("int", 1);
				changes++;
			}
			if (player.sens < 80 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour body becomes overwhelmed by stimuli for a moment making you shiver with a moan of pleasure at the mere caress of the wind. The excess sensation eventually dies down but leaves you more sensitive than before.");
				dynStats("sen", 2);
				if (player.sens < 40) dynStats("sen", 2);
				changes++;
			}
			if ((player.hairLength > 26 || player.hairLength < 16) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.hairLength < 16) {
					player.hairLength += 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				else {
					player.hairLength -= 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				changes++;
			}
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\nEach movement feels a tiny bit easier than the last. Did you just lose a little weight!?");
				outputText(player.modThickness(70, 4));
			}
			if (changes < changeLimit && rand(3) == 0) outputText(player.modTone(10, 5));
			if (changes < changeLimit && rand(3) == 0 && player.femininity != 50) outputText(player.modFem(50, 3));
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual
			if (player.cockTotal() > 0 && player.biggestCockArea() > 6 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour " + player.cockDescript(0) + " begins to tingle as it shrinks to a smaller size.");
				player.cocks[0].cockLength *= 2 / 3;
				player.cocks[0].cockThickness *= 2 / 3;
				dynStats("sen", -2, "lus", -10);
				changes++;
			}
			if (player.vaginas.length > 0 && player.breastRows[0].breastRating < 7 && changes < changeLimit && rand(3) == 0) {
				var grown:uint = 1 + rand(3);
				if (player.breastRows.length > 0) {
					if (player.breastRows[0].breastRating < 4 && rand(3) == 0) grown++;
				}
				outputText("\n\n");
				player.growTits(grown, player.breastRows.length, true, 3);
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}
			//Physical
			if (player.lowerBody != LowerBody.ELF && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nSomething shifts in your legs as you feel almost supernatural agility imbue your steps granting a nymph like grace to your stride. Your feet are no longer rough but delicate and agile like those of an elf. <b>You now have agile elven feet.</b>");
					setLowerBody(LowerBody.ELF);
				}
				else humanizeLowerBody();
				changes++;
			}
			if (player.lowerBody == LowerBody.ELF && player.arms.type != Arms.ELF && changes < changeLimit && rand(3) == 0) {
				if (player.arms.type == Arms.HUMAN) {
					outputText("\n\nSomething in your hands shift as they change taking on a more feminine fragile yet agile structure. You discover with surprise your dexterity has greatly increased allowing you to manipulate things in your delicate elven fingers with almost unreal precision. However your grip has become weaker as a result, weakening your ability to use raw force over finesse. <b>You now have delicate elven hands.</b>");
					setArmType(Arms.ELF);
				}
				else humanizeArms();
				changes++;
			}
			if (player.arms.type == Arms.ELF && player.ears.type != Ears.ELVEN && changes < changeLimit && rand(3) == 0) {
				if (player.ears.type == Ears.HUMAN) {
					outputText("\n\nSounds become increasingly audible as a weird tingling runs through your scalp and your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elven ears.</b> The points are quite sensitive and you will have to get used to your new enhanced hearing ability.");
					setEarType(Ears.ELVEN);
				}
				else humanizeEars();
				changes++;
			}
			if (player.ears.type == Ears.ELVEN && player.eyes.type != Eyes.ELF && changes < changeLimit && rand(3) == 0) {
				if (player.eyes.type == Eyes.HUMAN) {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision is changed somehow. Your pupils draw in light and the color and shapes seems more defined even at great distance. Your new eyes granting you better vision. You go to a puddle to check what happened to them and notice <b>your new eyes are like those of an elf’s with a vertical slit that reflects lights.</b>");
					setEyeType(Eyes.ELF);
				}
				else humanizeEyes();
				changes++;
			}
			if (changes < changeLimit && player.findPerk(PerkLib.ElvenSense) < 0 && player.ears.type == Ears.ELVEN && player.eyes.type == Eyes.ELF) {
				outputText("\n\nYour acute hearing warns you of imminent danger and you dodge as a branch falls from a nearby tree missing your head by mere inches. You realise your newly sharpened senses granted you increased agility and precision.  <b>You gained the ability Elven Senses.</b>\n\n");
				outputText("<b>(Gained Perk: Elven Sense</b>)");
				player.createPerk(PerkLib.ElvenSense, 0, 0, 0, 0);
				changes++;
			}
			if (player.tongue.type == Tongue.HUMAN && player.tongue.type != Tongue.ELF && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realize it is because your body became closer to that of an elf, adapting even your tongue and voice.  <b>You now have the beautiful voice of the elves.</b>");
				setTongueType(Tongue.ELF);
				changes++;
			}
			if (player.tongue.type != Tongue.HUMAN && player.tongue.type != Tongue.ELF && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
				setTongueType(Tongue.HUMAN);
				changes++;
			}
			if (player.hairType != 10 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nSomething changes in your scalp and you pass a hand through to know what is going on. To your surprise your hair texture turned silky, feeling as if you had been tending it for years, the touch is so agreeable you can’t help but idly stroke it with your hand. <b>Your hair has taken on an almost silk-like texture, just like that of an elf!</b>");
				setHairType(Hair.SILKEN);
				changes++;
			}
			if (player.lowerBody == LowerBody.ELF && player.arms.type == Arms.ELF && player.hasPlainSkinOnly() && !player.isGargoyle() && player.skinAdj != "flawless" && changes < changeLimit && rand(3) == 0) {
				var color:String;
				color = randomChoice("dark","light","tan");
				player.skinTone = color;
				outputText("\n\nYour skin begins to change again, impurities, scars and bruises disappearing entirely as your skin color changes to a " + player.skinTone + " tone. You examine your body discovering with surprise your skin is now extremely sensitive but also flawless just like that of an elf. ");
				outputText("It is beautiful and inviting to the touch, surely your opponents would beg for a chance to get but a single taste of your flawless body. <b>Your " + player.skinTone + " skin is now flawless just like that of the elves.</b>");
				if (player.findPerk(PerkLib.FlawlessBody) < 0) {
					player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
					outputText("\n\n<b>(Gained Perk: Flawless Body</b>)");
				}
				player.skinAdj = "flawless";
				changes++;
			}
			if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
				humanizeSkin();
				changes++;
			}
			//Hair Color
			var elf_hair:Array = ["silver", "golden blonde", "leaf green", "black"];
			if (!InCollection(player.hairColor, elf_hair) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				player.hairColor = randomChoice(elf_hair);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!");
			}
			//wings tf for high elfs xD
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function orcMead(player:Player):void {
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("You drink the mead, finding it to have a remarkably smooth yet potent taste.  You lick your lips and sneeze, feeling slightly tipsy.");
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			//Stats
			if (player.str < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour fill your muscles filling with orc might.");
				dynStats("str", 1);
				changes++;
			}
			if (player.tou < 100 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
				dynStats("tou", 1);
				changes++;
			}
			if (player.spe < 75 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nHearing a suddent sound you suddently move by reflex to the side with such speed you nearly trip.  Seems your reaction speed has increased as well as your mobile execution.");
				dynStats("spe", 1);
				changes++;
			}
			if (player.inte > 15 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
				dynStats("int", -1);
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.thickness > 20) {
				outputText(player.modThickness(20, 3));
				changes++;
			}
			if (changes < changeLimit && rand(3) == 0 && player.tone < player.maxToneCap()) {
				outputText(player.modTone(player.maxToneCap(), 3));
			}
			if (rand(3) == 0 && changes < changeLimit && player.gender >= 2 && player.hips.type < 15) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hips.type++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.butt.type < 12) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.butt.type++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 6) {
				if (player.ballSize < 3)
					outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + (player.balls == 4 ? "quartette" : "duo") + " of [balls] have grown larger than a human’s.");
				else
					outputText("\n\nA sudden onset of heat envelops your groin, focusing on your ballsack. Walking becomes difficult as you discover your " + (player.balls == 4 ? "quartette" : "duo") + " of testicles have enlarged again.");
				player.ballSize++;
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			if (rand(3) == 0 && changes < changeLimit && player.cocks.length > 0 && player.cocks[0].cockType != CockTypesEnum.PIG) {
				if (player.cocks.length == 1) { //Single cock
					outputText("\n\nYou feel an uncomfortable pinching sensation in your [cock]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[0].cockType = CockTypesEnum.PIG;
				}
				else { //Multiple cocks
					outputText("\n\nYou feel an uncomfortable pinching sensation in one of your cocks. You pull open your [armor], watching as it warps and changes. As the transformation completes, you’re left with a shiny pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[rand(player.cocks.length+1)].cockType = CockTypesEnum.PIG;
				}
				changes++;
			}
			//Physical
			if (player.lowerBody != LowerBody.ORC && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nYou have trouble standing up as multiple flashes of mild pain run across your legs as a whole set of intricate scar shaped tattoos covers them. Furthermore, your toenails become increasingly pointed, looking like a set of claws. Well, it seems you will have get used to your <b>scar tattooed legs and feet topped with pointed nails.</b>");
					setLowerBody(LowerBody.ORC);
				}
				else humanizeLowerBody();
				changes++;
			}
			if (player.lowerBody == LowerBody.ORC && player.arms.type != Arms.ORC && changes < changeLimit && rand(3) == 0) {
				if (player.arms.type == Arms.HUMAN) {
					outputText("\n\nThe skin on your arms feels as if they’re being cut open as a whole new set of intricate scar-like tattoos covers them. Furthermore your nails become increasingly pointed just like a set of claws and your arms in general grow a bit longer. Well, it seems you’re going to have some issues hiding your <b>scar tattooed arms and sharp nails.</b>");
					setArmType(Arms.ORC);
				}
				else humanizeArms();
				changes++;
			}
			if (player.arms.type == Arms.ORC && player.faceType != Face.ORC_FANGS && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nY");
				if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
				outputText("ou feel your two lower canines grow bigger and slightly sharper, similar to those of a boar, or in your case, an orc. <b>You now have orc canines.</b>");
				setFaceType(Face.ORC_FANGS);
				changes++;
			}
			if (player.ears.type != Ears.ELFIN && rand(3) == 0 && changes < changeLimit) {
				if (player.ears.type == Ears.HUMAN) {
					outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
					setEarType(Ears.ELFIN);
				}
				else humanizeEars();
				changes++;
			}
			if (player.ears.type == Ears.ELFIN && player.eyes.type != Eyes.ORC && changes < changeLimit && rand(3) == 0) {
				if (player.eyes.type == Eyes.HUMAN) {
					player.eyes.colour = "bloody red";
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized.  Your vision has been changed somehow.  <b>Your eyes has turned into those of orc.</b>");
					setEyeType(Eyes.ORC);
				}
				else humanizeEyes();
				changes++;
			}
			if (player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
				var color:String;
				color = randomChoice("green","grey","brown","red","sandy tan");
				player.skinTone = color;
				outputText("\n\nWhoah, that was weird.  You just hallucinated that your " + player.skinDesc + " turned " + player.skinTone + ".  No way!  It's staying, it really changed color!");
				changes++;
			}
			if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
				humanizeSkin();
				changes++;
			}
			if (player.hasPlainSkinOnly() && !player.skin.hasScarShapedTattoo() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou double over suddenly as a harsh, stabbing pain runs across your skin, tattoos in the shape of scars forming on various parts of your body. Considering how you look now, you might as well proudly display your <b>Orc scar tattooed skin.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedScarTattoed)) {
					outputText("\n\n<b>Genetic Memory: Scar Tattoed Skin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedScarTattoed, 0, 0, 0, 0);
				}
				player.skin.base.pattern = Skin.PATTERN_SCAR_SHAPED_TATTOO;
				player.skin.base.adj = "scar shaped tattooed";
				changes++;
			}
			if (player.lowerBody == LowerBody.ORC && player.arms.type == Arms.ORC && player.faceType == Face.ORC_FANGS && player.eyes.type == Eyes.ORC && player.skin.hasScarShapedTattoo() && player.orcScore() >= 11 && player.findPerk(PerkLib.Ferocity) < 0 && changes < changeLimit) {
				outputText("\n\nYou feel a limitless energy fill your orcish limbs, as your body tenses, rippling muscle making your scar-like tattoos look even more realistic. Your [face] gains a look of reverence has you hear the all mighty words of your goddess, telling you to go and claim new lands, conquer all living things, bring them beneath your rule.");
				outputText("\n\nShe tells you that as long as you bear her blessing, you will not fall in battle, even if fatal blows are dealt. Go forth and prove that puny human who said people die when they are killed wrong.");
				outputText("\n\n<b>(Gained Perk: Ferocity</b>)");
				player.createPerk(PerkLib.Ferocity, 0, 0, 0, 0);
				changes++;
			}/*
			if (player.arms.type == Arms.ORC (zamienić to na nieco inne wymagania jak min race score czy coś takiego) && player.tailType != Tail.PIG && changes < changeLimit && rand(3) == 0) {//dla high orka
				if (player.tailType == Tail.NONE) outputText("\n\nYou yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>");
				else outputText("\n\nYou nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out.  <b>You now have a silky Raiju tail!</b>");
				setTailType(Tail.PIG);
				changes++;
			}*/
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function voltageTopaz(itemused:Boolean,player:Player):void
		{
			player.slimeFeed();
			if (itemused == true) clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			if (itemused == true) {
				if (rand(2) == 0) changeLimit++;
				if (rand(3) == 0) changeLimit++;
				changeLimit += additionalTransformationChances();
				outputText("As you admire the shiny jewel, you notice a flicker of energy flash across it, before a sudden jolt runs through your body! Letting out a howling moan, the jewel crumbles to dust as your body spasms in pleasure before the feeling subsides into dull ecstasy. You twitch and drool as something seems to be happening to your body...");
			}
			//Stats
			if (player.lib < 100 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou roll your tongue over your lips as residual tingles run all over your body. Your nipples are tight and your groin warmed with jolting pleasure. You growl as you feel hornier and hornier before the feeling ebbs. Part of you says you should be concerned by this turn of events, but there are <i>sooo</i> many cuties out there to molest!");
				dynStats("lib", 2);
				if (player.lib < 60) dynStats("lib", 2);
				changes++;
			}
			if (player.sens < 70 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour skin tingles with delight as every slight movement of the wind feels more distinct. Thoughts about how it would feel against your sexual spots slip into your mind before you can even stop them, and you start idly ");
					if (player.gender == 1 || player.gender == 3) outputText("stroking your [cock]");
					if (player.gender == 3) outputText(" and ");
					if (player.gender > 1) outputText("fingering your [clit]");
					outputText(". This is going to be fun.");
				dynStats("sen", 1);
				if (player.sens < 40) dynStats("sen", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual
			if (player.vaginas.length > 0 && player.breastRows[0].breastRating < 7 && changes < changeLimit && rand(3) == 0) {
				player.growTits(1 + rand(2), 1, false, 3);
				outputText("\n\nYou feel a surge of energy and heat deep in your [breasts]. They wobble and tingle before suddenly bursting forward, almost throwing you off balance. They jostle a bit before settling into their new size.");
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}
			//Physical
			var raiju_hair:Array = ["purple", "light blue", "yellow", "white"];
			if (!InCollection(player.hairColor, raiju_hair) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				player.hairColor = randomChoice(raiju_hair);
				outputText("\n\nYour hair stands up on end as bolts of lightning run through each strand, changing them to a <b>[haircolor] color!</b>");
			}
			if (player.lowerBody != LowerBody.RAIJU && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nYou have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidently hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>");
					setLowerBody(LowerBody.RAIJU);
				}
				else humanizeLowerBody();
				changes++;
			}
			if (player.lowerBody == LowerBody.RAIJU && player.arms.type != Arms.RAIJU && changes < changeLimit && rand(3) == 0) {
				if (player.arms.type == Arms.HUMAN) {
					outputText("\n\nYour nails tingle as they elongate into white claws! They look quite dangerous, but you feel the strange need to use them to stimulate your ");
					if (player.gender == 1 || player.gender == 3) outputText("[cock]");
					if (player.gender == 3) outputText(" and ");
					if (player.gender > 1) outputText("[clit]");
					outputText(". ");
					if (player.cor >= 50) outputText("You give a lusty smile, thinking that it wouldn't be so bad...");
					else outputText("You scowl, shaking away the impure thoughts.");
					setArmType(Arms.RAIJU);
				}
				else humanizeArms();
				changes++;
			}
			if (player.arms.type == Arms.RAIJU && player.tailType != Tail.RAIJU && changes < changeLimit && rand(3) == 0) {
				if (player.tailType == Tail.NONE) outputText("\n\nYou yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>");
				else outputText("\n\nYou nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out.  <b>You now have a silky Raiju tail!</b>");
				setTailType(Tail.RAIJU);
				changes++;
			}
			if (player.tailType == Tail.RAIJU && player.rearBody.type != RearBody.RAIJU_MANE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.");
				setRearBody(RearBody.RAIJU_MANE);
				changes++;
			}
			if (player.rearBody.type == RearBody.RAIJU_MANE && player.faceType != Face.RAIJU_FANGS && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nY");
				if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
				outputText("ou feel your two canines grow bigger and slightly sharper, not unlike those of a weasel or in your case a raiju. <b>You now have raiju canines.</b>");
				setFaceType(Face.RAIJU_FANGS);
				changes++;
			}
			if (player.faceType == Face.RAIJU_FANGS && player.ears.type != Ears.WEASEL && changes < changeLimit && rand(3) == 0) {
				if (player.ears.type == Ears.HUMAN) {
					outputText("\n\nYour ears twitch as jolt of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new weasel ears!</b>");
					setEarType(Ears.WEASEL);
				}
				else humanizeEars();
				changes++;
			}
			var raiju_eyes_color:Array = ["blue", "green", "teal"];
			if (player.ears.type == Ears.WEASEL && player.eyes.type != Eyes.RAIJU && changes < changeLimit && rand(3) == 0) {
				if (player.eyes.type == Eyes.HUMAN) {
					player.eyes.colour = randomChoice(raiju_eyes_color);
					outputText("\n\nBright lights flash into your vision as your eyes glow with electric light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>glowing [eyecolor] bestial slitted eyes staring back at you.</b>");
					setEyeType(Eyes.RAIJU);
				}
				else humanizeEyes();
				changes++;
			}
			if (player.hairType != 11 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nThe ends of your hair seem to split before a quick jolt smacks you in the back of the head. Irritated and confused, you rub the back of your head only to get a small zap in return. You wander over to a puddle and make note of several glowing strands of hair shaped like the typical stylized lightning bolt. There's even a single strand that floats just off the side of your face!");//<b></b>
				setHairType(Hair.STORM);
				changes++;
			}
			if (!player.skin.hasLightningShapedTattoo() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed)) {
					outputText("\n\n<b>Genetic Memory: Lighting Tattoed Skin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedLightningTattoed, 0, 0, 0, 0);
				}
				player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
				player.skin.base.adj = "lightning shaped tattooed";
				changes++;
			}
			if (player.hairType != 4 && player.hairLength < 26 && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				temp2 += 1 + rand(3);
				outputText("\n\nYour hair tingles as it grows longer, adding " + temp2 + " inches of length to your scalp.");
				player.hairLength += temp2;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function stormSeed(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 2;
			var temp2:Number = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("You eat up the seed and not to soon after let out a howling moan as your body spasms in pleasure before the feeling subsides into dull ecstasy. You twitch and drool as something seems to be happening to your body...");
			//Stats
			if (player.spe < 100 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.spe >= 75) outputText("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else outputText("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				//Speed gains diminish as it rises.
				if (player.spe < 40) dynStats("spe", .5);
				if (player.spe < 75) dynStats("spe", .5);
				dynStats("spe", .5);
			}
			if (player.tou > 50 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (rand(2) == 0) outputText("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.");
				else outputText("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more harpy-like in structure?");
				dynStats("tou", -1);
			}
			if (player.lib < 100 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou roll your tongue over your lips as residual tingles run all over your body. Your nipples are tight and your groin warmed with jolting pleasure. You growl as you feel hornier and hornier before the feeling ebbs. Part of you says you should be concerned by this turn of events, but there are <i>sooo</i> many cuties out there to molest!");
				dynStats("lib", 2);
				if (player.lib < 60) dynStats("lib", 2);
				changes++;
			}
			if (player.sens < 70 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour skin tingles with delight as every slight movement of the wind feels more distinct. Thoughts about how it would feel against your sexual spots slip into your mind before you can even stop them, and you start idly ");
					if (player.gender == 1 || player.gender == 3) outputText("stroking your [cock]");
					if (player.gender == 3) outputText(" and ");
					if (player.gender > 1) outputText("fingering your [clit]");
					outputText(". This is going to be fun.");
				dynStats("sen", 1);
				if (player.sens < 40) dynStats("sen", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.breastRows.length >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && player.breastRows.length == 1 && rand(3) == 0 && player.breastRows[0].breastRating >= 7 && !flags[kFLAGS.HYPER_HAPPY])
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (player.breastRows[0].breastRating < 19)
				{
					player.shrinkTits();
				}
				//(H+)
				else {
					player.breastRows[0].breastRating -= (4 + rand(4));
					outputText("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + player.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && player.breastRows[0].breastRating < 2 && rand(3) == 0) {
				changes++;
				outputText("\n\nYour chest starts to tingle, the [skin.type] warming under your [armor]. Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (player.breastRows[0].breastRating < 1) outputText("  <b>You have breasts now!</b>");
				player.breastRows[0].breastRating = 2;
			}//Physical
			var raiju_hair:Array = ["purple", "light blue", "yellow", "white"];
			if (!InCollection(player.hairColor, raiju_hair) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				player.hairColor = randomChoice(raiju_hair);
				outputText("\n\nYour hair stands up on end as bolts of lightning run through each strand, changing them to a <b>[haircolor] color!</b>");
			}
			//-Harpy legs
			if (player.lowerBody != LowerBody.HARPY && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				//(biped/taur)
				if (!player.isGoo()) outputText("\n\nYour [legs] creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your [feet] have changed.  ");
				//goo
				else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ");
				setLowerBody(LowerBody.HARPY);
				player.legCount = 2;
				changes++;
				//(cont)
				outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in [haircolor] feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>");
			}
			//-Propah Wings
			if (player.wings.type == Wings.NONE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>");
				setWingType(Wings.FEATHERED_LARGE, "large, feathered");
				changes++;
			}
			//-Remove old wings
			if (player.wings.type != Wings.FEATHERED_LARGE && player.wings.type > Wings.NONE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				removeWings();
				changes++;
			}
			//-Feathery Arms
			if (!InCollection(player.arms.type, Arms.GARGOYLE, Arms.HARPY) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou smile impishly as you lick the last bits of the seed from your teeth, but when you go to wipe your mouth, instead of the usual texture of your [skin.type] on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				setArmType(Arms.HARPY);
				changes++;
			}
			if (player.arms.type == Arms.HARPY && player.tailType != Tail.THUNDERBIRD && changes < changeLimit && rand(3) == 0) {
				if (player.tailType == Tail.NONE) outputText("\n\nYou yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming still before it fully fizzles out, <b>leaving you with a long sinuous bolt shaped thunderbird tail!</b>");
				else outputText("\n\nYou nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out.  <b>You now have a long sinuous bolt shaped thunderbird tail!</b>");
				setTailType(Tail.THUNDERBIRD);
				changes++;
			}
			if (player.tailType == Tail.THUNDERBIRD && player.rearBody.type != RearBody.RAIJU_MANE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.");
				setRearBody(RearBody.RAIJU_MANE);
				changes++;
			}
			if (player.rearBody.type == RearBody.RAIJU_MANE && player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour visage twists painfully, returning to a more normal human shape, albeit with flawless skin.  <b>Your face is human again!</b>");
				setFaceType(Face.HUMAN);
				changes++;
			}
			if (player.faceType == Face.HUMAN && player.ears.type != Ears.ELFIN && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.ears.type != Ears.HUMAN) {
				outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
				}
				else {
					outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
				}
				setEarType(Ears.ELFIN);
				changes++;
			}
			var raiju_eyes_color:Array = ["blue", "green", "teal"];
			if (player.ears.type == Ears.WEASEL && player.eyes.type != Eyes.RAIJU && changes < changeLimit && rand(3) == 0) {
				if (player.eyes.type == Eyes.HUMAN) {
					player.eyes.colour = randomChoice(raiju_eyes_color);
					outputText("\n\nBright lights flash into your vision as your eyes glow with electric light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>glowing [eyecolor] bestial slitted eyes staring back at you.</b>");
					setEyeType(Eyes.RAIJU);
				}
				else humanizeEyes();
				changes++;
			}
			if (player.hairType != 11 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nThe ends of your hair seem to split before a quick jolt smacks you in the back of the head. Irritated and confused, you rub the back of your head only to get a small zap in return. You wander over to a puddle and make note of several glowing strands of hair shaped like the typical stylized lightning bolt. There's even a single strand that floats just off the side of your face!");//<b></b>
				setHairType(Hair.STORM);
				changes++;
			}
			if (!player.skin.hasLightningShapedTattoo() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed)) {
					outputText("\n\n<b>Genetic Memory: Lighting Tattoed Skin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedLightningTattoed, 0, 0, 0, 0);
				}
				player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
				player.skin.base.adj = "lightning shaped tattooed";
				changes++;
			}
			if (player.hairType != 4 && player.hairLength < 26 && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				temp2 += 1 + rand(3);
				outputText("\n\nYour hair tingles as it grows longer, adding " + temp2 + " inches of length to your scalp.");
				player.hairLength += temp2;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function isabellaMilk(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You swallow down the bottle of Isabella's milk.");
			if (player.fatigue > 0) outputText("  You feel much less tired! (-33 fatigue)");
			fatigue(-33);
			player.refillHunger(20);
		}


//TF item - Shriveled Tentacle
//tooltip:
		public function shriveledTentacle(player:Player):void
		{
			clearOutput();
			outputText("You chew on the rubbery tentacle; its texture and taste are somewhat comparable to squid, but the half-dormant nematocysts cause your mouth to tingle sensitively.");
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//possible use effects:
			//- toughess up, sensitivity down
			if (rand(3) == 0 && player.tou < 50 && changes < changeLimit) {
				outputText("\n\nYour skin feels clammy and a little rubbery.  You touch yourself experimentally and notice that you can barely feel the pressure from your fingertips.  Consumed with curiosity, you punch yourself lightly in the arm; the most you feel is a dull throb!");
				dynStats("tou", 1, "sen", -1);
				changes++;
			}
			//- speed down
			if (rand(3) == 0 && player.spe > 40 && changes < changeLimit) {
				outputText("\n\nA pinprick sensation radiates from your stomach down to your knees, as though your legs were falling asleep.  Wobbling slightly, you stand up and take a few stumbling steps to work the blood back into them.  The sensation fades, but your grace fails to return and you stumble again.  You'll have to be a little more careful moving around for a while.");
				changes++;
				dynStats("spe", -1);
			}
			//- corruption increases by 1 up to low threshold (~20)
			if (rand(3) == 0 && player.cor < 20 && changes < changeLimit) {
				outputText("\n\nYou shiver, a sudden feeling of cold rushing through your extremities.");
				changes++;
				dynStats("cor", 1);
			}
			//-always increases lust by a function of sensitivity
			//"The tingling of the tentacle
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//physical changes:
			//- may randomly remove bee abdomen, if present; always checks and does so when any changes to hair might happen
			if (rand(4) == 0 && changes < changeLimit && player.tailType == Tail.BEE_ABDOMEN) {
				outputText("\n\nAs the gentle tingling of the tentacle's remaining venom spreads through your body, it begins to collect and intensify above the crack of your butt.  Looking back, you notice your abdomen shivering and contracting; with a snap, the chitinous appendage parts smoothly from your backside and falls to the ground.  <b>You no longer have a bee abdomen!</b>\n\n");
				setTailType(Tail.NONE);
				changes++;
			}
			//-may randomly remove bee wings:
			if (rand(4) == 0 && (player.wings.type == Wings.BEE_LIKE_SMALL || player.wings.type == Wings.BEE_LIKE_LARGE) && changes < changeLimit) {
				outputText("\n\nYour wings twitch and flap involuntarily.  You crane your neck to look at them as best you are able; from what you can see, they seem to be shriveling and curling up.  They're starting to look a lot like they did when they first popped out, wet and new.  <b>As you watch, they shrivel all the way, then recede back into your body.</b>");
				setWingType(Wings.NONE, "non-existent");
				changes++;
			}
			//-hair morphs to anemone tentacles, retains color, hair shrinks back to med-short('shaggy') and stops growing, lengthening treatments don't work and goblins won't cut it, but more anemone items can lengthen it one level at a time
			if (player.gills.type == Gills.ANEMONE && player.hairType != 4 && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nYour balance slides way off, and you plop down on the ground as mass concentrates on your head.  Reaching up, you give a little shriek as you feel a disturbingly thick, squirming thing where your hair should be.  Pulling it down in front of your eyes, you notice it's still attached to your head; what's more, it's the same color as your hair used to be.  <b>You now have squirming tentacles in place of hair!</b>  As you gaze at it, a gentle heat starts to suffuse your hand.  The tentacles must be developing their characteristic stingers!  You quickly let go; you'll have to take care to keep them from rubbing on your skin at all hours.  On the other hand, they're quite short and you find you can now flex and extend them as you would any other muscle, so that shouldn't be too hard.  You settle on a daring, windswept look for now.");
				setHairType(Hair.ANEMONE);
				player.hairLength = 5;
				if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
					outputText("  <b>(Your hair has stopped growing.)</b>");
					flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1;
				}
				changes++;
				changes++;
				changes++;
				//(reset hair to 'shaggy', add tentacle hair status, stop hair growth)
				//appearance screen: replace 'hair' with 'tentacle-hair'
			}
			//-feathery gills sprout from chest and drape sensually over nipples (cumulative swimming power boost with fin, if swimming is implemented)
			if (rand(5) == 0 && player.gills.type != Gills.ANEMONE && player.skinTone == "aphotic blue-black" && changes < changeLimit)
				updateGills(Gills.ANEMONE);
			//-[aphotic] skin tone (blue-black)
			if (rand(5) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.skinTone != "aphotic blue-black") {
				outputText("\n\nYou absently bite down on the last of the tentacle, then pull your hand away, wincing in pain.  How did you bite your finger so hard?  Looking down, the answer becomes obvious; <b>your hand, along with the rest of your skin, is now the same aphotic color as the dormant tentacle was!</b>");
				player.skinTone = "aphotic blue-black";
				changes++;
			}
			//-eat more, grow more 'hair':
			if (player.hairType == 4 && player.hairLength < 36 &&
					rand(2) == 0 && changes < changeLimit) {
				var gain:int = 5 + rand(3);
				player.hairLength += gain;
				outputText("\n\nAs you laboriously chew the rubbery dried anemone, your head begins to feel heavier.  Using your newfound control, you snake one of your own tentacles forward; holding it out where you can see it, the first thing you notice is that it appears quite a bit longer.  <b>Your head-tentacles are now " + num2Text(gain) + " inches longer!</b>");
				//(add one level of hairlength)
				changes++;
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//ITEMS START

		public function foxTF(enhanced:Boolean,player:Player):void
		{
			clearOutput();
			if (!enhanced) outputText("You examine the berry a bit, rolling the orangish-red fruit in your hand for a moment before you decide to take the plunge and chow down.  It's tart and sweet at the same time, and the flavors seem to burst across your tongue with potent strength.  Juice runs from the corners of your lips as you finish the tasty snack.");
			else outputText("You pop the cap on the enhanced \"Vixen's Vigor\" and decide to take a swig of it.  Perhaps it will make you as cunning as the crude fox Lumi drew on the front?");
			var changes:int = 0;
			var changeLimit:int = 1;
			if (enhanced) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Used for dick and boob TFs
			var counter:int = 0;

			if (player.faceType == Face.FOX && player.tailType == Tail.FOX && player.ears.type == Ears.FOX && player.lowerBody == LowerBody.FOX && player.hasFur() && rand(3) == 0 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				if (flags[kFLAGS.FOX_BAD_END_WARNING] == 0) {
					outputText("\n\nYou get a massive headache and a craving to raid a henhouse.  Thankfully, both pass in seconds, but <b>maybe you should cut back on the vulpine items...</b>");
					flags[kFLAGS.FOX_BAD_END_WARNING] = 1;
				}
				else {
					outputText("\n\nYou scarf down the ");
					if (enhanced) outputText("fluid ");
					else outputText("berries ");
					outputText("with an uncommonly voracious appetite, taking particular enjoyment in the succulent, tart flavor.  As you carefully suck the last drops of ochre juice from your fingers, you note that it tastes so much more vibrant than you remember.  Your train of thought is violently interrupted by the sound of bones snapping, and you cry out in pain, doubling over as a flaming heat boils through your ribs.");
					outputText("\n\nWrithing on the ground, you clutch your hand to your chest, looking on in horror through tear-streaked eyes as the bones in your fingers pop and fuse, rearranging themselves into a dainty paw covered in coarse black fur, fading to a ruddy orange further up.  You desperately try to call out to someone - anyone - for help, but all that comes out is a high-pitched, ear-splitting yap.");
					if (player.tailCount > 1) outputText("  Your tails thrash around violently as they begin to fuse painfully back into one, the fur bristling back out with a flourish.");
					outputText("\n\nA sharp spark of pain jolts through your spinal column as the bones shift themselves around, the joints in your hips migrating forward.  You continue to howl in agony even as you feel your intelligence slipping away.  In a way, it's a blessing - as your thoughts grow muddied, the pain is dulled, until you are finally left staring blankly at the sky above, tilting your head curiously.");
					outputText("\n\nYou roll over and crawl free of the [armor] covering you, pawing the ground for a few moments before a pang of hunger rumbles through your stomach.  Sniffing the wind, you bound off into the wilderness, following the telltale scent of a farm toward the certain bounty of a chicken coop.");
					EventParser.gameOver();
					return;
				}
			}
			//[increase Intelligence, Libido and Sensitivity]
			if (changes < changeLimit && rand(3) == 0 && (player.lib < 80 || player.inte < 80 || player.sens < 80)) {
				outputText("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental picture of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				if (player.inte < 80) dynStats("int", 4);
				if (player.lib < 80) dynStats("lib", 1);
				if (player.sens < 80) dynStats("sen", 1);
				//gain small lust also
				dynStats("lus", 10);
				changes++;
			}
			//[decrease Strength] (to some floor) // I figured 15 was fair, but you're in a better position to judge that than I am.
			if (changes < changeLimit && rand(3) == 0 && player.str > 40) {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				dynStats("str", -1);
				if (player.str > 60) dynStats("str", -1);
				if (player.str > 80) dynStats("str", -1);
				if (player.str > 90) dynStats("str", -1);
				changes++;
			}
			//[decrease Toughness] (to some floor) // 20 or so was my thought here
			if (changes < changeLimit && rand(3) == 0 && player.tou > 30) {
				if (player.tou < 60) outputText("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your supple skin isn't going to offer you much protection.");
				else outputText("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				dynStats("tou", -1);
				if (player.tou > 60) dynStats("tou", -1);
				if (player.tou > 80) dynStats("tou", -1);
				if (player.tou > 90) dynStats("tou", -1);
				changes++;
			}

			//[Change Hair Color: Golden-blonde or Reddish-orange]
			var fox_hair:Array = ["golden blonde", "reddish-orange", "silver", "white", "red", "black"];
			if (!InCollection(player.hairColor, fox_hair) && !InCollection(player.hairColor, KitsuneScene.basicKitsuneHair) && !InCollection(player.hairColor, KitsuneScene.elderKitsuneColors) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				if (player.tailType == Tail.FOX && player.tailCount > 1)
					if(player.tailCount < 9) player.hairColor = randomChoice(KitsuneScene.basicKitsuneHair);
					else player.hairColor = randomChoice(KitsuneScene.elderKitsuneColors);
				else player.hairColor = randomChoice(fox_hair);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!");
			}
			//[Adjust hips toward 10 – wide/curvy/flared]
			if (changes < changeLimit && rand(3) == 0 && player.hips.type != 10) {
				//from narrow to wide
				if (player.hips.type < 10) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has widened into [hips]!");
					player.hips.type++;
					if (player.hips.type < 7) player.hips.type++;
				}
				//from wide to narrower
				else {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has narrowed, becoming [hips].");
					player.hips.type--;
					if (player.hips.type > 15) player.hips.type--;
				}
				changes++;
			}
			//[Remove tentacle hair]
			//required if the hair length change below is triggered
			if (changes < changeLimit && player.hairType == 4 && rand(3) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nEerie flames of the jewel migrate up your body to your head, where they cover your [hair].  Though they burned nowhere else in their lazy orbit, your head begins to heat up as they congregate.  Fearful, you raise your hands to it just as the temperature peaks, but as you touch your hair, the searing heat is suddenly gone - along with your tentacles!  <b>Your hair is normal again!</b>");
				setHairType(Hair.NORMAL);
				changes++;
			}
			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if (player.hairType != 4 && (player.hairLength > 26 || player.hairLength < 16) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				if (player.hairLength < 16) {
					player.hairLength += 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				else {
					player.hairLength -= 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				changes++;
			}
			if (changes < changeLimit && rand(10) == 0) {
				outputText("\n\nYou sigh as the exotic flavor washes through you, and unbidden, you begin to daydream.  Sprinting through the thicket, you can feel the corners of your muzzle curling up into a mischievous grin.  You smell the scent of demons, and not far away either.  With your belly full and throat watered, now is the perfect time for a little bit of trickery.   As the odor intensifies, you slow your playful gait and begin to creep a bit more carefully.");
				outputText("\n\nSuddenly, you are there, at a demonic camp, and you spy the forms of an incubus and a succubus, their bodies locked together at the hips and slowly undulating, even in sleep.  You carefully prance around their slumbering forms and find their supplies.  With the utmost care, you put your razor-sharp teeth to work, and slowly, meticulously rip through their packs - not with the intention of theft, but with mischief.  You make sure to leave small holes in the bottom of each, and after making sure your stealth remains unbroken, you urinate on their hooves.");
				outputText("\n\nThey don't even notice, so lost in the subconscious copulation as they are.  Satisfied at your petty tricks, you scurry off into the night, a red blur amidst the foliage.");
				changes++;
				fatigue(-10);
			}

			//fox cocks!
			if (changes < changeLimit && rand(3) == 0 && player.foxCocks() < player.cocks.length) {
				var choices:Array = [];
				counter = player.cockTotal();
				while (counter > 0) {
					counter--;
					//Add non-dog locations to the array
					if (player.cocks[counter].cockType != CockTypesEnum.FOX) choices[choices.length] = counter;
				}
				if (choices.length != 0) {
					var select:int = choices[rand(choices.length)];
					if (player.cocks[select].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + cockDescript(select) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a vulpine-looking sheath.  You shudder as the crown of your " + cockDescript(select) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your " + Appearance.cockNoun(CockTypesEnum.FOX) + " much thicker than it ever was before.  <b>You now have a fox-cock.</b>");
						player.cocks[select].cockThickness += .3;
						dynStats("sen", 10, "lus", 5);
					}
					//Horse
					else if (player.cocks[select].cockType == CockTypesEnum.HORSE) {
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a fox-cock.</b>");
						//Tweak length/thickness.
						if (player.cocks[select].cockLength > 6) player.cocks[select].cockLength -= 2;
						else player.cocks[select].cockLength -= .5;
						player.cocks[select].cockThickness += .5;

						dynStats("sen", 4, "lus", 5);
					}
					//Tentacular Tuesday!
					else if (player.cocks[select].cockType == CockTypesEnum.TENTACLE) {
						outputText("\n\nYour " + cockDescript(select) + " coils in on itself, reshaping and losing its plant-like coloration as thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a fox-cock.</b>");
						dynStats("sen", 4, "lus", 10);
					}
					//Misc
					else {
						outputText("\n\nYour " + cockDescript(select) + " trembles, reshaping itself into a shiny red fox-shaped dick with a fat knot at the base.  <b>You now have a fox-cock.</b>");
						dynStats("sen", 4, "lus", 10);
					}
					player.cocks[select].cockType = CockTypesEnum.FOX;
					player.cocks[select].knotMultiplier = 1.25;
					changes++;
				}

			}
			//Cum Multiplier Xform
			if (player.cumQ() < 5000 && rand(3) == 0 && changes < changeLimit && player.hasCock()) {
				var mult:int = 2 + rand(4);
				//Lots of cum raises cum multiplier cap to 2 instead of 1.5
				if (player.findPerk(PerkLib.MessyOrgasms) >= 0) mult += rand(10);
				player.cumMultiplier += mult;
				//Flavor text
				if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
				if (player.balls > 0) outputText("\n\nYou feel a churning in your [balls].  It quickly settles, leaving them feeling somewhat more dense.");
				outputText("  A bit of milky pre dribbles from your [cocks], pushed out by the change.");
				changes++;
			}
			if (changes < changeLimit && player.balls > 0 && player.ballSize > 4 && rand(3) == 0) {
				outputText("\n\nYour [sack] gets lighter and lighter, the skin pulling tight around your shrinking balls until you can't help but check yourself.");
				if (player.ballSize > 10) player.ballSize -= 5;
				if (player.ballSize > 20) player.ballSize -= 4;
				if (player.ballSize > 30) player.ballSize -= 4;
				if (player.ballSize > 40) player.ballSize -= 4;
				if (player.ballSize > 50) player.ballSize -= 8;
				if (player.ballSize > 60) player.ballSize -= 8;
				if (player.ballSize <= 10) player.ballSize--;
				changes++;
				outputText("  You now have a [balls].");
			}
			//Sprouting more!
			if (changes < changeLimit && enhanced && player.bRows() < 4 && player.breastRows[player.bRows() - 1].breastRating > 1) {
				outputText("\n\nYour belly rumbles unpleasantly for a second as the ");
				if (!enhanced) outputText("berry ");
				else outputText("drink ");
				outputText("settles deeper inside you.  A second later, the unpleasant gut-gurgle passes, and you let out a tiny burp of relief.  Before you finish taking a few breaths, there's an itching below your " + allChestDesc() + ".  You idly scratch at it, but gods be damned, it hurts!  You peel off part of your [armor] to inspect the unwholesome itch, ");
				if (player.biggestTitSize() >= 8) outputText("it's difficult to see past the wall of tits obscuring your view.");
				else outputText("it's hard to get a good look at.");
				outputText("  A few gentle prods draw a pleasant gasp from your lips, and you realize that you didn't have an itch - you were growing new nipples!");
				outputText("\n\nA closer examination reveals your new nipples to be just like the ones above in size and shape");
				if (player.breastRows[player.bRows() - 1].nipplesPerBreast > 1) outputText(", not to mention number");
				else if (player.hasFuckableNipples()) outputText(", not to mention penetrability");
				outputText(".  While you continue to explore your body's newest addition, a strange heat builds behind the new nubs. Soft, jiggly breastflesh begins to fill your cupped hands.  Radiant warmth spreads through you, eliciting a moan of pleasure from your lips as your new breasts catch up to the pair above.  They stop at " + player.breastCup(player.bRows() - 1) + "s.  <b>You have " + num2Text(player.bRows() + 1) + " rows of breasts!</b>");
				player.createBreastRow();
				player.breastRows[player.bRows() - 1].breastRating = player.breastRows[player.bRows() - 2].breastRating;
				player.breastRows[player.bRows() - 1].nipplesPerBreast = player.breastRows[player.bRows() - 2].nipplesPerBreast;
				if (player.hasFuckableNipples()) player.breastRows[player.bRows() - 1].fuckable = true;
				player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
				dynStats("sen", 2, "lus", 30);
				changes++;
			}
			//Find out if tits are eligible for evening
			var tits:Boolean = false;
			counter = player.bRows();
			while (counter > 1) {
				counter--;
				//If the row above is 1 size above, can be grown!
				if (player.breastRows[counter].breastRating <= (player.breastRows[counter - 1].breastRating - 1) && changes < changeLimit && rand(2) == 0) {
					if (tits) outputText("\n\nThey aren't the only pair to go through a change!  Another row of growing bosom goes through the process with its sisters, getting larger.");
					else {
						var select2:Number = rand(3);
						if (select2 == 1) outputText("\n\nA faint warmth buzzes to the surface of your " + breastDescript(counter) + ", the fluttering tingles seeming to vibrate faster and faster just underneath your [skin].  Soon, the heat becomes uncomfortable, and that row of chest-flesh begins to feel tight, almost thrumming like a newly-stretched drum.  You " + nippleDescript(counter) + "s go rock hard, and though the discomforting feeling of being stretched fades, the pleasant, warm buzz remains.  It isn't until you cup your tingly tits that you realize they've grown larger, almost in envy of the pair above.");
						else if (select2 == 2) outputText("\n\nA faintly muffled gurgle emanates from your " + breastDescript(counter) + " for a split-second, just before your flesh shudders and shakes, stretching your " + player.skinFurScales() + " outward with newly grown breast.  Idly, you cup your hands to your swelling bosom, and though it stops soon, you realize that your breasts have grown closer in size to the pair above.");
						else {
							outputText("\n\nAn uncomfortable stretching sensation spreads its way across the curves of your " + breastDescript(counter) + ", threads of heat tingling through your flesh.  It feels as though your heartbeat has been magnified tenfold within the expanding mounds, your [skin] growing flushed with arousal and your " + nippleDescript(counter) + " filling with warmth.  As the tingling heat gradually fades, a few more inches worth of jiggling breast spill forth.  Cupping them experimentally, you confirm that they have indeed grown to be a bit more in line with the size of the pair above.")
						}
					}
					//Bigger change!
					if (player.breastRows[counter].breastRating <= (player.breastRows[counter - 1].breastRating - 3))
						player.breastRows[counter].breastRating += 2 + rand(2);
					//Smallish change.
					else player.breastRows[counter].breastRating++;
					outputText("  You do a quick measurement and determine that your " + num2Text2(counter + 1) + " row of breasts are now " + player.breastCup(counter) + "s.");

					if (!tits) {
						tits = true;
						changes++;
					}
					dynStats("sen", 2, "lus", 10);
				}
			}
			//HEAT!
			if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(6) == 0 && changes < changeLimit) {
				if(player.goIntoHeat(true)) {
						changes++;
				}
			}
			//[Grow Fur]
			//FOURTH
			if ((enhanced || player.lowerBody == LowerBody.FOX) && !player.hasFur() && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				//from scales
				if (player.hasScales()) outputText("\n\nYour skin shifts and every scale stands on end, sending you into a mild panic.  No matter how you tense, you can't seem to flatten them again.  The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out.  You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old.  <b>Oh well; at least you won't need to sun yourself as much with your new fur.</b>");
				//from skin
				else outputText("\n\nYour skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch.  As you hold still through an agony of tiny tingles and pinches, fine, luxuriant fur sprouts from every bare inch of your skin!  <b>You'll have to get used to being furry...</b>");
				player.skin.growCoat(Skin.FUR);
				if (player.kitsuneScore() >= 4)
					if(InCollection(player.hairColor, KitsuneScene.basicKitsuneFur) || InCollection(player.hairColor, KitsuneScene.elderKitsuneColors)) {
						player.skin.coat.color = player.hairColor;
					} else
						if (player.tailType == Tail.FOX && player.tailCount == 9)
							player.skin.coat.color = randomChoice(KitsuneScene.elderKitsuneColors);
						else
							player.skin.coat.color = randomChoice(KitsuneScene.basicKitsuneFur);
				else {
					// TODO patterns
					player.skin.coat.color = randomChoice("orange and white", "orange and white", "orange and white", "red and white", "black and white", "white", "tan", "brown");
				}
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//[Grow Fox Legs]
			//THIRD
			if ((enhanced || player.ears.type == Ears.FOX) && player.lowerBody != LowerBody.FOX && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(5) == 0) {
				//4 legs good, 2 legs better
				if (player.isTaur()) outputText("\n\nYou shiver as the strength drains from your back legs.  Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over;  their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides.  A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations.  When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be.  <b>You now have fox legs!</b>");
				//n*ga please
				else if (player.isNaga()) outputText("\n\nYour scales split at the waistline and begin to peel, shedding like old snakeskin.  If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal.  As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin.  Within minutes, it crumbles completely and is taken by the ever-moving wind.  <b>Your legs are now those of a fox!</b>");
				//other digitigrade
				else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO)
					outputText("\n\nYour legs twitch and quiver, forcing you to your seat.  As you watch, the ends shape themselves into furry, padded toes.  <b>You now have fox feet!</b>  Rather cute ones, actually.");
				//red drider bb gone
				else if (player.lowerBody == LowerBody.DRIDER) outputText("\n\nYour legs buckle under you and you fall, smashing your abdomen on the ground.  Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves.  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible.  When you try to part them, you find you cannot.  Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>");
				//goo home and goo to bed
				else if (player.isGoo()) outputText("\n\nIt takes a while before you notice that your gooey mounds have something more defined in them.  As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg.  You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot.  The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>");
				//reg legs, not digitigrade
				else {
					outputText("\n\nYour hamstrings tense painfully and begin to pull, sending you onto your face.  As you writhe on the ground, you can feel your thighs shortening and your feet stretching");
					if (player.lowerBody == LowerBody.BEE) outputText(", while a hideous cracking fills the air");
					outputText(".  When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>");
				}
				setLowerBody(LowerBody.FOX);
				player.legCount = 2;
				changes++;
			}
			//Grow Fox Arms
			if (changes < changeLimit && player.arms.type == Arms.HUMAN && player.arms.type != Arms.FOX && player.lowerBody != LowerBody.GARGOYLE && rand(2) == 0) {
				outputText("\n\nYour arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>");
				setArmType(Arms.FOX);
				changes++;
			}
			//Grow Fox Ears]
			//SECOND
			if ((enhanced || player.tailType == Tail.FOX) && player.ears.type != Ears.FOX && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				//from human/gob/liz ears
				if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) {
					outputText("\n\nThe sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  <b>You now have fox ears.</b>");
				}
				//from dog/cat/roo ears
				else {
					outputText("\n\nYour ears change, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
				}
				setEarType(Ears.FOX);
				changes++;
			}
			//[Grow Fox Tail](fairly common)
			//FIRST
			if (player.tailType != Tail.FOX && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				//from no tail
				if (player.tailType == Tail.NONE) outputText("\n\nA pressure builds on your backside.  You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own.  <b>You now have a fox's tail!</b>");
				//from another type of tail
				else outputText("\n\nPain lances through your lower back as your tail shifts violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox's tail!</b>");
				setTailType(Tail.FOX,1);
				changes++;
			}
			//[Grow Fox Face]
			//LAST - muzzlygoodness
			//should work from any face, including other muzzles
			if (player.tailType == Tail.FOX && player.faceType != Face.FOX && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour face pinches and you clap your hands to it.  Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror.  <b>Looks like you now have a fox's face.</b>");
				if (silly()) outputText("  And they called you crazy...");
				setFaceType(Face.FOX);
				changes++;
			}
			//Fox Eyes
			if (player.faceType == Face.FOX && player.eyes.type != Eyes.FOX && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your eyes shifted to look more fox-like in a fashion similar to the kitsunes.  <b>You now have fox eyes.</b>");
				setEyeType(Eyes.FOX);
				changes++;
			}
			if (player.tone > 40 && changes < changeLimit && rand(2) == 0) {
				outputText("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				player.tone -= 4;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && (player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nWell that didn't do much, but you do feel a little refreshed!");
				fatigue(-5);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function godMead(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You take a hearty swig of mead, savoring the honeyed taste on your tongue.  Emboldened by the first drink, you chug the remainder of the horns's contents in no time flat.  You wipe your lips, satisfied, and let off a small belch as you toss the empty horns aside.  ");

			//Libido: No desc., always increases.
			//Corruption: No desc., always decreases.
			dynStats("lib", 2, "cor", -2);
			//Health/HP(Large increase; always occurs):
			outputText("\n\nYou feel suddenly invigorated by the potent beverage, like you could take on a whole horde of barbarians or giants and come out victorious! ");
			HPChange(Math.round(player.maxHP() * .25), true);
			if (rand(3) == 0) {
				outputText("\n\nThe alcohol fills your limbs with vigor, making you feel like you could take on the world with just your fists!");
				if (silly()) outputText("  Maybe you should run around shirtless, drink, and fight!  Saxton Hale would be proud.");
				dynStats("str", 2);
			}
			//Tough:
			else {
				outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				dynStats("tou", 2);
			}
			//Grow Beard [ONLY if PC has a masculine face & a dick.)( -- Why? Bearded ladies are also a fetish [That's just nasty.] (I want a lady beard)): A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. You now sport a fine [player.HairColor] beard!
			if (rand(6) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.beardLength < 4) {
				if (player.beardLength <= 0) outputText("A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. <b>You now sport a fine [haircolor] beard!</b>");
				else outputText("\n\nA sudden tingling runs along your chin. You stroke your beard proudly as it slowly grows in length and lustre.");
				player.beardLength += 0.5;
			}
			//Grow hair: Your scalp is beset by pins and needles as your hair grows out, stopping after it reaches [medium/long] length.}
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			player.refillHunger(20);
		}

		public function proMead(player:Player):void
		{
			clearOutput();
			outputText("You take a hearty swig of mead, savoring the honeyed taste on your tongue.  Emboldened by the first drink, you chug the remainder of the horns's contents in no time flat.  You wipe your lips, satisfied, and let off a small belch as you toss the empty horns aside.");

			//Libido: No desc., always increases.
			//Corruption: No desc., always decreases.
			dynStats("lib", 10, "cor", -10);
			//Health/HP(Large increase; always occurs):
			outputText("\n\nYou feel suddenly invigorated by the potent beverage, like you could take on a whole horde of barbarians or giants and come out victorious!");
			HPChange(Math.round(player.maxHP()), false);
			dynStats("lus=", 50 + rand(16));
			if (rand(3) == 0) {
				outputText("\n\nThe alcohol fills your limbs with vigor, making you feel like you could take on the world with just your fists!");
				if (silly()) outputText("  Maybe you should run around shirtless, drink, and fight!  Saxton Hale would be proud.");
				dynStats("str", 10);
			}
			//Tough:
			else {
				outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				dynStats("tou", 10);
			}
			//Grow Beard [ONLY if PC has a masculine face & a dick.)( -- Why? Bearded ladies are also a fetish [That's just nasty.] (I want a lady beard)): A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. You now sport a fine [player.HairColor] beard!
			if (rand(6) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.beardLength < 6) {
				if (player.beardLength <= 0) outputText("A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. <b>You now sport a fine [haircolor] beard!</b>");
				else outputText("\n\nA sudden tingling runs along your chin. You stroke your beard proudly as it slowly grows in length and lustre.");
				player.beardLength += 0.5;
			}
			//Grow hair: Your scalp is beset by pins and needles as your hair grows out, stopping after it reaches [medium/long] length.}
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			player.refillHunger(80);
		}

		public function sheepMilk(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You gulp the bottle's contents, and its sweet taste immediately invigorates you, making you feel calm and concentrated");
			//-60 fatigue, -2 libido, -20 lust]
			fatigue(-180);
			dynStats("lib", -1, "lus", -90, "cor", -2);
			player.refillHunger(40);
		}

		public function springWater(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("The water is cool and sweet to the taste, and every swallow makes you feel calmer, cleaner, and refreshed.  You drink until your thirst is quenched, feeling purer in both mind and body. ");
			//-30 fatigue, -2 libido, -10 lust]
			fatigue(-40);
			dynStats("lus", -100, "cor", (-4 - rand(3)), "scale", false);
			HPChange(100 + (10 * player.level) + rand(10 * player.level), true);
			player.refillHunger(30);
			if(player.cor > 50) dynStats("cor", -2);
			if(player.cor > 75) dynStats("cor", -2);
		}
		
		public function akbalSaliva(player:Player):void
		{
			outputText("You uncork the vial and chug down the saliva.  ");
			HPChange((player.maxHP() / 4), true);
			player.refillHunger(5);
		}
		
		//Item: Dragon Egg (Z) (FEN CODED TO HERE - OR AT LEAST COPIED INTO THE CODE FOR FUTURE CODING)
		//Itemdescription - "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches."
		public function eatEmberEgg(player:Player):void
		{
			clearOutput();
			//Effect:
			//Boosts the special effect of Dragonbreath by 20% for 1 use. ie: if Tainted's breath weapon has a 80% chance to stun on hit, +20% equals 100% chance to stun.
			outputText("You crack the shell easily and swallow the large yolk and the copious amounts of albumen - the yolk is blue, while the rest is crimson-tinted.  It tastes like... well, it tastes mostly of spiced mint, you think.");
			if (player.findPerk(PerkLib.DragonFireBreath) >= 0 || player.findPerk(PerkLib.DragonIceBreath) >= 0 || player.findPerk(PerkLib.DragonLightningBreath) >= 0 || player.findPerk(PerkLib.DragonDarknessBreath) >= 0) {
				var changes:int = 0;
				var changeLimit:int = 1;
				if (!player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && !player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && !player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && !player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && !player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.hasStatusEffect(StatusEffects.DragonBreathBoost) && changes < changeLimit) {
					player.createStatusEffect(StatusEffects.DragonBreathBoost, 0, 0, 0, 0);
					changes++;
				}
				if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && changes < changeLimit) {
					player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
					changes++;
				}
				if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && changes < changeLimit) {
					player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
					changes++;
				}
				if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && changes < changeLimit) {
					player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
					changes++;
				}
				if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && changes < changeLimit) {
					player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
					changes++;
				}
				if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && changes < changeLimit) {
					player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
					changes++;
				}
				outputText("\n\nA sudden surge of energy fills your being and you feel like you could blast anything to atoms with a single breath, like the mighty dragons of legends.");
			}
			fatigue(-20);
			player.refillHunger(50);
		}


//Inventory Description:
//9999A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.
//Fox Jewel (Magatama)

//Consume:
		public function foxJewel(mystic:Boolean,player:Player):void
		{
			clearOutput();
			mutationStart("foxJewel" + (mystic ? "M" : ""), 3);
			changeLimit += additionalTransformationChances();
			if (mystic) changeLimit += 2;
			if (mystic) outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie purple flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale lavender flames swirl around you, the air is filled with a sickly sweet scent that drips with the bitter aroma of licorice, filling you with a dire warmth.");
			else outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie blue flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale azure flames swirl around you, the air is filled with a sweet scent that drips with the aroma of wintergreen, sending chills down your spine.");

			//**********************
			//BASIC STATS
			//**********************
			//[increase Intelligence, Libido and Sensitivity]
			mutationStep(player.inte < 100, mystic ? 2 : 4, function ():void {
				outputText("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental image of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				//Raise INT, Lib, Sens. and +10 LUST
				dynStats("int", 2, "lib", 1, "sen", 2, "lus", 10);
			});
			//[decrease Strength toward 15]
			mutationStep(player.str > 15, mystic ? 2 : 3, function ():void {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				dynStats("str", -1);
				if (player.str > 70) dynStats("str", -1);
				if (player.str > 50) dynStats("str", -1);
				if (player.str > 30) dynStats("str", -1);
			});
			//[decrease Toughness toward 20]
			mutationStep(player.tou > 20, mystic ? 2 : 3, function ():void {
				//from 66 or less toughness
				if (player.tou <= 66) outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your " + player.skinFurScales() + " won't offer you much protection.");
				//from 66 or greater toughness
				else outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				dynStats("tou", -1);
				if (player.tou > 66) dynStats("tou", -1);
			});
			mutationStep(mystic && player.cor < 100, 2, function ():void {
				if (player.cor < 33) outputText("\n\nA sense of dirtiness comes over you, like the magic of this gem is doing some perverse impropriety to you.");
				else if (player.cor < 66) outputText("\n\nA tingling wave of sensation rolls through you, but you have no idea what exactly just changed.  It must not have been that important.");
				else outputText("\n\nThoughts of mischief roll across your consciousness, unbounded by your conscience or any concern for others.  You should really have some fun - who cares who it hurts, right?");
				dynStats("cor", 1);
			});


			//**********************
			//MEDIUM/SEXUAL CHANGES
			//**********************
			//[adjust Femininity toward 50]
			//from low to high
			//Your facial features soften as your body becomes more androgynous.
			//from high to low
			//Your facial features harden as your body becomes more androgynous.
			mutationStep(player.femininity != 50, mystic?2:4, function(): void {
				outputText(player.modFem(50, 2));
			});
			//[decrease muscle tone toward 40]
			mutationStep(player.tone >= 40, mystic?2:4, function(): void {
				outputText("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				player.tone -= 2 + rand(3);
			});

			//[Adjust hips toward 10 – wide/curvy/flared]
			//from narrow to wide
			mutationStep(player.hips.type < 10, mystic?2:3, function ():void {
				player.hips.type++;
				if (player.hips.type < 7) player.hips.type++;
				if (player.hips.type < 4) player.hips.type++;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have widened nicely!");
			});
			//from wide to narrower
			mutationStep(player.hips.type > 10, mystic?2:3, function ():void {
				player.hips.type--;
				if (player.hips.type > 14) player.hips.type--;
				if (player.hips.type > 19) player.hips.type--;
				if (player.hips.type > 24) player.hips.type--;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have narrowed.");
			});

			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			mutationStep((player.hairLength < 16 || player.hairLength > 26) && player.lowerBody != LowerBody.GARGOYLE, mystic ? 2 : 3, function():void {
				//from short to long
				if (player.hairLength < 16) {
					player.hairLength += 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming [hair].");
				}
				//from long to short
				else {
					player.hairLength -= 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming [hair].");
				}
			});
			//[Increase Vaginal Capacity] - requires vagina, of course
			mutationStep(player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 200, mystic?2:3, function(): void {
				outputText("\n\nA gurgling sound issues from your abdomen, and you double over as a trembling ripple passes through your womb.  The flesh of your stomach roils as your internal organs begin to shift, and when the sensation finally passes, you are instinctively aware that your [vagina] is a bit deeper than it was before.");
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) {
					player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				}
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5 + rand(10));
			});
			//[Vag of Holding] - rare effect, only if PC has high vaginal looseness
			mutationStep(player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) >= 200 && player.statusEffectv1(StatusEffects.BonusVCapacity) < 8000, mystic?1:5, function(): void{
				outputText("\n\nYou clutch your stomach with both hands, dropping to the ground in pain as your internal organs begin to twist and shift violently inside you.  As you clench your eyes shut in agony, you are overcome with a sudden calm.  The pain in your abdomen subsides, and you feel at one with the unfathomable infinity of the universe, warmth radiating through you from the vast swirling cosmos contained within your womb.");
				if (silly()) outputText("  <b>Your vagina has become a universe unto itself, capable of accepting colossal insertions beyond the scope of human comprehension!</b>");
				else outputText("  <b>Your vagina is now capable of accepting even the most ludicrously sized insertions with no ill effects.</b>");
				player.changeStatusValue(StatusEffects.BonusVCapacity, 1, 8000);
			});


			//**********************
			//BIG APPEARANCE CHANGES
			//**********************
			//[Grow Fox Tail]
			mutationStep(player.tailType != Tail.FOX && player.lowerBody != LowerBody.GARGOYLE, mystic ? 2 : 4, function():void {
				//if PC has no tail
				if (player.tailType == Tail.NONE) {
					outputText("\n\nA pressure builds on your backside.  You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it has a mind of its own.  <b>You now have a fox-tail.</b>");
				}
				//if PC has another type of tail
				else if (player.tailType != Tail.FOX) {
					outputText("\n\nPain lances through your lower back as your tail shifts and twitches violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox-tail.</b>");
				}
				setTailType(Tail.FOX, 1);
			});
			var nFoxTails:int = (player.ears.type == Ears.FOX && player.tailType == Tail.FOX) ? player.tailCount : 0;
			if (nFoxTails == 8 && !mystic && rand(3) == 0) {
				outputText("\n\nYou have the feeling that if you could grow a ninth tail you would be much more powerful, but you would need to find a way to enhance one of these gems or meditate with one to have a chance at unlocking your full potential.");
			}
			//[Grow Addtl. Fox Tail]
			//(rare effect, up to max of 8 tails, requires PC level and int*10 = number of tail to be added)
			mutationStep(nFoxTails == 1 && player.inte >= 15 && player.wis >= 15, mystic ? 2 : 3, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
				setTailType(Tail.FOX, 2);
			});
			mutationStep(nFoxTails == 2 && player.level >= 6 && player.inte >= 30 && player.wis >= 30, mystic ? 2 : 3, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				setTailType(Tail.FOX, 3);
			});
			mutationStep(nFoxTails == 3 && player.level >= 12 && player.inte >= 45 && player.wis >= 45, mystic ? 2 : 3, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				setTailType(Tail.FOX, 4);
			});
			mutationStep(nFoxTails == 4 && player.level >= 18 && player.inte >= 60 && player.wis >= 60, mystic ? 2 : 3, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				setTailType(Tail.FOX, 5);
			});
			mutationStep(nFoxTails == 5 && player.level >= 24 && player.inte >= 75 && player.wis >= 75, mystic ? 2 : 3, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				setTailType(Tail.FOX, 6);
			});
			mutationStep(nFoxTails == 6 && player.level >= 30 && player.inte >= 90 && player.wis >= 90 && (player.findPerk(PerkLib.EnlightenedKitsune) < 0 || player.perkv4(PerkLib.EnlightenedKitsune) > 0) && (player.findPerk(PerkLib.EnlightenedNinetails) < 0 || player.perkv4(PerkLib.EnlightenedNinetails) > 0), mystic ? 1 : 3, function(): void {
				if (player.findPerk(PerkLib.CorruptedKitsune) < 0) {
					outputText("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into seven tails.  <b>You are now a seven-tails!  But something is wrong...  The cosmic power radiating from your body feels...  tainted somehow.  The corruption pouring off your body feels...  good.</b>");
					outputText("\n\n(Perk Gained: Corrupted Kitsune - Grants Corrupted Fox Fire and Terror special attacks.)");
					player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
					dynStats("lib", 1, "lus", 5, "cor", 5);
				}
				else outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				player.tailCount = 7;
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) {
					outputText("\n\n<b>Genetic Memory: 7th Fox Tail - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFoxTail7th, 0, 0, 0, 0);
				}
			});
			mutationStep(nFoxTails == 7 && player.level >= 36 && player.inte >= 105 && player.wis >= 105 && (player.findPerk(PerkLib.EnlightenedKitsune) < 0 || player.perkv4(PerkLib.EnlightenedKitsune) > 0) && (player.findPerk(PerkLib.EnlightenedNinetails) < 0 || player.perkv4(PerkLib.EnlightenedNinetails) > 0), mystic ? 1 : 4, function(): void {
				outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				player.tailCount++;
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) {
					outputText("\n\n<b>Genetic Memory: 8th Fox Tail - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFoxTail8th, 0, 0, 0, 0);
				}
			});
			//[Grow 9th tail and gain Corrupted Nine-tails perk]
			mutationStep(nFoxTails == 8 && player.level >= 42 && player.inte >= 120 && player.wis >= 120 && (player.findPerk(PerkLib.EnlightenedNinetails) < 0 || player.perkv4(PerkLib.EnlightenedNinetails) > 0), mystic ? 1 : 4, function(): void {
				if (player.findPerk(PerkLib.CorruptedNinetails) < 0) {
					outputText("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into nine tails.  <b>You are now a nine-tails!  But something is strange...  The cosmic power radiating from your body feels...  somehow more tainted than before.  The corruption pouring off your body feels...  amazing good.</b>");
					outputText("\n\nYou have the inexplicable urge to set fire to the world, just to watch it burn.  With your newfound power, it's a goal that is well within reach.");
					outputText("\n\n(Perk Gained: Corrupted Nine-tails - Grants boosts to your racial special attacks.)");
					player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
					dynStats("lib", 2, "lus", 10, "cor", 10);
				}
				else outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
				player.tailCount = 9;
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) {
					outputText("\n\n<b>Genetic Memory: 9th Fox Tail - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFoxTail9th, 0, 0, 0, 0);
				}

			});
			//Fox Eyes
			mutationStep(player.ears.type == Ears.FOX && player.eyes.type != Eyes.FOX, 3, function(): void {
				outputText("\n\nYou blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your eyes shifted to look more fox-like in a fashion similar to the kitsunes.  <b>You now have fox eyes.</b>");
				setEyeType(Eyes.FOX);
			});
			//Kitsune arms
			mutationStep(player.arms.type == Arms.HUMAN, 2, function(): void {
				outputText("\n\n Your finger tingle as your nails sharpen to point. You run them on a tree bark and they feel way harder than your old human nails. <b>You will be able to claw at your opponent with your sharp kitsune nails.</b>");
				setArmType(Arms.KITSUNE);
			});
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			mutationStep(!InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE, Arms.FOX, Arms.KITSUNE), 4, function(): void {
				humanizeArms();
			});
			//[Grow Fox Ears]
			mutationStep(player.tailType == Tail.FOX && player.ears.type != Ears.FOX, mystic ? 2 : 4, function(): void {
				//if PC has non-animal ears
				if (player.ears.type == Ears.HUMAN) outputText("\n\nThe sides of your face painfully stretch as your ears morph and begin to migrate up past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  <b>You now have fox ears.</b>");
				//if PC has animal ears
				else outputText("\n\nYour ears change shape, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
				setEarType(Ears.FOX);
			});
			//[Change Hair Color: Golden-blonde, SIlver Blonde, White, Black, Red]
			mutationStep(!InCollection(player.hairColor, KitsuneScene.basicKitsuneHair) && player.lowerBody != LowerBody.GARGOYLE && !InCollection(player.hairColor, KitsuneScene.elderKitsuneColors), mystic ? 2 : 4, function(): void {
				if (player.tailType == Tail.FOX && player.tailCount == 9) player.hairColor = randomChoice(KitsuneScene.elderKitsuneColors);
				else player.hairColor = randomChoice(KitsuneScene.basicKitsuneHair);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand, pulling it forward to check it.  Your hair has become the same [haircolor] as a kitsune's!");
			});
			var tone:Array = mystic ? ["dark", "ebony", "ashen", "sable", "milky white"] : ["tan", "olive", "light"];
			//[Change Skin Type: remove fur or scales, change skin to Tan, Olive, or Light]
			var changed:Boolean = mutationStep(player.skin.hasFur()
					&& !InCollection(player.coatColor, KitsuneScene.basicKitsuneFur)
					&& !InCollection(player.coatColor, KitsuneScene.elderKitsuneColors)
					&& !InCollection(player.coatColor, ["orange and white", "black and white", "red and white", "tan", "brown"])
					|| !player.skin.hasFur() && player.skin.hasCoat(), mystic ? 1 : 2, function(): void {
				outputText("\n\nYou begin to tingle all over your [skin], starting as a cool, pleasant sensation but gradually worsening until you are furiously itching all over.");
				if (player.hasFur()) outputText("  You stare in horror as you pull your fingers away holding a handful of [skin coat.color] fur!  Your fur sloughs off your body in thick clumps, falling away to reveal patches of bare, " + player.skinTone + " skin.");
				else if (player.hasScales()) outputText("  You stare in horror as you pull your fingers away holding a handful of dried up scales!  Your scales continue to flake and peel off your skin in thick patches, revealing the tender " + player.skinTone + " skin underneath.");
				outputText("  Your skin slowly turns raw and red under your severe scratching, the tingling sensations raising goosebumps across your whole body.  Over time, the itching fades, and your flushed skin resolves into a natural-looking ");
				player.skin.setBaseOnly({type:Skin.PLAIN});
				if (!InCollection(player.skinTone, tone)) player.skinTone = randomChoice(tone);
				outputText(player.skinTone + " complexion.");
				outputText("  <b>You now have [skin]!</b>");
			});
			//Change skin tone if not changed you!
			if (!changed) mutationStep(!InCollection(player.skinTone, tone) && player.lowerBody != LowerBody.GARGOYLE, mystic ? 2 : 3, function(): void {
				outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  Holding an arm up to your face, you discover that <b>you now have ");
				player.skinTone = randomChoice(tone);
				outputText("[skin]!</b>");
			});
			//[Change Skin Color: add "Tattoos"]
			//From Tan, Olive, or Light skin tones
			mutationStep(player.skin.base.type == Skin.PLAIN && !player.skin.hasMagicalTattoo(), 3, function(): void {
				outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin].  The glow gradually fades, but the distinctive ");
				if (mystic) outputText("angular");
				else outputText("curved");
				outputText(" markings remain, as if etched into your skin. <b>You now have Kitsune tattooed skin.</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedTattoed)) {
					outputText("\n\n<b>Genetic Memory: Magic Tattoed Skin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedTattoed, 0, 0, 0, 0);
				}
				player.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;
				player.skin.base.adj = "sexy tattooed";
			});
			//Nipples Turn Back:
			mutationStep(player.hasStatusEffect(StatusEffects.BlackNipples), 3, function(): void {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				player.removeStatusEffect(StatusEffects.BlackNipples);
			});
			//Debugcunt
			mutationStep((player.vaginaType() == 5 || player.vaginaType() == 6) && player.hasVagina(), 3, function(): void {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
			});
			if (changes == 0) {
				outputText("\n\nOdd.  You don't feel any different.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

/* Moved to KitsuneGift.as
//Kitsune's Gift
		public function kitsunesGift(player:Player):void
		{
			clearOutput();
			outputText("Curiosity gets the best of you, and you decide to open the package.  After all, what's the worst that could happen?\n\n");
			//Opening the gift randomly results in one of the following:
//			menuLoc = MENU_LOCATION_KITSUNE_GIFT;
			
			switch(rand(12)) {
			//[Fox Jewel]
				case 0:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, sitting in the center is a small teardrop-shaped jewel!");
				outputText("\n\n<b>You've received a shining Fox Jewel from the kitsune's gift!  How generous!</b>  ");
				inventory.takeItem(consumables.FOXJEWL, inventory.inventoryMenu);
				break;

			//[Fox Berries]
				case 1:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, there is a small cluster of orange-colored berries sitting in the center!");
				outputText("\n\n<b>You've received a fox berry from the kitsune's gift!  How generous!</b>  ");
				//add Fox Berries to inventory
				inventory.takeItem(consumables.FOXBERY, inventory.inventoryMenu);
				break;

			//[Gems]
				case 2:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it is filled to the brim with shining gems!");
				var gems:int = 2 + rand(20);
				outputText("\n\n<b>You've received " + num2Text(gems) + " shining gems from the kitsune's gift!  How generous!</b>");
				player.gems += gems;
				//add X gems to inventory
				statScreenRefresh();
				break;

			//[Kitsune Tea/Scholar's Tea] //Just use Scholar's Tea and drop the "trick" effect if you don't want to throw in another new item.
				case 3:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small bag of dried tea leaves!");
				outputText("\n\n<b>You've received a bag of tea from the kitsune's gift!  How thoughtful!</b>  ");
				//add Kitsune Tea/Scholar's Tea to inventory
				inventory.takeItem(consumables.SMART_T, inventory.inventoryMenu);
				break;

			//[Hair Dye]
				case 4:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small vial filled with hair dye!");
				var itype:ItemType = [
					consumables.RED_DYE,
					consumables.BLOND_D,
					consumables.BLACK_D,
					consumables.WHITEDY
				][rand(4)];

				outputText("\n\n<b>You've received " + itype.longName + " from the kitsune's gift!  How generous!</b>  ");
				//add <color> Dye to inventory
				inventory.takeItem(itype, inventory.inventoryMenu);
				break;

			//[Knowledge Spell]
				case 5:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but it seems like there's nothing else inside.  As you peer into the box, a glowing circle filled with strange symbols suddenly flashes to life!  Light washes over you, and your mind is suddenly assaulted with new knowledge...  and the urge to use that knowledge for mischief!");

				outputText("\n\n<b>The kitsune has shared some of its knowledge with you!</b>  But in the process, you've gained some of the kitsune's promiscuous trickster nature...");
				//Increase INT and Libido, +10 LUST
				dynStats("int", 4, "sen", 2, "lus", 10);
				break;

			//[Thief!]
				case 6:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it leaps into your item pouch, then hops away and gallavants into the woods, carting off a small fortune in gems.");

				outputText("\n\n<b>The kitsune's familiar has stolen your gems!</b>");
				// Lose X gems as though losing in battle to a kitsune
				player.gems -= 2 + rand(15);
				statScreenRefresh();
				break;

			//[Prank]
				case 7:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it pulls a large calligraphy brush from thin air and leaps up into your face, then hops away and gallavants off into the woods.  Touching your face experimentally, you come away with a fresh coat of black ink on your fingertips.");

				outputText("\n\n<b>The kitsune's familiar has drawn all over your face!</b>  The resilient marks take about an hour to completely scrub off in the nearby stream.  You could swear you heard some mirthful snickering among the trees while you were cleaning yourself off.");
				//Advance time 1 hour, -20 LUST
				dynStats("lus", -20);
				break;

			//[Aphrodisiac]
				case 8:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sweet-smelling pink dust into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel yourself growing hot and flushed, unable to keep your hands away from your groin.");
				outputText("\n\n<b>Oh no!  The kitsune's familiar has hit you with a powerful aphrodisiac!  You are debilitatingly aroused and can think of nothing other than masturbating.</b>");
				//+100 LUST
				dynStats("lus=", player.maxLust(), "scale", false);
				break;

			//[Wither]
				case 9:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sour-smelling orange powder into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel the strength draining from your muscles, withering away before your eyes.");
				outputText("\n\n<b>Oh no!  The kitsune's familiar has hit you with a strength draining spell!  Hopefully it's only temporary...</b>");
				dynStats("str", -5, "tou", -5);
				break;

			//[Dud]
				case 10:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.");
				outputText("\n\n<b>It seems the kitsune's gift was just a pile of useless junk!  What a ripoff!</b>");
				break;

			//[Dud...  Or is it?]
				case 11:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.  Upon further investigation, though, you find a shard of shiny black chitinous plating mixed in with the other useless junk.");
					outputText("\n\n<b>At least you managed to salvage a shard of black chitin from it...</b>  ");
				inventory.takeItem(useables.B_CHITN, inventory.inventoryMenu);
				break;

				default: trace("Kitsune's gift roll foobar..."); break;
			}
		}
*/

		/*
		 Perk

		 Corrupted Nine-tails:
		 Description: The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.
		 Effect: Recover 1-3 Fatigue per Round in combat, 3 per hour out of combat.  Victory sex recovers fatigue equal to 2x the enemy's level.  Also applies Masochist and Sadist perks, if they are not already.
		 //Alternatively, add the same effects as Masochist and Sadist but don't allow stacking, this way the effects can be removed if the player loses the corrupted nine-tails perk.
		 Requirements: Have fox ears and obtain your 9th tail from the Mystic Jewel item.  Must maintain at least 80 corruption and 80 intelligence, fox ears and 9 tails, or lose the perk.

		 Corrupted Fox Fire
		 Fatigue Cost: 35
		 Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
		 Cast: outputText( "Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at the " + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere." );

		 Terror
		 Fatigue Cost: 25
		 Inflicts fear and reduces enemy SPD.
		 Cast: outputText( "The world goes dark, an inky shadow blanketing everything in sight as you fill the " + monster.short + "'s mind with visions of otherworldly terror that defy description."  + ((succeed) ? "They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares." : "The dark fog recedes as quickly as it rolled in as they push back your illusions, resisting your hypnotic influence.") );

		 Seal
		 Fatigue Cost: 35
		 Seals enemy abilities, preventing them from using their specials.
		 Cast: outputText( "You make a series of gestures, chanting in a strange tongue.  " + ((succeed) ? "A symbol made of flames appears on the " + monster.short + "'s body, temporarily preventing them from using any special abilities!" : "A symbol made of flames appears on the " + monster.short + "'s body, but it dissipates as quickly as it was formed, failing to properly seal them." ) );

		 Enlightened Nine-tails:
		 Description: The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.
		 Effect: Recover 1-3 Fatigue per Round in combat, 3 per hour out of combat.  Provides a buff to Tease.  Victory sex recovers fatigue equal to 2x the enemy's level.
		 Requirements: Have fox ears and obtain your 9th tail from spiritual enlightenment.  Must maintain at least 80 intelligence, fox ears and 9 tails, or lose the perk.

		 Fox Fire
		 Fatigue Cost: 35
		 Deals direct damage and lust regardless of enemy defenses.  Especially effective against corrupted targets.
		 Cast: outputText( "Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at the " + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.");

		 Illusion
		 Fatigue Cost: 25
		 Decrease enemy hit chance and increase their susceptibility to lust attacks.
		 Cast: outputText( "The world begins to twist and distort around you as reality bends to your will, the " + monster.short + "'s mind blanketed in the thick fog of your illusions." + ((succeed) ? "They stumble humorously to and fro, unable to keep pace with the shifting illusions that cloud their perceptions" : "Like the snapping of a rubber band, reality falls back into its rightful place as they resist your illusory conjurations." ) );

		 Seal
		 Fatigue Cost: 35
		 Seals enemy abilities, preventing them from using their specials.
		 Cast: outputText( "You make a series of gestures, chanting in a strange tongue.  " + ((succeed) ? "A symbol made of flames appears on the " + monster.short + "'s body, temporarily preventing them from using any special abilities!" : "A symbol made of flames appears on the " + monster.short + "'s body, but it dissipates as quickly as it was formed, failing to properly seal them." ) );
		 Teases

		 // Specific to tentacle beasts
		 outputText( "You find yourself unable to stifle a flirtatious giggle, waggling your fingers at the tentacle beast and grinning.  You stroll fearlessly up to the writhing abomination and run your hands through its thick, foliage-like coat, your tail" + ((player.tailVenum > 1) ? "s" : "" ) + " curling around its wriggling limbs.  " + ((succeed) ? "The creature's wild thrashing is quelled by confusion and arousal, a few of its limbs running along your face tenderly before you break away.  The beast resumes its savage flailing, but you can tell your touch had an effect on it." : "The creature is unmoved by your tender caresses, swinging a thick limb at you violently.  Thankfully, you are able to break away from it unscathed, but it's obvious that you're going to have to try harder to fluster this beast.") );
		 */

//Unbimbo Yourself:*
/* Now handled by DeBimbo.as
		public function deBimbo(player:Player):void
		{
			clearOutput();
			if (player.findPerk(PerkLib.BimboBrains) < 0 && player.findPerk(PerkLib.FutaFaculties) < 0 && player.findPerk(PerkLib.BroBrains) < 0) {
				outputText("You can't use this right now, and it's too expensive to waste!\n\n");
				if (debug) {}
				else {
					inventory.takeItem(consumables.DEBIMBO);
				}
				return;
			}
			outputText("Well, time to see what this smelly, old rat was on about!  You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you.  Stumbling back against a rock for support, you close your eyes.  A constant, pounding ache throbs just behind your temples, and for once, you find yourself speechless.  A pained groan slips through your lips as thoughts and memories come rushing back.  One after another, threads of cognizant thought plow through the simple matrices of your bimbo mind, shredding and replacing them.");
			outputText("\n\nYou... you were an air-headed ditz!  A vacuous, idiot-girl with nothing between her ears but hunger for dick and pleasure!  You shudder as your faculties return, the pain diminishing with each passing moment.");
			if (player.findPerk(PerkLib.BimboBrains) >= 0) {
				outputText("\n\n(<b>Perk Removed:  Bimbo Brains - Your intelligence and speech patterns are no longer limited to that of a bimbo.</b>)");
				player.removePerk(PerkLib.BimboBrains);
			}
			else if (player.findPerk(PerkLib.FutaFaculties) >= 0) {
				outputText("\n\n(<b>Perk Removed:  Futa Faculties - Your intelligence and speech patterns are no longer limited to that of a futanari bimbo.</b>)");
				player.removePerk(PerkLib.FutaFaculties);
			}
			else if (player.findPerk(PerkLib.BroBrains) >= 0) {
				outputText("\n\n(<b>Perk Removed:  Bro Brains - Your intelligence gains are no longer hampered. You now gain intelligence at a normal pace.</b>)");
				player.removePerk(PerkLib.BroBrains);
			}
		}
*/
		//Fish Fillet
		public function fishFillet(player:Player):void
		{
			clearOutput();
            if (!CoC.instance.inCombat) outputText("You sit down and unwrap your fish fillet. It's perfectly flaky, allowing you to break it off in bite-sized chunks.  The salty meal disappears quickly, and your stomach gives an appreciative gurgle.");
            //(In combat?)
			else outputText("You produce the fish fillet from your bag.  Rather than unwrap it and savor the taste as you normally would, you take a large bite out of it, leaf wrapping and all.  In no time your salty meal is gone, your stomach giving an appreciative gurgle.  ");
			//Increase HP by quite a bit!)
			//(Slight chance at increasing Toughness?)
			//(If lake has been tainted, +1 Corruption?)
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) dynStats("cor", 0.5);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) dynStats("cor", -0.1);
			dynStats("cor", 0.1);
			HPChange(Math.round(player.maxHP() * .25), true);
			player.refillHunger(30);
		}
		//Behemoth Cum
		public function behemothCum(player:Player):void
		{
			clearOutput();
			outputText("You uncork the bottle and drink the behemoth cum; it tastes great and by the time you've finished drinking, you feel a bit stronger. ");
			dynStats("str", 0.5, "tou", 0.5, "lus", 5 + (player.cor / 5));
			HPChange(Math.round(player.maxHP() * .25), true);
			player.slimeFeed();
			player.refillHunger(25);
		}
		//Urta's Cum
		public function urtaCum(player:Player):void
		{
			clearOutput();
			outputText("You uncork the bottle and drink the vulpine cum; it tastes great. Urta definitely produces good-tasting cum!");
			dynStats("sens", 1, "lus", 5 + (player.cor / 5));
			HPChange(Math.round(player.maxHP() * .25), true);
			player.slimeFeed();
			player.refillHunger(25);
		}
		//Fresh Fish
		public function freshFish(player:Player):void
		{
			clearOutput();
            if (!CoC.instance.inCombat) outputText("You sit down and unbag your fresh fish. It's perfectly flaky, allowing you to break it off in bite-sized chunks.  The salty meal disappears quickly, and your stomach gives an appreciative gurgle.");
            //(In combat?)
			else {
				if (player.orcaScore() >= 12) outputText("You produce the fresh fish from your bag and prety much just open wide your hungry mouth and toss it in. Your salty meal is gone in a flash, your stomach giving an appreciative gurgle.  ");
				else outputText("You produce the fresh fish from your bag. Instead of eating slowly it and savor the taste as you normally would, you take a large bite out of it.  In no time your salty meal is gone, your stomach giving an appreciative gurgle.  ");
			}
			//Increase HP by quite a bit!)
			HPChange(Math.round(player.maxHP() * .2), true);
			player.refillHunger(30);
		}
//Trap Oil
//Flavour Description: A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.
		public function trapOil(player:Player):void
		{
			clearOutput();
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("You pour some of the oil onto your hands and ");
			if (player.cor < 30) outputText("hesitantly ");
			else if (player.cor > 70) outputText("eagerly ");
			outputText("rub it into your arms and chest.  The substance is warm, coating and ever so slightly numbing; it quickly sinks into your skin, leaving you feeling smooth and sleek.");
			//Speed Increase:
			if (player.spe < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel fleet and lighter on your toes; you sense you could dodge, dart or skip away from anything.");
				dynStats("spe", 1);
				changes++;
			}
			//Strength Loss:
			else if (player.str > 40 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA sense of helplessness settles upon you as your limbs lose mass, leaving you feeling weaker and punier.");
				dynStats("str", -1);
				changes++;
			}
			//Sensitivity Increase:
			if (player.sens < 70 && player.hasCock() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA light breeze brushes over you and your skin tingles.  You have become more sensitive to physical sensation.");
				dynStats("sen", 5);
				changes++;
			}
			//Libido Increase:
			if (player.lib < 70 && player.hasVagina() && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel your blood quicken and rise, and a desire to... hunt builds within you.");
				dynStats("lib", 2);
				if (player.lib < 30) dynStats("lib", 2);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Body Mass Loss:
			if (player.thickness > 40 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel an odd tightening sensation in your midriff, as if you were becoming narrower and lither.  You frown downwards, and then turn your arms around, examining them closely.  Is it just you or have you lost weight?");
				player.modThickness(40, 3);
				changes++;
			}
			//Thigh Loss: (towards “girly”)
			if (player.hips.type >= 10 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou touch your thighs speculatively.  It's not just your imagination; you've lost a bit of weight around your waist.");
				player.hips.type--;
				if (player.hips.type > 15) player.hips.type -= 2 + rand(3);
				changes++;
			}
			//Thigh Gain: (towards “girly”)
			if (player.hips.type < 6 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou touch your thighs speculatively.  You think you may have gained a little weight around your waist.");
				player.hips.type++;
				changes++;
			}
			//Breast Loss: (towards A cup)
			if (player.biggestTitSize() > 1 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou gasp as you feel a compressing sensation in your chest and around your [fullChest].  The feeling quickly fades however, leaving you feeling like you have lost a considerable amount of weight from your upper body.");
				var index:int = 0;
				while (index < player.bRows()) {
					if (player.breastRows[index].breastRating > 70) player.breastRows[index].breastRating -= rand(3) + 15;
					else if (player.breastRows[index].breastRating > 50) player.breastRows[index].breastRating -= rand(3) + 10;
					else if (player.breastRows[index].breastRating > 30) player.breastRows[index].breastRating -= rand(3) + 7;
					else if (player.breastRows[index].breastRating > 15) player.breastRows[index].breastRating -= rand(3) + 4;
					else player.breastRows[index].breastRating -= 2 + rand(2);
					if (player.breastRows[index].breastRating < 1) player.breastRows[index].breastRating = 1;
					index++;
				}
				changes++;
			}
			//Breast Gain: (towards A cup)
			if (player.biggestTitSize() < 1 || player.breastRows[0].breastRating < 1 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel a vague swelling sensation in your [fullChest], and you frown downwards.  You seem to have gained a little weight on your chest.  Not enough to stand out, but- you cup yourself carefully- certainly giving you the faintest suggestion of boobs.");
				player.breastRows[0].breastRating = 1;
				if (player.bRows() > 1) {
					index = 1;
					while (index < player.bRows()) {
						if (player.breastRows[index].breastRating < 1) player.breastRows[index].breastRating = 1;
					}
				}
				changes++;
			}
			//Penis Reduction towards 3.5 Inches:
			if (player.longestCockLength() >= 3.5 && player.hasCock() && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYou flinch and gasp as your [cocks] suddenly become");
				if (player.cockTotal() == 1) outputText("s");
				outputText(" incredibly sensitive and retract into your body.  Anxiously you pull down your underclothes to examine your nether regions.  To your relief ");
				if (player.cockTotal() == 1) outputText("it is");
				else outputText("they are");
				outputText(" still present, and as you touch ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("them");
				outputText(", the sensitivity fades, however - a blush comes to your cheeks - ");
				if (player.cockTotal() == 1) outputText("it seems");
				else outputText("they seem");
				outputText(" to have become smaller.");
				index = 0;
				while (index < player.cockTotal()) {
					if (player.cocks[index].cockLength >= 3.5) {
						//Shrink said cock
						if (player.cocks[index].cockLength < 6 && player.cocks[index].cockLength >= 2.9) {
							player.cocks[index].cockLength -= .5;
							if (player.cocks[index].cockThickness * 6 > player.cocks[index].cockLength) player.cocks[index].cockThickness -= .2;
							if (player.cocks[index].cockThickness * 8 > player.cocks[index].cockLength) player.cocks[index].cockThickness -= .2;
							if (player.cocks[index].cockThickness < .5) player.cocks[index].cockThickness = .5;
						}
						player.cocks[index].cockLength -= 0.5;
						player.increaseCock(index, Math.round(player.cocks[index].cockLength * 0.33) * -1);
					}
					index++;
				}
				changes++;
			}
			//Testicle Reduction:
			if (player.balls > 0 && player.hasCock() && (player.ballSize > 1 || !player.hasStatusEffect(StatusEffects.Uniball)) && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel a delicate tightening sensation around your [balls].  The sensation upon this most sensitive part of your anatomy isn't painful, but the feeling of your balls getting smaller is intense enough that you stifle anything more than a sharp intake of breath only with difficulty.");
				player.ballSize--;
				if (player.ballSize > 8) player.ballSize--;
				if (player.ballSize > 10) player.ballSize--;
				if (player.ballSize > 12) player.ballSize--;
				if (player.ballSize > 15) player.ballSize--;
				if (player.ballSize > 20) player.ballSize--;
				//Testicle Reduction final:
				if (player.ballSize < 1 && !player.hasStatusEffect(StatusEffects.Uniball)) {
					outputText("  You whimper as once again, your balls tighten and shrink.  Your eyes widen when you feel the gentle weight of your testicles pushing against the top of your [hips], and a few hesitant swings of your rear confirm what you can feel - you've tightened your balls up so much they no longer hang beneath your [cocks], but press perkily upwards.  Heat ringing your ears, you explore your new sack with a careful hand.  You are deeply grateful you apparently haven't reversed puberty, but you discover that though you still have " + num2Text(player.balls) + ", your balls now look and feel like one: one cute, tight little sissy parcel, its warm, insistent pressure upwards upon the joining of your thighs a never-ending reminder of it.");
					//[Note: Balls description should no longer say “swings heavily beneath”.  For simplicity's sake sex scenes should continue to assume two balls]
					player.ballSize = 1;
					player.createStatusEffect(StatusEffects.Uniball, 0, 0, 0, 0);
				}
				else if (player.ballSize < 1) player.ballSize = 1;
				changes++;
			}
			//Anal Wetness Increase:
			if (player.ass.analWetness < 5 && rand(4) == 0 && changes < changeLimit) {
				if (player.ass.analWetness < 4) outputText("\n\nYour eyes widen in shock as you feel oily moisture bead out of your [asshole].  Your asshole has become wetter and more pliable.");
				//Anal Wetness Increase Final (always loose):
				else outputText("\n\nYou moan as clear, odorless oil dribbles out of your [asshole], this time in enough quantity to stain your [armor].  Your back passage feels incredibly sensitive, wet and accommodating.  Your ass is ready to be plowed by anything, and always will be.");
				player.ass.analWetness++;
				//buttChange(30,false,false,false);
				if (player.ass.analLooseness < 3) player.ass.analLooseness++;
				changes++;
				dynStats("sen", 2);
			}
			//Fertility Decrease:
			if (player.hasVagina() && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nThe vague numbness in your skin sinks slowly downwards, and you put a hand on your lower stomach as the sensation centers itself there.  ");
				dynStats("sen", -2);
				//High fertility:
				if (player.fertility >= 30) outputText("It feels like your overcharged reproductive organs have simmered down a bit.");
				//Average fertility:
				else if (player.fertility >= 5) outputText("You feel like you have dried up a bit inside; you are left feeling oddly tranquil.");
				//[Low/No fertility:
				else {
					outputText("Although the numbness makes you feel serene, the trap oil has no effect upon your ");
					if (player.fertility > 0) outputText("mostly ");
					outputText("sterile system.");
					//[Low/No fertility + Trap/Corruption  >70:
					if (player.cor > 70) outputText("  For some reason the fact that you cannot function as nature intended makes you feel helpless and submissive.  Perhaps the only way to be a useful creature now is to find a dominant, fertile being willing to plow you full of eggs? You shake the alien, yet oddly alluring thought away.");
				}
				player.fertility -= 1 + rand(3);
				if (player.fertility < 4) player.fertility = 4;
				changes++;
			}
			//Male Effects
			if (player.gender == 1) {
				//Femininity Increase Final (max femininity allowed increased by +10):
				if (rand(4) == 0 && changes < changeLimit) {
					if (player.femininity < 70 && player.femininity >= 60) {
						outputText("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a girly giggle than anything else.  Feeling slightly more sober, you touch the soft flesh of your face prospectively.  The trap oil has changed you profoundly, making your innate maleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a girl now if you wanted to.");
						if (player.findPerk(PerkLib.Androgyny) < 0) {
							player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							outputText("\n\n(<b>Perk Gained: Androgyny</b>)");
						}
						player.femininity += 10;
						if (player.femininity > 70) player.femininity = 70;
						changes++;
					}
					//Femininity Increase:
					else {
						outputText("\n\nYour face softens as your features become more feminine.");
						player.femininity += 10;
						changes++;
					}
				}
				//Muscle tone reduction:
				if (player.tone > 20 && rand(4) == 0 && changes < changeLimit) {
					outputText("\n\nYou sink a finger into your arm inquiringly.  You seem to have lost some of your muscle definition, leaving you looking softer.");
					player.tone -= 10;
					changes++;
				}
			}
			//Female Effects
			else if (player.gender == 2) {
				//Masculinity Increase:
				if (player.femininity > 30 && rand(4) == 0 && changes < changeLimit) {
					player.femininity -= 10;
					if (player.femininity < 30) {
						player.femininity = 30;
						//Masculinity Increase Final (max masculinity allowed increased by +10):
						outputText("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a boyish crow than anything else.  Feeling slightly more sober, you touch the defined lines of your face prospectively.  The trap oil has changed you profoundly, making your innate femaleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a boy now if you wanted to.");
						if (player.findPerk(PerkLib.Androgyny) < 0) {
							player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							outputText("\n\n(<b>Perk Gained: Androgyny</b>)");
						}
					}
					else {
						outputText("\n\nYour face becomes more set and defined as your features turn more masculine.");
					}
					changes++;
				}
				//Muscle tone gain:
				if (player.tone < 80 && rand(4) == 0 && changes < changeLimit) {
					outputText("\n\nYou flex your arm in interest.  Although you have become thinner, your muscles seem to have become more defined.");
					player.tone += 10;
					changes++;
				}
			}
			//Nipples Turn Black:
			if (!player.hasStatusEffect(StatusEffects.BlackNipples) && player.lowerBody != LowerBody.GARGOYLE && rand(6) == 0 && changes < changeLimit) {
				outputText("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				changes++;
			}
			//Remove odd eyes
			if ((player.eyes.type == Eyes.FOUR_SPIDER_EYES || player.eyes.type == Eyes.CAT_SLITS) && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				if (player.eyes.type == Eyes.FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
				else if (player.eyes.type == Eyes.CAT_SLITS) outputText("  Your cat-like eyes are gone!</b>");
				outputText("  <b>You have normal, humanoid eyes again.</b>");
				setEyeType(Eyes.HUMAN);
				changes++;
			}
			//PC Trap Effects
			if (player.eyes.type != Eyes.BLACK_EYES_SAND_TRAP && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				setEyeTypeAndColor(Eyes.BLACK_EYES_SAND_TRAP,"black");
				//Eyes Turn Black:
				outputText("\n\nYou blink, and then blink again.  It feels like something is irritating your eyes.  Panic sets in as black suddenly blooms in the corner of your left eye and then your right, as if drops of ink were falling into them.  You calm yourself down with the thought that rubbing at your eyes will certainly make whatever is happening to them worse; through force of will you hold your hands behind your back and wait for the strange affliction to run its course.  The strange inky substance pools over your entire vision before slowly fading, thankfully taking the irritation with it.  As soon as it goes you stride quickly over to the stream and stare at your reflection.  <b>Your pupils, your irises, your entire eye has turned a liquid black</b>, leaving you looking vaguely like the many half insect creatures which inhabit these lands.  You find you are merely grateful the change apparently hasn't affected your vision.");
				changes++;
			}
			//Vagina Turns Black:
			if (player.hasVagina() && player.vaginaType() != 5 && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour [vagina] feels... odd.  You undo your clothes and gingerly inspect your nether regions.  The tender pink color of your sex has disappeared, replaced with smooth, marble blackness starting at your lips and working inwards.");
				//(Wet:
				if (player.wetness() >= 3) outputText("  Your natural lubrication makes it gleam invitingly.");
				//(Corruption <50:
				if (player.cor < 50) outputText("  After a few cautious touches you decide it doesn't feel any different- it does certainly look odd, though.");
				else outputText("  After a few cautious touches you decide it doesn't feel any different - the sheer bizarreness of it is a big turn on though, and you feel it beginning to shine with anticipation at the thought of using it.");
				outputText("  <b>Your vagina is now ebony in color.</b>");
				dynStats("sen", 2, "lus", 10);
				player.vaginaType(5);
				changes++;
			}
			//Dragonfly Wings:
			if (!InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.GIANT_DRAGONFLY) && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYou scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades.  After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back.  You clench the dirt as you slide what feel like giant leaves of paper into the open air.  Eventually the sensation passes and you groggily get to your feet.  You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful.  You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground.  What fun this is going to be!");
				//Wings Fall Out: You feel a sharp pinching sensation in your shoulders and you cringe slightly.  Your former dragonfly wings make soft, papery sounds as they fall into the dirt behind you.
				changes++;
				setWingType(Wings.GIANT_DRAGONFLY, "giant dragonfly");
			}
			if (changes == 0) {
				outputText("\n\nWell... that didn't amount to much.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//PurPeac
//Purity Peach - Inventory
		public function purityPeach(player:Player):void
		{
			clearOutput();
			outputText("You bite into the sweet, juicy peach, feeling a sensation of energy sweeping through your limbs and your mind.  You feel revitalized, refreshed, and somehow cleansed.  ");
			fatigue(-15);
			HPChange(Math.round(player.maxHP() * 0.25), true);
			player.refillHunger(25);
		}

//New Item: "Purple Fruit"
//This sweet-smelling produce looks like an eggplant but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.

//>When Used
		public function purpleFruitEssrayle(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You bite into the fruit Essrayle gave you with little hesitation.  It's amazingly sweet, with a texture that's rather gummy.  The juice is a candied grape syrup that fills your cheeks and flows down your throat with far more fluid than the size of the plant should allow.  You hastily devour the entire thing, unable to stop yourself once you've started.");
			outputText("\n\nA tingling warmth shifts to a roaring inferno in your veins, your heart-rate spiking abruptly.  The intensity of it almost makes your body feel molten!  But, as quickly as it came, the sensation fades into merely a pleasing warmth that settles in your chest.");
			if (player.averageNipplesPerBreast() < 4) {
				outputText("  At first you think nothing has changed, but a second look confirms that your breasts now sport the same quartet of cow-like nipples the bovine plant-girl bears.");
				if (player.nippleLength < 4) player.nippleLength = 4;
				var rows:int = player.bRows();
				while (rows > 0) {
					rows--;
					player.breastRows[rows].nipplesPerBreast = 4;
				}
			}
			//[Player gains quad nipples, milk production and libido way up]
			dynStats("lib", 5);
			player.boostLactation(3 * player.bRows());
			player.refillHunger(30);
		}

//TF Items
//Ringtail Fig/RingFig (please do not change the fruit type to suit whimsy because I have some plans for figs)
//tooltip:
//A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.

		public function ringtailFig(player:Player):void
		{
			clearOutput();
			//eat it:
			outputText("You split the fruit and scoop out the pulp, eating it greedily.  It's sweet and slightly gritty with seeds, and you quickly finish both halves.");

			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//stat gains:
			//gain speed to ceiling of 80
			if (player.spe < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou twitch and turn your head this way and that, feeling a bit more alert.  This will definitely help when defending your personal space from violators.");
				changes++;
				if (player.spe < 40) dynStats("spe", 1);
				dynStats("spe", 1);
			}
			//gain sensitivity
			if (player.sens < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nThe wrinkled rind suddenly feels alarmingly distinct in your hands, and you drop the remnants of the fruit.  Wonderingly, you touch yourself with a finger - you can feel even the lightest pressure on your " + player.skinFurScales() + " much more clearly now!");
				if (player.sens < 60) dynStats("sen", 2);
				dynStats("sen", 2);
				changes++;
			}
			//lose toughness to floor of 50
			if (rand(4) && player.tou > 50 && changes < changeLimit) {
				outputText("\n\nYou find yourself wishing you could just sit around and eat all day, and spend a while lazing about and doing nothing before you can rouse yourself to get moving.");
				if (player.tou > 75) dynStats("tou", -1);
				dynStats("tou", -1);
				changes++;
			}

			//Sex stuff
			if (player.hasCock()) {
				//gain ball size
				if (player.balls > 0 && player.ballSize < 15 && rand(4) == 0 && changes < changeLimit) {
					outputText("\n\nYour [balls] inflate, stretching the skin of your sack.  Exposing them, you can see that they've grown several inches!  How magical!");
					changes++;
					player.ballSize += 2 + rand(3);
					dynStats("lib", 1);
				}
				//gain balls up to 2 (only if full-coon face and fur; no dick required)
				if (player.balls == 0 && player.hasFur() && 9999 == 9999 && rand(3) == 0 && changes < changeLimit) {
					outputText("\n\nAs you eat, you contemplate your masked appearance; it strikes you that you're dangerously close to the classic caricature of a thief.  Really, all it would take is a big, nondescript sack and a hurried gait and everyone would immediately think the worst of you.  In a brief fit of pique, you wish you had such a bag to store your things in, eager to challenge a few assumptions.  A few minutes into that line of thought, a twisting ache in your lower gut bends you double, and you expose yourself hurriedly to examine the region.  As you watch, a balloon of flesh forms on your crotch, and two lumps migrate from below your navel down into it.  <b>Looks like you have a sack, after all.</b>");
					player.balls = 2;
					player.ballSize = 1;
					changes++;
				}
			}
			//gain thickness or lose tone or whatever - standard message
			if (rand(4) == 0 && player.thickness < 80 && changes < changeLimit) {
				outputText(player.modThickness(80, 2));
				changes++;
			}
			//bodypart changes:
			if (player.tailType != Tail.RACCOON && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				//grow da tail
				//from no tail:
				if (player.tailType == Tail.NONE) {
					outputText("\n\nPain shivers through your spine and forces you onto the ground; your body locks up despite your attempt to rise again.  You can feel a tug on your spine from your backside, as if someone is trying to pull it out!  Several nodules form along your back, growing into new vertebrae and pushing the old ones downward and into your [armor].  An uncomfortable pressure grows there, as whatever development is taking place fights to free itself from the constriction.  Finally the shifting stops, and you're able to move again; the first thing you do is loosen your bottoms, allowing a matted tail to slide out.  <b>It twitches involuntarily, fluffing out into a ringed raccoon tail!</b>");
				}
				//from other tail:
				else {
					outputText("\n\nYour tail goes rigid with pain, and soon your body follows.  It feels as though your spine is trying to push the growth off of your body... barely, you manage to turn your head to see almost exactly that!  A new ringed, fluffy tail is growing in behind its predecessor, dark bands after light.  Soon it reaches full length and a tear comes to your eye as your old tail parts from its end and drops to the ground like overripe fruit, dissolving.  <b>You now have a raccoon tail!</b>");
				}
				setTailType(Tail.RACCOON);
				changes++;
			}
			//gain fur
			if ((player.lowerBody == LowerBody.RACCOON && player.ears.type == Ears.RACCOON) && !player.hasFur() && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou shiver, feeling a bit cold.  Just as you begin to wish for something to cover up with, it seems your request is granted; thick, bushy fur begins to grow all over your body!  You tug at the tufts in alarm, but they're firmly rooted and... actually pretty soft.  Huh.  ");
				player.skin.growCoat(Skin.FUR,{color:"gray"});
				outputText("<b>You now have a warm coat of [skin coat.color] raccoon fur!</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//gain coon ears
			if (player.tailType == Tail.RACCOON && player.ears.type != Ears.RACCOON && rand(4) == 0 && changes < changeLimit) {
				//from dog, kangaroo, bunny, other long ears
				if (player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) outputText("\n\nYour ears compress, constricting your ear canal momentarily.  You shake your head to get sound back, and reach up to touch the auricles, to find a pair of stubby egg-shaped ears in their place.  <b>You now have raccoon ears!</b>");
				//from cat, horse, cow ears
				else if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.CAT) outputText("\n\nYour ears tingle.  Huh.  Do they feel a bit rounder at the tip now?  <b>Looks like you have raccoon ears.</b>");
				//from human, goblin, lizard or other short ears
				else outputText("\n\nYour ears prick and stretch uncomfortably, poking up through your [hair].  Covering them with your hands, you feel them shaping into little eggdrop ornaments resting atop your head.  <b>You have raccoon ears!</b>");
				setEarType(Ears.RACCOON);
				changes++;
			}
			//gain feet-coon
			if (player.ears.type == Ears.RACCOON && player.lowerBody != LowerBody.RACCOON && changes < changeLimit && rand(4) == 0) {
				//from naga non-feet (gain fatigue and lose lust)
				if (player.isNaga()) {
					outputText("\n\nYour body straightens and telescopes suddenly and without the length of your snake half to anchor you, you're left with your face in the dirt.  A shuffling and scraping of falling scales sounds and a terrible cramp takes you as your back half continues migrating, subducting under your [butt] and making you feel extremely bloated.  As your once prominent tail dwindles to roughly the length of your torso, a sickly ripping noise fills your head and it bursts apart, revealing two new legs!  The tattered snake-skin continues melding into your groin as you examine the fuzzy legs and long-toed, sensitive feet.  <b>Looks like you now have raccoon hind-paws...</b> and an upset stomach.");
					dynStats("lus", -30);
					fatigue(5);
				}
				//from amoeba non-feet
				else if (player.isGoo()) outputText("\n\nYour gooey undercarriage begins to boil violently, and before you can do anything, it evaporates!  Left sitting on just the small pad of sticky half-dried slime that comprises your [butt], a sudden bulge under you is enough to push you onto your back.  Wondering idly and unable to see what's happening, you close your eyes and try to focus on what sensations you can feel from your lower body.  You feel... a swell of expansion, followed by weak muscles trying to contract for the first time, pulling flimsy, folded limbs apart and laying them flat.  As your attention wanders downward, you feel toes wiggling - far longer toes than you remember.  For several minutes you lie still and test muscles gingerly as your body solidifes, but when you can finally move again and look at your legs properly, what you see surprises you very little.  <b>You have fuzzy legs and a pair of long-toed raccoon paws!</b>");
				//from hooves or hard feet, including centaurs and bees
				else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || player.isTaur()) {
					outputText("\n\nYour [feet] feel very... wide, all of a sudden.  You clop around experimentally, finding them far less responsive and more cumbersome than usual.  On one step, one of your feet ");
					if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY) outputText("pops right out of its hoof just in time");
					else outputText("comes loose inside its long boot, and you pull it free with irritation only");
					outputText(" for you to set it back down on a sharp rock!  Biting off a curse, you examine the new bare foot.  It looks much like a human's, except for the nearly-twice-as-long toes.  You find you can even use them to pick things up; the sharp rock is dropped into your hand and tossed far away.  The shed [foot] is quickly joined on the ground by its complement, revealing more long toes.  ");
					if (player.isTaur()) outputText("For a few minutes you amuse yourself with your four prehensile feet... you even make up a game that involves juggling a stone under your body by tossing it between two feet while balancing on the others.  It's only a short while, however, before your lower stomach grumbles and a searing pain makes you miss your catch.  Anticipating what will happen, you lie down carefully and close your eyes, biting down on a soft wad of cloth.  The pain quickly returns and drives you into unconsciousness, and when you awaken, your back legs are gone.  ");
					outputText("<b>You now have two fuzzy, long-toed raccoon legs.</b>");
				}
				//from human, demon, paw feet
				else {
					outputText("\n\nYour toes wiggle of their own accord, drawing your attention.  Looking down, you can see them changing from their current shape, stretching into oblongs.  When they finish, your foot appears humanoid, but with long, prehesile toes!  ");
					if ((player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS) && !player.hasFur()) outputText("The sensation of walking around on what feels like a second pair of hands is so weird that you miss noticing the itchy fur growing in over your legs...  ");
					outputText("<b>You now have raccoon paws!</b>");
				}
				setLowerBody(LowerBody.RACCOON);
				player.legCount = 2;
				changes++;
			}
			//gain half-coon face (prevented if already full-coon)
			if (player.faceType != Face.RACCOON_MASK && player.faceType != Face.RACCOON && player.lowerBody != LowerBody.GARGOYLE && rand(4) == 0 && changes < changeLimit) {
				//from human/naga/shark/bun face
				if (player.faceType == Face.HUMAN || player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
					outputText("\n\nA sudden wave of exhaustion passes over you, and your face goes partially numb around your eyes.  ");
					//(nagasharkbunnies)
					if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.BUNNY) {
						outputText("Your prominent teeth chatter noisily at first, then with diminishing violence, until you can no longer feel them jutting past the rest!  ");
					}
					outputText("Shaking your head a bit, you wait for your energy to return, then examine your appearance.  ");
					//(if player skinTone = ebony/black/ebony with tats and no fur/scales or if black/midnight fur or if black scales
					if (((player.skinTone == "ebony" || player.skinTone == "black") && !player.hasCoat()) || ((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) {
						outputText("Nothing seems different at first.  Strange... you look closer and discover a darker, mask-line outline on your already inky visage.  <b>You now have a barely-visible raccoon mask.</b>");
					}
					else outputText("A dark, almost black mask shades the " + player.skinFurScales() + " around your eyes and over the topmost portion of your nose, lending you a criminal air!  <b>You now have a raccoon mask!</b>");
				}
				//from snout (will not overwrite full-coon snout but will overwrite others)
				else {
					outputText("\n\nA sudden migraine sweeps over you and you clutch your head in agony as your nose collapses back to human dimensions.  A worrying numb spot grows around your eyes, and you entertain several horrible premonitions until it passes as suddenly as it came.  Checking your reflection in your water barrel, you find ");
					//[(if black/midnight fur or if black scales)
					if (((player.hairColor == "black" || player.hairColor == "midnight") && (player.hasFur() || player.hasScales()))) outputText("your face apparently returned to normal shape, albeit still covered in " + player.skinFurScales() + ".  You look closer and discover a darker, mask-line outline on your already inky visage.  <b>You now have a barely-visible raccoon mask on your otherwise normal human face.</b>");
					else if ((player.skinTone == "ebony" || player.skinTone == "black") && (!player.hasCoat())) outputText("your face apparently returned to normal shape.  You look closer and discover a darker, mask-line outline on your already inky visage.  <b>You now have a barely-visible raccoon mask on your normal human face.</b>");
					else outputText("your face returned to human dimensions, but shaded by a black mask around the eyes and over the nose!  <b>You now have a humanoid face with a raccoon mask!</b>");
				}
				setFaceType(Face.RACCOON_MASK);
				changes++;
			}
			//gain full-coon face (requires half-coon and fur)
			//from humanoid - should be the only one possible
			else if (player.faceType == Face.RACCOON_MASK && player.lowerBody == LowerBody.RACCOON && player.hasFur() && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour face pinches with tension, and you rub the bridge of your nose to release it.  The action starts a miniature slide in your bone structure, and your nose extends out in front of you!  You shut your eyes, waiting for the sinus pressure to subside, and when you open them, a triangular, pointed snout dotted with whiskers and capped by a black nose greets you!  <b>You now have a raccoon's face!</b>");
				//from muzzleoid - should not be possible, but included if things change
				//Your face goes numb, and you can see your snout shifting into a medium-long, tapered shape.  Closing your eyes, you rub at your forehead to try and get sensation back into it; it takes several minutes before full feeling returns.  <b>When it does, you look again at yourself and see a raccoon's pointy face, appointed with numerous whiskers and a black nose!</b>
				changes++;
				setFaceType(Face.RACCOON);
			}
			//fatigue damage (only if face change was not triggered)
			else if (rand(2) == 0 && changes < changeLimit && (player.faceType != Face.RACCOON_MASK && player.faceType != Face.RACCOON)) {
				outputText("\n\nYou suddenly feel tired and your eyelids are quite heavy.  Checking your reflection, you can see small dark rings have begun to form under your eyes.");
				fatigue(10);
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nYawning, you figure you could really use a nap.");
				fatigue(5);
			}
			player.refillHunger(30);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//MouseCo
//tooltip:
//A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.


//Mouse Cocoa/MousCoco (you can change the name if you're saddlesore I guess but I'll make fun of you for having no plausible source of chocolate for your bakery if you do)
		public function mouseCocoa(type:Number,player:Player):void
		{
			clearOutput();
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//use:
			if (type == 0) {
				outputText("You pop several of the beans in your mouth and suck; they immediately reward you by giving up an oily, chocolatey flavor with a hint of bitterness.  For several minutes you ");
				if (!player.isTaur()) outputText("sit and ");
				outputText("enjoy the taste.");
			}
			if (type == 1) outputText("You heat yourself a cup of the exotic alcohol and sip it. It tastes great, but leaves you somewhat tipsy. You also feel yourself pleasantly warming up from the sake as something changes in you.");
			//stat changes:
			//lose height + gain speed (42" height floor, no speed ceiling but no speed changes without height change)
			if (player.tallness >= 45 && changes < changeLimit && rand(5) > 2) {
				//not horse
				if (!player.isTaur()) outputText("\n\nYou tap your [feet] idly against the rock you sit upon as you enjoy the treat; it takes several minutes before you realize you don't reach as far down as you did when you sat down!  In shock, you jerk upright and leap off, nearly falling forward as your body moves more responsively than before!  Experimentally, you move in place as you look down at your now-closer [feet]; the sensation of a more compact agility stays with you.");
				//horse
				else outputText("\n\nYou trot idly in place as you eat, moving quicker and quicker as you become increasingly bored; on one step, the ground sneaks up on you and you hit it sharply, expecting a few more inches before contact!  Looking down, you notice better resolution than before - you can make out the dirt a bit more clearly.  It looks like you just shed some height, but... you're feeling too jittery to care.  You just want to run around.");
				dynStats("spe", 1);
				player.tallness--;
				if (player.tallness > 50) player.tallness--;
				if (player.tallness > 60) player.tallness--;
				if (player.tallness > 70) player.tallness -= 2;
				if (player.tallness > 80) player.tallness -= 2;
				if (player.tallness > 90) player.tallness -= 2;
				changes++;
			}
			//lose tough
			if (player.tou > 50 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel a bit less sturdy, both physically and mentally.  In fact, you'd prefer to have somewhere to hide for the time being, until your confidence returns.  The next few minutes are passed in a mousey funk - even afterward, you can't quite regain the same sense of invincibility you had before.");
				changes++;
				dynStats("tou", -1);
				if (player.tou >= 75) dynStats("tou", -1);
				if (player.tou >= 90) dynStats("tou", -1);
			}

			//SEXYYYYYYYYYYY
			//vag-anal capacity up for non-goo (available after PC < 5 ft; capacity ceiling reasonable but not horse-like or gooey)
			if (player.tallness < 60 && (player.analCapacity() < 100 || (player.vaginalCapacity() < 100 && player.hasVagina())) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour ");
				if (player.vaginalCapacity() < 100 && player.hasVagina()) outputText("[vagina]");
				else outputText("[asshole]");
				outputText(" itches, and you shyly try to scratch it, looking around to see if you're watched.  ");
				if (player.isTaur()) outputText("Backing up to a likely rock, you rub your hindquarters against it, only to be surprised when you feel your hole part smoothly against the surface, wider than you're used to!");
				else outputText("Slipping a hand in your [armor], you rub vigorously; your hole opens more easily and your fingers poke in farther than you're used to!");
				outputText("  It feels unusual - not bad, really, but definitely weird.  You can see how it would come in handy, now that you're smaller than most prospective partners, but... shaking your head, you ");
				if (player.isTaur()) outputText("back away from your erstwhile sedimentary lover");
				else outputText("pull your hand back out");
				outputText(".");
				//adds some lust
				dynStats("lus", 10 + player.sens / 5);
				if (player.vaginalCapacity() < 100 && player.hasVagina()) {
					if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				}
				else {
					if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 5);
				}
				changes++;
			}
			//fem fertility up and heat (suppress if pregnant)
			//not already in heat (add heat and lust)
			if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(2) == 0 && changes < changeLimit) {

        var intensified:Boolean = player.inHeat;
        if(player.goIntoHeat(false)) {
			if(intensified) {
  				outputText("\n\nYour womb feels achingly empty, and your temperature shoots up.  Try as you might, you can't stop fantasizing about being filled with semen, drenched inside and out with it, enough to make a baker's dozen offspring.  ");
  				//[(no mino cum in inventory)]
  				if (!player.hasItem(consumables.MINOCUM)) {
  					outputText("<b>Your heat has intensified as much as your fertility has increased, which is a considerable amount!</b>");
  				}
  				else if (player.lust < player.maxLust() || player.isTaur()) outputText("You even pull out a bottle of minotaur jism and spend several minutes considering the feasibility of pouring it directly in your [vagina], but regain your senses as you're unsealing the cap, setting it aside.  <b>Still, your heat is more intense than ever and your increasingly-fertile body is practically begging for dick - it'll be hard to resist any that come near!</b>");
  				//(mino cum in inventory and non-horse, 100 lust)
  				else {
  					outputText("Desperately horny, you pull out your bottle of minotaur jism and break the seal in two shakes, then lie down with your hips elevated and upend it over your greedy vagina.  The gooey seed pours into you, and you orgasm fitfully, shaking and failing to hold the bottle in place as it coats your labia.  <b>As a hazy doze infiltrates your mind, you pray the pregnancy takes and dream of the sons you'll bear with your increasingly fertile body... you're going to go insane if you don't get a baby in you</b>.");
  					//(consumes item, increment addiction/output addict message, small chance of mino preg, reduce lust)]", false);
  					player.minoCumAddiction(5);
					if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(25);
					player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR, 175);
  					player.consumeItem(consumables.MINOCUM);
  				}
			}
			else {
  				outputText("\n\nYour insides feel... roomy.  Accomodating, even.  You could probably carry a whole litter of little [name]s right now.  Filled with a sudden flush of desire, you look around furtively for any fertile males.  With a shake of your head, you try to clear your thoughts, but daydreams of being stuffed with seed creep right back in - it looks like your body is intent on probing the limits of your new fertility.  <b>You're in heat, and pregnable in several senses of the word!</b>");
            // Also make a permanent nudge.
  				player.fertility++;
			}
			changes++;
		}
		}
			//bodypart changes:
			//gain ears
			if (player.ears.type != Ears.MOUSE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour ears ");
				if (player.ears.type == Ears.HORSE || player.ears.type == Ears.COW || player.ears.type == Ears.DOG || player.ears.type == Ears.BUNNY || player.ears.type == Ears.KANGAROO) outputText("shrink suddenly");
				else outputText("pull away from your head");
				outputText(", like they're being pinched, and you can distinctly feel the auricles taking a rounded shape through the pain.  Reaching up to try and massage away their stings, <b>you're not terribly surprised when you find a pair of fuzzy mouse's ears poking through your [hair].</b>");
				setEarType(Ears.MOUSE);
				changes++;
			}
			//gain tail
			//from no tail
			if (player.ears.type == Ears.MOUSE && player.tailType != Tail.MOUSE && changes < changeLimit && rand(3) == 0 && type == 0) {
				//from other tail
				if (player.tailType > Tail.NONE) {
					outputText("\n\nYour tail clenches and itches simultaneously, leaving you wondering whether to cry out or try to scratch it.  The question is soon answered as the pain takes the forefront; looking backward is a horrible strain, but when you manage it, you can see your old appendage ");
					if (player.tailType == Tail.HORSE) outputText("elongating");
					else outputText("compressing");
					outputText(" into a long, thin line.  With a shudder, it begins to shed until it's completely, starkly nude.  <b>Your new mouse tail looks a bit peaked.</b>");
				}
				else outputText("\n\nA small nub pokes from your backside, and you turn to look at it.  When you do, your neck aches as if whiplashed, and you groan as your spine shifts smoothly downward like a rope being pulled, growing new vertebra behind it and expanding the nub into a naked, thin, tapered shape.  <b>Rubbing at your sore neck, you stare at your new mouse tail.</b>");
				setTailType(Tail.MOUSE);
				changes++;
			}
			if (player.ears.type == Ears.MOUSE && player.tailType != Tail.HINEZUMI && changes < changeLimit && rand(3) == 0 && type == 1) {
				if (player.tailType > Tail.NONE) outputText("\n\nY");
				else outputText("\n\nA small nub pokes from your backside, and you turn to look at it.  Y");
				outputText("ou jump in surprise as your tail suddenly sparks and lights ablaze. Oddly, it doesn’t hurt. Your tail doesn’t seem to burn your own skin but whatever it touches is set aflame. Pondering how difficult it will be to move around without torching everything, your tail’s fire suddenly dies down. Seems you can light it up or extinguish it at will.  <b>You now have a fiery mouse tail!</b>");
				setTailType(Tail.HINEZUMI);
				changes++;
			}
			//gain legs
			if (player.lowerBody != LowerBody.MOUSE && player.tailType == Tail.MOUSE && changes < changeLimit && rand(3) == 0 && type == 0) {
				outputText("\n\nYour legs begins to change covering up to the tight with a thin layer of fur. Your feet distort to takes on a more animalistic appearance and the nails sharpens to points more like mouses claws. <b>Seems you now got mouses leg paws now.</b>");
				setLowerBody(LowerBody.MOUSE);
				player.legCount = 2;
			}
			if (player.lowerBody != LowerBody.HINEZUMI && player.tailType == Tail.HINEZUMI && changes < changeLimit && rand(3) == 0 && type == 1) {
				outputText("\n\nYour legs grow increasingly hot until suddenly they light up and start blazing, just like your tail. Well wow! Kicking with these is sure to pack an extra punch. The fur under your fiery coat doesn’t seem to burn either, but you're pretty sure anything that gets a kick from your legs is in for a painful experience. <b>You now have blazing mouse legs!</b>");
				setLowerBody(LowerBody.HINEZUMI);
				player.legCount = 2;
			}
			//gain arms
			if (player.arms.type != Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && changes < changeLimit && rand(3) == 0 && type == 1) {
				outputText("\n\nYou suddenly feel like your forearms are burning. Burning they indeed begin to do, as they suddenly start blazing, a thick coat of fire covering them up to the fist. That’s going to be a very interesting ability to use in combat. <b>You now have blazing arms!</b>");
				setArmType(Arms.HINEZUMI);
			}
			//get hinezumi eyes
			if (player.eyes.type != Eyes.HINEZUMI && player.eyes.type == Eyes.HUMAN && rand(3) == 0 && changes < changeLimit && type == 1) {
				outputText("\n\nYour eyes start to hurt and as a reaction, you start shedding tears. Once your vision clears, you head to a puddle to check what is going on. <b>To your surprise, it seems your irises turned blazing red like those of an Hinezumi.</b>");
				setEyeTypeAndColor(Eyes.HINEZUMI,"blazing red");
				changes++;
			}
			//Remove odd eyes
			if (player.eyes.type != Eyes.HUMAN && player.eyes.type != Eyes.HINEZUMI && rand(2) == 0 && changes < changeLimit && type == 1) {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				if (player.eyes.type == Eyes.FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
				else if (player.eyes.type == Eyes.CAT_SLITS) outputText("  Your cat-like eyes are gone!</b>");
				outputText("  <b>You have normal, humanoid eyes again.</b>");
				setEyeType(Eyes.HUMAN);
				changes++;
			}
			//Hair
			if ((player.faceType == Face.BUCKTEETH || player.faceType == Face.MOUSE) && player.hairType != Hair.BURNING && changes < changeLimit && rand(3) == 0 && type == 1) {
				if (rand(3) == 0) {
					player.hairColor = "red";
				} else {
					if (rand (2) == 0) player.hairColor = "orange";
					else player.hairColor = "pinkish orange";
				}
				outputText("\n\nSomething weird happen in your hairs. The strands coloration slowly shift to a [haircolor] hue and to your absolute surprise the tips turns incandescent like embers. There's no doubt to the heat your hairs now produce as if the tips were on fire. <b>Better keep watch not to set anything on fire with your fiery hairs now.</b>");
				setHairType(Hair.BURNING);
				changes++;
			}
			//get fur
			if ((!player.hasFur() || (player.hasFur() && (player.coatColor != "brown" && player.coatColor != "white"))) && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				var color:String;
				if (rand(10) < 8) {
					player.coatColor = "brown";
				} else {
					player.coatColor = "white";
				}
				//from skinscales
				if (!player.hasFur()) {
					outputText("\n\nYour [skin] "+player.skin.isAre("itches","itch")+outputText(" all over"));
					if (player.tailType > Tail.NONE) outputText(", except on your tail");
					outputText(".  Alarmed and suspicious, you tuck in your hands, trying to will yourself not to scratch, but it doesn't make much difference.  Tufts of "+player.coatColor+" fur begin to force through your skin");
					if (player.hasScales()) outputText(", pushing your scales out with little pinches");
					outputText(", resolving the problem for you.  <b>You now have fur.</b>");
					player.skin.growCoat(Skin.FUR, {color:player.coatColor});
					if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
						outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
					}
				}
				//from other color fur
				else {
					player.skin.coat.color = color;
					outputText("\n\nYour fur stands on end, as if trying to leap from your body - which it does next.  You watch, dumb with shock, as your covering deserts you, but it's quickly replaced with another layer of "+player.coatColor+" fuzz coming in behind it that soon grows to full-fledged fur.");
				}
				changes++;
			}
			//get partial fur form full or full from partial fur
			if (player.hasFur() && rand(3) == 0 && changes < changeLimit) {
				if (player.skin.coverage == Skin.COVERAGE_COMPLETE || player.skin.coverage == Skin.COVERAGE_HIGH) {
					outputText("\n\nWhat used to be a dense coat of fur begins to fall in patches on the ground leaving you with just enough fur to cover some area of your body.  <b>Some area of your body are now partially covered with fur!</b>");
					player.skin.coverage = Skin.COVERAGE_LOW;
					changes++;
				}
				else {
					outputText("\n\nYou feel your skin tickle as more fur grows to cover the areas you did not already had fur at. Guess you have truly joined the furry club now.  <b>Your skin is now entirely coated with fur.</b>");
					player.skin.coverage = Skin.COVERAGE_COMPLETE;
					changes++;
				}
			}
			//get teeth - from human, bunny, coonmask, or other humanoid teeth faces
			if (player.ears.type == Ears.MOUSE && (player.faceType == Face.HUMAN || player.faceType == Face.SHARK_TEETH || player.faceType == Face.BUNNY || player.faceType == Face.SPIDER_FANGS || player.faceType == Face.RACCOON_MASK) && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour teeth grind on their own, and you feel a strange, insistent pressure just under your nose.  As you open your mouth and run your tongue along them, you can feel ");
				if (player.faceType != Face.HUMAN) outputText("the sharp teeth receding and ");
				outputText("your incisors lengthening.  It's not long before they're twice as long as their neighbors and the obvious growth stops, but the pressure doesn't go away completely.  <b>Well, you now have mouse incisors and your face aches a tiny bit - wonder if they're going to keep growing?</b>");
				setFaceType(Face.BUCKTEETH);
				changes++;
			}
			//get mouse muzzle from mouse teeth or other muzzle
			if (player.hasFur() && player.faceType != Face.MOUSE && (player.faceType != Face.HUMAN || player.faceType != Face.SHARK_TEETH || player.faceType != Face.BUNNY || player.faceType != Face.SPIDER_FANGS || player.faceType != Face.RACCOON_MASK) && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA wave of light-headedness hits you, and you black out.  In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn't taste like anything much.  For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken.  Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection.  <b>Your face has shifted to resemble a mouse's, down to the whiskers!</b>");
				setFaceType(Face.MOUSE);
				changes++;
			}
			//get mouse teeth from mouse muzzle
			if (player.hasFur() && player.faceType == Face.MOUSE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour mouse face begins to change as if melting. When you pass your hand over it you discover to your surprise its back to being human.or well it would be if not for your buck teeth way larger than normal.  <b>Your face is now human save for your two incisor like buck teeth.</b>");
				setFaceType(Face.BUCKTEETH);
				changes++;
			}
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//special attack - bite?
//tooth length counter starts when you get teef, mouse bite gets more powerful over time as teeth grow in
//hit
//You sink your prominent incisors deep into your foe.  They're not as sharp as a predator's, but even a mouse bites when threatened, and you punch quite a large hole.
//miss
//You attempt to turn and bite your foe, but " + monster.pronoun1 + " pulls back deftly and your jaws close on empty air.

//perk - fuck if i know
//maybe some pregnancy-accelerating thing

		private function demonChanges(player:Player):void
		{
			//Change tail if already horned.
			if (player.tailType != Tail.DEMONIC && player.lowerBody != LowerBody.GARGOYLE && player.horns.count > 0) {
				if (player.tailType != Tail.NONE) {
					outputText("\n\n");
					if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ");
					else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ");
					outputText("<b>Your tail is now demonic in appearance.</b>");
				}
				else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
				dynStats("cor", 4);
				setTailType(Tail.DEMONIC);
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//grow horns!
			if (player.lowerBody != LowerBody.GARGOYLE && (player.horns.count == 0 || (rand(player.horns.count + 3) == 0))) {
				if (player.horns.type == Horns.NONE) {
					outputText("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>");
					setHornType(Horns.DEMON, 2);
				} else if (player.horns.count < 12 && player.horns.type == Horns.DEMON) {
					outputText("\n\n");
					outputText("Another pair of demon horns, larger than the last, forms behind the first row.");
					player.horns.count++;
					player.horns.count++;
					dynStats("cor", 3);
				}
				//Text for shifting horns
				else if (player.horns.type != Horns.DEMON && player.horns.type != Horns.ORCHID) {
					outputText("\n\n");
					outputText("Your horns shift, shrinking into two small demonic-looking horns.");
					setHornType(Horns.DEMON, 2);
					dynStats("cor", 3);
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && rand(2) == 0) {
				outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				player.removeStatusEffect(StatusEffects.BlackNipples);
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//remove fur
			if ((player.faceType != Face.HUMAN || !player.hasPlainSkinOnly()) && player.lowerBody != LowerBody.GARGOYLE && rand(2) == 0) {
				//Remove face before fur!
				if (player.faceType != Face.HUMAN) {
					outputText("\n\n");
					outputText("Your visage twists painfully, returning to a more normal human shape, albeit with flawless skin.  <b>Your face is human again!</b>");
					setFaceType(Face.HUMAN);
				}
				//De-fur
				else if (!player.hasPlainSkinOnly()) {
					outputText("\n\n");
					if (player.hasFur()) outputText("Your skin suddenly feels itchy as your fur begins falling out in clumps, <b>revealing inhumanly smooth skin</b> underneath.");
					if (player.hasScales()) outputText("Your scales begin to itch as they begin falling out in droves, <b>revealing your inhumanly smooth " + player.skinTone + " skin</b> underneath.");
					player.skin.setBaseOnly({type:Skin.PLAIN});
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Demon tongue
			if (player.tongue.type != Tongue.DEMONIC && rand(2) == 0) {
				outputText("\n\nYour tongue tingles");
				if (player.tongue.type != Tongue.HUMAN) outputText(", thickening in your mouth until it feels more like your old human tongue, at least for the first few inches");
				outputText(".  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>");
				setTongueType(Tongue.DEMONIC);
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(4) == 0) {
				humanizeArms();
				changes++;
			}
			//foot changes - requires furless
			if (player.hasPlainSkinOnly() && rand(3) == 0) {
				//Males/genderless get clawed feet
				if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
					if (player.lowerBody != LowerBody.DEMONIC_CLAWS) {
						outputText("\n\n");
						outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>");
						setLowerBody(LowerBody.DEMONIC_CLAWS);
						player.legCount = 2;
					}
				}
				//Females/futa get high heels
				else if (player.lowerBody != LowerBody.DEMONIC_HIGH_HEELS) {
					outputText("\n\n");
					outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horns protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.");
					setLowerBody(LowerBody.DEMONIC_HIGH_HEELS);
					player.legCount = 2;
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Grow demon wings
			if (!InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.BAT_LIKE_LARGE_2) && rand(3) == 0 && player.cor >= 50) {
				//grow smalls to large
				if (player.wings.type == Wings.BAT_LIKE_TINY && player.cor >= 75) {
					outputText("\n\n");
					outputText("Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>");
					setWingType(Wings.BAT_LIKE_LARGE, "large, bat-like");
				}
				//split large wings to two pairs
				else if (player.wings.type == Wings.BAT_LIKE_LARGE && player.cor >= 75) {
					outputText("\n\n");
					outputText("Your large demonic wings starts to tremble and then starts to split from the tip.  You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings.  <b>Your demonic wings have split into two pairs!</b>");
					setWingType(Wings.BAT_LIKE_LARGE_2, "two large pairs of bat-like");
				}
				else if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.BEE_LIKE_SMALL || player.wings.type == Wings.BEE_LIKE_LARGE || player.wings.type == Wings.MANTIS_LIKE_SMALL || player.wings.type == Wings.MANTIS_LIKE_LARGE || player.wings.type == Wings.MANTICORE_LIKE_SMALL || player.wings.type == Wings.MANTICORE_LIKE_LARGE) {
					outputText("\n\n");
					outputText("The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing.  You twist your head as far as you can for a look and realize they've changed into ");
					if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.BEE_LIKE_SMALL || player.wings.type == Wings.MANTIS_LIKE_SMALL || player.wings.type == Wings.MANTICORE_LIKE_SMALL) {
						outputText("small <b>bat-like demon-wings!</b>");
						setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
					}
					else {
						outputText("large <b>bat-like demon-wings!</b>");
						setWingType(Wings.BAT_LIKE_LARGE, "large, bat-like");
					}
				}
				else {
					outputText("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by small <b>bat-like demon-wings!</b>");
					setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
				}
				//No wings
				if (player.wings.type == Wings.NONE) {
					outputText("\n\n");
					outputText("A knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor].  <b>You now have tiny demonic wings</b>.");
					setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
		}
		
		//Ferret Fruit
		public function ferretTF(player:Player):void {
			//CoC Ferret TF (Ferret Fruit)
			//Finding Ferret Fruit
			//- Ferret Fruit may be randomly found while exploring the plains.
			//- Upon finding Ferret Fruit: “While searching the plains, you find an odd little tree with a curved trunk. The shape of its fruit appears to mimic that of the tree. A few of the fruits seem to have fallen off. You brush the dirt off of one of the fruits before placing in in your (x) pouch. (if there is no room in your inventory, you get the generic option to use now or abandon)
			//- If you hover over the fruit in your inventory, this is its description:  “This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.”
			//-Upon eating the fruit:
			clearOutput();
			outputText("Feeling parched, you gobble down the fruit without much hesitation. Despite the skin being fuzzy like a peach, the inside is relatively hard, and its taste reminds you of that of an apple.  It even has a core like an apple. Finished, you toss the core aside.");

			//BAD END:
			if(player.ferretScore() >= 6 && player.findPerk(PerkLib.TransformationResistance) < 0)
			{
				//Get warned!
				if(flags[kFLAGS.FERRET_BAD_END_WARNING] == 0) {
					outputText("\n\nYou find yourself staring off into the distance, dreaming idly of chasing rabbits through a warren.  You shake your head, returning to reality.  <b>Perhaps you should cut back on all the Ferret Fruit?</b>");
					player.inte -= 5 + rand(3);
					if(player.inte < 5) player.inte = 5;
					flags[kFLAGS.FERRET_BAD_END_WARNING] = 1;
				}
				//BEEN WARNED! BAD END! DUN DUN DUN
				else if(rand(3) == 0)
				{
					//-If you fail to heed the warning, it’s game over:
					outputText("\n\nAs you down the fruit, you begin to feel all warm and fuzzy inside.  You flop over on your back, eagerly removing your clothes.  You laugh giddily, wanting nothing more than to roll about happily in the grass.  Finally finished, you attempt to get up, but something feels...  different.  Try as you may, you find yourself completely unable to stand upright for a long period of time.  You only manage to move about comfortably on all fours.  Your body now resembles that of a regular ferret.  That can’t be good!  As you attempt to comprehend your situation, you find yourself less and less able to focus on the problem.  Your attention eventually drifts to a rabbit in the distance.  You lick your lips. Nevermind that, you have warrens to raid!");
					EventParser.gameOver();
					return;
				}
			}
			//Reset the warning if ferret score drops.
			else
			{
				flags[kFLAGS.FERRET_BAD_END_WARNING] = 0;
			}

			var changes:int = 0;
			var changeLimit:int = 1;
			var temp:int = 0;
			var x:int = 0;
			if(rand(2) == 0) changeLimit++;
			if(rand(2) == 0) changeLimit++;
			if(rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//Ferret Fruit Effects
			//- + Thin:
			if(player.thickness > 15 && changes < changeLimit && rand(3) == 0)
			{
				outputText("\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+2 thin)");
				player.thickness -=2;
				changes++;
			}
			//- If speed is > 80, increase speed:
			if (player.spe < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour muscles begin to twitch rapidly, but the feeling is not entirely unpleasant.  In fact, you feel like running.");
				dynStats("spe",1);
				changes++;
			}
			//- If male with a hip rating >4 or a female/herm with a hip rating >6:
			if(((!player.hasCock() && player.hips.type > 6) || (player.hasCock() && player.hips.type > 4)) && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nA warm, tingling sensation arises in your [hips].  Immediately, you reach down to them, concerned.  You can feel a small portion of your [hips] dwindling away under your hands.");
				player.hips.type--;
				if(player.hips.type > 10) player.hips.type--;
				if(player.hips.type > 15) player.hips.type--;
				if(player.hips.type > 20) player.hips.type--;
				if(player.hips.type > 23) player.hips.type--;
				changes++;
			}
			//- If butt rating is greater than “petite”:
			if(player.butt.type >= 8 && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou cringe as your [butt] begins to feel uncomfortably tight.  Once the sensation passes, you look over your shoulder, inspecting yourself.  It would appear that your ass has become smaller!");
				player.butt.type--;
				if(player.butt.type > 10) player.butt.type--;
				if(player.butt.type > 15) player.butt.type--;
				if(player.butt.type > 20) player.butt.type--;
				if(player.butt.type > 23) player.butt.type--;
				changes++;
			}

			//-If male with breasts or female/herm with breasts > B cup:
			if(!flags[kFLAGS.HYPER_HAPPY] && (player.biggestTitSize() > 2 || (player.hasCock() && player.biggestTitSize() >= 1)) && rand(2) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou cup your tits as they begin to tingle strangely.  You can actually feel them getting smaller in your hands!");
				for(x = 0; x < player.bRows(); x++)
				{
					if(player.breastRows[x].breastRating > 2 || (player.hasCock() && player.breastRows[x].breastRating >= 1))
					{
						player.breastRows[x].breastRating--;
					}
				}
				changes++;
				//(this will occur incrementally until they become flat, manly breasts for males, or until they are A or B cups for females/herms)
			}
			//-If penis size is > 6 inches:
			if(player.hasCock())
			{
				//Find longest cock
				temp = -1;
				for(x = 0; x < player.cockTotal(); x++)
				{
					if(temp == -1 || player.cocks[x].cockLength > player.cocks[temp].cockLength) temp = x;
				}
				if(temp >= 0 && rand(2) == 0 && changes < changeLimit)
				{
					if(player.cocks[temp].cockLength > 6 && !flags[kFLAGS.HYPER_HAPPY])
					{
						outputText("\n\nA pinching sensation racks the entire length of your " + cockDescript(temp) + ".  Within moments, the sensation is gone, but it appears to have become smaller.");
						player.cocks[temp].cockLength--;
						if(rand(2) == 0) player.cocks[temp].cockLength--;
						if(player.cocks[temp].cockLength >= 9) player.cocks[temp].cockLength -= rand(3) + 1;
						if(player.cocks[temp].cockLength/6 >= player.cocks[temp].cockThickness)
						{
							outputText("  Luckily, it doen’t seem to have lost its previous thickness.");
						}
						else
						{
							player.cocks[temp].cockThickness = player.cocks[temp].cockLength/6;
						}
						changes++;
					}
				}
			}
			//-If the PC has quad nipples:
			if(player.averageNipplesPerBreast() > 1 && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts.  <b>You are left with only one nipple on each breast.</b>");
				for(x = 0; x < player.bRows(); x++)
				{
					player.breastRows[x].nipplesPerBreast = 1;
				}
				changes++;
			}
			//If the PC has gills:
			if (player.hasGills() && rand(4) == 0 && changes < changeLimit) updateGills();
			//	outputText("\n\nYou grit your teeth as a stinging sensation arises in your gills.  Within moments, the sensation passes, and <b>your gills are gone!</b>");
 			//If the PC has tentacle hair:
			if(player.hairType == Hair.ANEMONE && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nYour head feels strange as the tentacles you have for hair begin to recede back into your scalp, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of hair sprouts from the skin of your scalp.  <b>Your hair is normal again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				setHairType(Hair.NORMAL);
				changes++;
			}
			//If the PC has goo hair:
			if(player.hairType == Hair.GOO && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of hair sprouts from the skin of your scalp.  <b>Your hair is normal again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				setHairType(Hair.NORMAL);
				changes++;
			}
			//If the PC has four eyes:
			if(player.eyes.type == Eyes.FOUR_SPIDER_EYES && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYour two forehead eyes start throbbing painfully, your sight in them eventually going dark.  You touch your forehead to inspect your eyes, only to find out that they have disappeared.  <b>You only have two eyes now!</b>");
				humanizeEyes();
				changes++;
			}
			//Go into heat
			if (rand(3) == 0 && changes < changeLimit) {
				if(player.goIntoHeat(true)) {
						changes++;
				}
			}
			//Turn ferret mask to full furface.
			if(player.faceType == Face.FERRET_MASK && player.hasFur() && player.ears.type == Ears.FERRET && player.tailType == Tail.FERRET && player.lowerBody == LowerBody.FERRET && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange.  You rub your face furiously in an attempt to ease the pain, but to no avail.  As the sensations pass, you examine your face in a nearby puddle.  <b>You nearly gasp in shock at the sight of your new ferret face!</b>");
				setFaceType(Face.FERRET);
				changes++;
			}
			//If face is human:
			if(player.faceType == 0 && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nA horrible itching begins to encompass the area around your eyes.  You grunt annoyedly, rubbing furiously at the afflicted area.  Once the feeling passes, you make your way to the nearest reflective surface to see if anything has changed.  Your suspicions are confirmed.  The [skinFurScales] around your eyes has darkened.  <b>You now have a ferret mask!</b>");
				setFaceType(Face.FERRET_MASK);
				changes++;
			}
			//If face is not ferret, has ferret ears, tail, and legs:
			if(player.faceType != Face.HUMAN && player.faceType != Face.FERRET_MASK && player.faceType != Face.FERRET && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou groan uncomfortably as the bones in your [face] begin to rearrange.  You grab your head with both hands, rubbing at your temples in an attempt to ease the pain.  As the shifting stops, you frantically feel at your face.  The familiar feeling is unmistakable.  <b>Your face is human again!</b>");
				setFaceType(Face.HUMAN);
				changes++;
			}
			//No fur, has ferret ears, tail, and legs:
			if(!player.hasFur() && player.ears.type == Ears.FERRET && player.tailType == Tail.FERRET && player.lowerBody == LowerBody.FERRET && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nYour skin starts to itch like crazy as a thick coat of fur sprouts out of your skin.");
				//If hair was not sandy brown, silver, white, or brown
				if(player.hairColor != "sandy brown" && player.hairColor != "silver" && player.hairColor != "white" && player.hairColor != "brown")
				{
					outputText("\n\nOdder still, all of your hair changes to ");
					if(rand(4) == 0) player.hairColor = "sandy brown";
					else if(rand(3) == 0) player.hairColor = "silver";
					else if(rand(2) == 0) player.hairColor = "white";
					else player.hairColor = "brown";
					outputText(".");
				}
				player.skin.growCoat(Skin.FUR,{color:player.hairColor});
				outputText("  <b>You now have [skin coat.color] fur!</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//Tail TFs!
			if(player.tailType != Tail.FERRET && player.ears.type == Ears.FERRET && rand(3) == 0 && changes < changeLimit)
			{
				//If ears are ferret, no tail:
				if(player.tailType == 0)
				{
					outputText("\n\nYou slump to the ground as you feel your spine lengthening and twisting, sprouting fur as it finishes growing.  Luckily the new growth does not seem to have ruined your [armor].  <b>You now have a ferret tail!</b>");
				}
				//Placeholder for any future TFs that will need to be made compatible with this one
				//centaur, has ferret ears:
				else if(player.tailType == Tail.HORSE && player.isTaur()) outputText("\n\nYou shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  This new, mismatched tail looks a bit odd on your horse lower body.  <b>You now have a ferret tail!</b>");
				//If tail is harpy, has ferret ears:
				else if(player.tailType == Tail.HARPY) outputText("\n\nYou feel a soft tingle as your tail feathers fall out one by one.  The little stump that once held the feathers down begins to twist and lengthen before sprouting soft, fluffy fur.  <b>You now have a ferret tail!</b>");
				//If tail is bunny, has ferret ears:
				else if(player.tailType == Tail.RABBIT) outputText("\n\nYou feel a pressure at the base of your tiny, poofy bunny tail as it begins to lengthen, gaining at least another foot in length.  <b>You now have a ferret tail!</b>");
				//If tail is reptilian/draconic, has ferret ears:
				else if(player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD) outputText("\n\nYou reach a hand behind yourself to rub at your backside as your tail begins to twist and warp, becoming much thinner than before.  It then sprouts a thick coat of fur.  <b>You now have a ferret tail!</b>");
				//If tail is cow, has ferret ears:
				else if(player.tailType == Tail.COW) outputText("\n\nYour tail begins to itch slightly as the poof at the end of your tail begins to spread across its entire surface, making all of its fur much more dense than it was before. It also loses a tiny bit of its former length. <b>You now have a ferret tail!</b>");
				//If tail is cat, has ferret ears:
				else if(player.tailType == Tail.CAT) outputText("\n\nYour tail begins to itch as its fur becomes much denser than it was before.  It also loses a tiny bit of its former length.  <b>You now have a ferret tail!</b>");
				//If tail is dog, has ferret ears:
				else if(player.tailType == Tail.DOG) outputText("\n\nSomething about your tail feels... different.  You reach behind yourself, feeling it.  It feels a bit floppier than it was before, and the fur seems to have become a little more dense.  <b>You now have a ferret tail!</b>");
				//If tail is kangaroo, has ferret ears:
				else if(player.tailType == Tail.KANGAROO) outputText("\n\nYour tail becomes uncomfortably tight as the entirety of its length begins to lose a lot of its former thickness.  The general shape remains tapered, but its fur has become much more dense and shaggy.  <b>You now have a ferret tail!</b>");
				//If tail is fox, has ferret ears:
				else if(player.tailType == Tail.FOX) outputText("\n\nYour tail begins to itch as its fur loses a lot of its former density.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>");
				//If tail is raccoon, has ferret ears:
				else if(player.tailType == Tail.RACCOON) outputText("\n\nYour tail begins to itch as its fur loses a lot of its former density, losing its trademark ring pattern as well.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>");
				//If tail is horse, has ferret ears:
				else if(player.tailType == Tail.HORSE) outputText("\n\nYou shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  <b>You now have a ferret tail!</b>");
				//If tail is mouse, has ferret ears:
				else if(player.tailType == Tail.MOUSE) outputText("\n\nYour tail begins to itch as its bald surface begins to sprout a thick layer of fur.  It also appears to have lost a bit of its former length.  <b>You now have a ferret tail!</b>");
				else outputText("\n\nYour tail begins to itch a moment before it starts writhing, your back muscles spasming as it changes shape. Before you know it, <b>your tail has reformed into a narrow, ferret's tail.</b>");
				setTailType(Tail.FERRET);
				changes++;
			}
			//If naga, has ferret ears:
			//(NOTE: this is the only exception to the legs coming after the tail, as the ferret tail will only go away right after it appears because of your snake lower half)
			else if(player.isNaga() && player.ears.type == Ears.FERRET && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou scream in agony as a horrible pain racks the entire length of your snake-like coils.  Unable to take it anymore, you pass out.  When you wake up, you’re shocked to find that you no longer have the lower body of a snake.  Instead, you have soft, furry legs that resemble that of a ferret’s.  <b>You now have ferret legs!</b>");
				changes++;
				setLowerBody(LowerBody.FERRET);
				player.legCount = 2;
			}
			//If legs are not ferret, has ferret ears and tail
			if(player.lowerBody != LowerBody.FERRET && player.ears.type == Ears.FERRET && player.tailType == Tail.FERRET && rand(4) == 0 && changes < changeLimit)
			{
				//-If centaur, has ferret ears and tail:
				if(player.isTaur()) outputText("\n\nYou scream in agony as a horrible pain racks your entire horse lower half.  Unable to take it anymore, you pass out.  When you wake up, you’re shocked to find that you no longer have the lower body of a horse.  Instead, you have soft, furry legs that resemble that of a ferret’s.  <b>You now have ferret legs!</b>");

				outputText("\n\nYou scream in agony as the bones in your legs begin to break and rearrange.  Even as the pain passes, an uncomfortable combination of heat and throbbing continues even after the transformation is over.  You rest for a moment, allowing the sensations to subside.  Now feeling more comfortable, <b>you stand up, ready to try out your new ferret legs!</b>");
				changes++;
				setLowerBody(LowerBody.FERRET);
				player.legCount = 2;
			}
			//If ears are not ferret:
			if(player.ears.type != Ears.FERRET && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou squint as you feel a change in your ears.  Inspecting your reflection in a nearby puddle you find that <b>your ears have become small, fuzzy, and rounded, just like a ferret’s!</b>");
				setEarType(Ears.FERRET);
				changes++;
			}
			//If no other effect occurred, fatigue decreases:
			if(changes == 0)
			{
				outputText("\n\nYour eyes widen.  With the consumption of the fruit, you feel much more energetic.  You’re wide awake now!");
				changes++;
				fatigue(-10);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function pigTruffle(boar:Boolean, player:Player):void {
			var changes:int = 0;
			var changeLimit:int = 1;
			var temp:int = 0;
			var x:int = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (boar) changeLimit++;
			changeLimit += additionalTransformationChances();
			outputText("You take a bite into the pigtail truffle. It oddly tastes like bacon. You eventually finish eating. ");
			player.refillHunger(20);
			if (player.str < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour fill your muscles filling with might.");
				dynStats("str", 1);
				changes++;
			}
			if (player.tou < 100 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
				dynStats("tou", 1);
				changes++;
			}
			if (player.spe > 50 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
				dynStats("spe", -1);
				changes++;
			}
			if (player.inte > 15 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
				dynStats("int", -1);
				changes++;
			}
			//-----------------------
			// BAD END ALERT!
			//-----------------------
			if (rand(5) == 0 && player.pigScore() >= 9 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				if (flags[kFLAGS.PIG_BAD_END_WARNING] == 0) {
					outputText("\n\nYou find yourself idly daydreaming of flailing about in the mud, letting go of all of your troubles. Eventually, you shake off the thought. Why would you do something like that? Maybe you should cut back on all the truffles?");
					flags[kFLAGS.PIG_BAD_END_WARNING] = 1;
					dynStats("inte", -3);
				}
				else {
					outputText("\n\nAs you down the last of your truffle, your entire body begins to convulse violently. Your vision becomes blurry, and you black out.");
					outputText("\n\nWhen you awaken, you are greeted by a large dog licking at your face. The dog seems oddly familiar. \"<i>Bessy, whatcha doin’ girl?</i>\" a voice calls. The voice seems familiar as well. A funny-looking pig on two legs soon appears at the dog’s side. \"<i>Now, now, what do we have here?</i>\" The pig inspects you for a moment, eventually finding a hint of pigtail truffle on your snout.");
					outputText("\n\n\"<i>Ah no...</i>\" he says sadly, shaking his head. \"<i>Come with me little " + player.mf("guy", "gal") + ",  I’ve got a place for ya.</i>\"  He then leads you to his shack, nestled in a small clearing in a nearby forest. \"<i>You don’t need ‘ta worry about a thing.  Come ‘ta think of it...</i>\"  he taps his chin for a moment,  \"<i>I know what I could use you for. You could be my own personal truffle hog! The more truffles, the better!</i>\"");
					outputText("\n\nYou take wonderfully to your new job. Finding truffles is fun, and the funny pig takes great care of you. You couldn’t ask for better. Sure, the world is full of demons and the like, but here, you’re safe, and that’s all you care about.");
					EventParser.gameOver();
					return;
				}
			}
			//-----------------------
			// SIZE MODIFICATIONS
			//-----------------------
			//Increase thickness
			if (rand(3) == 0 && changes < changeLimit && player.thickness < 75) {
				outputText(player.modThickness(player.maxThicknessCap(), 3));
				changes++;
			}
			//Decrease muscle tone
			if (rand(3) == 0 && changes < changeLimit && player.gender >= 2 && player.tone > 20) {
				outputText(player.modTone(20, 4));
				changes++;
			}
			//Increase hip rating
			if (rand(3) == 0 && changes < changeLimit && player.gender >= 2 && player.hips.type < 15) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hips.type++;
				changes++;
			}
			//Increase ass rating
			if (rand(3) == 0 && changes < changeLimit && player.butt.type < 12) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.butt.type++;
				changes++;
			}
			//Increase ball size if you have balls.
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 4) {
				if (player.ballSize < 3)
					outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + (player.balls == 4 ? "quartette" : "duo") + " of [balls] have grown larger than a human’s.");
				else
					outputText("\n\nA sudden onset of heat envelops your groin, focusing on your ballsack. Walking becomes difficult as you discover your " + (player.balls == 4 ? "quartette" : "duo") + " of testicles have enlarged again.");
				player.ballSize++;
				changes++;
			}
			//-----------------------
			// TRANSFORMATIONS
			//-----------------------
			//Gain pig cock, independent of other pig TFs.
			if (rand(3) == 0 && changes < changeLimit && player.cocks.length > 0 && player.cocks[0].cockType != CockTypesEnum.PIG) {
				if (player.cocks.length == 1) { //Single cock
					outputText("\n\nYou feel an uncomfortable pinching sensation in your [cock]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[0].cockType = CockTypesEnum.PIG;
				}
				else { //Multiple cocks
					outputText("\n\nYou feel an uncomfortable pinching sensation in one of your cocks. You pull open your [armor], watching as it warps and changes. As the transformation completes, you’re left with a shiny pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[rand(player.cocks.length+1)].cockType = CockTypesEnum.PIG;
				}
				changes++;
			}
			//Gain pig ears!
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.ears.type != Ears.PIG) {
				outputText("\n\nYou feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>");
				setEarType(Ears.PIG);
				changes++;
			}
			//Gain pig tail if you already have pig ears!
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tailType != Tail.PIG) {
				if (player.tailType > 0) //If you have non-pig tail.
					outputText("\n\nYou feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>");
				else //If you don't have a tail.
					outputText("\n\nYou feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>");
				setTailType(Tail.PIG);
				changes++;
			}
			//Gain pig tail even when centaur, needs pig ears.
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tailType != Tail.PIG && player.isTaur() && (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY)) {
				outputText("\n\nThere is a tingling in your [tail] as it begins to warp and change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b> This new, mismatched tail looks a bit odd on your horse lower body.");
				setTailType(Tail.PIG);
				changes++;
			}
			//Turn your lower body into pig legs if you have pig ears and tail.
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tailType == Tail.PIG && player.lowerBody != LowerBody.CLOVEN_HOOFED) {
				if (player.isTaur()) //Centaur
					outputText("\n\nYou scream in agony as a horrible pain racks your entire bestial lower half. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the animal's lower body. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else if (player.lowerBody == LowerBody.NAGA) //Naga
					outputText("\n\nYou scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else //Bipedal
					outputText("\n\nYou scream in agony as the bones in your legs break and rearrange. Once the pain subsides, you inspect your legs, finding that they are digitigrade and ending in cloven hooves. <b>You now have pig legs!</b>");
				setLowerBody(LowerBody.CLOVEN_HOOFED);
				player.legCount = 2;
				changes++;
			}
			//Gain pig/boar arms
			if (rand(2) == 0 && changes < changeLimit && player.tailType == Tail.PIG && player.lowerBody == LowerBody.CLOVEN_HOOFED && (player.arms.type != Arms.PIG || player.arms.type != Arms.BOAR)) {
				if (boar) {
					outputText("\n\nYour arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive. Furthermore your nails become increasingly pointed turning black just like a set of claws. <b>You now have boar arms.</b>");
					player.skin.coat.color = player.hairColor;
					setArmType(Arms.BOAR);
					changes++;
				}
				else {
					outputText("\n\nYour finguers starts to feel like some bee stung them as they inflates to a more chubby size your nails tickening and darkening turning into clover-like claws. Aside of your now fat finguers and darker claws your arms remains about the same. <b>You now have pig arms.</b>");
					setArmType(Arms.PIG);
					changes++;
				}
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
			if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.PIG, Arms.BOAR) && rand(3) == 0) {
				humanizeArms();
				changes++;
			}
			//Gain pig/boar face when you have the first three pig TFs.
			if (rand(2) == 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tailType == Tail.PIG && player.lowerBody == LowerBody.CLOVEN_HOOFED && (player.faceType != Face.PIG || player.faceType != Face.BOAR)) {
				if (boar) {
					outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>");
					setFaceType(Face.BOAR);
					changes++;
				}
				else {
					outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>");
					setFaceType(Face.PIG);
					changes++;
				}
			}
			//Change skin to normal
			if (!player.hasPlainSkinOnly() && rand(2) == 0 && changes < changeLimit) {
				if (player.skin.base.pattern != Skin.PATTERN_NONE) {
					player.skin.base.pattern = Skin.PATTERN_NONE;
					player.skin.base.adj = "";
				}
				if (player.skinAdj != "") player.skinAdj = "";
				humanizeSkin();
				changes++;
			}
			if (boar && rand(2) == 0 && player.hasPlainSkinOnly() && !player.hasFur()) {
				var skinChoosen:int = rand(5);
				var furToBeChosen:String = "";
				if (skinChoosen == 0) furToBeChosen = "brown";
				else if (skinChoosen == 1) furToBeChosen = "dark brown";
				else if (skinChoosen == 2) furToBeChosen = "black";
				else if (skinChoosen == 3) furToBeChosen = "red";
				else furToBeChosen = "grey";
				outputText("\n\nYou shiver, feeling a bit cold.  Just as you begin to wish for something to cover up with, it seems your request is granted; thick, bushy fur begins to grow all over your body!  You tug at the tufts in alarm, but they're firmly rooted and... actually pretty soft.  Huh.  ");
				player.skin.growCoat(Skin.FUR,{color:furToBeChosen});
				outputText("<b>You now have a warm coat of [skin coat.color] boar fur!</b>");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			//Change skin colour
			if (rand(boar ? 2 : 3) == 0 && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit) {
				var skinChoose:int = rand(3);
				var skinToBeChosen:String = "pink";
				if (boar) {
					if (skinChoose == 0) skinToBeChosen = "pink";
					else if (skinChoose == 1) skinToBeChosen = "dark blue";
					else skinToBeChosen = "black";
				}
				else {
					if (skinChoose == 0) skinToBeChosen = "pink";
					else if (skinChoose == 1) skinToBeChosen = "tan";
					else skinToBeChosen = "sable";
				}
				outputText("\n\nYour skin tingles ever so slightly as you skin’s color changes before your eyes. As the tingling diminishes, you find that your skin has turned " + skinToBeChosen + ".");
				player.skinTone = skinToBeChosen;
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nOddly, you do not feel any changes. Perhaps you're lucky? Or not.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function winterPudding(player:Player, returnToBakery:Boolean = false):void {
			outputText("You stuff the stodgy pudding down your mouth, the taste of brandy cream sauce and bitter black treacle sugar combining in your mouth.  You can tell by its thick spongy texture that it's far from good for you, so its exclusivity is more than likely for the best.");
			player.refillHunger(30);
			if(player.thickness < 100 || player.tone > 0) {
				//outputText("\n\nYou feel your waist protrude slightly.  Did you just put on a little weight?  It sure looks like it.");
				outputText(player.modTone(0,2));
				outputText(player.modThickness(player.maxThicknessCap(),2));
			}
			outputText("\n\nYou lick your lips clean, savoring the taste of the Winter Pudding.  You feel kinda antsy...");
			//[Decrease player tone by 5, Increase Lust by 20, Destroy item.]
			dynStats("lus", (10+player.lib/10), "scale", false);
			
			//[Optional, give the player antlers! (30% chance) Show this description if the player doesn't have horns already.]
			if(player.horns.count == 0 && player.lowerBody != LowerBody.GARGOYLE && rand(2) == 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear.  <b>You've grown antlers!</b>");
				//[Player horns type changed to Antlers.]
				setHornType(Horns.ANTLERS, 4 + rand(12));
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//[Show this description instead if the player already had horns when the transformation occurred.]
			else if(player.horns.count > 0 && player.horns.type != Horns.ANTLERS && player.horns.type != Horns.ORCHID && player.lowerBody != LowerBody.GARGOYLE && rand(2) == 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained antlers!</b>");
				//[Player horns type changed to Antlers.]
				setHornType(Horns.ANTLERS, 4 + rand(12));
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			if (returnToBakery) {
				doNext(SceneLib.telAdre.bakeryScene.bakeryuuuuuu);
			}
		}
		
		public function scyllaInk(type:Number,player:Player):void
		{
			//'type' refers to the variety of ink.
			//0 == black ink (female scylla TF)
			//1 == grey ink (herm scylla TF)
			//2 == white ink (male scylla TF)
			//3 == abyssal black ink (female kraken TF)
			//4 == abyssal grey ink (herm kraken TF)
			//5 == abyssal white ink (male kraken TF)
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("The ink taste salty and slimy, you really think you could use a full glass of fresh water to wash your aching throat.");
			
			//Statistical changes:
			//-Raises intelligence to 80.
			if (player.inte < 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nAs you finish drinking the ink you suddenly feel more cunning and by far way smarter.");
				dynStats("int", 1);
				changes++;
			}
			//-Raises strength to 90.
			if (player.str < 90 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou suddenly feel like you could do a wrestling contest with anyone who ask.");
				if (player.str > 60) outputText(" Heck you feel so strong you could bend wood or even steel!");
				dynStats("str", 1);
				changes++;
			}
			//-Decrease muscle tone toward 30
			if (player.tone >= 30 && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour muscle start to vanish but strangely you didn't lose strength or gain any weight. Well that was weird.");
				player.tone -= 3;
				changes++;
			}
			//-Femininity to 100 (female scylla version)
			if (type == 0 && player.femininity < 100 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText(player.modFem(100, 3 + rand(5)));
			}
			//-Femininity to 0 (male scylla version)
			if (type == 2 && player.femininity > 0 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText(player.modFem(0, 3 + rand(5)));
			}
			
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual Changes:
			//FEMALE
			if (player.gender == 2 || player.gender == 3) {
				//Single vag
				if (player.vaginas.length == 1) {
					if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_DROOLING && changes < changeLimit && rand(2) == 0) {
						temp = player.vaginas.length;
						while (temp > 0) {
							temp--;
							if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_DROOLING) player.vaginas[temp].vaginalWetness++;
							changes++;
						}
						if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) {
							outputText("\n\nYour pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your [vagina].  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
							player.orgasm();
						}
						if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_DROOLING) {
							outputText("\n\nWow your wet down there just what on going on. When you put your hand to your " + vaginaDescript(temp) + ". Surprised you discover it's twice as more lubricated then before.");
						}
					}
					if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING && changes < changeLimit && rand(3) == 0) {
						outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your [vagina] has grown larger, in depth AND size.");
						player.vaginas[0].vaginalLooseness++;
						changes++;
					}
				}
				//Multicooch
				else {
					//determine least wet
					//temp - least wet
					//temp2 - saved wetness
					//temp3 - counter
					temp = 0;
					temp2 = player.vaginas[temp].vaginalWetness;
					temp3 = player.vaginas.length;
					while (temp3 > 0) {
						temp3--;
						if (temp2 > player.vaginas[temp3].vaginalWetness) {
							temp = temp3;
							temp2 = player.vaginas[temp].vaginalWetness;
						}
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) {
						outputText("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your [vagina]s.  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						player.orgasm();
						changes++;
					}
					if (player.vaginas[temp].vaginalWetness < VaginaClass.WETNESS_DROOLING && changes < changeLimit && rand(2) == 0) {
						outputText("\n\nWow your wet down there just what on going on. When you put your hand to one of your " + vaginaDescript(temp) + " you discover not only is it twice as more lubricated then before.");
						player.vaginas[temp].vaginalWetness++;
						changes++;
					}
					//determine smallest
					//temp - least big
					//temp2 - saved looseness
					//temp3 - counter
					temp = 0;
					temp2 = player.vaginas[temp].vaginalLooseness;
					temp3 = player.vaginas.length;
					while (temp3 > 0) {
						temp3--;
						if (temp2 > player.vaginas[temp3].vaginalLooseness) {
							temp = temp3;
							temp2 = player.vaginas[temp].vaginalLooseness;
						}
					}
					if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING && changes < changeLimit && rand(3) == 0) {
						outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize one of your " + vaginaDescript(temp) + " has grown larger, in depth AND size.");
						player.vaginas[temp].vaginalLooseness++;
						changes++;
					}
				}
			}
			//Feminization of males
			if (type == 0 && (player.gender == 1 || player.gender == 3) && player.cocks.length > 0 && rand(2) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				//If the player has at least one dick, decrease the size of each slightly,
				outputText("\n\n");
				temp = 0;
				temp2 = player.cocks.length;
				temp3 = 0;
				//Find biggest cock
				while (temp2 > 0) {
					temp2--;
					if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
				}
				//Shrink said cock
				if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
					player.cocks[temp].cockLength -= .5;
					temp3 -= .5;
				}
				temp3 += player.increaseCock(temp, (rand(3) + 1) * -1);
				player.lengthChange(temp3, 1);
				if (player.cocks[temp].cockLength < 2) {
					outputText("  ");
					if (player.cockTotal() == 1 && !player.hasVagina()) {
						outputText("Your [cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.");
						if (player.balls > 0) outputText("  At the same time, your [balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.");
						outputText("  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>");
						player.balls = 0;
						player.ballSize = 1;
						player.createVagina();
						player.clitLength = .25;
						player.removeCock(0, 1);
					}
					else {
						player.killCocks(1);
					}
				}
				//if the last of the player's dicks are eliminated this way, they gain a virgin vagina;
				if (player.cocks.length == 0 && !player.hasVagina()) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.clitLength = .25;
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [vagina]</b>!");

					changes++;
					dynStats("lus", 10);
				}
			}
			//MALES
			//Masculinization of females
			if (type == 2 && (player.gender == 2 || player.gender == 3) && player.cocks.length > 0 && rand(2) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				//Kills vagina size (and eventually the whole vagina)
				if (player.vaginas.length > 0) {
					if (player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_TIGHT) {
						//tighten that bitch up!
						outputText("\n\nYour [vagina] clenches up painfully as it tightens up, becoming smaller and tighter.");
						player.vaginas[0].vaginalLooseness--;
					}
					else {
						outputText("\n\nA tightness in your groin is the only warning you get before your <b>[vagina] disappears forever</b>!");
						//Goodbye womanhood!
						player.removeVagina(0, 1);
						if (player.cocks.length == 0) {
							outputText("  Strangely, your clit seems to have resisted the change, and is growing larger by the moment. Eventually it ends, <b>leaving you with a completely human penis.</b>");
							player.createCock();
							player.cocks[0].cockLength = player.clitLength + 2;
							player.cocks[0].cockThickness = 1;
							player.cocks[0].cockType = CockTypesEnum.HUMAN;
							player.clitLength = .25;
						}
					}
					changes++;
				}
				//-Remove extra breast rows
				if (changes < changeLimit && player.bRows() > 1 && rand(3) == 0) {
					changes++;
					outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
					if (player.bRows() >= 3) outputText("abdomen");
					else outputText("chest");
					outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
					if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
					else outputText(player.skinTone + " " + player.skinDesc);
					outputText(" remains. <b>You've lost a row of breasts!</b>");
					dynStats("sen", -5);
					player.removeBreastRow(player.breastRows.length - 1, 1);
				}
				//Shrink boobages till they are normal
				else if (rand(2) == 0 && changes < changeLimit && player.breastRows.length > 0) {
					//Single row
					if (player.breastRows.length == 1) {
						//Shrink if bigger than B cups
						if (player.breastRows[0].breastRating >= 1) {
							temp = 1;
							player.breastRows[0].breastRating--;
							//Shrink again if huuuuge
							if (player.breastRows[0].breastRating > 8) {
								temp++;
								player.breastRows[0].breastRating--;
							}
							//Talk about shrinkage
							if (temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your [breasts] have shrunk to " + player.breastCup(0) + "s.");
							if (temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
							changes++;
						}

					}
					//multiple
					else {
						//temp2 = amount changed
						//temp3 = counter
						temp = 0;
						temp2 = 0;
						temp3 = 0;
						if (player.biggestTitSize() >= 1) outputText("\n");
						while (temp3 < player.breastRows.length) {
							if (player.breastRows[temp3].breastRating >= 1) {
								player.breastRows[temp3].breastRating--;
								temp2++;
								outputText("\n");
								//If this isn't the first change...
								if (temp2 > 1) outputText("...and y");
								else outputText("Y");
								outputText("our " + breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
							}
							temp3++;
						}
						if (temp2 == 2) outputText("\nYou feel so much lighter after the change.");
						if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
						if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
						if (temp2 > 0) changes++;
					}
				}
			}
			
			//Boost vaginal capacity without gaping
			if ((type == 0 || type == 1) && changes < changeLimit && rand(3) == 0 && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 200) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				outputText("\n\nThere is a sudden... emptiness within your [vagina].  Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Increase player's breast size, if they are big DD or smaller
			if ((type == 0 || type == 1) && player.smallestTitSize() <= 5 && player.gender == 2 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nAfter drinking it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//Change one prick to a vine-like tentacle cock.
			if ((type == 2 || type == 1) && rand(3) == 0 && player.cocks.length > 0) {
				if (player.tentacleCocks() < player.cockTotal()) {
					if (player.cocks.length == 1) { //Single cawks
						outputText("\n\nYour feel your [cock] bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>  ");
						//Set primary cock flag
						player.cocks[0].cockType = CockTypesEnum.TENTACLE;
					}
					if (player.cockTotal() > 1) { //multi
						outputText("\n\nYour feel your [cocks] bending and flexing of their own volition... looking down, you watch them morph into flexible vine-like shapes.  <b>You now have green tentacle cocks!</b>  ");
						for (var x:int = 0; x < player.cocks.length; x++) player.cocks[x].cockType = CockTypesEnum.TENTACLE;
					}
				}
			}
			//Grow cock(s) longer
			if ((type == 2 || type == 1) && rand(3) == 0 && player.cocks.length > 0) {
				//single cock
				if (player.cocks.length == 1) {
					temp2 = player.increaseCock(0, rand(4) + 3);
					temp = 0;
					dynStats("sen", 1, "lus", 10);
				}
				//Multicock
				else {
					//Find smallest cock
					//Temp2 = smallness size
					//temp = current smallest
					temp3 = player.cocks.length;
					temp = 0;
					while (temp3 > 0) {
						temp3--;
						//If current cock is smaller than saved, switch values.
						if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
							temp2 = player.cocks[temp3].cockLength;
							temp = temp3;
						}
					}
					//Grow smallest cock!
					//temp2 changes to growth amount
					temp2 = player.increaseCock(temp, rand(4) + 3);
					dynStats("sen", 1, "lus", 10);
					if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
				}
				if (temp2 > 2) outputText("\n\nYour " + cockDescript(temp) + " tightens painfully, inches of bulging dick-flesh pouring out from your crotch as it grows longer.  Thick pre forms at the pointed tip, drawn out from the pleasure of the change.");
				if (temp2 > 1 && temp2 <= 2) outputText("\n\nAching pressure builds within your crotch, suddenly releasing as an inch or more of extra dick-flesh spills out.  A dollop of pre beads on the head of your enlarged " + cockDescript(temp) + " from the pleasure of the growth.");
				if (temp2 <= 1) outputText("\n\nA slight pressure builds and releases as your " + cockDescript(temp) + " pushes a bit further out of your crotch.");
			}
			
			//Physical changes:
			//Skin
			if ((player.skinAdj != "slippery" || !player.hasPlainSkinOnly()) && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.hasFur()) outputText("You suddenly start sweating abundantly as your [skin.type] fall off leaving bare the smooth skin underneath.  ");
				else if (player.hasGooSkin()) outputText("Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. Then you start sweating abundantly. ");
				else if (player.hasScales()) outputText("You suddenly start sweating abundantly as your scales fall off leaving bare the smooth skin underneath.  ");
				else if (player.hasPlainSkinOnly()) outputText("You suddenly start sweating abundantly.  ");
				outputText("As much as you try to dry your skin using a cloth it remains slimy and slippery to the touch as if constantly wet! Your skin is now slippery like the one of a sea creature!");
				player.skin.setBaseOnly({type:Skin.PLAIN,adj:"slippery"});
				changes++;
			}
			//Face
			if (player.hasPlainSkinOnly() && player.skinAdj == "slippery" && player.faceType != Face.HUMAN && changes < changeLimit && rand(4) == 0) {
				humanizeFace();
				changes++;
			}
			//Ears
			if (player.faceType == Face.HUMAN && player.ears.type != Ears.ELFIN && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				if (player.ears.type != Ears.HUMAN) {
				outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
				}
				else {
					outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
				}
				setEarType(Ears.ELFIN);
				changes++;
			}
			//Ink spray attack
			if ((type == 0 && player.gender == 2 || type == 2 && player.gender == 1) && player.lowerBody == LowerBody.SCYLLA && player.findPerk(PerkLib.InkSpray) < 0) {
				if (type == 0) {
					outputText("\n\nYour pussy suddenly start gushing around and you squirt so much your tentacle are drenched. Blushing red in embarrassment you examine the damage lifting a tentacle and suddenly a jet black shot of girl juice shoot out of your pussy like a spray dying a nearby tree black.");
					outputText(" You smell the liquid and discover your girl juice turned into actual ink! Thinking about octopus behing able to spray ink you point your pussy at a random tree and take aim. As your relax the newly discovery organ a gush of ink splatter the tree.");
				}
				if (type == 2) {
					outputText("\n\nYour cock suddenly start leaking pre-cum around so much your front tentacles are drenched. Blushing red in embarrassment you examine the damage reaching to it and suddenly when you merely touched it a jet black shot of cum shoot out of your cock like a spray dying a nearby tree black.");
					outputText(" You smell the liquid and discover your cum turned into actual ink! Thinking about octopus behing able to spray ink you point your cock at a random tree and take aim. After moment of pumping it shoot another portion of the ink that splatter at the tree.");
				}
				outputText(" You think you could use this interesting ability to blind foe in battle.  (<b>Gained Perk: Ink Spray!</b>)");
				player.createPerk(PerkLib.InkSpray, 0, 0, 0, 0);
				changes++;
			}
			//Legs
			if (player.faceType == Face.HUMAN && player.lowerBody != LowerBody.GARGOYLE && (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.CLOVEN_HOOFED)) {
				if (changes < changeLimit && rand(3) == 0) {
					if (player.lowerBody == LowerBody.CLOVEN_HOOFED) outputText("\n\nYour lower half suddenly transform back into two human legs. You so missed having normal legs like before.");
					if (player.lowerBody == LowerBody.NAGA) outputText("\n\nYour tail split in two and turn into a pair of legs. You missed behing able to walk instead of slithering around.");
					outputText("<b>  You now have human legs in place of your feet!</b>");
					setLowerBody(LowerBody.HUMAN);
					player.legCount = 2;
					dynStats("spe", 1);
					changes++;
				}
			}
			if (((type == 0 && player.gender == 2) || (type == 1 && player.gender == 3) || (type == 2 && player.gender == 1)) && player.lowerBody != LowerBody.SCYLLA && player.lowerBody != LowerBody.GARGOYLE && (player.lowerBody != LowerBody.NAGA && player.lowerBody != LowerBody.CLOVEN_HOOFED) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou suddenly feel your legs giving in bellow you and you fall off to the ground unable to resume standing.");
				if (player.tailType != 0) {
					if (player.tailType == 5 || player.tailType == 6) outputText(" Your insectile abdomen");
					else if (player.tailType > 0 && player.tailCount > 1) outputText(" Your tails");
					else outputText(" Your tail");
					outputText(" recede back into your body disappearing entirely into your backside as if it never existed.");
				}
				outputText(" You suddenly feel something weird down your leg as you notice they are literally boneless! No wonder you fell down there's no way those empty lump of flesh would be able to carry your weight around. As you think over how you will fix this annoying situation wracking pain hits you in waves as your legs seems to stretch to a ridiculous length up to twice your height. Just as you think this can't get any weirder your legs split apart dividing into four then again into eighths!");
				outputText(" You watch you toe disappearing turning your feet into what could have been described as eight very weird tails when your legs start to cover with what looks like suction cups similar to those of an octopus. <b>Your legs have turned into tentacles!</b>");
				if (type == 0) outputText(" Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became about huge like a mouth ready to engulf anything.");
				if (type == 1) outputText(" Looking for your privates you notice your pussy is right under your 8 legs just like the center of a fleshy flower and became about huge like a mouth ready to engulf anything and your cock is right between your 2 front 'legs' looking almost like another tentacle.");
				if (type == 2) outputText(" Looking for your privates you notice your cock is right between your 2 front 'legs' looking almost like another tentacle.");
				outputText(" As you lift yourself standing on your tentacles not only can you still walk somewhat but heck don't you feel like grabbing something and squeezing it in your pleasurable new legs!");
				setLowerBody(LowerBody.SCYLLA);
				player.legCount = 8;
				if (player.tailType != Tail.NONE) {
					setTailType(Tail.NONE, 0);
				}
				changes++;
			}
			//Skin part 2
		//	if (player.hasPlainSkinOnly() && player.skinAdj == "slippery" && player.skinAdj != "rubberlike slippery" && changes < changeLimit && rand(4) == 0) {
		//		outputText("\n\nYour body is hit by a quake of sensation as your body shift into something more fitting for underwater swimming, your flesh becoming rubbery like the flesh of octopus and squid. You now have rubber like skin same as a scylla or a kraken.");
		//		player.skinAdj = "rubberlike slippery";
		//		changes++;
		//	}
			//FAILSAFE CHANGE
			if (changes == 0) outputText("\n\nRemarkably, the black ink has no effect.  Should you really be surprised at black ink NOT doing anything?");
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
	/*
		public function krakenInk(type:Number, player:Player):void
		{
			//'type' refers to the variety of ink.
			//0 == black ink (female kraken TF)
			//1 == grey ink (herm kraken TF)
			//2 == white ink (male kraken TF)
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("The ink taste salty and slimy, you really think you could use a full glass of fresh water to wash your aching throat.");
			
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			
		}
	*/
		public function yetiCum(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("The cum tastes pretty much like you expected it would, salty. Strangely, you feel warmer by the minute, perhaps it's your body adapting to the very hot feeling the cum left in your stomach.");
			//str up to 85
			if (player.str < 80 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYour fill your muscles filling with yeti might.");
				dynStats("str", 1);
				changes++;
			}
			//tou up to 100
			if (player.tou < 100 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
				dynStats("tou", 1);
				changes++;
			}
			//spe up to 75
			if (player.spe < 75 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nHearing a suddent sound you suddently move by reflex to the side with such speed you nearly trip.  Seems your reaction speed has increased as well as your mobile execution.");
				dynStats("spe", 1);
				changes++;
			}
			//int down to 15
			if (player.inte > 15 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
				dynStats("int", -1);
				changes++;
			}
			//lib up to 75
			if (player.lib < 75 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nA blush of red works its way across your skin as your sex drive kicks up a notch.");
				dynStats("lib", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Maleness
			if (player.hasCock() && rand(3) == 0 && player.cocks.length > 0) {
				if (player.cocks.length == 1) {
					outputText("\n\nYour [cock] becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					if (rand(4) == 0) temp = player.increaseCock(0, 3);
					else temp = player.increaseCock(0, 1);
					dynStats("int", 1, "lib", 2, "sen", 1, "lust", 5 + temp * 3);
					if (temp < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp >= .5 && temp < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp >= 1 && temp <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp > 2) outputText("  You smile and idly stroke your lengthening [cock] as a few more inches sprout.");
					dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					outputText("  With the transformation complete, your [cock] returns to its normal coloration.");
				}
				if (player.cocks.length > 1) {
					temp = player.cocks.length;
					temp2 = 0;
					//Find shortest cock
					while (temp > 0) {
						temp--;
						if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) {
							temp2 = temp;
						}
					}
					if (int(Math.random() * 4) == 0) temp3 = player.increaseCock(temp2, 3);
					else temp3 = player.increaseCock(temp2, 1);
					dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					//Grammar police for 2 cocks
					if (player.cockTotal() == 2) outputText("\n\nBoth of your [cocks] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + cockDescript(temp2) + " begins to grow.");
					//For more than 2
					else outputText("\n\nAll of your [cocks] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + cockDescript(temp2) + " begins to grow.");
					if (temp3 < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp3 >= .5 && temp3 < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp3 >= 1 && temp3 <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp3 > 2) outputText("  You smile and idly stroke your lengthening " + cockDescript(temp2) + " as a few more inches sprout.");
					outputText("  With the transformation complete, your [cocks] return to their normal coloration.");
				}
			}
			//Skin
			if (player.skinTone != "dark" && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour skin suddenly darkens. Doesn’t look like much, but darker skin will likely help soak up more sunlight and keep you warmer.<b> You now have dark skin.</b>");
				player.skinTone = "dark";
				changes++;
			}
			//Legs
			if (player.lowerBody != LowerBody.YETI && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				if (player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nYour legs start becoming excessively hairy down to your feet. They’re so hairy that you can no longer see your skin. Just as you thought the transformation was over, you see your feet enlarging to twice their size. They look like those of a huge monkey. Well, you guess people can call you Bigfoot now with your enormous <b>yeti feet!</b>");
					setLowerBody(LowerBody.YETI);
				}
				else {
					humanizeLowerBody();
				}
				changes++;
			}
			//Arms
			if (player.lowerBody == LowerBody.YETI && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.YETI) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour arms start to become excessively hairy down almost to your hands. They're so hairy that you can no longer see your skin. As the fur growth stops, your hands enlarge to twice their size. They look like huge monkey paws. Well, you guess punching people will be easy with your enormous <b>yeti hands!</b>");
				setArmType(Arms.YETI);
				changes++;
			}
			//Ears
			if (player.arms.type == Arms.YETI && player.ears.type != Ears.YETI && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou feel your ears as though they’re growing bigger for a moment. It feels weird, but when you touch them to check what happened they still feel somewhat human. Looking down in a puddle you notice the term human isn’t correct, in your case they look more like those of a monkey. <b>You now have yeti ears.</b>");
				setEarType(Ears.YETI);
				changes++;
			}
			//Face
			if (player.ears.type == Ears.YETI && player.faceType != Face.YETI_FANGS && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou feel your canines elongate and sharpen. Your mouth feels somewhat like a human one still, but when you feel your teeth with your tongue you discover that your canines have pretty much turned into proper fangs. <b>You now have yeti fangs.</b>");
				setFaceType(Face.YETI_FANGS);
				changes++;
			}
			//Hair
			if (player.faceType == Face.YETI_FANGS && player.hairType != Hair.FLUFFY && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour hair starts to grow longer and fluffier. It covers all sides of your head perfectly, like a furry helmet, keeping it warm. Only your face and neck are devoid of this hairy armor which still manage to look like a nice short haircut. While it looks like hair at first, touching it proves it to be like a very thick coat of fluff. You now have <b>yeti fluffy [haircolor] hairs.</b>");
				setHairType(Hair.FLUFFY);
				changes++;
			}
			//Fur
			if (player.hairType == Hair.FLUFFY && !player.skin.checkProps({coverage:Skin.COVERAGE_LOW,coat:{type:Skin.FUR}}) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nThick hair starts to grow in random areas all over your body. ");
				if (player.breastRows.length > 0) outputText("Your breasts in particular cover with hair forming into what can only be described as a natural bikini.");
				outputText(" Furthermore, your hair natural color turns to white. Your body is now <b>partially covered with thick white fur!</b>");
				player.skin.growFur({color:"white"},Skin.COVERAGE_LOW);
				player.hairColor = "white";
				changes++;
			}
			//Eyes
			if (changes < changeLimit && rand(3) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//hips
			if (rand(2) == 0 && player.hips.type < 11 && changes < changeLimit) {
				outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
				player.hips.type += 1 + rand(2);
				changes++;
			}
			//ass
			if (rand(2) == 0 && player.butt.type < 11 && changes < changeLimit) {
				outputText("\n\nYour ass grows in size, becoming bigger and more cushiony. A little fat to help you to endure the coming winter, perhaps.");
				player.butt.type += 1 + rand(2);
				changes++;
			}
			//tallness
			if (player.tallness < 84 && changes < changeLimit && rand(2) == 0) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 74) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			if (rand(3) == 0) outputText(player.modThickness(50, 3));
			if (player.cocks.length > 0 && rand(3) == 0) outputText(player.modTone(85, 3));
			if (player.vaginas.length > 0 && rand(3) == 0) outputText(player.modTone(10, 5));
			//FAILSAFE CHANGE
			if (changes == 0) outputText("\n\nRemarkably, the yeti cum has no effect.  Should you really be surprised at yeti cum NOT doing anything?");
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function aquaSeed(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
		//	var temp:Number = 0;
		//	var temp2:Number = 0;
		//	var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You eat the weird kelp seed and feel suddenly like singing. Seems your talent for music are skyrocketing as you embrace the changes within you.");
			
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//FAILSAFE CHANGE
			if (changes == 0) outputText("\n\nRemarkably, the seed has no effect.  Maybe next time?");
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function orcaSunscreen(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
		//	var temp2:Number = 0;
		//	var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You apply the sunscreen on your skin and suddenly feel some of your worries fly as you laugh cheerfully at the thought of taking a vacation day or two to rest and swim at the beach. Your body seems to react weirdly to the sunscreen.");
			if (player.str < 100 && rand(3) == 0) {
				dynStats("str", 1 + rand(3));
				changes++;
				outputText("\n\nYou suddenly feel stronger. Your body growing with raw physical power. Funnily enough, you don’t seem to grow in muscle.");
			}
			if (player.spe < 100 && rand(3) == 0) {
				dynStats("spe", 1 + rand(3));
				changes++;
				outputText("\n\nShivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.");
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//skin
			if ((player.skinAdj != "glossy" || !player.hasPlainSkinOnly()) && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.hasFur()) outputText("You suddenly start sweating abundantly as your [skin.type] fall off leaving bare the smooth skin underneath.  ");
				if (player.hasGooSkin()) outputText("Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. Then you start sweating abundantly. ");
				if (player.hasScales()) outputText("You suddenly start sweating abundantly as your scales fall off leaving bare the smooth skin underneath.  ");
				outputText("Your skin starts to change, turning darker and darker until it is pitch black. Your underbelly, on the other hand , turns pure white. Just as you thought it was over, your skin takes on a glossy shine similar to that of a whale. <b>Your body is now black with a white underbelly running on the underside of your limbs and up to your mouth in a color pattern similar to an orca’s.</b>");
				player.skin.setBaseOnly({type:Skin.PLAIN,adj:"glossy",pattern:Skin.PATTERN_ORCA_UNDERBODY,color:"white",color2:"black"});
				changes++;
			}
			//legs
			if (player.skinAdj == "glossy" && player.hasPlainSkinOnly() && player.lowerBody != LowerBody.ORCA && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
				if (player.lowerBody == LowerBody.HUMAN) {
					outputText("\n\nYour toes suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. <b>You can only guess those Orca legs will help you to swim at great speed.</b>");
					setLowerBody(LowerBody.ORCA);
				}
				else {
					humanizeLowerBody();
				}
				changes++;
			}
			//arms
			if (player.lowerBody == LowerBody.ORCA && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.ORCA) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour fingers suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. You are still examining your hands when something not unlike a pair of fins grow out of your forearms. <b>You can only guess those Orca arms will help you to swim at high speeds!</b>");
				setArmType(Arms.ORCA);
				changes++;
			}
			//tail
			if (player.arms.type == Arms.ORCA && player.tailType != Tail.ORCA && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA large bump starts to grow out of your " + assDescript() + ", making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail black as midnight with a white underside and a smaller fin closer to your body, likely for hydrodynamism sake. ");
				outputText("You swing your tail a few times, battering the ground with it and smile as you rush to the stream to take a dip. With the help of your mighty tail you easily reach such a high swim speed you even manage to jump several meters out of the water, laughing with delight at the trill of this aquatic experience. ");
				outputText("<b>You're going to have a lot of fun swimming with your new Orca tail.</b>");
				setTailType(Tail.ORCA);
				changes++;
			}
			//ears
			if (player.tailType == Tail.ORCA && player.ears.type != Ears.ORCA && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour ears suddenly begin to lengthen, growing bigger and bigger until their length reaches your shoulders. When you examine them you discover they have grown into a pair of large fins, easily twice as big as your head. <b>Orienting yourself underwater will be easy with your large orca fin ears.</b>");
				setEarType(Ears.ORCA);
				changes++;
			}
			//blowhole
			if (player.ears.type == Ears.ORCA && player.rearBody.type != RearBody.ORCA_BLOWHOLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				if (player.rearBody.type > RearBody.NONE) outputText("Your wings fold into themselves, merging together with your back.  ");
				outputText("Pain rushes just behind your shoulder blades as a hole opens up, air rushing in. The hole is burning making you groan in pain as air flows in and out. Eventually you get accustomed to breathing from your back like whales do, but it sure was a weird experience.");
				if (silly()) outputText("  Well it doesn't matter because now you can break the world record of the longest breath holding by sitting on the ocean floor for more than 90 minutes.");
				setRearBody(RearBody.ORCA_BLOWHOLE);
				changes++;
			}
			//face
			if (player.rearBody.type == RearBody.ORCA_BLOWHOLE && player.faceType != Face.ORCA && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYour nose starts to tingle, getting bigger and rounder as your facial features take on a bombed shape. Your nasal hole disappears entirely as you feel your mouth change, your dentition turning into pointed teeth fit for an orca. You go look at your reflection in the water to be sure, and discover your face is now similar in shape to that of a killer whale. Um… you could use a fish or two, you are getting pretty hungry. <b>Taking a bite out of fresh fish would be great with your new orca face.</b>");
				setFaceType(Face.ORCA);
				changes++;
			}
			//tallness
			if (player.tallness < 132 && changes < changeLimit && rand(2) == 0) {
				var heightGain:int = rand(5) + 3;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (heightGain < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				else if (heightGain >= 5 && heightGain < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				else if (heightGain == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += heightGain;
				changes++;
			}
			//FAILSAFE CHANGE
			if (changes == 0) outputText("\n\nRemarkably, the sunscreen has no effect.  Maybe next time?");
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function drakeHeart(player:Player):void {
			outputText("You bring the flower up to your nose and smell it. It has exquisite smell. You suddenly have the strange desire to eat it. You pop the flower into your mouth and chew. It tastes like vanilla somehow. Before you know it, you're undergoing changes.");
			emberTFchanges.dragonTFeffects(true);
		}
		
		public function bladeGrass(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You prepare the tea using grass you acquired and then drinks it. Its sharp taste fires up your palate and in moments, you find yourself more mentaly and physicaly sharp just like a blade.");

			//Statistical changes:
			//-Raises speed to 100.
			if (player.spe < 100 && rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nHearing a suddent sound you suddently move by reflex to the side with such speed you nearly trip.  Seems your reaction speed has increased as well as your mobile execution.");
				dynStats("spe", 1);
				changes++;
			}
			//-Raises intelligence to 80.
			if (player.inte < 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nPatience is the key to any successful behavior weither it is battle or carefull planing.");
				outputText("\nYour mind keep readying new plans and strategy to ambush your future foes as your brain start processing logic way better then you used to.");
				dynStats("int", 1);
				changes++;
			}
			//-Decrease strength toward 30
			if (changes < changeLimit && rand(3) == 0 && player.str > 30) {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can beat your foes with superior speed?");
				dynStats("str", -1);
				if (player.str > 60) dynStats("str", -1);
				if (player.str > 80) dynStats("str", -1);
				if (player.str > 90) dynStats("str", -1);
				changes++;
			}
			
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//Sexual Changes:
			//-Remove extra breast rows
			if (changes < changeLimit && player.bRows() > 1 && rand(3) == 0) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//Shrink boobages till they are normal
			else if (rand(2) == 0 && changes < changeLimit && player.breastRows.length > 0) {
				//Single row
				if (player.breastRows.length == 1) {
					//Shrink if bigger than B cups
					if (player.breastRows[0].breastRating >= 2) {
						var swtch:int = 1;
						player.breastRows[0].breastRating--;
						//Shrink again if huuuuge
						if (player.breastRows[0].breastRating > 10) {
							swtch++;
							player.breastRows[0].breastRating--;
						}
						//Talk about shrinkage
						if (swtch == 1) outputText("\n\nYou feel a weight lifted from you, and realize your [breasts] have shrunk to " + player.breastCup(0) + "s.");
						if (swtch == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
						changes++;
					}

				}
				//multiple
				else {
					//temp2 = amount changed
					//temp3 = counter
					swtch = 0;
					temp2 = 0;
					temp3 = 0;
					if (player.biggestTitSize() >= 1) outputText("\n");
					while (temp3 < player.breastRows.length) {
						if (player.breastRows[temp3].breastRating >= 1) {
							player.breastRows[temp3].breastRating--;
							temp2++;
							outputText("\n");
							//If this isn't the first change...
							if (temp2 > 1) outputText("...and y");
							else outputText("Y");
							outputText("our " + breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
						}
						temp3++;
					}
					if (temp2 == 2) outputText("\nYou feel so much lighter after the change.");
					if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
					if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
					if (temp2 > 0) changes++;
				}
			}
			//(tightens vagina to 1, increases lust/libido)
			if (player.hasVagina()) {
				if (player.looseness() > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!");
					dynStats("lib", 2, "lus", 25);
					changes++;
					player.vaginas[0].vaginalLooseness--;
				}
			}
			//(tightens asshole to 1, increases lust)
			if (player.ass.analLooseness > 1 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				dynStats("lib", 2, "lus", 25);
				changes++;
				player.ass.analLooseness--;
			}
			//(Thickens all cocks to a ratio of 1\" thickness per 5.5\"
			if (player.hasCock() && changes < changeLimit && rand(4) == 0) {
				//Use swtch to see if any dicks can be thickened
				swtch = 0;
				counter = 0;
				while (counter < player.cockTotal()) {
					if (player.cocks[counter].cockThickness * 5.5 < player.cocks[counter].cockLength) {
						player.cocks[counter].cockThickness += .1;
						swtch = 1;
					}
					counter++;
				}
				//If something got thickened
				if (swtch == 1) {
					outputText("\n\nYou can feel your [cocks] filling out in your [armor]. Pulling ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" out, you look closely.  ");
					if (player.cockTotal() == 1) outputText("It's");
					else outputText("They're");
					outputText(" definitely thicker.");
					var counter:Number;
					changes++;
				}
			}
			
			//Physical Changes:
			//Antennae (nie wymaga innych body parts)
			if (changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.antennae.type == Antennae.MANTIS && rand(3) == 0) {
				if (player.antennae.type == Antennae.BEE) outputText("\n\nYour head itches momentarily as your two floppy antennae changes slowly into long prehensile ones similar to those seen at mantis.");
				else outputText("\n\nYour head itches momentarily as two long prehensile antennae sprout from your [hair].");
				setAntennae(Antennae.MANTIS);
				changes++;
			}
			//Horns
			if (changes < changeLimit && player.horns.count > 0 && player.horns.type != Horns.ORCHID && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0) {
				setHornType(Horns.NONE, 0);
				outputText("\n\nYour horns crumble, falling apart in large chunks until they flake away to nothing.");
				changes++;
			}
			
			//oviposition (prawdopodobnie podobne do wersji dla bee niż dridera)
			if (changes < changeLimit && player.findPerk(PerkLib.MantisOvipositor) < 0 && player.tailType == Tail.MANTIS_ABDOMEN && rand(2) == 0) {
				outputText("\n\nAn odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous mantis part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, green, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new mantis ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Mantis Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.MantisOvipositor, 0, 0, 0, 0);
				changes++;
			}
			
			//Legs
			if (player.lowerBody != LowerBody.MANTIS && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour legs tremble with sudden unbearable pain, as if they’re being ripped apart from the inside out and being stitched together again all at once.");
				outputText("\nYou scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining green chitin from the thigh down. <b>You now have mantis feet.</b>");
				setLowerBody(LowerBody.MANTIS);
				player.legCount = 2;
				changes++;
			}
			
			//Arms
			if (player.lowerBody == LowerBody.MANTIS && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.MANTIS) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, turning the [skin.type] into a shiny green carapace.");
				outputText("\nA moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining green chitin from the upper arm down.");
				outputText("\nThe transformation end as down the lenght of your forearms you grow a pair of massive scythe like appendage just like a mantis.");
				outputText("\nYou nonchalantly run them across a young tree slicing the plant trunk in half. This might prove a deadly weapon if used as part of your unarmed strikes. <b>You now have mantis arms.</b>");
				setArmType(Arms.MANTIS);
				changes++;
			}
			
			//Tail
			if (player.arms.type == Arms.MANTIS && player.tailType != Tail.MANTIS_ABDOMEN && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nPainful swelling just above your firm backside doubles you over.");
				outputText("\nIt gets worse and worse as the swollen lump begins to protrude from your backside, swelling and elongating with a series of pops until you have a bulbous abdomen hanging just above your butt.");
				outputText("\nThe whole thing is covered in a hard greenish chitinous material, and large enough to be impossible to hide. <b>You have a Mantis abdomen.</b>");
				setTailType(Tail.MANTIS_ABDOMEN);
				changes++;
			}
			
			//Wings
			if (!InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.MANTIS_LIKE_LARGE) && changes < changeLimit && rand(4) == 0) {
				//Grow bigger mantis wings!
				if (player.wings.type == Wings.MANTIS_LIKE_SMALL) {
					outputText("\n\nYour wings tingle as they grow, filling out covering your back abdomen until they are large enough to lift you from the ground and allow you to fly!  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.  <b>You now have large Mantis wings!</b>");
					setWingType(Wings.MANTIS_LIKE_LARGE, "large mantis-like");
				}
				//Grow small mantis wings if player has none.
				else if (player.wings.type == Wings.NONE) {
					outputText("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.");
					outputText("\nYou hastily remove the top portion of your [armor] and marvel as a pair of small Insectile wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can’t seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new mantis wings</b>.");
					setWingType(Wings.MANTIS_LIKE_SMALL, "small mantis-like");
				}
				//Remove old wings
				else {
					removeWings();
				}
				changes++;
			}
			
			//Chitin skin
			if (changes < changeLimit && !player.hasCoatOfType(Skin.CHITIN) && player.tailType == Tail.MANTIS_ABDOMEN && rand(2) == 0) {
				growChitin("green");
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedChitin)) {
					outputText("\n\n<b>Genetic Memory: Chitin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedChitin, 0, 0, 0, 0);
				}
				changes++;
			}
			
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function infernalWine(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			//Temporary storage
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			//clear screen
			clearOutput();
			outputText("You raise the disgusting black concoction to your mouth. The taste is better than its texture but leaves you with a strong aftertaste of sulfur.");
			dynStats("cor", 3 + rand(3));
			
			//int change
			if (player.inte < 100 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nArcane knowledge floods into your mind. You already imagine tons of new sinister ways to use this knowledge.");
				dynStats("int", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//sexual changes
			//female
			if (player.gender > 1) {
				if (player.biggestTitSize() <= 4 && changes < changeLimit && rand(3) == 0) {
					if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
					else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
					player.growTits(1 + rand(3), 1, false, 3);
					changes++;
					dynStats("sen", .5);
				}
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of A cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 1;
					outputText("\n");
				}
			}
			//male
			if ((player.gender == 1 || player.gender == 3) && rand(3) == 0 && changes < changeLimit) {
				if ((player.horseCocks() + player.demonCocks()) < player.cocks.length) {
					if (player.cocks.length == 1) {
						var temp:int = 0;
						temp3 = 0;
						if (player.cocks[0].cockType == CockTypesEnum.HUMAN) {
							outputText("\n\nYour [cock] begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
							temp = player.addHorseCock();
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType == CockTypesEnum.DOG) {
							temp = player.addHorseCock();
							outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond it's traditional size.  You notice your knot vanishing, the extra flesh pushing more horsecock out from your sheath.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType == CockTypesEnum.TENTACLE) {
							temp = player.addHorseCock();
							outputText("\n\nYour [cock] begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [cock] as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType.Index > 4) {
							outputText("\n\nYour [cock] begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [cock] as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp = player.addHorseCock();
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (temp3 == 1) outputText("  <b>Your penis has transformed into a horse's!</b>");
					}
					else {
						dynStats("lib", 5, "sen", 4, "lus", 35);
						temp = player.addHorseCock();
						outputText("\n\nOne of your penises begins to feel strange.  You pull down your clothes to take a look and see the skin of your " + cockDescript(temp) + " darkening to a mottled brown and black pattern.");
						if (temp == -1) {
							CoC_Settings.error("");
							clearOutput();
							outputText("FUKKKK ERROR NO COCK XFORMED");
						}
						if (player.horseCocks() > 1 || player.dogCocks() > 0) outputText("  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.");
						else outputText("  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your " + cockDescript(temp) + "'s root, tightening and pulling your " + cockDescript(temp) + " inside its depths.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						outputText("  The shaft suddenly explodes with movement, growing longer and developing a thick flared head leaking steady stream of animal-cum.");
						outputText("  <b>You now have a horse-cock.</b>");
					}
					if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
					changes++;
				}
				else {
					if (player.cocks.length == 1) {
						temp2 = player.increaseCock(0, rand(3) + 1);
						temp = 0;
						dynStats("sen", 1, "lus", 10);
					}
					else {
						//Find smallest cock
						//Temp2 = smallness size
						//temp = current smallest
						temp3 = player.cocks.length;
						temp = 0;
						while (temp3 > 0) {
							temp3--;
							//If current cock is smaller than saved, switch values.
							if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
								temp2 = player.cocks[temp3].cockLength;
								temp = temp3;
							}
						}
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = player.increaseCock(temp, rand(4) + 1);
						dynStats("sen", 1, "lus", 10);
					}
					outputText("\n\n");
					if (temp2 > 2) outputText("Your " + cockDescript(temp) + " tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) outputText("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) outputText("A slight pressure builds and releases as your " + cockDescript(temp) + " pushes a bit further out of your sheath.");
					changes++;
				}
			}
			//physical changes
			//legs
			if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.lowerBody != LowerBody.CLOVEN_HOOFED) {
				outputText("\n\nYou feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of goat legs</b>.");
				setLowerBody(LowerBody.CLOVEN_HOOFED);
				player.legCount = 2;
				changes++;
			}
			//tail
			if (rand(3) == 0 && changes < changeLimit && player.lowerBody == LowerBody.CLOVEN_HOOFED && (player.tailType != Tail.GOAT && player.tailType != Tail.DEMONIC)) {
				outputText("\n\n");
				if (rand(2) == 0) {
					outputText("You feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>");
					setTailType(Tail.GOAT);
				}
				else {
					if (player.tailType != Tail.NONE) {
						if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ");
						else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ");
						outputText("<b>Your tail is now demonic in appearance.</b>");
					}
					else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
					setTailType(Tail.DEMONIC);
				}
				changes++;
			}
			//wings
			if (rand(3) == 0 && changes < changeLimit && !InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.BAT_LIKE_LARGE) && (player.tailType == Tail.GOAT || player.tailType == Tail.DEMONIC)) {
				//grow smalls to large
				if (player.wings.type == Wings.BAT_LIKE_TINY && player.cor >= 75) {
					outputText("\n\n");
					outputText("Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>");
					setWingType(Wings.BAT_LIKE_LARGE, "large, bat-like");
				}
				else if (player.wings.type == Wings.BEE_LIKE_SMALL || player.wings.type == Wings.BEE_LIKE_LARGE) {
					outputText("\n\n");
					outputText("The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing.  You twist your head as far as you can for a look and realize they've changed into ");
					if (player.wings.type == Wings.BEE_LIKE_SMALL) {
						outputText("small ");
						setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
					}
					else {
						outputText("large ");
						setWingType(Wings.BAT_LIKE_LARGE, "large, bat-like");
					}
					outputText("<b>bat-like demon-wings!</b>");
				}
				else {
					outputText("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by small <b>bat-like demon-wings!</b>");
					setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
				}
				//No wings
				if (player.wings.type == Wings.NONE) {
					outputText("\n\n");
					outputText("A knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor].  <b>You now have tiny demonic wings</b>.");
					setWingType(Wings.BAT_LIKE_TINY, "tiny, bat-like");
				}
				changes++;
			}
			//arms
			if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.DEVIL && (player.wings.type == Wings.BAT_LIKE_TINY || player.wings.type == Wings.BAT_LIKE_LARGE)) {
				outputText("\n\nYour hands shapeshift as they cover in fur and morph into the clawed hands of some unknown beast. They retain their dexterity despite their weird shape and paw pads. At least this won't hinder spellcasting. <b>You now have bestial clawed hands!</b>");
				setArmType(Arms.DEVIL);
				changes++;
			}
			//Horns
			if (rand(3) == 0 && changes < changeLimit && player.horns.type != Horns.GOAT && player.arms.type == Arms.DEVIL) {
				if (player.horns.type == Horns.NONE) outputText("You begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				else outputText("You begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				setHornType(Horns.GOAT, 1);
				changes++;
			}
			//Ears
			if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.GOAT && player.horns.type == Horns.GOAT) {
				outputText("\n\nYour ears elongate and flatten on your head. You flap them a little and discover they have turned into something similar to the ears of a goat. <b>You now have goat ears!</b>");
				setEarType(Ears.GOAT);
				changes++;
			}
			//Fangs
			if (rand(3) == 0 && changes < changeLimit && player.faceType != Face.DEVIL_FANGS && player.ears.type == Ears.GOAT) {
				outputText("\n\nYou feel your canines grow slightly longer to take on a sharp appearance like those of a beast. Perhaps not as long as you thought they would end up as but clearly they make your smile all the more fiendish. <b>You now have demonic fangs!</b>");
				setFaceType(Face.DEVIL_FANGS);
				changes++;
			}
			//Eyes
			if (rand(3) == 0 && changes < changeLimit && player.eyes.type != Eyes.DEVIL && player.faceType == Face.DEVIL_FANGS) {
				outputText("\n\nYour eyes feels like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a demonic appearance: the sclera is black and the pupils ember. Furthermore they seem to glow with a faint inner light. <b>You now have fiendish eyes!</b>");
				setEyeTypeAndColor(Eyes.DEVIL,"ember");
				changes++;
			}
			//Shrinkage!
			if (rand(2) == 0 && player.tallness > 42) {
				outputText("\n\nYou see the ground grow closer. Upon examining yourself you discover you are shorter than before.");
				player.tallness -= 1 + rand(3);
				changes++;
			}
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		
		public function prisonBread(player:Player):void {
			prison.prisonItemBread(false);
		}
		
		public function prisonCumStew(player:Player):void {
			prison.prisonItemBread(true);
		}
		
		public function frothyBeer(player:Player):void {
			outputText("Feeling parched, you twist the metal cap from the clear green bottle and chug it down. ");
			dynStats("lus", 15);
			player.refillHunger(10, false);
			if (!player.hasStatusEffect(StatusEffects.Drunk)) {
				player.createStatusEffect(StatusEffects.Drunk, 2, 1, 1, 0);
				dynStats("str", 0.1);
				dynStats("inte", -0.5);
				dynStats("lib", 0.25);
			}
			else {
				player.addStatusValue(StatusEffects.Drunk, 2, 1);
				if (player.statusEffectv1(StatusEffects.Drunk) < 2) player.addStatusValue(StatusEffects.Drunk, 1, 1);
				if (player.statusEffectv2(StatusEffects.Drunk) == 2) {
					outputText("\n\n<b>You feel a bit drunk. Maybe you should cut back on the beers?</b>");
				}
				//Get so drunk you end up peeing! Genderless can still urinate.
				if (player.statusEffectv2(StatusEffects.Drunk) >= 3) {
					outputText("\n\nYou feel so drunk; your vision is blurry and you realize something's not feeling right. Gasp! You have to piss like a racehorse! You stumble toward the nearest bush");
					if (player.hasVagina() && !player.hasCock()) outputText(player.clothedOrNakedLower(", open up your [armor]") + " and release your pressure onto the ground. ");
					else outputText(player.clothedOrNakedLower(", open up your [armor]") + " and release your pressure onto the wall. ");
					outputText("It's like as if the floodgate has opened! ");
					awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
					awardAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, true, true, false);
					outputText("\n\nIt seems to take forever but it eventually stops. You look down to see that your urine has been absorbed into the ground.");
					player.removeStatusEffect(StatusEffects.Drunk);
					cheatTime(1/12);
				}
			}
			if (player.tone < 70) player.modTone(70, rand(3));
			if (player.femininity > 30) player.modFem(30, rand(3));
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= DrunkenPowerEmpowerOni()) DrunkenPowerEmpower();
		}
		
		public function jabberwockyScale(player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 0;
			clearOutput();
			player.refillHunger(10);
			if (player.dragonScore() > 9 || player.dragonneScore() > 9) {
				outputText("You eat the scale expecting some kind of spectacular change and for a moment pretty much nothing happen. You begin to feel weird… like very weird. For some reason your situation as a whole is so funny you can’t help but laugh. Are you seriously eating some otherworldly dragon scale just so you can turn into a messed up rabbit dragon yourself? Aha yes you are and that's way to funny.");
				changeLimit += 2;
			}
			else {
				outputText("You eat the scale expecting some kind of spectacular change strangely nothing happened. Maybe you should stop eating everything you find.");
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//-Jabberwocky face/bucktooth
			if ((player.faceType == Face.DRAGON || player.faceType == Face.DRAGON_FANGS) && changes < changeLimit) {
				outputText("\n\nWhile you are busy laughing at the ridicule of this situation your bucktooth begin to pulse in accordance with your laughter growing almost to rabbit like size. You now have ");
				if (player.faceType == Face.DRAGON_FANGS) {
					outputText("<b>Jabberwocky buck tooths!</b>");
					setFaceType(Face.BUCKTOOTH);
				}
				else {
					outputText("<b>a Jabberwocky face.</b>");
					setFaceType(Face.JABBERWOCKY);
				}
				changes++;
			}
			//-Fea Dragon Wings
			if ((player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.DRACONIC_HUGE) && changes < changeLimit) {
				outputText("\n\nYou ain't even noticing as something messed up happen in your wings. They shrivel and change taking on a delicate almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fey dragon wings.</b>");
				setWingType(Wings.FEY_DRAGON_WINGS, "large majestic fey draconic");
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function redRiverRoot(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var x:int = 0;
			//Temporary storage
			//var temp2:Number = 0;
			//var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			clearOutput();
			outputText("Having bought that odd-looking root on the bakery, you give it a try, only to face the mildly spicy taste of the transformative. Still, it has a rich flavour and texture, but soon that becomes secondary, as you realize that the foreign rhizome is changing your body!");
			
			//spe change
			if (player.spe < 100 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nAfter a momentaneous dizziness, you recover your stance, and find your muscles becoming more nimble and prompt to run.");
				//+3 spe if less than 50
				if (player.spe < 50) dynStats("spe", 1);
				//+2 spe if less than 75
				if (player.spe < 75) dynStats("spe", 1);
				//+1 if above 75.
				dynStats("spe", 1);
				changes++;
			}
			if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
			//sexual changes
			//-If the PC has quad nipples:
			if(player.averageNipplesPerBreast() > 1 && rand(4) == 0 && changes < changeLimit)
			{
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts.  <b>You are left with only one nipple on each breast.</b>");
				for(x = 0; x < player.bRows(); x++)
				{
					player.breastRows[x].nipplesPerBreast = 1;
				}
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.bRows() > 1 && rand(3) == 0) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			if (player.butt.type > 5) {
				player.butt.type -= 2;
				outputText("\n\nA feeling of tightness starts in your [butt], increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your [butt] is shrinking into a more manageable size.");
			}
			if (player.isFemaleOrHerm()) {
				if (player.biggestTitSize() <= 2 && changes < changeLimit && rand(3) == 0) {
					player.growTits(1 + rand(2), 1, false, 3);
					outputText("\n\nYour breasts feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach "+player.breastCup(0)+" size. You rub the tender orbs as you get used to your larger breast flesh.");
					changes++;
					dynStats("lib", 1);
				}
				if (changes < changeLimit && rand(3) == 0 && player.biggestTitSize() > 4)
				{
					player.shrinkTits();
					changes++;
				}
				if (player.hips.type > 12) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully. Your hips have narrowed.");
					player.hips.type -= 1 + rand(3);
					changes++;
				}
				if (player.hips.type < 6) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.type += 1 + rand(3);
					changes++;
				}
				if (player.nippleLength > 1 && player.biggestTitSize() > 0) {
					outputText("\n\nWith a sudden pinch your [nipples] get smaller and smaller, stopping when they are roughly half their previous size");
					player.nippleLength /= 2;
				}
				if (player.hasVagina() && player.vaginas[0].vaginalWetness < 3 && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYour [cunt]'s internal walls feel a tingly wave of strange tightness which then transitions into a long stretching sensation, like you were made of putty. Experimentally, you slip a couple of fingers inside to find you've become looser and more pliable, ready to take those monster cocks.");
					player.vaginas[0].vaginalWetness++;
					changes++;
				}
				if (player.tone < 65 && rand(3) == 0) {
					outputText(player.modTone(65, 2));
				}
				if (player.thickness > 35 && rand(3) == 0) {
					outputText(player.modThickness(35, 5));
				}
			}
			if (player.isMale()) {
				if (changes < changeLimit && rand(3) == 0 && player.biggestTitSize() > 2)
				{
					player.shrinkTits();
					changes++;
				}
				if (player.nippleLength > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a sudden pinch your [nipples] get smaller and smaller, stopping when they are roughly half their previous size");
					player.nippleLength /= 2;
				}
				if (player.hips.type > 10 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully. Your hips have narrowed.");
					player.hips.type -= 1 + rand(3);
					changes++;
				}
				if (player.hips.type < 2 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.type += 1 + rand(3);
					changes++;
				}
				if (player.tone < 70 && rand(3) === 0) {
					outputText(player.modTone(65, 2));
				}
				if (player.thickness > 35 && rand(3) === 0) {
					outputText(player.modThickness(35, 5));
				}
			}
			if (player.isMaleOrHerm()) {
				if (player.hasCock() && player.cocks[0].cockType != CockTypesEnum.RED_PANDA && rand(3) == 0 && changes < changeLimit) {
					outputText("\n\nThe skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath. <b>You now have a red-panda cock!</b>");
					player.cocks[0].cockType = CockTypesEnum.RED_PANDA;
					changes++;
				}
				if (player.shortestCockLength() < 6 && rand(3) == 0 && changes < changeLimit) {
					var increment:Number = player.increaseCock(player.shortestCockIndex(), 1 + rand(2));
					outputText("Your [if (cocks > 1)shortest] cock fills to its normal size, but doesn’t just stop there. Your cock feels incredibly tight as a few more inches of length seem to pour out from your crotch. Your cock has gained "+ increment + " inches.");
					changes++;
				}
				if (player.biggestCockLength() > 16 && rand(3) == 0 && changes < changeLimit) {
					var idx:int = player.biggestCockIndex();
						outputText("\n\nYou feel a tightness in your groin like someone tugging on your shaft from behind you. Once the sensation"
						          +" fades you check [if (hasLowerGarment)inside your [lowergarment]|your [multicock]] and see that your"
						          +" [if (cocks > 1)largest] [cock] has shrunk to a slightly shorter length.");
					player.cocks[idx].cockLength -= (rand(10) + 5) / 10;
					if (player.cocks[idx].cockThickness > 3) {
						outputText(" Your " + player.cockDescript(idx) + " definitely got a bit thinner as well.");
						player.cocks[idx].cockThickness -= (rand(4) + 1) / 10;
					}
					changes++;
				}
				if (player.smallestCockArea() < 10 && rand(3) == 0 && changes < changeLimit) {
					outputText("[if (cocks > 1) One of your cocks|Your cock] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					player.cocks[player.thinnestCockIndex()].thickenCock(1.5);
					changes++;
				}
			}

			//Remove additional cocks
			if (player.cocks.length > 1 && rand(3) == 0 && changes < changeLimit) {
				player.removeCock(1, 1);
				outputText("\n\nYou have a strange feeling as your crotch tingles.  Opening your [armor], <b>you realize that one of your cocks have vanished completely!</b>");
				changes++;
			}
			//Remove additional balls/remove uniball
			if ((player.balls > 0 || player.hasStatusEffect(StatusEffects.Uniball)) && rand(3) == 0 && changes < changeLimit) {
				if (player.ballSize > 2) {
					if (player.ballSize > 5) player.ballSize -= 1 + rand(3);
					player.ballSize -= 1;
					outputText("\n\nYour scrotum slowly shrinks, settling down at a smaller size. <b>Your " + player.ballsDescriptLight() + " ");
					if (player.balls == 1 || player.hasStatusEffect(StatusEffects.Uniball)) outputText("is smaller now.</b>");
					else outputText("are smaller now.</b>");
					changes++;
				}
				else if (player.balls > 2) {
					player.balls = 2;
					//I have no idea if Uniball status effect sets balls to 1 or not so here's a just in case.
					if (player.hasStatusEffect(StatusEffects.Uniball)) player.removeStatusEffect(StatusEffects.Uniball);
					outputText("\n\nYour scrotum slowly shrinks until they seem to have reached a normal size. <b>You can feel as if your extra balls fused together, leaving you with a pair of balls.</b>");
					changes++;
				}
				else if (player.balls == 1 || player.hasStatusEffect(StatusEffects.Uniball)) {
					player.balls = 2;
					if (player.hasStatusEffect(StatusEffects.Uniball)) player.removeStatusEffect(StatusEffects.Uniball);
					outputText("\n\nYour scrotum slowly shrinks, and you feel a great pressure release in your groin. <b>Your uniball has split apart, leaving you with a pair of balls.</b>");
					changes++;
				}
			}
			//physical changes
			//Ears
			if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.RED_PANDA) {
				outputText("\n\n");
				if (flags[kFLAGS.MINO_CHEF_TALKED_RED_RIVER_ROOT] > 0) outputText("The warned dizziness");
				else outputText("A sudden dizziness");
				outputText(" seems to overcome your head. Your ears tingle, and you’re sure you can feel the flesh on them shifting, as you gradually have trouble hearing. A couple of minutes later the feeling stops. Curious of what has changed you go to check yourself on the stream, only to find that they’ve changed into cute, triangular ears, covered with white fur. <b>You’ve got red-panda ears!</b>");
				setEarType(Ears.RED_PANDA);
				changes++;
			}
			//Removes antennae.type
			if (player.antennae.type > Antennae.NONE && player.antennae.type != Antennae.COCKATRICE && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nThe pair of antennae.type atop your head start losing the ability of ‘feel’ your surroundings as the root takes effect on them. Soon they recede on your head, and in a matter of seconds, it looks like they never were there.");
				player.antennae.type = Antennae.NONE;
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(4) == 0 && player.eyes.type > Eyes.HUMAN) {
				humanizeEyes();
				changes++;
			}
			//Hair
			var panda_hair:Array = ["white", "auburn", "red", "russet"];
			if ((!InCollection(player.hairColor, panda_hair) || player.hairType != 0) && changes < changeLimit && rand(3) == 0) {
				if (!InCollection(player.hairColor, panda_hair)) {
					player.hairColor = randomChoice(panda_hair);
					outputText("\n\nA mild tingling on your scalp makes your check yourself on the stream. Seems like the root is changing your hair this time, turning it into [hair].");
				}
				if (player.hairLength == 0) {
					player.hairLength = 1;
					outputText("\n\nThe familiar sensation of hair returns to your head. After looking yourself on the stream, you confirm that your once bald head now has normal, short [haircolor] hair.");
				}
				if (player.hairType != 0) {
					if (player.hairType == Hair.FEATHER) outputText("\n\nShortly after their taste fades, the roots seem to have effect. Your scalp itches and as you scratch you see your feathered hair begin to shed, downy feathers falling from your head until you are bald. Alarmed by this sudden change you quickly go to examine yourself in the nearby river, relief soon washing over you as new [haircolor] hair begins to rapidly grow. <b>You now have [hair]</b>!");
					else if (player.hairType == Hair.GORGON) {
						player.hairLength = 1;
						outputText("\n\nAs you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes start hissing uncontrollably. Many of them go rigid, any kind of life that they could had taken away by the root effects. Soon all the snakes that made your hair are limp and lifeless.");
						outputText("\n\nTheir dead bodies are separated from you head by a scorching sensation, and start falling to the ground, turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.");
						outputText("\n\nThe effects don’t end here, though as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.");
					}
					else if (player.hairType == Hair.GOO) {
						player.hairLength = 1;
						outputText("\n\nAfter having consumed the root, a lock of gooey hair falls over your forehead. When you try to examine it, the bunch of goo falls to the ground and evaporates. As you tilt your head to see what happened, more and more patches of goo start falling from your head, disappearing on the ground with the same speed. Soon, your scalp is devoid of any kind of goo, albeit entirely bald.");
						outputText("\n\nNot for long, it seems, as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.");
					}
					else outputText("\n\nA mild tingling on your scalp makes your check yourself on the stream. Seems like the root is changing your hair this time, <b>turning it into [hair]</b>.");
					setHairType(Hair.NORMAL);
				}
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				changes++;
			}
			//Face
			if (rand(3) == 0 && changes < changeLimit && player.faceType != Face.RED_PANDA && player.ears.type == Ears.RED_PANDA) {
				outputText("\n\nNumbness comes to your cheekbones and jaw, while the rest of your head is overwhelmed by a tingling sensation. Every muscle on your face tenses and shifts, while the bones and tissue rearrange, radically changing the shape of your head. You have troubles breathing as the changes reach your nose, but you manage to see as it changes into an animalistic muzzle. You jaw joins it and your teeth sharpen a little, not to the point of being true menacing, but gaining unequivocally the shape of those belonging on a little carnivore.");
				outputText("\n\nOnce you’re face and jaw has reshaped, fur covers the whole of your head. The soft sensation is quite pleasant. It has a russet-red coloration, that turns to white on your muzzle and cheeks. Small, rounded patches of white cover the area where your eyebrows were. <b>You now have a red-panda head!</b>");
				setFaceType(Face.RED_PANDA);
				changes++;
			}
			//Arms
			if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.RED_PANDA && player.tailType == Tail.RED_PANDA) {
				outputText("\n\nWeakness overcomes your arms, and no matter what you do, you can’t muster the strength to raise or move them. Sighing you attribute this to the consumption of that strange root. Sitting on the ground, you wait for the limpness to end. As you do so, you realize that the bones at your hands are changing, as well as the muscles on your arms. They’re soon covered, from the shoulders to the tip of your digits, on a layer of soft, fluffy black-brown fur. Your hands gain pink, padded paws where your palms were once, and your nails become short claws, not sharp enough to tear flesh, but nimble enough to make climbing and exploring much easier. <b>Your arms have become like those of a red-panda!</b>");
				setArmType(Arms.RED_PANDA);
				changes++;
			}
			//Legs
			if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.RED_PANDA && player.arms.type == Arms.RED_PANDA) {
				if (player.isTaur()) {
					outputText("\n\nYou legs tremble, forcing you to lie on the ground, as they don't seems to answer you anymore. A burning sensation in them is the last thing you remember before briefly blacking out. When it subsides and you finally awaken, you look at them again, only to see that you’ve left with a single set of digitigrade legs, and a much more humanoid backside. Soon enough, the feeling returns to your reformed legs, only to come with an itching sensation. A thick black-brown coat of fur sprouts from them. It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>");
				}
				if (player.isNaga()) {
					outputText("\n\nA strange feeling in your tail makes you have to lay on the ground. Then, the feeling becomes stronger, as you feel an increasing pain in the middle of your coils. You gaze at them for a second, only to realize that they’re dividing! In a matter of seconds, they’ve reformed into a more traditional set of legs, with the peculiarity being that they’re fully digitigrade in shape. Soon, every scale on them falls off to leave soft [skin] behind. That doesn’t last long, because soon a thick coat of black-brown fur covers them. It feels soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>");
				}
				if (player.isGoo()) {
					outputText("\n\nThe blob that forms your lower body becomes suddenly rigid under the rhizome effects, forcing you to stay still until the transformation ends. Amazingly, what was once goo turns into flesh and skill in mere seconds, thus leaving you with a very human-like set of legs and feet.");
					outputText("\n\nIt doesn’t stop here as a feeling of unease forces you to sit on a nearby rock, as you feel something within your newly regained feet is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. For a second you feel that they’re becoming goo again, but after a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>");
				}
				else {
					outputText("\n\nA feeling of unease forces your to sit on a nearby rock, as you feel something within your [feet] is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>");
				}
				setLowerBody(LowerBody.RED_PANDA);
				player.legCount = 2;
				changes++;
			}
			//Tail
			if (rand(3) == 0 && changes < changeLimit && player.tailType != Tail.RED_PANDA) {
				outputText("\n\n");
				if (player.tailCount > 1) {
					outputText("Your tails seem to move on their own, tangling together in a single mass. Before you can ever feel it happening, you realize that they’re merging! An increased sensation of heat, not unlike the flavor of the roots, rushes through your body, and once that it fades, you realize that you now have a single tail.");
					outputText("\n\nThe process doesn’t stop here though, as the feel of that spicy root returns, but now the heat is felt only in your tail, as it shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
					outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful to the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
				}
				else if (player.tailType == Tail.NONE) {
					outputText("Feeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a rough surface. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses  seem to have stopped, it has become a long, fluffy tube");
					outputText("\n\nShortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
					outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
				}
				else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.MANTIS_ABDOMEN) {
					outputText("Your insectile backside seems affected by the root properties, as your venom production suddenly stops. The flesh within the abdomen retracts into your backside, the chiting covering falling, leaving exposed a layer of soft, bare skin. When the abdomen disappears, your left with a comically sized butt, that soon reverts to its usual size.");
					outputText("\n\nThe root keeps doing its thing, as you feel an uncomfortable sensation on your butt. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses  seem to have stopped, it has become a long, fluffy tube, quite different from your former abdomen.");
					outputText("\n\nShortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
					outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
				}
				else {
					outputText("The feel of that spicy root returns, but now the heat is felt on your tail, that shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
					outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control their moves with easy, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
				}
				setTailType(Tail.RED_PANDA, 1);
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && !player.hasFur()) {
				if (!player.hasCoat()) {
					outputText("\n\nYou start to scratch your [skin], as an uncomfortable itching overcomes you. It’s quite annoying, like the aftermath of being bitten by a bug, only that it’s all over at the same time.");
				}
				else if (player.hasScales()) {
					outputText("\n\nThe layer of scales covering your body feels weird for a second, almost looking like they’re moving on they own, and that is when you realize that they changing!");
					outputText("\n\nThe feeling is quite odd, a bit of an itching from the place where they join your skin, that quickly becomes more intense as their transformation advances. Then a bunch of scales fall from your arm. Soon all the scales on your arm fall off, leaving behind a layer of healthy, normal skin. The process continues overs the rest of your body, and before long you are covered in a layer of " + player.skinTone + " skin.");
					outputText("\n\nNot for long though, as an uncomfortable itching overcomes you. It’s quite annoying, like the aftermath of being bitten for a bug, only all over your body at the same time.");
				}
				outputText("\n\nSoon you realize that the sensation is coming from <i>under</i> your skin. After rubbing one of your arms in annoyance, you feel something different, and when you lay your eyes on it, you realize that a patch of fur is growing over your skin. Then you spot similar patches over your legs, chest and back. Fur grows over your body, patches joining and closing over your skin, and in a matter of seconds, your entire body is covered with a lovely coat of thick fur. The soft and fluffy sensation is quite pleasant to the touch.  <b>Seems like you’re now covered from head to toe with russet-red fur with black fur on your underside!</b>");
				player.skin.growCoat(Skin.FUR,{
					color:"russet-red",
					color2:"black",
					pattern:Skin.PATTERN_RED_PANDA_UNDERBODY
				});
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedFur)) {
					outputText("\n\n<b>Genetic Memory: Fur - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedFur, 0, 0, 0, 0);
				}
				changes++;
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function skelp(player:Player):void
		{
			player.slimeFeed();
			//init variables
			var changes:Number = 0;
			var changeLimit:Number = 1;
			var x:int = 0;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Randomly choose affects limit
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(4) == 0) changeLimit++;
			changeLimit += additionalTransformationChances();
			clearOutput();
			outputText("You eat the kelp and a deep chill runs across your body as something in you begins to change.");
			
			//spe change
			if (player.spe < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nYou feel like a coiled spring, ready to swim or run a marathon!");
				//+3 spe if less than 50
				if (player.spe < 50) dynStats("spe", 1);
				//+2 spe if less than 75
				if (player.spe < 75) dynStats("spe", 1);
				//+1 if above 75.
				dynStats("spe", 1);
				changes++;
			}
			//int change
			if (player.inte < 100 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWhile the cold air around you doesn’t feel comfortable it brings you sharpness of mind like never before.");
				dynStats("int", 1);
				changes++;
			}
			//lib change
			if (player.lib < 70 && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nGah it's so cold out there, you could use some warmth… the warmth of a strong, caring man. ");
				if (player.lib < 30) outputText("Whoa wait, what are you daydreaming about exactly? This place is clearly getting to you!");
				else outputText("Mmmmm, if you could get him tight and snuggly against your body to share his heat perhaps he wouldn’t even mind gently inserting himself in and filling you full of his warm man meat. As you start drooling in desire the sudden chill of the wind against your skin jar you awake from your daydream making you shiver.");
				dynStats("lib", 1);
				changes++;
			}
			//sens change
			if (rand(3) == 0 && changes < changeLimit) {
				outputText("\n\nWhoa… It's chilly out there. You feel the passage of cold wind on your skin as your sensitivity increases.");
				dynStats("sen", 1);
			}
			//Sex bits - Duderiffic
			if (player.cocks.length > 0 && rand(2) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				//If the player has at least one dick, decrease the size of each slightly,
				outputText("\n\n");
				temp = 0;
				temp2 = player.cocks.length;
				temp3 = 0;
				//Find biggest cock
				while (temp2 > 0) {
					temp2--;
					if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
				}
				//Shrink said cock
				if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
					player.cocks[temp].cockLength -= .5;
					temp3 -= .5;
				}
				temp3 += player.increaseCock(temp, (rand(3) + 1) * -1);
				player.lengthChange(temp3, 1);
				if (player.cocks[temp].cockLength < 2) {
					outputText("  ");
					if (player.cockTotal() == 1 && !player.hasVagina()) {
						outputText("Your [cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.");
						if (player.balls > 0) outputText("  At the same time, your [balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.");
						outputText("  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>");
						player.balls = 0;
						player.ballSize = 1;
						player.createVagina();
						player.clitLength = .25;
						player.removeCock(0, 1);
					}
					else {
						player.killCocks(1);
					}
				}
				//if the last of the player's dicks are eliminated this way, they gain a virgin vagina;
				if (player.cocks.length == 0 && !player.hasVagina()) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.clitLength = .25;
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [vagina]</b>!");
					changes++;
					dynStats("lus", 10);
				}
			}
			//Sex bits - girly
			var boobsGrew:Boolean = false;
			//Increase player's breast size, if they are HH or bigger
			//do not increase size, but do the other actions:
			if (player.biggestTitSize() <= 10 && changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
			//If the player is under 7 feet in height, increase their height
			if (player.tallness < 96 && changes < changeLimit && rand(2) == 0) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 74) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			
			
			
			if (changes < changeLimit && rand(2) == 0) outputText(player.modFem(100, 3));
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function hardBiscuits(player:Player):void {
			outputText("You eat the flavorless biscuits. It satisfies your hunger a bit, but not much else.");
			player.refillHunger(15);
		}
		
		public function trailMix(player:Player):void {
			outputText("You eat the trail mix. You got energy boost from it!");
			player.refillHunger(30);
			fatigue(-20);
			HPChange(Math.round(player.maxHP() * 0.1), true);
		}
	}
}
