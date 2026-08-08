globals
//globals from DamageEngine:
constant boolean LIBRARY_DamageEngine=true
timer DamageEngine___alarm= CreateTimer()
boolean DamageEngine___alarmSet= false
    
    //Values to track the original pre-spirit Link/defensive damage values
boolean DamageEngine___canKick= true
boolean DamageEngine___totem= false
real DamageEngine___lastAmount= 0.00
real DamageEngine___lastPrevAmt= 0.00
integer DamageEngine___lastType= 0
boolean DamageEngine___lastCode= false
real DamageEngine___lastPierced= 0.00
integer DamageEngine___armorType= 0
integer DamageEngine___lastArmor= 0
integer DamageEngine___lastPrevArmor= 0
integer DamageEngine___defenseType= 0
integer DamageEngine___lastDefense= 0
integer DamageEngine___lastPrevDefense= 0
    
    //Stuff to track recursive UnitDamageTarget calls.
boolean DamageEngine___eventsRun= false
boolean DamageEngine___kicking= false
integer DamageEngine___damageStack= 0
unit array DamageEngine___sourceStack
unit array DamageEngine___targetStack
real array DamageEngine___amountStack
attacktype array DamageEngine___attackTStack
damagetype array DamageEngine___damageTStack
weapontype array DamageEngine___weaponTStack
integer array DamageEngine___userTrigStack
integer array DamageEngine___typeStack
    
    //Added in 5.4 to silently eliminate infinite recursion.
integer DamageEngine___userTrigs= 9
integer DamageEngine___eventTrig= 0
integer array DamageEngine___nextTrig
trigger array DamageEngine___userTrig
boolean array DamageEngine___trigFrozen
        
    //Added/re-tooled in 5.4.1 to allow forced recursion (for advanced users only).
constant integer DamageEngine___LIMBO= 16
integer array DamageEngine___levelsDeep
boolean DamageEngine_inception= false
                                                        //When true, it allows your trigger to potentially go recursive up to LIMBO.
boolean DamageEngine___dreaming= false
boolean array DamageEngine___inceptionTrig
integer DamageEngine___sleepLevel= 0
group DamageEngine___proclusGlobal= CreateGroup()
group DamageEngine___fischerMorrow= CreateGroup()
    
    //Improves readability in the code to have these as named constants.
constant integer DamageEngine___MOD_EVENT= 1
constant integer DamageEngine___SHIELD_EVENT= 4
constant integer DamageEngine___DAMAGE_EVENT= 5
constant integer DamageEngine___ZERO_EVENT= 6
constant integer DamageEngine___AFTER_EVENT= 7
constant integer DamageEngine___LETHAL_EVENT= 8
constant integer DamageEngine___AOE_EVENT= 9
    
    //private string crashStr = ""
//endglobals from DamageEngine
    // User-defined
integer udg_chance= 0
integer array udg_item_6
effect array udg_item_6_SpecialEffect
integer array udg_item_9
effect array udg_item_9_SpecialEffect
integer array udg_stormhammer
effect array udg_stormhammer_SpecialEffect
integer array udg_item_25
timer udg_wave_timer= null
timer udg_start_timer= null
location array udg_spawn_point
location array udg_spawn_point_1
location array udg_spawn_point_2
location array udg_spawn_point_3
integer udg_income_gold= 0
real udg_income_wood= 0
integer udg_bonus_gold_to_top3= 0
integer udg_AI_WarGolem= 0
integer array udg_Ability_ultimate_Limit
timer udg_pvp_timer= null
integer udg_Sec_5= 0
unit udg_pvp_last_player= null
timer udg_FinalDuels_timer= null
integer array udg_trait3_2
timer udg_enrage_timer= null
integer array udg_FinalDuels_wins
integer array udg_trait1
integer array udg_trait3
integer array udg_trait6
integer array udg_trait8
integer array udg_trait10
integer array udg_lvl2_trait5
integer array udg_lvl2_trait7
integer array udg_retraining_Ability
integer array udg_retraining_levelof_Ability
integer udg_pig= 0
attacktype array udg_CONVERTED_ATTACK_TYPE
damagetype array udg_CONVERTED_DAMAGE_TYPE
real udg_DamageEventArmorPierced= 0
real udg_AfterDamageEvent= 0
boolean udg_DamageEventOverride= false
real udg_DamageEvent= 0
real udg_DamageModifierEvent= 0
real udg_DamageEventAmount= 0
unit udg_DamageEventSource= null
unit udg_DamageEventTarget= null
real udg_DamageEventPrevAmt= 0
real udg_LethalDamageEvent= 0
real udg_LethalDamageHP= 0
real udg_AOEDamageEvent= 0
unit udg_AOEDamageSource= null
integer udg_DamageEventAOE= 0
group udg_DamageEventAOEGroup= null
integer udg_DamageEventLevel= 0
unit udg_EnhancedDamageTarget= null
integer udg_DamageEventType= 0
integer udg_NextDamageType= 0
real udg_DamageScalingUser= 0
real udg_DamageScalingWC3= 0
integer udg_DamageTypeBlocked= 0
integer udg_DamageTypeCriticalStrike= 0
integer udg_DamageTypeCode= 0
integer udg_DamageTypeExplosive= 0
integer udg_DamageTypeHeal= 0
integer udg_DamageTypePure= 0
integer udg_DamageTypePureExplosive= 0
integer udg_DamageTypeReduced= 0
boolean udg_IsDamageCode= false
boolean udg_IsDamageMelee= false
boolean udg_IsDamageRanged= false
boolean udg_IsDamageSpell= false
integer udg_DamageEventArmorT= 0
integer udg_ARMOR_TYPE_NONE= 0
integer udg_ARMOR_TYPE_FLESH= 0
integer udg_ARMOR_TYPE_METAL= 0
integer udg_ARMOR_TYPE_WOOD= 0
integer udg_ARMOR_TYPE_ETHEREAL= 0
integer udg_ARMOR_TYPE_STONE= 0
string array udg_ArmorTypeDebugStr
integer udg_DamageEventAttackT= 0
integer udg_ATTACK_TYPE_SPELLS= 0
integer udg_ATTACK_TYPE_NORMAL= 0
integer udg_ATTACK_TYPE_PIERCE= 0
integer udg_ATTACK_TYPE_SIEGE= 0
integer udg_ATTACK_TYPE_MAGIC= 0
integer udg_ATTACK_TYPE_CHAOS= 0
integer udg_ATTACK_TYPE_HERO= 0
string array udg_AttackTypeDebugStr
integer udg_DamageEventDamageT= 0
integer udg_DAMAGE_TYPE_UNKNOWN= 0
integer udg_DAMAGE_TYPE_NORMAL= 0
integer udg_DAMAGE_TYPE_ENHANCED= 0
integer udg_DAMAGE_TYPE_FIRE= 0
integer udg_DAMAGE_TYPE_COLD= 0
integer udg_DAMAGE_TYPE_LIGHTNING= 0
integer udg_DAMAGE_TYPE_POISON= 0
integer udg_DAMAGE_TYPE_DISEASE= 0
integer udg_DAMAGE_TYPE_DIVINE= 0
integer udg_DAMAGE_TYPE_MAGIC= 0
integer udg_DAMAGE_TYPE_SONIC= 0
integer udg_DAMAGE_TYPE_ACID= 0
integer udg_DAMAGE_TYPE_FORCE= 0
integer udg_DAMAGE_TYPE_DEATH= 0
integer udg_DAMAGE_TYPE_MIND= 0
integer udg_DAMAGE_TYPE_PLANT= 0
integer udg_DAMAGE_TYPE_DEFENSIVE= 0
integer udg_DAMAGE_TYPE_DEMOLITION= 0
integer udg_DAMAGE_TYPE_SLOW_POISON= 0
integer udg_DAMAGE_TYPE_SPIRIT_LINK= 0
integer udg_DAMAGE_TYPE_SHADOW_STRIKE= 0
integer udg_DAMAGE_TYPE_UNIVERSAL= 0
string array udg_DamageTypeDebugStr
integer udg_DamageEventDefenseT= 0
integer udg_DEFENSE_TYPE_LIGHT= 0
integer udg_DEFENSE_TYPE_MEDIUM= 0
integer udg_DEFENSE_TYPE_HEAVY= 0
integer udg_DEFENSE_TYPE_FORTIFIED= 0
integer udg_DEFENSE_TYPE_NORMAL= 0
integer udg_DEFENSE_TYPE_HERO= 0
integer udg_DEFENSE_TYPE_DIVINE= 0
integer udg_DEFENSE_TYPE_UNARMORED= 0
string array udg_DefenseTypeDebugStr
string array udg_WeaponTypeDebugStr
integer udg_WEAPON_TYPE_NONE= 0
integer udg_WEAPON_TYPE_ML_CHOP= 0
integer udg_WEAPON_TYPE_MM_CHOP= 0
integer udg_WEAPON_TYPE_MH_CHOP= 0
integer udg_WEAPON_TYPE_ML_SLICE= 0
integer udg_WEAPON_TYPE_MM_SLICE= 0
integer udg_WEAPON_TYPE_MH_SLICE= 0
integer udg_WEAPON_TYPE_MM_BASH= 0
integer udg_WEAPON_TYPE_MH_BASH= 0
integer udg_WEAPON_TYPE_MM_STAB= 0
integer udg_WEAPON_TYPE_MH_STAB= 0
integer udg_WEAPON_TYPE_WL_SLICE= 0
integer udg_WEAPON_TYPE_WM_SLICE= 0
integer udg_WEAPON_TYPE_WH_SLICE= 0
integer udg_WEAPON_TYPE_WL_BASH= 0
integer udg_WEAPON_TYPE_WM_BASH= 0
integer udg_WEAPON_TYPE_WH_BASH= 0
integer udg_WEAPON_TYPE_WL_STAB= 0
integer udg_WEAPON_TYPE_WM_STAB= 0
integer udg_WEAPON_TYPE_CL_SLICE= 0
integer udg_WEAPON_TYPE_CM_SLICE= 0
integer udg_WEAPON_TYPE_CH_SLICE= 0
integer udg_WEAPON_TYPE_AM_CHOP= 0
integer udg_WEAPON_TYPE_RH_BASH= 0
integer udg_DamageEventWeaponT= 0
unit udg_temp_Unit= null
location udg_temp_Point= null
integer array udg_lvl3_trait3
integer array udg_lvl3_trait4
integer array udg_orb_of_kil_trait
integer array udg_overwhelm_trait
integer array udg_trait11
integer array udg_item_35
effect array udg_item_35_SpecialEffect
group udg_temp_UnitGroup= null
integer array udg_item_37
unit array udg_item_37_Unit
integer array udg_trait9
fogmodifier array udg_map_reveal
integer udg_temp_num= 0
integer array udg_trait10_Copy
effect array udg_trait10_SpecialEffect
integer udg_creeps_enrage= 0
integer array udg_trait12
integer array udg_Abilities_Items
integer array udg_maxabilities_counter
hashtable udg_maxabilities= null
integer array udg_temp_Abilities
integer array udg_Infinity_Tome
timer array udg_trait5_timer
integer array udg_trait5
integer array udg_NICKLevelUpFix
integer array udg_Hotkey_Abilities
hashtable udg_Hotkey_Htable= null
string array udg_Hotkeys
integer udg_temp_Ability= 0
integer udg_temp_num_1= 0
string udg_temp_string
boolean udg_temp_bol= false
item udg_temp_item= null
integer array udg_temp_Abilities_1
integer array udg_temp_integr
force udg_NICKActivePlayers= null
unit array udg_NICKHeroArray
integer udg_NICKVoteCount= 0
integer udg_NICKFrenzyTraitDMG= 0
string udg_NICKTempText
group udg_NICKDuelsGroup= null
unit array udg_NICKDuelUnitArray
group udg_NICKDuelsWonGroup= null
player udg_winner_player= null
timer array udg_NickClawsofFrenzyTimer
hashtable udg_NICKHashtable= null
timer array udg_NICKManaShieldTimer
real array udg_NICKManaShieldAbsorb
hashtable udg_NICKHashtable2= null
effect array udg_NICKManaShieldEffect
timer array udg_NICKSerathilTimer
hashtable udg_NICKHashtable3= null
integer udg_NICKPhoenixClawDMGType= 0
timer udg_NICKPeriodicTimer= null
unit udg_NICKAllStatsShop= null
integer udg_NICKAllStatsColour= 0
group udg_NICKObsidianRingGroup= null
integer array udg_NICKWandofSorcery
real udg_NICKPhoenixClawDamage= 0
hashtable udg_NICKHashtable4= null
timer array udg_NICKStormHammerTimer
integer array udg_NICKStormHammerCharges
group udg_NICKSkullofGuldanGroup= null
group udg_NICKBerserkerSpearGroup= null
group udg_NICKPhoenixClawGroup= null
integer array udg_NICKLightningJavelinCharges
real array udg_NICKMagicDaggerReal
integer array udg_NICKMagicDaggerInteger
trigger udg_DamageEventTrigger= null
group udg_NICKFirehandGauntletsGroup= null
hashtable udg_NICKHashtable5= null
group udg_NICKFirehandGauntletsAllUnits= null
unit array udg_NICKDamageDummyArray
integer array udg_NICKBeltofGiantStrengthInteger
group udg_NICKBeltofGiantStrengthGroup= null
integer array udg_NICKSkullofGuldanInteger
integer array udg_NICKObsidianRingInteger
hashtable udg_NICKHashtable6= null
timer array udg_NICKGladiatorsAxeTimer
boolean array udg_NICKGladiatorsAxeBoolean
group udg_NICKBootsofQuelThalasGroup= null
integer array udg_NICKBootsofQuelThalasInteger
group udg_NICKRobeoftheMagiGroup= null
integer array udg_NICKRobeoftheMagiInteger
unit array udg_Draft_ChooseShop
unit array udg_Draft_UpgradeShop
boolean array udg_Draft_haschosen
rect array udg_Draft_regions
integer array udg_Draft_NumberofChosen
real array udg_spelldamage
effect array udg_item_energy_staff
integer array udg_thorniumweapons_trait
unit udg_warsong_hero= null
location udg_pig_point= null
unit array udg_Draft_hero_building
multiboard udg_infoboard= null
string udg_iconpath
string array udg_player_colors
string array udg_Abilities
string udg_temp_string2
boolean array udg_cleared_level
group udg_revival_heroes= null
rect array udg_revival_spots
unit udg_revived_hero= null
boolean array udg_lvl2_trait_taken
boolean array udg_lvl3_trait_taken
boolean udg_IsDamageAttack= false
real udg_UnitIndexEvent= 0
real udg_DeathEvent= 0
real udg_HEAL_THRESHOLD= 0
real udg_HEAL_CHECK_INTERVAL= 0
timer udg_heal_timer= null
real udg_REGEN_STRENGTH_VALUE= 0
real udg_REGEN_THRESHOLD= 0
real udg_REGEN_EVENT_INTERVAL= 0
integer udg_heal_exitwhen= 0
integer udg_heal_count= 0
integer udg_heal_integer= 0
integer array udg_heal_indices
unit udg_heal_target= null
unit array udg_UDexUnits
real udg_heal_life= 0
real udg_heal_diff= 0
real array udg_heal_lastLife
real udg_heal_amount= 0
real array udg_heal_regen
real array udg_regen_buildup
real array udg_regen_timeleft
real udg_HealEvent= 0
integer array udg_heal_indexRef
integer udg_UDex= 0
boolean array udg_heal_inSys
integer array udg_UnitIndexLock
integer array udg_UDexPrev
integer array udg_UDexNext
integer udg_UDexRecycle= 0
boolean udg_UnitIndexerEnabled= false
integer udg_UDexWasted= 0
integer udg_UDexGen= 0
player udg_GetLocalPlayer= null
timer udg_wavesDecay_timer= null
weathereffect udg_wavesDecay_effect= null
unit array udg_orb_unit
real udg_temp_real= 0
integer array udg_searingBlade
unit array udg_searingBlade_auraUnit
timer array udg_heresy_timer
unit array udg_heresy_hero
integer array udg_sonicspeed_trait
boolean array udg_helm_used
integer array udg_pillage_stats
integer array udg_grim_stats_hp
integer array udg_grim_stats_mana
integer array udg_killblow_stats
real array udg_armorUp_stats
unit udg_winner_hero= null
boolean array udg_sund_used
integer array udg_portal_trait_count
timer array udg_angry_totem_timer
integer array udg_angry_totem
integer array udg_orb_of_kil_trait_count
timer array udg_decimate_timer
integer array udg_staff_pseudo_chance
integer array udg_firehand_pseudo_chance
integer array udg_infinityclaws_pseudo_chance
integer array udg_orboflightning_pseudo_chance
timer array udg_portal_summoning_timer
group udg_channel_dummies= null
boolean udg_is_pvpround= false
integer array udg_final_pvp_lives
boolean array udg_rainbowpot_used
integer array udg_rainbowpot_best
integer array udg_rainbowpot_worst
integer array udg_rainbowpot_bonusstats
unit array udg_final_pvp_lastopponent
integer array udg_gloves_spell_mastery
rect udg_CP_Rect= null
item udg_CP_Item= null
integer udg_CP_HiddenItemsIndex= 0
item array udg_CP_HiddenItems
location udg_CP_Point= null
integer udg_temp_int= 0
handle udg_handle_temp= null
boolean udg_CP_PointIsWalkable= false
integer udg_NumberOfAbilities= 0
timer array udg_ressed_timer
group udg_bloodheart_temp_group= null
unit array udg_javelin_target
integer array udg_javelin_counter
group udg_move_projectiles_group= null
integer array udg_Draft_rerolled
boolean array udg_floating_text_enabled
hashtable udg_floating_text_table= null
group array udg_floating_text_targets
real array udg_divinity_gauntlet_dmg
timer array udg_demonic_blade_timer
boolean array udg_player_dead
integer array udg_retraining_item_type
handle udg_handle_temp1= null
integer array udg_Draft_choose_amount
boolean array udg_lvl1_trait_taken
integer array udg_Draft_item_options1
integer array udg_Draft_item_options2
integer array udg_Draft_item_options3
integer array udg_Draft_item_options4
integer array udg_Draft_item_options5
unit array udg_Draft_ItemShop
boolean array udg_Draft_items_paused
integer udg_Draft_trait_temp_num= 0
integer array udg_spawn_num
integer udg_lvl3_wave_num= 0
rect array udg_player_arena
integer udg_spawn_chance1= 0
boolean array udg_spawn_waves_complete
boolean udg_spawn_everyone_cleared= false
integer udg_temp_ability_code= 0
integer udg_spawn_waves= 0
group udg_temp_unit_group= null
real array udg_froststrike_dmg
integer array udg_chestgold_count
integer udg_spawn_chance2= 0
integer udg_spawn_chance3= 0
integer array udg_trait_picked_count
integer array udg_trait_picked_ability1
integer array udg_trait_picked_ability2
integer array udg_trait_picked_ability3
timer udg_walls_warning_timer= null
integer udg_wave_temp_num= 0
integer udg_wave_diff_lvl= 0
dialog udg_reward_dialog= null
button array udg_reward_dialog_button
trigger array udg_reward_trigger_list
trigger array udg_reward_trigger
integer array udg_reward_list_randomnum
integer udg_r_temp_num= 0
integer udg_reward_chosenbutton_num= 0
real array udg_reward_spelldmg
integer array udg_reward_upsummons
integer udg_reward_returndmg_pillar= 0
integer udg_unit_type_temp= 0
boolean array udg_reward_trigger_taken
integer array udg_reward_list_randomnum2
integer array udg_pillar_item_type
real udg_reward_lifesteal= 0
integer udg_reward_cheapitem= 0
integer udg_time_week= 0
integer udg_time_day= 0
integer array udg_boss_spells
integer udg_lose_temp_int= 0
timer udg_wavesDecay_warning_timer= null
timerdialog udg_wavesDecay_timer_window= null
weathereffect udg_weather_effect= null
boolean udg_wave_cleared= false
integer array udg_reward_learn_option_taken
integer array udg_reward_retrainnr_taken
integer udg_wave_temp_num_2= 0
real udg_reward_regen= 0
real udg_reward_manaregen_pillar= 0
effect array udg_pillar_effect
effect array udg_walls_effect
dialog udg_ending_dialog= null
button array udg_ending_dialog_button
integer udg_end_temp_int= 0
unit udg_end_boss= null
destructable udg_end_voidtear= null
integer udg_end_spell_int= 0
sound array udg_end_boss_sound
real udg_heresy_bonus= 0
integer array udg_reward_stats_perlvl
integer udg_reward_cd_ability= 0
integer udg_shop_cheapitem_type= 0
integer udg_shop_cheapitem_amount= 0
ability udg_temp_ability= null
integer udg_current_wave= 0
integer array udg_reward_chosenbutton_num_Copy
dialog array udg_reward_dialog_Copy
button array udg_reward_dialog_button_Copy
integer udg_X= 0
integer array udg_reward_expensiveitem_Copy
integer udg_reward_expensiveitem= 0
integer array udg_reward_cheapitem_Copy
integer array udg_reward_cd_ability_Copy
real array udg_reward_lifesteal_Copy
integer udg_ChoosePlayers= 0
integer array udg_ut
timer udg_picktimer= null
timerdialog udg_picktimerwindow= null
integer udg_N= 0
group udg_heropicker= null
real array udg_reward_regen_Copy
integer udg_Y= 0
integer array udg_wave_diff_lvl_Copy
string array udg_Pcolorname
hashtable udg_upgradeshop_ability= null
integer array udg_retrain_bugfix
player udg_RetrainPlayer= null
ability udg_RetrainAbility= null
real array udg_swap_temp_real1
real array udg_swap_temp_real2
real array udg_swap_temp_real3
real array udg_swap_temp_real4
integer array udg_swap_temp_ability1
integer array udg_swap_temp_ability2
real array udg_DMG
integer array udg_UpAbil
integer array udg_IntArray
integer array udg_RetrainNr
integer array udg_AbilLearned1
integer array udg_AbilLearned2
integer array udg_AbilLearned3
integer array udg_AbilLearned4
integer udg_shop_cheapitem_type_2= 0
integer udg_shop_cheapitem_type_3= 0
integer udg_shop_cheapitem_amount_2= 0
integer udg_shop_cheapitem_amount_3= 0
integer udg_prevchance= 0
force udg_Activeplayers= null
integer udg_Pint= 0
real array udg_PGold
integer udg_lost= 0
integer udg_prevchance2= 0
timer udg_GStimer= null
integer array udg_HeroXP
integer array udg_Frenzy
integer array udg_random_heroes
group udg_UG= null
location udg_TP= null
integer array udg_MSInt
integer array udg_BigUp
integer array udg_SmallUp
real udg_SpellFactor= 0
unit array udg_VolcanoDummy
timer array udg_FireTimer
timer array udg_RunedTimer
integer array udg_mana_axe_dmg
real udg_temp_real_2= 0
integer array udg_dragoon_pike_rng
boolean udg_KeyOfBalance= false
boolean array udg_ARISscepterflag
boolean array udg_ARISkeyFlag
group udg_ARISsceptercorpes= null
location udg_temp_loc= null
location udg_temp_loc_2= null
ability udg_sev_ab= null
integer udg_Draft_max1= 0
integer udg_Draft_max2= 0
integer udg_Draft_max3= 0
integer udg_Draft_max4= 0
integer udg_Draft_max5= 0
real udg_temp_real_hp= 0
unit udg_temp_unit_slash1= null
location udg_temp_loc_slash1= null
location udg_temp_loc_slash2= null
unit udg_temp_unit_slash2= null
group udg_temp_group_slash= null
integer udg_SHeroNazgrelGold= 0
integer udg_SHeroBladeClaws1= 0
integer udg_SHeroBladeClaws2= 0
group udg_temp_group_slash2= null
integer udg_SHeroArchivistGold= 0
integer udg_SHeroAncientOrbs= 0
integer udg_SHeroSantaBarrels= 0
integer udg_temp_int_slash= 0
real udg_SHeroPenPenDamage= 0
integer udg_SHeroBoneCollectorInt= 0
integer udg_SHeroStormHadronInt= 0
integer udg_SLASHJainaAbil= 0
integer udg_SHeroRylaiInt= 0
integer array udg_SHeroWardenAbs
integer udg_SHeroWardenCount= 0
integer udg_temp_int_slash2= 0
integer udg_SHeroDuckCheeses= 0
location udg_temp_loc_slash3= null
integer udg_SHeroDancerCount= 0
string array udg_SHeroDancerArr
real udg_SLASHSpellFactor= 0
real array udg_SHeroItemArP

    // Generated
rect gg_rct_Region_000= null
rect gg_rct_item_spawn= null
rect gg_rct_obelisk= null
camerasetup gg_cam_Camera_001= null
sound gg_snd_ArrangedTeamInvitation= null
sound gg_snd_BattleNetTick= null
sound gg_snd_BrewMasterDeath1= null
sound gg_snd_BuildingDeathLargeHuman= null
sound gg_snd_ClanInvitation= null
sound gg_snd_CreepAggroWhat1= null
sound gg_snd_DarkVictory= null
sound gg_snd_Feedback= null
sound gg_snd_GameFound= null
sound gg_snd_GameFound01= null
sound gg_snd_GoodJob= null
sound gg_snd_LightningBolt1= null
sound gg_snd_NewTournament= null
sound gg_snd_QuestActivateWhat1= null
sound gg_snd_QuestLog= null
sound gg_snd_QuestNew= null
sound gg_snd_ReceiveGold= null
sound gg_snd_Rescue= null
sound gg_snd_ShimmeringPortalBirth= null
sound gg_snd_ShimmeringPortalDeath= null
sound gg_snd_ShimmeringPortalEntrance= null
sound gg_snd_TuskarrDeath1= null
sound gg_snd_Warning= null
sound gg_snd_MouseClick1= null
sound gg_snd_StampedeCaster1= null
sound gg_snd_QuestCompleted= null
sound gg_snd_QuestFailed= null
sound gg_snd_Tension= null
sound gg_snd_LichKingTheme= null
sound gg_snd_One_Eternity_Later= null
sound gg_snd_ObsidianStatueYes3= null
sound gg_snd_ObsidianStatueYes2= null
sound gg_snd_ObsidianAvengerPissed1= null
sound gg_snd_ObsidianStatueMorph= null
sound gg_snd_HeroicVictory= null
sound gg_snd_PH1= null
sound gg_snd_HeroicVictory01= null
sound gg_snd_EarthquakeLoop1= null
sound gg_snd_EarthquakeRock= null
sound gg_snd_ReviveHuman= null
trigger gg_trg_SLASHOnKill= null
trigger gg_trg_SLASHOnHit= null
trigger gg_trg_SLASHOnPick= null
trigger gg_trg_SLASHOnItem= null
trigger gg_trg_SLASHOnAbility= null
trigger gg_trg_SLASHLevelUp= null
trigger gg_trg_SLASHPeriodic= null
trigger gg_trg_on_damage_items= null
trigger gg_trg_on_summon_items= null
trigger gg_trg_Reward_Life_Steal= null
trigger gg_trg_SLASHAfterDamage= null
trigger gg_trg_SLASHSanta= null
trigger gg_trg_SLASHJaina1= null
trigger gg_trg_SLASHJaina2= null
trigger gg_trg_SLASHKael= null
trigger gg_trg_SLASHLock= null
trigger gg_trg_SLASHBossZerk= null
trigger gg_trg_SLASHWaveLoot= null
trigger gg_trg_Change_Item_Description= null
trigger gg_trg_Nick_Unit_starts_effect_of_an_ability= null
trigger gg_trg_Nick_Item_Acquired= null
trigger gg_trg_Nick_Item_Lost= null
trigger gg_trg_Nick_Periodic= null
trigger gg_trg_Damage_Engine_Config= null
trigger gg_trg_Damage_Engine= null
trigger gg_trg_SpellDMG_Check= null
trigger gg_trg_Key_Of_Balance= null
trigger gg_trg_Item_Used= null
trigger gg_trg_Infinity_Tome= null
trigger gg_trg_Staff_of_Lightning= null
trigger gg_trg_clear_drops= null
trigger gg_trg_Heart_of_Aszune= null
trigger gg_trg_Helm_of_Battlethirst= null
trigger gg_trg_Bloodfeathers_Heart= null
trigger gg_trg_Storm_Hammer= null
trigger gg_trg_Crown_of_the_Manalord= null
trigger gg_trg_Wand_of_Sorcery= null
trigger gg_trg_Skeletal_Rod= null
trigger gg_trg_Energy_Staff= null
trigger gg_trg_Energy_Staff_on_dmg= null
trigger gg_trg_Lightning_Javelin= null
trigger gg_trg_Orb_of_Fire= null
trigger gg_trg_Orb_of_Fire_on_dmg= null
trigger gg_trg_Orb_of_Corruption= null
trigger gg_trg_Searing_Blade_aura_taken= null
trigger gg_trg_Searing_Blade_aura_dies= null
trigger gg_trg_Tome_of_Heresy= null
trigger gg_trg_Sundering_Blade= null
trigger gg_trg_Cloak_of_Frost= null
trigger gg_trg_Power_Staff= null
trigger gg_trg_divinity_gauntlet= null
trigger gg_trg_divinity_gauntlet_periodic= null
trigger gg_trg_divinity_gauntlet_on_dmg= null
trigger gg_trg_Angry_Totem= null
trigger gg_trg_angry_totem_timer= null
trigger gg_trg_demonic_blade_init= null
trigger gg_trg_demonic_blade= null
trigger gg_trg_Mask_of_Death= null
trigger gg_trg_Claws_of_Frenzy= null
trigger gg_trg_Engulfing_Blade= null
trigger gg_trg_leave= null
trigger gg_trg_weather1= null
trigger gg_trg_weather2= null
trigger gg_trg_weather3= null
trigger gg_trg_weather4= null
trigger gg_trg_weather5= null
trigger gg_trg_weather6= null
trigger gg_trg_weather7= null
trigger gg_trg_weather8= null
trigger gg_trg_lose_condition= null
trigger gg_trg_Walls= null
trigger gg_trg_obelisk_takes_dmg= null
trigger gg_trg_obelisk_prevent_focus= null
trigger gg_trg_sound_deaths= null
trigger gg_trg_fel_spawns= null
trigger gg_trg_doodads= null
trigger gg_trg_doodads_die= null
trigger gg_trg_trigger_tk_prevent= null
trigger gg_trg_permanent_immo_bug_fix= null
trigger gg_trg_perm_immo_ability_effect= null
trigger gg_trg_illusion_stat_fix= null
trigger gg_trg_bonus_leveling_hero= null
trigger gg_trg_Tips= null
trigger gg_trg_Repair_Pillar_Item= null
trigger gg_trg_Item_Reroll= null
trigger gg_trg_set_random_heroes= null
trigger gg_trg_start= null
trigger gg_trg_Nick_Monitor_Heroes= null
trigger gg_trg_endpick= null
trigger gg_trg_afterpick= null
trigger gg_trg_wavesStart= null
trigger gg_trg_waves= null
trigger gg_trg_wave_units_spawn= null
trigger gg_trg_wave_clear= null
trigger gg_trg_wavesDecaywarningtimer= null
trigger gg_trg_wavesDecaytimer= null
trigger gg_trg_wavesDecay= null
trigger gg_trg_boss_spell_init= null
trigger gg_trg_boss_spell= null
trigger gg_trg_Creeps_Enter_Map= null
trigger gg_trg_Creeps_Get_Attacked= null
trigger gg_trg_Stronger_Creep_Abilities= null
trigger gg_trg_Order_Creeps_Obelisk= null
trigger gg_trg_Skip_command= null
trigger gg_trg_Hero_Info_command= null
trigger gg_trg_Continue_Command= null
trigger gg_trg_Kick_command= null
trigger gg_trg_clear_Command= null
trigger gg_trg_enum= null
trigger gg_trg_Swap_Commannd= null
trigger gg_trg_Floating_Text_dmg= null
trigger gg_trg_Floating_Text_periodic= null
trigger gg_trg_Set_Hotkey_Abilities= null
trigger gg_trg_Set_Hotkeys= null
trigger gg_trg_Hero_buys_Ability= null
trigger gg_trg_Hero_buys_Random_Ability= null
trigger gg_trg_Set_Abilities_and_Items= null
trigger gg_trg_Tome_of_Retraining= null
trigger gg_trg_Remove_Tomes= null
trigger gg_trg_Preload_Abilities= null
trigger gg_trg_Channeling_Spells_Cast= null
trigger gg_trg_Channeling_Spells_finish= null
trigger gg_trg_Move_Projectiles= null
trigger gg_trg_Return_Damage_Pillar= null
trigger gg_trg_frost_strike_init= null
trigger gg_trg_frost_strike= null
trigger gg_trg_frost_strike_dmg= null
trigger gg_trg_DraftStart= null
trigger gg_trg_Item_Stack= null
trigger gg_trg_InitMB= null
trigger gg_trg_Reward_Init= null
trigger gg_trg_Reward_Round= null
trigger gg_trg_Reward_Chosen= null
trigger gg_trg_RewardReroll= null
trigger gg_trg_Attribute_Rewards= null
trigger gg_trg_Base_Damage_Bonus= null
trigger gg_trg_Armor_Bonus= null
trigger gg_trg_Lifesteal_Bonus= null
trigger gg_trg_Attack_Cooldown_Reduction= null
trigger gg_trg_Spend_All_gold_for_reward= null
trigger gg_trg_Sacrifice_stats_for_reward= null
trigger gg_trg_Expensive_Item= null
trigger gg_trg_Cheap_Item= null
trigger gg_trg_Summon_Units= null
trigger gg_trg_Upgrade_Pillar= null
trigger gg_trg_Movement_Speed_Bonus= null
trigger gg_trg_Reduce_Difficulty_Level= null
trigger gg_trg_Gain_stats_per_level= null
trigger gg_trg_Gain_Spell_Damage= null
trigger gg_trg_Upgrade_Summons= null
trigger gg_trg_Learn_Ability= null
trigger gg_trg_Upgrade_Ability= null
trigger gg_trg_Reduce_CD_Ability= null
trigger gg_trg_goldshare= null
trigger gg_trg_Item_bought_from_obelisk= null
trigger gg_trg_Item_Sold= null
trigger gg_trg_SetGoldValue= null
trigger gg_trg_Ending_start= null
trigger gg_trg_Ending_button_clicked= null
trigger gg_trg_Ending_2_start= null
trigger gg_trg_Ending_pillar_channel= null
trigger gg_trg_end_boss_spell= null
trigger gg_trg_end_boss_takes_dmg= null
trigger gg_trg_void_trap_effect= null
trigger gg_trg_end_boss_deals_dammage= null
trigger gg_trg_end_boss_dies= null
trigger gg_trg_end_lose_condition= null
unit gg_unit_n02S_0002= null
string array SHero
framehandle array UName
framehandle array UIcon
framehandle array TIcon
framehandle array FIcon
framehandle array TTIcon
framehandle array TLiveT
framehandle array TLiveI
framehandle array USkill
framehandle array UTrait
framehandle array TDamT
string array SSkill
string array STrait
framehandle array TSkill
framehandle array TTrait
framehandle array FSkill
framehandle array FTrait
framehandle array TTSkill
framehandle array TTTrait
framehandle PF
framehandle UIB
framehandle UIB2
framehandle array FTeam
boolean UIOn
trigger TrigUI
real BX= .606
real BY= .486

trigger l__library_init

//JASSHelper struct globals:
trigger array st___prototype6
trigger f__arg_trigger1
string f__arg_string1
limitop f__arg_limitop1
real f__arg_real1

endglobals

function sc___prototype6_execute takes integer i,trigger a1,string a2,limitop a3,real a4 returns nothing
    set f__arg_trigger1=a1
    set f__arg_string1=a2
    set f__arg_limitop1=a3
    set f__arg_real1=a4

    call TriggerExecute(st___prototype6[i])
endfunction
function sc___prototype6_evaluate takes integer i,trigger a1,string a2,limitop a3,real a4 returns nothing
    set f__arg_trigger1=a1
    set f__arg_string1=a2
    set f__arg_limitop1=a3
    set f__arg_real1=a4

    call TriggerEvaluate(st___prototype6[i])

endfunction
function h__TriggerRegisterVariableEvent takes trigger a0, string a1, limitop a2, real a3 returns event
    //hook: DamageEngine___PreSetup
    call sc___prototype6_evaluate(1,a0,a1,a2,a3)
return TriggerRegisterVariableEvent(a0,a1,a2,a3)
endfunction

//library DamageEngine:
    
    
//GUI Vars:

    
    function DamageEngine___RunTrigs takes integer i returns nothing
        local integer cat= i
        //if dreaming then
        //    call BJDebugMsg("Tried to run triggers while triggers were already running.")
        //    return
        //endif
        set DamageEngine___dreaming=true
        //call BJDebugMsg("Start of event running")
        loop
            set i=DamageEngine___nextTrig[i]
            exitwhen i == 0
            exitwhen cat == DamageEngine___MOD_EVENT and ( udg_DamageEventOverride or udg_DamageEventType * udg_DamageEventType == 4 )
            exitwhen cat == DamageEngine___SHIELD_EVENT and udg_DamageEventAmount <= 0.00
            exitwhen cat == DamageEngine___LETHAL_EVENT and udg_LethalDamageHP > 0.405
            //set crashStr = "Bout to inspect " + I2S(i)
            if not DamageEngine___trigFrozen[i] and IsTriggerEnabled(DamageEngine___userTrig[i]) then
                set DamageEngine___eventTrig=i
                //set crashStr = "Bout to evaluate " + I2S(i)
                if TriggerEvaluate(DamageEngine___userTrig[i]) then
                    //set crashStr = "Bout to execute " + I2S(i)
                    call TriggerExecute(DamageEngine___userTrig[i])
                endif
                //set crashStr = "Ran " + I2S(i)
                //call BJDebugMsg("Ran " + I2S(i))
                //if not (udg_DamageEventPrevAmt == 0.00 or udg_DamageScalingWC3 == 0.00 or udg_DamageEventAmount == 0.00) then
                //    if cat == MOD_EVENT then
                //        set udg_DamageScalingUser = udg_DamageEventAmount/udg_DamageEventPrevAmt
                //    elseif cat == SHIELD_EVENT then
                //        set udg_DamageScalingUser = udg_DamageEventAmount/udg_DamageEventPrevAmt/udg_DamageScalingWC3
                //    endif
                //elseif udg_DamageEventPrevAmt == 0.00 then
                //    call BJDebugMsg("Prev amount 0.00 and User Amount " + R2S(udg_DamageEventAmount))
                //elseif udg_DamageEventAmount == 0.00 then
                //    call BJDebugMsg("User amount 0.00 and Prev Amount " + R2S(udg_DamageEventPrevAmt))
                //elseif udg_DamageScalingWC3 == 0.00 then
                //    call BJDebugMsg("WC3 amount somehow 0.00")
                //endif
                //set crashStr = "Filtered " + I2S(i)
            //elseif i > 9 then
            //    if trigFrozen[i] then
            //        call BJDebugMsg("User Trigger is frozen")
            //    else
            //        call BJDebugMsg("User Trigger is off")
            //    endif
            endif
        endloop
        //call BJDebugMsg("End of event running")
        set DamageEngine___dreaming=false
    endfunction
    
    function DamageEngine___OnAOEEnd takes nothing returns nothing
        if udg_DamageEventAOE > 1 then
            call DamageEngine___RunTrigs(DamageEngine___AOE_EVENT)
            set udg_DamageEventAOE=1
        endif
        set udg_DamageEventLevel=1
        set udg_EnhancedDamageTarget=null
        set udg_AOEDamageSource=null
        call GroupClear(udg_DamageEventAOEGroup)
    endfunction
    
    function DamageEngine___AfterDamage takes nothing returns nothing
        if udg_DamageEventPrevAmt != 0.00 and udg_DamageEventDamageT != udg_DAMAGE_TYPE_UNKNOWN then
            call DamageEngine___RunTrigs(DamageEngine___AFTER_EVENT)
        endif
    endfunction
    
    function DamageEngine___Finish takes nothing returns nothing
        local integer i= 0
        local integer exit
        if DamageEngine___eventsRun then
            //call BJDebugMsg("events ran")
            set DamageEngine___eventsRun=false
            call DamageEngine___AfterDamage()
        endif
        if DamageEngine___canKick and not DamageEngine___kicking then
            //call BJDebugMsg("can kick")
            if DamageEngine___damageStack > 0 then
                set DamageEngine___kicking=true
                //call BJDebugMsg("Clearing queued damage instances: " + I2S(damageStack))
                loop
                    set exit=DamageEngine___damageStack
                    set DamageEngine___sleepLevel=DamageEngine___sleepLevel + 1
                    loop
                        set udg_NextDamageType=DamageEngine___typeStack[i]
                        //call BJDebugMsg("Stacking on " + R2S(amountStack[i]))
                        call UnitDamageTarget(DamageEngine___sourceStack[i], DamageEngine___targetStack[i], DamageEngine___amountStack[i], true, false, DamageEngine___attackTStack[i], DamageEngine___damageTStack[i], DamageEngine___weaponTStack[i])
                        call DamageEngine___AfterDamage()
                        set i=i + 1 //Need to loop bottom to top to make sure damage order is preserved.
                        exitwhen i == exit
                    endloop
                    //call BJDebugMsg("Exit at: " + I2S(i))
                    exitwhen i == DamageEngine___damageStack
                endloop
                //call BJDebugMsg("Terminate at at: " + I2S(i))
                set DamageEngine___sleepLevel=0
                loop
                    set i=i - 1
                    set DamageEngine___trigFrozen[DamageEngine___userTrigStack[i]]=false //Only re-enable recursive triggers AFTER all damage is dealt.
                    set DamageEngine___levelsDeep[DamageEngine___userTrigStack[i]]=0 //Reset this stuff if the user tried some nonsense
                    exitwhen i == 0
                endloop
                //call BJDebugMsg("Cleared queued damage instances: " + I2S(damageStack))
                set DamageEngine___damageStack=0 //Can only be set after all the damage has successfully ended.
                set DamageEngine___kicking=false
            endif
            call GroupClear(DamageEngine___proclusGlobal)
            call GroupClear(DamageEngine___fischerMorrow)
        //elseif kicking then
        //    call BJDebugMsg("Somehow still kicking")
        //else
        //    call BJDebugMsg("Cannot kick")
        endif
    endfunction
    
    function DamageEngine___ResetArmor takes nothing returns nothing
        if udg_DamageEventArmorPierced != 0.00 then
            call BlzSetUnitArmor(udg_DamageEventTarget, BlzGetUnitArmor(udg_DamageEventTarget) + udg_DamageEventArmorPierced)
        endif
        if DamageEngine___armorType != udg_DamageEventArmorT then
            call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, DamageEngine___armorType) //revert changes made to the damage instance
        endif
        if DamageEngine___defenseType != udg_DamageEventDefenseT then
            call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, DamageEngine___defenseType)
        endif
    endfunction
    
    function DamageEngine___FailsafeClear takes nothing returns nothing
        //call BJDebugMsg("Damage from " + GetUnitName(udg_DamageEventSource) + " to " + GetUnitName(udg_DamageEventTarget) + " has been messing up Damage Engine.")
        //call BJDebugMsg(R2S(udg_DamageEventAmount) + " " + " " + R2S(udg_DamageEventPrevAmt) + " " + udg_AttackTypeDebugStr[udg_DamageEventAttackT] + " " + udg_DamageTypeDebugStr[udg_DamageEventDamageT])
        call DamageEngine___ResetArmor()
        set DamageEngine___canKick=true
        set DamageEngine___totem=false
        set udg_DamageEventAmount=0.00
        set udg_DamageScalingWC3=0.00
        if udg_DamageEventDamageT != udg_DAMAGE_TYPE_UNKNOWN then
            call DamageEngine___RunTrigs(DamageEngine___DAMAGE_EVENT) //Run the normal on-damage event based on this failure.
            set DamageEngine___eventsRun=true //Run the normal after-damage event based on this failure.
        endif
        call DamageEngine___Finish()
    endfunction
    
    function DamageEngine___WakeUp takes nothing returns nothing
        set DamageEngine___alarmSet=false //The timer has expired. Flag off to allow it to be restarted when needed.
        //if dreaming then
        //    set dreaming= false
        //    call BJDebugMsg("Timer set dreaming to False")
        //    call BJDebugMsg(crashStr)
        //endif
        if DamageEngine___totem then
            //Something went wrong somewhere; the WarCraft 3 engine didn't run the DAMAGED event despite running the DAMAGING event.
            call DamageEngine___FailsafeClear()
        else
            if not DamageEngine___canKick and DamageEngine___damageStack > 0 then
                //call BJDebugMsg("Damage Engine recursion deployment was failing with application of: " + R2S(udg_DamageEventAmount))
                set DamageEngine___canKick=true
            endif
            call DamageEngine___Finish() //Wrap up any outstanding damage instance
        endif
        call DamageEngine___OnAOEEnd() //Reset things so they don't perpetuate for AoE/Level target detection
        set udg_DamageEventPrevAmt=0.00 //Added in 5.4.2.1 to try to squash the Cold Arrows glitch (failed to do it)
    endfunction
    
    function DamageEngine___CalibrateMR takes nothing returns nothing
        set udg_IsDamageMelee=false
        set udg_IsDamageRanged=false
        set udg_IsDamageSpell=udg_DamageEventAttackT == 0 //In Patch 1.31, one can just check the attack type to find out if it's a spell.
        if udg_DamageEventDamageT == udg_DAMAGE_TYPE_NORMAL and not udg_IsDamageSpell then //This damage type is the only one that can get reduced by armor.
            set udg_IsDamageMelee=IsUnitType(udg_DamageEventSource, UNIT_TYPE_MELEE_ATTACKER)
            set udg_IsDamageRanged=IsUnitType(udg_DamageEventSource, UNIT_TYPE_RANGED_ATTACKER)
            if udg_IsDamageMelee and udg_IsDamageRanged then
                set udg_IsDamageMelee=udg_DamageEventWeaponT > 0 // Melee units play a sound when damaging
                set udg_IsDamageRanged=not udg_IsDamageMelee // In the case where a unit is both ranged and melee, the ranged attack plays no sound.
            endif // The Huntress has a melee sound for her ranged projectile, however it is only an issue
        endif //if she also had a melee attack, because by default she is only UNIT_TYPE_RANGED_ATTACKER.
    endfunction
    
    function DamageEngine___OnPreDamage takes nothing returns boolean
        local unit src= GetEventDamageSource()
        local unit tgt= GetTriggerUnit()
        local real amt= GetEventDamage()
        local attacktype at= BlzGetEventAttackType()
        local damagetype dt= BlzGetEventDamageType()
        local weapontype wt= BlzGetEventWeaponType()
        
        //call BJDebugMsg("First damage event running")
        
        if DamageEngine___dreaming then
            //call BJDebugMsg("Dreaming")
            if amt != 0.00 then
                //Store recursive damage into a queue from index "damageStack" (0-15)
                //This damage will be fired after the current damage instance has wrapped up its events.
                //This damage can only be caused by triggers.
                set DamageEngine___amountStack[DamageEngine___damageStack]=amt
                set DamageEngine___sourceStack[DamageEngine___damageStack]=src
                set DamageEngine___targetStack[DamageEngine___damageStack]=tgt
                set DamageEngine___attackTStack[DamageEngine___damageStack]=at
                set DamageEngine___damageTStack[DamageEngine___damageStack]=dt
                set DamageEngine___weaponTStack[DamageEngine___damageStack]=wt
                set DamageEngine___userTrigStack[DamageEngine___damageStack]=DamageEngine___eventTrig
                if udg_NextDamageType == 0 then
                    set DamageEngine___typeStack[DamageEngine___damageStack]=udg_DamageTypeCode
                else
                    set DamageEngine___typeStack[DamageEngine___damageStack]=udg_NextDamageType
                endif
                //Next block added in 5.4.1 to allow *some* control over whether recursion should kick
                //in. Also it's important to track whether the source and target were both involved at
                //some earlier point, so this is a more accurate and lenient method than before.
                set DamageEngine_inception=DamageEngine_inception or DamageEngine___inceptionTrig[DamageEngine___eventTrig]
                call GroupAddUnit(DamageEngine___proclusGlobal, udg_DamageEventSource)
                call GroupAddUnit(DamageEngine___fischerMorrow, udg_DamageEventTarget)
                if DamageEngine___kicking and IsUnitInGroup(src, DamageEngine___proclusGlobal) and IsUnitInGroup(tgt, DamageEngine___fischerMorrow) then
                    if DamageEngine_inception and not DamageEngine___trigFrozen[DamageEngine___eventTrig] then
                        set DamageEngine___inceptionTrig[DamageEngine___eventTrig]=true
                        if DamageEngine___levelsDeep[DamageEngine___eventTrig] < DamageEngine___sleepLevel then
                            set DamageEngine___levelsDeep[DamageEngine___eventTrig]=DamageEngine___levelsDeep[DamageEngine___eventTrig] + 1
                            if DamageEngine___levelsDeep[DamageEngine___eventTrig] >= DamageEngine___LIMBO then
                                set DamageEngine___trigFrozen[DamageEngine___eventTrig]=true
                            endif
                        endif
                    else
                        set DamageEngine___trigFrozen[DamageEngine___eventTrig]=true
                    endif
                endif
                set DamageEngine___damageStack=DamageEngine___damageStack + 1
                //call BJDebugMsg("damageStack: " + I2S(damageStack) + " levelsDeep: " + I2S(levelsDeep[eventTrig]) + " sleepLevel: " + I2S(sleepLevel))
                call BlzSetEventDamage(0.00) //queue the damage instance instead of letting it run recursively
            endif
        else
            if not DamageEngine___kicking then
                //Added 25 July 2017 to detect AOE damage or multiple single-target damage
                if DamageEngine___alarmSet then
                    if DamageEngine___totem then
                        if dt != DAMAGE_TYPE_SPIRIT_LINK and dt != DAMAGE_TYPE_DEFENSIVE and dt != DAMAGE_TYPE_PLANT then
                            //if 'totem' is still set and it's not due to spirit link distribution or defense retaliation,
                            //the next function must be called as a debug. This reverts an issue I created in patch 5.1.3.
                            call DamageEngine___FailsafeClear()
                        else
                            set DamageEngine___totem=false
                            set DamageEngine___lastAmount=udg_DamageEventAmount
                            set DamageEngine___lastPrevAmt=udg_DamageEventPrevAmt //Store the actual pre-armor value.
                            set DamageEngine___lastType=udg_DamageEventType //also store the damage type.
                            set DamageEngine___lastCode=udg_IsDamageCode //store this as well.
                            set DamageEngine___lastArmor=udg_DamageEventArmorT
                            set DamageEngine___lastPrevArmor=DamageEngine___armorType
                            set DamageEngine___lastDefense=udg_DamageEventDefenseT
                            set DamageEngine___lastPrevDefense=DamageEngine___defenseType
                            set DamageEngine___lastPierced=udg_DamageEventArmorPierced
                            set DamageEngine___canKick=false
                        endif
                    else
                        call DamageEngine___Finish()
                    endif
                    if src != udg_AOEDamageSource then //Source has damaged more than once
                        call DamageEngine___OnAOEEnd() //New damage source - unflag everything
                        set udg_AOEDamageSource=src
                    elseif tgt == udg_EnhancedDamageTarget then
                        set udg_DamageEventLevel=udg_DamageEventLevel + 1 //The number of times the same unit was hit.
                    elseif not IsUnitInGroup(tgt, udg_DamageEventAOEGroup) then
                        set udg_DamageEventAOE=udg_DamageEventAOE + 1 //Multiple targets hit by this source - flag as AOE
                    endif
                else
                    call TimerStart(DamageEngine___alarm, 0.00, false, function DamageEngine___WakeUp)
                    set DamageEngine___alarmSet=true
                    set udg_AOEDamageSource=src
                    set udg_EnhancedDamageTarget=tgt
                endif
                call GroupAddUnit(udg_DamageEventAOEGroup, tgt)
            endif
            set udg_DamageEventType=udg_NextDamageType
            if udg_NextDamageType != 0 then
                set udg_DamageEventType=udg_NextDamageType
                set udg_IsDamageCode=true //New in 5.1 - requested by chopinski to allow user to detect Code damage
            endif
            set udg_DamageEventOverride=dt == null //Got rid of NextDamageOverride in 5.1 for simplicity
            set udg_DamageEventPrevAmt=amt
            set udg_DamageEventSource=src
            set udg_DamageEventTarget=tgt
            set udg_DamageEventAmount=amt
            set udg_DamageEventAttackT=GetHandleId(at)
            set udg_DamageEventDamageT=GetHandleId(dt)
            set udg_DamageEventWeaponT=GetHandleId(wt)
            
            call DamageEngine___CalibrateMR() //Set Melee and Ranged settings.
            
            set udg_DamageEventArmorT=BlzGetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE) //Introduced in Damage Engine 5.2.0.0
            set udg_DamageEventDefenseT=BlzGetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE)
            set DamageEngine___armorType=udg_DamageEventArmorT
            set DamageEngine___defenseType=udg_DamageEventDefenseT
            set udg_DamageEventArmorPierced=0.00
            set udg_DamageScalingUser=1.00
            set udg_DamageScalingWC3=1.00
            
            if amt != 0.00 then
                if not udg_DamageEventOverride then
                    call DamageEngine___RunTrigs(DamageEngine___MOD_EVENT)
               
                    //All events have run and the pre-damage amount is finalized.
                    call BlzSetEventAttackType(ConvertAttackType(udg_DamageEventAttackT))
                    call BlzSetEventDamageType(ConvertDamageType(udg_DamageEventDamageT))
                    call BlzSetEventWeaponType(ConvertWeaponType(udg_DamageEventWeaponT))
                    if udg_DamageEventArmorPierced != 0.00 then
                        call BlzSetUnitArmor(udg_DamageEventTarget, BlzGetUnitArmor(udg_DamageEventTarget) - udg_DamageEventArmorPierced)
                    endif
                    if DamageEngine___armorType != udg_DamageEventArmorT then
                        call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, udg_DamageEventArmorT) //Introduced in Damage Engine 5.2.0.0
                    endif
                    if DamageEngine___defenseType != udg_DamageEventDefenseT then
                        call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, udg_DamageEventDefenseT) //Introduced in Damage Engine 5.2.0.0
                    endif
                    call BlzSetEventDamage(udg_DamageEventAmount)
                endif
                //call BJDebugMsg("Ready to deal " + R2S(udg_DamageEventAmount))
                set DamageEngine___totem=true
            else
                call DamageEngine___RunTrigs(DamageEngine___ZERO_EVENT)
                set DamageEngine___canKick=true
                call DamageEngine___Finish()
            endif
        endif
        set src=null
        set tgt=null
        set DamageEngine_inception=false
        set udg_NextDamageType=0
        return false
    endfunction
    
    //The traditional on-damage response, where armor reduction has already been factored in.
    function DamageEngine___OnDamage takes nothing returns boolean
 local integer ii
 local integer ii2
 local integer len
        local real r= GetEventDamage()
 local real tr
 local string s
 local string s2= ""
        //call BJDebugMsg("Second damage event running")
        if DamageEngine___dreaming or udg_DamageEventPrevAmt == 0.00 then
            //if dreaming then
            //    call BJDebugMsg("Dreaming")
            //else
            //    call BJDebugMsg("Prev amount is zero")
            //endif
            return false
        endif
        if DamageEngine___totem then
            set DamageEngine___totem=false //This should be the case in almost all circumstances
        else
            call DamageEngine___AfterDamage() //Wrap up the outstanding damage instance
            set DamageEngine___canKick=true
            //Unfortunately, Spirit Link and Thorns Aura/Spiked Carapace fire the DAMAGED event out of sequence with the DAMAGING event,
            //so I have to re-generate a buncha stuff here.
            set udg_DamageEventSource=GetEventDamageSource()
            set udg_DamageEventTarget=GetTriggerUnit()
            set udg_DamageEventAmount=DamageEngine___lastAmount
            set udg_DamageEventPrevAmt=DamageEngine___lastPrevAmt
            set udg_DamageEventAttackT=GetHandleId(BlzGetEventAttackType())
            set udg_DamageEventDamageT=GetHandleId(BlzGetEventDamageType())
            set udg_DamageEventWeaponT=GetHandleId(BlzGetEventWeaponType())
            set udg_DamageEventType=DamageEngine___lastType
            set udg_IsDamageCode=DamageEngine___lastCode
            set udg_DamageEventArmorT=DamageEngine___lastArmor
            set udg_DamageEventDefenseT=DamageEngine___lastDefense
            set udg_DamageEventArmorPierced=DamageEngine___lastPierced
            set DamageEngine___armorType=DamageEngine___lastPrevArmor
            set DamageEngine___defenseType=DamageEngine___lastPrevDefense
            call DamageEngine___CalibrateMR() //Apply melee/ranged settings once again.
        endif
        call DamageEngine___ResetArmor()
        if udg_DamageEventAmount != 0.00 and r != 0.00 then
            set udg_DamageScalingWC3=r / udg_DamageEventAmount
        elseif udg_DamageEventAmount > 0.00 then
            set udg_DamageScalingWC3=0.00
        else
            set udg_DamageScalingWC3=1.00
            set udg_DamageScalingUser=udg_DamageEventAmount / udg_DamageEventPrevAmt
        endif
        set udg_DamageEventAmount=udg_DamageEventAmount * udg_DamageScalingWC3
        
        if udg_DamageEventAmount > 0.00 then
            //This event is used for custom shields which have a limited hit point value
            //The shield here kicks in after armor, so it acts like extra hit points.
            call DamageEngine___RunTrigs(DamageEngine___SHIELD_EVENT)

            set udg_LethalDamageHP=GetWidgetLife(udg_DamageEventTarget) - udg_DamageEventAmount
            if udg_LethalDamageHP <= 0.405 then
                call DamageEngine___RunTrigs(DamageEngine___LETHAL_EVENT) //Added 10 May 2019 to detect and potentially prevent lethal damage. Instead of
                //modifying the damage, you need to modify LethalDamageHP instead (the final HP of the unit).
                
                set udg_DamageEventAmount=GetWidgetLife(udg_DamageEventTarget) - udg_LethalDamageHP
                if udg_DamageEventType < 0 and udg_LethalDamageHP <= 0.405 then
                    call SetUnitExploded(udg_DamageEventTarget, true) //Explosive damage types should blow up the target.
                endif
            endif
            set udg_DamageScalingUser=udg_DamageEventAmount / udg_DamageEventPrevAmt / udg_DamageScalingWC3
        endif

		if not IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) and GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER then
			if GetWidgetLife(udg_DamageEventTarget) < udg_DamageEventAmount then
				set tr=GetWidgetLife(udg_DamageEventTarget)
			else
				set tr=udg_DamageEventAmount
			endif
			set ii=GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))
			set udg_DMG[ii]=udg_DMG[ii] + R2I(tr)


	if udg_current_wave > 99 then
			call BlzFrameSetText(TDamT[ii], I2S(R2I(udg_DMG[ii]) / 1000000) + "m")

	elseif udg_current_wave > 25 then
			call BlzFrameSetText(TDamT[ii], I2S(R2I(udg_DMG[ii] / 1000)) + "k")

	else
			call BlzFrameSetText(TDamT[ii], I2S(R2I(udg_DMG[ii])))

	endif

		endif

        call BlzSetEventDamage(udg_DamageEventAmount) //Apply the final damage amount.
        if udg_DamageEventDamageT != udg_DAMAGE_TYPE_UNKNOWN then
            call DamageEngine___RunTrigs(DamageEngine___DAMAGE_EVENT)
        endif
        set DamageEngine___eventsRun=true
        if udg_DamageEventAmount == 0.00 then
            call DamageEngine___Finish()
        endif
        return false
    endfunction
    
    //===========================================================================
    function DamageEngine___Init takes nothing returns nothing
        local trigger trig= CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGED) //Thanks to this I no longer have to create an event for every unit in the map.
        call TriggerAddCondition(trig, Filter(function DamageEngine___OnDamage))

        set trig=CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DAMAGING) //The new 1.31 event which fires before damage.
        call TriggerAddCondition(trig, Filter(function DamageEngine___OnPreDamage))
        set trig=null
    endfunction
    
    function DamageEngine_DebugStr takes nothing returns nothing
        local integer i= 0
        loop
            set udg_CONVERTED_ATTACK_TYPE[i]=ConvertAttackType(i)
            exitwhen i == 6
            set i=i + 1
        endloop
        set i=0
        loop
            set udg_CONVERTED_DAMAGE_TYPE[i]=ConvertDamageType(i)
            exitwhen i == 26
            set i=i + 1
        endloop
        set udg_AttackTypeDebugStr[0]="SPELLS" //ATTACK_TYPE_NORMAL in JASS
        set udg_AttackTypeDebugStr[1]="NORMAL" //ATTACK_TYPE_MELEE in JASS
        set udg_AttackTypeDebugStr[2]="PIERCE"
        set udg_AttackTypeDebugStr[3]="SIEGE"
        set udg_AttackTypeDebugStr[4]="MAGIC"
        set udg_AttackTypeDebugStr[5]="CHAOS"
        set udg_AttackTypeDebugStr[6]="HERO"
        
        set udg_DamageTypeDebugStr[0]="UNKNOWN"
        set udg_DamageTypeDebugStr[4]="NORMAL"
        set udg_DamageTypeDebugStr[5]="ENHANCED"
        set udg_DamageTypeDebugStr[8]="FIRE"
        set udg_DamageTypeDebugStr[9]="COLD"
        set udg_DamageTypeDebugStr[10]="LIGHTNING"
        set udg_DamageTypeDebugStr[11]="POISON"
        set udg_DamageTypeDebugStr[12]="DISEASE"
        set udg_DamageTypeDebugStr[13]="DIVINE"
        set udg_DamageTypeDebugStr[14]="MAGIC"
        set udg_DamageTypeDebugStr[15]="SONIC"
        set udg_DamageTypeDebugStr[16]="ACID"
        set udg_DamageTypeDebugStr[17]="FORCE"
        set udg_DamageTypeDebugStr[18]="DEATH"
        set udg_DamageTypeDebugStr[19]="MIND"
        set udg_DamageTypeDebugStr[20]="PLANT"
        set udg_DamageTypeDebugStr[21]="DEFENSIVE"
        set udg_DamageTypeDebugStr[22]="DEMOLITION"
        set udg_DamageTypeDebugStr[23]="SLOW_POISON"
        set udg_DamageTypeDebugStr[24]="SPIRIT_LINK"
        set udg_DamageTypeDebugStr[25]="SHADOW_STRIKE"
        set udg_DamageTypeDebugStr[26]="UNIVERSAL"

        set udg_WeaponTypeDebugStr[0]="NONE" //WEAPON_TYPE_WHOKNOWS in JASS
        set udg_WeaponTypeDebugStr[1]="METAL_LIGHT_CHOP"
        set udg_WeaponTypeDebugStr[2]="METAL_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[3]="METAL_HEAVY_CHOP"
        set udg_WeaponTypeDebugStr[4]="METAL_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[5]="METAL_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[6]="METAL_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[7]="METAL_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[8]="METAL_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[9]="METAL_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[10]="METAL_HEAVY_STAB"
        set udg_WeaponTypeDebugStr[11]="WOOD_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[12]="WOOD_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[13]="WOOD_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[14]="WOOD_LIGHT_BASH"
        set udg_WeaponTypeDebugStr[15]="WOOD_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[16]="WOOD_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[17]="WOOD_LIGHT_STAB"
        set udg_WeaponTypeDebugStr[18]="WOOD_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[19]="CLAW_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[20]="CLAW_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[21]="CLAW_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[22]="AXE_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[23]="ROCK_HEAVY_BASH"

        set udg_DefenseTypeDebugStr[0]="LIGHT"
        set udg_DefenseTypeDebugStr[1]="MEDIUM"
        set udg_DefenseTypeDebugStr[2]="HEAVY"
        set udg_DefenseTypeDebugStr[3]="FORTIFIED"
        set udg_DefenseTypeDebugStr[4]="NORMAL" //Typically deals flat damage to all armor types
        set udg_DefenseTypeDebugStr[5]="HERO"
        set udg_DefenseTypeDebugStr[6]="DIVINE"
        set udg_DefenseTypeDebugStr[7]="UNARMORED"
        
        set udg_ArmorTypeDebugStr[0]="NONE" //ARMOR_TYPE_WHOKNOWS in JASS, added in 1.31
        set udg_ArmorTypeDebugStr[1]="FLESH"
        set udg_ArmorTypeDebugStr[2]="METAL"
        set udg_ArmorTypeDebugStr[3]="WOOD"
        set udg_ArmorTypeDebugStr[4]="ETHEREAL"
        set udg_ArmorTypeDebugStr[5]="STONE"
    endfunction
    
    //This function exists mainly to make it easier to switch from another DDS, like PDD.
    function UnitDamageTargetEx takes unit src,unit tgt,real amt,boolean a,boolean r,attacktype at,damagetype dt,weapontype wt returns boolean
        if udg_NextDamageType == 0 then
           set udg_NextDamageType=udg_DamageTypeCode
        endif
        call UnitDamageTarget(src, tgt, amt, a, r, at, dt, wt)
        return DamageEngine___dreaming
    endfunction
    
    function DamageEngine_SetupEvent takes trigger whichTrig,string var,integer index returns nothing
        local integer max= 1
        local integer off= 0
        local integer exit= 0
        local integer i
        if var == "udg_DamageModifierEvent" then //MOD_EVENT 1-4 -> Events 1-4
            if index < 3 then
                set exit=index + 1
            endif
            if DamageEngine___nextTrig[1] == 0 then
                set DamageEngine___nextTrig[1]=2
                set DamageEngine___nextTrig[2]=3
                set DamageEngine___trigFrozen[2]=true
                set DamageEngine___trigFrozen[3]=true
            endif
            set max=4
        elseif var == "udg_DamageEvent" then //DAMAGE_EVENT 1,2 -> Events 5,6
            set max=2
            set off=4
        elseif var == "udg_AfterDamageEvent" then //AFTER_EVENT -> Event 7
            set off=6
        elseif var == "udg_LethalDamageEvent" then //LETHAL_EVENT -> Event 8
            set off=7
        elseif var == "udg_AOEDamageEvent" then //AOE_EVENT -> Event 9
            set off=8
        else
            return
        endif
        set i=IMaxBJ(IMinBJ(index, max), 1) + off
        //call BJDebugMsg("Root index: " + I2S(i))
        loop
            set index=i
            set i=DamageEngine___nextTrig[i]
            exitwhen i == exit
        endloop
        set DamageEngine___userTrigs=DamageEngine___userTrigs + 1 //User list runs from index 10 and up
        set DamageEngine___nextTrig[index]=DamageEngine___userTrigs
        set DamageEngine___nextTrig[DamageEngine___userTrigs]=exit
        set DamageEngine___userTrig[DamageEngine___userTrigs]=whichTrig
        //call BJDebugMsg("Registered " + I2S(userTrigs) + " to " + I2S(index))
    endfunction
    
    function DamageEngine___PreSetup takes trigger whichTrig,string var,limitop op,real value returns nothing
        call DamageEngine_SetupEvent(whichTrig , var , R2I(value))
    endfunction
    
//processed hook:     hook TriggerRegisterVariableEvent DamageEngine___PreSetup
    

//library DamageEngine ends
//===========================================================================
// 
// |cff00ffffTest of Balance SLASH126
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: OverClocked
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
    local integer i= 0
    set udg_chance=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_item_6[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_item_9[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_stormhammer[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_item_25[i]=0
        set i=i + 1
    endloop

    set udg_wave_timer=CreateTimer()
    set udg_start_timer=CreateTimer()
    set udg_income_gold=400
    set udg_income_wood=10.00
    set udg_bonus_gold_to_top3=0
    set udg_AI_WarGolem=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_Ability_ultimate_Limit[i]=0
        set i=i + 1
    endloop

    set udg_pvp_timer=CreateTimer()
    set udg_Sec_5=5
    set udg_FinalDuels_timer=CreateTimer()
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait3_2[i]=0
        set i=i + 1
    endloop

    set udg_enrage_timer=CreateTimer()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_FinalDuels_wins[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait1[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait3[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait6[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait8[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait10[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_lvl2_trait5[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_lvl2_trait7[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_retraining_levelof_Ability[i]=0
        set i=i + 1
    endloop

    set udg_pig=0
    set udg_DamageEventArmorPierced=0
    set udg_AfterDamageEvent=0
    set udg_DamageEventOverride=false
    set udg_DamageEvent=0
    set udg_DamageModifierEvent=0
    set udg_DamageEventAmount=0
    set udg_DamageEventPrevAmt=0
    set udg_LethalDamageEvent=0
    set udg_LethalDamageHP=0
    set udg_AOEDamageEvent=0
    set udg_DamageEventAOE=0
    set udg_DamageEventAOEGroup=CreateGroup()
    set udg_DamageEventLevel=0
    set udg_DamageEventType=0
    set udg_NextDamageType=0
    set udg_DamageScalingUser=0
    set udg_DamageScalingWC3=0
    set udg_DamageTypeBlocked=0
    set udg_DamageTypeCriticalStrike=0
    set udg_DamageTypeCode=0
    set udg_DamageTypeExplosive=0
    set udg_DamageTypeHeal=0
    set udg_DamageTypePure=0
    set udg_DamageTypePureExplosive=0
    set udg_DamageTypeReduced=0
    set udg_IsDamageCode=false
    set udg_IsDamageMelee=false
    set udg_IsDamageRanged=false
    set udg_IsDamageSpell=false
    set udg_DamageEventArmorT=0
    set udg_ARMOR_TYPE_NONE=0
    set udg_ARMOR_TYPE_FLESH=0
    set udg_ARMOR_TYPE_METAL=0
    set udg_ARMOR_TYPE_WOOD=0
    set udg_ARMOR_TYPE_ETHEREAL=0
    set udg_ARMOR_TYPE_STONE=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ArmorTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_DamageEventAttackT=0
    set udg_ATTACK_TYPE_SPELLS=0
    set udg_ATTACK_TYPE_NORMAL=0
    set udg_ATTACK_TYPE_PIERCE=0
    set udg_ATTACK_TYPE_SIEGE=0
    set udg_ATTACK_TYPE_MAGIC=0
    set udg_ATTACK_TYPE_CHAOS=0
    set udg_ATTACK_TYPE_HERO=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_AttackTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_DamageEventDamageT=0
    set udg_DAMAGE_TYPE_UNKNOWN=0
    set udg_DAMAGE_TYPE_NORMAL=0
    set udg_DAMAGE_TYPE_ENHANCED=0
    set udg_DAMAGE_TYPE_FIRE=0
    set udg_DAMAGE_TYPE_COLD=0
    set udg_DAMAGE_TYPE_LIGHTNING=0
    set udg_DAMAGE_TYPE_POISON=0
    set udg_DAMAGE_TYPE_DISEASE=0
    set udg_DAMAGE_TYPE_DIVINE=0
    set udg_DAMAGE_TYPE_MAGIC=0
    set udg_DAMAGE_TYPE_SONIC=0
    set udg_DAMAGE_TYPE_ACID=0
    set udg_DAMAGE_TYPE_FORCE=0
    set udg_DAMAGE_TYPE_DEATH=0
    set udg_DAMAGE_TYPE_MIND=0
    set udg_DAMAGE_TYPE_PLANT=0
    set udg_DAMAGE_TYPE_DEFENSIVE=0
    set udg_DAMAGE_TYPE_DEMOLITION=0
    set udg_DAMAGE_TYPE_SLOW_POISON=0
    set udg_DAMAGE_TYPE_SPIRIT_LINK=0
    set udg_DAMAGE_TYPE_SHADOW_STRIKE=0
    set udg_DAMAGE_TYPE_UNIVERSAL=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_DamageTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_DamageEventDefenseT=0
    set udg_DEFENSE_TYPE_LIGHT=0
    set udg_DEFENSE_TYPE_MEDIUM=0
    set udg_DEFENSE_TYPE_HEAVY=0
    set udg_DEFENSE_TYPE_FORTIFIED=0
    set udg_DEFENSE_TYPE_NORMAL=0
    set udg_DEFENSE_TYPE_HERO=0
    set udg_DEFENSE_TYPE_DIVINE=0
    set udg_DEFENSE_TYPE_UNARMORED=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_DefenseTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_WeaponTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_WEAPON_TYPE_NONE=0
    set udg_WEAPON_TYPE_ML_CHOP=0
    set udg_WEAPON_TYPE_MM_CHOP=0
    set udg_WEAPON_TYPE_MH_CHOP=0
    set udg_WEAPON_TYPE_ML_SLICE=0
    set udg_WEAPON_TYPE_MM_SLICE=0
    set udg_WEAPON_TYPE_MH_SLICE=0
    set udg_WEAPON_TYPE_MM_BASH=0
    set udg_WEAPON_TYPE_MH_BASH=0
    set udg_WEAPON_TYPE_MM_STAB=0
    set udg_WEAPON_TYPE_MH_STAB=0
    set udg_WEAPON_TYPE_WL_SLICE=0
    set udg_WEAPON_TYPE_WM_SLICE=0
    set udg_WEAPON_TYPE_WH_SLICE=0
    set udg_WEAPON_TYPE_WL_BASH=0
    set udg_WEAPON_TYPE_WM_BASH=0
    set udg_WEAPON_TYPE_WH_BASH=0
    set udg_WEAPON_TYPE_WL_STAB=0
    set udg_WEAPON_TYPE_WM_STAB=0
    set udg_WEAPON_TYPE_CL_SLICE=0
    set udg_WEAPON_TYPE_CM_SLICE=0
    set udg_WEAPON_TYPE_CH_SLICE=0
    set udg_WEAPON_TYPE_AM_CHOP=0
    set udg_WEAPON_TYPE_RH_BASH=0
    set udg_DamageEventWeaponT=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_lvl3_trait3[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_lvl3_trait4[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_orb_of_kil_trait[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_overwhelm_trait[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait11[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_item_35[i]=0
        set i=i + 1
    endloop

    set udg_temp_UnitGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_item_37[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait9[i]=0
        set i=i + 1
    endloop

    set udg_temp_num=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait10_Copy[i]=0
        set i=i + 1
    endloop

    set udg_creeps_enrage=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait12[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_maxabilities_counter[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_trait5_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait5[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKLevelUpFix[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Hotkeys[i]=""
        set i=i + 1
    endloop

    set udg_temp_num_1=0
    set udg_temp_string=""
    set udg_temp_bol=false
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_temp_integr[i]=0
        set i=i + 1
    endloop

    set udg_NICKActivePlayers=CreateForce()
    set udg_NICKVoteCount=0
    set udg_NICKFrenzyTraitDMG=0
    set udg_NICKTempText=""
    set udg_NICKDuelsGroup=CreateGroup()
    set udg_NICKDuelsWonGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NickClawsofFrenzyTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NICKManaShieldTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKManaShieldAbsorb[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NICKSerathilTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set udg_NICKPhoenixClawDMGType=0
    set udg_NICKPeriodicTimer=CreateTimer()
    set udg_NICKAllStatsColour=0
    set udg_NICKObsidianRingGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKWandofSorcery[i]=0
        set i=i + 1
    endloop

    set udg_NICKPhoenixClawDamage=0
    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NICKStormHammerTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKStormHammerCharges[i]=0
        set i=i + 1
    endloop

    set udg_NICKSkullofGuldanGroup=CreateGroup()
    set udg_NICKBerserkerSpearGroup=CreateGroup()
    set udg_NICKPhoenixClawGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKLightningJavelinCharges[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKMagicDaggerReal[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKMagicDaggerInteger[i]=0
        set i=i + 1
    endloop

    set udg_NICKFirehandGauntletsGroup=CreateGroup()
    set udg_NICKFirehandGauntletsAllUnits=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKBeltofGiantStrengthInteger[i]=0
        set i=i + 1
    endloop

    set udg_NICKBeltofGiantStrengthGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKSkullofGuldanInteger[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKObsidianRingInteger[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NICKGladiatorsAxeTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_NICKGladiatorsAxeBoolean[i]=true
        set i=i + 1
    endloop

    set udg_NICKBootsofQuelThalasGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKBootsofQuelThalasInteger[i]=0
        set i=i + 1
    endloop

    set udg_NICKRobeoftheMagiGroup=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_NICKRobeoftheMagiInteger[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Draft_haschosen[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_Draft_NumberofChosen[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_spelldamage[i]=1.00
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_thorniumweapons_trait[i]=0
        set i=i + 1
    endloop

    set udg_iconpath=""
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_player_colors[i]=""
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Abilities[i]=""
        set i=i + 1
    endloop

    set udg_temp_string2=""
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_cleared_level[i]=false
        set i=i + 1
    endloop

    set udg_revival_heroes=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_lvl2_trait_taken[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_lvl3_trait_taken[i]=false
        set i=i + 1
    endloop

    set udg_IsDamageAttack=false
    set udg_UnitIndexEvent=0
    set udg_DeathEvent=0
    set udg_HEAL_THRESHOLD=0
    set udg_HEAL_CHECK_INTERVAL=0
    set udg_heal_timer=CreateTimer()
    set udg_REGEN_STRENGTH_VALUE=0
    set udg_REGEN_THRESHOLD=0
    set udg_REGEN_EVENT_INTERVAL=0
    set udg_heal_exitwhen=0
    set udg_heal_count=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_heal_indices[i]=0
        set i=i + 1
    endloop

    set udg_heal_life=0
    set udg_heal_diff=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_heal_lastLife[i]=0
        set i=i + 1
    endloop

    set udg_heal_amount=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_heal_regen[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_regen_buildup[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_regen_timeleft[i]=0
        set i=i + 1
    endloop

    set udg_HealEvent=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_heal_indexRef[i]=0
        set i=i + 1
    endloop

    set udg_UDex=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_heal_inSys[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_UnitIndexLock[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_UDexPrev[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_UDexNext[i]=0
        set i=i + 1
    endloop

    set udg_UDexRecycle=0
    set udg_UnitIndexerEnabled=false
    set udg_UDexWasted=0
    set udg_UDexGen=0
    set udg_wavesDecay_timer=CreateTimer()
    set udg_temp_real=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_searingBlade[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_heresy_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_sonicspeed_trait[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_helm_used[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_pillage_stats[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_grim_stats_hp[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_grim_stats_mana[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_killblow_stats[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_armorUp_stats[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_sund_used[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_portal_trait_count[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_angry_totem_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_angry_totem[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_orb_of_kil_trait_count[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_decimate_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_staff_pseudo_chance[i]=7
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_firehand_pseudo_chance[i]=4
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_infinityclaws_pseudo_chance[i]=2
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_orboflightning_pseudo_chance[i]=10
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_portal_summoning_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set udg_channel_dummies=CreateGroup()
    set udg_is_pvpround=false
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_final_pvp_lives[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_rainbowpot_used[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_rainbowpot_best[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_rainbowpot_worst[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_rainbowpot_bonusstats[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_gloves_spell_mastery[i]=0
        set i=i + 1
    endloop

    set udg_CP_HiddenItemsIndex=0
    set udg_temp_int=0
    set udg_CP_PointIsWalkable=false
    set udg_NumberOfAbilities=94
    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_ressed_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set udg_bloodheart_temp_group=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_javelin_counter[i]=0
        set i=i + 1
    endloop

    set udg_move_projectiles_group=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_Draft_rerolled[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_floating_text_enabled[i]=true
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_floating_text_targets[i]=CreateGroup()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 24 )
        set udg_divinity_gauntlet_dmg[i]=1.00
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 8 )
        set udg_demonic_blade_timer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_player_dead[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_Draft_choose_amount[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_lvl1_trait_taken[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Draft_items_paused[i]=false
        set i=i + 1
    endloop

    set udg_Draft_trait_temp_num=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_spawn_num[i]=0
        set i=i + 1
    endloop

    set udg_lvl3_wave_num=0
    set udg_spawn_chance1=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_spawn_waves_complete[i]=false
        set i=i + 1
    endloop

    set udg_spawn_everyone_cleared=false
    set udg_spawn_waves=0
    set udg_temp_unit_group=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_froststrike_dmg[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_chestgold_count[i]=0
        set i=i + 1
    endloop

    set udg_spawn_chance2=0
    set udg_spawn_chance3=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_trait_picked_count[i]=0
        set i=i + 1
    endloop

    set udg_walls_warning_timer=CreateTimer()
    set udg_wave_temp_num=0
    set udg_wave_diff_lvl=0
    set udg_reward_dialog=DialogCreate()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_list_randomnum[i]=0
        set i=i + 1
    endloop

    set udg_r_temp_num=0
    set udg_reward_chosenbutton_num=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_spelldmg[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_upsummons[i]=0
        set i=i + 1
    endloop

    set udg_reward_returndmg_pillar=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_trigger_taken[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_list_randomnum2[i]=- 1
        set i=i + 1
    endloop

    set udg_reward_lifesteal=0
    set udg_time_week=1
    set udg_time_day=1
    set udg_lose_temp_int=0
    set udg_wavesDecay_warning_timer=CreateTimer()
    set udg_wave_cleared=false
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_learn_option_taken[i]=0
        set i=i + 1
    endloop

    set udg_wave_temp_num_2=0
    set udg_reward_regen=0
    set udg_reward_manaregen_pillar=0
    set udg_ending_dialog=DialogCreate()
    set udg_end_temp_int=0
    set udg_end_spell_int=0
    set udg_heresy_bonus=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_stats_perlvl[i]=0
        set i=i + 1
    endloop

    set udg_shop_cheapitem_amount=0
    set udg_current_wave=0
    set i=0
    loop
        exitwhen ( i > 4 )
        set udg_reward_chosenbutton_num_Copy[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 4 )
        set udg_reward_dialog_Copy[i]=DialogCreate()
        set i=i + 1
    endloop

    set udg_X=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_lifesteal_Copy[i]=0
        set i=i + 1
    endloop

    set udg_ChoosePlayers=0
    set udg_picktimer=CreateTimer()
    set udg_N=0
    set udg_heropicker=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_reward_regen_Copy[i]=0
        set i=i + 1
    endloop

    set udg_Y=0
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_wave_diff_lvl_Copy[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Pcolorname[i]=""
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_retrain_bugfix[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_swap_temp_real1[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_swap_temp_real2[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_swap_temp_real3[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_swap_temp_real4[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_DMG[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_UpAbil[i]=- 1
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_IntArray[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 4 )
        set udg_RetrainNr[i]=- 1
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_AbilLearned1[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_AbilLearned2[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_AbilLearned3[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_AbilLearned4[i]=0
        set i=i + 1
    endloop

    set udg_shop_cheapitem_amount_2=0
    set udg_shop_cheapitem_amount_3=0
    set udg_prevchance=0
    set udg_Activeplayers=CreateForce()
    set udg_Pint=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_PGold[i]=0
        set i=i + 1
    endloop

    set udg_lost=0
    set udg_prevchance2=0
    set udg_GStimer=CreateTimer()
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_HeroXP[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_Frenzy[i]=0
        set i=i + 1
    endloop

    set udg_UG=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_MSInt[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_BigUp[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 0 )
        set udg_SmallUp[i]=0
        set i=i + 1
    endloop

    set udg_SpellFactor=0
    set i=0
    loop
        exitwhen ( i > 4 )
        set udg_FireTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 4 )
        set udg_RunedTimer[i]=CreateTimer()
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_mana_axe_dmg[i]=0
        set i=i + 1
    endloop

    set udg_temp_real_2=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_dragoon_pike_rng[i]=0
        set i=i + 1
    endloop

    set udg_KeyOfBalance=false
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ARISscepterflag[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ARISkeyFlag[i]=false
        set i=i + 1
    endloop

    set udg_ARISsceptercorpes=CreateGroup()
    set udg_Draft_max1=0
    set udg_Draft_max2=0
    set udg_Draft_max3=0
    set udg_Draft_max4=0
    set udg_Draft_max5=0
    set udg_temp_real_hp=0
    set udg_temp_group_slash=CreateGroup()
    set udg_SHeroNazgrelGold=0
    set udg_SHeroBladeClaws1=0
    set udg_SHeroBladeClaws2=0
    set udg_temp_group_slash2=CreateGroup()
    set udg_SHeroArchivistGold=0
    set udg_SHeroAncientOrbs=0
    set udg_SHeroSantaBarrels=0
    set udg_temp_int_slash=0
    set udg_SHeroPenPenDamage=0
    set udg_SHeroBoneCollectorInt=0
    set udg_SHeroStormHadronInt=0
    set udg_SHeroRylaiInt=0
    set udg_SHeroWardenCount=0
    set udg_temp_int_slash2=0
    set udg_SHeroDuckCheeses=0
    set udg_SHeroDancerCount=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_SHeroDancerArr[i]=""
        set i=i + 1
    endloop

    set udg_SLASHSpellFactor=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_SHeroItemArP[i]=0
        set i=i + 1
    endloop

endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  InitMB

function AddText takes string s,real x,real y returns framehandle
 local framehandle f= BlzCreateFrameByType("TEXT", "", PF, "", 0)
	call BlzFrameSetText(f, s)
	call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, BX + x, BY - y - .0005)
	call BlzFrameSetScale(f, 1.1)
	return f
endfunction

function AddIcon takes string s,real x,real y returns framehandle
 local framehandle f= BlzCreateFrameByType("BACKDROP", "", PF, "", 0)
	call BlzFrameSetTexture(f, s, 0, true)
	call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, BX + x, BY - y + .00005)
	call BlzFrameSetSize(f, .013, .013)
	return f
endfunction

function AddHero takes unit u returns nothing
 local player p= GetOwningPlayer(u)
 local integer i= GetUnitTypeId(u)
 local string s= BlzGetAbilityIcon(i)
 local integer z= GetConvertedPlayerId(p) * 10
	call BlzFrameSetTexture(UIcon[z], s, 0, true)
	set SHero[z]=SubString(s, 35, 99)
	set s=GetObjectName(i)
        call BlzFrameSetSize(TTIcon[z], I2R(StringLength(s)) / 150 + .025, .022)
	call BlzFrameSetText(TIcon[z], s)
	call BlzFrameSetVisible(FIcon[z], true)
endfunction

function AddAbility takes player p,integer i,integer a returns nothing
 local integer z= GetConvertedPlayerId(p) * 10
 local integer l= StringLength(BlzGetAbilityIcon(a))
 local integer v= GetUnitAbilityLevel(udg_NICKHeroArray[GetConvertedPlayerId(p)], a)
 local string s= SubString(BlzGetAbilityIcon(a), 0, l - 4)
	if SubString(s, l - 1, l) == "On" and SubString(s, l - 5, l) != "WalkOn" then
		set s=SubString(s, 0, l - 2)
	endif
	if SubString(s, 20, 27) == "Passive" then
		set s=SubString(s, 0, 20) + "CommandButtons/" + SubString(s, 38, 99)
	endif
	if SubString(s, l - 17, 99) == "Immolation" then
		set s=s + "On"
	endif
	call BlzFrameSetTexture(USkill[z + i], s, 0, true)
	call BlzFrameSetVisible(USkill[z + i], true)
	call BlzFrameSetVisible(FSkill[z + i], true)
	set SSkill[z + i]=SubString(s, 35, 99)
	set s=GetObjectName(a)
	set l=StringLength(s)
	set s=SubString(s, 0, l - 2)
	set s=s + " Lvl " + I2S(v)
	set l=StringLength(s)
        call BlzFrameSetSize(TTSkill[z + i], I2R(l + 2) / 150 + .016, .022)
	call BlzFrameSetText(TSkill[z + i], s)
endfunction

function Unlearn takes player p,integer i returns nothing
 local integer z= GetConvertedPlayerId(p) * 10
	set i=i + 1
	call BlzFrameSetVisible(USkill[z + i], false)
	call BlzFrameSetVisible(FSkill[z + i], false)
endfunction

function AddTrait takes player p,integer i,integer a returns nothing
 local integer z= GetConvertedPlayerId(p) * 10
 local string s= BlzGetAbilityIcon(a)
	call BlzFrameSetTexture(UTrait[z + i], s, 0, true)
	call BlzFrameSetVisible(UTrait[z + i], true)
	set STrait[z + i]=SubString(s, 35, 99)
	set s=GetObjectName(a)
        call BlzFrameSetSize(TTTrait[z + i], I2R(StringLength(s)) / 150 + .025, .022)
	call BlzFrameSetText(TTrait[z + i], s)
endfunction

function CheckActive takes integer i returns boolean
	return GetPlayerController(Player(i - 1)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING
endfunction

function EndPlayer takes player p returns nothing
 local integer z= GetConvertedPlayerId(p) * 10
 local integer i
 local string s
 local string sd= "ReplaceableTextures/CommandButtonsDisabled/DIS"
    call BlzFrameSetText(UName[z], "|cff5a5a5a" + GetPlayerName(p))
	if SHero[z] != null then
		set s=SHero[z]
	else
		set s="BTNSelectHeroOn"
	endif
	set s=sd + s
	call BlzFrameSetTexture(UIcon[z], s, 0, true)
	set i=1
	loop
		exitwhen i > 7
		if SSkill[z + i] != null then
			call BlzFrameSetTexture(USkill[z + i], sd + SSkill[z + i], 0, true)
		endif
		set i=i + 1
	endloop
endfunction

function ReturnPlayer takes player p returns nothing
 local integer x
 local integer i= GetConvertedPlayerId(p)
 local integer z= i * 10
 local string s= "ReplaceableTextures/CommandButtons/"
	call BlzFrameSetText(UName[z], udg_player_colors[i] + GetPlayerName(p))
	call BlzFrameSetTexture(UIcon[z], BlzGetAbilityIcon(GetUnitTypeId(udg_NICKHeroArray[i])), 0, true)
	set x=1
	loop
		exitwhen x > 7
		if SSkill[z + x] != null then
			call BlzFrameSetTexture(USkill[z + x], s + SSkill[z + x], 0, true)
		endif
		set x=x + 1
	endloop
	set x=1
	loop
		exitwhen x > 3
		if STrait[z + x] != null then
			call BlzFrameSetTexture(UTrait[z + x], s + STrait[z + x], 0, true)
		endif
		set x=x + 1
	endloop
endfunction


function FinalBoard takes nothing returns nothing
 local integer i= 0
	loop
		exitwhen i > 7
		if CheckActive(i * 3 + 1) or CheckActive(i * 3 + 2) or CheckActive(i * 3 + 3) then
			call BlzFrameSetVisible(TLiveT[i + 1], true)
			call BlzFrameSetVisible(TLiveI[i + 1], true)
		endif
		set i=i + 1
	endloop
endfunction

function SwapUI takes nothing returns nothing
 local player p= GetTriggerPlayer()
	if GetLocalPlayer() == GetTriggerPlayer() then
		call StartSound(gg_snd_MouseClick1)
		call BlzFrameSetEnable(BlzGetTriggerFrame(), false)
		call BlzFrameSetEnable(BlzGetTriggerFrame(), true)
		if UIOn == true then
			set UIOn=false
			call BlzFrameSetVisible(PF, false)
			call BlzFrameSetTexture(UIB2, "ui/widgets/glues/gluescreen-checkbox-background", 0, false)
		elseif UIOn == false then
			set UIOn=true
			call BlzFrameSetVisible(PF, true)
			call BlzFrameSetTexture(UIB2, "ui/widgets/glues/gluescreen-checkbox-backgroundpressed", 0, false)
		endif
	endif
endfunction

function InitMB takes nothing returns nothing

local player p
local integer i
local integer i2
local integer z
local real y= - .025
local framehandle f
local framehandle f2
local framehandle f3
local framehandle f4
set PF=BlzCreateFrameByType("BACKDROP", "", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
call BlzFrameSetAbsPoint(PF, FRAMEPOINT_TOPLEFT, BX - .005, BY + .026)
call BlzFrameSetTexture(PF, "Textures/Black32", 0, true)
set i=1
set i2=0
loop
	exitwhen i > 8
	set p=Player(i - 1)
	if GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
		if i != 1 then
        set y=y + .003
        endif
        set z=i * 10
        set TLiveT[i]=AddText("0" , .221 , y)
        set TDamT[i]=AddText("0" , .26 , y)

		set UName[z]=AddText(udg_player_colors[i] + GetPlayerName(p) , 0 , y)
		set f=AddIcon("" , .08 , y)
		call BlzFrameSetTexture(f, "ReplaceableTextures/CommandButtons/BTNSelectHeroOn", 0, true)
		set UIcon[z]=f
		set f2=BlzCreateFrameByType("FRAME", "", f, "", 0)
		call BlzFrameSetVisible(f2, false)
		set FIcon[z]=f2
		set f3=BlzCreateFrame("BoxedText", f, 0, 0)
		call BlzFrameSetAllPoints(f2, f)
		call BlzFrameSetTooltip(f2, f3)
		call BlzFrameSetPoint(f3, FRAMEPOINT_RIGHT, f, FRAMEPOINT_LEFT, - .002, 0)
		set TTIcon[z]=f3
		set f4=BlzGetFrameByName("BoxedTextTitle", 0)
		call BlzFrameSetScale(f3, .85)
		set TIcon[z]=f4
		set i2=1
		loop
			exitwhen i2 > 7
			set f=AddIcon("" , .09 + .014 * i2 , y)
			call BlzFrameSetVisible(f, false)
			set USkill[z + i2]=f
			set f2=BlzCreateFrameByType("FRAME", "", f, "", 0)
			set FSkill[z + i2]=f2
			set f3=BlzCreateFrame("BoxedText", f, 0, 0)
			call BlzFrameSetAllPoints(f2, f)
			call BlzFrameSetTooltip(f2, f3)
			call BlzFrameSetPoint(f3, FRAMEPOINT_RIGHT, f, FRAMEPOINT_LEFT, - .002, 0)
			set TTSkill[z + i2]=f3
			set f4=BlzGetFrameByName("BoxedTextTitle", 0)
			call BlzFrameSetScale(f3, .85)
			set TSkill[z + i2]=f4
			set i2=i2 + 1
		endloop
		set i2=1
		loop
			exitwhen i2 > 3
			set f=AddIcon("" , .209 + .044 * ( i2 - 1 ) , y)
		if i2 > 1 then
			call BlzFrameSetSize(f, .01, .01)
			call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, BX + .21 + .0382 * ( i2 - 1 ), BY - y - .00145)
		endif

			call BlzFrameSetVisible(f, false)
			set UTrait[z + i2]=f
			set f2=BlzCreateFrameByType("FRAME", "", f, "", 0)
			set FTrait[z + i2]=f2
			set f3=BlzCreateFrame("BoxedText", f, 0, 0)
			call BlzFrameSetAllPoints(f2, f)
			call BlzFrameSetTooltip(f2, f3)
			call BlzFrameSetPoint(f3, FRAMEPOINT_RIGHT, f, FRAMEPOINT_LEFT, - .002, 0)
			set TTTrait[z + i2]=f3
			set f4=BlzGetFrameByName("BoxedTextTitle", 0)
			call BlzFrameSetScale(f3, .85)
			set TTrait[z + i2]=f4
			set i2=i2 + 1
		endloop
		set y=y + .014
	endif
	set i=i + 1
endloop

call BlzFrameSetSize(PF, .33, y + .028)

set f=BlzCreateFrameByType("BUTTON", "", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
set f2=BlzCreateFrameByType("BACKDROP", "", f, "", 0)
set UIB=f
set UIB2=f2
call BlzFrameSetAllPoints(f2, f)
call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, .9084, .527)
call BlzFrameSetSize(f, .015, .015)
call BlzFrameSetTexture(f2, "ui/widgets/glues/gluescreen-checkbox-backgroundpressed", 0, false)
set f3=BlzCreateFrame("BoxedText", f, 0, 0)
call BlzFrameSetTooltip(f, f3)
call BlzFrameSetPoint(f3, FRAMEPOINT_RIGHT, f, FRAMEPOINT_LEFT, - .002, 0)
call BlzFrameSetSize(f3, .04, .022)
set f4=BlzGetFrameByName("BoxedTextTitle", 0)
call BlzFrameSetScale(f3, .85)
call BlzFrameSetText(f4, "Info")

call BlzFrameSetVisible(PF, false)
call BlzFrameSetVisible(UIB, false)
set UIOn=false

set TrigUI=CreateTrigger()
call BlzTriggerRegisterFrameEvent(TrigUI, f, FRAMEEVENT_CONTROL_CLICK)

set i=0
loop
	exitwhen i > 23
	call TriggerRegisterPlayerChatEvent(TrigUI, Player(i), "-info", true)
	set i=i + 1
endloop

endfunction

//***************************************************************************
//*
//*  Sound Assets
//*
//***************************************************************************

function InitSounds takes nothing returns nothing
    set gg_snd_ArrangedTeamInvitation=CreateSound("Sound\\Interface\\ArrangedTeamInvitation.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ArrangedTeamInvitation, 3562)
    call SetSoundChannel(gg_snd_ArrangedTeamInvitation, 0)
    call SetSoundVolume(gg_snd_ArrangedTeamInvitation, - 1)
    call SetSoundPitch(gg_snd_ArrangedTeamInvitation, 1.0)
    set gg_snd_BattleNetTick=CreateSound("Sound\\Interface\\BattleNetTick.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_BattleNetTick, 657)
    call SetSoundChannel(gg_snd_BattleNetTick, 0)
    call SetSoundVolume(gg_snd_BattleNetTick, 127)
    call SetSoundPitch(gg_snd_BattleNetTick, 1.0)
    set gg_snd_BrewMasterDeath1=CreateSound("Units/Creeps/PandarenBrewmaster/BrewMasterDeath1.flac", false, true, true, 1, 1, "CombatSoundsEAX")
    call SetSoundParamsFromLabel(gg_snd_BrewMasterDeath1, "PandarenBrewmasterDeath")
    call SetSoundDuration(gg_snd_BrewMasterDeath1, 2699)
    call SetSoundChannel(gg_snd_BrewMasterDeath1, 0)
    call SetSoundVolume(gg_snd_BrewMasterDeath1, 127)
    call SetSoundPitch(gg_snd_BrewMasterDeath1, 1.2)
    set gg_snd_BuildingDeathLargeHuman=CreateSound("Sound\\Buildings\\Death\\BuildingDeathLargeHuman.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_BuildingDeathLargeHuman, 4388)
    call SetSoundChannel(gg_snd_BuildingDeathLargeHuman, 0)
    call SetSoundVolume(gg_snd_BuildingDeathLargeHuman, - 1)
    call SetSoundPitch(gg_snd_BuildingDeathLargeHuman, 1.1)
    call SetSoundDistances(gg_snd_BuildingDeathLargeHuman, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_BuildingDeathLargeHuman, 3000.0)
    call SetSoundConeAngles(gg_snd_BuildingDeathLargeHuman, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_BuildingDeathLargeHuman, 0.0, 0.0, 0.0)
    set gg_snd_ClanInvitation=CreateSound("Sound\\Interface\\ClanInvitation.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ClanInvitation, 4295)
    call SetSoundChannel(gg_snd_ClanInvitation, 0)
    call SetSoundVolume(gg_snd_ClanInvitation, - 1)
    call SetSoundPitch(gg_snd_ClanInvitation, 1.0)
    set gg_snd_CreepAggroWhat1=CreateSound("Sound\\Interface\\CreepAggroWhat1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_CreepAggroWhat1, 1784)
    call SetSoundChannel(gg_snd_CreepAggroWhat1, 0)
    call SetSoundVolume(gg_snd_CreepAggroWhat1, - 1)
    call SetSoundPitch(gg_snd_CreepAggroWhat1, 1.0)
    set gg_snd_DarkVictory=CreateSound("Sound\\Music\\mp3Music\\DarkVictory.mp3", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_DarkVictory, 61185)
    call SetSoundChannel(gg_snd_DarkVictory, 7)
    call SetSoundVolume(gg_snd_DarkVictory, 127)
    call SetSoundPitch(gg_snd_DarkVictory, 1.0)
    set gg_snd_Feedback=CreateSound("Abilities\\Spells\\Human\\Feedback\\Feedback.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundDuration(gg_snd_Feedback, 1221)
    call SetSoundChannel(gg_snd_Feedback, 0)
    call SetSoundVolume(gg_snd_Feedback, - 1)
    call SetSoundPitch(gg_snd_Feedback, 1.0)
    call SetSoundDistances(gg_snd_Feedback, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_Feedback, 3000.0)
    call SetSoundConeAngles(gg_snd_Feedback, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_Feedback, 0.0, 0.0, 0.0)
    set gg_snd_GameFound=CreateSound("Sound\\Interface\\GameFound.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_GameFound, 7488)
    call SetSoundChannel(gg_snd_GameFound, 0)
    call SetSoundVolume(gg_snd_GameFound, - 1)
    call SetSoundPitch(gg_snd_GameFound, 1.0)
    set gg_snd_GameFound01=CreateSound("Sound/Interface/GameFound.flac", false, false, false, 1, 1, "DoodadsEAX")
    call SetSoundParamsFromLabel(gg_snd_GameFound01, "GameFound")
    call SetSoundDuration(gg_snd_GameFound01, 7488)
    call SetSoundVolume(gg_snd_GameFound01, 127)
    call SetSoundPitch(gg_snd_GameFound01, 1.0)
    set gg_snd_GoodJob=CreateSound("Sound\\Interface\\GoodJob.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_GoodJob, 2954)
    call SetSoundChannel(gg_snd_GoodJob, 0)
    call SetSoundVolume(gg_snd_GoodJob, - 1)
    call SetSoundPitch(gg_snd_GoodJob, 1.0)
    set gg_snd_LightningBolt1=CreateSound("Doodads\\Cinematic\\Lightningbolt\\LightningBolt1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundDuration(gg_snd_LightningBolt1, 3000)
    call SetSoundChannel(gg_snd_LightningBolt1, 0)
    call SetSoundVolume(gg_snd_LightningBolt1, - 1)
    call SetSoundPitch(gg_snd_LightningBolt1, 1.0)
    call SetSoundDistances(gg_snd_LightningBolt1, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_LightningBolt1, 3000.0)
    call SetSoundConeAngles(gg_snd_LightningBolt1, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_LightningBolt1, 0.0, 0.0, 0.0)
    set gg_snd_NewTournament=CreateSound("Sound\\Interface\\NewTournament.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_NewTournament, 7987)
    call SetSoundChannel(gg_snd_NewTournament, 0)
    call SetSoundVolume(gg_snd_NewTournament, - 1)
    call SetSoundPitch(gg_snd_NewTournament, 1.0)
    set gg_snd_QuestActivateWhat1=CreateSound("Sound\\Interface\\QuestActivateWhat1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_QuestActivateWhat1, 539)
    call SetSoundChannel(gg_snd_QuestActivateWhat1, 0)
    call SetSoundVolume(gg_snd_QuestActivateWhat1, 127)
    call SetSoundPitch(gg_snd_QuestActivateWhat1, 1.0)
    set gg_snd_QuestLog=CreateSound("Sound\\Interface\\QuestLog.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_QuestLog, 2275)
    call SetSoundChannel(gg_snd_QuestLog, 0)
    call SetSoundVolume(gg_snd_QuestLog, 127)
    call SetSoundPitch(gg_snd_QuestLog, 1.0)
    set gg_snd_QuestNew=CreateSound("Sound\\Interface\\QuestNew.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_QuestNew, 3750)
    call SetSoundChannel(gg_snd_QuestNew, 0)
    call SetSoundVolume(gg_snd_QuestNew, 127)
    call SetSoundPitch(gg_snd_QuestNew, 1.0)
    set gg_snd_ReceiveGold=CreateSound("Abilities\\Spells\\Items\\ResourceItems\\ReceiveGold.wav", true, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ReceiveGold, 589)
    call SetSoundChannel(gg_snd_ReceiveGold, 0)
    call SetSoundVolume(gg_snd_ReceiveGold, 85)
    call SetSoundPitch(gg_snd_ReceiveGold, 1.9)
    call SetSoundDistances(gg_snd_ReceiveGold, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_ReceiveGold, 3000.0)
    call SetSoundConeAngles(gg_snd_ReceiveGold, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_ReceiveGold, 0.0, 0.0, 0.0)
    set gg_snd_Rescue=CreateSound("Sound\\Interface\\Rescue.wav", false, false, false, 1, 1, "DefaultEAXON")
    call SetSoundDuration(gg_snd_Rescue, 3796)
    call SetSoundChannel(gg_snd_Rescue, 0)
    call SetSoundVolume(gg_snd_Rescue, 127)
    call SetSoundPitch(gg_snd_Rescue, 1.0)
    set gg_snd_ShimmeringPortalBirth=CreateSound("Sound\\Ambient\\DoodadEffects\\ShimmeringPortalBirth.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ShimmeringPortalBirth, 8528)
    call SetSoundChannel(gg_snd_ShimmeringPortalBirth, 0)
    call SetSoundVolume(gg_snd_ShimmeringPortalBirth, - 1)
    call SetSoundPitch(gg_snd_ShimmeringPortalBirth, 1.0)
    call SetSoundDistances(gg_snd_ShimmeringPortalBirth, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_ShimmeringPortalBirth, 3000.0)
    call SetSoundConeAngles(gg_snd_ShimmeringPortalBirth, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_ShimmeringPortalBirth, 0.0, 0.0, 0.0)
    set gg_snd_ShimmeringPortalDeath=CreateSound("Sound\\Ambient\\DoodadEffects\\ShimmeringPortalDeath.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ShimmeringPortalDeath, 4783)
    call SetSoundChannel(gg_snd_ShimmeringPortalDeath, 0)
    call SetSoundVolume(gg_snd_ShimmeringPortalDeath, - 1)
    call SetSoundPitch(gg_snd_ShimmeringPortalDeath, 1.0)
    call SetSoundDistances(gg_snd_ShimmeringPortalDeath, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_ShimmeringPortalDeath, 3000.0)
    call SetSoundConeAngles(gg_snd_ShimmeringPortalDeath, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_ShimmeringPortalDeath, 0.0, 0.0, 0.0)
    set gg_snd_ShimmeringPortalEntrance=CreateSound("Sound\\Ambient\\DoodadEffects\\ShimmeringPortalEntrance.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_ShimmeringPortalEntrance, 1828)
    call SetSoundChannel(gg_snd_ShimmeringPortalEntrance, 0)
    call SetSoundVolume(gg_snd_ShimmeringPortalEntrance, - 1)
    call SetSoundPitch(gg_snd_ShimmeringPortalEntrance, 1.0)
    call SetSoundDistances(gg_snd_ShimmeringPortalEntrance, 0.0, 10000.0)
    call SetSoundDistanceCutoff(gg_snd_ShimmeringPortalEntrance, 3000.0)
    call SetSoundConeAngles(gg_snd_ShimmeringPortalEntrance, 0.0, 0.0, 127)
    call SetSoundConeOrientation(gg_snd_ShimmeringPortalEntrance, 0.0, 0.0, 0.0)
    set gg_snd_TuskarrDeath1=CreateSound("Units/Creeps/tuskar/TuskarrDeath1.flac", false, true, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_TuskarrDeath1, "TuskarrDeath")
    call SetSoundDuration(gg_snd_TuskarrDeath1, 2252)
    call SetSoundVolume(gg_snd_TuskarrDeath1, 127)
    set gg_snd_Warning=CreateSound("Sound/Interface/Warning.flac", false, false, false, 1, 1, "DoodadsEAX")
    call SetSoundParamsFromLabel(gg_snd_Warning, "Warning")
    call SetSoundDuration(gg_snd_Warning, 1903)
    call SetSoundVolume(gg_snd_Warning, 127)
    set gg_snd_MouseClick1=CreateSound("Sound/Interface/MouseClick1.flac", false, false, false, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_MouseClick1, "InterfaceClick")
    call SetSoundDuration(gg_snd_MouseClick1, 238)
    call SetSoundVolume(gg_snd_MouseClick1, 127)
    set gg_snd_StampedeCaster1=CreateSound("Abilities/Spells/Other/Stampede/StampedeCaster1.flac", false, true, true, 1, 1, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_StampedeCaster1, "StampedeCast")
    call SetSoundDuration(gg_snd_StampedeCaster1, 2670)
    call SetSoundVolume(gg_snd_StampedeCaster1, 127)
    set gg_snd_QuestCompleted=CreateSound("Sound/Interface/QuestCompleted.flac", false, false, false, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_QuestCompleted, "QuestCompleted")
    call SetSoundDuration(gg_snd_QuestCompleted, 5154)
    call SetSoundChannel(gg_snd_QuestCompleted, 0)
    call SetSoundVolume(gg_snd_QuestCompleted, 127)
    set gg_snd_QuestFailed=CreateSound("Sound/Interface/QuestFailed.flac", false, false, false, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_QuestFailed, "QuestFailed")
    call SetSoundDuration(gg_snd_QuestFailed, 4690)
    call SetSoundChannel(gg_snd_QuestFailed, 0)
    call SetSoundVolume(gg_snd_QuestFailed, 127)
    set gg_snd_Tension=CreateSound("Sound/Music/mp3Music/Tension.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_Tension, "Tension")
    call SetSoundDuration(gg_snd_Tension, 19539)
    call SetSoundChannel(gg_snd_Tension, 0)
    call SetSoundVolume(gg_snd_Tension, 127)
    set gg_snd_LichKingTheme=CreateSound("Sound/Music/mp3Music/LichKingTheme.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_LichKingTheme, "LichKingTheme")
    call SetSoundDuration(gg_snd_LichKingTheme, 79133)
    call SetSoundChannel(gg_snd_LichKingTheme, 0)
    call SetSoundVolume(gg_snd_LichKingTheme, 127)
    set gg_snd_One_Eternity_Later=CreateSound("war3mapImported/One Eternity Later  SpongeBob Time Card #9.mp3", false, false, false, 1, 1, "DefaultEAXON")
    call SetSoundDuration(gg_snd_One_Eternity_Later, 2352)
    call SetSoundChannel(gg_snd_One_Eternity_Later, 0)
    call SetSoundVolume(gg_snd_One_Eternity_Later, 127)
    call SetSoundPitch(gg_snd_One_Eternity_Later, 1.0)
    set gg_snd_ObsidianStatueYes3=CreateSound("Units/Undead/ObsidianStatue/ObsidianStatueYes3.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_ObsidianStatueYes3, "ObsidianStatueYesAttack")
    call SetSoundDuration(gg_snd_ObsidianStatueYes3, 2641)
    call SetSoundChannel(gg_snd_ObsidianStatueYes3, 0)
    call SetSoundVolume(gg_snd_ObsidianStatueYes3, 127)
    set gg_snd_ObsidianStatueYes2=CreateSound("Units/Undead/ObsidianStatue/ObsidianStatueYes2.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_ObsidianStatueYes2, "ObsidianStatueYesAttack")
    call SetSoundDuration(gg_snd_ObsidianStatueYes2, 2710)
    call SetSoundChannel(gg_snd_ObsidianStatueYes2, 0)
    call SetSoundVolume(gg_snd_ObsidianStatueYes2, 127)
    set gg_snd_ObsidianAvengerPissed1=CreateSound("Units/Undead/ObsidianStatue/ObsidianAvengerPissed1.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_ObsidianAvengerPissed1, "ObsidianDestroyerPissed")
    call SetSoundDuration(gg_snd_ObsidianAvengerPissed1, 3024)
    call SetSoundChannel(gg_snd_ObsidianAvengerPissed1, 0)
    call SetSoundVolume(gg_snd_ObsidianAvengerPissed1, 127)
    set gg_snd_ObsidianStatueMorph=CreateSound("Units/Undead/ObsidianStatue/ObsidianStatueMorph.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_ObsidianStatueMorph, "ObsidianStatueMorph")
    call SetSoundDuration(gg_snd_ObsidianStatueMorph, 3384)
    call SetSoundChannel(gg_snd_ObsidianStatueMorph, 0)
    call SetSoundVolume(gg_snd_ObsidianStatueMorph, 127)
    set gg_snd_HeroicVictory=CreateSound("Sound/Music/mp3Music/HeroicVictory.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_HeroicVictory, "HeroicVictory")
    call SetSoundDuration(gg_snd_HeroicVictory, 53371)
    call SetSoundChannel(gg_snd_HeroicVictory, 0)
    call SetSoundVolume(gg_snd_HeroicVictory, 127)
    set gg_snd_PH1=CreateSound("war3mapImported/PH1.flac", true, false, false, 1, 1, "DefaultEAXON")
    call SetSoundDuration(gg_snd_PH1, 281712)
    call SetSoundChannel(gg_snd_PH1, 0)
    call SetSoundVolume(gg_snd_PH1, 127)
    call SetSoundPitch(gg_snd_PH1, 1.0)
    set gg_snd_HeroicVictory01=CreateSound("Sound/Music/mp3Music/HeroicVictory.flac", true, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_HeroicVictory01, "HeroicVictory")
    call SetSoundDuration(gg_snd_HeroicVictory01, 53371)
    call SetSoundChannel(gg_snd_HeroicVictory01, 0)
    call SetSoundVolume(gg_snd_HeroicVictory01, 127)
    set gg_snd_EarthquakeLoop1=CreateSound("Abilities/Spells/Orc/Earthquake/EarthquakeLoop1.flac", true, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_EarthquakeLoop1, "EarthquakeLoop")
    call SetSoundDuration(gg_snd_EarthquakeLoop1, 1962)
    call SetSoundChannel(gg_snd_EarthquakeLoop1, 0)
    call SetSoundVolume(gg_snd_EarthquakeLoop1, 127)
    set gg_snd_EarthquakeRock=CreateSound("Abilities/Spells/Orc/EarthQuake/EarthquakeRock.flac", false, false, true, 1, 1, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_EarthquakeRock, "Earthquake")
    call SetSoundDuration(gg_snd_EarthquakeRock, 2972)
    call SetSoundChannel(gg_snd_EarthquakeRock, 0)
    call SetSoundVolume(gg_snd_EarthquakeRock, 127)
    set gg_snd_ReviveHuman=CreateSound("Abilities/Spells/Human/ReviveHuman/ReviveHuman.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ReviveHuman, "ReviveHuman")
    call SetSoundDuration(gg_snd_ReviveHuman, 3195)
    call SetSoundVolume(gg_snd_ReviveHuman, 127)
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateBuildingsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_n02S_0002=BlzCreateUnitWithSkin(p, 'n02S', 8448.0, - 6912.0, 270.000, 'n02S')
    call SetUnitColor(gg_unit_n02S_0002, ConvertPlayerColor(1))
endfunction

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'h000', 7980.4, - 5785.5, 239.110, 'h000')
    call SetUnitState(u, UNIT_STATE_MANA, 99999)
    call UnitAddItemToSlotById(u, 'sxpl', 0)
    call UnitAddItemToSlotById(u, 'shrs', 1)
    call UnitAddItemToSlotById(u, 'tmmt', 2)
    call UnitAddItemToSlotById(u, 'rag1', 3)
    call UnitAddItemToSlotById(u, 'drph', 4)
    call UnitAddItemToSlotById(u, 'rde2', 5)
    set u=BlzCreateUnitWithSkin(p, 'h000', 7921.1, - 5760.1, 239.110, 'h000')
    call SetUnitState(u, UNIT_STATE_MANA, 99999)
    call UnitAddItemToSlotById(u, 'gcel', 0)
    set u=BlzCreateUnitWithSkin(p, 'h000', 8356.4, - 7088.4, 239.110, 'h000')
    call SetUnitState(u, UNIT_STATE_MANA, 99999)
    set u=BlzCreateUnitWithSkin(p, 'h000', 8025.5, - 5794.6, 239.110, 'h000')
    call SetUnitState(u, UNIT_STATE_MANA, 99999)
    call UnitAddItemToSlotById(u, 'ckng', 0)
    call UnitAddItemToSlotById(u, 'hcun', 1)
    call UnitAddItemToSlotById(u, 'hval', 2)
    call UnitAddItemToSlotById(u, 'ches', 3)
    call UnitAddItemToSlotById(u, 'rat6', 4)
    call UnitAddItemToSlotById(u, 'rlif', 5)
endfunction

//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'h01V', 6407.3, - 4521.2, 44.310, 'h01V')
    call SetUnitState(u, UNIT_STATE_MANA, 99999)
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
    call CreateBuildingsForPlayer0()
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateBuildingsForPlayer0() // INLINED!!
    call CreateNeutralPassive()
    call CreateUnitsForPlayer0() // INLINED!!
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_Region_000=Rect(5664.0, - 4096.0, 6144.0, - 3680.0)
    set gg_rct_item_spawn=Rect(8224.0, - 7136.0, 8352.0, - 7008.0)
    set gg_rct_obelisk=Rect(8320.0, - 7040.0, 8576.0, - 6784.0)
endfunction

//***************************************************************************
//*
//*  Cameras
//*
//***************************************************************************

function CreateCameras takes nothing returns nothing

    set gg_cam_Camera_001=CreateCameraSetup()
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ZOFFSET, 0.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROTATION, 73.4, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ANGLE_OF_ATTACK, 355.8, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_TARGET_DISTANCE, 3000.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROLL, 0.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FARZ, 10000.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_NEARZ, 16.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_PITCH, 0.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_YAW, 0.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_ROLL, 0.0, 0.0)
    call CameraSetupSetDestPosition(gg_cam_Camera_001, 8704.3, - 6576.5, 0.0)

endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: SLASHOnKill
//===========================================================================
function Trig_SLASHOnKill_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetKillingUnitBJ()) != GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) == Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetKillingUnitBJ()) == true ) ) then
        return false
    endif
    if ( not ( GetKillingUnitBJ() != GetDyingUnit() ) ) then
        return false
    endif
    if ( not ( GetKillingUnitBJ() != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func001Func002C takes nothing returns boolean
    if ( not ( udg_chance <= ( ( GetPlayerState(GetOwningPlayer(GetKillingUnitBJ()), PLAYER_STATE_RESOURCE_LUMBER) / 2 ) + 1 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func001Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetKillingUnitBJ()) == 'H01K' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]) == 'H01K' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnKill_Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnKill_Func001Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func002Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetKillingUnitBJ()) == 'H01B' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]) == 'H01B' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnKill_Func002Func003C takes nothing returns boolean
    if ( not ( udg_chance == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func002C takes nothing returns boolean
    if ( not Trig_SLASHOnKill_Func002Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func003Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetKillingUnitBJ()) == 'U00L' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]) == 'U00L' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnKill_Func003C takes nothing returns boolean
    if ( not Trig_SLASHOnKill_Func003Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func004Func001Func001C takes nothing returns boolean
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bcsi') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'BHca') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bcsd') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bfro') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bslo') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bfrz') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'BUfa') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'BCbf') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bcri') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'BHbd') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'Bprg') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(GetDyingUnit(), 'BEer') == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnKill_Func004Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnKill_Func004Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Func004Func002C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetKillingUnitBJ()) == 'H020' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]) == 'H020' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnKill_Func004C takes nothing returns boolean
    if ( not Trig_SLASHOnKill_Func004Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnKill_Actions takes nothing returns nothing
    if ( Trig_SLASHOnKill_Func001C() ) then
        set udg_chance=GetRandomInt(1, 100)
        if ( Trig_SLASHOnKill_Func001Func002C() ) then
            set udg_SHeroSantaBarrels=( udg_SHeroSantaBarrels + 1 )
            set udg_temp_loc_slash1=GetUnitLoc(GetDyingUnit())
            call CreateDestructableLoc('LTbr', udg_temp_loc_slash1, GetRandomDirectionDeg(), 1, 0)
            call TriggerRegisterDeathEvent(gg_trg_SLASHSanta, GetLastCreatedDestructable())
            call RemoveLocation(udg_temp_loc_slash1)
        else
        endif
    else
    endif
    if ( Trig_SLASHOnKill_Func002C() ) then
        set udg_chance=GetRandomInt(1, 64)
        if ( Trig_SLASHOnKill_Func002Func003C() ) then
            set udg_temp_loc_slash1=GetUnitLoc(GetDyingUnit())
            call CreateItemLoc('ches', udg_temp_loc_slash1)
            call RemoveLocation(udg_temp_loc_slash1)
        else
        endif
    else
    endif
    if ( Trig_SLASHOnKill_Func003C() ) then
        call ModifyHeroStat(bj_HEROSTAT_INT, GetKillingUnitBJ(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_INT, GetKillingUnitBJ(), false) + 5 ))
        set udg_SHeroBoneCollectorInt=( udg_SHeroBoneCollectorInt + 1 )
    else
    endif
    if ( Trig_SLASHOnKill_Func004C() ) then
        if ( Trig_SLASHOnKill_Func004Func001C() ) then
            call ModifyHeroStat(bj_HEROSTAT_INT, GetKillingUnitBJ(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_INT, GetKillingUnitBJ(), false) + 1 ))
            set udg_SHeroRylaiInt=( udg_SHeroRylaiInt + 1 )
            call CreateTextTagUnitBJ("TRIGSTR_11643", GetKillingUnitBJ(), 0, 8.00, 0.00, 0.00, 100.00, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, GetRandomDirectionDeg())
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHOnKill takes nothing returns nothing
    set gg_trg_SLASHOnKill=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHOnKill, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_SLASHOnKill, Condition(function Trig_SLASHOnKill_Conditions))
    call TriggerAddAction(gg_trg_SLASHOnKill, function Trig_SLASHOnKill_Actions)
endfunction

//===========================================================================
// Trigger: SLASHOnHit
//===========================================================================
function Trig_SLASHOnHit_Func013Func004C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnHit_Func013C takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_SLASHOnHit_Func013Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Conditions takes nothing returns boolean
    if ( not Trig_SLASHOnHit_Func013C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func004Func003Func001Func002C takes nothing returns boolean
    if ( ( IsUnitAliveBJ(GetEnumUnit()) == false ) ) then
        return true
    endif
    if ( ( IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnHit_Func004Func003Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnHit_Func004Func003Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func004Func003A takes nothing returns nothing
    if ( Trig_SLASHOnHit_Func004Func003Func001C() ) then
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_temp_group_slash)
    else
    endif
endfunction

function Trig_SLASHOnHit_Func004Func004A takes nothing returns nothing
    call AddSpecialEffectTargetUnitBJ("origin", GetEnumUnit(), "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call SetUnitLifeBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) + ( ( 0.03 * udg_temp_real_hp ) / I2R(CountUnitsInGroup(udg_temp_group_slash)) ) ))
endfunction

function Trig_SLASHOnHit_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'Hpal' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func005Func003C takes nothing returns boolean
    if ( not ( ( CosBJ(AngleBetweenPoints(udg_temp_loc_slash2, udg_temp_loc_slash1)) - GetUnitFacing(udg_DamageEventTarget) ) <= udg_temp_real_hp ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'H01A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'H00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'Ntin' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func008Func001C takes nothing returns boolean
    if ( not ( udg_SHeroStormHadronInt >= 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'H00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func009C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'H00G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func010C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'H00O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func011Func001Func002Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, udg_SHeroWardenAbs[GetForLoopIndexA()]) > 1.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func011Func001Func002C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_SHeroWardenAbs[GetForLoopIndexA()], udg_temp_unit_slash1) > 0 ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, udg_SHeroWardenAbs[GetForLoopIndexA()]) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Func011C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_unit_slash1) == 'E00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnHit_Actions takes nothing returns nothing
    set udg_temp_unit_slash1=udg_DamageEventSource
    set udg_temp_unit_slash2=udg_DamageEventTarget
    set udg_temp_loc_slash1=GetUnitLoc(udg_temp_unit_slash1)
    if ( Trig_SLASHOnHit_Func004C() ) then
        set udg_temp_real_hp=GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource)
        set udg_temp_group_slash=GetUnitsInRangeOfLocAll(360.00, udg_temp_loc_slash1)
        call ForGroupBJ(udg_temp_group_slash, function Trig_SLASHOnHit_Func004Func003A)
        call ForGroupBJ(udg_temp_group_slash, function Trig_SLASHOnHit_Func004Func004A)
        call DestroyGroup(udg_temp_group_slash)
    else
    endif
    if ( Trig_SLASHOnHit_Func005C() ) then
        set udg_temp_loc_slash2=GetUnitLoc(udg_DamageEventTarget)
        set udg_temp_real_hp=CosBJ(( 180.00 + 60.00 ))
        if ( Trig_SLASHOnHit_Func005Func003C() ) then
            set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
            set udg_DamageEventAmount=( udg_DamageEventAmount * 1.25 )
            call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventTarget, "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call CreateTextTagUnitBJ("TRIGSTR_7885", udg_DamageEventTarget, 0, 8.00, 0.00, 100, 0.00, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, GetRandomDirectionDeg())
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        else
        endif
        call RemoveLocation(udg_temp_loc_slash2)
    else
    endif
    if ( Trig_SLASHOnHit_Func006C() ) then
        call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, I2R(GetHeroLevel(udg_DamageEventSource)), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    endif
    if ( Trig_SLASHOnHit_Func007C() ) then
        call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, ( 0.10 * ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, gg_unit_n02S_0002) - GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) ) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    endif
    if ( Trig_SLASHOnHit_Func008C() ) then
        if ( Trig_SLASHOnHit_Func008Func001C() ) then
            set udg_SHeroStormHadronInt=1
            set udg_DamageEventAmount=( udg_DamageEventAmount * 5.00 )
        else
            set udg_SHeroStormHadronInt=( udg_SHeroStormHadronInt + 1 )
            call CreateTextTagUnitBJ(( "[ |cffffff00" + ( I2S(udg_SHeroStormHadronInt) + "|r! ]" ) ), udg_temp_unit_slash1, 0, 8.00, 100, 100, 100, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
        endif
    else
    endif
    if ( Trig_SLASHOnHit_Func009C() ) then
        set udg_temp_real_hp=udg_DamageEventAmount
        set udg_DamageEventAmount=0.10
        call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, udg_temp_real_hp, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    endif
    if ( Trig_SLASHOnHit_Func010C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * GetRandomReal(0.00, 2.00) )
    else
    endif
    if ( Trig_SLASHOnHit_Func011C() ) then
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_temp_Ability=udg_SHeroWardenAbs[GetForLoopIndexA()]
            if ( Trig_SLASHOnHit_Func011Func001Func002C() ) then
                if ( Trig_SLASHOnHit_Func011Func001Func002Func001C() ) then
                    call BlzStartUnitAbilityCooldown(udg_DamageEventSource, udg_SHeroWardenAbs[GetForLoopIndexA()], ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, udg_SHeroWardenAbs[GetForLoopIndexA()]) - 1 ))
                else
                    call BlzEndUnitAbilityCooldown(udg_DamageEventSource, udg_SHeroWardenAbs[GetForLoopIndexA()])
                endif
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
    endif
    call RemoveLocation(udg_temp_loc_slash1)
endfunction

//===========================================================================
function InitTrig_SLASHOnHit takes nothing returns nothing
    set gg_trg_SLASHOnHit=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_SLASHOnHit, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_SLASHOnHit, Condition(function Trig_SLASHOnHit_Conditions))
    call TriggerAddAction(gg_trg_SLASHOnHit, function Trig_SLASHOnHit_Actions)
endfunction

//===========================================================================
// Trigger: SLASHOnPick
//
// Fired from Start/Nick Monitor Heroes
//===========================================================================
function Trig_SLASHOnPick_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_SLASHOnPick takes nothing returns nothing
    set gg_trg_SLASHOnPick=CreateTrigger()
    call TriggerAddAction(gg_trg_SLASHOnPick, function Trig_SLASHOnPick_Actions)
endfunction

//===========================================================================
// Trigger: SLASHOnItem
//===========================================================================
function Trig_SLASHOnItem_Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'rat6' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func002Func002C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Obla' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func003Func001Func002C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I046' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I049' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I04A' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tdx2' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tst2' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tin2' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I03M' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tkno' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tpow' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnItem_Func003Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnItem_Func003Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Hamg' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func004Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'sorf' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Ekee' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func005Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'sorf' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H00E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func006Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'ches' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func007Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I03U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H021' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func008Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnItem_Actions takes nothing returns nothing
    if ( Trig_SLASHOnItem_Func001C() ) then
        set udg_SHeroItemArP[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=( udg_SHeroItemArP[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] + 1 )
    else
    endif
    if ( Trig_SLASHOnItem_Func002C() ) then
        if ( Trig_SLASHOnItem_Func002Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + ( 9 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            set udg_SHeroBladeClaws1=( udg_SHeroBladeClaws1 + GetItemCharges(GetManipulatedItem()) )
            call RemoveItem(GetManipulatedItem())
        else
        endif
        if ( Trig_SLASHOnItem_Func002Func002C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) * 0.90 ), ( 0 + 0 ))
            set udg_SHeroBladeClaws2=( udg_SHeroBladeClaws2 + GetItemCharges(GetManipulatedItem()) )
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func003C() ) then
        if ( Trig_SLASHOnItem_Func003Func001C() ) then
            set udg_SHeroArchivistGold=( udg_SHeroArchivistGold + 250 )
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD, ( GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD) + 250 ))
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func004C() ) then
        if ( Trig_SLASHOnItem_Func004Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            set udg_SHeroAncientOrbs=( udg_SHeroAncientOrbs + GetItemCharges(GetManipulatedItem()) )
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func005C() ) then
        if ( Trig_SLASHOnItem_Func005Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            set udg_SHeroAncientOrbs=( udg_SHeroAncientOrbs + GetItemCharges(GetManipulatedItem()) )
            call ModifyHeroStat(bj_HEROSTAT_INT, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, ( 5 * udg_SHeroAncientOrbs ))
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func006C() ) then
        if ( Trig_SLASHOnItem_Func006Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + ( 6 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + I2R(GetItemCharges(GetManipulatedItem())) ))
            set udg_SHeroDuckCheeses=( udg_SHeroDuckCheeses + GetItemCharges(GetManipulatedItem()) )
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func007C() ) then
        if ( Trig_SLASHOnItem_Func007Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + ( 50000 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
    if ( Trig_SLASHOnItem_Func008C() ) then
        if ( Trig_SLASHOnItem_Func008Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( GetHeroStatBJ(bj_HEROSTAT_STR, GetTriggerUnit(), false) + ( 150000 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), false) + ( 150000 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            call BlzSetUnitBaseDamage(GetTriggerUnit(), ( GetHeroStatBJ(bj_HEROSTAT_INT, GetTriggerUnit(), false) + ( 150000 * GetItemCharges(GetManipulatedItem()) ) ), 0)
            call RemoveItem(GetManipulatedItem())
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHOnItem takes nothing returns nothing
    set gg_trg_SLASHOnItem=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHOnItem, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(gg_trg_SLASHOnItem, function Trig_SLASHOnItem_Actions)
endfunction

//===========================================================================
// Trigger: SLASHOnAbility
//===========================================================================
function Trig_SLASHOnAbility_Func005C takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Conditions takes nothing returns boolean
    if ( not Trig_SLASHOnAbility_Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Hpal' ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(GetSpellTargetUnit(), GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnAbility_Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func002Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_SHeroWardenAbs[GetForLoopIndexA()] == GetSpellAbilityId() ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func002Func001Func003C takes nothing returns boolean
    if ( not ( udg_temp_int_slash == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func002Func001Func004C takes nothing returns boolean
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Blink" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Fan of Knives" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Shadow Strike" ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHOnAbility_Func002Func001C takes nothing returns boolean
    if ( not Trig_SLASHOnAbility_Func002Func001Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'E00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func003Func002Func001C takes nothing returns boolean
    if ( not ( udg_SHeroDancerArr[GetForLoopIndexA()] == GetAbilityName(GetSpellAbilityId()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func003Func003C takes nothing returns boolean
    if ( not ( udg_temp_int_slash == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'E00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func004Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 255) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H00O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHOnAbility_Actions takes nothing returns nothing
    if ( Trig_SLASHOnAbility_Func001C() ) then
        set udg_temp_real_hp=( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellTargetUnit()) - GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) )
        call AddSpecialEffectTargetUnitBJ("origin", GetEnumUnit(), "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call SetUnitLifeBJ(GetSpellTargetUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + ( 0.50 * udg_temp_real_hp ) ))
    else
    endif
    if ( Trig_SLASHOnAbility_Func002C() ) then
        if ( Trig_SLASHOnAbility_Func002Func001C() ) then
            set udg_temp_int_slash=0
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=4
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_SLASHOnAbility_Func002Func001Func002Func001C() ) then
                    set udg_temp_int_slash=1
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
            if ( Trig_SLASHOnAbility_Func002Func001Func003C() ) then
                set udg_SHeroWardenCount=( udg_SHeroWardenCount + 1 )
                set udg_SHeroWardenAbs[udg_SHeroWardenCount]=GetSpellAbilityId()
            else
            endif
        else
        endif
    else
    endif
    if ( Trig_SLASHOnAbility_Func003C() ) then
        set udg_temp_int_slash=0
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=( udg_SHeroDancerCount + 1 )
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_SLASHOnAbility_Func003Func002Func001C() ) then
                set udg_temp_int_slash=1
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        if ( Trig_SLASHOnAbility_Func003Func003C() ) then
            set udg_SHeroDancerCount=( udg_SHeroDancerCount + 1 )
            set udg_SHeroDancerArr[udg_SHeroDancerCount]=GetAbilityName(GetSpellAbilityId())
            call CreateTextTagUnitBJ(I2S(udg_SHeroDancerCount), GetTriggerUnit(), 0, 8.50, 100, 0.00, 100, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        else
            set udg_SHeroDancerCount=0
            call CreateTextTagUnitBJ("TRIGSTR_8488", GetTriggerUnit(), 0, 8.50, 100, 0.00, 100, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=15
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                set udg_SHeroDancerArr[GetForLoopIndexA()]=""
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        endif
    else
    endif
    if ( Trig_SLASHOnAbility_Func004C() ) then
        if ( Trig_SLASHOnAbility_Func004Func001C() ) then
            call SetHeroLevelBJ(GetTriggerUnit(), ( GetHeroLevel(GetTriggerUnit()) + 1 ), true)
            call CreateTextTagUnitBJ("TRIGSTR_070", GetTriggerUnit(), 0, 10, 100, 100, 100, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHOnAbility takes nothing returns nothing
    set gg_trg_SLASHOnAbility=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHOnAbility, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SLASHOnAbility, Condition(function Trig_SLASHOnAbility_Conditions))
    call TriggerAddAction(gg_trg_SLASHOnAbility, function Trig_SLASHOnAbility_Actions)
endfunction

//===========================================================================
// Trigger: SLASHLevelUp
//===========================================================================
function Trig_SLASHLevelUp_Func002C takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Conditions takes nothing returns boolean
    if ( not Trig_SLASHLevelUp_Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func001Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 150) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'U00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func003Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 10) == 0 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A0PZ', GetTriggerUnit()) < 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Nbrn' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func004Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 10) == 0 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A0QP', GetTriggerUnit()) < 11 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func005Func002C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func005Func004C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func005Func006C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H00O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func006Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 10) == 5 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A0Q8', GetTriggerUnit()) < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Nbrn' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func007Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 10) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Nalc' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func008Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 10) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H00N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func009Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(GetUnitLevel(GetTriggerUnit()), 1) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Func009C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H00O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLevelUp_Actions takes nothing returns nothing
    if ( Trig_SLASHLevelUp_Func001C() ) then
        if ( Trig_SLASHLevelUp_Func001Func001C() ) then
            call UnitRemoveItemFromSlotSwapped(1, GetTriggerUnit())
            call UnitRemoveItemFromSlotSwapped(2, GetTriggerUnit())
            call UnitRemoveItemFromSlotSwapped(3, GetTriggerUnit())
            call UnitRemoveItemFromSlotSwapped(4, GetTriggerUnit())
            call UnitRemoveItemFromSlotSwapped(5, GetTriggerUnit())
            call UnitRemoveItemFromSlotSwapped(6, GetTriggerUnit())
            call ReplaceUnitBJ(GetTriggerUnit(), 'O00I', bj_UNIT_STATE_METHOD_RELATIVE)
            call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, 1)
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func003C() ) then
        if ( Trig_SLASHLevelUp_Func003Func001C() ) then
            call IncUnitAbilityLevelSwapped('A0PZ', GetTriggerUnit())
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func004C() ) then
        if ( Trig_SLASHLevelUp_Func004Func001C() ) then
            call IncUnitAbilityLevelSwapped('A0QP', GetTriggerUnit())
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func005C() ) then
        set udg_temp_int_slash=GetRandomInt(1, ( 2 * GetHeroLevel(GetTriggerUnit()) ))
        if ( Trig_SLASHLevelUp_Func005Func002C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_STR, GetTriggerUnit(), false) + udg_temp_int_slash ))
        else
            call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_STR, GetTriggerUnit(), false) - udg_temp_int_slash ))
        endif
        set udg_temp_int_slash=GetRandomInt(1, ( 2 * GetHeroLevel(GetTriggerUnit()) ))
        if ( Trig_SLASHLevelUp_Func005Func004C() ) then
            call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), false) + udg_temp_int_slash ))
        else
            call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), false) - udg_temp_int_slash ))
        endif
        set udg_temp_int_slash=GetRandomInt(1, ( 2 * GetHeroLevel(GetTriggerUnit()) ))
        if ( Trig_SLASHLevelUp_Func005Func006C() ) then
            call ModifyHeroStat(bj_HEROSTAT_INT, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_INT, GetTriggerUnit(), false) + udg_temp_int_slash ))
        else
            call ModifyHeroStat(bj_HEROSTAT_INT, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_INT, GetTriggerUnit(), false) - udg_temp_int_slash ))
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func006C() ) then
        if ( Trig_SLASHLevelUp_Func006Func001C() ) then
            call IncUnitAbilityLevelSwapped('A0Q8', GetTriggerUnit())
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func007C() ) then
        if ( Trig_SLASHLevelUp_Func007Func001C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_STR, GetTriggerUnit(), true) + GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), true) ))
            call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, 1)
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func008C() ) then
        if ( Trig_SLASHLevelUp_Func008Func001C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, ( 3 * GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), true) ))
            call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_AGI, GetTriggerUnit(), false) / 2 ))
        else
        endif
    else
    endif
    if ( Trig_SLASHLevelUp_Func009C() ) then
        if ( Trig_SLASHLevelUp_Func009Func001C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, GetRandomInt(( GetHeroLevel(GetTriggerUnit()) * - 2 ), ( GetHeroLevel(GetTriggerUnit()) * 10 )))
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHLevelUp takes nothing returns nothing
    set gg_trg_SLASHLevelUp=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHLevelUp, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(gg_trg_SLASHLevelUp, Condition(function Trig_SLASHLevelUp_Conditions))
    call TriggerAddAction(gg_trg_SLASHLevelUp, function Trig_SLASHLevelUp_Actions)
endfunction

//===========================================================================
// Trigger: SLASHPeriodic
//===========================================================================
function Trig_SLASHPeriodic_Func005C takes nothing returns boolean
    if ( not ( GetHeroStatBJ(bj_HEROSTAT_AGI, udg_temp_unit_slash1, true) < udg_temp_int_slash ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHPeriodic_Func006C takes nothing returns boolean
    if ( not ( GetHeroStatBJ(bj_HEROSTAT_INT, udg_temp_unit_slash1, true) < udg_temp_int_slash ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHPeriodic_Func012C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_temp_unit_slash1) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHPeriodic_Func032C takes nothing returns boolean
    if ( not ( GetHeroStatBJ(bj_HEROSTAT_STR, udg_temp_unit_slash1, false) > 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHPeriodic_Actions takes nothing returns nothing
    // SLASH: Penguin King
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('H00R')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    set udg_temp_int_slash=GetHeroStatBJ(bj_HEROSTAT_STR, udg_temp_unit_slash1, true)
    if ( Trig_SLASHPeriodic_Func005C() ) then
        set udg_temp_int_slash=GetHeroStatBJ(bj_HEROSTAT_AGI, udg_temp_unit_slash1, true)
    else
    endif
    if ( Trig_SLASHPeriodic_Func006C() ) then
        set udg_temp_int_slash=GetHeroStatBJ(bj_HEROSTAT_INT, udg_temp_unit_slash1, true)
    else
    endif
    set udg_SHeroPenPenDamage=( 1.00 + ( 0.01 * I2R(udg_temp_int_slash) ) )
    call DestroyGroup(udg_temp_group_slash)
    // SLASH: Lich King
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('H00L')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    if ( Trig_SLASHPeriodic_Func012C() ) then
        call SetUnitLifeBJ(udg_temp_unit_slash1, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_temp_unit_slash1) + ( 0.01 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_temp_unit_slash1) ) ))
    else
    endif
    call DestroyGroup(udg_temp_group_slash)
    // SLASH: Jaina
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('H01X')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    set udg_temp_int_slash2=0
    loop
        exitwhen udg_temp_int_slash2 > 11
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetUnitAbility(udg_temp_unit_slash1, 'A0QP'), ABILITY_ILF_MANA_COST, udg_temp_int_slash2, R2I(( 0.18 * GetUnitStateSwap(UNIT_STATE_MAX_MANA, udg_temp_unit_slash1) )))
        set udg_temp_int_slash2=udg_temp_int_slash2 + 1
    endloop
    call DestroyGroup(udg_temp_group_slash)
    // SLASH: Kael
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('H01Y')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    call BlzSetAbilityIntegerLevelFieldBJ(BlzGetUnitAbility(udg_temp_unit_slash1, 'A0QQ'), ABILITY_ILF_MANA_COST, 0, R2I(( 0.99 * GetUnitStateSwap(UNIT_STATE_MAX_MANA, udg_temp_unit_slash1) )))
    call DestroyGroup(udg_temp_group_slash)
    // SLASH: Lock
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('Ofar')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    call BlzSetAbilityIntegerLevelFieldBJ(BlzGetUnitAbility(udg_temp_unit_slash1, 'A0R0'), ABILITY_ILF_MANA_COST, 0, R2I(( 0.50 * GetUnitStateSwap(UNIT_STATE_MAX_MANA, udg_temp_unit_slash1) )))
    call DestroyGroup(udg_temp_group_slash)
    // SLASH: Kel'thuzad
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('U00M')
    set udg_temp_unit_slash1=GroupPickRandomUnit(udg_temp_group_slash)
    if ( Trig_SLASHPeriodic_Func032C() ) then
        call ModifyHeroStat(bj_HEROSTAT_INT, udg_temp_unit_slash1, bj_MODIFYMETHOD_SET, ( GetHeroStatBJ(bj_HEROSTAT_INT, udg_temp_unit_slash1, false) + ( GetHeroStatBJ(bj_HEROSTAT_STR, udg_temp_unit_slash1, false) - 1 ) ))
        call ModifyHeroStat(bj_HEROSTAT_STR, udg_temp_unit_slash1, bj_MODIFYMETHOD_SET, 1)
    else
    endif
    call DestroyGroup(udg_temp_group_slash)
endfunction

//===========================================================================
function InitTrig_SLASHPeriodic takes nothing returns nothing
    set gg_trg_SLASHPeriodic=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_SLASHPeriodic, 1.00)
    call TriggerAddAction(gg_trg_SLASHPeriodic, function Trig_SLASHPeriodic_Actions)
endfunction

//===========================================================================
// Trigger: on damage items
//
// SLASH: Garithos, Ancient Protector, Nazgrel, Demon Hunter, Couatl, Orc Warlord, Penguin King, Luckiest Player, Fire, Horse, Rylai, Eredar Warlock
//===========================================================================
function Trig_on_damage_items_Func004Func009C takes nothing returns boolean
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bfro') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BHbd') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bfrz') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BCbf') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BUfa') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcsi') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BHca') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcsd') == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func004Func010C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00L' ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func004Func009C() ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func004Func010C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func006Func010C takes nothing returns boolean
    if ( ( UnitHasBuffBJ(udg_DamageEventSource, 'Bams') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bfro') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BUdd') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Buhf') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcrs') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcri') == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func006Func011C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Udea' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func006Func010C() ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func006Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func008Func011C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Udre' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not ( GetUnitLifePercent(udg_DamageEventTarget) < 50.00 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func008Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func010Func011C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func010C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Edem' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not ( GetUnitLifePercent(udg_DamageEventSource) > 98.00 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func010Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func012Func011C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func012C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00O' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 4) == 1 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func012Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func014Func011C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func014C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00F' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventTarget, UNIT_TYPE_RANGED_ATTACKER) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func014Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func016Func007C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func016C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Hmkg' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func016Func007C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func017Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func017C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'N02W' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func017Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func019Func001C takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'Udea' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func019Func005Func001Func002C takes nothing returns boolean
    if ( ( IsUnitAliveBJ(GetEnumUnit()) == false ) ) then
        return true
    endif
    if ( ( GetEnumUnit() == udg_DamageEventTarget ) ) then
        return true
    endif
    if ( ( IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(udg_DamageEventTarget)) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func019Func005Func001C takes nothing returns boolean
    if ( not Trig_on_damage_items_Func019Func005Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func019Func005A takes nothing returns nothing
    if ( Trig_on_damage_items_Func019Func005Func001C() ) then
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_temp_group_slash)
    else
    endif
endfunction

function Trig_on_damage_items_Func019Func006A takes nothing returns nothing
    call AddSpecialEffectTargetUnitBJ("origin", GetEnumUnit(), "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call SetUnitLifeBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) + ( udg_DamageEventAmount / I2R(CountUnitsInGroup(udg_temp_group_slash)) ) ))
endfunction

function Trig_on_damage_items_Func019C takes nothing returns boolean
    if ( not Trig_on_damage_items_Func019Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func021C takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'Npbm' ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func023Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 255) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func023C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00P' ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func025Func003C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource) <= udg_temp_real_hp ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func025Func007C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func025C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H01L' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func025Func007C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func027Func001Func001Func002C takes nothing returns boolean
    if ( not ( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func027Func001Func001C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_RunedTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func027Func001C takes nothing returns boolean
    if ( not ( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] < 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func027Func003C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func027C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'mlst') == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func027Func003C() ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func028Func001Func001Func002C takes nothing returns boolean
    if ( not ( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func028Func001Func001C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_RunedTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func028Func001C takes nothing returns boolean
    if ( not ( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] < 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func028Func003C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func028C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I04D') == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func028Func003C() ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func030Func002Func008002003001 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) == Player(20) )
endfunction

function Trig_on_damage_items_Func030Func002Func008002003002001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_on_damage_items_Func030Func002Func008002003002002 takes nothing returns boolean
    return ( BlzIsUnitInvulnerable(GetFilterUnit()) == false )
endfunction

function Trig_on_damage_items_Func030Func002Func008002003002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (BlzIsUnitInvulnerable(GetFilterUnit()) == false)) // INLINED!!
endfunction

function Trig_on_damage_items_Func030Func002Func008002003 takes nothing returns boolean
    return GetBooleanAnd((GetOwningPlayer(GetFilterUnit()) == Player(20)), (GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (BlzIsUnitInvulnerable(GetFilterUnit()) == false)))) // INLINED!!
endfunction

function Trig_on_damage_items_Func030Func002C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_FireTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]) == 0.00 ) ) then
        return false
    endif
    if ( not ( udg_chance <= udg_firehand_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func030Func004C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func030C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventSource, 'frhg')) == 'frhg' ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func030Func004C() ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func031C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h01O' ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func033Func001C takes nothing returns boolean
    if ( not ( ( udg_DamageEventAmount - I2R(GetHeroLevel(udg_DamageEventTarget)) ) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func033C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'I04K') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func035C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B00A') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func037C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'I04J') == true ) ) then
        return false
    endif
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) < ( 0.50 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func039Func003C takes nothing returns boolean
    if ( not ( BlzIsUnitInvulnerable(udg_DamageEventSource) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func039C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventTarget, 'arsh')) == 'arsh' ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B00L') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func041C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventTarget, 'mcou')) == 'mcou' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func043Func003C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func043C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'glsk') == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func043Func003C() ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( BlzGetUnitArmor(udg_DamageEventSource) >= 25.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func045Func009C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func045C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventSource, 'shcw')) == 'shcw' ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( GetUnitLifePercent(udg_DamageEventSource) < 50.00 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func045Func009C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func047C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventTarget, 'shen')) == 'shen' ) ) then
        return false
    endif
    if ( not ( udg_IsDamageRanged == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventTarget) == false ) ) then
        return false
    endif
    if ( not ( DistanceBetweenPoints(GetUnitLoc(udg_DamageEventTarget), GetUnitLoc(udg_DamageEventSource)) >= 300.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func049Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0JL') == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func049Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func049C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'rugt') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func049Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func051Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( CountLivingPlayerUnitsOfTypeId('h00C', GetOwningPlayer(udg_DamageEventSource)) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func051Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] != 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func051Func001Func001C takes nothing returns boolean
    if ( not ( udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func051Func001C takes nothing returns boolean
    if ( not ( udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func051Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func051C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I028') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func051Func005C() ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0NN') == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func053Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func053C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I02A') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0JK') == 0.00 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func053Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func054Func004C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func054C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I01P') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func054Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func056Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func056C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I04I') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0PM') == 0.00 ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func056Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func058Func012C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func058C takes nothing returns boolean
    if ( not ( udg_item_35[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] > 0 ) ) then
        return false
    endif
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventSource, 'I02B')) == 'I02B' ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func058Func012C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func061Func002C takes nothing returns boolean
    if ( not ( udg_javelin_counter[udg_temp_int] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func061Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func061C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I02D') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func061Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func063Func008C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func063C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I03O') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func063Func008C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func065Func001C takes nothing returns boolean
    if ( not ( GetUnitManaPercent(udg_DamageEventSource) < 50.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func065Func004C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func065C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I04X') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func065Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func067Func002C takes nothing returns boolean
    if ( not ( udg_chance <= udg_infinityclaws_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func067Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func067C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I02M') == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func067Func006C() ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0K9') == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func069Func002Func007C takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func069Func002C takes nothing returns boolean
    if ( not ( udg_chance <= udg_orboflightning_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func069Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func069C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I03Q') == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func069Func005C() ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0KA') == 0.00 ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func071Func009C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func071C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I02P') == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func071Func009C() ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( UnitHasBuffBJ(udg_DamageEventSource, 'B00K') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func073Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func073C takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func073Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func075Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func075C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H01B' ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func075Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func077Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'N02X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func077Func002C takes nothing returns boolean
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'N02X' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_DamageEventTarget) == 'N02X' ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func077Func004Func001Func002C takes nothing returns boolean
    if ( ( GetOwningPlayer(GetEnumUnit()) != Player(20) ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func077Func004Func001C takes nothing returns boolean
    if ( not Trig_on_damage_items_Func077Func004Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func077Func004A takes nothing returns nothing
    if ( Trig_on_damage_items_Func077Func004Func001C() ) then
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_temp_group_slash)
    else
    endif
endfunction

function Trig_on_damage_items_Func077Func005Func001A takes nothing returns nothing
    set udg_DamageEventAmount=( udg_DamageEventAmount * 1.05 )
    set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + 4.00 )
endfunction

function Trig_on_damage_items_Func077Func005Func002A takes nothing returns nothing
    set udg_DamageEventAmount=( udg_DamageEventAmount * 0.95 )
endfunction

function Trig_on_damage_items_Func077Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'N02X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func077C takes nothing returns boolean
    if ( not Trig_on_damage_items_Func077Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func079Func003Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_SUMMONED) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func079Func003A takes nothing returns nothing
    if ( Trig_on_damage_items_Func079Func003Func001C() ) then
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_temp_group_slash)
    else
    endif
endfunction

function Trig_on_damage_items_Func079Func004A takes nothing returns nothing
    set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + 1.00 )
endfunction

function Trig_on_damage_items_Func079C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Nbst' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func081C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'N02V' ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func083Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func083C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'E00A' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func083Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func085Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func085C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'E00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func085Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func087Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0PU') > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func087Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func087C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Otch' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func087Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func089Func006C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func089C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Obla' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func089Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func091C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_temp_Unit, 'I047') == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h01C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func093C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_temp_Unit, 'I02Q') == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_temp_Unit ) ) then
        return false
    endif
    if ( not ( IsUnitIdType(GetUnitTypeId(udg_DamageEventSource), UNIT_TYPE_HERO) == false ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( BlzIsUnitInvulnerable(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) * 0.02 ) >= 1.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func095C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'I03U') == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventAmount > ( 0.02 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func097C takes nothing returns boolean
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func099C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I04D') == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func101C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H020' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func103Func003C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource) <= udg_temp_real_hp ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func103C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'U00H' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func105C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00D' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func107C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'Ekee' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func109C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'U00N' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func111C takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func113C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'H00R' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != Player(20) ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func115C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'Edem' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventTarget) != Player(20) ) ) then
        return false
    endif
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) == GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func117Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'U00M' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventTarget) != Player(20) ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func117Func002C takes nothing returns boolean
    if ( not ( udg_DamageEventAmount > GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventTarget) ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func117C takes nothing returns boolean
    if ( not Trig_on_damage_items_Func117Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func119C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B00Q') == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func120C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B00R') == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func122C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventTarget, 'I019')) == 'I019' ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != udg_DamageEventTarget ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func124Func005C takes nothing returns boolean
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcsi') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'BHca') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bcsd') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bfrz') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_DamageEventTarget, 'Bfro') == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_on_damage_items_Func124C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_temp_Unit, 'I02R') == true ) ) then
        return false
    endif
    if ( not Trig_on_damage_items_Func124Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func126Func002002003001 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) == Player(20) )
endfunction

function Trig_on_damage_items_Func126Func002002003002001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_on_damage_items_Func126Func002002003002002001 takes nothing returns boolean
    return ( BlzIsUnitInvulnerable(GetFilterUnit()) != true )
endfunction

function Trig_on_damage_items_Func126Func002002003002002002 takes nothing returns boolean
    return ( GetFilterUnit() != udg_DamageEventTarget )
endfunction

function Trig_on_damage_items_Func126Func002002003002002 takes nothing returns boolean
    return GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) != true), (GetFilterUnit() != udg_DamageEventTarget)) // INLINED!!
endfunction

function Trig_on_damage_items_Func126Func002002003002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) != true), (GetFilterUnit() != udg_DamageEventTarget)))) // INLINED!!
endfunction

function Trig_on_damage_items_Func126Func002002003 takes nothing returns boolean
    return GetBooleanAnd((GetOwningPlayer(GetFilterUnit()) == Player(20)), (GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) != true), (GetFilterUnit() != udg_DamageEventTarget)))))) // INLINED!!
endfunction

function Trig_on_damage_items_Func126Func003C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(udg_temp_UnitGroup) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func126Func007001 takes nothing returns boolean
    return ( udg_IsDamageMelee == true )
endfunction

function Trig_on_damage_items_Func126Func007002 takes nothing returns boolean
    return ( udg_IsDamageRanged == true )
endfunction

function Trig_on_damage_items_Func126C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I022') == true ) ) then
        return false
    endif
    if ( not GetBooleanOr((udg_IsDamageMelee == true), (udg_IsDamageRanged == true)) ) then // INLINED!!
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Func127C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_damage_items_Actions takes nothing returns nothing
    set udg_temp_Unit=udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]
    set udg_X=( GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)) * 10 )
    // SLASH: LK
    if ( Trig_on_damage_items_Func004C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_3198", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: DK
    if ( Trig_on_damage_items_Func006C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_3196", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: Dread
    if ( Trig_on_damage_items_Func008C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_2971", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: DH
    if ( Trig_on_damage_items_Func010C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_3650", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: Pig
    if ( Trig_on_damage_items_Func012C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_2811", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: Lieutenant
    if ( Trig_on_damage_items_Func014C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagUnitBJ("TRIGSTR_556", udg_DamageEventTarget, 0, 8.00, 100, 100, 100, 0)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.66)
    else
    endif
    // SLASH: Nazgrel
    if ( Trig_on_damage_items_Func016C() ) then
        call AdjustPlayerStateBJ(udg_time_day, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
        set udg_DamageEventAmount=( udg_DamageEventAmount + I2R(( GetPlayerState(GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD) / 5 )) )
    else
    endif
    if ( Trig_on_damage_items_Func017C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * I2R(( GetPlayerState(GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER) * 1 )) )
    else
    endif
    // SLASH: DK
    if ( Trig_on_damage_items_Func019C() ) then
        set udg_temp_loc_slash3=GetUnitLoc(udg_DamageEventTarget)
        set udg_temp_real_hp=udg_DamageEventAmount
        set udg_temp_group_slash=GetUnitsInRangeOfLocAll(360.00, udg_temp_loc_slash3)
        call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func019Func005A)
        call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func019Func006A)
        call DestroyGroup(udg_temp_group_slash)
        call RemoveLocation(udg_temp_loc_slash3)
    else
    endif
    // SLASH: Horse
    if ( Trig_on_damage_items_Func021C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * ( 1.00 - ( ( ( GetUnitMoveSpeed(udg_DamageEventSource) / GetUnitDefaultMoveSpeed(udg_DamageEventSource) ) - 1.00 ) / 2.00 ) ) )
    else
    endif
    // SLASH: Luckiest
    if ( Trig_on_damage_items_Func023C() ) then
        if ( Trig_on_damage_items_Func023Func001C() ) then
            set udg_DamageEventAmount=( udg_DamageEventAmount * 10.00 )
            call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventTarget, "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call CreateTextTagUnitBJ("TRIGSTR_7832", udg_DamageEventTarget, 0, 10, 100, 100, 100, 0)
            call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
            call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
            call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        else
        endif
    else
    endif
    // SLASH: Orc Warlord
    if ( Trig_on_damage_items_Func025C() ) then
        set udg_temp_real_hp=( 0.05 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventSource) )
        set udg_DamageEventAmount=( udg_DamageEventAmount + udg_temp_real_hp )
        if ( Trig_on_damage_items_Func025Func003C() ) then
            call SetUnitLifeBJ(udg_DamageEventSource, 1.00)
        else
            call SetUnitLifeBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource) - udg_temp_real_hp ))
        endif
    else
    endif
    // Runed Gauntlets----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func027C() ) then
        if ( Trig_on_damage_items_Func027Func001C() ) then
            set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
        else
            if ( Trig_on_damage_items_Func027Func001Func001C() ) then
                if ( Trig_on_damage_items_Func027Func001Func001Func002C() ) then
                    set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
                    call AddSpecialEffectTargetUnitBJ("weapon", udg_DamageEventSource, "Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
                    set udg_item_6_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=GetLastCreatedEffectBJ()
                else
                    call StartTimerBJ(udg_RunedTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], false, 1.50)
                    call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, ( I2R(BlzGetUnitBaseDamage(udg_DamageEventSource, 0)) * 1.00 ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
                    call DestroyEffectBJ(udg_item_6_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
                    call AddSpecialEffectTargetUnitBJ("chest", udg_DamageEventTarget, "Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    call AddSpecialEffectTargetUnitBJ("chest", udg_DamageEventSource, "Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
                endif
            else
            endif
        endif
    else
    endif
    if ( Trig_on_damage_items_Func028C() ) then
        if ( Trig_on_damage_items_Func028Func001C() ) then
            set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
        else
            if ( Trig_on_damage_items_Func028Func001Func001C() ) then
                if ( Trig_on_damage_items_Func028Func001Func001Func002C() ) then
                    set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
                    call AddSpecialEffectTargetUnitBJ("weapon", udg_DamageEventSource, "Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
                    set udg_item_6_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=GetLastCreatedEffectBJ()
                else
                    call StartTimerBJ(udg_RunedTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], false, 1.50)
                    call UnitDamagePointLoc(udg_DamageEventSource, 0, 500, GetUnitLoc(GetTriggerUnit()), ( I2R(BlzGetUnitBaseDamage(udg_DamageEventSource, 0)) * 0.50 ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
                    call DestroyEffectBJ(udg_item_6_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
                    call AddSpecialEffectTargetUnitBJ("chest", udg_DamageEventTarget, "Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    call AddSpecialEffectTargetUnitBJ("chest", udg_DamageEventSource, "Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
                endif
            else
            endif
        endif
    else
    endif
    // Firehand Gauntlets-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func030C() ) then
        set udg_chance=GetRandomInt(1, 100)
        if ( Trig_on_damage_items_Func030Func002C() ) then
            call StartTimerBJ(udg_FireTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], false, 1.00)
            set udg_firehand_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
            set udg_TP=GetUnitLoc(udg_DamageEventSource)
            call CreateNUnitsAtLoc(1, 'h01O', GetOwningPlayer(udg_DamageEventSource), udg_TP, bj_UNIT_FACING)
            call RemoveLocation(udg_TP)
            call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
            set udg_TP=GetUnitLoc(udg_DamageEventTarget)
            set udg_temp_UnitGroup=GetUnitsInRangeOfLocMatching(750.00, udg_TP, Condition(function Trig_on_damage_items_Func030Func002Func008002003))
            call IssueTargetOrderBJ(GetLastCreatedUnit(), "attackonce", GroupPickRandomUnit(udg_temp_UnitGroup))
            call RemoveLocation(udg_TP)
            call DestroyGroup(udg_temp_UnitGroup)
        else
            set udg_firehand_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_firehand_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 6 )
        endif
    else
    endif
    if ( Trig_on_damage_items_Func031C() ) then
        set udg_DamageEventAmount=0.01
        call UnitDamageTargetBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], udg_DamageEventTarget, 200.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE)
    else
    endif
    // Lamellar Plating
    if ( Trig_on_damage_items_Func033C() ) then
        if ( Trig_on_damage_items_Func033Func001C() ) then
            set udg_DamageEventAmount=( udg_DamageEventAmount - I2R(GetHeroLevel(udg_DamageEventTarget)) )
        else
            set udg_DamageEventAmount=0.00
        endif
    else
    endif
    // NICK: Shield of Honor----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func035C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.65 )
    else
    endif
    // Guardian's Blessing
    if ( Trig_on_damage_items_Func037C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.75 )
    else
    endif
    // Spiked Shield------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func039C() ) then
        call DisableTrigger(GetTriggeringTrigger())
        set udg_DamageEventTrigger=GetTriggeringTrigger()
        if ( Trig_on_damage_items_Func039Func003C() ) then
            call UnitDamageTargetBJ(udg_DamageEventTarget, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], ( udg_DamageEventAmount * 1.00 ), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
        else
            call UnitDamageTargetBJ(udg_DamageEventTarget, udg_DamageEventSource, ( udg_DamageEventAmount * 1.00 ), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
        endif
        call EnableTrigger(GetTriggeringTrigger())
    else
    endif
    // Medalion of Courage------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func041C() ) then
        call SetUnitManaBJ(udg_DamageEventTarget, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventTarget) + 20.00 ))
    else
    endif
    // Skull of Guldan----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func043C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * ( 1 + ( 0.15 * I2R(( R2I(BlzGetUnitArmor(udg_DamageEventSource)) / 25 )) ) ) )
    else
    endif
    // Berserker Spear----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func045C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount + ( udg_DamageEventAmount * 1.00 ) )
        call AddSpecialEffectTargetUnitBJ("hand,left", udg_temp_Unit, "Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSLeft.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("hand.right", udg_temp_Unit, "Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSLeft.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
    // Enchanted Shield---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func047C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.50 )
        call AddSpecialEffectTargetUnitBJ("head", udg_DamageEventTarget, "Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
    // Storm Hammer-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func049C() ) then
        if ( Trig_on_damage_items_Func049Func001C() ) then
            call DestroyEffectBJ(udg_stormhammer_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
            call AddSpecialEffectLocBJ(GetUnitLoc(udg_DamageEventTarget), "Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call UnitDamagePointLoc(udg_DamageEventSource, 0, 200.00, GetUnitLoc(GetTriggerUnit()), ( I2R(BlzGetUnitBaseDamage(udg_DamageEventSource, 0)) * 0.20 ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
        else
        endif
        call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0JL', 0.00)
        set udg_stormhammer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
    else
    endif
    // Searing Blade------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func051C() ) then
        if ( Trig_on_damage_items_Func051Func001C() ) then
            call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0NN', 1.00)
            call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, ( 10.00 * I2R(GetHeroStatBJ(bj_HEROSTAT_AGI, udg_DamageEventSource, true)) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
            call AddSpecialEffectTargetUnitBJ("overhead", udg_DamageEventTarget, "Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
        else
            if ( Trig_on_damage_items_Func051Func001Func001C() ) then
                call CreateNUnitsAtLoc(1, 'h00C', GetOwningPlayer(udg_DamageEventSource), PolarProjectionBJ(GetUnitLoc(udg_DamageEventSource), GetRandomReal(200.00, 500.00), GetRandomDirectionDeg()), bj_UNIT_FACING)
                call UnitApplyTimedLifeBJ(3.00, 'BTLF', GetLastCreatedUnit())
                set udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=GetLastCreatedUnit()
                set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=3
                call TriggerRegisterUnitInRangeSimple(gg_trg_Searing_Blade_aura_taken, 100.00, GetLastCreatedUnit())
            else
                if ( Trig_on_damage_items_Func051Func001Func001Func001C() ) then
                    set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
                else
                    if ( Trig_on_damage_items_Func051Func001Func001Func001Func001C() ) then
                        set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=1
                    else
                    endif
                endif
            endif
        endif
    else
    endif
    // Gladiator Axe------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func053C() ) then
        call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0JK', 4.00)
        call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, ( I2R(BlzGetUnitBaseDamage(udg_DamageEventSource, 0)) * ( I2R(GetHeroLevel(GetTriggerUnit())) * 0.20 ) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
    else
    endif
    if ( Trig_on_damage_items_Func054C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * GetRandomReal(0.01, 7.00) )
    else
    endif
    // Illithuvia
    if ( Trig_on_damage_items_Func056C() ) then
        call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0PM', 1.50)
        set udg_DamageEventAmount=( udg_DamageEventAmount + ( 0.05 * ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) - GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) ) ) )
    else
    endif
    // Wand of Sorcery----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func058C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount + 1000.00 )
        call DestroyEffectBJ(udg_item_35_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
        call CreateTextTagLocBJ(( "|cff005dff1000!" ), GetUnitLoc(udg_DamageEventTarget), 0, 10.50, 100.00, 100.00, 50.00, 10.00)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 35.00, 90)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 2.00)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 3.00)
        set udg_item_35[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
    else
    endif
    // Lightning Javelin--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    set udg_temp_int=GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))
    if ( Trig_on_damage_items_Func061C() ) then
        set udg_javelin_counter[udg_temp_int]=( udg_javelin_counter[udg_temp_int] + 1 )
        if ( Trig_on_damage_items_Func061Func002C() ) then
            set udg_javelin_counter[udg_temp_int]=0
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=7
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                set udg_TP=GetUnitLoc(udg_DamageEventTarget)
                set udg_temp_Point=PolarProjectionBJ(udg_TP, 800.00, GetRandomDirectionDeg())
                call CreateNUnitsAtLocFacingLocBJ(1, 'h01D', ConvertedPlayer(udg_temp_int), udg_temp_Point, udg_TP)
                call RemoveLocation(udg_TP)
                call RemoveLocation(udg_temp_Point)
                call GroupAddUnitSimple(GetLastCreatedUnit(), udg_move_projectiles_group)
                call UnitApplyTimedLifeBJ(7.00, 'BTLF', GetLastCreatedUnit())
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
    else
    endif
    // NICK: Claws of Frenzy----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func063C() ) then
        set udg_temp_item=GetItemOfTypeFromUnitBJ(udg_temp_Unit, 'I03O')
        set udg_Frenzy[udg_X]=( udg_Frenzy[udg_X] + 1 )
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(udg_temp_item, 0), ABILITY_ILF_ATTACK_BONUS, 0, ( udg_Frenzy[udg_X] * 9 ))
        call StartTimerBJ(udg_NickClawsofFrenzyTimer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], false, 3.00)
    else
    endif
    // NICK: Magic Icon---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func065C() ) then
        if ( Trig_on_damage_items_Func065Func001C() ) then
            set udg_DamageEventAmount=( udg_DamageEventAmount + ( I2R(GetHeroStatBJ(bj_HEROSTAT_INT, udg_DamageEventSource, true)) * 3.50 ) )
            call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventTarget, "Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
        endif
    else
    endif
    // Infinity Claws-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func067C() ) then
        set udg_chance=GetRandomInt(1, 100)
        if ( Trig_on_damage_items_Func067Func002C() ) then
            set udg_infinityclaws_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=2
            call UnitResetCooldown(udg_DamageEventSource)
            call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0K9', 27.00)
            call AddSpecialEffectLocBJ(GetUnitLoc(udg_DamageEventSource), "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
            set udg_infinityclaws_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_infinityclaws_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 1 )
        endif
    else
    endif
    // Orb of Lightning---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func069C() ) then
        set udg_chance=GetRandomInt(1, 100)
        if ( Trig_on_damage_items_Func069Func002C() ) then
            set udg_orboflightning_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=10
            call CreateNUnitsAtLoc(1, 'h000', GetOwningPlayer(udg_DamageEventSource), GetUnitLoc(udg_DamageEventTarget), bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(3.00, 'BTLF', GetLastCreatedUnit())
            call UnitAddAbilityBJ('AIpg', GetLastCreatedUnit())
            call IssueTargetOrderBJ(GetLastCreatedUnit(), "purge", udg_DamageEventTarget)
            if ( Trig_on_damage_items_Func069Func002Func007C() ) then
                call BlzStartUnitAbilityCooldown(udg_DamageEventSource, 'A0KA', 1.00)
            else
            endif
        else
            set udg_orboflightning_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=( udg_orboflightning_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + 8 )
        endif
    else
    endif
    // Sundering Blade----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func071C() ) then
        set udg_DamageEventArmorPierced=BlzGetUnitArmor(udg_DamageEventTarget)
        call CreateTextTagLocBJ(( "|cffff0000" + ( I2S(R2I(udg_DamageEventAmount)) + "!" ) ), GetUnitLoc(udg_DamageEventTarget), GetRandomReal(0, 120.00), 10.00, 50.00, 50.00, 50.00, 0.00)
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 35.00, 90)
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 2.00)
    else
    endif
    // SLASH: Tome
    if ( Trig_on_damage_items_Func073C() ) then
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + udg_SHeroItemArP[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] )
    else
    endif
    // SLASH: Duck
    if ( Trig_on_damage_items_Func075C() ) then
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + ( 5.00 * I2R(udg_SHeroDuckCheeses) ) )
    else
    endif
    // SLASH: Spartan
    if ( Trig_on_damage_items_Func077C() ) then
        if ( Trig_on_damage_items_Func077Func001C() ) then
            set udg_temp_loc_slash3=GetUnitLoc(udg_DamageEventTarget)
        else
            set udg_temp_loc_slash3=GetUnitLoc(udg_DamageEventSource)
        endif
        set udg_temp_group_slash=GetUnitsInRangeOfLocAll(256.00, udg_temp_loc_slash3)
        call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func077Func004A)
        if ( Trig_on_damage_items_Func077Func005C() ) then
            call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func077Func005Func002A)
        else
            call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func077Func005Func001A)
        endif
        call DestroyGroup(udg_temp_group_slash)
        call RemoveLocation(udg_temp_loc_slash3)
    else
    endif
    // SLASH: Beast
    if ( Trig_on_damage_items_Func079C() ) then
        set udg_temp_group_slash=GetUnitsOfPlayerAll(GetOwningPlayer(udg_DamageEventSource))
        call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func079Func003A)
        call ForGroupBJ(udg_temp_group_slash, function Trig_on_damage_items_Func079Func004A)
        call DestroyGroup(udg_temp_group_slash)
    else
    endif
    // SLASH: Fire
    if ( Trig_on_damage_items_Func081C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * ( 1.00 + ( ( ( GetUnitMoveSpeed(udg_DamageEventSource) / GetUnitDefaultMoveSpeed(udg_DamageEventSource) ) - 1.00 ) / 2.00 ) ) )
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced * ( BlzGetUnitArmor(udg_DamageEventTarget) * ( ( ( GetUnitMoveSpeed(udg_DamageEventSource) / GetUnitDefaultMoveSpeed(udg_DamageEventSource) ) - 1.00 ) / 2.00 ) ) )
    else
    endif
    // SLASH: Dancer
    if ( Trig_on_damage_items_Func083C() ) then
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(( udg_SHeroDancerCount * 4 )) )
    else
    endif
    // SLASH: Warden
    if ( Trig_on_damage_items_Func085C() ) then
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(( GetHeroStatBJ(bj_HEROSTAT_INT, udg_DamageEventSource, true) / 12 )) )
    else
    endif
    // SLASH: TC
    if ( Trig_on_damage_items_Func087C() ) then
        if ( Trig_on_damage_items_Func087Func001C() ) then
            set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(( GetHeroLevel(udg_DamageEventSource) * R2I(( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventSource, 'A0PU') / 180.00 )) )) )
        else
            set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(GetHeroLevel(udg_DamageEventSource)) )
        endif
    else
    endif
    // SLASH: Blade
    if ( Trig_on_damage_items_Func089C() ) then
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(udg_SHeroBladeClaws1) )
        set udg_DamageEventArmorPierced=( udg_DamageEventArmorPierced + I2R(( udg_SHeroBladeClaws2 * 4 )) )
    else
    endif
    // Power Staff--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func091C() ) then
        set udg_DamageEventAmount=0.50
        call AddSpecialEffectTargetUnitBJ("overhead", udg_DamageEventTarget, "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call UnitDamageTargetBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], udg_DamageEventTarget, 1000.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
    else
    endif
    // Blue Flag----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func093C() ) then
        call UnitDamageTargetBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], udg_DamageEventTarget, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) * 0.02 ), ATTACK_TYPE_MELEE, DAMAGE_TYPE_UNKNOWN)
    else
    endif
    // Demonic Blade------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func095C() ) then
        call SetUnitAbilityLevelSwapped('A0LJ', udg_DamageEventTarget, 2)
    else
    endif
    // Reward Spell Dmg
    if ( Trig_on_damage_items_Func097C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount + udg_reward_spelldmg[( udg_X + 2 )] )
    else
    endif
    // Sol
    if ( Trig_on_damage_items_Func099C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount + 25.00 )
    else
    endif
    // SLASH: Rylai
    if ( Trig_on_damage_items_Func101C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount + I2R(udg_SHeroRylaiInt) )
    else
    endif
    // SLASH: Eredar Warlock
    if ( Trig_on_damage_items_Func103C() ) then
        set udg_temp_real_hp=( 0.05 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventSource) )
        set udg_DamageEventAmount=( udg_DamageEventAmount + udg_temp_real_hp )
        if ( Trig_on_damage_items_Func103Func003C() ) then
            call SetUnitLifeBJ(udg_DamageEventSource, 1.00)
        else
            call SetUnitLifeBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource) - udg_temp_real_hp ))
        endif
    else
    endif
    // SLASH: Garithos
    if ( Trig_on_damage_items_Func105C() ) then
        set udg_SLASHSpellFactor=( 0.05 * BlzGetUnitArmor(udg_DamageEventSource) )
    else
    endif
    // SLASH: Ancient Protector
    if ( Trig_on_damage_items_Func107C() ) then
        set udg_SLASHSpellFactor=( 0.05 * I2R(udg_SHeroAncientOrbs) )
    else
    endif
    // SLASH: Medivh
    if ( Trig_on_damage_items_Func109C() ) then
        set udg_SLASHSpellFactor=( 0.10 * I2R(( BlzGetUnitMaxMana(udg_DamageEventSource) / 300 )) )
    else
    endif
    // ----------------------------------------------------------Spell Damage Multiplier----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func111C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * ( udg_spelldamage[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] + udg_SLASHSpellFactor ) )
    else
    endif
    // SLASH: Penguin
    if ( Trig_on_damage_items_Func113C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * udg_SHeroPenPenDamage )
    else
    endif
    // SLASH: Demon Hunter
    if ( Trig_on_damage_items_Func115C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.10 )
    else
    endif
    // SLASH: KT
    if ( Trig_on_damage_items_Func117C() ) then
        if ( Trig_on_damage_items_Func117Func002C() ) then
            call SetUnitLifeBJ(udg_DamageEventTarget, 0.00)
        else
            call SetUnitManaBJ(udg_DamageEventTarget, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventTarget) - udg_DamageEventAmount ))
            set udg_DamageEventAmount=0.00
        endif
    else
    endif
    // SLASH: Buffs
    if ( Trig_on_damage_items_Func119C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.10 )
    else
    endif
    if ( Trig_on_damage_items_Func120C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.10 )
    else
    endif
    // Necklace of Spell Immunity-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func122C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 0.30 )
    else
    endif
    // Cloak of Frost-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func124C() ) then
        set udg_DamageEventAmount=( udg_DamageEventAmount * 3.00 )
        call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventTarget, "Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
    // Moon Glaive--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_damage_items_Func126C() ) then
        set udg_TP=GetUnitLoc(udg_DamageEventTarget)
        set udg_temp_UnitGroup=GetUnitsInRangeOfLocMatching(350.00, udg_TP, Condition(function Trig_on_damage_items_Func126Func002002003))
        if ( Trig_on_damage_items_Func126Func003C() ) then
            call CreateNUnitsAtLoc(1, 'h009', GetOwningPlayer(udg_DamageEventSource), udg_TP, bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
            call IssueTargetOrderBJ(GetLastCreatedUnit(), "attackonce", GroupPickRandomUnit(udg_temp_UnitGroup))
            call SetUnitUserData(GetLastCreatedUnit(), R2I(( udg_DamageEventAmount * 0.90 )))
        else
        endif
        call RemoveLocation(udg_TP)
        call DestroyGroup(udg_temp_UnitGroup)
    else
    endif
    if ( Trig_on_damage_items_Func127C() ) then
        set udg_DamageEventAmount=I2R(GetUnitUserData(udg_DamageEventSource))
    else
    endif
endfunction

//===========================================================================
function InitTrig_on_damage_items takes nothing returns nothing
    set gg_trg_on_damage_items=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_on_damage_items, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddAction(gg_trg_on_damage_items, function Trig_on_damage_items_Actions)
endfunction

//===========================================================================
// Trigger: on summon items
//
// SLASH: Beastmaster, Thrall, Bone Collector
//===========================================================================
function Trig_on_summon_items_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) != Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitIdType(GetUnitTypeId(GetTriggerUnit()), UNIT_TYPE_HERO) == false ) ) then
        return false
    endif
    if ( not ( BlzIsUnitInvulnerable(GetTriggerUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func002C takes nothing returns boolean
    if ( not ( IsUnitIllusionBJ(GetTriggerUnit()) == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetTriggerUnit()) == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) != 'nlur' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == 'H01Y' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h01Z' ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetTriggerUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == 'Nbst' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == 'U00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func009C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'I03J') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func010C takes nothing returns boolean
    if ( not ( udg_reward_upsummons[( udg_X + 2 )] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func011C takes nothing returns boolean
    if ( not ( udg_reward_upsummons[( udg_X + 1 )] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func012C takes nothing returns boolean
    if ( not ( udg_reward_upsummons[( udg_X + 3 )] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func017Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], GetForLoopIndexA())) == 'war2' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func017C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'war2') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func019Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], GetForLoopIndexA())) == 'sehr' ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func019C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'sehr') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func021C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'btst') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func023C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'I04G') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func025C takes nothing returns boolean
    if ( not ( udg_KeyOfBalance == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetTriggerUnit()) == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'I04F') == true ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'A0PL') == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func028C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'I017') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func030C takes nothing returns boolean
    if ( not ( udg_current_wave > 50 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func033Func002C takes nothing returns boolean
    if ( not ( udg_chance == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func033C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'rots') == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) != 'nlur' ) ) then
        return false
    endif
    if ( not ( GetUnitUserData(GetTriggerUnit()) != 69 ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetTriggerUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func035Func003C takes nothing returns boolean
    if ( not ( udg_chance == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Func035C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == 'Nngs' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) != 'nlur' ) ) then
        return false
    endif
    if ( not ( GetUnitUserData(GetTriggerUnit()) != 67 ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetTriggerUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_on_summon_items_Actions takes nothing returns nothing
    set udg_X=( GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit())) * 10 )
    if ( Trig_on_summon_items_Func002C() ) then
        call UnitAddAbilityBJ('A0QH', GetTriggerUnit())
    else
    endif
    // SLASH: Kael
    if ( Trig_on_summon_items_Func004C() ) then
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxMana(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) / 3 ))
        call BlzSetUnitBaseDamage(GetTriggerUnit(), BlzGetUnitMaxHP(GetTriggerUnit()), 0)
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, ( - 0.02 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) ))
    else
    endif
    // SLASH: Beastmaster
    if ( Trig_on_summon_items_Func006C() ) then
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + ( 5 * GetHeroStatBJ(bj_HEROSTAT_STR, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], true) ) ))
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + I2R(( GetHeroStatBJ(bj_HEROSTAT_AGI, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], true) / 20 )) ))
    else
    endif
    if ( Trig_on_summon_items_Func007C() ) then
        call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + ( GetHeroStatBJ(bj_HEROSTAT_INT, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], true) / 5 ) ), 0)
    else
    endif
    // Horn of Doom-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func009C() ) then
        call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + 200 ), 0)
        call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 1) + 200 ), 1)
    else
    endif
    if ( Trig_on_summon_items_Func010C() ) then
        call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 0) + ( udg_reward_upsummons[( udg_X + 2 )] * 10 ) ), 0)
        call BlzSetUnitBaseDamage(GetTriggerUnit(), ( BlzGetUnitBaseDamage(GetTriggerUnit(), 1) + ( udg_reward_upsummons[( udg_X + 2 )] * 10 ) ), 1)
    else
    endif
    if ( Trig_on_summon_items_Func011C() ) then
        set udg_temp_num=( 100 + udg_reward_upsummons[( udg_X + 1 )] )
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * ( I2R(udg_temp_num) / 100.00 ) )), 0)
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * ( I2R(udg_temp_num) / 100.00 ) )), 1)
    else
    endif
    if ( Trig_on_summon_items_Func012C() ) then
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + ( udg_reward_upsummons[( udg_X + 3 )] * 150 ) ))
        call SetUnitLifePercentBJ(GetTriggerUnit(), 100)
    else
    endif
    // Warsong Battledrums------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func017C() ) then
        set udg_temp_real=1.00
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=6
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_on_summon_items_Func017Func002Func001C() ) then
                set udg_temp_real=( udg_temp_real + 1.00 )
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * udg_temp_real )), 0)
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * udg_temp_real )), 1)
    else
    endif
    // Heart of Searinox--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func019C() ) then
        set udg_temp_real=1.00
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=6
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_on_summon_items_Func019Func002Func001C() ) then
                set udg_temp_real=( udg_temp_real + 1.00 )
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        call BlzSetUnitMaxHP(GetTriggerUnit(), R2I(( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * udg_temp_real )))
        call SetUnitLifePercentBJ(GetTriggerUnit(), 100)
    else
    endif
    // Battle Standard----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func021C() ) then
        call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) * 0.75 ), ( 0 + 0 ))
        call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 1) * 0.75 ), 1)
        call UnitAddAbilityBJ('A0MN', GetTriggerUnit())
    else
    endif
    // Frozen Crown
    if ( Trig_on_summon_items_Func023C() ) then
        call UnitAddAbilityBJ('Afra', GetTriggerUnit())
    else
    endif
    // Aether Orb
    if ( Trig_on_summon_items_Func025C() ) then
        call BlzStartUnitAbilityCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 'A0PL', 18.00)
        call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) * 0.75 ), ( 0 + 0 ))
        call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 1) * 0.75 ), ( 0 + 1 ))
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * 1.50 )), 0)
        call BlzSetUnitBaseDamage(GetTriggerUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * 1.50 )), 1)
        call BlzSetUnitMaxHP(GetTriggerUnit(), R2I(( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * 1.50 )))
        call SetUnitMoveSpeed(GetTriggerUnit(), ( GetUnitMoveSpeed(GetTriggerUnit()) * 1.50 ))
        call SetUnitScalePercent(GetTriggerUnit(), 133.00, 133.00, 133.00)
        call SetUnitVertexColorBJ(GetTriggerUnit(), 100, 33.00, 33.00, 10.00)
        call AddSpecialEffectTargetUnitBJ("origin", GetTriggerUnit(), "Abilities\\Spells\\Other\\Levelup\\LevelupCaster.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
    set udg_KeyOfBalance=false
    // Skull of Doom------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func028C() ) then
        call UnitAddAbilityBJ('A0ON', GetTriggerUnit())
    else
    endif
    call SetUnitLifePercentBJ(GetTriggerUnit(), 100)
    if ( Trig_on_summon_items_Func030C() ) then
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) * ( 1 + ( ( I2R(udg_current_wave) - 50.00 ) * 0.05 ) ) ))
    else
    endif
    call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + I2R(( udg_current_wave / 2 )) ))
    // Scepter of the Sea-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_on_summon_items_Func033C() ) then
        set udg_chance=GetRandomInt(1, 5)
        if ( Trig_on_summon_items_Func033Func002C() ) then
            call TriggerSleepAction(0.01)
            set udg_TP=GetUnitLoc(GetTriggerUnit())
            call CreateNUnitsAtLoc(1, GetUnitTypeId(GetTriggerUnit()), GetOwningPlayer(GetTriggerUnit()), udg_TP, GetUnitFacing(GetTriggerUnit()))
            call RemoveLocation(udg_TP)
            call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) / 2 ), 0)
            call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( BlzGetUnitBaseDamage(GetLastCreatedUnit(), 1) / 2 ), 1)
            call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( BlzGetUnitMaxHP(GetLastCreatedUnit()) / 2 ))
            call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100.00)
            call SetUnitUserData(GetLastCreatedUnit(), 69)
            call SetUnitVertexColorBJ(GetLastCreatedUnit(), 35.00, 35.00, 100, 15.00)
            call UnitApplyTimedLifeBJ(30.00, 'BHwe', GetLastCreatedUnit())
            call AddSpecialEffectTargetUnitBJ("overhead", GetLastCreatedUnit(), "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
        endif
    else
    endif
    // SLASH: Thrall
    if ( Trig_on_summon_items_Func035C() ) then
        set udg_chance=GetRandomInt(1, 10)
        if ( Trig_on_summon_items_Func035Func003C() ) then
            call TriggerSleepAction(0.00)
            set udg_TP=GetUnitLoc(GetTriggerUnit())
            call CreateNUnitsAtLoc(1, 'o00J', GetOwningPlayer(GetTriggerUnit()), udg_TP, GetUnitFacing(GetTriggerUnit()))
            call RemoveLocation(udg_TP)
            set udg_temp_real_hp=( 100.00 + ( 0.10 * I2R(GetHeroLevel(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])) ) )
            call BlzSetUnitArmor(GetLastCreatedUnit(), ( BlzGetUnitArmor(GetLastCreatedUnit()) + I2R(( GetHeroStatBJ(bj_HEROSTAT_INT, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], true) / 20 )) ))
            call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100.00)
            call SetUnitUserData(GetLastCreatedUnit(), 67)
            call SetUnitVertexColorBJ(GetLastCreatedUnit(), 100.00, 100.00, 100, 15.00)
            call SetUnitScalePercent(GetLastCreatedUnit(), udg_temp_real_hp, udg_temp_real_hp, udg_temp_real_hp)
            call UnitApplyTimedLifeBJ(120.00, 'BEfn', GetLastCreatedUnit())
            call AddSpecialEffectTargetUnitBJ("origin", GetLastCreatedUnit(), "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_on_summon_items takes nothing returns nothing
    set gg_trg_on_summon_items=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_on_summon_items, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_on_summon_items, Condition(function Trig_on_summon_items_Conditions))
    call TriggerAddAction(gg_trg_on_summon_items, function Trig_on_summon_items_Actions)
endfunction

//===========================================================================
// Trigger: Reward Life Steal
//===========================================================================
function Trig_Reward_Life_Steal_Func005C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageSpell == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Reward_Life_Steal_Conditions takes nothing returns boolean
    if ( not ( IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not Trig_Reward_Life_Steal_Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Life_Steal_Func009C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_Unit) == 'Udre' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Life_Steal_Func011Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_temp_Unit) == 'H00L' ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A0QH', udg_DamageEventSource) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Life_Steal_Func011C takes nothing returns boolean
    if ( not Trig_Reward_Life_Steal_Func011Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Life_Steal_Func013C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'H01I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Life_Steal_Actions takes nothing returns nothing
    set udg_X=GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))
    call LeaderboardSetPlayerItemValueBJ(ConvertedPlayer(udg_X), GetLastCreatedLeaderboard(), R2I(udg_DMG[udg_X]))
    set udg_temp_Unit=udg_NICKHeroArray[udg_X]
    call SetUnitLifeBJ(udg_temp_Unit, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_temp_Unit) + ( udg_DamageEventAmount * udg_reward_lifesteal_Copy[udg_X] ) ))
    // SLASH: Dreadlord
    if ( Trig_Reward_Life_Steal_Func009C() ) then
        call SetUnitLifeBJ(udg_temp_Unit, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_temp_Unit) + ( 0.04 * ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_temp_Unit) - GetUnitStateSwap(UNIT_STATE_LIFE, udg_temp_Unit) ) ) ))
    else
    endif
    // SLASH: Lich King
    if ( Trig_Reward_Life_Steal_Func011C() ) then
        call SetUnitLifeBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventSource) + ( udg_DamageEventAmount * udg_reward_lifesteal_Copy[udg_X] ) ))
    else
    endif
    // SLASH: Halberdier
    if ( Trig_Reward_Life_Steal_Func013C() ) then
        call UnitDamageTargetBJ(udg_DamageEventTarget, udg_DamageEventSource, ( udg_DamageEventAmount * ( 0.50 * ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) / GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) ) ) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Reward_Life_Steal takes nothing returns nothing
    set gg_trg_Reward_Life_Steal=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Reward_Life_Steal, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Reward_Life_Steal, Condition(function Trig_Reward_Life_Steal_Conditions))
    call TriggerAddAction(gg_trg_Reward_Life_Steal, function Trig_Reward_Life_Steal_Actions)
endfunction

//===========================================================================
// Trigger: SLASHAfterDamage
//===========================================================================
function Trig_SLASHAfterDamage_Conditions takes nothing returns boolean
    if ( not ( IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHAfterDamage_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'H01I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHAfterDamage_Actions takes nothing returns nothing
    // SLASH: Halberdier
    if ( Trig_SLASHAfterDamage_Func004C() ) then
        call UnitDamageTargetBJ(udg_DamageEventTarget, udg_DamageEventSource, ( udg_DamageEventAmount * ( 0.50 * ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_DamageEventTarget) / GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) ) ) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHAfterDamage takes nothing returns nothing
    set gg_trg_SLASHAfterDamage=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_SLASHAfterDamage, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_SLASHAfterDamage, Condition(function Trig_SLASHAfterDamage_Conditions))
    call TriggerAddAction(gg_trg_SLASHAfterDamage, function Trig_SLASHAfterDamage_Actions)
endfunction

//===========================================================================
// Trigger: SLASHSanta
//===========================================================================
function Trig_SLASHSanta_Func002001 takes nothing returns boolean
    return ( udg_chance == 1 )
endfunction

function Trig_SLASHSanta_Func003001 takes nothing returns boolean
    return ( udg_chance == 2 )
endfunction

function Trig_SLASHSanta_Func004001 takes nothing returns boolean
    return ( udg_chance == 3 )
endfunction

function Trig_SLASHSanta_Func005001 takes nothing returns boolean
    return ( udg_chance == 4 )
endfunction

function Trig_SLASHSanta_Func006001 takes nothing returns boolean
    return ( udg_chance == 5 )
endfunction

function Trig_SLASHSanta_Func007001 takes nothing returns boolean
    return ( udg_chance == 6 )
endfunction

function Trig_SLASHSanta_Func008001 takes nothing returns boolean
    return ( udg_chance == 7 )
endfunction

function Trig_SLASHSanta_Func009001 takes nothing returns boolean
    return ( udg_chance == 8 )
endfunction

function Trig_SLASHSanta_Func010001 takes nothing returns boolean
    return ( udg_chance == 9 )
endfunction

function Trig_SLASHSanta_Func011001 takes nothing returns boolean
    return ( udg_chance == 10 )
endfunction

function Trig_SLASHSanta_Func012Func004Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHSanta_Func012Func004A takes nothing returns nothing
    if ( Trig_SLASHSanta_Func012Func004Func001C() ) then
        call SetUnitLifeBJ(GetEnumUnit(), ( 0.10 * GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) ))
    else
        call UnitDamageTargetBJ(GroupPickRandomUnit(udg_temp_group_slash), GetEnumUnit(), ( 0.60 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) ), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNKNOWN)
    endif
endfunction

function Trig_SLASHSanta_Func012C takes nothing returns boolean
    if ( not ( udg_chance == 11 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHSanta_Actions takes nothing returns nothing
    set udg_chance=GetRandomInt(1, 11)
    if ( (udg_chance == 1) ) then // INLINED!!
        call CreateItemLoc('tgxp', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 2) ) then // INLINED!!
        call CreateItemLoc('manh', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 3) ) then // INLINED!!
        call CreateItemLoc('gold', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 4) ) then // INLINED!!
        call CreateItemLoc('tpow', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 5) ) then // INLINED!!
        call CreateItemLoc('gold', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 6) ) then // INLINED!!
        call CreateItemLoc('gold', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 7) ) then // INLINED!!
        call CreateItemLoc('tst2', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 8) ) then // INLINED!!
        call CreateItemLoc('tdx2', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 9) ) then // INLINED!!
        call CreateItemLoc('tin2', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( (udg_chance == 10) ) then // INLINED!!
        call CreateItemLoc('lmbr', GetDestructableLoc(GetDyingDestructable()))
    else
        call DoNothing()
    endif
    if ( Trig_SLASHSanta_Func012C() ) then
        set udg_temp_loc_slash1=GetDestructableLoc(GetDyingDestructable())
        set udg_temp_group_slash=GetUnitsOfTypeIdAll('H01K')
        set udg_temp_group_slash2=GetUnitsInRangeOfLocAll(300.00, udg_temp_loc_slash1)
        call ForGroupBJ(udg_temp_group_slash2, function Trig_SLASHSanta_Func012Func004A)
        call DestroyGroup(udg_temp_group_slash)
        call DestroyGroup(udg_temp_group_slash2)
        call AddSpecialEffectLocBJ(GetDestructableLoc(GetDyingDestructable()), "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectLocBJ(GetDestructableLoc(GetDyingDestructable()), "Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call RemoveLocation(udg_temp_loc_slash1)
    else
    endif
    call ShowDestructableBJ(false, GetDyingDestructable())
endfunction

//===========================================================================
function InitTrig_SLASHSanta takes nothing returns nothing
    set gg_trg_SLASHSanta=CreateTrigger()
    call TriggerAddAction(gg_trg_SLASHSanta, function Trig_SLASHSanta_Actions)
endfunction

//===========================================================================
// Trigger: SLASHJaina1
//===========================================================================
function Trig_SLASHJaina1_Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01X' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() != 'A0QP' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHJaina1_Conditions takes nothing returns boolean
    if ( not Trig_SLASHJaina1_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHJaina1_Actions takes nothing returns nothing
    set udg_SLASHJainaAbil=GetSpellAbilityId()
endfunction

//===========================================================================
function InitTrig_SLASHJaina1 takes nothing returns nothing
    set gg_trg_SLASHJaina1=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHJaina1, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHJaina1, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHJaina1, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_SLASHJaina1, Condition(function Trig_SLASHJaina1_Conditions))
    call TriggerAddAction(gg_trg_SLASHJaina1, function Trig_SLASHJaina1_Actions)
endfunction

//===========================================================================
// Trigger: SLASHJaina2
//===========================================================================
function Trig_SLASHJaina2_Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01X' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() == 'A0QP' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHJaina2_Conditions takes nothing returns boolean
    if ( not Trig_SLASHJaina2_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHJaina2_Actions takes nothing returns nothing
    call BlzEndUnitAbilityCooldown(GetTriggerUnit(), udg_SLASHJainaAbil)
endfunction

//===========================================================================
function InitTrig_SLASHJaina2 takes nothing returns nothing
    set gg_trg_SLASHJaina2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHJaina2, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SLASHJaina2, Condition(function Trig_SLASHJaina2_Conditions))
    call TriggerAddAction(gg_trg_SLASHJaina2, function Trig_SLASHJaina2_Actions)
endfunction

//===========================================================================
// Trigger: SLASHKael
//===========================================================================
function Trig_SLASHKael_Func011C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01Y' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() == 'A0QQ' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHKael_Conditions takes nothing returns boolean
    if ( not Trig_SLASHKael_Func011C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHKael_Func002A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_SLASHKael_Actions takes nothing returns nothing
    set udg_temp_group_slash=GetUnitsOfTypeIdAll('h01Z')
    call ForGroupBJ(udg_temp_group_slash, function Trig_SLASHKael_Func002A)
    call DestroyGroup(udg_temp_group_slash)
    set udg_temp_loc_slash1=GetUnitLoc(GetTriggerUnit())
    set udg_temp_loc_slash2=PolarProjectionBJ(udg_temp_loc_slash1, 128.00, GetUnitFacing(GetTriggerUnit()))
    call CreateNUnitsAtLoc(1, 'h01Z', GetOwningPlayer(GetTriggerUnit()), udg_temp_loc_slash2, GetUnitFacing(GetTriggerUnit()))
    call AddSpecialEffectTargetUnitBJ("origin", GetLastCreatedUnit(), "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call RemoveLocation(udg_temp_loc_slash2)
    call RemoveLocation(udg_temp_loc_slash1)
endfunction

//===========================================================================
function InitTrig_SLASHKael takes nothing returns nothing
    set gg_trg_SLASHKael=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHKael, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SLASHKael, Condition(function Trig_SLASHKael_Conditions))
    call TriggerAddAction(gg_trg_SLASHKael, function Trig_SLASHKael_Actions)
endfunction

//===========================================================================
// Trigger: SLASHLock
//===========================================================================
function Trig_SLASHLock_Func013C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'Ofar' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() == 'A0R0' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLock_Conditions takes nothing returns boolean
    if ( not Trig_SLASHLock_Func013C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLock_Func010Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A0QH', GetEnumUnit()) > 0 ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'nbal' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLock_Func010Func001C takes nothing returns boolean
    if ( not Trig_SLASHLock_Func010Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLock_Func010A takes nothing returns nothing
    if ( Trig_SLASHLock_Func010Func001C() ) then
        call BlzSetUnitBaseDamage(udg_temp_unit_slash1, ( BlzGetUnitBaseDamage(udg_temp_unit_slash1, 0) + ( BlzGetUnitBaseDamage(GetEnumUnit(), 0) / 2 ) ), 0)
        call BlzSetUnitMaxHP(udg_temp_unit_slash1, ( BlzGetUnitMaxHP(udg_temp_unit_slash1) + ( BlzGetUnitMaxHP(GetEnumUnit()) / 2 ) ))
        call KillUnit(GetEnumUnit())
    else
    endif
endfunction

function Trig_SLASHLock_Func012C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 100) <= 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHLock_Actions takes nothing returns nothing
    set udg_temp_loc_slash1=GetUnitLoc(GetTriggerUnit())
    set udg_temp_loc_slash2=PolarProjectionBJ(udg_temp_loc_slash1, 128.00, GetUnitFacing(GetTriggerUnit()))
    call CreateNUnitsAtLoc(1, 'nbal', GetOwningPlayer(GetTriggerUnit()), udg_temp_loc_2, GetUnitFacing(GetTriggerUnit()))
    set udg_temp_unit_slash1=GetLastCreatedUnit()
    call AddSpecialEffectTargetUnitBJ("origin", GetLastCreatedUnit(), "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call RemoveLocation(udg_temp_loc_slash2)
    call RemoveLocation(udg_temp_loc_slash1)
    set udg_temp_group_slash=GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit()))
    call ForGroupBJ(udg_temp_group_slash, function Trig_SLASHLock_Func010A)
    call DestroyGroup(udg_temp_group_slash)
    if ( Trig_SLASHLock_Func012C() ) then
        call SetUnitOwner(udg_temp_unit_slash1, Player(20), false)
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHLock takes nothing returns nothing
    set gg_trg_SLASHLock=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHLock, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SLASHLock, Condition(function Trig_SLASHLock_Conditions))
    call TriggerAddAction(gg_trg_SLASHLock, function Trig_SLASHLock_Actions)
endfunction

//===========================================================================
// Trigger: SLASHBossZerk
//===========================================================================
function Trig_SLASHBossZerk_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0R3' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHBossZerk_Actions takes nothing returns nothing
    call CreateTextTagUnitBJ("TRIGSTR_11602", GetTriggerUnit(), 0, 10.00, 100, 0.00, 100, 0)
    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.33)
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 1.00)
endfunction

//===========================================================================
function InitTrig_SLASHBossZerk takes nothing returns nothing
    set gg_trg_SLASHBossZerk=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHBossZerk, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SLASHBossZerk, Condition(function Trig_SLASHBossZerk_Conditions))
    call TriggerAddAction(gg_trg_SLASHBossZerk, function Trig_SLASHBossZerk_Actions)
endfunction

//===========================================================================
// Trigger: SLASHWaveLoot
//===========================================================================
function Trig_SLASHWaveLoot_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetKillingUnitBJ()) != GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) == Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetKillingUnitBJ()) == true ) ) then
        return false
    endif
    if ( not ( GetKillingUnitBJ() != GetDyingUnit() ) ) then
        return false
    endif
    if ( not ( GetKillingUnitBJ() != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHWaveLoot_Func002Func001Func001Func001C takes nothing returns boolean
    if ( ( IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true ) ) then
        return true
    endif
    if ( ( GetUnitUserData(GetDyingUnit()) == 16 ) ) then
        return true
    endif
    if ( ( GetUnitUserData(GetDyingUnit()) == 32 ) ) then
        return true
    endif
    if ( ( GetUnitUserData(GetDyingUnit()) == 64 ) ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHWaveLoot_Func002Func001Func001C takes nothing returns boolean
    if ( not Trig_SLASHWaveLoot_Func002Func001Func001Func001C() ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 100) <= 25 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHWaveLoot_Func002Func001Func002C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 100) <= 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHWaveLoot_Func002Func001C takes nothing returns boolean
    if ( Trig_SLASHWaveLoot_Func002Func001Func001C() ) then
        return true
    endif
    if ( Trig_SLASHWaveLoot_Func002Func001Func002C() ) then
        return true
    endif
    return false
endfunction

function Trig_SLASHWaveLoot_Func002Func004001 takes nothing returns boolean
    return ( udg_chance == 1 )
endfunction

function Trig_SLASHWaveLoot_Func002Func005001 takes nothing returns boolean
    return ( udg_chance == 2 )
endfunction

function Trig_SLASHWaveLoot_Func002Func006001 takes nothing returns boolean
    return ( udg_chance == 3 )
endfunction

function Trig_SLASHWaveLoot_Func002Func007001 takes nothing returns boolean
    return ( udg_chance == 4 )
endfunction

function Trig_SLASHWaveLoot_Func002Func008001 takes nothing returns boolean
    return ( udg_chance == 5 )
endfunction

function Trig_SLASHWaveLoot_Func002Func009001 takes nothing returns boolean
    return ( udg_chance == 6 )
endfunction

function Trig_SLASHWaveLoot_Func002Func010001 takes nothing returns boolean
    return ( udg_chance == 7 )
endfunction

function Trig_SLASHWaveLoot_Func002C takes nothing returns boolean
    if ( not Trig_SLASHWaveLoot_Func002Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SLASHWaveLoot_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetTriggerUnit(), - 99999.00)
    if ( Trig_SLASHWaveLoot_Func002C() ) then
        set udg_chance=GetRandomInt(1, 7)
        set udg_temp_loc_slash1=GetUnitLoc(GetDyingUnit())
        if ( (udg_chance == 1) ) then // INLINED!!
            call CreateItemLoc('lmbr', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 2) ) then // INLINED!!
            call CreateItemLoc('tpow', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 3) ) then // INLINED!!
            call CreateItemLoc('gold', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 4) ) then // INLINED!!
            call CreateItemLoc('I04O', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 5) ) then // INLINED!!
            call CreateItemLoc('sorf', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 6) ) then // INLINED!!
            call CreateItemLoc('ches', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        if ( (udg_chance == 7) ) then // INLINED!!
            call CreateItemLoc('rat6', udg_temp_loc_slash1)
        else
            call DoNothing()
        endif
        call RemoveLocation(udg_temp_loc_slash1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_SLASHWaveLoot takes nothing returns nothing
    set gg_trg_SLASHWaveLoot=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SLASHWaveLoot, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_SLASHWaveLoot, Condition(function Trig_SLASHWaveLoot_Conditions))
    call TriggerAddAction(gg_trg_SLASHWaveLoot, function Trig_SLASHWaveLoot_Actions)
endfunction

//===========================================================================
// Trigger: Change Item Description
//===========================================================================
function Trig_Change_Item_Description_Func001002002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_Change_Item_Description_Func002Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I028') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func002C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I02C') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func003C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I005') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func004C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'crdt') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func005C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'rugt') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func006C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'sxpl') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func007C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'shrs') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func008C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I03R') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func009C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I02Z') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func011C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'I04X') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002Func012C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetEnumUnit(), 'mlst') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Change_Item_Description_Func002A takes nothing returns nothing
    if ( Trig_Change_Item_Description_Func002Func001C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I028'), ( "|cffffcc00Agility:|r +10|n|cffffcc00Unique Effect:|r Every 3rd basic attack creates a fire aura next to the hero. Picking up the fire aura charges your next attack to do |cfffa5e19" + ( I2S(R2I(( 10.00 * I2R(GetHeroStatBJ(bj_HEROSTAT_AGI, GetEnumUnit(), true)) ))) + ( "|r (10x Agility) spell damage.|nThe aura lasts for 3 seconds." ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func002C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I02C'), ( "|cffffcc00Health Regeneration:|r +6|n|cffffcc00Unique Effect:|r On use: Sacrifices 30% of your current health to deal damage in an area around your hero equal to |cfffa5e19" + ( I2S(R2I(( 0.25 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) ))) + ( "|r (25% of maximum health)." ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func003C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I005'), ( "|cffffcc00Intelligence:|r +4|n|cffffcc00Damage:|r +10|n|cffffcc00Unique Effect:|r On use: Casts a Firebolt on an area dealing 400 +  |cfffa5e19" + ( I2S(( GetHeroStatBJ(bj_HEROSTAT_INT, GetEnumUnit(), true) * 3 )) + ( "|r (x3 Intelligence) spell damage and stunning for 2 seconds." ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func004C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'crdt'), ( "|cffffcc00Armor:|r +6|n|cffffcc00Mana:|r +300|n|cffffcc00Unique Effect:|r Regenerate mana per second equal to |cfffa5e19" + ( R2S(( 0.50 * BlzGetUnitArmor(GetEnumUnit()) )) + ( "|r (0.50x armor)" ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func005C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'rugt'), ( "|cffffcc00Strength:|r +7|n|cffffcc00Damage:|r +22|n|cffffcc00Unique Effect:|r Every 4 seconds charges your next basic attack, increasing damage by |cfffa5e19" + ( I2S(( GetHeroStatBJ(bj_HEROSTAT_STR, GetEnumUnit(), true) * 10 )) + ( "|r " + ( "(0.5x Strength) damage.|nThis effect resets every time you attack." ) ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func006C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'sxpl'), ( "|cffffcc00On Use:|r Restores |cfffa5e19" + ( I2S(( GetItemCharges(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'sxpl')) * 150 )) + "|r Mana (150 x stacks). Doesn't lose a stack when used.|n|n|cffffcc00Stackable." ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func007C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'shrs'), ( "|cffffcc00On Use:|r Restores |cfffa5e19" + ( I2S(( GetItemCharges(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'shrs')) * 100 )) + "|r Health (100 x stacks). Doesn't lose a stack when used.|n|n|cffffcc00Stackable." ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func008C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I03R'), ( "|cffffcc00All Stats:|r +10|n|cffffcc00Unique Effect:|r Taking damage begins charging this item. When damage reaches |cfffa5e19" + ( "|cfffa5e19100% max health|r" + ( "|r  allows this item to be used. (|cfffa5e19" + ( I2S(R2I(( 100.00 / ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) / udg_divinity_gauntlet_dmg[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] ) ))) + "%|r)|n|cffffcc00On Use:|r Deals 1500 spell damage to enemies in a large area." ) ) ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func009C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I02Z'), ( "|cffffcc00All Stats:|r +15|n|cffffcc00On Use:|r Summons a |cfffa5e19" + ( I2S(( 150 * GetHeroLevel(GetEnumUnit()) )) + ( "|r HP (150*lvl) |cfffa5e19" + ( I2S(( 10 * GetHeroLevel(GetEnumUnit()) )) + "|r DMG (10*lvl) unit to fight for you." ) ) ) ))
    else
    endif
    // Nick's Items-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_Change_Item_Description_Func002Func011C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I04X'), ( "|cffffcc00Attack Speed:|r +20%|n|cffffcc00Intelligence:|r +10|n|cffffcc00Unique Effect:|r While below 50% mana, your basic attacks deal |cfffa5e19" + ( I2S(R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_INT, GetEnumUnit(), true)) * 3.50 ))) + "|r (x3.5 Intelligence) bonus damage." ) ))
    else
    endif
    if ( Trig_Change_Item_Description_Func002Func012C() ) then
        call BlzSetItemExtendedTooltip(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'mlst'), ( "|cffffcc00Damage:|r +35|n|cffffcc00Unique Effect:|r Every 7th basic attack deals a bonus of |cfffa5e19" + ( I2S(R2I(( I2R(BlzGetUnitBaseDamage(GetEnumUnit(), 0)) * 0.50 ))) + "|r (50% base) damage as spell damage." ) ))
    else
    endif
endfunction

function Trig_Change_Item_Description_Actions takes nothing returns nothing
    set udg_temp_UnitGroup=GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_Change_Item_Description_Func001002002))
    call ForGroupBJ(udg_temp_UnitGroup, function Trig_Change_Item_Description_Func002A)
    call DestroyGroup(udg_temp_UnitGroup)
endfunction

//===========================================================================
function InitTrig_Change_Item_Description takes nothing returns nothing
    set gg_trg_Change_Item_Description=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Change_Item_Description, 4.00)
    call TriggerAddAction(gg_trg_Change_Item_Description, function Trig_Change_Item_Description_Actions)
endfunction

//===========================================================================
// Trigger: Nick Unit starts effect of an ability
//===========================================================================
function Trig_Nick_Unit_starts_effect_of_an_ability_Conditions takes nothing returns boolean
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Unit_starts_effect_of_an_ability_Func002C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I04Q') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Unit_starts_effect_of_an_ability_Actions takes nothing returns nothing
    if ( Trig_Nick_Unit_starts_effect_of_an_ability_Func002C() ) then
        set udg_temp_Point=GetUnitLoc(GetTriggerUnit())
        call CreateNUnitsAtLoc(1, 'h000', GetOwningPlayer(GetTriggerUnit()), udg_temp_Point, bj_UNIT_FACING)
        call UnitAddAbilityBJ('A0M7', GetLastCreatedUnit())
        call IssueTargetOrderBJ(GetLastCreatedUnit(), "bloodlust", GetTriggerUnit())
        call UnitApplyTimedLifeBJ(3.20, 'BTLF', GetLastCreatedUnit())
        call RemoveLocation(udg_temp_Point)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Nick_Unit_starts_effect_of_an_ability takes nothing returns nothing
    set gg_trg_Nick_Unit_starts_effect_of_an_ability=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nick_Unit_starts_effect_of_an_ability, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nick_Unit_starts_effect_of_an_ability, Condition(function Trig_Nick_Unit_starts_effect_of_an_ability_Conditions))
    call TriggerAddAction(gg_trg_Nick_Unit_starts_effect_of_an_ability, function Trig_Nick_Unit_starts_effect_of_an_ability_Actions)
endfunction

//===========================================================================
// Trigger: Nick Item Acquired
//===========================================================================
function Trig_Nick_Item_Acquired_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetTriggerUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Acquired_Func003C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I03V' ) ) then
        return false
    endif
    if ( not ( udg_NICKObsidianRingInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Acquired_Func004C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04M' ) ) then
        return false
    endif
    if ( not ( udg_NICKMagicDaggerInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Acquired_Func005C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04R' ) ) then
        return false
    endif
    if ( not ( udg_NICKBeltofGiantStrengthInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Acquired_Func006C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04T' ) ) then
        return false
    endif
    if ( not ( udg_NICKRobeoftheMagiInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Acquired_Actions takes nothing returns nothing
    if ( Trig_Nick_Item_Acquired_Func003C() ) then
        set udg_NICKObsidianRingInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=1
        call GroupAddUnitSimple(GetTriggerUnit(), udg_NICKObsidianRingGroup)
    else
    endif
    if ( Trig_Nick_Item_Acquired_Func004C() ) then
        set udg_NICKMagicDaggerInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=1
        call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) / 1.17 ), ( 1 - 1 ))
    else
    endif
    if ( Trig_Nick_Item_Acquired_Func005C() ) then
        set udg_NICKBeltofGiantStrengthInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=1
        call GroupAddUnitSimple(GetTriggerUnit(), udg_NICKBeltofGiantStrengthGroup)
    else
    endif
    if ( Trig_Nick_Item_Acquired_Func006C() ) then
        set udg_NICKRobeoftheMagiInteger[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=1
        call GroupAddUnitSimple(GetTriggerUnit(), udg_NICKRobeoftheMagiGroup)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Nick_Item_Acquired takes nothing returns nothing
    set gg_trg_Nick_Item_Acquired=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nick_Item_Acquired, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Nick_Item_Acquired, Condition(function Trig_Nick_Item_Acquired_Conditions))
    call TriggerAddAction(gg_trg_Nick_Item_Acquired, function Trig_Nick_Item_Acquired_Actions)
endfunction

//===========================================================================
// Trigger: Nick Item Lost
//===========================================================================
function Trig_Nick_Item_Lost_Func002Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03U') == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Lost_Func002Func002C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03V') == false ) ) then
        return false
    endif
    if ( not ( udg_NICKObsidianRingInteger[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Lost_Func002Func003C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04M') == false ) ) then
        return false
    endif
    if ( not ( udg_NICKMagicDaggerInteger[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Lost_Func002Func004C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04R') == false ) ) then
        return false
    endif
    if ( not ( udg_NICKBeltofGiantStrengthInteger[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Lost_Func002Func005C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04T') == false ) ) then
        return false
    endif
    if ( not ( udg_NICKRobeoftheMagiInteger[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Item_Lost_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Nick_Item_Lost_Func002Func001C() ) then
            call SetUnitAbilityLevelSwapped('A0LJ', udg_NICKHeroArray[GetForLoopIndexA()], 1)
        else
        endif
        if ( Trig_Nick_Item_Lost_Func002Func002C() ) then
            call GroupRemoveUnitSimple(udg_NICKHeroArray[GetForLoopIndexA()], udg_NICKObsidianRingGroup)
            set udg_NICKObsidianRingInteger[GetForLoopIndexA()]=0
        else
        endif
        if ( Trig_Nick_Item_Lost_Func002Func003C() ) then
            call BlzSetUnitAttackCooldown(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitAttackCooldown(udg_NICKHeroArray[GetForLoopIndexA()], 0) * 1.17 ), ( 1 - 1 ))
            set udg_NICKMagicDaggerInteger[GetForLoopIndexA()]=0
        else
        endif
        if ( Trig_Nick_Item_Lost_Func002Func004C() ) then
            call GroupRemoveUnitSimple(udg_NICKHeroArray[GetForLoopIndexA()], udg_NICKBeltofGiantStrengthGroup)
            set udg_NICKBeltofGiantStrengthInteger[GetForLoopIndexA()]=0
        else
        endif
        if ( Trig_Nick_Item_Lost_Func002Func005C() ) then
            call GroupRemoveUnitSimple(udg_NICKHeroArray[GetForLoopIndexA()], udg_NICKRobeoftheMagiGroup)
            set udg_NICKRobeoftheMagiInteger[GetForLoopIndexA()]=0
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Nick_Item_Lost takes nothing returns nothing
    set gg_trg_Nick_Item_Lost=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Nick_Item_Lost, 1.00)
    call TriggerAddAction(gg_trg_Nick_Item_Lost, function Trig_Nick_Item_Lost_Actions)
endfunction

//===========================================================================
// Trigger: Nick Periodic
//===========================================================================
function Trig_Nick_Periodic_Func001C takes nothing returns boolean
    if ( not ( udg_reward_manaregen_pillar > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func002Func001C takes nothing returns boolean
    if ( not ( udg_reward_regen_Copy[GetForLoopIndexA()] > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func002Func002C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'rlif') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func003Func001C takes nothing returns boolean
    if ( not ( BlzIsUnitInvulnerable(GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( GetUnitManaPercent(GetEnumUnit()) != 100.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func003A takes nothing returns nothing
    if ( Trig_Nick_Periodic_Func003Func001C() ) then
        call SetUnitManaBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) - ( 0.02 * ( 0.10 * GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetEnumUnit()) ) ) ))
    else
    endif
endfunction

function Trig_Nick_Periodic_Func004Func001Func003C takes nothing returns boolean
    if ( not ( udg_mana_axe_dmg[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func004Func001Func004C takes nothing returns boolean
    if ( not ( udg_mana_axe_dmg[GetForLoopIndexA()] == 0 ) ) then
        return false
    endif
    if ( not ( GetUnitStateSwap(UNIT_STATE_MANA, udg_NICKHeroArray[GetForLoopIndexA()]) > ( udg_temp_real_2 / 2.00 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func004Func001Func005C takes nothing returns boolean
    if ( not ( udg_mana_axe_dmg[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    if ( not ( GetUnitStateSwap(UNIT_STATE_MANA, udg_NICKHeroArray[GetForLoopIndexA()]) < ( udg_temp_real_2 / 2.00 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func004Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04C') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func005Func001Func001C takes nothing returns boolean
    if ( not ( udg_dragoon_pike_rng[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func005Func001Func002C takes nothing returns boolean
    if ( not ( udg_dragoon_pike_rng[GetForLoopIndexA()] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func005Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04H') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Periodic_Func006A takes nothing returns nothing
    call SetUnitLifeBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) + 1.50 ))
endfunction

function Trig_Nick_Periodic_Func007A takes nothing returns nothing
    call SetUnitManaBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) + 5.00 ))
endfunction

function Trig_Nick_Periodic_Actions takes nothing returns nothing
    if ( Trig_Nick_Periodic_Func001C() ) then
        call SetUnitManaBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_MANA, gg_unit_n02S_0002) + ( udg_reward_manaregen_pillar / 10.00 ) ))
    else
    endif
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Nick_Periodic_Func002Func001C() ) then
            call SetUnitLifeBJ(udg_NICKHeroArray[GetForLoopIndexA()], ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[GetForLoopIndexA()]) + ( udg_reward_regen_Copy[GetForLoopIndexA()] / 10.00 ) ))
        else
        endif
        if ( Trig_Nick_Periodic_Func002Func002C() ) then
            call SetUnitLifeBJ(udg_NICKHeroArray[GetForLoopIndexA()], ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[GetForLoopIndexA()]) + ( I2R(GetItemCharges(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'rlif'))) * 0.20 ) ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ(udg_NICKObsidianRingGroup, function Trig_Nick_Periodic_Func003A)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Nick_Periodic_Func004Func001C() ) then
            set udg_temp_real_2=GetUnitStateSwap(UNIT_STATE_MAX_MANA, udg_NICKHeroArray[GetForLoopIndexA()])
            if ( Trig_Nick_Periodic_Func004Func001Func004C() ) then
                set udg_mana_axe_dmg[GetForLoopIndexA()]=1
                call BlzSetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], 0) + R2I(( 0.10 * udg_temp_real_2 )) ), 0)
            else
            endif
            if ( Trig_Nick_Periodic_Func004Func001Func005C() ) then
                set udg_mana_axe_dmg[GetForLoopIndexA()]=0
                call BlzSetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], 0) - R2I(( 0.10 * udg_temp_real_2 )) ), 0)
            else
            endif
        else
            set udg_temp_real_2=GetUnitStateSwap(UNIT_STATE_MAX_MANA, udg_NICKHeroArray[GetForLoopIndexA()])
            if ( Trig_Nick_Periodic_Func004Func001Func003C() ) then
                call BlzSetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], 0) - R2I(( 0.10 * udg_temp_real_2 )) ), 0)
                set udg_mana_axe_dmg[GetForLoopIndexA()]=0
            else
            endif
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Nick_Periodic_Func005Func001C() ) then
            if ( Trig_Nick_Periodic_Func005Func001Func002C() ) then
                set udg_dragoon_pike_rng[GetForLoopIndexA()]=1
                call BlzSetUnitRealFieldBJ(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_RF_ACQUISITION_RANGE, ( BlzGetUnitRealField(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_RF_ACQUISITION_RANGE) + 256.00 ))
                call BlzSetUnitWeaponRealFieldBJ(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_WEAPON_RF_ATTACK_RANGE, 0, ( BlzGetUnitWeaponRealField(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_WEAPON_RF_ATTACK_RANGE, 0) + 256.00 ))
            else
            endif
        else
            if ( Trig_Nick_Periodic_Func005Func001Func001C() ) then
                set udg_dragoon_pike_rng[GetForLoopIndexA()]=0
                call BlzSetUnitRealFieldBJ(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_RF_ACQUISITION_RANGE, ( BlzGetUnitRealField(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_RF_ACQUISITION_RANGE) - 256.00 ))
                call BlzSetUnitWeaponRealFieldBJ(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_WEAPON_RF_ATTACK_RANGE, 0, ( BlzGetUnitWeaponRealField(udg_NICKHeroArray[GetForLoopIndexA()], UNIT_WEAPON_RF_ATTACK_RANGE, 0) - 256.00 ))
            else
            endif
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ(udg_NICKBeltofGiantStrengthGroup, function Trig_Nick_Periodic_Func006A)
    call ForGroupBJ(udg_NICKRobeoftheMagiGroup, function Trig_Nick_Periodic_Func007A)
endfunction

//===========================================================================
function InitTrig_Nick_Periodic takes nothing returns nothing
    set gg_trg_Nick_Periodic=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Nick_Periodic, 0.10)
    call TriggerAddAction(gg_trg_Nick_Periodic, function Trig_Nick_Periodic_Actions)
endfunction

//===========================================================================
// Trigger: Damage Engine Config
//===========================================================================
function Trig_Damage_Engine_Config_Actions takes nothing returns nothing
    // -
    // You can add extra classifications here if you want to differentiate between your triggered damage
    // Use DamageTypeExplosive (or any negative value damage type) if you want a unit killed by that damage to explode
    // -
    // The pre-defined type Code might be set by Damage Engine if Unit - Damage Target is detected and the user didn't define a type of their own.
    // "Pure" is especially important because it overrides both the Damage Engine as well as WarCraft 3 damage modification.
    // I therefore gave the user "Explosive Pure" in case one wants to combine the functionality of the two.
    // -
    set udg_DamageTypePureExplosive=- 2
    set udg_DamageTypeExplosive=- 1
    set udg_DamageTypeCode=1
    set udg_DamageTypePure=2
    // -
    set udg_DamageTypeHeal=3
    set udg_DamageTypeBlocked=4
    set udg_DamageTypeReduced=5
    // -
    set udg_DamageTypeCriticalStrike=6
    // -
    // Added 25 July 2017 to allow detection of things like Bash or Pulverize or AOE spread
    // -
    set udg_DamageEventAOE=1
    set udg_DamageEventLevel=1
    // -
    // In-game World Editor doesn't allow Attack Type and Damage Type comparisons. Therefore I need to code them as integers into GUI
    // -
    set udg_ATTACK_TYPE_SPELLS=0
    set udg_ATTACK_TYPE_NORMAL=1
    set udg_ATTACK_TYPE_PIERCE=2
    set udg_ATTACK_TYPE_SIEGE=3
    set udg_ATTACK_TYPE_MAGIC=4
    set udg_ATTACK_TYPE_CHAOS=5
    set udg_ATTACK_TYPE_HERO=6
    // -
    set udg_DAMAGE_TYPE_UNKNOWN=0
    set udg_DAMAGE_TYPE_NORMAL=4
    set udg_DAMAGE_TYPE_ENHANCED=5
    set udg_DAMAGE_TYPE_FIRE=8
    set udg_DAMAGE_TYPE_COLD=9
    set udg_DAMAGE_TYPE_LIGHTNING=10
    set udg_DAMAGE_TYPE_POISON=11
    set udg_DAMAGE_TYPE_DISEASE=12
    set udg_DAMAGE_TYPE_DIVINE=13
    set udg_DAMAGE_TYPE_MAGIC=14
    set udg_DAMAGE_TYPE_SONIC=15
    set udg_DAMAGE_TYPE_ACID=16
    set udg_DAMAGE_TYPE_FORCE=17
    set udg_DAMAGE_TYPE_DEATH=18
    set udg_DAMAGE_TYPE_MIND=19
    set udg_DAMAGE_TYPE_PLANT=20
    set udg_DAMAGE_TYPE_DEFENSIVE=21
    set udg_DAMAGE_TYPE_DEMOLITION=22
    set udg_DAMAGE_TYPE_SLOW_POISON=23
    set udg_DAMAGE_TYPE_SPIRIT_LINK=24
    set udg_DAMAGE_TYPE_SHADOW_STRIKE=25
    set udg_DAMAGE_TYPE_UNIVERSAL=26
    // -
    // The below variables don't affect damage amount, but do affect the sound played
    // They also give important information about the type of attack used.
    // They can differentiate between ranged and melee for units who are both
    // -
    set udg_WEAPON_TYPE_NONE=0
    // Metal Light/Medium/Heavy
    set udg_WEAPON_TYPE_ML_CHOP=1
    set udg_WEAPON_TYPE_MM_CHOP=2
    set udg_WEAPON_TYPE_MH_CHOP=3
    set udg_WEAPON_TYPE_ML_SLICE=4
    set udg_WEAPON_TYPE_MM_SLICE=5
    set udg_WEAPON_TYPE_MH_SLICE=6
    set udg_WEAPON_TYPE_MM_BASH=7
    set udg_WEAPON_TYPE_MH_BASH=8
    set udg_WEAPON_TYPE_MM_STAB=9
    set udg_WEAPON_TYPE_MH_STAB=10
    // Wood Light/Medium/Heavy
    set udg_WEAPON_TYPE_WL_SLICE=11
    set udg_WEAPON_TYPE_WM_SLICE=12
    set udg_WEAPON_TYPE_WH_SLICE=13
    set udg_WEAPON_TYPE_WL_BASH=14
    set udg_WEAPON_TYPE_WM_BASH=15
    set udg_WEAPON_TYPE_WH_BASH=16
    set udg_WEAPON_TYPE_WL_STAB=17
    set udg_WEAPON_TYPE_WM_STAB=18
    // Claw Light/Medium/Heavy
    set udg_WEAPON_TYPE_CL_SLICE=19
    set udg_WEAPON_TYPE_CM_SLICE=20
    set udg_WEAPON_TYPE_CH_SLICE=21
    // Axe Medium
    set udg_WEAPON_TYPE_AM_CHOP=22
    // Rock Heavy
    set udg_WEAPON_TYPE_RH_BASH=23
    // -
    // Since GUI still doesn't provide Defense Type and Armor Types, I needed to include the below
    // -
    set udg_ARMOR_TYPE_NONE=0
    set udg_ARMOR_TYPE_FLESH=1
    set udg_ARMOR_TYPE_METAL=2
    set udg_ARMOR_TYPE_WOOD=3
    set udg_ARMOR_TYPE_ETHEREAL=4
    set udg_ARMOR_TYPE_STONE=5
    // -
    set udg_DEFENSE_TYPE_LIGHT=0
    set udg_DEFENSE_TYPE_MEDIUM=1
    set udg_DEFENSE_TYPE_HEAVY=2
    set udg_DEFENSE_TYPE_FORTIFIED=3
    set udg_DEFENSE_TYPE_NORMAL=4
    set udg_DEFENSE_TYPE_HERO=5
    set udg_DEFENSE_TYPE_DIVINE=6
    set udg_DEFENSE_TYPE_UNARMORED=7
    // -
    call DamageEngine_DebugStr()
endfunction

//===========================================================================
function InitTrig_Damage_Engine_Config takes nothing returns nothing
    set gg_trg_Damage_Engine_Config=CreateTrigger()
    call TriggerAddAction(gg_trg_Damage_Engine_Config, function Trig_Damage_Engine_Config_Actions)
endfunction

//===========================================================================
// Trigger: Damage Engine
//===========================================================================
//===========================================================================
//  
//  Damage Engine 5.4.2.2 - update requires copying of the JASS script
//  
//===========================================================================
//===========================================================================
// Trigger: SpellDMG Check
//
// spell damage is applied to the on damage items at the bottom
//===========================================================================
function Trig_SpellDMG_Check_Func001Func003C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'sorf') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func005Func001C takes nothing returns boolean
    if ( not ( GetUnitManaPercent(udg_NICKHeroArray[GetForLoopIndexA()]) < 50.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func005C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04E')) == 'I04E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func007C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I04L')) == 'I04L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func009C takes nothing returns boolean
    if ( not ( udg_lvl3_trait4[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func011C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03V')) == 'I03V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func013Func001Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetForLoopIndexA()], 'A0N2') == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func013Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetForLoopIndexA()], 'A0N2') > 4.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Func001Func013C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'gvsm') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpellDMG_Check_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_spelldamage[GetForLoopIndexA()]=( 1.00 + udg_reward_spelldmg[( ( 10 * GetForLoopIndexA() ) + 1 )] )
        // Shadow Orb---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func003C() ) then
            set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + ( 0.05 * I2R(GetItemCharges(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'sorf'))) ) )
        else
        endif
        // Gloves of Magic Bending--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func005C() ) then
            if ( Trig_SpellDMG_Check_Func001Func005Func001C() ) then
                set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + 0.85 )
            else
            endif
        else
        endif
        // NICK: Shield of the Death Lord-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func007C() ) then
            set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + 50.00 )
        else
        endif
        // Ethereal Claws-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func009C() ) then
            set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + 0.20 )
        else
        endif
        // Cursed Wand--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func011C() ) then
            set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + 1.00 )
        else
        endif
        // Gloves of Spell Mastery--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        if ( Trig_SpellDMG_Check_Func001Func013C() ) then
            if ( Trig_SpellDMG_Check_Func001Func013Func001C() ) then
                set udg_spelldamage[GetForLoopIndexA()]=( udg_spelldamage[GetForLoopIndexA()] + 0.70 )
            else
                if ( Trig_SpellDMG_Check_Func001Func013Func001Func001C() ) then
                    call BlzStartUnitAbilityCooldown(udg_NICKHeroArray[GetForLoopIndexA()], 'A0N2', 10.00)
                else
                endif
            endif
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_SpellDMG_Check takes nothing returns nothing
    set gg_trg_SpellDMG_Check=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_SpellDMG_Check, 0.50)
    call TriggerAddAction(gg_trg_SpellDMG_Check, function Trig_SpellDMG_Check_Actions)
endfunction

//===========================================================================
// Trigger: Key Of Balance
//===========================================================================
function Trig_Key_Of_Balance_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnteringUnit()) == 'nlur' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Key_Of_Balance_Actions takes nothing returns nothing
    call RemoveUnit(GetEnteringUnit())
    set udg_KeyOfBalance=true
    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(GetRandomInt(7, 9)), GetOwningPlayer(GetEnteringUnit()), GetUnitLoc(GetEnteringUnit()), bj_UNIT_FACING)
    call AddSpecialEffectLocBJ(GetUnitLoc(GetLastCreatedUnit()), "Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call UnitRemoveAbilityBJ('ACrn', GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_MECHANICAL, GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_MAGIC_IMMUNE, GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_RESISTANT, GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_STRUCTURE, GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_FLYING, GetLastCreatedUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_ANCIENT, GetLastCreatedUnit())
    call UnitAddTypeBJ(UNIT_TYPE_GROUND, GetLastCreatedUnit())
    call UnitRemoveAbilityBJ('ACmi', GetLastCreatedUnit())
    call UnitRemoveAbilityBJ('Amim', GetLastCreatedUnit())
    call BlzSetUnitIntegerFieldBJ(GetLastCreatedUnit(), UNIT_IF_TARGETED_AS, 2)
    call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( 150 * GetHeroLevel(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))]) ))
    call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100)
    call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 10 * GetHeroLevel(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))]) ), 0)
    call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 10 * GetHeroLevel(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))]) ), 1)
    call UnitApplyTimedLifeBJ(45.00, 'BTLF', GetLastCreatedUnit())
endfunction

//===========================================================================
function InitTrig_Key_Of_Balance takes nothing returns nothing
    set gg_trg_Key_Of_Balance=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Key_Of_Balance, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_Key_Of_Balance, Condition(function Trig_Key_Of_Balance_Conditions))
    call TriggerAddAction(gg_trg_Key_Of_Balance, function Trig_Key_Of_Balance_Actions)
endfunction

//===========================================================================
// Trigger: Item Used
//===========================================================================
function Trig_Item_Used_Func001Func001C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I02C' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Item_Used_Func001Func003002003 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) != GetOwningPlayer(GetManipulatingUnit()) )
endfunction

function Trig_Item_Used_Func001Func004A takes nothing returns nothing
    call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()), "Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl")
endfunction

function Trig_Item_Used_Func001C takes nothing returns boolean
    if ( not Trig_Item_Used_Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Func002Func001C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I000' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Item_Used_Func002C takes nothing returns boolean
    if ( not Trig_Item_Used_Func002Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Func003C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Func004Func001C takes nothing returns boolean
    if ( not ( udg_heresy_hero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] == null ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Func004C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I03Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Func005Func001C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'shrs' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'sxpl' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Item_Used_Func005C takes nothing returns boolean
    if ( not Trig_Item_Used_Func005Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Used_Actions takes nothing returns nothing
    if ( Trig_Item_Used_Func001C() ) then
        call UnitDamagePointLoc(GetManipulatingUnit(), 0.01, 250.00, GetUnitLoc(GetManipulatingUnit()), ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetManipulatingUnit()) * 0.25 ), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
        set udg_temp_UnitGroup=GetUnitsInRangeOfLocMatching(250.00, GetUnitLoc(GetManipulatingUnit()), Condition(function Trig_Item_Used_Func001Func003002003))
        call ForGroupBJ(udg_temp_UnitGroup, function Trig_Item_Used_Func001Func004A)
        call DestroyGroup(udg_temp_UnitGroup)
        call SetUnitLifeBJ(GetManipulatingUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetManipulatingUnit()) * 0.75 ))
    else
    endif
    if ( Trig_Item_Used_Func002C() ) then
        call BlzEndUnitAbilityCooldown(GetManipulatingUnit(), udg_Infinity_Tome[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))])
    else
    endif
    if ( Trig_Item_Used_Func003C() ) then
        set udg_temp_Point=GetUnitLoc(GetTriggerUnit())
        call CreateNUnitsAtLoc(1, 'h000', GetOwningPlayer(GetTriggerUnit()), udg_temp_Point, bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(3.20, 'BTLF', GetLastCreatedUnit())
        call UnitAddAbilityBJ('A0MD', GetLastCreatedUnit())
        call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(GetLastCreatedUnit(), 'A0MD'), ABILITY_RLF_HIT_POINTS_GAINED_REJ1, 0, ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetManipulatingUnit()) * 0.70 ))
        call IssueTargetOrderBJ(GetLastCreatedUnit(), "rejuvination", GetTriggerUnit())
        call RemoveLocation(udg_temp_Point)
    else
    endif
    if ( Trig_Item_Used_Func004C() ) then
        if ( Trig_Item_Used_Func004Func001C() ) then
            set udg_heresy_bonus=GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetManipulatingUnit())
            call BlzSetUnitMaxHP(GetManipulatingUnit(), ( BlzGetUnitMaxHP(GetManipulatingUnit()) * 2 ))
            call SetUnitLifeBJ(GetManipulatingUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetManipulatingUnit()) + udg_heresy_bonus ))
            set udg_heresy_hero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=GetManipulatingUnit()
            set udg_temp_real=( BlzGetUnitRealField(GetManipulatingUnit(), UNIT_RF_SCALING_VALUE) * 130.00 )
            call SetUnitScalePercent(GetManipulatingUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
        else
        endif
        call StartTimerBJ(udg_heresy_timer[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))], false, 30.00)
    else
    endif
    if ( Trig_Item_Used_Func005C() ) then
        call SetItemCharges(GetManipulatedItem(), ( GetItemCharges(GetManipulatedItem()) + 1 ))
    else
    endif
endfunction

//===========================================================================
function InitTrig_Item_Used takes nothing returns nothing
    set gg_trg_Item_Used=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Used, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddAction(gg_trg_Item_Used, function Trig_Item_Used_Actions)
endfunction

//===========================================================================
// Trigger: Infinity Tome
//===========================================================================
function Trig_Infinity_Tome_Conditions takes nothing returns boolean
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetSpellAbilityUnit(), 'I000') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Infinity_Tome_Actions takes nothing returns nothing
    set udg_Infinity_Tome[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=GetSpellAbilityId()
endfunction

//===========================================================================
function InitTrig_Infinity_Tome takes nothing returns nothing
    set gg_trg_Infinity_Tome=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Infinity_Tome, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Infinity_Tome, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Infinity_Tome, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_Infinity_Tome, Condition(function Trig_Infinity_Tome_Conditions))
    call TriggerAddAction(gg_trg_Infinity_Tome, function Trig_Infinity_Tome_Actions)
endfunction

//===========================================================================
// Trigger: Staff of Lightning
//===========================================================================
function Trig_Staff_of_Lightning_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'mnsf')) == 'mnsf' ) ) then
        return false
    endif
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) != 'h000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Staff_of_Lightning_Func002Func008003001003001 takes nothing returns boolean
    return ( IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true )
endfunction

function Trig_Staff_of_Lightning_Func002Func008003001003002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_Staff_of_Lightning_Func002Func008003001003 takes nothing returns boolean
    return GetBooleanAnd((IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_Staff_of_Lightning_Func002C takes nothing returns boolean
    if ( not ( udg_chance <= udg_staff_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Staff_of_Lightning_Actions takes nothing returns nothing
    set udg_chance=GetRandomInt(1, 100)
    if ( Trig_Staff_of_Lightning_Func002C() ) then
        set udg_staff_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=7
        call CreateNUnitsAtLoc(1, 'h000', GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellAbilityUnit()), bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(3.20, 'BTLF', GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('thdm', GetLastCreatedUnit())
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbility(GetItemOfTypeFromUnitBJ(GetLastCreatedUnit(), 'thdm'), 'AIcl'), ABILITY_ILF_NUMBER_OF_TARGETS_HIT, 0, 7)
        call BlzSetAbilityRealLevelFieldBJ(BlzGetItemAbility(GetItemOfTypeFromUnitBJ(GetLastCreatedUnit(), 'thdm'), 'AIcl'), ABILITY_RLF_DAMAGE_PER_TARGET_OCL1, 0, 400.00)
        call UnitUseItemTarget(GetLastCreatedUnit(), GetLastCreatedItem(), GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(1000.00, GetUnitLoc(GetLastCreatedUnit()), Condition(function Trig_Staff_of_Lightning_Func002Func008003001003))))
        call TriggerRegisterUnitEvent(gg_trg_clear_drops, GetLastCreatedUnit(), EVENT_UNIT_DROP_ITEM)
    else
        set udg_staff_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=( udg_staff_pseudo_chance[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] + 8 )
    endif
endfunction

//===========================================================================
function InitTrig_Staff_of_Lightning takes nothing returns nothing
    set gg_trg_Staff_of_Lightning=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_Lightning, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Staff_of_Lightning, Condition(function Trig_Staff_of_Lightning_Conditions))
    call TriggerAddAction(gg_trg_Staff_of_Lightning, function Trig_Staff_of_Lightning_Actions)
endfunction

//===========================================================================
// Trigger: clear drops
//===========================================================================
function Trig_clear_drops_Actions takes nothing returns nothing
    call RemoveItem(GetManipulatedItem())
endfunction

//===========================================================================
function InitTrig_clear_drops takes nothing returns nothing
    set gg_trg_clear_drops=CreateTrigger()
    call TriggerAddAction(gg_trg_clear_drops, function Trig_clear_drops_Actions)
endfunction

//===========================================================================
// Trigger: Heart of Aszune
//===========================================================================
function Trig_Heart_of_Aszune_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'azhr')) == 'azhr' ) ) then
        return false
    endif
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Heart_of_Aszune_Func001Func001Func004Func001C takes nothing returns boolean
    if ( not ( GetEnumUnit() != gg_unit_n02S_0002 ) ) then
        return false
    endif
    if ( not ( IsUnitAlly(GetSpellAbilityUnit(), GetOwningPlayer(GetEnumUnit())) == true ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetEnumUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Heart_of_Aszune_Func001Func001Func004A takes nothing returns nothing
    if ( Trig_Heart_of_Aszune_Func001Func001Func004Func001C() ) then
        call AddSpecialEffectTargetUnitBJ("origin", GetEnumUnit(), "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call SetUnitLifeBJ(GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) + ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) * 0.30 ) ))
    else
    endif
endfunction

function Trig_Heart_of_Aszune_Func001Func001C takes nothing returns boolean
    if ( not ( udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Heart_of_Aszune_Func001C takes nothing returns boolean
    if ( not ( udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] < 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Heart_of_Aszune_Actions takes nothing returns nothing
    if ( Trig_Heart_of_Aszune_Func001C() ) then
        set udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=( udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] + 1 )
    else
        if ( Trig_Heart_of_Aszune_Func001Func001C() ) then
            set udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=( udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] + 1 )
            call AddSpecialEffectTargetUnitBJ("hand", GetSpellAbilityUnit(), "Abilities\\Spells\\Other\\HealingSpray\\HealBottleMissile.mdl")
            set udg_item_9_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=GetLastCreatedEffectBJ()
        else
            call DisableTrigger(GetTriggeringTrigger())
            set udg_temp_Point=GetUnitLoc(GetSpellAbilityUnit())
            set udg_temp_UnitGroup=GetUnitsInRangeOfLocAll(600.00, udg_temp_Point)
            call ForGroupBJ(udg_temp_UnitGroup, function Trig_Heart_of_Aszune_Func001Func001Func004A)
            call DestroyGroup(udg_temp_UnitGroup)
            call RemoveLocation(udg_temp_Point)
            call DestroyEffectBJ(udg_item_9_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))])
            set udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=0
            call EnableTrigger(GetTriggeringTrigger())
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Heart_of_Aszune takes nothing returns nothing
    set gg_trg_Heart_of_Aszune=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Heart_of_Aszune, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Heart_of_Aszune, Condition(function Trig_Heart_of_Aszune_Conditions))
    call TriggerAddAction(gg_trg_Heart_of_Aszune, function Trig_Heart_of_Aszune_Actions)
endfunction

//===========================================================================
// Trigger: Helm of Battlethirst
//===========================================================================
function Trig_Helm_of_Battlethirst_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01O' ) ) then
        return false
    endif
    if ( not ( udg_helm_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Helm_of_Battlethirst_Func003001 takes nothing returns boolean
    return ( UnitHasBuffBJ(GetManipulatingUnit(), 'Bbsk') == false )
endfunction

function Trig_Helm_of_Battlethirst_Actions takes nothing returns nothing
    set udg_helm_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=true
    call BlzSetUnitAttackCooldown(GetManipulatingUnit(), ( BlzGetUnitAttackCooldown(GetManipulatingUnit(), 0) / 2.00 ), ( 0 + 0 ))
    loop
        exitwhen ( (UnitHasBuffBJ(GetManipulatingUnit(), 'Bbsk') == false) ) // INLINED!!
        call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.10))
    endloop
    call BlzSetUnitAttackCooldown(GetManipulatingUnit(), ( BlzGetUnitAttackCooldown(GetManipulatingUnit(), 0) * 2.00 ), ( 0 + 0 ))
    set udg_helm_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=false
endfunction

//===========================================================================
function InitTrig_Helm_of_Battlethirst takes nothing returns nothing
    set gg_trg_Helm_of_Battlethirst=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Helm_of_Battlethirst, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Helm_of_Battlethirst, Condition(function Trig_Helm_of_Battlethirst_Conditions))
    call TriggerAddAction(gg_trg_Helm_of_Battlethirst, function Trig_Helm_of_Battlethirst_Actions)
endfunction

//===========================================================================
// Trigger: Bloodfeathers Heart
//===========================================================================
function Trig_Bloodfeathers_Heart_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventTarget == udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))] ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'bfhr') == true ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventTarget, 'A0KD') == 0.00 ) ) then
        return false
    endif
    if ( not ( TimerGetRemaining(udg_ressed_timer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))]) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bloodfeathers_Heart_Func008Func001C takes nothing returns boolean
    if ( not ( GetEnumUnit() != udg_DamageEventTarget ) ) then
        return false
    endif
    if ( not ( GetEnumUnit() != gg_unit_n02S_0002 ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetEnumUnit()) == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) == false ) ) then
        return false
    endif
    if ( not ( BlzIsUnitInvulnerable(GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(GetEnumUnit())) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bloodfeathers_Heart_Func008A takes nothing returns nothing
    if ( Trig_Bloodfeathers_Heart_Func008Func001C() ) then
        call GroupAddUnitSimple(GetEnumUnit(), udg_bloodheart_temp_group)
    else
    endif
endfunction

function Trig_Bloodfeathers_Heart_Func011Func007A takes nothing returns nothing
    call SetUnitLifeBJ(udg_DamageEventTarget, I2R(BlzGetUnitMaxHP(GetEnumUnit())))
    call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()), "Abilities\\Spells\\Orc\\AncestralSpirit\\AncestralSpiritCaster.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Bloodfeathers_Heart_Func011C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(udg_bloodheart_temp_group) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bloodfeathers_Heart_Actions takes nothing returns nothing
    call GroupClear(udg_bloodheart_temp_group)
    set udg_temp_Point=GetUnitLoc(udg_DamageEventTarget)
    set udg_temp_UnitGroup=GetUnitsInRangeOfLocAll(2500.00, udg_temp_Point)
    call ForGroupBJ(udg_temp_UnitGroup, function Trig_Bloodfeathers_Heart_Func008A)
    call DestroyGroup(udg_temp_UnitGroup)
    call RemoveLocation(udg_temp_Point)
    if ( Trig_Bloodfeathers_Heart_Func011C() ) then
        call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_DamageEventTarget)
        call BlzStartUnitAbilityCooldown(udg_DamageEventTarget, 'A0KD', 10.00)
        call UnitAddAbilityBJ('A0NJ', udg_DamageEventTarget)
        call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventTarget, "Abilities\\Spells\\Orc\\Reincarnation\\ReincarnationTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call ForGroupBJ(GetRandomSubGroup(1, udg_bloodheart_temp_group), function Trig_Bloodfeathers_Heart_Func011Func007A)
        call StartTimerBJ(udg_ressed_timer[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))], false, 1.00)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Bloodfeathers_Heart takes nothing returns nothing
    set gg_trg_Bloodfeathers_Heart=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Bloodfeathers_Heart, "udg_LethalDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Bloodfeathers_Heart, Condition(function Trig_Bloodfeathers_Heart_Conditions))
    call TriggerAddAction(gg_trg_Bloodfeathers_Heart, function Trig_Bloodfeathers_Heart_Actions)
endfunction

//===========================================================================
// Trigger: Storm Hammer
//===========================================================================
function Trig_Storm_Hammer_Func002Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'rugt') == true ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetForLoopIndexA()], 'A0JL') == 0.00 ) ) then
        return false
    endif
    if ( not ( udg_stormhammer[GetForLoopIndexA()] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Storm_Hammer_Actions takes nothing returns nothing
    // damage bonus is found in the "on damage" triggger
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Storm_Hammer_Func002Func001C() ) then
            call AddSpecialEffectTargetUnitBJ("weapon", udg_NICKHeroArray[GetForLoopIndexA()], "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl")
            set udg_stormhammer_SpecialEffect[GetForLoopIndexA()]=GetLastCreatedEffectBJ()
            set udg_stormhammer[GetForLoopIndexA()]=1
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Storm_Hammer takes nothing returns nothing
    set gg_trg_Storm_Hammer=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Storm_Hammer, 0.00)
    call TriggerAddAction(gg_trg_Storm_Hammer, function Trig_Storm_Hammer_Actions)
endfunction

//===========================================================================
// Trigger: Crown of the Manalord
//===========================================================================
function Trig_Crown_of_the_Manalord_Func001Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'crdt') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Crown_of_the_Manalord_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Crown_of_the_Manalord_Func001Func001C() ) then
            call SetUnitManaBJ(udg_NICKHeroArray[GetForLoopIndexA()], ( GetUnitStateSwap(UNIT_STATE_MANA, udg_NICKHeroArray[GetForLoopIndexA()]) + ( 0.10 * BlzGetUnitArmor(udg_NICKHeroArray[GetForLoopIndexA()]) ) ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Crown_of_the_Manalord takes nothing returns nothing
    set gg_trg_Crown_of_the_Manalord=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Crown_of_the_Manalord, 0.20)
    call TriggerAddAction(gg_trg_Crown_of_the_Manalord, function Trig_Crown_of_the_Manalord_Actions)
endfunction

//===========================================================================
// Trigger: Wand of Sorcery
//===========================================================================
function Trig_Wand_of_Sorcery_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetSpellAbilityUnit(), 'I02B') == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetSpellAbilityUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityManaCost(GetSpellAbilityUnit(), GetSpellAbilityId(), ( GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()) - 1 )) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Wand_of_Sorcery_Actions takes nothing returns nothing
    // damage bonus is found in the "on damage" triggger
    set udg_item_35[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=( BlzGetUnitAbilityManaCost(GetSpellAbilityUnit(), GetSpellAbilityId(), ( GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()) - 1 )) + ( BlzGetUnitAbilityManaCost(GetSpellAbilityUnit(), GetSpellAbilityId(), ( GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()) - 1 )) / 4 ) )
    call DestroyEffectBJ(udg_item_35_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))])
    call AddSpecialEffectTargetUnitBJ("hand", GetSpellAbilityUnit(), "Abilities\\Weapons\\SpiritOfVengeanceMissile\\SpiritOfVengeanceMissile.mdl")
    set udg_item_35_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=GetLastCreatedEffectBJ()
endfunction

//===========================================================================
function InitTrig_Wand_of_Sorcery takes nothing returns nothing
    set gg_trg_Wand_of_Sorcery=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wand_of_Sorcery, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wand_of_Sorcery, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_Wand_of_Sorcery, Condition(function Trig_Wand_of_Sorcery_Conditions))
    call TriggerAddAction(gg_trg_Wand_of_Sorcery, function Trig_Wand_of_Sorcery_Actions)
endfunction

//===========================================================================
// Trigger: Skeletal Rod
//===========================================================================
function Trig_Skeletal_Rod_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skeletal_Rod_Func004Func004Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitBooleanField(GetLastCreatedUnit(), UNIT_BF_RAISABLE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skeletal_Rod_Func004Func005C takes nothing returns boolean
    if ( not ( BlzGetUnitBooleanField(GetLastCreatedUnit(), UNIT_BF_RAISABLE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skeletal_Rod_Func009A takes nothing returns nothing
    call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
    call GroupRemoveUnitSimple(GetEnumUnit(), udg_ARISsceptercorpes)
endfunction

function Trig_Skeletal_Rod_Actions takes nothing returns nothing
    set udg_ARISscepterflag[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=false
    set udg_ARISkeyFlag[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=true
    set udg_temp_loc=GetUnitLoc(GetTriggerUnit())
    set bj_forLoopBIndex=1
    set bj_forLoopBIndexEnd=4
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        set udg_temp_loc_2=PolarProjectionBJ(udg_temp_loc, 256, ( 90.00 * I2R(GetForLoopIndexB()) ))
        call CreateCorpseLocBJ(ChooseRandomCreepBJ(GetRandomInt(1, 10)), GetOwningPlayer(GetManipulatingUnit()), udg_temp_loc_2)
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_ARISsceptercorpes)
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_Skeletal_Rod_Func004Func004Func001C() ) then
                call RemoveUnit(GetLastCreatedUnit())
                call CreateCorpseLocBJ(ChooseRandomCreepBJ(GetRandomInt(1, 10)), GetOwningPlayer(GetManipulatingUnit()), udg_temp_loc_2)
                call GroupAddUnitSimple(GetLastCreatedUnit(), udg_ARISsceptercorpes)
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        if ( Trig_Skeletal_Rod_Func004Func005C() ) then
            call RemoveUnit(GetLastCreatedUnit())
            call CreateCorpseLocBJ('ucry', GetOwningPlayer(GetManipulatingUnit()), udg_temp_loc_2)
            call GroupAddUnitSimple(GetLastCreatedUnit(), udg_ARISsceptercorpes)
        else
        endif
        call RemoveLocation(udg_temp_loc_2)
        set bj_forLoopBIndex=bj_forLoopBIndex + 1
    endloop
    call RemoveLocation(udg_temp_loc)
    call TriggerSleepAction(0.00)
    set udg_ARISscepterflag[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=true
    set udg_ARISkeyFlag[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=false
    call ForGroupBJ(udg_ARISsceptercorpes, function Trig_Skeletal_Rod_Func009A)
endfunction

//===========================================================================
function InitTrig_Skeletal_Rod takes nothing returns nothing
    set gg_trg_Skeletal_Rod=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Skeletal_Rod, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Skeletal_Rod, Condition(function Trig_Skeletal_Rod_Conditions))
    call TriggerAddAction(gg_trg_Skeletal_Rod, function Trig_Skeletal_Rod_Actions)
endfunction

//===========================================================================
// Trigger: Energy Staff
//===========================================================================
function Trig_Energy_Staff_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetSpellAbilityUnit(), 'I048') == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetSpellAbilityUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( BlzGetAbilityBooleanField(BlzGetUnitAbility(GetSpellAbilityUnit(), GetSpellAbilityId()), ABILITY_BF_ITEM_ABILITY) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Energy_Staff_Actions takes nothing returns nothing
    // damage bonus is found in the "on damage" triggger
    set udg_NICKWandofSorcery[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=1
    call DestroyEffectBJ(udg_item_energy_staff[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))])
    call AddSpecialEffectTargetUnitBJ("hand left", GetSpellAbilityUnit(), "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl")
    set udg_item_energy_staff[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=GetLastCreatedEffectBJ()
endfunction

//===========================================================================
function InitTrig_Energy_Staff takes nothing returns nothing
    set gg_trg_Energy_Staff=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Energy_Staff, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Energy_Staff, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_Energy_Staff, Condition(function Trig_Energy_Staff_Conditions))
    call TriggerAddAction(gg_trg_Energy_Staff, function Trig_Energy_Staff_Actions)
endfunction

//===========================================================================
// Trigger: Energy Staff on dmg
//===========================================================================
function Trig_Energy_Staff_on_dmg_Func016C takes nothing returns boolean
    if ( ( udg_IsDamageMelee == true ) ) then
        return true
    endif
    if ( ( udg_IsDamageRanged == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Energy_Staff_on_dmg_Conditions takes nothing returns boolean
    if ( not ( udg_NICKWandofSorcery[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == 1 ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I048') == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(udg_DamageEventSource) == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventTarget) != GetOwningPlayer(udg_DamageEventSource) ) ) then
        return false
    endif
    if ( not Trig_Energy_Staff_on_dmg_Func016C() ) then
        return false
    endif
    return true
endfunction

function Trig_Energy_Staff_on_dmg_Actions takes nothing returns nothing
    call SetUnitManaBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventSource) + ( 1.00 * udg_DamageEventAmount ) ))
    call DestroyEffectBJ(udg_item_energy_staff[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
    call AddSpecialEffectLocBJ(GetUnitLoc(udg_DamageEventSource), "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call CreateTextTagLocBJ(( "|cff00a0ff+" + ( I2S(R2I(( udg_DamageEventAmount * 1.00 ))) + "" ) ), GetUnitLoc(udg_DamageEventSource), 0, 9.50, 100.00, 100.00, 100.00, 0.00)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 30.00, 90)
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 2.40)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 3.40)
    set udg_NICKWandofSorcery[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]=0
endfunction

//===========================================================================
function InitTrig_Energy_Staff_on_dmg takes nothing returns nothing
    set gg_trg_Energy_Staff_on_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Energy_Staff_on_dmg, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Energy_Staff_on_dmg, Condition(function Trig_Energy_Staff_on_dmg_Conditions))
    call TriggerAddAction(gg_trg_Energy_Staff_on_dmg, function Trig_Energy_Staff_on_dmg_Actions)
endfunction

//===========================================================================
// Trigger: Lightning Javelin
//===========================================================================
function Trig_Lightning_Javelin_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h01D' ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_DamageEventSource) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lightning_Javelin_Actions takes nothing returns nothing
    set udg_DamageEventAmount=GetRandomReal(1.00, 9999.00)
    call KillUnit(udg_DamageEventSource)
    call AddSpecialEffectLocBJ(GetUnitLoc(udg_DamageEventSource), "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

//===========================================================================
function InitTrig_Lightning_Javelin takes nothing returns nothing
    set gg_trg_Lightning_Javelin=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Lightning_Javelin, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Lightning_Javelin, Condition(function Trig_Lightning_Javelin_Conditions))
    call TriggerAddAction(gg_trg_Lightning_Javelin, function Trig_Lightning_Javelin_Actions)
endfunction

//===========================================================================
// Trigger: Orb of Fire
//===========================================================================
function Trig_Orb_of_Fire_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05D' ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetSpellAbilityUnit(), 'I005') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Orb_of_Fire_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h017', GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellAbilityUnit()), bj_UNIT_FACING)
    call IssuePointOrderLocBJ(GetLastCreatedUnit(), "attackground", GetSpellTargetLoc())
    call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
endfunction

//===========================================================================
function InitTrig_Orb_of_Fire takes nothing returns nothing
    set gg_trg_Orb_of_Fire=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Orb_of_Fire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orb_of_Fire, Condition(function Trig_Orb_of_Fire_Conditions))
    call TriggerAddAction(gg_trg_Orb_of_Fire, function Trig_Orb_of_Fire_Actions)
endfunction

//===========================================================================
// Trigger: Orb of Fire on dmg
//===========================================================================
function Trig_Orb_of_Fire_on_dmg_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'h017' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'h018' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Orb_of_Fire_on_dmg_Conditions takes nothing returns boolean
    if ( not Trig_Orb_of_Fire_on_dmg_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Orb_of_Fire_on_dmg_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h017' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != GetOwningPlayer(udg_DamageEventTarget) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Orb_of_Fire_on_dmg_Actions takes nothing returns nothing
    set udg_DamageEventAmount=0.01
    if ( Trig_Orb_of_Fire_on_dmg_Func003C() ) then
        call UnitDamageTargetBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], udg_DamageEventTarget, ( 400.00 + I2R(( GetHeroStatBJ(bj_HEROSTAT_INT, udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], true) * 3 )) ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE)
        call CreateNUnitsAtLoc(1, 'h018', GetOwningPlayer(udg_DamageEventSource), GetUnitLoc(udg_DamageEventTarget), bj_UNIT_FACING)
        call IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", udg_DamageEventTarget)
        call UnitApplyTimedLifeBJ(0.50, 'BTLF', GetLastCreatedUnit())
    else
    endif
endfunction

//===========================================================================
function InitTrig_Orb_of_Fire_on_dmg takes nothing returns nothing
    set gg_trg_Orb_of_Fire_on_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Orb_of_Fire_on_dmg, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Orb_of_Fire_on_dmg, Condition(function Trig_Orb_of_Fire_on_dmg_Conditions))
    call TriggerAddAction(gg_trg_Orb_of_Fire_on_dmg, function Trig_Orb_of_Fire_on_dmg_Actions)
endfunction

//===========================================================================
// Trigger: Orb of Corruption
//===========================================================================
function Trig_Orb_of_Corruption_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05E' ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetSpellAbilityUnit(), 'I02N') == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Orb_of_Corruption_Actions takes nothing returns nothing
    // remove old unit effect---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    call UnitRemoveAbilityBJ('A05F', udg_orb_unit[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))])
    call SetUnitVertexColorBJ(udg_orb_unit[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))], 100.00, 100.00, 100.00, 0)
    set udg_temp_real=( BlzGetUnitRealField(udg_orb_unit[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))], UNIT_RF_SCALING_VALUE) * 100.00 )
    call SetUnitScalePercent(udg_orb_unit[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))], udg_temp_real, udg_temp_real, udg_temp_real)
    // add new------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    call SetUnitVertexColorBJ(GetSpellTargetUnit(), 51.00, 15.00, 77.00, 0)
    call AddSpecialEffectLocBJ(GetUnitLoc(GetSpellTargetUnit()), "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    set udg_temp_real=( BlzGetUnitRealField(GetSpellTargetUnit(), UNIT_RF_SCALING_VALUE) * 120.00 )
    call SetUnitScalePercent(GetSpellTargetUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
    call UnitAddAbilityBJ('A05F', GetSpellTargetUnit())
    set udg_orb_unit[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=GetSpellTargetUnit()
endfunction

//===========================================================================
function InitTrig_Orb_of_Corruption takes nothing returns nothing
    set gg_trg_Orb_of_Corruption=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Orb_of_Corruption, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orb_of_Corruption, Condition(function Trig_Orb_of_Corruption_Conditions))
    call TriggerAddAction(gg_trg_Orb_of_Corruption, function Trig_Orb_of_Corruption_Actions)
endfunction

//===========================================================================
// Trigger: Searing Blade aura taken
//===========================================================================
function Trig_Searing_Blade_aura_taken_Conditions takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]) == true ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnteringUnit()) == GetOwningPlayer(udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]) ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetEnteringUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetEnteringUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Searing_Blade_aura_taken_Actions takes nothing returns nothing
    set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]=4
    call KillUnit(udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))])
endfunction

//===========================================================================
function InitTrig_Searing_Blade_aura_taken takes nothing returns nothing
    set gg_trg_Searing_Blade_aura_taken=CreateTrigger()
    call TriggerAddCondition(gg_trg_Searing_Blade_aura_taken, Condition(function Trig_Searing_Blade_aura_taken_Conditions))
    call TriggerAddAction(gg_trg_Searing_Blade_aura_taken, function Trig_Searing_Blade_aura_taken_Actions)
endfunction

//===========================================================================
// Trigger: Searing Blade aura dies
//===========================================================================
function Trig_Searing_Blade_aura_dies_Conditions takes nothing returns boolean
    if ( not ( udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == GetDyingUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Searing_Blade_aura_dies_Func001C takes nothing returns boolean
    if ( not ( udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] != 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Searing_Blade_aura_dies_Actions takes nothing returns nothing
    if ( Trig_Searing_Blade_aura_dies_Func001C() ) then
        set udg_searingBlade[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=0
        call RemoveUnit(udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))])
    else
    endif
    set udg_searingBlade_auraUnit[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=null
endfunction

//===========================================================================
function InitTrig_Searing_Blade_aura_dies takes nothing returns nothing
    set gg_trg_Searing_Blade_aura_dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Searing_Blade_aura_dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Searing_Blade_aura_dies, Condition(function Trig_Searing_Blade_aura_dies_Conditions))
    call TriggerAddAction(gg_trg_Searing_Blade_aura_dies, function Trig_Searing_Blade_aura_dies_Actions)
endfunction

//===========================================================================
// Trigger: Tome of Heresy
//===========================================================================
function Trig_Tome_of_Heresy_Func001Func001C takes nothing returns boolean
    if ( not ( udg_heresy_hero[GetForLoopIndexA()] != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tome_of_Heresy_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Tome_of_Heresy_Func001Func001C() ) then
            call BlzSetUnitMaxHP(udg_heresy_hero[GetForLoopIndexA()], ( BlzGetUnitMaxHP(udg_heresy_hero[GetForLoopIndexA()]) - R2I(udg_heresy_bonus) ))
            set udg_temp_real=( BlzGetUnitRealField(udg_heresy_hero[GetForLoopIndexA()], UNIT_RF_SCALING_VALUE) * 100.00 )
            call SetUnitScalePercent(udg_heresy_hero[GetForLoopIndexA()], udg_temp_real, udg_temp_real, udg_temp_real)
            set udg_heresy_hero[GetForLoopIndexA()]=null
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Tome_of_Heresy takes nothing returns nothing
    set gg_trg_Tome_of_Heresy=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Tome_of_Heresy, udg_heresy_timer[1])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Tome_of_Heresy, udg_heresy_timer[2])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Tome_of_Heresy, udg_heresy_timer[3])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Tome_of_Heresy, udg_heresy_timer[4])
    call TriggerAddAction(gg_trg_Tome_of_Heresy, function Trig_Tome_of_Heresy_Actions)
endfunction

//===========================================================================
// Trigger: Sundering Blade
//===========================================================================
function Trig_Sundering_Blade_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I02P' ) ) then
        return false
    endif
    if ( not ( udg_sund_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sundering_Blade_Func002001 takes nothing returns boolean
    return ( UnitHasBuffBJ(GetManipulatingUnit(), 'B00K') == false )
endfunction

function Trig_Sundering_Blade_Actions takes nothing returns nothing
    set udg_sund_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=true
    loop
        exitwhen ( (UnitHasBuffBJ(GetManipulatingUnit(), 'B00K') == false) ) // INLINED!!
        call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.10))
    endloop
    set udg_sund_used[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=false
endfunction

//===========================================================================
function InitTrig_Sundering_Blade takes nothing returns nothing
    set gg_trg_Sundering_Blade=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sundering_Blade, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Sundering_Blade, Condition(function Trig_Sundering_Blade_Conditions))
    call TriggerAddAction(gg_trg_Sundering_Blade, function Trig_Sundering_Blade_Actions)
endfunction

//===========================================================================
// Trigger: Cloak of Frost
//===========================================================================
function Trig_Cloak_of_Frost_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0MT' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cloak_of_Frost_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h019', GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellAbilityUnit()), bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "attackonce", GetSpellTargetUnit())
endfunction

//===========================================================================
function InitTrig_Cloak_of_Frost takes nothing returns nothing
    set gg_trg_Cloak_of_Frost=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cloak_of_Frost, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cloak_of_Frost, Condition(function Trig_Cloak_of_Frost_Conditions))
    call TriggerAddAction(gg_trg_Cloak_of_Frost, function Trig_Cloak_of_Frost_Actions)
endfunction

//===========================================================================
// Trigger: Power Staff
//===========================================================================
function Trig_Power_Staff_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0N4' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Power_Staff_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h01C', GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellAbilityUnit()), bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "attackonce", GetSpellTargetUnit())
endfunction

//===========================================================================
function InitTrig_Power_Staff takes nothing returns nothing
    set gg_trg_Power_Staff=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Power_Staff, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Power_Staff, Condition(function Trig_Power_Staff_Conditions))
    call TriggerAddAction(gg_trg_Power_Staff, function Trig_Power_Staff_Actions)
endfunction

//===========================================================================
// Trigger: divinity gauntlet
//===========================================================================
function Trig_divinity_gauntlet_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0MU' ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_Actions takes nothing returns nothing
    call UnitDamagePointLoc(GetSpellAbilityUnit(), 0, 500, GetUnitLoc(GetSpellAbilityUnit()), 1500.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
    call AddSpecialEffectLocBJ(GetUnitLoc(GetSpellAbilityUnit()), "war3mapImported\\FireNova2.mdx")
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 0.80)
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call AddSpecialEffectLocBJ(GetUnitLoc(GetSpellAbilityUnit()), "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

//===========================================================================
function InitTrig_divinity_gauntlet takes nothing returns nothing
    set gg_trg_divinity_gauntlet=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_divinity_gauntlet, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_divinity_gauntlet, Condition(function Trig_divinity_gauntlet_Conditions))
    call TriggerAddAction(gg_trg_divinity_gauntlet, function Trig_divinity_gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: divinity gauntlet periodic
//===========================================================================
function Trig_divinity_gauntlet_periodic_Func001Func001Func002Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexB()], 'I03N') == true ) ) then
        return false
    endif
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetForLoopIndexA())) == 'I03N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_periodic_Func001Func001C takes nothing returns boolean
    if ( not ( udg_player_dead[GetForLoopIndexB()] == false ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('Avul', udg_NICKHeroArray[GetForLoopIndexB()]) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_periodic_Func001Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetForLoopIndexA())) == 'I03R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_periodic_Func001Func002C takes nothing returns boolean
    if ( not ( udg_divinity_gauntlet_dmg[GetForLoopIndexB()] >= GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_NICKHeroArray[GetForLoopIndexB()]) ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexB()], 'I03R') == true ) ) then
        return false
    endif
    if ( not ( udg_player_dead[GetForLoopIndexB()] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_periodic_Actions takes nothing returns nothing
    set bj_forLoopBIndex=1
    set bj_forLoopBIndexEnd=4
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        if ( Trig_divinity_gauntlet_periodic_Func001Func001C() ) then
            set udg_divinity_gauntlet_dmg[GetForLoopIndexB()]=1.00
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_divinity_gauntlet_periodic_Func001Func001Func002Func001C() ) then
                    call RemoveItem(UnitItemInSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetForLoopIndexA()))
                    call UnitAddItemByIdSwapped('I03R', udg_NICKHeroArray[GetForLoopIndexB()])
                    call UnitDropItemSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetLastCreatedItem(), GetForLoopIndexA())
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        if ( Trig_divinity_gauntlet_periodic_Func001Func002C() ) then
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_divinity_gauntlet_periodic_Func001Func002Func001Func001C() ) then
                    call RemoveItem(UnitItemInSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetForLoopIndexA()))
                    call UnitAddItemByIdSwapped('I03N', udg_NICKHeroArray[GetForLoopIndexB()])
                    call UnitDropItemSlotBJ(udg_NICKHeroArray[GetForLoopIndexB()], GetLastCreatedItem(), GetForLoopIndexA())
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        set bj_forLoopBIndex=bj_forLoopBIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_divinity_gauntlet_periodic takes nothing returns nothing
    set gg_trg_divinity_gauntlet_periodic=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_divinity_gauntlet_periodic, 0.00)
    call TriggerAddAction(gg_trg_divinity_gauntlet_periodic, function Trig_divinity_gauntlet_periodic_Actions)
endfunction

//===========================================================================
// Trigger: divinity gauntlet on dmg
//===========================================================================
function Trig_divinity_gauntlet_on_dmg_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'I03R') == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventTarget == udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_divinity_gauntlet_on_dmg_Actions takes nothing returns nothing
    set udg_divinity_gauntlet_dmg[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))]=( udg_divinity_gauntlet_dmg[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventTarget))] + udg_DamageEventAmount )
endfunction

//===========================================================================
function InitTrig_divinity_gauntlet_on_dmg takes nothing returns nothing
    set gg_trg_divinity_gauntlet_on_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_divinity_gauntlet_on_dmg, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_divinity_gauntlet_on_dmg, Condition(function Trig_divinity_gauntlet_on_dmg_Conditions))
    call TriggerAddAction(gg_trg_divinity_gauntlet_on_dmg, function Trig_divinity_gauntlet_on_dmg_Actions)
endfunction

//===========================================================================
// Trigger: Angry Totem
//===========================================================================
function Trig_Angry_Totem_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0MV' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Angry_Totem_Func003Func001C takes nothing returns boolean
    if ( not ( GetHeroStatBJ(bj_HEROSTAT_STR, GetSpellAbilityUnit(), true) >= GetHeroStatBJ(bj_HEROSTAT_AGI, GetSpellAbilityUnit(), true) ) ) then
        return false
    endif
    if ( not ( GetHeroStatBJ(bj_HEROSTAT_STR, GetSpellAbilityUnit(), true) >= GetHeroStatBJ(bj_HEROSTAT_INT, GetSpellAbilityUnit(), true) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Angry_Totem_Func003C takes nothing returns boolean
    if ( not ( udg_angry_totem[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Angry_Totem_Actions takes nothing returns nothing
    if ( Trig_Angry_Totem_Func003C() ) then
        if ( Trig_Angry_Totem_Func003Func001C() ) then
            call BlzSetUnitBaseDamage(GetSpellAbilityUnit(), ( BlzGetUnitBaseDamage(GetSpellAbilityUnit(), 0) + 800 ), 0)
            set udg_angry_totem[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=2
        else
            call BlzSetUnitBaseDamage(GetSpellAbilityUnit(), ( BlzGetUnitBaseDamage(GetSpellAbilityUnit(), 0) + 400 ), 0)
            set udg_angry_totem[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]=1
        endif
    else
    endif
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call AddSpecialEffectLocBJ(GetUnitLoc(GetSpellAbilityUnit()), "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl")
    call StartTimerBJ(udg_angry_totem_timer[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))], false, 11.00)
endfunction

//===========================================================================
function InitTrig_Angry_Totem takes nothing returns nothing
    set gg_trg_Angry_Totem=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Angry_Totem, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Angry_Totem, Condition(function Trig_Angry_Totem_Conditions))
    call TriggerAddAction(gg_trg_Angry_Totem, function Trig_Angry_Totem_Actions)
endfunction

//===========================================================================
// Trigger: angry totem timer
//===========================================================================
function Trig_angry_totem_timer_Func001Func001C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_angry_totem_timer[GetForLoopIndexA()]) <= 0.00 ) ) then
        return false
    endif
    if ( not ( udg_angry_totem[GetForLoopIndexA()] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_angry_totem_timer_Func001Func002C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_angry_totem_timer[GetForLoopIndexA()]) <= 0.00 ) ) then
        return false
    endif
    if ( not ( udg_angry_totem[GetForLoopIndexA()] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_angry_totem_timer_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_angry_totem_timer_Func001Func001C() ) then
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], 0) - 400 ), 0)
            set udg_angry_totem[GetForLoopIndexA()]=0
        else
        endif
        if ( Trig_angry_totem_timer_Func001Func002C() ) then
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[GetForLoopIndexA()], 0) - 800 ), 0)
            set udg_angry_totem[GetForLoopIndexA()]=0
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_angry_totem_timer takes nothing returns nothing
    set gg_trg_angry_totem_timer=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_angry_totem_timer, udg_angry_totem_timer[1])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_angry_totem_timer, udg_angry_totem_timer[2])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_angry_totem_timer, udg_angry_totem_timer[3])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_angry_totem_timer, udg_angry_totem_timer[4])
    call TriggerAddAction(gg_trg_angry_totem_timer, function Trig_angry_totem_timer_Actions)
endfunction

//===========================================================================
// Trigger: demonic blade init
//===========================================================================
function Trig_demonic_blade_init_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call TriggerRegisterTimerExpireEventBJ(gg_trg_demonic_blade, udg_demonic_blade_timer[GetForLoopIndexA()])
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_demonic_blade_init takes nothing returns nothing
    set gg_trg_demonic_blade_init=CreateTrigger()
    call TriggerAddAction(gg_trg_demonic_blade_init, function Trig_demonic_blade_init_Actions)
endfunction

//===========================================================================
// Trigger: demonic blade
//===========================================================================
function Trig_demonic_blade_Func001Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03U') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_demonic_blade_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_demonic_blade_Func001Func001C() ) then
            call SetUnitAbilityLevelSwapped('A0LJ', udg_NICKHeroArray[GetForLoopIndexA()], 1)
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_demonic_blade takes nothing returns nothing
    set gg_trg_demonic_blade=CreateTrigger()
    call TriggerAddAction(gg_trg_demonic_blade, function Trig_demonic_blade_Actions)
endfunction

//===========================================================================
// Trigger: Mask of Death
//===========================================================================
function Trig_Mask_of_Death_Func004C takes nothing returns boolean
    if ( not ( IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(udg_temp_Unit, 'modt') == true ) ) then
        return false
    endif
    if ( not ( UnitHasBuffBJ(udg_temp_Unit, 'B00O') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mask_of_Death_Func005C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventTarget, 'modt') == true ) ) then
        return false
    endif
    if ( not ( BlzGetUnitAbilityCooldownRemaining(udg_DamageEventTarget, 'A0NT') == 0.00 ) ) then
        return false
    endif
    if ( not ( IsUnitAlly(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mask_of_Death_Actions takes nothing returns nothing
    set udg_temp_Unit=udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]
    // Mask of Death------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if ( Trig_Mask_of_Death_Func004C() ) then
        call SetUnitLifeBJ(udg_temp_Unit, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_temp_Unit) + ( udg_DamageEventAmount * 0.20 ) ))
        call AddSpecialEffectTargetUnitBJ("origin", udg_DamageEventSource, "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
    if ( Trig_Mask_of_Death_Func005C() ) then
        call BlzStartUnitAbilityCooldown(udg_DamageEventTarget, 'A0NT', 35.00)
        call CreateNUnitsAtLoc(1, 'h000', GetOwningPlayer(udg_DamageEventTarget), GetUnitLoc(udg_DamageEventTarget), bj_UNIT_FACING)
        call UnitAddAbilityBJ('A0NV', GetLastCreatedUnit())
        call IssueTargetOrderBJ(GetLastCreatedUnit(), "innerfire", udg_DamageEventTarget)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Mask_of_Death takes nothing returns nothing
    set gg_trg_Mask_of_Death=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Mask_of_Death, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddAction(gg_trg_Mask_of_Death, function Trig_Mask_of_Death_Actions)
endfunction

//===========================================================================
// Trigger: Claws of Frenzy
//===========================================================================
function Trig_Claws_of_Frenzy_Func001Func001C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_NickClawsofFrenzyTimer[GetForLoopIndexA()]) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Claws_of_Frenzy_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Claws_of_Frenzy_Func001Func001C() ) then
            set udg_Frenzy[( GetForLoopIndexA() * 10 )]=0
            call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03O'), 0), ABILITY_ILF_ATTACK_BONUS, 0, 0)
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Claws_of_Frenzy takes nothing returns nothing
    set gg_trg_Claws_of_Frenzy=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Claws_of_Frenzy, udg_NickClawsofFrenzyTimer[1])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Claws_of_Frenzy, udg_NickClawsofFrenzyTimer[2])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Claws_of_Frenzy, udg_NickClawsofFrenzyTimer[3])
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Claws_of_Frenzy, udg_NickClawsofFrenzyTimer[4])
    call TriggerAddAction(gg_trg_Claws_of_Frenzy, function Trig_Claws_of_Frenzy_Actions)
endfunction

//===========================================================================
// Trigger: Engulfing Blade
//===========================================================================
function Trig_Engulfing_Blade_Func001Func001Func002002001002001001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002001002 takes nothing returns boolean
    return ( IsUnitIllusionBJ(GetFilterUnit()) == false )
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002001 takes nothing returns boolean
    return GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (IsUnitIllusionBJ(GetFilterUnit()) == false)) // INLINED!!
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002002001 takes nothing returns boolean
    return ( BlzIsUnitInvulnerable(GetFilterUnit()) == false )
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false )
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002002002002 takes nothing returns boolean
    return ( GetFilterUnit() != gg_unit_n02S_0002 )
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false), (GetFilterUnit() != gg_unit_n02S_0002)) // INLINED!!
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002002 takes nothing returns boolean
    return GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) == false), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false), (GetFilterUnit() != gg_unit_n02S_0002)))) // INLINED!!
endfunction

function Trig_Engulfing_Blade_Func001Func001Func002002001002 takes nothing returns boolean
    return GetBooleanAnd((GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (IsUnitIllusionBJ(GetFilterUnit()) == false))), (GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) == false), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false), (GetFilterUnit() != gg_unit_n02S_0002)))))) // INLINED!!
endfunction

function Trig_Engulfing_Blade_Func001Func001Func003C takes nothing returns boolean
    if ( not ( udg_temp_int > 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Engulfing_Blade_Func001Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03I') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Engulfing_Blade_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Engulfing_Blade_Func001Func001C() ) then
            set udg_temp_int=CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_Engulfing_Blade_Func001Func001Func002002001002)))
            if ( Trig_Engulfing_Blade_Func001Func001Func003C() ) then
                set udg_temp_int=30
            else
            endif
            call BlzSetAbilityRealLevelFieldBJ(BlzGetItemAbilityByIndex(GetItemOfTypeFromUnitBJ(udg_NICKHeroArray[GetForLoopIndexA()], 'I03I'), 0), ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1, 0, ( I2R(udg_temp_int) * 0.10 ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Engulfing_Blade takes nothing returns nothing
    set gg_trg_Engulfing_Blade=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Engulfing_Blade, 1.00)
    call TriggerAddAction(gg_trg_Engulfing_Blade, function Trig_Engulfing_Blade_Actions)
endfunction

//===========================================================================
// Trigger: leave
//===========================================================================
function Trig_leave_Func003C takes nothing returns boolean
    if ( not ( IsTriggerEnabled(gg_trg_waves) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_leave_Func009C takes nothing returns boolean
    if ( not ( udg_wave_cleared == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_leave_Actions takes nothing returns nothing
    call RemoveUnit(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
    call SetPlayerStateBJ(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED, 0)
    if ( Trig_leave_Func003C() ) then
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
    endif
    call DisplayTextToForce(GetPlayersAll(), ( "|cffff0000" + ( GetPlayerName(GetTriggerPlayer()) + " has left!|r" ) ))
    set udg_ChoosePlayers=( udg_ChoosePlayers - 1 )
    call EndPlayer(GetTriggerPlayer())
    call ForceRemovePlayerSimple(GetTriggerPlayer(), udg_Activeplayers)
    set udg_Pint=( udg_Pint - 1 )
    if ( Trig_leave_Func009C() ) then
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
    endif
endfunction

//===========================================================================
function InitTrig_leave takes nothing returns nothing
    set gg_trg_leave=CreateTrigger()
    call DisableTrigger(gg_trg_leave)
    call TriggerRegisterPlayerEventLeave(gg_trg_leave, Player(0))
    call TriggerRegisterPlayerEventLeave(gg_trg_leave, Player(1))
    call TriggerRegisterPlayerEventLeave(gg_trg_leave, Player(2))
    call TriggerRegisterPlayerEventLeave(gg_trg_leave, Player(3))
    call TriggerAddAction(gg_trg_leave, function Trig_leave_Actions)
endfunction

//===========================================================================
// Trigger: weather1
//===========================================================================
function Trig_weather1_Actions takes nothing returns nothing
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'SNls')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather1 takes nothing returns nothing
    set gg_trg_weather1=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_weather1, 2.00)
    call TriggerAddAction(gg_trg_weather1, function Trig_weather1_Actions)
endfunction

//===========================================================================
// Trigger: weather2
//===========================================================================
function Trig_weather2_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 14 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather2_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'RAlr')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather2 takes nothing returns nothing
    set gg_trg_weather2=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather2, 10.00)
    call TriggerAddCondition(gg_trg_weather2, Condition(function Trig_weather2_Conditions))
    call TriggerAddAction(gg_trg_weather2, function Trig_weather2_Actions)
endfunction

//===========================================================================
// Trigger: weather3
//===========================================================================
function Trig_weather3_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 21 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather3_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'WOcw')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather3 takes nothing returns nothing
    set gg_trg_weather3=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather3, 10.00)
    call TriggerAddCondition(gg_trg_weather3, Condition(function Trig_weather3_Conditions))
    call TriggerAddAction(gg_trg_weather3, function Trig_weather3_Actions)
endfunction

//===========================================================================
// Trigger: weather4
//===========================================================================
function Trig_weather4_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 28 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather4_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'FDrl')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather4 takes nothing returns nothing
    set gg_trg_weather4=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather4, 10.00)
    call TriggerAddCondition(gg_trg_weather4, Condition(function Trig_weather4_Conditions))
    call TriggerAddAction(gg_trg_weather4, function Trig_weather4_Actions)
endfunction

//===========================================================================
// Trigger: weather5
//===========================================================================
function Trig_weather5_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 35 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather5_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'FDrh')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather5 takes nothing returns nothing
    set gg_trg_weather5=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather5, 10.00)
    call TriggerAddCondition(gg_trg_weather5, Condition(function Trig_weather5_Conditions))
    call TriggerAddAction(gg_trg_weather5, function Trig_weather5_Actions)
endfunction

//===========================================================================
// Trigger: weather6
//===========================================================================
function Trig_weather6_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 42 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather6_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'FDgh')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather6 takes nothing returns nothing
    set gg_trg_weather6=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather6, 10.00)
    call TriggerAddCondition(gg_trg_weather6, Condition(function Trig_weather6_Conditions))
    call TriggerAddAction(gg_trg_weather6, function Trig_weather6_Actions)
endfunction

//===========================================================================
// Trigger: weather7
//===========================================================================
function Trig_weather7_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 49 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather7_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'WNcw')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather7 takes nothing returns nothing
    set gg_trg_weather7=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather7, 10.00)
    call TriggerAddCondition(gg_trg_weather7, Condition(function Trig_weather7_Conditions))
    call TriggerAddAction(gg_trg_weather7, function Trig_weather7_Actions)
endfunction

//===========================================================================
// Trigger: weather8
//===========================================================================
function Trig_weather8_Conditions takes nothing returns boolean
    if ( not ( udg_current_wave > 56 ) ) then
        return false
    endif
    return true
endfunction

function Trig_weather8_Actions takes nothing returns nothing
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'FDwl')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_weather8 takes nothing returns nothing
    set gg_trg_weather8=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_weather8, 10.00)
    call TriggerAddCondition(gg_trg_weather8, Condition(function Trig_weather8_Conditions))
    call TriggerAddAction(gg_trg_weather8, function Trig_weather8_Actions)
endfunction

//===========================================================================
// Trigger: lose condition
//===========================================================================
function Trig_lose_condition_Func001Func006Func001A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_lose_condition_Func001C takes nothing returns boolean
    if ( not ( GetTriggerUnit() == gg_unit_n02S_0002 ) ) then
        return false
    endif
    if ( not ( udg_lost == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_lose_condition_Func002Func001Func003Func001001001002001 takes nothing returns boolean
    return ( GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER )
endfunction

function Trig_lose_condition_Func002Func001Func003Func001001001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_lose_condition_Func002Func001Func003Func001001001002002002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_lose_condition_Func002Func001Func003Func001001001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_lose_condition_Func002Func001Func003Func001001001002 takes nothing returns boolean
    return GetBooleanAnd((GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)))) // INLINED!!
endfunction

function Trig_lose_condition_Func002Func001Func003Func004Func002A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_lose_condition_Func002Func001Func003C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_lose_condition_Func002Func001Func003Func001001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_lose_condition_Func002Func001C takes nothing returns boolean
    if ( not ( udg_lost == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_lose_condition_Func002C takes nothing returns boolean
    if ( not ( GetTriggerUnit() == udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_lose_condition_Actions takes nothing returns nothing
    if ( Trig_lose_condition_Func001C() ) then
        set udg_lost=1
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7435")
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call PanCameraToTimedLocForPlayer(ConvertedPlayer(GetForLoopIndexA()), GetUnitLoc(gg_unit_n02S_0002), 2.00)
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        call SetUnitTimeScalePercent(gg_unit_n02S_0002, 40.00)
        call PlaySoundBJ(gg_snd_QuestFailed)
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())), function Trig_lose_condition_Func001Func006Func001A)
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        set udg_lose_temp_int=1
        loop
            exitwhen udg_lose_temp_int > 5
            call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call TriggerSleepAction(1.00)
            set udg_lose_temp_int=udg_lose_temp_int + 1
        endloop
        call DisplayTimedTextToForce(GetPlayersAll(), 30, ( "|cffff0000You made it to Week " + ( I2S(udg_time_week) + ( " and Day " + ( I2S(udg_time_day) + "!|r" ) ) ) ))
        call TriggerSleepAction(30.00)
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call CustomDefeatBJ(ConvertedPlayer(GetForLoopIndexA()), "TRIGSTR_7449")
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
    endif
    if ( Trig_lose_condition_Func002C() ) then
        if ( Trig_lose_condition_Func002Func001C() ) then
            call DisplayTextToForce(GetPlayersAll(), ( "|cffff0000" + ( GetPlayerName(GetTriggerPlayer()) + "'s Hero has died, and will revive at the end of the round!|r" ) ))
            if ( Trig_lose_condition_Func002Func001Func003C() ) then
                set udg_lost=1
                call SetUnitTimeScalePercent(gg_unit_n02S_0002, 40.00)
                set bj_forLoopAIndex=1
                set bj_forLoopAIndexEnd=4
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    call PanCameraToTimedLocForPlayer(ConvertedPlayer(GetForLoopIndexA()), GetUnitLoc(gg_unit_n02S_0002), 2.00)
                    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())), function Trig_lose_condition_Func002Func001Func003Func004Func002A)
                    set bj_forLoopAIndex=bj_forLoopAIndex + 1
                endloop
                call KillUnit(gg_unit_n02S_0002)
                call PlaySoundBJ(gg_snd_QuestFailed)
                set udg_lose_temp_int=1
                loop
                    exitwhen udg_lose_temp_int > 5
                    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    call TriggerSleepAction(1.00)
                    set udg_lose_temp_int=udg_lose_temp_int + 1
                endloop
                call DisplayTimedTextToForce(GetPlayersAll(), 30, ( "|cffff0000You made it to Week " + ( I2S(udg_time_week) + ( " and Day " + ( I2S(udg_time_day) + "!|r" ) ) ) ))
                call TriggerSleepAction(30.00)
                set bj_forLoopAIndex=1
                set bj_forLoopAIndexEnd=4
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    call CustomDefeatBJ(ConvertedPlayer(GetForLoopIndexA()), "TRIGSTR_072")
                    set bj_forLoopAIndex=bj_forLoopAIndex + 1
                endloop
            else
            endif
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_lose_condition takes nothing returns nothing
    set gg_trg_lose_condition=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_lose_condition, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(gg_trg_lose_condition, function Trig_lose_condition_Actions)
endfunction

//===========================================================================
// Trigger: Walls
//===========================================================================
function Trig_Walls_Func001002002 takes nothing returns boolean
    return ( GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER )
endfunction

function Trig_Walls_Func002Func001Func003Func001C takes nothing returns boolean
    if ( not ( DistanceBetweenPoints(udg_TP, udg_temp_Point) >= 2200.00 ) ) then
        return false
    endif
    if ( not ( TimerGetRemaining(udg_walls_warning_timer) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Walls_Func002Func001Func003Func003C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) <= ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) / 20.00 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Walls_Func002Func001Func003C takes nothing returns boolean
    if ( not ( DistanceBetweenPoints(udg_TP, udg_temp_Point) >= 2500.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Walls_Func002Func001C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(GetEnumUnit()) == true ) ) then
        return false
    endif
    if ( not ( IsUnitDeadBJ(GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( BlzIsUnitInvulnerable(GetEnumUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Walls_Func002A takes nothing returns nothing
    if ( Trig_Walls_Func002Func001C() ) then
        set udg_temp_Point=GetUnitLoc(GetEnumUnit())
        set udg_TP=GetUnitLoc(gg_unit_n02S_0002)
        if ( Trig_Walls_Func002Func001Func003C() ) then
            if ( Trig_Walls_Func002Func001Func003Func003C() ) then
                call SetUnitLifeBJ(GetEnumUnit(), 5.00)
                call UnitDamageTargetBJ(GetEnumUnit(), GetEnumUnit(), 999.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNKNOWN)
            else
                call SetUnitLifePercentBJ(GetEnumUnit(), ( GetUnitLifePercent(GetEnumUnit()) - 5.00 ))
            endif
            call AddSpecialEffectLocBJ(udg_temp_Point, "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
            if ( Trig_Walls_Func002Func001Func003Func001C() ) then
                call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "TRIGSTR_7475")
                call StartTimerBJ(udg_walls_warning_timer, false, 60.00)
            else
            endif
        endif
        call RemoveLocation(udg_temp_Point)
        call RemoveLocation(udg_TP)
    else
    endif
endfunction

function Trig_Walls_Actions takes nothing returns nothing
    set udg_UG=GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_Walls_Func001002002))
    call ForGroupBJ(udg_UG, function Trig_Walls_Func002A)
    call DestroyGroup(udg_UG)
endfunction

//===========================================================================
function InitTrig_Walls takes nothing returns nothing
    set gg_trg_Walls=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Walls, 0.50)
    call TriggerAddAction(gg_trg_Walls, function Trig_Walls_Actions)
endfunction

//===========================================================================
// Trigger: obelisk takes dmg
//===========================================================================
function Trig_obelisk_takes_dmg_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventTarget == gg_unit_n02S_0002 ) ) then
        return false
    endif
    return true
endfunction

function Trig_obelisk_takes_dmg_Func001Func001C takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_obelisk_takes_dmg_Func001C takes nothing returns boolean
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_obelisk_takes_dmg_Actions takes nothing returns nothing
    if ( Trig_obelisk_takes_dmg_Func001C() ) then
        set udg_DamageEventAmount=0.00
    else
        if ( Trig_obelisk_takes_dmg_Func001Func001C() ) then
            set udg_DamageEventAmount=( udg_DamageEventAmount / 50.00 )
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_obelisk_takes_dmg takes nothing returns nothing
    set gg_trg_obelisk_takes_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_obelisk_takes_dmg, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_obelisk_takes_dmg, Condition(function Trig_obelisk_takes_dmg_Conditions))
    call TriggerAddAction(gg_trg_obelisk_takes_dmg, function Trig_obelisk_takes_dmg_Actions)
endfunction

//===========================================================================
// Trigger: obelisk prevent focus
//===========================================================================
function Trig_obelisk_prevent_focus_Func004001001003001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_obelisk_prevent_focus_Func004001001003002001 takes nothing returns boolean
    return ( GetFilterUnit() != gg_unit_n02S_0002 )
endfunction

function Trig_obelisk_prevent_focus_Func004001001003002002 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) == Player(0) )
endfunction

function Trig_obelisk_prevent_focus_Func004001001003002 takes nothing returns boolean
    return GetBooleanAnd((GetFilterUnit() != gg_unit_n02S_0002), (GetOwningPlayer(GetFilterUnit()) == Player(0))) // INLINED!!
endfunction

function Trig_obelisk_prevent_focus_Func004001001003 takes nothing returns boolean
    return GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (GetBooleanAnd((GetFilterUnit() != gg_unit_n02S_0002), (GetOwningPlayer(GetFilterUnit()) == Player(0))))) // INLINED!!
endfunction

function Trig_obelisk_prevent_focus_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventTarget == gg_unit_n02S_0002 ) ) then
        return false
    endif
    if ( not ( udg_IsDamageSpell == false ) ) then
        return false
    endif
    if ( not ( CountUnitsInGroup(GetUnitsInRangeOfLocMatching(800.00, GetUnitLoc(udg_DamageEventSource), Condition(function Trig_obelisk_prevent_focus_Func004001001003))) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_obelisk_prevent_focus_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(udg_DamageEventSource, "stop")
endfunction

//===========================================================================
function InitTrig_obelisk_prevent_focus takes nothing returns nothing
    set gg_trg_obelisk_prevent_focus=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_obelisk_prevent_focus, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_obelisk_prevent_focus, Condition(function Trig_obelisk_prevent_focus_Conditions))
    call TriggerAddAction(gg_trg_obelisk_prevent_focus, function Trig_obelisk_prevent_focus_Actions)
endfunction

//===========================================================================
// Trigger: sound deaths
//===========================================================================
function Trig_sound_deaths_Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetDyingUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_sound_deaths_Conditions takes nothing returns boolean
    if ( not Trig_sound_deaths_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_sound_deaths_Func002Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetDyingUnit()) == 'H00I' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetDyingUnit()) == 'N02V' ) ) then
        return true
    endif
    return false
endfunction

function Trig_sound_deaths_Func002C takes nothing returns boolean
    if ( not Trig_sound_deaths_Func002Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_sound_deaths_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'H00Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_sound_deaths_Actions takes nothing returns nothing
    if ( Trig_sound_deaths_Func002C() ) then
        call PlaySoundOnUnitBJ(gg_snd_BrewMasterDeath1, 100, GetDyingUnit())
    else
    endif
    if ( Trig_sound_deaths_Func003C() ) then
        call SetSoundPitchBJ(gg_snd_TuskarrDeath1, GetRandomReal(0.90, 1.00))
        call PlaySoundOnUnitBJ(gg_snd_TuskarrDeath1, 100, GetDyingUnit())
    else
    endif
endfunction

//===========================================================================
function InitTrig_sound_deaths takes nothing returns nothing
    set gg_trg_sound_deaths=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_sound_deaths, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_sound_deaths, Condition(function Trig_sound_deaths_Conditions))
    call TriggerAddAction(gg_trg_sound_deaths, function Trig_sound_deaths_Actions)
endfunction

//===========================================================================
// Trigger: fel spawns
//===========================================================================
function Trig_fel_spawns_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetEnteringUnit()) == 'n00A' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnteringUnit()) == 'n00H' ) ) then
        return true
    endif
    return false
endfunction

function Trig_fel_spawns_Conditions takes nothing returns boolean
    if ( not Trig_fel_spawns_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_fel_spawns_Actions takes nothing returns nothing
    call SetUnitVertexColorBJ(GetEnteringUnit(), 0.00, 100.00, 0.00, 0)
endfunction

//===========================================================================
function InitTrig_fel_spawns takes nothing returns nothing
    set gg_trg_fel_spawns=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_fel_spawns, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_fel_spawns, Condition(function Trig_fel_spawns_Conditions))
    call TriggerAddAction(gg_trg_fel_spawns, function Trig_fel_spawns_Actions)
endfunction

//===========================================================================
// Trigger: doodads
//===========================================================================
function Trig_doodads_Func001A takes nothing returns nothing
    call TriggerRegisterDeathEvent(gg_trg_doodads_die, GetEnumDestructable())
endfunction

function Trig_doodads_Actions takes nothing returns nothing
    call EnumDestructablesInRectAll(GetPlayableMapRect(), function Trig_doodads_Func001A)
endfunction

//===========================================================================
function InitTrig_doodads takes nothing returns nothing
    set gg_trg_doodads=CreateTrigger()
    call TriggerAddAction(gg_trg_doodads, function Trig_doodads_Actions)
endfunction

//===========================================================================
// Trigger: doodads die
//===========================================================================
function Trig_doodads_die_Actions takes nothing returns nothing
    call TriggerSleepAction(10.00)
    call DestructableRestoreLife(GetDyingDestructable(), GetDestructableMaxLife(GetLastCreatedDestructable()), true)
endfunction

//===========================================================================
function InitTrig_doodads_die takes nothing returns nothing
    set gg_trg_doodads_die=CreateTrigger()
    call TriggerAddAction(gg_trg_doodads_die, function Trig_doodads_die_Actions)
endfunction

//===========================================================================
// Trigger: trigger tk prevent
//===========================================================================
function Trig_trigger_tk_prevent_Conditions takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) ) ) then
        return false
    endif
    if ( not ( udg_IsDamageMelee == false ) ) then
        return false
    endif
    if ( not ( udg_IsDamageRanged == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_trigger_tk_prevent_Actions takes nothing returns nothing
    set udg_DamageEventAmount=0.00
endfunction

//===========================================================================
function InitTrig_trigger_tk_prevent takes nothing returns nothing
    set gg_trg_trigger_tk_prevent=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_trigger_tk_prevent, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_trigger_tk_prevent, Condition(function Trig_trigger_tk_prevent_Conditions))
    call TriggerAddAction(gg_trg_trigger_tk_prevent, function Trig_trigger_tk_prevent_Actions)
endfunction

//===========================================================================
// Trigger: permanent immo bug fix
//===========================================================================
function Trig_permanent_immo_bug_fix_Func001Func001C takes nothing returns boolean
    if ( not ( BlzIsUnitInvulnerable(udg_NICKHeroArray[GetForLoopIndexA()]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_permanent_immo_bug_fix_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_permanent_immo_bug_fix_Func001Func001C() ) then
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0JJ', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0JJ', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0J0', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0J0', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IV', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IV', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IW', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IW', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IX', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IX', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0JF', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0JF', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IZ', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A0IZ', false, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A02D', true, true)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'A02D', false, true)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'AIcf', true, false)
            call BlzUnitDisableAbility(udg_NICKHeroArray[GetForLoopIndexA()], 'AIcf', false, false)
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_permanent_immo_bug_fix takes nothing returns nothing
    set gg_trg_permanent_immo_bug_fix=CreateTrigger()
    call TriggerAddAction(gg_trg_permanent_immo_bug_fix, function Trig_permanent_immo_bug_fix_Actions)
endfunction

//===========================================================================
// Trigger: perm immo ability effect
//===========================================================================
function Trig_perm_immo_ability_effect_Func002Func001Func003Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexB()], udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_perm_immo_ability_effect_Func002Func001Func005C takes nothing returns boolean
    if ( ( GetUnitAbilityLevelSwapped('A0JJ', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0J0', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0IV', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0IW', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0IX', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0JF', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    if ( ( GetUnitAbilityLevelSwapped('A0IZ', udg_NICKHeroArray[GetForLoopIndexA()]) > 0 ) ) then
        return true
    endif
    return false
endfunction

function Trig_perm_immo_ability_effect_Func002Func001C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_NICKHeroArray[GetForLoopIndexA()]) == true ) ) then
        return false
    endif
    if ( not Trig_perm_immo_ability_effect_Func002Func001Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_perm_immo_ability_effect_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_perm_immo_ability_effect_Func002Func001C() ) then
            call UnitAddAbilityBJ('A0L8', udg_NICKHeroArray[GetForLoopIndexA()])
            set bj_forLoopBIndex=363
            set bj_forLoopBIndexEnd=370
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                if ( Trig_perm_immo_ability_effect_Func002Func001Func003Func001C() ) then
                    call UnitDamagePointLoc(udg_NICKHeroArray[GetForLoopIndexA()], 0.01, 220.00, GetUnitLoc(udg_NICKHeroArray[GetForLoopIndexA()]), ( I2R(( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexB()], udg_NICKHeroArray[GetForLoopIndexA()]) * 6 )) + 4.00 ), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE)
                else
                endif
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
            call UnitRemoveAbilityBJ('A0L8', udg_NICKHeroArray[GetForLoopIndexA()])
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_perm_immo_ability_effect takes nothing returns nothing
    set gg_trg_perm_immo_ability_effect=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_perm_immo_ability_effect, 1.01)
    call TriggerAddAction(gg_trg_perm_immo_ability_effect, function Trig_perm_immo_ability_effect_Actions)
endfunction

//===========================================================================
// Trigger: illusion stat fix
//===========================================================================
function Trig_illusion_stat_fix_Conditions takes nothing returns boolean
    if ( not ( IsUnitIllusionBJ(GetEnteringUnit()) == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnteringUnit()) == GetUnitTypeId(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]) ) ) then
        return false
    endif
    return true
endfunction

function Trig_illusion_stat_fix_Actions takes nothing returns nothing
    set udg_temp_Unit=udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))]
    call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_SET, GetHeroStatBJ(bj_HEROSTAT_STR, udg_temp_Unit, false))
    call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_SET, GetHeroStatBJ(bj_HEROSTAT_AGI, udg_temp_Unit, false))
    call ModifyHeroStat(bj_HEROSTAT_INT, GetTriggerUnit(), bj_MODIFYMETHOD_SET, GetHeroStatBJ(bj_HEROSTAT_INT, udg_temp_Unit, false))
    call BlzSetUnitArmor(GetEnteringUnit(), BlzGetUnitArmor(udg_temp_Unit))
    call BlzSetUnitBaseDamage(GetEnteringUnit(), BlzGetUnitBaseDamage(udg_temp_Unit, 0), 0)
    call BlzSetUnitAttackCooldown(GetEnteringUnit(), BlzGetUnitAttackCooldown(udg_temp_Unit, 0), ( 0 + 0 ))
    call BlzSetUnitDiceNumber(GetEnteringUnit(), BlzGetUnitDiceNumber(udg_temp_Unit, 0), 0)
    call BlzSetUnitDiceSides(GetEnteringUnit(), BlzGetUnitDiceSides(udg_temp_Unit, 0), 0)
    call SetUnitMoveSpeed(GetTriggerUnit(), GetUnitMoveSpeed(udg_temp_Unit))
    call BlzSetUnitMaxHP(GetTriggerUnit(), BlzGetUnitMaxHP(udg_temp_Unit))
    call BlzSetUnitMaxMana(GetTriggerUnit(), BlzGetUnitMaxMana(udg_temp_Unit))
endfunction

//===========================================================================
function InitTrig_illusion_stat_fix takes nothing returns nothing
    set gg_trg_illusion_stat_fix=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_illusion_stat_fix, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_illusion_stat_fix, Condition(function Trig_illusion_stat_fix_Conditions))
    call TriggerAddAction(gg_trg_illusion_stat_fix, function Trig_illusion_stat_fix_Actions)
endfunction

//===========================================================================
// Trigger: bonus leveling hero
//===========================================================================
function Trig_bonus_leveling_hero_Conditions takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_bonus_leveling_hero_Func002Func004C takes nothing returns boolean
    if ( not ( IsUnitType(GetLevelingUnit(), UNIT_TYPE_RANGED_ATTACKER) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_bonus_leveling_hero_Func003C takes nothing returns boolean
    if ( not ( ( ( GetHeroLevel(GetTriggerUnit()) / 25 ) - 3 ) > udg_HeroXP[GetConvertedPlayerId(GetTriggerPlayer())] ) ) then
        return false
    endif
    return true
endfunction

function Trig_bonus_leveling_hero_Actions takes nothing returns nothing
    set bj_forLoopAIndex=( udg_NICKLevelUpFix[GetConvertedPlayerId(GetOwningPlayer(GetLevelingUnit()))] + 1 )
    set bj_forLoopAIndexEnd=GetHeroLevel(GetLevelingUnit())
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ModifyHeroStat(bj_HEROSTAT_STR, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, udg_reward_stats_perlvl[( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 1 )])
        call ModifyHeroStat(bj_HEROSTAT_INT, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, udg_reward_stats_perlvl[( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 2 )])
        call ModifyHeroStat(bj_HEROSTAT_AGI, GetTriggerUnit(), bj_MODIFYMETHOD_ADD, udg_reward_stats_perlvl[( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 3 )])
        if ( Trig_bonus_leveling_hero_Func002Func004C() ) then
            call BlzSetUnitMaxHP(GetLevelingUnit(), ( BlzGetUnitMaxHP(GetLevelingUnit()) + 15 ))
            call SetUnitLifeBJ(GetLevelingUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetLevelingUnit()) + 15.00 ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if ( Trig_bonus_leveling_hero_Func003C() ) then
        call SetPlayerHandicapXPBJ(ConvertedPlayer(GetConvertedPlayerId(GetTriggerPlayer())), ( GetPlayerHandicapXPBJ(ConvertedPlayer(GetConvertedPlayerId(GetTriggerPlayer()))) / 2.00 ))
        set udg_HeroXP[GetConvertedPlayerId(GetTriggerPlayer())]=1
    else
    endif
    call TriggerSleepAction(0.10)
    set udg_NICKLevelUpFix[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetHeroLevel(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_bonus_leveling_hero takes nothing returns nothing
    set gg_trg_bonus_leveling_hero=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_bonus_leveling_hero, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(gg_trg_bonus_leveling_hero, Condition(function Trig_bonus_leveling_hero_Conditions))
    call TriggerAddAction(gg_trg_bonus_leveling_hero, function Trig_bonus_leveling_hero_Actions)
endfunction

//===========================================================================
// Trigger: Tips
//===========================================================================
function Trig_Tips_Actions takes nothing returns nothing
    call TriggerSleepAction(20.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_7434")
    call TriggerSleepAction(100.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_10483")
    call TriggerSleepAction(100.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_7456")
    call TriggerSleepAction(140.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_10484")
    call TriggerSleepAction(120.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_10485")
    call TriggerSleepAction(120.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_2541")
    call TriggerSleepAction(120.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_5105")
    call TriggerSleepAction(120.00)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_6273")
endfunction

//===========================================================================
function InitTrig_Tips takes nothing returns nothing
    set gg_trg_Tips=CreateTrigger()
    call TriggerAddAction(gg_trg_Tips, function Trig_Tips_Actions)
endfunction

//===========================================================================
// Trigger: Repair Pillar Item
//===========================================================================
function Trig_Repair_Pillar_Item_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Repair_Pillar_Item_Actions takes nothing returns nothing
    call SetUnitLifeBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) + 500.00 ))
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

//===========================================================================
function InitTrig_Repair_Pillar_Item takes nothing returns nothing
    set gg_trg_Repair_Pillar_Item=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Repair_Pillar_Item, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Repair_Pillar_Item, Condition(function Trig_Repair_Pillar_Item_Conditions))
    call TriggerAddAction(gg_trg_Repair_Pillar_Item, function Trig_Repair_Pillar_Item_Actions)
endfunction

//===========================================================================
// Trigger: Item Reroll
//===========================================================================
function Trig_Item_Reroll_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I040' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Reroll_Func007Func030Func001Func001C takes nothing returns boolean
    if ( not ( udg_chance == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Reroll_Func007Func030Func001C takes nothing returns boolean
    if ( not ( udg_chance == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Reroll_Func007Func030C takes nothing returns boolean
    if ( not ( udg_chance == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Reroll_Func007C takes nothing returns boolean
    if ( not ( IsTriggerEnabled(gg_trg_goldshare) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Reroll_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=30
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItemFromStockBJ(udg_Draft_item_options1[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options2[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options3[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options4[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options5[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_pillar_item_type[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tdex', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tstr', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tint', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('I04B', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('I040', gg_unit_n02S_0002)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call UnitRemoveAbilityBJ('Ane2', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Asid', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Asud', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Apit', gg_unit_n02S_0002)
    call TriggerSleepAction(0.50)
    if ( Trig_Item_Reroll_Func007C() ) then
        call UnitAddAbilityBJ('Ane2', gg_unit_n02S_0002)
        call UnitAddAbilityBJ('Asid', gg_unit_n02S_0002)
        call UnitAddAbilityBJ('Asud', gg_unit_n02S_0002)
        call UnitAddAbilityBJ('Apit', gg_unit_n02S_0002)
        set udg_chance=GetRandomInt(1, 23)
        set udg_prevchance=udg_chance
        set udg_shop_cheapitem_type=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount=GetRandomInt(1, ( 2 + ( udg_current_wave / 10 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount)
        loop
        set udg_chance=GetRandomInt(1, 23)
        exitwhen udg_chance != udg_prevchance
        endloop
        set udg_shop_cheapitem_type_2=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount_2=GetRandomInt(1, ( 2 + ( udg_current_wave / 10 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type_2, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount_2)
        loop
        set udg_chance=GetRandomInt(1, 23)
        exitwhen udg_chance != udg_prevchance
        endloop
        set udg_shop_cheapitem_type_3=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount_3=GetRandomInt(1, ( 2 + ( udg_current_wave / 10 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type_3, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount_3)
        call AddItemToStockBJ(udg_Draft_item_options2[GetRandomInt(1, 18)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options3[GetRandomInt(1, 19)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options4[GetRandomInt(1, 16)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options5[GetRandomInt(1, 17)], gg_unit_n02S_0002, 1, 1)
        set udg_chance=GetRandomInt(1, 3)
        if ( Trig_Item_Reroll_Func007Func030C() ) then
            call AddItemToStockBJ('tdex', gg_unit_n02S_0002, 1, 1)
        else
            if ( Trig_Item_Reroll_Func007Func030Func001C() ) then
                call AddItemToStockBJ('tstr', gg_unit_n02S_0002, 1, 1)
            else
                if ( Trig_Item_Reroll_Func007Func030Func001Func001C() ) then
                    call AddItemToStockBJ('tint', gg_unit_n02S_0002, 1, 1)
                else
                endif
            endif
        endif
        call AddItemToStockBJ('I04B', gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ('I040', gg_unit_n02S_0002, 0, 1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Item_Reroll takes nothing returns nothing
    set gg_trg_Item_Reroll=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Reroll, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(gg_trg_Item_Reroll, Condition(function Trig_Item_Reroll_Conditions))
    call TriggerAddAction(gg_trg_Item_Reroll, function Trig_Item_Reroll_Actions)
endfunction

//===========================================================================
// Trigger: set random heroes
//===========================================================================
function Trig_set_random_heroes_Actions takes nothing returns nothing
    set udg_random_heroes[1]='Hpal'
    set udg_random_heroes[2]='Hmkg'
    set udg_random_heroes[3]='N02W'
    set udg_random_heroes[4]='Obla'
    set udg_random_heroes[5]='Ofar'
    set udg_random_heroes[6]='H01P'
    set udg_random_heroes[7]='H01X'
    set udg_random_heroes[8]='Udre'
    set udg_random_heroes[9]='U00L'
    set udg_random_heroes[10]='Ekee'
    set udg_random_heroes[11]='H01J'
    set udg_random_heroes[12]='Edem'
    set udg_random_heroes[13]='H021'
    set udg_random_heroes[14]='Nalc'
    set udg_random_heroes[15]='Ntin'
    set udg_random_heroes[16]='Nbst'
    set udg_random_heroes[17]='Nfir'
    set udg_random_heroes[18]='Npbm'
    set udg_random_heroes[19]='Nbrn'
    set udg_random_heroes[20]='H01K'
    set udg_random_heroes[21]='H00D'
    set udg_random_heroes[22]='H00F'
    set udg_random_heroes[23]='H00G'
    set udg_random_heroes[24]='H01L'
    set udg_random_heroes[25]='H00E'
    set udg_random_heroes[26]='H00I'
    set udg_random_heroes[27]='Hamg'
    set udg_random_heroes[28]='H00L'
    set udg_random_heroes[29]='H01I'
    set udg_random_heroes[30]='H00O'
    set udg_random_heroes[31]='H00P'
    set udg_random_heroes[32]='H00R'
    set udg_random_heroes[33]='H01B'
    set udg_random_heroes[34]='U00H'
    set udg_random_heroes[35]='Udea'
    set udg_random_heroes[36]='Nngs'
    set udg_random_heroes[37]='U00I'
    set udg_random_heroes[38]='N02V'
    set udg_random_heroes[39]='H01A'
    set udg_random_heroes[40]='H01Y'
    set udg_random_heroes[41]='H020'
    set udg_random_heroes[42]='E00A'
    set udg_random_heroes[43]='E00B'
    set udg_random_heroes[44]='U00N'
    set udg_random_heroes[45]='H00N'
endfunction

//===========================================================================
function InitTrig_set_random_heroes takes nothing returns nothing
    set gg_trg_set_random_heroes=CreateTrigger()
    call TriggerAddAction(gg_trg_set_random_heroes, function Trig_set_random_heroes_Actions)
endfunction

//===========================================================================
// Trigger: start
//===========================================================================
function Trig_start_Func003001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func003A takes nothing returns nothing
    set udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]=GetEnumUnit()
endfunction

function Trig_start_Func020Func002Func001C takes nothing returns boolean
    if ( not ( SubStringBJ(udg_temp_string, ( StringLength(udg_temp_string) - GetForLoopIndexA() ), ( StringLength(udg_temp_string) - GetForLoopIndexA() )) == "#" ) ) then
        return false
    endif
    return true
endfunction

function Trig_start_Func020A takes nothing returns nothing
    set udg_temp_string=GetPlayerName(GetEnumPlayer())
    set bj_forLoopAIndex=3
    set bj_forLoopAIndexEnd=10
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_start_Func020Func002Func001C() ) then
            set udg_temp_string=SubStringBJ(udg_temp_string, 1, ( StringLength(udg_temp_string) - ( GetForLoopIndexA() + 1 ) ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call SetPlayerName(GetEnumPlayer(), udg_temp_string)
    set udg_Pcolorname[GetConvertedPlayerId(GetEnumPlayer())]=( udg_player_colors[GetConvertedPlayerId(GetEnumPlayer())] + ( udg_temp_string + "|r" ) )
endfunction

function Trig_start_Func051Func001001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func051Func001001002002002 takes nothing returns boolean
    return ( BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 3 )
endfunction

function Trig_start_Func051Func001001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 3)) // INLINED!!
endfunction

function Trig_start_Func051Func001A takes nothing returns nothing
    set udg_X=( udg_X + 1 )
    call AddUnitToStockBJ(GetUnitTypeId(GetEnumUnit()), udg_Draft_hero_building[1], 1, 1)
    set udg_ut[udg_X]=GetUnitTypeId(GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_start_Func051Func002001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func051Func002001002002002 takes nothing returns boolean
    return ( BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 1 )
endfunction

function Trig_start_Func051Func002001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 1)) // INLINED!!
endfunction

function Trig_start_Func051Func002A takes nothing returns nothing
    set udg_X=( udg_X + 1 )
    call AddUnitToStockBJ(GetUnitTypeId(GetEnumUnit()), udg_Draft_hero_building[1], 1, 1)
    set udg_ut[udg_X]=GetUnitTypeId(GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_start_Func051Func003001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func051Func003001002002002 takes nothing returns boolean
    return ( BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 2 )
endfunction

function Trig_start_Func051Func003001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (BlzGetUnitIntegerField(GetFilterUnit(), UNIT_IF_PRIMARY_ATTRIBUTE) == 2)) // INLINED!!
endfunction

function Trig_start_Func051Func003A takes nothing returns nothing
    set udg_X=( udg_X + 1 )
    call AddUnitToStockBJ(GetUnitTypeId(GetEnumUnit()), udg_Draft_hero_building[1], 1, 1)
    set udg_ut[udg_X]=GetUnitTypeId(GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_start_Func051Func004001002002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func051Func004A takes nothing returns nothing
    set udg_X=( udg_X + 1 )
    call AddUnitToStockBJ(GetUnitTypeId(GetEnumUnit()), udg_Draft_hero_building[1], 1, 1)
    set udg_ut[udg_X]=GetUnitTypeId(GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_start_Func052001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_start_Func052A takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_start_Actions takes nothing returns nothing
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_3496", "TRIGSTR_3497", "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_6432", "TRIGSTR_6737", "ReplaceableTextures\\CommandButtons\\BTNTomeRedBlood.blp")
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func003001002)), function Trig_start_Func003A)
    // this is for testing purposes---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(20))
    call CinematicModeBJ(true, GetPlayersAll())
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 0.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
    call SetAmbientDaySound("LordaeronFallDay")
    call SetAmbientNightSound("LordaeronFallNight")
    set udg_GetLocalPlayer=GetLocalPlayer()
    set udg_player_colors[1]="|cffff0000"
    set udg_player_colors[2]="|cff004aff"
    set udg_player_colors[3]="|cff00ffff"
    set udg_player_colors[4]="|cffa139e7"
    set udg_player_colors[5]="|cffffff00"
    set udg_player_colors[6]="|cffff7200"
    set udg_player_colors[7]="|cff00ff00"
    set udg_player_colors[8]="|cffff5a9d"
    call BlzChangeMinimapTerrainTex("war3mapImported\\miniMap.blp")
    call ForForce(GetPlayersAll(), function Trig_start_Func020A)
    call BlzLoadTOCFile("BoxedText.toc")
    call InitHashtableBJ()
    set udg_maxabilities=GetLastCreatedHashtableBJ()
    call InitHashtableBJ()
    set udg_floating_text_table=GetLastCreatedHashtableBJ()
    call InitHashtableBJ()
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_Draft_hero_building[GetForLoopIndexA()]=gg_unit_n02S_0002
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call StopMusicBJ(false)
    call StartMeleeAI(Player(20), "")
    call DisplayTimedTextToForce(GetPlayersAll(), 8.00, "TRIGSTR_11642")
    call DisplayTimedTextToForce(GetPlayersAll(), 8.00, "TRIGSTR_11618")
    call TriggerSleepAction(1.00)
    call DisplayTimedTextToForce(GetPlayersAll(), 7.00, "TRIGSTR_11619")
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call CameraSetupApplyForPlayer(true, gg_cam_Camera_001, ConvertedPlayer(GetForLoopIndexA()), 0)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 3.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
    call PlayThematicMusicBJ("DarkAgents")
    call TriggerSleepAction(4.00)
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 3.00)
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call AddUnitAnimationPropertiesBJ(true, "alternate", gg_unit_n02S_0002)
    call TriggerSleepAction(1.00)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ResetToGameCameraForPlayer(ConvertedPlayer(GetForLoopIndexA()), 2.00)
        call SetCameraFieldForPlayer(ConvertedPlayer(GetForLoopIndexA()), CAMERA_FIELD_TARGET_DISTANCE, 2700.00, 2.00)
        call PanCameraToTimedLocForPlayer(ConvertedPlayer(GetForLoopIndexA()), GetUnitLoc(gg_unit_n02S_0002), 2.00)
        call CreateNUnitsAtLoc(1, 'h000', ConvertedPlayer(GetForLoopIndexA()), GetUnitLoc(gg_unit_n02S_0002), bj_UNIT_FACING)
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_heropicker)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call CinematicModeBJ(false, GetPlayersAll())
    call TriggerExecute(gg_trg_DraftStart)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=100
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call AddSpecialEffectLocBJ(PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), 2500.00, ( 3.60 * I2R(GetForLoopIndexA()) )), "Abilities\\Spells\\NightElf\\Barkskin\\BarkSkinTarget.mdl")
        set udg_walls_effect[GetForLoopIndexA()]=GetLastCreatedEffectBJ()
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call TriggerSleepAction(2.00)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=45
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call CreateNUnitsAtLoc(1, udg_random_heroes[GetForLoopIndexA()], Player(PLAYER_NEUTRAL_PASSIVE), GetRectCenter(GetPlayableMapRect()), bj_UNIT_FACING)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    set udg_Draft_hero_building[1]=gg_unit_n02S_0002
    set udg_X=0
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=2
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func051Func001001002002))), function Trig_start_Func051Func001A)
        call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func051Func002001002002))), function Trig_start_Func051Func002A)
        call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func051Func003001002002))), function Trig_start_Func051Func003A)
        call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func051Func004001002002))), function Trig_start_Func051Func004A)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_start_Func052001002)), function Trig_start_Func052A)
    call StartTimerBJ(udg_picktimer, false, 30.00)
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_7455")
    call TimerDialogDisplayBJ(true, GetLastCreatedTimerDialogBJ())
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call ClearSelectionForPlayer(ConvertedPlayer(GetForLoopIndexA()))
            call SelectUnitForPlayerSingle(udg_Draft_hero_building[1], ConvertedPlayer(GetForLoopIndexA()))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_start takes nothing returns nothing
    set gg_trg_start=CreateTrigger()
    call TriggerAddAction(gg_trg_start, function Trig_start_Actions)
endfunction

//===========================================================================
// Trigger: Nick Monitor Heroes
//===========================================================================
function Trig_Nick_Monitor_Heroes_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnteringUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnteringUnit()) != Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) != 'H00K' ) ) then
        return false
    endif
    if ( not ( udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == null ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Monitor_Heroes_Func003C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_NICKActivePlayers) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nick_Monitor_Heroes_Actions takes nothing returns nothing
    if ( Trig_Nick_Monitor_Heroes_Func003C() ) then
        call AddHero(GetTriggerUnit())
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()), udg_NICKActivePlayers)
        set udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
        call BlzSetUnitArmor(GetTriggerUnit(), 5.00)
        call UnitAddItemByIdSwapped('shrs', GetTriggerUnit())
        call UnitAddItemByIdSwapped('I045', GetTriggerUnit())
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_TURN_RATE, 1.00)
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_DEATH_TIME, 4.00)
        call SelectUnitForPlayerSingle(GetTriggerUnit(), GetOwningPlayer(GetTriggerUnit()))
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] + ( " picked |c00fA361F" + ( GetHeroProperName(GetTriggerUnit()) + "|r" ) ) ))
    else
    endif
    set udg_NICKLevelUpFix[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetHeroLevel(GetTriggerUnit())
    set udg_temp_unit_slash1=GetTriggerUnit()
    call ConditionalTriggerExecute(gg_trg_SLASHOnPick)
endfunction

//===========================================================================
function InitTrig_Nick_Monitor_Heroes takes nothing returns nothing
    set gg_trg_Nick_Monitor_Heroes=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Nick_Monitor_Heroes, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_Nick_Monitor_Heroes, Condition(function Trig_Nick_Monitor_Heroes_Conditions))
    call TriggerAddAction(gg_trg_Nick_Monitor_Heroes, function Trig_Nick_Monitor_Heroes_Actions)
endfunction

//===========================================================================
// Trigger: endpick
//===========================================================================
function Trig_endpick_Func001Func001Func001Func001Func002001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_endpick_Func001Func001Func001Func001Func003001001002 takes nothing returns boolean
    return ( GetUnitTypeId(GetFilterUnit()) == udg_ut[GetForLoopIndexB()] )
endfunction

function Trig_endpick_Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_endpick_Func001Func001Func001Func001Func002001001002))) == 0 ) ) then
        return false
    endif
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_endpick_Func001Func001Func001Func001Func003001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_endpick_Func001Func001Func002001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_endpick_Func001Func001Func003001 takes nothing returns boolean
    return ( GetPlayerController(ConvertedPlayer(GetForLoopIndexA())) == MAP_CONTROL_USER )
endfunction

function Trig_endpick_Func001Func001Func003002 takes nothing returns boolean
    return ( GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA())) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_endpick_Func001Func001C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_endpick_Func001Func001Func002001001002))) == 0 ) ) then
        return false
    endif
    if ( not GetBooleanAnd((GetPlayerController(ConvertedPlayer(GetForLoopIndexA())) == MAP_CONTROL_USER), (GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA())) == PLAYER_SLOT_STATE_PLAYING)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_endpick_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_endpick_Func001Func001C() ) then
            set bj_forLoopBIndex=1
            set bj_forLoopBIndexEnd=8
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                if ( Trig_endpick_Func001Func001Func001Func001C() ) then
                    call CreateNUnitsAtLocFacingLocBJ(1, udg_ut[GetForLoopIndexB()], ConvertedPlayer(GetForLoopIndexA()), GetUnitLoc(gg_unit_n02S_0002), GetRectCenter(GetPlayableMapRect()))
                else
                endif
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_endpick takes nothing returns nothing
    set gg_trg_endpick=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_endpick, udg_picktimer)
    call TriggerAddAction(gg_trg_endpick, function Trig_endpick_Actions)
endfunction

//===========================================================================
// Trigger: afterpick
//===========================================================================
function Trig_afterpick_Func005001001002001 takes nothing returns boolean
    return ( GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER )
endfunction

function Trig_afterpick_Func005001001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_afterpick_Func005001001002002002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_afterpick_Func005001001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_afterpick_Func005001001002 takes nothing returns boolean
    return GetBooleanAnd((GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)))) // INLINED!!
endfunction

function Trig_afterpick_Func005003001001001 takes nothing returns boolean
    return ( GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER )
endfunction

function Trig_afterpick_Func005003001001002 takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_afterpick_Func005003001001 takes nothing returns boolean
    return GetBooleanAnd((GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER), (GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING)) // INLINED!!
endfunction

function Trig_afterpick_Conditions takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_afterpick_Func005001001002))) >= CountPlayersInForceBJ(GetPlayersMatching(Condition(function Trig_afterpick_Func005003001001))) ) ) then
        return false
    endif
    return true
endfunction

function Trig_afterpick_Func009002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_afterpick_Func012Func001C takes nothing returns boolean
    if ( not ( udg_NICKHeroArray[udg_N] != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_afterpick_Func013001 takes nothing returns boolean
    return ( udg_ChoosePlayers <= 0 )
endfunction

function Trig_afterpick_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call PauseTimerBJ(true, udg_picktimer)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveUnitFromStockBJ(udg_ut[GetForLoopIndexA()], udg_Draft_hero_building[1])
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call UnitAddAbilityBJ('A0PD', gg_unit_n02S_0002)
    set udg_reward_chosenbutton_num=0
    call ForGroupBJ(udg_heropicker, function Trig_afterpick_Func009002)
    call TriggerSleepAction(2)
    set udg_ChoosePlayers=0
    set udg_N=1
    loop
        exitwhen udg_N > 4
        if ( Trig_afterpick_Func012Func001C() ) then
            call EnableTrigger(gg_trg_leave)
            call ForceAddPlayerSimple(ConvertedPlayer(udg_N), udg_Activeplayers)
            set udg_Pint=( udg_Pint + 1 )
            set udg_ChoosePlayers=( udg_ChoosePlayers + 1 )
            call DialogClearBJ(udg_reward_dialog_Copy[udg_N])
            call DialogSetMessageBJ(udg_reward_dialog_Copy[udg_N], "TRIGSTR_7457")
            set udg_r_temp_num=( ( 10 * udg_N ) + 1 )
            loop
                exitwhen udg_r_temp_num > ( ( 10 * udg_N ) + 6 )
                set udg_reward_trigger[udg_r_temp_num]=udg_reward_trigger_list[1]
                call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
                set udg_r_temp_num=udg_r_temp_num + 1
            endloop
            call DialogDisplayBJ(true, udg_reward_dialog_Copy[udg_N], ConvertedPlayer(udg_N))
        else
        endif
        set udg_N=udg_N + 1
    endloop
    loop
        exitwhen ( (udg_ChoosePlayers <= 0) ) // INLINED!!
        call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.50))
    endloop
    call ConditionalTriggerExecute(gg_trg_wavesStart)
endfunction

//===========================================================================
function InitTrig_afterpick takes nothing returns nothing
    set gg_trg_afterpick=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_afterpick, 0.50)
    call TriggerAddCondition(gg_trg_afterpick, Condition(function Trig_afterpick_Conditions))
    call TriggerAddAction(gg_trg_afterpick, function Trig_afterpick_Actions)
endfunction

//===========================================================================
// Trigger: wavesStart
//===========================================================================
function Trig_wavesStart_Func003Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'h000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_wavesStart_Func003A takes nothing returns nothing
    if ( Trig_wavesStart_Func003Func001C() ) then
        call RemoveUnit(GetEnumUnit())
    else
    endif
endfunction

function Trig_wavesStart_Func010Func001Func002001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_wavesStart_Func010Func001C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_wavesStart_Func010Func001Func002001001002))) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wavesStart_Func015Func002Func003001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_wavesStart_Func015Func002C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_wavesStart_Func015Func002Func003001001002))) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wavesStart_Actions takes nothing returns nothing
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    set udg_temp_UnitGroup=GetUnitsInRectAll(GetPlayableMapRect())
    call ForGroupBJ(udg_temp_UnitGroup, function Trig_wavesStart_Func003A)
    call DestroyGroup(udg_temp_UnitGroup)
    set bj_forLoopAIndex=0
    set bj_forLoopAIndexEnd=60
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveUnitFromStockBJ(udg_random_heroes[GetForLoopIndexA()], gg_unit_n02S_0002)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call RemoveUnitFromStockBJ('H00Z', gg_unit_n02S_0002)
    call TriggerSleepAction(2)
    set udg_current_wave=( udg_current_wave + 1 )
    call StartTimerBJ(udg_wave_timer, false, 4.00)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_wavesStart_Func010Func001C() ) then
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED, ( udg_current_wave * 2 ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call CreateLeaderboardBJ(GetPlayersAll(), "TRIGSTR_013")
    call LeaderboardAddItemBJ(Player(PLAYER_NEUTRAL_PASSIVE), GetLastCreatedLeaderboard(), "TRIGSTR_234", 1)
    call LeaderboardSetPlayerItemStyleBJ(Player(PLAYER_NEUTRAL_PASSIVE), GetLastCreatedLeaderboard(), true, false, false)
    call LeaderboardSetPlayerItemLabelColorBJ(Player(PLAYER_NEUTRAL_PASSIVE), GetLastCreatedLeaderboard(), 100, 100.00, 100.00, 0)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set bj_wantDestroyGroup=true
        if ( Trig_wavesStart_Func015Func002C() ) then
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_wavesStart takes nothing returns nothing
    set gg_trg_wavesStart=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_wavesStart, udg_start_timer)
    call TriggerAddAction(gg_trg_wavesStart, function Trig_wavesStart_Actions)
endfunction

//===========================================================================
// Trigger: waves
//===========================================================================
function Trig_waves_Func001002001001001 takes nothing returns boolean
    return ( GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER )
endfunction

function Trig_waves_Func001002001001002 takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_waves_Func001002001001 takes nothing returns boolean
    return GetBooleanAnd((GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER), (GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING)) // INLINED!!
endfunction

function Trig_waves_Func015001 takes nothing returns boolean
    return ( udg_wave_cleared == true )
endfunction

function Trig_waves_Func025C takes nothing returns boolean
    if ( not ( udg_current_wave >= 100 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func026C takes nothing returns boolean
    if ( not ( udg_current_wave > 28 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func037Func002Func001001001002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) == ConvertedPlayer(udg_N) )
endfunction

function Trig_waves_Func037Func002Func001001001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_waves_Func037Func002Func001001001002002002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_waves_Func037Func002Func001001001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_waves_Func037Func002Func001001001002 takes nothing returns boolean
    return GetBooleanAnd((GetOwningPlayer(GetFilterUnit()) == ConvertedPlayer(udg_N)), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)))) // INLINED!!
endfunction

function Trig_waves_Func037Func002C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_waves_Func037Func002Func001001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func025Func003Func001Func001C takes nothing returns boolean
    if ( not ( udg_chance == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func025Func003Func001C takes nothing returns boolean
    if ( not ( udg_chance == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func025Func003C takes nothing returns boolean
    if ( not ( udg_chance == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func025C takes nothing returns boolean
    if ( not ( udg_current_wave > 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func026C takes nothing returns boolean
    if ( not ( udg_current_wave > 21 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043Func027C takes nothing returns boolean
    if ( not ( udg_current_wave > 42 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func043C takes nothing returns boolean
    if ( not ( udg_current_wave > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func048001 takes nothing returns boolean
    return ( udg_ChoosePlayers <= 0 )
endfunction

function Trig_waves_Func049Func008001 takes nothing returns boolean
    return ( udg_ChoosePlayers <= 0 )
endfunction

function Trig_waves_Func049C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_current_wave, 7) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func055C takes nothing returns boolean
    if ( not ( udg_time_day == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func056Func001C takes nothing returns boolean
    if ( not ( udg_current_wave == 26 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func056Func002C takes nothing returns boolean
    if ( not ( udg_current_wave == 91 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func056Func003Func001C takes nothing returns boolean
    if ( not ( udg_current_wave < 21 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func056Func003Func002001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_waves_Func056Func003C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_waves_Func056Func003Func002001001002))) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Func060C takes nothing returns boolean
    if ( not ( udg_current_wave > 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_waves_Actions takes nothing returns nothing
    set udg_Pint=CountPlayersInForceBJ(GetPlayersMatching(Condition(function Trig_waves_Func001002001001)))
    call EnableTrigger(gg_trg_goldshare)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call LeaderboardDisplayBJ(true, GetLastCreatedLeaderboard())
    // Round Starts
    call DisplayTextToForce(GetPlayersAll(), ( ( "Week: " + I2S(udg_time_week) ) + ( " Day: " + I2S(udg_time_day) ) ))
    call SetTimeOfDay(12.00)
    call EnableTrigger(gg_trg_Creeps_Get_Attacked)
    call TriggerExecute(gg_trg_permanent_immo_bug_fix)
    call ConditionalTriggerExecute(gg_trg_wave_units_spawn)
    call AddUnitAnimationPropertiesBJ(false, "alternate", gg_unit_n02S_0002)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=30
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItemFromStockBJ(udg_Draft_item_options1[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options2[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options3[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options4[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_Draft_item_options5[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ(udg_pillar_item_type[GetForLoopIndexA()], gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tdex', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tstr', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('tint', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('I04B', gg_unit_n02S_0002)
        call RemoveItemFromStockBJ('I040', gg_unit_n02S_0002)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call StartTimerBJ(udg_wavesDecay_warning_timer, false, 999.00)
    set udg_wave_cleared=false
    loop
        exitwhen ( (udg_wave_cleared == true) ) // INLINED!!
        call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.10))
    endloop
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
        call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call DisableTrigger(gg_trg_goldshare)
    call PauseTimerBJ(true, udg_wavesDecay_timer)
    call PauseTimerBJ(true, udg_wavesDecay_warning_timer)
    call DestroyTimerDialogBJ(udg_wavesDecay_timer_window)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitAddAbilityBJ('Avul', udg_NICKHeroArray[GetForLoopIndexA()])
        call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_NEGATIVE, udg_NICKHeroArray[GetForLoopIndexA()])
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call DisableTrigger(gg_trg_wavesDecay)
    call RemoveWeatherEffectBJ(udg_wavesDecay_effect)
    // Round Ends
    if ( Trig_waves_Func025C() ) then
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call BlzFrameSetText(TDamT[bj_forLoopAIndex], I2S(R2I(udg_DMG[bj_forLoopAIndex] / 1000000)) + "m")
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(gg_trg_wave_clear)
        call ConditionalTriggerExecute(gg_trg_Ending_start)
        return
    else
    endif
    if ( Trig_waves_Func026C() ) then
        call BlzSetUnitMaxHP(gg_unit_n02S_0002, ( BlzGetUnitMaxHP(gg_unit_n02S_0002) + 250 ))
        call SetUnitLifeBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) + 250.00 ))
        call BlzSetUnitArmor(gg_unit_n02S_0002, I2R(( udg_current_wave * 2 )))
        set bj_forLoopAIndex=0
        set bj_forLoopAIndexEnd=1
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(gg_unit_n02S_0002, 'A0PD'), ABILITY_RLF_HIT_POINTS_GAINED_REJ1, GetForLoopIndexA(), ( 250.00 + ( 10.00 * I2R(udg_current_wave) ) ))
            call BlzSetAbilityStringLevelFieldBJ(BlzGetUnitAbility(gg_unit_n02S_0002, 'A0PD'), ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, GetForLoopIndexA(), ( "Restores " + ( I2S(( 250 + ( 10 * udg_current_wave ) )) + " hit points to nearby friendly units." ) ))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
        call BlzSetUnitMaxHP(gg_unit_n02S_0002, ( BlzGetUnitMaxHP(gg_unit_n02S_0002) + 50 ))
        call SetUnitLifeBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) + 50.00 ))
        call BlzSetUnitArmor(gg_unit_n02S_0002, I2R(udg_current_wave))
        set bj_forLoopAIndex=0
        set bj_forLoopAIndexEnd=1
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(gg_unit_n02S_0002, 'A0PD'), ABILITY_RLF_HIT_POINTS_GAINED_REJ1, GetForLoopIndexA(), ( 50.00 + ( 5.00 * I2R(udg_current_wave) ) ))
            call BlzSetAbilityStringLevelFieldBJ(BlzGetUnitAbility(gg_unit_n02S_0002, 'A0PD'), ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, GetForLoopIndexA(), ( "Restores " + ( I2S(( 50 + ( 5 * udg_current_wave ) )) + " hit points to nearby friendly units." ) ))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
    call SetTimeOfDay(24.00)
    call PlaySoundBJ(gg_snd_GoodJob)
    call AddUnitAnimationPropertiesBJ(true, "alternate", gg_unit_n02S_0002)
    set udg_creeps_enrage=0
    call UnitRemoveAbilityBJ('Ane2', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Asid', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Asud', gg_unit_n02S_0002)
    call UnitRemoveAbilityBJ('Apit', gg_unit_n02S_0002)
    call TriggerSleepAction(1.00)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitRemoveAbilityBJ('Avul', udg_NICKHeroArray[GetForLoopIndexA()])
        call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_NEGATIVE, udg_NICKHeroArray[GetForLoopIndexA()])
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    set udg_N=1
    loop
        exitwhen udg_N > 4
        set bj_wantDestroyGroup=true
        if ( Trig_waves_Func037Func002C() ) then
            call ReviveHeroLoc(udg_NICKHeroArray[udg_N], GetUnitLoc(gg_unit_n02S_0002), true)
            call PlaySoundOnUnitBJ(gg_snd_ReviveHuman, 100, udg_NICKHeroArray[udg_N])
            call SelectUnitForPlayerSingle(udg_NICKHeroArray[udg_N], ConvertedPlayer(udg_N))
            call SetUnitLifePercentBJ(udg_NICKHeroArray[udg_N], 50.00)
        else
        endif
        set udg_N=udg_N + 1
    endloop
    call TriggerSleepAction(1.00)
    call UnitAddAbilityBJ('Ane2', gg_unit_n02S_0002)
    call UnitAddAbilityBJ('Asid', gg_unit_n02S_0002)
    call UnitAddAbilityBJ('Asud', gg_unit_n02S_0002)
    call UnitAddAbilityBJ('Apit', gg_unit_n02S_0002)
    if ( Trig_waves_Func043C() ) then
        set udg_chance=GetRandomInt(1, udg_Draft_max1)
        set udg_prevchance=udg_chance
        set udg_shop_cheapitem_type=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount=GetRandomInt(1, ( 2 + ( udg_current_wave / 15 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount)
        loop
        set udg_chance=GetRandomInt(1, 23)
        exitwhen udg_chance != udg_prevchance
        endloop
        set udg_prevchance2=udg_chance
        set udg_shop_cheapitem_type_2=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount_2=GetRandomInt(1, ( 2 + ( udg_current_wave / 15 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type_2, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount_2)
        loop
        set udg_chance=GetRandomInt(1, 23)
        exitwhen udg_chance != udg_prevchance and udg_chance != udg_prevchance2
        endloop
        set udg_shop_cheapitem_type_3=udg_Draft_item_options1[udg_chance]
        set udg_shop_cheapitem_amount_3=GetRandomInt(1, ( 2 + ( udg_current_wave / 15 ) ))
        call AddItemToStockBJ(udg_shop_cheapitem_type_3, gg_unit_n02S_0002, 999, udg_shop_cheapitem_amount_3)
        call AddItemToStockBJ(udg_Draft_item_options2[GetRandomInt(1, udg_Draft_max2)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options3[GetRandomInt(1, udg_Draft_max3)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options4[GetRandomInt(1, udg_Draft_max4)], gg_unit_n02S_0002, 1, 1)
        call AddItemToStockBJ(udg_Draft_item_options5[GetRandomInt(1, udg_Draft_max5)], gg_unit_n02S_0002, 1, 1)
        if ( Trig_waves_Func043Func025C() ) then
            set udg_chance=GetRandomInt(1, 3)
            if ( Trig_waves_Func043Func025Func003C() ) then
                call AddItemToStockBJ('tdex', gg_unit_n02S_0002, 1, 1)
            else
                if ( Trig_waves_Func043Func025Func003Func001C() ) then
                    call AddItemToStockBJ('tstr', gg_unit_n02S_0002, 1, 1)
                else
                    if ( Trig_waves_Func043Func025Func003Func001Func001C() ) then
                        call AddItemToStockBJ('tint', gg_unit_n02S_0002, 1, 1)
                    else
                    endif
                endif
            endif
        else
        endif
        if ( Trig_waves_Func043Func026C() ) then
            call AddItemToStockBJ('I04B', gg_unit_n02S_0002, 1, 1)
        else
        endif
        if ( Trig_waves_Func043Func027C() ) then
            call AddItemToStockBJ('I040', gg_unit_n02S_0002, 1, 1)
        else
        endif
    else
    endif
    call TriggerSleepAction(1.00)
    call PlaySoundBJ(gg_snd_BattleNetTick)
    call TriggerSleepAction(1.00)
    call ConditionalTriggerExecute(gg_trg_Reward_Round)
    loop
        exitwhen ( (udg_ChoosePlayers <= 0) ) // INLINED!!
        call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.50))
    endloop
    if ( Trig_waves_Func049C() ) then
        call TriggerSleepAction(1.00)
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_197")
        call PlaySoundBJ(gg_snd_QuestCompleted)
        call TriggerSleepAction(4.00)
        call PlaySoundBJ(gg_snd_BattleNetTick)
        call TriggerSleepAction(1.00)
        call ConditionalTriggerExecute(gg_trg_Reward_Round)
        loop
            exitwhen ( (udg_ChoosePlayers <= 0) ) // INLINED!!
            call TriggerSleepAction(RMaxBJ(bj_WAIT_FOR_COND_MIN_INTERVAL, 0.50))
        endloop
    else
    endif
    call TriggerSleepAction(2.00)
    set udg_current_wave=( udg_current_wave + 1 )
    set udg_time_week=( ( ( udg_current_wave - 1 ) / 7 ) + 1 )
    set udg_time_day=ModuloInteger(udg_current_wave, 7)
    set udg_SpellFactor=( udg_SpellFactor * 1.01 )
    if ( Trig_waves_Func055C() ) then
        set udg_time_day=7
    else
    endif
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_waves_Func056Func001C() ) then
            call BlzFrameSetText(TDamT[bj_forLoopAIndex], I2S(R2I(udg_DMG[bj_forLoopAIndex] / 1000)) + "k")
        else
        endif
        if ( Trig_waves_Func056Func002C() ) then
            call BlzFrameSetText(TDamT[bj_forLoopAIndex], I2S(R2I(udg_DMG[bj_forLoopAIndex] / 1000000)) + "m")
        else
        endif
        if ( Trig_waves_Func056Func003C() ) then
            if ( Trig_waves_Func056Func003Func001C() ) then
                call AdjustPlayerStateBJ(2, ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED)
            else
                call AdjustPlayerStateBJ(3, ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED)
            endif
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
        call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call LeaderboardSetPlayerItemLabelBJ(Player(PLAYER_NEUTRAL_PASSIVE), GetLastCreatedLeaderboard(), ( ( "Week " + I2S(udg_time_week) ) + ( " / Day " + I2S(udg_time_day) ) ))
    call LeaderboardDisplayBJ(false, GetLastCreatedLeaderboard())
    if ( Trig_waves_Func060C() ) then
        call StartTimerBJ(udg_wave_timer, false, 10.00)
        call CreateTimerDialogBJ(udg_wave_timer, "TRIGSTR_228")
    else
        call StartTimerBJ(udg_wave_timer, false, 0.00)
    endif
endfunction

//===========================================================================
function InitTrig_waves takes nothing returns nothing
    set gg_trg_waves=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_waves, udg_wave_timer)
    call TriggerAddAction(gg_trg_waves, function Trig_waves_Actions)
endfunction

//===========================================================================
// Trigger: wave units spawn
//===========================================================================
function Trig_wave_units_spawn_Func002Func001Func001001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_wave_units_spawn_Func002Func001C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_wave_units_spawn_Func002Func001Func001001001002))) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func001A takes nothing returns nothing
    call AdjustPlayerStateBJ(1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 10) == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 6 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 10) == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 6 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 20) == 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 12 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    if ( not ( udg_current_wave > 14 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 10) == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 6 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 10) == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 6 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 20) == 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 12 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    if ( not ( udg_current_wave > 14 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001Func002C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 30) == 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002Func001C takes nothing returns boolean
    if ( not ( ( udg_chance + 32 ) <= udg_wave_diff_lvl ) ) then
        return false
    endif
    if ( not ( udg_current_wave > 28 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func002C takes nothing returns boolean
    if ( not ( udg_chance <= udg_wave_diff_lvl ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func003Func003C takes nothing returns boolean
    if ( not ( udg_wave_diff_lvl > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func006Func002Func001001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_wave_units_spawn_Func003Func006Func002Func003Func014Func002C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_boss_spells[udg_chance], GetLastCreatedUnit()) < 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003Func006Func002C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(function Trig_wave_units_spawn_Func003Func006Func002Func001001001002))) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Func003C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_current_wave, 7) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_units_spawn_Actions takes nothing returns nothing
    set udg_wave_diff_lvl=0
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_wave_units_spawn_Func002Func001C() ) then
            set udg_wave_diff_lvl_Copy[GetForLoopIndexA()]=GetPlayerState(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED)
            set udg_wave_diff_lvl=( udg_wave_diff_lvl + GetPlayerState(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED) )
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if ( Trig_wave_units_spawn_Func003C() ) then
        call ForForce(GetPlayersAll(), function Trig_wave_units_spawn_Func003Func001A)
        call PlaySoundBJ(gg_snd_Warning)
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_237")
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set bj_wantDestroyGroup=true
            if ( Trig_wave_units_spawn_Func003Func006Func002C() ) then
                set udg_temp_int=( IMaxBJ(( ( udg_current_wave - 14 ) / 14 ), 0) + 1 )
                set udg_wave_temp_num_2=1
                loop
                    exitwhen udg_wave_temp_num_2 > udg_temp_int
                    set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                    call CreateNUnitsAtLoc(1, udg_random_heroes[GetRandomInt(1, 39)], Player(20), udg_TP, bj_UNIT_FACING)
                    call RemoveLocation(udg_TP)
                    call SetHeroLevelBJ(GetLastCreatedUnit(), R2I(( I2R(GetPlayerState(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED)) * 0.70 )), false)
                    call BlzSetUnitRealFieldBJ(GetLastCreatedUnit(), UNIT_RF_SCALING_VALUE, ( BlzGetUnitRealField(GetLastCreatedUnit(), UNIT_RF_SCALING_VALUE) * ( 1 + ( I2R(udg_current_wave) * 0.01 ) ) ))
                    set udg_temp_real=( BlzGetUnitRealField(GetLastCreatedUnit(), UNIT_RF_SCALING_VALUE) * 100.00 )
                    call SetUnitScalePercent(GetLastCreatedUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( BlzGetUnitMaxHP(GetLastCreatedUnit()) + IMinBJ(( 800 + ( 175 * udg_current_wave ) ), 2250) ))
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 50 + ( 5 * udg_current_wave ) ), 0)
                    call BlzSetUnitMaxMana(GetLastCreatedUnit(), 800)
                    call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100)
                    call SetUnitManaPercentBJ(GetLastCreatedUnit(), 100)
                    call BlzSetUnitArmor(GetLastCreatedUnit(), ( BlzGetUnitArmor(GetLastCreatedUnit()) + ( I2R(udg_current_wave) * 0.10 ) ))
                    set udg_wave_temp_num=1
                    loop
                        exitwhen udg_wave_temp_num > 3
                        set udg_chance=GetRandomInt(0, 31)
                        if ( Trig_wave_units_spawn_Func003Func006Func002Func003Func014Func002C() ) then
                            call UnitAddAbilityBJ(udg_boss_spells[udg_chance], GetLastCreatedUnit())
                        else
                            set udg_wave_temp_num=( udg_wave_temp_num - 1 )
                        endif
                        set udg_wave_temp_num=udg_wave_temp_num + 1
                    endloop
                    set udg_wave_temp_num_2=udg_wave_temp_num_2 + 1
                endloop
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
        set udg_temp_int=( IMaxBJ(( ( udg_current_wave - 14 ) / 14 ), 0) + 1 )
        set udg_wave_temp_num=1
        loop
            exitwhen udg_wave_temp_num > 2
            set udg_chance=GetRandomInt(1, ModuloInteger(udg_wave_diff_lvl, 11))
            if ( Trig_wave_units_spawn_Func003Func003Func002C() ) then
                if ( Trig_wave_units_spawn_Func003Func003Func002Func001C() ) then
                    if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002C() ) then
                        set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                        call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                        call RemoveLocation(udg_TP)
                        call SetUnitUserData(GetLastCreatedUnit(), 64)
                        set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 32 ) )
                    else
                        if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001C() ) then
                            if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002C() ) then
                                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                call RemoveLocation(udg_TP)
                                call SetUnitUserData(GetLastCreatedUnit(), 32)
                                set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 12 ) )
                            else
                                if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002Func001C() ) then
                                    if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func002Func001Func001C() ) then
                                        set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                        call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                        call RemoveLocation(udg_TP)
                                        call SetUnitUserData(GetLastCreatedUnit(), 16)
                                        set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 6 ) )
                                    else
                                        set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                        call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                        call RemoveLocation(udg_TP)
                                        set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                                    endif
                                else
                                    set udg_TP=udg_TP
                                    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg()), bj_UNIT_FACING)
                                    call RemoveLocation(udg_TP)
                                    set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                                endif
                            endif
                        else
                            if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func001C() ) then
                                if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func002Func001Func001Func001C() ) then
                                    set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                    call RemoveLocation(udg_TP)
                                    call SetUnitUserData(GetLastCreatedUnit(), 16)
                                    set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 6 ) )
                                else
                                    set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                    call RemoveLocation(udg_TP)
                                    set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                                endif
                            else
                                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                call RemoveLocation(udg_TP)
                                set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                            endif
                        endif
                    endif
                else
                    if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001C() ) then
                        if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002C() ) then
                            set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                            call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                            call RemoveLocation(udg_TP)
                            call SetUnitUserData(GetLastCreatedUnit(), 32)
                            set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 12 ) )
                        else
                            if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002Func001C() ) then
                                if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func002Func001Func001C() ) then
                                    set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                    call RemoveLocation(udg_TP)
                                    call SetUnitUserData(GetLastCreatedUnit(), 16)
                                    set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 6 ) )
                                else
                                    set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                    call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                    call RemoveLocation(udg_TP)
                                    set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                                endif
                            else
                                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                call RemoveLocation(udg_TP)
                                set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                            endif
                        endif
                    else
                        if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func001C() ) then
                            if ( Trig_wave_units_spawn_Func003Func003Func002Func001Func001Func001Func001C() ) then
                                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                call RemoveLocation(udg_TP)
                                call SetUnitUserData(GetLastCreatedUnit(), 16)
                                set udg_wave_diff_lvl=( udg_wave_diff_lvl - ( udg_chance + 6 ) )
                            else
                                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                                call RemoveLocation(udg_TP)
                                set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                            endif
                        else
                            set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
                            call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(udg_chance), Player(20), udg_TP, bj_UNIT_FACING)
                            call RemoveLocation(udg_TP)
                            set udg_wave_diff_lvl=( udg_wave_diff_lvl - udg_chance )
                        endif
                    endif
                endif
            else
            endif
            if ( Trig_wave_units_spawn_Func003Func003Func003C() ) then
                set udg_wave_temp_num=1
            else
            endif
            set udg_wave_temp_num=udg_wave_temp_num + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_wave_units_spawn takes nothing returns nothing
    set gg_trg_wave_units_spawn=CreateTrigger()
    call TriggerAddAction(gg_trg_wave_units_spawn, function Trig_wave_units_spawn_Actions)
endfunction

//===========================================================================
// Trigger: wave clear
//===========================================================================
function Trig_wave_clear_Conditions takes nothing returns boolean
    if ( not ( udg_wave_cleared == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_clear_Func002Func004Func002001001002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_wave_clear_Func002Func004C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(Player(20), Condition(function Trig_wave_clear_Func002Func004Func002001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_clear_Func002Func006001001002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_wave_clear_Func002C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsOfPlayerMatching(Player(20), Condition(function Trig_wave_clear_Func002Func006001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_wave_clear_Actions takes nothing returns nothing
    set bj_wantDestroyGroup=true
    if ( Trig_wave_clear_Func002C() ) then
        call DisableTrigger(GetTriggeringTrigger())
        call TriggerSleepAction(1.00)
        set bj_wantDestroyGroup=true
        if ( Trig_wave_clear_Func002Func004C() ) then
            set udg_wave_cleared=true
        else
        endif
        call EnableTrigger(GetTriggeringTrigger())
    else
    endif
endfunction

//===========================================================================
function InitTrig_wave_clear takes nothing returns nothing
    set gg_trg_wave_clear=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_wave_clear, 1.00)
    call TriggerAddCondition(gg_trg_wave_clear, Condition(function Trig_wave_clear_Conditions))
    call TriggerAddAction(gg_trg_wave_clear, function Trig_wave_clear_Actions)
endfunction

//===========================================================================
// Trigger: wavesDecaywarningtimer
//===========================================================================
function Trig_wavesDecaywarningtimer_Actions takes nothing returns nothing
    call CreateTimerDialogBJ(udg_wavesDecay_timer, "TRIGSTR_12113")
    set udg_wavesDecay_timer_window=GetLastCreatedTimerDialogBJ()
    call StartTimerBJ(udg_wavesDecay_timer, false, 0.00)
    call TimerDialogDisplayBJ(true, GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_wavesDecaywarningtimer takes nothing returns nothing
    set gg_trg_wavesDecaywarningtimer=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_wavesDecaywarningtimer, udg_wavesDecay_warning_timer)
    call TriggerAddAction(gg_trg_wavesDecaywarningtimer, function Trig_wavesDecaywarningtimer_Actions)
endfunction

//===========================================================================
// Trigger: wavesDecaytimer
//===========================================================================
function Trig_wavesDecaytimer_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3023")
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'MEds')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_wavesDecay_effect=GetLastCreatedWeatherEffect()
    call PlaySoundBJ(gg_snd_Warning)
    call EnableTrigger(gg_trg_wavesDecay)
endfunction

//===========================================================================
function InitTrig_wavesDecaytimer takes nothing returns nothing
    set gg_trg_wavesDecaytimer=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_wavesDecaytimer, udg_wavesDecay_timer)
    call TriggerAddAction(gg_trg_wavesDecaytimer, function Trig_wavesDecaytimer_Actions)
endfunction

//===========================================================================
// Trigger: wavesDecay
//===========================================================================
function Trig_wavesDecay_Func001Func001C takes nothing returns boolean
    if ( not ( BlzIsUnitInvulnerable(udg_NICKHeroArray[GetForLoopIndexA()]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_wavesDecay_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_wavesDecay_Func001Func001C() ) then
            call SetUnitLifePercentBJ(udg_NICKHeroArray[GetForLoopIndexA()], ( GetUnitLifePercent(udg_NICKHeroArray[GetForLoopIndexA()]) - 1 ))
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_wavesDecay takes nothing returns nothing
    set gg_trg_wavesDecay=CreateTrigger()
    call DisableTrigger(gg_trg_wavesDecay)
    call TriggerRegisterTimerEventPeriodic(gg_trg_wavesDecay, 0.20)
    call TriggerAddAction(gg_trg_wavesDecay, function Trig_wavesDecay_Actions)
endfunction

//===========================================================================
// Trigger: boss spell init
//===========================================================================
function Trig_boss_spell_init_Actions takes nothing returns nothing
    set udg_boss_spells[0]='A00I'
    set udg_boss_spells[1]='A040'
    set udg_boss_spells[2]='A00D'
    set udg_boss_spells[3]='A01U'
    set udg_boss_spells[4]='A008'
    set udg_boss_spells[5]='A00F'
    set udg_boss_spells[6]='ACwe'
    set udg_boss_spells[7]='A0PE'
    set udg_boss_spells[8]='A01D'
    set udg_boss_spells[9]='A08D'
    set udg_boss_spells[10]='A037'
    set udg_boss_spells[11]='A0AZ'
    set udg_boss_spells[12]='A0CN'
    set udg_boss_spells[14]='A0GN'
    set udg_boss_spells[13]='A015'
    set udg_boss_spells[15]='A0DE'
    set udg_boss_spells[16]='A0N7'
    set udg_boss_spells[17]='A0ND'
    set udg_boss_spells[18]='A00S'
    set udg_boss_spells[19]='A0FV'
    set udg_boss_spells[20]='A0L7'
    set udg_boss_spells[21]='A0B1'
    set udg_boss_spells[22]='A0J6'
    set udg_boss_spells[23]='A0BL'
    set udg_boss_spells[24]='A04U'
    set udg_boss_spells[25]='A0BN'
    set udg_boss_spells[26]='A0LB'
    set udg_boss_spells[27]='A0K3'
    set udg_boss_spells[28]='A0QZ'
    set udg_boss_spells[29]='A0QY'
    set udg_boss_spells[30]='A03S'
    set udg_boss_spells[31]='A0R3'
endfunction

//===========================================================================
function InitTrig_boss_spell_init takes nothing returns nothing
    set gg_trg_boss_spell_init=CreateTrigger()
    call TriggerAddAction(gg_trg_boss_spell_init, function Trig_boss_spell_init_Actions)
endfunction

//===========================================================================
// Trigger: boss spell
//===========================================================================
function Trig_boss_spell_Func004001001002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) == Player(20) )
endfunction

function Trig_boss_spell_Func004001001002002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_boss_spell_Func004001001002 takes nothing returns boolean
    return GetBooleanAnd((GetOwningPlayer(GetFilterUnit()) == Player(20)), (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true)) // INLINED!!
endfunction

function Trig_boss_spell_Conditions takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_boss_spell_Func004001001002))) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_boss_spell_Func001002002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_boss_spell_Func002Func001Func001C takes nothing returns boolean
    if ( ( GetUnitCurrentOrder(GetEnumUnit()) == String2OrderIdBJ("") ) ) then
        return true
    endif
    if ( ( GetUnitCurrentOrder(GetEnumUnit()) == String2OrderIdBJ("attack") ) ) then
        return true
    endif
    return false
endfunction

function Trig_boss_spell_Func002Func001Func004002003001 takes nothing returns boolean
    return ( GetOwningPlayer(GetFilterUnit()) != Player(20) )
endfunction

function Trig_boss_spell_Func002Func001Func004002003002001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_boss_spell_Func002Func001Func004002003002002001 takes nothing returns boolean
    return ( BlzIsUnitInvulnerable(GetFilterUnit()) == false )
endfunction

function Trig_boss_spell_Func002Func001Func004002003002002002 takes nothing returns boolean
    return ( GetFilterUnit() != gg_unit_n02S_0002 )
endfunction

function Trig_boss_spell_Func002Func001Func004002003002002 takes nothing returns boolean
    return GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) == false), (GetFilterUnit() != gg_unit_n02S_0002)) // INLINED!!
endfunction

function Trig_boss_spell_Func002Func001Func004002003002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) == false), (GetFilterUnit() != gg_unit_n02S_0002)))) // INLINED!!
endfunction

function Trig_boss_spell_Func002Func001Func004002003 takes nothing returns boolean
    return GetBooleanAnd((GetOwningPlayer(GetFilterUnit()) != Player(20)), (GetBooleanAnd((IsUnitAliveBJ(GetFilterUnit()) == true), (GetBooleanAnd((BlzIsUnitInvulnerable(GetFilterUnit()) == false), (GetFilterUnit() != gg_unit_n02S_0002)))))) // INLINED!!
endfunction

function Trig_boss_spell_Func002Func001Func005C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(udg_temp_UnitGroup) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_boss_spell_Func002Func001Func008C takes nothing returns boolean
    if ( not ( GetUnitLifePercent(GetEnumUnit()) <= 65.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_boss_spell_Func002Func001C takes nothing returns boolean
    if ( not Trig_boss_spell_Func002Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_boss_spell_Func002A takes nothing returns nothing
    if ( Trig_boss_spell_Func002Func001C() ) then
        set bj_forLoopAIndex=8
        set bj_forLoopAIndexEnd=30
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetUnitAbilityLevelSwapped(udg_boss_spells[GetForLoopIndexA()], GetEnumUnit(), 5)
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        set udg_temp_Point=GetUnitLoc(GetEnumUnit())
        set udg_temp_UnitGroup=GetUnitsInRangeOfLocMatching(600.00, udg_temp_Point, Condition(function Trig_boss_spell_Func002Func001Func004002003))
        if ( Trig_boss_spell_Func002Func001Func005C() ) then
            set udg_temp_Point=GetUnitLoc(GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssuePointOrderLocBJ(GetEnumUnit(), "rainoffire", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "volcano", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "dreadlordinferno", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "stampede", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "flamestrike", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "blizzard", udg_temp_Point)
            call IssuePointOrderLocBJ(GetEnumUnit(), "rainoffire", udg_temp_Point)
            call IssueImmediateOrderBJ(GetEnumUnit(), "lavamonster")
            call IssueImmediateOrderBJ(GetEnumUnit(), "waterelemental")
            call IssueImmediateOrderBJ(GetEnumUnit(), "animatedead")
            call IssueTargetOrderBJ(GetEnumUnit(), "drain", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "drain", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "entanglingroots", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "transmute", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "drunkenhaze", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "cripple", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssueTargetOrderBJ(GetEnumUnit(), "magicleash", GroupPickRandomUnit(udg_temp_UnitGroup))
            call IssuePointOrderLocBJ(GetEnumUnit(), "blink", udg_temp_Point)
        else
        endif
        call DestroyGroup(udg_temp_UnitGroup)
        call RemoveLocation(udg_temp_Point)
        if ( Trig_boss_spell_Func002Func001Func008C() ) then
            call IssueTargetOrderBJ(GetEnumUnit(), "holybolt", GetEnumUnit())
            call IssueTargetOrderBJ(GetEnumUnit(), "rejuvination", GetEnumUnit())
            call IssueTargetOrderBJ(GetEnumUnit(), "antimagicshell", GetEnumUnit())
            call IssueImmediateOrderBJ(GetEnumUnit(), "manashieldon")
            call IssueImmediateOrderBJ(GetEnumUnit(), "windwalk")
            call IssueImmediateOrderBJ(GetEnumUnit(), "berserk")
            call IssueImmediateOrderBJ(GetEnumUnit(), "mirrorimage")
        else
        endif
    else
    endif
endfunction

function Trig_boss_spell_Actions takes nothing returns nothing
    set udg_UG=GetUnitsOfPlayerMatching(Player(20), Condition(function Trig_boss_spell_Func001002002))
    call ForGroupBJ(udg_UG, function Trig_boss_spell_Func002A)
    call DestroyGroup(udg_UG)
endfunction

//===========================================================================
function InitTrig_boss_spell takes nothing returns nothing
    set gg_trg_boss_spell=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_boss_spell, 10.00)
    call TriggerAddCondition(gg_trg_boss_spell, Condition(function Trig_boss_spell_Conditions))
    call TriggerAddAction(gg_trg_boss_spell, function Trig_boss_spell_Actions)
endfunction

//===========================================================================
// Trigger: Creeps Enter Map
//===========================================================================
function Trig_Creeps_Enter_Map_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnteringUnit()) == Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetTriggerUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func032C takes nothing returns boolean
    if ( not ( udg_current_wave > 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func033C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 16 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func034C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 32 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func035C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 64 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func036Func002C takes nothing returns boolean
    if ( not ( udg_temp_int_slash == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func036Func003C takes nothing returns boolean
    if ( not ( udg_temp_int_slash == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func036Func004C takes nothing returns boolean
    if ( not ( udg_temp_int_slash == 11 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func036Func005C takes nothing returns boolean
    if ( ( GetUnitUserData(GetTriggerUnit()) == 16 ) ) then
        return true
    endif
    if ( ( GetUnitUserData(GetTriggerUnit()) == 32 ) ) then
        return true
    endif
    if ( ( GetUnitUserData(GetTriggerUnit()) == 64 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Creeps_Enter_Map_Func036C takes nothing returns boolean
    if ( not Trig_Creeps_Enter_Map_Func036Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func038C takes nothing returns boolean
    if ( not ( udg_creeps_enrage == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func039C takes nothing returns boolean
    if ( not ( udg_current_wave >= 1 ) ) then
        return false
    endif
    if ( not ( udg_current_wave <= 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func040Func002C takes nothing returns boolean
    if ( not ( udg_current_wave >= 3 ) ) then
        return false
    endif
    if ( not ( udg_current_wave <= 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func040C takes nothing returns boolean
    if ( not Trig_Creeps_Enter_Map_Func040Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func041C takes nothing returns boolean
    if ( not ( udg_current_wave > 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func042C takes nothing returns boolean
    if ( not ( udg_current_wave > 21 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Func043C takes nothing returns boolean
    if ( not ( udg_current_wave > 56 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Enter_Map_Actions takes nothing returns nothing
    call IssuePointOrderLocBJ(GetTriggerUnit(), "attack", GetUnitLoc(gg_unit_n02S_0002))
    call SetUnitManaPercentBJ(GetEnteringUnit(), 100)
    call SetUnitMoveSpeed(GetEnteringUnit(), 200.00)
    call BlzSetUnitIntegerFieldBJ(GetEnteringUnit(), UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, ( BlzGetUnitIntegerField(GetEnteringUnit(), UNIT_IF_GOLD_BOUNTY_AWARDED_BASE) * 3 ))
    call BlzSetUnitIntegerFieldBJ(GetEnteringUnit(), UNIT_IF_TARGETED_AS, 2)
    call BlzSetUnitRealFieldBJ(GetEnteringUnit(), UNIT_RF_MINIMUM_ATTACK_RANGE, 0.00)
    call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_ACQUISITION_RANGE, 1500.00)
    call UnitRemoveTypeBJ(UNIT_TYPE_MECHANICAL, GetEnteringUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_MAGIC_IMMUNE, GetEnteringUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_RESISTANT, GetEnteringUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_STRUCTURE, GetEnteringUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_FLYING, GetEnteringUnit())
    call UnitRemoveTypeBJ(UNIT_TYPE_ANCIENT, GetEnteringUnit())
    call UnitAddTypeBJ(UNIT_TYPE_GROUND, GetEnteringUnit())
    call UnitRemoveAbilityBJ('ACmi', GetEnteringUnit())
    call UnitRemoveAbilityBJ('Amim', GetEnteringUnit())
    call BlzSetUnitIntegerFieldBJ(GetTriggerUnit(), UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, 0)
    call UnitRemoveAbilityBJ('Ahea', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Anhe', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Anh1', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Anh2', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Arpl', GetTriggerUnit())
    call UnitRemoveAbilityBJ('ACsl', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Acn2', GetTriggerUnit())
    call UnitRemoveAbilityBJ('Acan', GetTriggerUnit())
    call UnitRemoveAbilityBJ('ACcn', GetTriggerUnit())
    call UnitRemoveAbilityBJ('ACah', GetTriggerUnit())
    call UnitRemoveAbilityBJ('ANth', GetTriggerUnit())
    call UnitRemoveAbilityBJ('ANt2', GetTriggerUnit())
    if ( Trig_Creeps_Enter_Map_Func032C() ) then
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) + I2R(( 8 * ( udg_current_wave / 7 ) )) )), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) + I2R(( 8 * ( udg_current_wave / 7 ) )) )), 1)
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + ( 50 + ( udg_current_wave / 7 ) ) ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func033C() ) then
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_SCALING_VALUE, ( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 1.50 ))
        set udg_temp_real=( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 100.00 )
        call SetUnitScalePercent(GetTriggerUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + 1000 ))
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 0) + ( ( GetUnitLevel(GetTriggerUnit()) * 10 ) + 20 ) ), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 1) + ( ( GetUnitLevel(GetTriggerUnit()) * 10 ) + 20 ) ), 1)
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + 5.00 ))
        call BlzSetUnitIntegerFieldBJ(GetTriggerUnit(), UNIT_IF_LEVEL, ( GetUnitLevel(GetTriggerUnit()) + 6 ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func034C() ) then
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_SCALING_VALUE, ( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 1.90 ))
        set udg_temp_real=( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 100.00 )
        call SetUnitScalePercent(GetTriggerUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + 4000 ))
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 0) + ( ( GetUnitLevel(GetTriggerUnit()) * 25 ) + 90 ) ), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 1) + ( ( GetUnitLevel(GetTriggerUnit()) * 25 ) + 90 ) ), 1)
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + 10.00 ))
        call BlzSetUnitIntegerFieldBJ(GetTriggerUnit(), UNIT_IF_LEVEL, ( GetUnitLevel(GetTriggerUnit()) + 12 ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func035C() ) then
        call BlzSetUnitRealFieldBJ(GetTriggerUnit(), UNIT_RF_SCALING_VALUE, ( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 2.50 ))
        set udg_temp_real=( BlzGetUnitRealField(GetTriggerUnit(), UNIT_RF_SCALING_VALUE) * 100.00 )
        call SetUnitScalePercent(GetTriggerUnit(), udg_temp_real, udg_temp_real, udg_temp_real)
        call BlzSetUnitMaxHP(GetTriggerUnit(), ( BlzGetUnitMaxHP(GetTriggerUnit()) + 10000 ))
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 0) + ( ( GetUnitLevel(GetTriggerUnit()) * 60 ) + 300 ) ), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 1) + ( ( GetUnitLevel(GetTriggerUnit()) * 60 ) + 300 ) ), 1)
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + 15.00 ))
        call BlzSetUnitIntegerFieldBJ(GetTriggerUnit(), UNIT_IF_LEVEL, ( GetUnitLevel(GetTriggerUnit()) + 32 ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func036C() ) then
        set udg_temp_int_slash=GetRandomInt(1, 11)
        if ( Trig_Creeps_Enter_Map_Func036Func002C() ) then
            call UnitAddAbilityBJ('A0QZ', GetTriggerUnit())
        else
        endif
        if ( Trig_Creeps_Enter_Map_Func036Func003C() ) then
            call UnitAddAbilityBJ('A0QY', GetTriggerUnit())
        else
        endif
        if ( Trig_Creeps_Enter_Map_Func036Func004C() ) then
            call UnitAddAbilityBJ('A0R5', GetTriggerUnit())
        else
        endif
    else
    endif
    call BlzSetUnitIntegerFieldBJ(GetTriggerUnit(), UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, ( 25 * GetUnitLevel(GetTriggerUnit()) ))
    if ( Trig_Creeps_Enter_Map_Func038C() ) then
        call UnitAddAbilityBJ('Aens', GetEnteringUnit())
        call UnitAddAbilityBJ('A04N', GetEnteringUnit())
        call UnitAddAbilityBJ('AIms', GetEnteringUnit())
        call SetUnitMoveSpeed(GetEnteringUnit(), 322.00)
        call BlzSetUnitAttackCooldown(GetEnteringUnit(), ( BlzGetUnitAttackCooldown(GetEnteringUnit(), 0) / 3.00 ), ( 0 + 0 ))
        call BlzSetUnitBaseDamage(GetEnteringUnit(), ( BlzGetUnitBaseDamage(GetEnteringUnit(), 0) * 5 ), 0)
        call BlzSetUnitRealFieldBJ(GetEnteringUnit(), UNIT_RF_ANIMATION_RUN_SPEED, ( BlzGetUnitRealField(GetEnteringUnit(), UNIT_RF_ANIMATION_RUN_SPEED) * 1.20 ))
        call BlzSetUnitWeaponRealFieldBJ(GetEnteringUnit(), UNIT_WEAPON_RF_ATTACK_RANGE, 0, ( BlzGetUnitWeaponRealField(GetEnteringUnit(), UNIT_WEAPON_RF_ATTACK_RANGE, 0) * 2.00 ))
        call SetUnitColor(GetEnteringUnit(), PLAYER_COLOR_RED)
        call SetUnitVertexColorBJ(GetEnteringUnit(), 100.00, 30.00, 30.00, 0.00)
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func039C() ) then
        call BlzSetUnitMaxHP(GetEnteringUnit(), ( BlzGetUnitMaxHP(GetEnteringUnit()) / 2 ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func040C() ) then
        call BlzSetUnitMaxHP(GetEnteringUnit(), ( BlzGetUnitMaxHP(GetEnteringUnit()) - ( BlzGetUnitMaxHP(GetEnteringUnit()) / 3 ) ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func041C() ) then
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * ( 0.50 + ( I2R(udg_current_wave) * 0.07 ) ) )), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * ( 0.50 + ( I2R(udg_current_wave) * 0.07 ) ) )), 1)
        call BlzSetUnitMaxHP(GetEnteringUnit(), R2I(( ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) / 2.00 ) + ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * ( I2R(udg_current_wave) * 0.07 ) ) )))
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) + ( 0.20 * I2R(udg_current_wave) ) ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func042C() ) then
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * ( 1.00 + ( I2R(( udg_current_wave - 21 )) * 0.10 ) ) )), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * ( 1.00 + ( I2R(( udg_current_wave - 21 )) * 0.10 ) ) )), 1)
        call BlzSetUnitMaxHP(GetEnteringUnit(), R2I(( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) + ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * ( I2R(( udg_current_wave - 21 )) * 0.09 ) ) )))
        call BlzSetUnitArmor(GetTriggerUnit(), ( BlzGetUnitArmor(GetTriggerUnit()) * ( 1.00 + ( 0.10 * I2R(( udg_current_wave - 21 )) ) ) ))
    else
    endif
    if ( Trig_Creeps_Enter_Map_Func043C() ) then
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 0)) * ( 1.00 + ( I2R(( udg_current_wave - 56 )) * 0.11 ) ) )), 0)
        call BlzSetUnitBaseDamage(GetEnteringUnit(), R2I(( I2R(BlzGetUnitBaseDamage(GetTriggerUnit(), 1)) * ( 1.00 + ( I2R(( udg_current_wave - 56 )) * 0.11 ) ) )), 1)
        call BlzSetUnitMaxHP(GetEnteringUnit(), R2I(( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) + ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * ( I2R(( udg_current_wave - 56 )) * 0.03 ) ) )))
    else
    endif
    call BlzSetUnitMaxHP(GetTriggerUnit(), R2I(( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetTriggerUnit()) * Pow(1.02, I2R(udg_current_wave)) )))
    call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) * Pow(0.99, I2R(udg_current_wave)) ), ( 0 + 0 ))
    call BlzSetUnitAttackCooldown(GetTriggerUnit(), ( BlzGetUnitAttackCooldown(GetTriggerUnit(), 0) * Pow(0.99, I2R(udg_current_wave)) ), 1)
    call SetUnitLifePercentBJ(GetEnteringUnit(), 100)
endfunction

//===========================================================================
function InitTrig_Creeps_Enter_Map takes nothing returns nothing
    set gg_trg_Creeps_Enter_Map=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Creeps_Enter_Map, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_Creeps_Enter_Map, Condition(function Trig_Creeps_Enter_Map_Conditions))
    call TriggerAddAction(gg_trg_Creeps_Enter_Map, function Trig_Creeps_Enter_Map_Actions)
endfunction

//===========================================================================
// Trigger: Creeps Get Attacked
//===========================================================================
function Trig_Creeps_Get_Attacked_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_DamageEventTarget) == Player(20) ) ) then
        return false
    endif
    if ( not ( udg_DamageEventSource != gg_unit_n02S_0002 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Creeps_Get_Attacked_Func002A takes nothing returns nothing
    call SetUnitMoveSpeed(GetEnumUnit(), 265.00)
endfunction

function Trig_Creeps_Get_Attacked_Actions takes nothing returns nothing
    set udg_UG=GetUnitsOfPlayerAll(Player(20))
    call ForGroupBJ(udg_UG, function Trig_Creeps_Get_Attacked_Func002A)
    call DestroyGroup(udg_UG)
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_Creeps_Get_Attacked takes nothing returns nothing
    set gg_trg_Creeps_Get_Attacked=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Creeps_Get_Attacked, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Creeps_Get_Attacked, Condition(function Trig_Creeps_Get_Attacked_Conditions))
    call TriggerAddAction(gg_trg_Creeps_Get_Attacked, function Trig_Creeps_Get_Attacked_Actions)
endfunction

//===========================================================================
// Trigger: Stronger Creep Abilities
//===========================================================================
function Trig_Stronger_Creep_Abilities_Conditions takes nothing returns boolean
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) == Player(20) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Stronger_Creep_Abilities_Actions takes nothing returns nothing
    set udg_DamageEventAmount=( udg_DamageEventAmount * ( ( 0.50 + ( I2R(udg_current_wave) * 0.04 ) ) * udg_SpellFactor ) )
endfunction

//===========================================================================
function InitTrig_Stronger_Creep_Abilities takes nothing returns nothing
    set gg_trg_Stronger_Creep_Abilities=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Stronger_Creep_Abilities, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Stronger_Creep_Abilities, Condition(function Trig_Stronger_Creep_Abilities_Conditions))
    call TriggerAddAction(gg_trg_Stronger_Creep_Abilities, function Trig_Stronger_Creep_Abilities_Actions)
endfunction

//===========================================================================
// Trigger: Order Creeps Obelisk
//===========================================================================
function Trig_Order_Creeps_Obelisk_Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitCurrentOrder(GetEnumUnit()) == String2OrderIdBJ("") ) ) then
        return false
    endif
    return true
endfunction

function Trig_Order_Creeps_Obelisk_Func002A takes nothing returns nothing
    if ( Trig_Order_Creeps_Obelisk_Func002Func001C() ) then
        set udg_temp_Point=GetUnitLoc(gg_unit_n02S_0002)
        call IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_temp_Point)
        call RemoveLocation(udg_temp_Point)
    else
    endif
endfunction

function Trig_Order_Creeps_Obelisk_Actions takes nothing returns nothing
    set udg_UG=GetUnitsOfPlayerAll(Player(20))
    call ForGroupBJ(udg_UG, function Trig_Order_Creeps_Obelisk_Func002A)
    call DestroyGroup(udg_UG)
endfunction

//===========================================================================
function InitTrig_Order_Creeps_Obelisk takes nothing returns nothing
    set gg_trg_Order_Creeps_Obelisk=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Order_Creeps_Obelisk, 2)
    call TriggerAddAction(gg_trg_Order_Creeps_Obelisk, function Trig_Order_Creeps_Obelisk_Actions)
endfunction

//===========================================================================
// Trigger: Skip command
//===========================================================================
function Trig_Skip_command_Conditions takes nothing returns boolean
    if ( not ( GetPlayerName(GetTriggerPlayer()) == "WorldEdit" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skip_command_Func001C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_start_timer) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skip_command_Func003C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_FinalDuels_timer) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skip_command_Func004C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_wave_timer) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skip_command_Func005C takes nothing returns boolean
    if ( not ( TimerGetRemaining(udg_pvp_timer) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Skip_command_Actions takes nothing returns nothing
    if ( Trig_Skip_command_Func001C() ) then
        call StartTimerBJ(udg_start_timer, false, 1.00)
    else
    endif
    if ( Trig_Skip_command_Func003C() ) then
        call StartTimerBJ(udg_FinalDuels_timer, false, 1.00)
    else
    endif
    if ( Trig_Skip_command_Func004C() ) then
        call StartTimerBJ(udg_wave_timer, false, 1.00)
    else
    endif
    if ( Trig_Skip_command_Func005C() ) then
        call StartTimerBJ(udg_pvp_timer, false, 1.00)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Skip_command takes nothing returns nothing
    set gg_trg_Skip_command=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Skip_command, Player(0), "-skip", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Skip_command, Player(1), "-skip", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Skip_command, Player(2), "-skip", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Skip_command, Player(3), "-skip", true)
    call TriggerAddCondition(gg_trg_Skip_command, Condition(function Trig_Skip_command_Conditions))
    call TriggerAddAction(gg_trg_Skip_command, function Trig_Skip_command_Actions)
endfunction

//===========================================================================
// Trigger: Hero Info command
//===========================================================================
function Trig_Hero_Info_command_Func004C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 3, 3) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func005C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func006C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func009C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 3, 3) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func010C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func011C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func014C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 3, 3) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func015C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func016C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func019C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 3, 3) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func020C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 4, 4) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func021C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func024C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 7, 7) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 6, 6) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func025C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 7, 7) == "0" ) ) then
        return false
    endif
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 6, 6) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func026C takes nothing returns boolean
    if ( not ( SubStringBJ(ParseTags(udg_NICKTempText), 5, 5) == "0" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func036C takes nothing returns boolean
    if ( not ( udg_SHeroAncientOrbs > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func037C takes nothing returns boolean
    if ( not ( udg_SHeroArchivistGold > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func038C takes nothing returns boolean
    if ( not ( udg_SHeroBladeClaws1 > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func039C takes nothing returns boolean
    if ( not ( udg_SHeroBladeClaws2 > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func040C takes nothing returns boolean
    if ( not ( udg_SHeroBoneCollectorInt > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func041C takes nothing returns boolean
    if ( not ( udg_SHeroDuckCheeses > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func042C takes nothing returns boolean
    return true
endfunction

function Trig_Hero_Info_command_Func043C takes nothing returns boolean
    if ( not ( udg_SHeroRylaiInt > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Func044C takes nothing returns boolean
    if ( not ( udg_SHeroItemArP[GetConvertedPlayerId(GetTriggerPlayer())] > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_Info_command_Actions takes nothing returns nothing
    set udg_temp_int=GetConvertedPlayerId(GetTriggerPlayer())
    set udg_X=( 10 * udg_temp_int )
    set udg_NICKTempText=R2S(( BlzGetUnitRealField(udg_NICKHeroArray[udg_temp_int], UNIT_RF_STRENGTH_PER_LEVEL) + I2R(udg_reward_stats_perlvl[( udg_X + 1 )]) ))
    if ( Trig_Hero_Info_command_Func004C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 1)
    else
    endif
    if ( Trig_Hero_Info_command_Func005C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 3)
    else
    endif
    if ( Trig_Hero_Info_command_Func006C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 4)
    else
    endif
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Strength per level: |cffffcc00" + ( udg_NICKTempText + "|r" ) ))
    set udg_NICKTempText=R2S(( BlzGetUnitRealField(udg_NICKHeroArray[udg_temp_int], UNIT_RF_AGILITY_PER_LEVEL) + I2R(udg_reward_stats_perlvl[( udg_X + 3 )]) ))
    if ( Trig_Hero_Info_command_Func009C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 1)
    else
    endif
    if ( Trig_Hero_Info_command_Func010C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 3)
    else
    endif
    if ( Trig_Hero_Info_command_Func011C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 4)
    else
    endif
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Agility per level: |cffffcc00" + ( udg_NICKTempText + "|r" ) ))
    set udg_NICKTempText=R2S(( BlzGetUnitRealField(udg_NICKHeroArray[udg_temp_int], UNIT_RF_INTELLIGENCE_PER_LEVEL) + I2R(udg_reward_stats_perlvl[( udg_X + 2 )]) ))
    if ( Trig_Hero_Info_command_Func014C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 1)
    else
    endif
    if ( Trig_Hero_Info_command_Func015C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 3)
    else
    endif
    if ( Trig_Hero_Info_command_Func016C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 4)
    else
    endif
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Intelligence per level: |cffffcc00" + ( udg_NICKTempText + "|r" ) ))
    set udg_NICKTempText=R2S(BlzGetUnitAttackCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], 0))
    if ( Trig_Hero_Info_command_Func019C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 1)
    else
    endif
    if ( Trig_Hero_Info_command_Func020C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 3)
    else
    endif
    if ( Trig_Hero_Info_command_Func021C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 4)
    else
    endif
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Attack cooldown: |cffffcc00" + ( udg_NICKTempText + "|r" ) ))
    set udg_NICKTempText=R2S(GetUnitMoveSpeed(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())]))
    if ( Trig_Hero_Info_command_Func024C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 3)
    else
    endif
    if ( Trig_Hero_Info_command_Func025C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 5)
    else
    endif
    if ( Trig_Hero_Info_command_Func026C() ) then
        set udg_NICKTempText=SubStringBJ(udg_NICKTempText, 1, 6)
    else
    endif
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Movement speed: |cffffcc00" + udg_NICKTempText ))
    set udg_NICKTempText=( I2S(R2I(( udg_spelldamage[GetConvertedPlayerId(GetTriggerPlayer())] * 100.01 ))) + "%|r" )
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|rSpell Damage: |cfffa5e19" + udg_NICKTempText ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Spell Damage Bonus: |cfffa5e19" + I2S(R2I(udg_reward_spelldmg[( udg_X + 2 )])) ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|rSummons Damage Bonus (%): |cfffa5e19" + ( I2S(udg_reward_upsummons[( udg_X + 1 )]) + "%|r" ) ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Summons Damage Bonus: |cfffa5e19" + I2S(( udg_reward_upsummons[( udg_X + 2 )] * 10 )) ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|rSummons Health Bonus: |cfffa5e19" + I2S(( udg_reward_upsummons[( udg_X + 3 )] * 150 )) ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|rSacred Pillar Return Damage (%): |cfffa5e19" + ( I2S(( udg_reward_returndmg_pillar * 20 )) + "%|r" ) ))
    call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "Life Steal Bonus (%): |cfffa5e19" + ( I2S(R2I(( udg_reward_lifesteal_Copy[udg_temp_int] * 100.00 ))) + "%|r" ) ))
    if ( Trig_Hero_Info_command_Func036C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Ancient Orbs Consumed:|r " + I2S(udg_SHeroAncientOrbs) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func037C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Gold Archivist Recovered from Tomes:|r " + I2S(( 250 * udg_SHeroArchivistGold )) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func038C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Blademaster Claws Consumed (1):|r " + I2S(udg_SHeroBladeClaws1) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func039C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Blademaster Claws Consumed (2):|r " + I2S(udg_SHeroBladeClaws2) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func040C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Bone Collector Bonus Intelligence:|r " + I2S(udg_SHeroBoneCollectorInt) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func041C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Duck Cheese:|r " + I2S(udg_SHeroDuckCheeses) ))
    else
    endif
    if ( (true) ) then // INLINED!!
    else
    endif
    if ( Trig_Hero_Info_command_Func043C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Rylai Bonus Intelligence|r " + I2S(udg_SHeroRylaiInt) ))
    else
    endif
    if ( Trig_Hero_Info_command_Func044C() ) then
        call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()), 10.00, ( "|cffffff00SLASH - Flat Armor Penetration:|r " + I2S(R2I(udg_SHeroItemArP[GetConvertedPlayerId(GetTriggerPlayer())])) ))
    else
    endif
endfunction

//===========================================================================
function InitTrig_Hero_Info_command takes nothing returns nothing
    set gg_trg_Hero_Info_command=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Hero_Info_command, Player(0), "-hero", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Hero_Info_command, Player(1), "-hero", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Hero_Info_command, Player(2), "-hero", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Hero_Info_command, Player(3), "-hero", true)
    call TriggerAddAction(gg_trg_Hero_Info_command, function Trig_Hero_Info_command_Actions)
endfunction

//===========================================================================
// Trigger: Continue Command
//===========================================================================
function Trig_Continue_Command_Actions takes nothing returns nothing
    set udg_ChoosePlayers=0
endfunction

//===========================================================================
function InitTrig_Continue_Command takes nothing returns nothing
    set gg_trg_Continue_Command=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Continue_Command, Player(0), "-continue", true)
    call TriggerAddAction(gg_trg_Continue_Command, function Trig_Continue_Command_Actions)
endfunction

//===========================================================================
// Trigger: Kick command
//===========================================================================
function Trig_Kick_command_Func001C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == GetPlayerName(Player(1)) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func002C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == GetPlayerName(Player(2)) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func003C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == GetPlayerName(Player(3)) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func004C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "2" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func005C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "3" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func006C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "4" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func007C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "blue" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func008C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "teal" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Func009C takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 7, 99) == "purple" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kick_command_Actions takes nothing returns nothing
    if ( Trig_Kick_command_Func001C() ) then
        call CustomDefeatBJ(Player(1), "TRIGSTR_3294")
    else
    endif
    if ( Trig_Kick_command_Func002C() ) then
        call CustomDefeatBJ(Player(2), "TRIGSTR_3296")
    else
    endif
    if ( Trig_Kick_command_Func003C() ) then
        call CustomDefeatBJ(Player(3), "TRIGSTR_3489")
    else
    endif
    if ( Trig_Kick_command_Func004C() ) then
        call CustomDefeatBJ(Player(1), "TRIGSTR_3490")
    else
    endif
    if ( Trig_Kick_command_Func005C() ) then
        call CustomDefeatBJ(Player(2), "TRIGSTR_3491")
    else
    endif
    if ( Trig_Kick_command_Func006C() ) then
        call CustomDefeatBJ(Player(3), "TRIGSTR_3492")
    else
    endif
    if ( Trig_Kick_command_Func007C() ) then
        call CustomDefeatBJ(Player(1), "TRIGSTR_3493")
    else
    endif
    if ( Trig_Kick_command_Func008C() ) then
        call CustomDefeatBJ(Player(2), "TRIGSTR_3494")
    else
    endif
    if ( Trig_Kick_command_Func009C() ) then
        call CustomDefeatBJ(Player(3), "TRIGSTR_3495")
    else
    endif
endfunction

//===========================================================================
function InitTrig_Kick_command takes nothing returns nothing
    set gg_trg_Kick_command=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Kick_command, Player(0), "-kick", false)
    call TriggerAddAction(gg_trg_Kick_command, function Trig_Kick_command_Actions)
endfunction

//===========================================================================
// Trigger: clear Command
//===========================================================================
function Trig_clear_Command_Conditions takes nothing returns boolean
    if ( not ( IsTriggerEnabled(gg_trg_end_lose_condition) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_clear_Command_Func002A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_clear_Command_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(20)), function Trig_clear_Command_Func002A)
endfunction

//===========================================================================
function InitTrig_clear_Command takes nothing returns nothing
    set gg_trg_clear_Command=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_clear_Command, Player(0), "-clear", true)
    call TriggerAddCondition(gg_trg_clear_Command, Condition(function Trig_clear_Command_Conditions))
    call TriggerAddAction(gg_trg_clear_Command, function Trig_clear_Command_Actions)
endfunction

//===========================================================================
// Trigger: enum
//===========================================================================
function Trig_enum_Conditions takes nothing returns boolean
    if ( not ( IsTriggerEnabled(gg_trg_end_lose_condition) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_enum_Func003A takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( ( GetUnitName(GetEnumUnit()) + " " ) + ( ( R2S(GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit())) + " " ) + ( ( R2S(GetLocationX(GetUnitLoc(GetEnumUnit()))) + " " ) + R2S(GetLocationY(GetUnitLoc(GetEnumUnit()))) ) ) ))
    call PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetEnumUnit()), 1)
endfunction

function Trig_enum_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( "CG " + I2S(CountUnitsInGroup(GetUnitsOfPlayerAll(Player(20)))) ))
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(20)), function Trig_enum_Func003A)
endfunction

//===========================================================================
function InitTrig_enum takes nothing returns nothing
    set gg_trg_enum=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_enum, Player(0), "-enum", true)
    call TriggerAddCondition(gg_trg_enum, Condition(function Trig_enum_Conditions))
    call TriggerAddAction(gg_trg_enum, function Trig_enum_Actions)
endfunction

//===========================================================================
// Trigger: Swap Commannd
//===========================================================================
function Trig_Swap_Commannd_Func014Func002C takes nothing returns boolean
    if ( not ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]) == udg_temp_string ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func014Func004C takes nothing returns boolean
    if ( not ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]) == udg_temp_string2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func016Func002C takes nothing returns boolean
    if ( not ( SubStringBJ(udg_temp_string, 1, ( StringLength(udg_temp_string) - 2 )) == SubStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), 1, ( StringLength(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()])) - 2 )) ) ) then
        return false
    endif
    if ( not ( SubStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), StringLength(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()])), 1) == udg_Hotkeys[udg_temp_num] ) ) then
        return false
    endif
    if ( not ( udg_temp_integr[1] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func016Func004C takes nothing returns boolean
    if ( not ( SubStringBJ(udg_temp_string2, 1, ( StringLength(udg_temp_string2) - 2 )) == SubStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), 1, ( StringLength(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()])) - 2 )) ) ) then
        return false
    endif
    if ( not ( SubStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), StringLength(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()])), 1) == udg_Hotkeys[udg_temp_int] ) ) then
        return false
    endif
    if ( not ( udg_temp_integr[2] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func017Func001C takes nothing returns boolean
    if ( not ( udg_UpAbil[GetConvertedPlayerId(GetTriggerPlayer())] == udg_temp_num ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func017C takes nothing returns boolean
    if ( not ( udg_UpAbil[GetConvertedPlayerId(GetTriggerPlayer())] == udg_temp_int ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func018Func001C takes nothing returns boolean
    if ( not ( udg_RetrainNr[udg_X] == udg_temp_num ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Func018C takes nothing returns boolean
    if ( not ( udg_RetrainNr[udg_X] == udg_temp_int ) ) then
        return false
    endif
    return true
endfunction

function Trig_Swap_Commannd_Actions takes nothing returns nothing
    set udg_temp_integr[1]=0
    set udg_temp_integr[2]=0
    set udg_temp_int=S2I(SubStringBJ(GetEventPlayerChatString(), 7, 1))
    set udg_temp_int=( udg_temp_int - 1 )
    set udg_temp_num=S2I(SubStringBJ(GetEventPlayerChatString(), 9, 1))
    set udg_temp_num=( udg_temp_num - 1 )
    set udg_temp_string=LoadStringBJ(udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
    set udg_temp_string2=LoadStringBJ(udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
    set udg_retraining_levelof_Ability[GetConvertedPlayerId(GetTriggerPlayer())]=0
    if udg_temp_int < 0 or udg_temp_int > 6 or udg_temp_num < 0 or udg_temp_num > 6 then
    return
    endif
    // remove old abilities-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    set bj_forLoopAIndex=0
    set bj_forLoopAIndexEnd=700
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        // Ability1
        if ( Trig_Swap_Commannd_Func014Func002C() ) then
            set udg_swap_temp_real1[GetConvertedPlayerId(GetTriggerPlayer())]=BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()])
            set bj_forLoopBIndex=0
            set bj_forLoopBIndexEnd=11
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_swap_temp_real3[GetForLoopIndexB()]=BlzGetUnitAbilityCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()], GetForLoopIndexB())
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
            set udg_temp_integr[1]=GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call UnitRemoveAbilityBJ(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call Unlearn(GetTriggerPlayer() , udg_temp_int)
            call SaveStringBJ("", udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
            call SaveStringBJ("", udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_maxabilities)
        else
        endif
        // Ability2
        if ( Trig_Swap_Commannd_Func014Func004C() ) then
            set udg_swap_temp_real2[GetConvertedPlayerId(GetTriggerPlayer())]=BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()])
            set bj_forLoopBIndex=0
            set bj_forLoopBIndexEnd=11
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_swap_temp_real4[GetForLoopIndexB()]=BlzGetUnitAbilityCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()], GetForLoopIndexB())
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
            set udg_temp_integr[2]=GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call UnitRemoveAbilityBJ(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call Unlearn(GetTriggerPlayer() , udg_temp_num)
            call SaveStringBJ("", udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
            call SaveStringBJ("", udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_maxabilities)
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    // add new------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    set bj_forLoopAIndex=0
    set bj_forLoopAIndexEnd=700
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        // Ability1 -> Ability2
        if ( Trig_Swap_Commannd_Func016Func002C() ) then
            set udg_swap_temp_ability1[GetConvertedPlayerId(GetTriggerPlayer())]=udg_Hotkey_Abilities[GetForLoopIndexA()]
            call UnitAddAbilityBJ(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call SaveStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
            call SaveIntegerBJ(GetForLoopIndexA(), udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_maxabilities)
            call SetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_temp_integr[1])
            call AddAbility(GetTriggerPlayer() , udg_temp_num + 1 , udg_Hotkey_Abilities[bj_forLoopAIndex])
            // in case of spell mastery trait
            set bj_forLoopBIndex=0
            set bj_forLoopBIndexEnd=11
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()]), ABILITY_RLF_COOLDOWN, GetForLoopIndexB(), udg_swap_temp_real3[GetForLoopIndexB()])
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
        endif
        // Ability2 -> Ability1
        if ( Trig_Swap_Commannd_Func016Func004C() ) then
            set udg_swap_temp_ability2[GetConvertedPlayerId(GetTriggerPlayer())]=udg_Hotkey_Abilities[GetForLoopIndexA()]
            call UnitAddAbilityBJ(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())])
            call SaveStringBJ(GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexA()]), udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
            call SaveIntegerBJ(GetForLoopIndexA(), udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_maxabilities)
            call SetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[GetForLoopIndexA()], udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_temp_integr[2])
            call AddAbility(GetTriggerPlayer() , udg_temp_int + 1 , udg_Hotkey_Abilities[bj_forLoopAIndex])
            // in case of spell mastery trait
            set bj_forLoopBIndex=0
            set bj_forLoopBIndexEnd=11
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_Hotkey_Abilities[GetForLoopIndexA()]), ABILITY_RLF_COOLDOWN, GetForLoopIndexB(), udg_swap_temp_real4[GetForLoopIndexB()])
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if ( Trig_Swap_Commannd_Func017C() ) then
        set udg_UpAbil[udg_X]=udg_temp_num
    else
        if ( Trig_Swap_Commannd_Func017Func001C() ) then
            set udg_UpAbil[udg_X]=udg_temp_int
        else
        endif
    endif
    if ( Trig_Swap_Commannd_Func018C() ) then
        set udg_RetrainNr[udg_X]=udg_temp_num
    else
        if ( Trig_Swap_Commannd_Func018Func001C() ) then
            set udg_RetrainNr[udg_X]=udg_temp_int
        else
        endif
    endif
    set udg_temp_integr[11]=LoadIntegerBJ(udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_upgradeshop_ability)
    set udg_temp_integr[12]=LoadIntegerBJ(udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_upgradeshop_ability)
    call SaveIntegerBJ(udg_temp_integr[11], udg_temp_num, GetConvertedPlayerId(GetTriggerPlayer()), udg_upgradeshop_ability)
    call SaveIntegerBJ(udg_temp_integr[12], udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_upgradeshop_ability)
    call TriggerSleepAction(0.10)
    call BlzStartUnitAbilityCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_swap_temp_ability1[GetConvertedPlayerId(GetTriggerPlayer())], udg_swap_temp_real1[GetConvertedPlayerId(GetTriggerPlayer())])
    call BlzStartUnitAbilityCooldown(udg_NICKHeroArray[GetConvertedPlayerId(GetTriggerPlayer())], udg_swap_temp_ability2[GetConvertedPlayerId(GetTriggerPlayer())], udg_swap_temp_real2[GetConvertedPlayerId(GetTriggerPlayer())])
endfunction

//===========================================================================
function InitTrig_Swap_Commannd takes nothing returns nothing
    set gg_trg_Swap_Commannd=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(0), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(1), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(2), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(3), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(4), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(5), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(6), "-swap", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Swap_Commannd, Player(7), "-swap", false)
    call TriggerAddAction(gg_trg_Swap_Commannd, function Trig_Swap_Commannd_Actions)
endfunction

//===========================================================================
// Trigger: Floating Text dmg
//===========================================================================
function Trig_Floating_Text_dmg_Conditions takes nothing returns boolean
    if ( not ( udg_floating_text_enabled[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))] == true ) ) then
        return false
    endif
    if ( not ( udg_DamageEventAmount > 1.00 ) ) then
        return false
    endif
    if ( not ( IsUnitVisible(udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_dmg_Func006C takes nothing returns boolean
    if ( not ( udg_temp_real > 10.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_dmg_Func007C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_DamageEventTarget, udg_floating_text_targets[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_dmg_Func008C takes nothing returns boolean
    if ( not ( udg_IsDamageSpell == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_dmg_Actions takes nothing returns nothing
    set udg_handle_temp=udg_DamageEventTarget
    set udg_temp_real=( 6.00 + ( 15.00 * ( udg_DamageEventAmount / 2000.00 ) ) )
    if ( Trig_Floating_Text_dmg_Func006C() ) then
        set udg_temp_real=10.00
    else
    endif
    if ( Trig_Floating_Text_dmg_Func007C() ) then
        call SaveRealBJ(( LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)), udg_floating_text_table) + 4.00 ), GetHandleIdBJ(udg_handle_temp), GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)), udg_floating_text_table)
    else
        call SaveRealBJ(1.00, GetHandleIdBJ(udg_handle_temp), GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)), udg_floating_text_table)
        call GroupAddUnitSimple(udg_DamageEventTarget, udg_floating_text_targets[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))])
    endif
    if ( Trig_Floating_Text_dmg_Func008C() ) then
        call CreateTextTagLocBJ(I2S(R2I(udg_DamageEventAmount)), OffsetLocation(GetUnitLoc(udg_DamageEventTarget), - 50.00, ( 5.00 * LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)), udg_floating_text_table) )), 0.00, udg_temp_real, 0.00, 70.00, 100, 0.00)
    else
        call CreateTextTagLocBJ(I2S(R2I(udg_DamageEventAmount)), PolarProjectionBJ(GetUnitLoc(udg_DamageEventTarget), ( 5.00 * LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource)), udg_floating_text_table) ), 90.00), 0.00, udg_temp_real, 100, 100, 100, 0.00)
    endif
    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 40.00, - 90.00)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), ( 1.50 + RMinBJ(( udg_DamageEventAmount / 500.00 ), 3.00) ))
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), ( 0.75 + RMinBJ(( udg_DamageEventAmount / 500.00 ), 3.00) ))
    call ShowTextTagForceBJ(false, GetLastCreatedTextTag(), GetPlayersAll())
    call ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetForceOfPlayer(GetOwningPlayer(udg_DamageEventSource)))
endfunction

//===========================================================================
function InitTrig_Floating_Text_dmg takes nothing returns nothing
    set gg_trg_Floating_Text_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Floating_Text_dmg, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Floating_Text_dmg, Condition(function Trig_Floating_Text_dmg_Conditions))
    call TriggerAddAction(gg_trg_Floating_Text_dmg, function Trig_Floating_Text_dmg_Actions)
endfunction

//===========================================================================
// Trigger: Floating Text periodic
//===========================================================================
function Trig_Floating_Text_periodic_Func001Func001Func002Func003C takes nothing returns boolean
    if ( not ( LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetForLoopIndexA(), udg_floating_text_table) > 20.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_periodic_Func001Func001Func002C takes nothing returns boolean
    if ( not ( LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetForLoopIndexA(), udg_floating_text_table) > 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Floating_Text_periodic_Func001Func001A takes nothing returns nothing
    set udg_handle_temp=GetEnumUnit()
    if ( Trig_Floating_Text_periodic_Func001Func001Func002C() ) then
        call SaveRealBJ(( LoadRealBJ(GetHandleIdBJ(udg_handle_temp), GetForLoopIndexA(), udg_floating_text_table) - 2.00 ), GetHandleIdBJ(udg_handle_temp), GetForLoopIndexA(), udg_floating_text_table)
        if ( Trig_Floating_Text_periodic_Func001Func001Func002Func003C() ) then
            call SaveRealBJ(1.00, GetHandleIdBJ(udg_handle_temp), GetForLoopIndexA(), udg_floating_text_table)
        else
        endif
    else
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_floating_text_targets[GetForLoopIndexA()])
    endif
endfunction

function Trig_Floating_Text_periodic_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ForGroupBJ(udg_floating_text_targets[GetForLoopIndexA()], function Trig_Floating_Text_periodic_Func001Func001A)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Floating_Text_periodic takes nothing returns nothing
    set gg_trg_Floating_Text_periodic=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Floating_Text_periodic, 0.50)
    call TriggerAddAction(gg_trg_Floating_Text_periodic, function Trig_Floating_Text_periodic_Actions)
endfunction

//===========================================================================
// Trigger: Set Hotkey Abilities
//===========================================================================
function Trig_Set_Hotkey_Abilities_Actions takes nothing returns nothing
    set udg_Hotkey_Abilities[0]='A047'
    set udg_Hotkey_Abilities[1]='A045'
    set udg_Hotkey_Abilities[2]='A048'
    set udg_Hotkey_Abilities[3]='A049'
    set udg_Hotkey_Abilities[4]='A021'
    set udg_Hotkey_Abilities[5]='A046'
    set udg_Hotkey_Abilities[6]='A044'
    set udg_Hotkey_Abilities[7]='A0FN'
    set udg_Hotkey_Abilities[8]='A0FL'
    set udg_Hotkey_Abilities[9]='A0FO'
    set udg_Hotkey_Abilities[10]='A0FP'
    set udg_Hotkey_Abilities[11]='A03S'
    set udg_Hotkey_Abilities[12]='A0FM'
    set udg_Hotkey_Abilities[13]='A0FK'
    set udg_Hotkey_Abilities[14]='A0FU'
    set udg_Hotkey_Abilities[15]='A0FS'
    set udg_Hotkey_Abilities[16]='A0FV'
    set udg_Hotkey_Abilities[17]='A0FW'
    set udg_Hotkey_Abilities[18]='A0FQ'
    set udg_Hotkey_Abilities[19]='A0FT'
    set udg_Hotkey_Abilities[20]='A0FR'
    set udg_Hotkey_Abilities[21]='A05T'
    set udg_Hotkey_Abilities[22]='A04C'
    set udg_Hotkey_Abilities[23]='A05U'
    set udg_Hotkey_Abilities[24]='A05V'
    set udg_Hotkey_Abilities[25]='A02F'
    set udg_Hotkey_Abilities[26]='A05S'
    set udg_Hotkey_Abilities[27]='A04A'
    set udg_Hotkey_Abilities[28]='A06E'
    set udg_Hotkey_Abilities[29]='A06C'
    set udg_Hotkey_Abilities[30]='A06F'
    set udg_Hotkey_Abilities[31]='A06G'
    set udg_Hotkey_Abilities[32]='A06A'
    set udg_Hotkey_Abilities[33]='A06D'
    set udg_Hotkey_Abilities[34]='A06B'
    set udg_Hotkey_Abilities[35]='A060'
    set udg_Hotkey_Abilities[36]='A05Z'
    set udg_Hotkey_Abilities[37]='A061'
    set udg_Hotkey_Abilities[38]='A062'
    set udg_Hotkey_Abilities[39]='A05W'
    set udg_Hotkey_Abilities[40]='A05Y'
    set udg_Hotkey_Abilities[41]='A05X'
    set udg_Hotkey_Abilities[42]='A067'
    set udg_Hotkey_Abilities[43]='A065'
    set udg_Hotkey_Abilities[44]='A068'
    set udg_Hotkey_Abilities[45]='A069'
    set udg_Hotkey_Abilities[46]='A063'
    set udg_Hotkey_Abilities[47]='A066'
    set udg_Hotkey_Abilities[48]='A064'
    set udg_Hotkey_Abilities[49]='A0G1'
    set udg_Hotkey_Abilities[50]='A0FZ'
    set udg_Hotkey_Abilities[51]='A0G2'
    set udg_Hotkey_Abilities[52]='A0G3'
    set udg_Hotkey_Abilities[53]='A0FX'
    set udg_Hotkey_Abilities[54]='A0G0'
    set udg_Hotkey_Abilities[55]='A0FY'
    set udg_Hotkey_Abilities[56]='A06L'
    set udg_Hotkey_Abilities[57]='A06J'
    set udg_Hotkey_Abilities[58]='A06M'
    set udg_Hotkey_Abilities[59]='A06N'
    set udg_Hotkey_Abilities[60]='A06H'
    set udg_Hotkey_Abilities[61]='A06K'
    set udg_Hotkey_Abilities[62]='A06I'
    set udg_Hotkey_Abilities[63]='A0G8'
    set udg_Hotkey_Abilities[64]='A0G6'
    set udg_Hotkey_Abilities[65]='A0G9'
    set udg_Hotkey_Abilities[66]='A0GA'
    set udg_Hotkey_Abilities[67]='A0G4'
    set udg_Hotkey_Abilities[68]='A0G7'
    set udg_Hotkey_Abilities[69]='A0G5'
    set udg_Hotkey_Abilities[70]='A06S'
    set udg_Hotkey_Abilities[71]='A06Q'
    set udg_Hotkey_Abilities[72]='A06T'
    set udg_Hotkey_Abilities[73]='A06U'
    set udg_Hotkey_Abilities[74]='A06O'
    set udg_Hotkey_Abilities[75]='A06R'
    set udg_Hotkey_Abilities[76]='A06P'
    set udg_Hotkey_Abilities[77]='A06Z'
    set udg_Hotkey_Abilities[78]='A04B'
    set udg_Hotkey_Abilities[79]='A00N'
    set udg_Hotkey_Abilities[80]='A00O'
    set udg_Hotkey_Abilities[81]='A01J'
    set udg_Hotkey_Abilities[82]='A06V'
    set udg_Hotkey_Abilities[83]='A01N'
    set udg_Hotkey_Abilities[84]='A075'
    set udg_Hotkey_Abilities[85]='A073'
    set udg_Hotkey_Abilities[86]='A076'
    set udg_Hotkey_Abilities[87]='A077'
    set udg_Hotkey_Abilities[88]='A01M'
    set udg_Hotkey_Abilities[89]='A074'
    set udg_Hotkey_Abilities[90]='A072'
    set udg_Hotkey_Abilities[91]='A0GF'
    set udg_Hotkey_Abilities[92]='A0GD'
    set udg_Hotkey_Abilities[93]='A0GG'
    set udg_Hotkey_Abilities[94]='A0GH'
    set udg_Hotkey_Abilities[95]='A0GB'
    set udg_Hotkey_Abilities[96]='A0GC'
    set udg_Hotkey_Abilities[97]='A0GE'
    set udg_Hotkey_Abilities[98]='A0GM'
    set udg_Hotkey_Abilities[99]='A0GK'
    set udg_Hotkey_Abilities[100]='A0GN'
    set udg_Hotkey_Abilities[101]='A0GO'
    set udg_Hotkey_Abilities[102]='A0GI'
    set udg_Hotkey_Abilities[103]='A0GL'
    set udg_Hotkey_Abilities[104]='A0GJ'
    set udg_Hotkey_Abilities[105]='A07C'
    set udg_Hotkey_Abilities[106]='A07D'
    set udg_Hotkey_Abilities[107]='A078'
    set udg_Hotkey_Abilities[108]='A079'
    set udg_Hotkey_Abilities[109]='A07A'
    set udg_Hotkey_Abilities[110]='A07E'
    set udg_Hotkey_Abilities[111]='A07B'
    set udg_Hotkey_Abilities[112]='A0GT'
    set udg_Hotkey_Abilities[113]='A0GR'
    set udg_Hotkey_Abilities[114]='A0GU'
    set udg_Hotkey_Abilities[115]='A0GV'
    set udg_Hotkey_Abilities[116]='A0GP'
    set udg_Hotkey_Abilities[117]='A0GS'
    set udg_Hotkey_Abilities[118]='A0GQ'
    set udg_Hotkey_Abilities[119]='A0H0'
    set udg_Hotkey_Abilities[120]='A0GY'
    set udg_Hotkey_Abilities[121]='A0H1'
    set udg_Hotkey_Abilities[122]='A0H2'
    set udg_Hotkey_Abilities[123]='A0GW'
    set udg_Hotkey_Abilities[124]='A0GZ'
    set udg_Hotkey_Abilities[125]='A0GX'
    set udg_Hotkey_Abilities[126]='A07J'
    set udg_Hotkey_Abilities[127]='A07H'
    set udg_Hotkey_Abilities[128]='A07K'
    set udg_Hotkey_Abilities[129]='A07L'
    set udg_Hotkey_Abilities[130]='A07F'
    set udg_Hotkey_Abilities[131]='A07I'
    set udg_Hotkey_Abilities[132]='A07G'
    set udg_Hotkey_Abilities[133]='A07Q'
    set udg_Hotkey_Abilities[134]='A07O'
    set udg_Hotkey_Abilities[135]='A07R'
    set udg_Hotkey_Abilities[136]='A07S'
    set udg_Hotkey_Abilities[137]='A07M'
    set udg_Hotkey_Abilities[138]='A07P'
    set udg_Hotkey_Abilities[139]='A07N'
    set udg_Hotkey_Abilities[140]='A07X'
    set udg_Hotkey_Abilities[141]='A07V'
    set udg_Hotkey_Abilities[142]='A07Y'
    set udg_Hotkey_Abilities[143]='A07Z'
    set udg_Hotkey_Abilities[144]='A07T'
    set udg_Hotkey_Abilities[145]='A07W'
    set udg_Hotkey_Abilities[146]='A07U'
    set udg_Hotkey_Abilities[147]='A0H7'
    set udg_Hotkey_Abilities[148]='A0H5'
    set udg_Hotkey_Abilities[149]='A0H8'
    set udg_Hotkey_Abilities[150]='A0H9'
    set udg_Hotkey_Abilities[151]='A0H3'
    set udg_Hotkey_Abilities[152]='A0H6'
    set udg_Hotkey_Abilities[153]='A0H4'
    set udg_Hotkey_Abilities[154]='A081'
    set udg_Hotkey_Abilities[155]='A082'
    set udg_Hotkey_Abilities[156]='A083'
    set udg_Hotkey_Abilities[157]='A01K'
    set udg_Hotkey_Abilities[158]='A080'
    set udg_Hotkey_Abilities[159]='A03A'
    set udg_Hotkey_Abilities[160]='A0HE'
    set udg_Hotkey_Abilities[161]='A0HC'
    set udg_Hotkey_Abilities[162]='A0HF'
    set udg_Hotkey_Abilities[163]='A0HG'
    set udg_Hotkey_Abilities[164]='A0HA'
    set udg_Hotkey_Abilities[165]='A0HD'
    set udg_Hotkey_Abilities[166]='A0HB'
    set udg_Hotkey_Abilities[167]='A088'
    set udg_Hotkey_Abilities[168]='A086'
    set udg_Hotkey_Abilities[169]='A089'
    set udg_Hotkey_Abilities[170]='A08A'
    set udg_Hotkey_Abilities[171]='A084'
    set udg_Hotkey_Abilities[172]='A087'
    set udg_Hotkey_Abilities[173]='A085'
    set udg_Hotkey_Abilities[174]='A08F'
    set udg_Hotkey_Abilities[175]='A08D'
    set udg_Hotkey_Abilities[176]='A08G'
    set udg_Hotkey_Abilities[177]='A08H'
    set udg_Hotkey_Abilities[178]='A08B'
    set udg_Hotkey_Abilities[179]='A08E'
    set udg_Hotkey_Abilities[180]='A08C'
    set udg_Hotkey_Abilities[181]='A0HL'
    set udg_Hotkey_Abilities[182]='A0HJ'
    set udg_Hotkey_Abilities[183]='A0HM'
    set udg_Hotkey_Abilities[184]='A0HN'
    set udg_Hotkey_Abilities[185]='A0HH'
    set udg_Hotkey_Abilities[186]='A0HK'
    set udg_Hotkey_Abilities[187]='A0HI'
    set udg_Hotkey_Abilities[188]='A08M'
    set udg_Hotkey_Abilities[189]='A08K'
    set udg_Hotkey_Abilities[190]='A08N'
    set udg_Hotkey_Abilities[191]='A08O'
    set udg_Hotkey_Abilities[192]='A08I'
    set udg_Hotkey_Abilities[193]='A08L'
    set udg_Hotkey_Abilities[194]='A08J'
    set udg_Hotkey_Abilities[195]='A0HS'
    set udg_Hotkey_Abilities[196]='A0HQ'
    set udg_Hotkey_Abilities[197]='A0HT'
    set udg_Hotkey_Abilities[198]='A0HU'
    set udg_Hotkey_Abilities[199]='A0HO'
    set udg_Hotkey_Abilities[200]='A0HR'
    set udg_Hotkey_Abilities[201]='A0HP'
    set udg_Hotkey_Abilities[202]='A08T'
    set udg_Hotkey_Abilities[203]='A08R'
    set udg_Hotkey_Abilities[204]='A08U'
    set udg_Hotkey_Abilities[205]='A08V'
    set udg_Hotkey_Abilities[206]='A08P'
    set udg_Hotkey_Abilities[207]='A08S'
    set udg_Hotkey_Abilities[208]='A08Q'
    set udg_Hotkey_Abilities[209]='A0HZ'
    set udg_Hotkey_Abilities[210]='A012'
    set udg_Hotkey_Abilities[211]='A00Y'
    set udg_Hotkey_Abilities[212]='A00Z'
    set udg_Hotkey_Abilities[213]='A010'
    set udg_Hotkey_Abilities[214]='A013'
    set udg_Hotkey_Abilities[215]='A011'
    set udg_Hotkey_Abilities[216]='A0I6'
    set udg_Hotkey_Abilities[217]='A0I4'
    set udg_Hotkey_Abilities[218]='A0I7'
    set udg_Hotkey_Abilities[219]='A0I8'
    set udg_Hotkey_Abilities[220]='A0I2'
    set udg_Hotkey_Abilities[221]='A0I5'
    set udg_Hotkey_Abilities[222]='A0I3'
    set udg_Hotkey_Abilities[223]='A090'
    set udg_Hotkey_Abilities[224]='A08Y'
    set udg_Hotkey_Abilities[225]='A091'
    set udg_Hotkey_Abilities[226]='A092'
    set udg_Hotkey_Abilities[227]='A08W'
    set udg_Hotkey_Abilities[228]='A08Z'
    set udg_Hotkey_Abilities[229]='A08X'
    set udg_Hotkey_Abilities[230]='A096'
    set udg_Hotkey_Abilities[231]='A094'
    set udg_Hotkey_Abilities[232]='A097'
    set udg_Hotkey_Abilities[233]='A098'
    set udg_Hotkey_Abilities[234]='A099'
    set udg_Hotkey_Abilities[235]='A095'
    set udg_Hotkey_Abilities[236]='A093'
    set udg_Hotkey_Abilities[237]='A09E'
    set udg_Hotkey_Abilities[238]='A09C'
    set udg_Hotkey_Abilities[239]='A09F'
    set udg_Hotkey_Abilities[240]='A09G'
    set udg_Hotkey_Abilities[241]='A09A'
    set udg_Hotkey_Abilities[242]='A09D'
    set udg_Hotkey_Abilities[243]='A09B'
    set udg_Hotkey_Abilities[244]='A09L'
    set udg_Hotkey_Abilities[245]='A09J'
    set udg_Hotkey_Abilities[246]='A09M'
    set udg_Hotkey_Abilities[247]='A09N'
    set udg_Hotkey_Abilities[248]='A09H'
    set udg_Hotkey_Abilities[249]='A09K'
    set udg_Hotkey_Abilities[250]='A09I'
    set udg_Hotkey_Abilities[251]='A09S'
    set udg_Hotkey_Abilities[252]='A09Q'
    set udg_Hotkey_Abilities[253]='A09T'
    set udg_Hotkey_Abilities[254]='A09U'
    set udg_Hotkey_Abilities[255]='A09O'
    set udg_Hotkey_Abilities[256]='A09R'
    set udg_Hotkey_Abilities[257]='A09P'
    set udg_Hotkey_Abilities[258]='A0ID'
    set udg_Hotkey_Abilities[259]='A0IB'
    set udg_Hotkey_Abilities[260]='A0IE'
    set udg_Hotkey_Abilities[261]='A0IF'
    set udg_Hotkey_Abilities[262]='A0I9'
    set udg_Hotkey_Abilities[263]='A0IC'
    set udg_Hotkey_Abilities[264]='A0IA'
    set udg_Hotkey_Abilities[265]='A0IK'
    set udg_Hotkey_Abilities[266]='A0II'
    set udg_Hotkey_Abilities[267]='A0IL'
    set udg_Hotkey_Abilities[268]='A0IM'
    set udg_Hotkey_Abilities[269]='A0IG'
    set udg_Hotkey_Abilities[270]='A0IJ'
    set udg_Hotkey_Abilities[271]='A0IH'
    set udg_Hotkey_Abilities[272]='A0IR'
    set udg_Hotkey_Abilities[273]='A0IP'
    set udg_Hotkey_Abilities[274]='A0IS'
    set udg_Hotkey_Abilities[275]='A0IT'
    set udg_Hotkey_Abilities[276]='A0IN'
    set udg_Hotkey_Abilities[277]='A0IQ'
    set udg_Hotkey_Abilities[278]='A0IO'
    set udg_Hotkey_Abilities[279]='A09Z'
    set udg_Hotkey_Abilities[280]='A09X'
    set udg_Hotkey_Abilities[281]='A0A0'
    set udg_Hotkey_Abilities[282]='A0A1'
    set udg_Hotkey_Abilities[283]='A09V'
    set udg_Hotkey_Abilities[284]='A09Y'
    set udg_Hotkey_Abilities[285]='A09W'
    set udg_Hotkey_Abilities[286]='A0A6'
    set udg_Hotkey_Abilities[287]='A0A4'
    set udg_Hotkey_Abilities[288]='A0A7'
    set udg_Hotkey_Abilities[289]='A0A8'
    set udg_Hotkey_Abilities[290]='A0A2'
    set udg_Hotkey_Abilities[291]='A0A5'
    set udg_Hotkey_Abilities[292]='A0A3'
    set udg_Hotkey_Abilities[293]='A0AD'
    set udg_Hotkey_Abilities[294]='A0AB'
    set udg_Hotkey_Abilities[295]='A0AE'
    set udg_Hotkey_Abilities[296]='A0AF'
    set udg_Hotkey_Abilities[297]='A0A9'
    set udg_Hotkey_Abilities[298]='A0AC'
    set udg_Hotkey_Abilities[299]='A0AA'
    set udg_Hotkey_Abilities[300]='A0AK'
    set udg_Hotkey_Abilities[301]='A0AL'
    set udg_Hotkey_Abilities[302]='A0AG'
    set udg_Hotkey_Abilities[303]='A0AH'
    set udg_Hotkey_Abilities[304]='A0AI'
    set udg_Hotkey_Abilities[305]='A0AM'
    set udg_Hotkey_Abilities[306]='A0AJ'
    set udg_Hotkey_Abilities[307]='A01T'
    set udg_Hotkey_Abilities[308]='A01R'
    set udg_Hotkey_Abilities[309]='A01W'
    set udg_Hotkey_Abilities[310]='A01X'
    set udg_Hotkey_Abilities[311]='A01P'
    set udg_Hotkey_Abilities[312]='A01S'
    set udg_Hotkey_Abilities[313]='A01Q'
    set udg_Hotkey_Abilities[314]='A0AY'
    set udg_Hotkey_Abilities[315]='A0AW'
    set udg_Hotkey_Abilities[316]='A0AZ'
    set udg_Hotkey_Abilities[317]='A0B0'
    set udg_Hotkey_Abilities[318]='A0AU'
    set udg_Hotkey_Abilities[319]='A0AX'
    set udg_Hotkey_Abilities[320]='A0AV'
    set udg_Hotkey_Abilities[321]='A0IY'
    set udg_Hotkey_Abilities[322]='A05B'
    set udg_Hotkey_Abilities[323]='A057'
    set udg_Hotkey_Abilities[324]='A058'
    set udg_Hotkey_Abilities[325]='A059'
    set udg_Hotkey_Abilities[326]='A05C'
    set udg_Hotkey_Abilities[327]='A05A'
    set udg_Hotkey_Abilities[328]='A0B5'
    set udg_Hotkey_Abilities[329]='A0B3'
    set udg_Hotkey_Abilities[330]='A0B6'
    set udg_Hotkey_Abilities[331]='A0B7'
    set udg_Hotkey_Abilities[332]='A0B1'
    set udg_Hotkey_Abilities[333]='A0B4'
    set udg_Hotkey_Abilities[334]='A0B2'
    set udg_Hotkey_Abilities[335]='A0J5'
    set udg_Hotkey_Abilities[336]='A0J3'
    set udg_Hotkey_Abilities[337]='A0J6'
    set udg_Hotkey_Abilities[338]='A0J7'
    set udg_Hotkey_Abilities[339]='A0J1'
    set udg_Hotkey_Abilities[340]='A0J4'
    set udg_Hotkey_Abilities[341]='A0J2'
    set udg_Hotkey_Abilities[342]='A0BC'
    set udg_Hotkey_Abilities[343]='A0BD'
    set udg_Hotkey_Abilities[344]='A0B8'
    set udg_Hotkey_Abilities[345]='A0B9'
    set udg_Hotkey_Abilities[346]='A0BA'
    set udg_Hotkey_Abilities[347]='A0BE'
    set udg_Hotkey_Abilities[348]='A0BB'
    set udg_Hotkey_Abilities[349]='A0BJ'
    set udg_Hotkey_Abilities[350]='A0BG'
    set udg_Hotkey_Abilities[351]='A0BF'
    set udg_Hotkey_Abilities[352]='A0BL'
    set udg_Hotkey_Abilities[353]='A0BH'
    set udg_Hotkey_Abilities[354]='A0BK'
    set udg_Hotkey_Abilities[355]='A0BI'
    set udg_Hotkey_Abilities[356]='A0JC'
    set udg_Hotkey_Abilities[357]='A0JD'
    set udg_Hotkey_Abilities[358]='A0J8'
    set udg_Hotkey_Abilities[359]='A0J9'
    set udg_Hotkey_Abilities[360]='A0JA'
    set udg_Hotkey_Abilities[361]='A0JE'
    set udg_Hotkey_Abilities[362]='A0JB'
    set udg_Hotkey_Abilities[363]='A0JJ'
    set udg_Hotkey_Abilities[364]='A0J0'
    set udg_Hotkey_Abilities[365]='A0IV'
    set udg_Hotkey_Abilities[366]='A0IW'
    set udg_Hotkey_Abilities[367]='A0IX'
    set udg_Hotkey_Abilities[368]='A0JF'
    set udg_Hotkey_Abilities[369]='A0IZ'
    set udg_Hotkey_Abilities[370]='A0BQ'
    set udg_Hotkey_Abilities[371]='A0BN'
    set udg_Hotkey_Abilities[372]='A0BP'
    set udg_Hotkey_Abilities[373]='A0BR'
    set udg_Hotkey_Abilities[374]='A001'
    set udg_Hotkey_Abilities[375]='A0BO'
    set udg_Hotkey_Abilities[376]='A0BM'
    set udg_Hotkey_Abilities[377]='A0JQ'
    set udg_Hotkey_Abilities[378]='A0JO'
    set udg_Hotkey_Abilities[379]='A0JR'
    set udg_Hotkey_Abilities[380]='A0JS'
    set udg_Hotkey_Abilities[381]='A0JM'
    set udg_Hotkey_Abilities[382]='A0JP'
    set udg_Hotkey_Abilities[383]='A0JN'
    set udg_Hotkey_Abilities[384]='A0JX'
    set udg_Hotkey_Abilities[385]='A0JV'
    set udg_Hotkey_Abilities[386]='A0JY'
    set udg_Hotkey_Abilities[387]='A0JZ'
    set udg_Hotkey_Abilities[388]='A0JT'
    set udg_Hotkey_Abilities[389]='A0JW'
    set udg_Hotkey_Abilities[390]='A0JU'
    set udg_Hotkey_Abilities[391]='A0BX'
    set udg_Hotkey_Abilities[392]='A0BV'
    set udg_Hotkey_Abilities[393]='A0BY'
    set udg_Hotkey_Abilities[394]='A0BZ'
    set udg_Hotkey_Abilities[395]='A0BT'
    set udg_Hotkey_Abilities[396]='A0BW'
    set udg_Hotkey_Abilities[397]='A0BU'
    set udg_Hotkey_Abilities[398]='A0K4'
    set udg_Hotkey_Abilities[399]='A0K2'
    set udg_Hotkey_Abilities[400]='A0K5'
    set udg_Hotkey_Abilities[401]='A0K6'
    set udg_Hotkey_Abilities[402]='A0K0'
    set udg_Hotkey_Abilities[403]='A0K3'
    set udg_Hotkey_Abilities[404]='A0K1'
    set udg_Hotkey_Abilities[405]='A0KB'
    set udg_Hotkey_Abilities[406]='A00V'
    set udg_Hotkey_Abilities[407]='A00M'
    set udg_Hotkey_Abilities[408]='A00R'
    set udg_Hotkey_Abilities[409]='A00S'
    set udg_Hotkey_Abilities[410]='A00X'
    set udg_Hotkey_Abilities[411]='A00T'
    set udg_Hotkey_Abilities[412]='A0C4'
    set udg_Hotkey_Abilities[413]='A0C2'
    set udg_Hotkey_Abilities[414]='A0C5'
    set udg_Hotkey_Abilities[415]='A0C6'
    set udg_Hotkey_Abilities[416]='A0C0'
    set udg_Hotkey_Abilities[417]='A0C3'
    set udg_Hotkey_Abilities[418]='A0C1'
    set udg_Hotkey_Abilities[419]='A0CB'
    set udg_Hotkey_Abilities[420]='A0C9'
    set udg_Hotkey_Abilities[421]='A0CC'
    set udg_Hotkey_Abilities[422]='A0CD'
    set udg_Hotkey_Abilities[423]='A0C7'
    set udg_Hotkey_Abilities[424]='A0CA'
    set udg_Hotkey_Abilities[425]='A0C8'
    set udg_Hotkey_Abilities[426]='A0CI'
    set udg_Hotkey_Abilities[427]='A0CG'
    set udg_Hotkey_Abilities[428]='A0CJ'
    set udg_Hotkey_Abilities[429]='A0CK'
    set udg_Hotkey_Abilities[430]='A0CE'
    set udg_Hotkey_Abilities[431]='A0CH'
    set udg_Hotkey_Abilities[432]='A0CF'
    set udg_Hotkey_Abilities[433]='A0CP'
    set udg_Hotkey_Abilities[434]='A0CN'
    set udg_Hotkey_Abilities[435]='A0CQ'
    set udg_Hotkey_Abilities[436]='A0CR'
    set udg_Hotkey_Abilities[437]='A0CL'
    set udg_Hotkey_Abilities[438]='A0CO'
    set udg_Hotkey_Abilities[439]='A0CM'
    set udg_Hotkey_Abilities[440]='A0KI'
    set udg_Hotkey_Abilities[441]='A0KG'
    set udg_Hotkey_Abilities[442]='A0KJ'
    set udg_Hotkey_Abilities[443]='A0KK'
    set udg_Hotkey_Abilities[444]='A0KE'
    set udg_Hotkey_Abilities[445]='A0KH'
    set udg_Hotkey_Abilities[446]='A0KF'
    set udg_Hotkey_Abilities[447]='A0CW'
    set udg_Hotkey_Abilities[448]='A0CU'
    set udg_Hotkey_Abilities[449]='A0CX'
    set udg_Hotkey_Abilities[450]='A0CY'
    set udg_Hotkey_Abilities[451]='A0CS'
    set udg_Hotkey_Abilities[452]='A0CV'
    set udg_Hotkey_Abilities[453]='A0CT'
    set udg_Hotkey_Abilities[454]='A0D3'
    set udg_Hotkey_Abilities[455]='A0D1'
    set udg_Hotkey_Abilities[456]='A0D4'
    set udg_Hotkey_Abilities[457]='A0D5'
    set udg_Hotkey_Abilities[458]='A0CZ'
    set udg_Hotkey_Abilities[459]='A0D2'
    set udg_Hotkey_Abilities[460]='A0D0'
    set udg_Hotkey_Abilities[461]='A0KP'
    set udg_Hotkey_Abilities[462]='A0KN'
    set udg_Hotkey_Abilities[463]='A0KQ'
    set udg_Hotkey_Abilities[464]='A0KR'
    set udg_Hotkey_Abilities[465]='A0KL'
    set udg_Hotkey_Abilities[466]='A0KO'
    set udg_Hotkey_Abilities[467]='A0KM'
    set udg_Hotkey_Abilities[468]='A0DA'
    set udg_Hotkey_Abilities[469]='A0DB'
    set udg_Hotkey_Abilities[470]='A0D6'
    set udg_Hotkey_Abilities[471]='A0D7'
    set udg_Hotkey_Abilities[472]='A0D8'
    set udg_Hotkey_Abilities[473]='A0DC'
    set udg_Hotkey_Abilities[474]='A0D9'
    set udg_Hotkey_Abilities[475]='A0DF'
    set udg_Hotkey_Abilities[476]='A0DD'
    set udg_Hotkey_Abilities[477]='A0DG'
    set udg_Hotkey_Abilities[478]='A0DH'
    set udg_Hotkey_Abilities[479]='A0O5'
    set udg_Hotkey_Abilities[480]='A0DE'
    set udg_Hotkey_Abilities[481]='A0O4'
    set udg_Hotkey_Abilities[482]='A0DO'
    set udg_Hotkey_Abilities[483]='A0DM'
    set udg_Hotkey_Abilities[484]='A0DP'
    set udg_Hotkey_Abilities[485]='A0DQ'
    set udg_Hotkey_Abilities[486]='A0DK'
    set udg_Hotkey_Abilities[487]='A0DN'
    set udg_Hotkey_Abilities[488]='A0DL'
    set udg_Hotkey_Abilities[489]='A0DV'
    set udg_Hotkey_Abilities[490]='A0DT'
    set udg_Hotkey_Abilities[491]='A0DW'
    set udg_Hotkey_Abilities[492]='A0DX'
    set udg_Hotkey_Abilities[493]='A0DR'
    set udg_Hotkey_Abilities[494]='A0DU'
    set udg_Hotkey_Abilities[495]='A0DS'
    set udg_Hotkey_Abilities[496]='A0E2'
    set udg_Hotkey_Abilities[497]='A0E0'
    set udg_Hotkey_Abilities[498]='A0E3'
    set udg_Hotkey_Abilities[499]='A0E4'
    set udg_Hotkey_Abilities[500]='A0DY'
    set udg_Hotkey_Abilities[501]='A0E1'
    set udg_Hotkey_Abilities[502]='A0DZ'
    set udg_Hotkey_Abilities[503]='A0EB'
    set udg_Hotkey_Abilities[504]='A0E9'
    set udg_Hotkey_Abilities[505]='A0EC'
    set udg_Hotkey_Abilities[506]='A0ED'
    set udg_Hotkey_Abilities[507]='A0E7'
    set udg_Hotkey_Abilities[508]='A0EA'
    set udg_Hotkey_Abilities[509]='A0E8'
    set udg_Hotkey_Abilities[510]='A0EI'
    set udg_Hotkey_Abilities[511]='A0EG'
    set udg_Hotkey_Abilities[512]='A0EJ'
    set udg_Hotkey_Abilities[513]='A0EK'
    set udg_Hotkey_Abilities[514]='A0EE'
    set udg_Hotkey_Abilities[515]='A0EH'
    set udg_Hotkey_Abilities[516]='A0EF'
    set udg_Hotkey_Abilities[517]='A0EP'
    set udg_Hotkey_Abilities[518]='A0EN'
    set udg_Hotkey_Abilities[519]='A0EQ'
    set udg_Hotkey_Abilities[520]='A0ER'
    set udg_Hotkey_Abilities[521]='A0EL'
    set udg_Hotkey_Abilities[522]='A0EO'
    set udg_Hotkey_Abilities[523]='A0EM'
    set udg_Hotkey_Abilities[524]='A0EV'
    set udg_Hotkey_Abilities[525]='A0EU'
    set udg_Hotkey_Abilities[526]='A0EX'
    set udg_Hotkey_Abilities[527]='A0EY'
    set udg_Hotkey_Abilities[528]='A0ES'
    set udg_Hotkey_Abilities[529]='A0EW'
    set udg_Hotkey_Abilities[530]='A0ET'
    set udg_Hotkey_Abilities[531]='A0KW'
    set udg_Hotkey_Abilities[532]='A0KU'
    set udg_Hotkey_Abilities[533]='A0KX'
    set udg_Hotkey_Abilities[534]='A0KY'
    set udg_Hotkey_Abilities[535]='A0KS'
    set udg_Hotkey_Abilities[536]='A0KV'
    set udg_Hotkey_Abilities[537]='A0KT'
    set udg_Hotkey_Abilities[538]='A0F3'
    set udg_Hotkey_Abilities[539]='A0F1'
    set udg_Hotkey_Abilities[540]='A0F4'
    set udg_Hotkey_Abilities[541]='A0F5'
    set udg_Hotkey_Abilities[542]='A0EZ'
    set udg_Hotkey_Abilities[543]='A0F2'
    set udg_Hotkey_Abilities[544]='A0F0'
    set udg_Hotkey_Abilities[545]='A0FA'
    set udg_Hotkey_Abilities[546]='A0F8'
    set udg_Hotkey_Abilities[547]='A0FB'
    set udg_Hotkey_Abilities[548]='A0FC'
    set udg_Hotkey_Abilities[549]='A0F6'
    set udg_Hotkey_Abilities[550]='A0F9'
    set udg_Hotkey_Abilities[551]='A0F7'
    set udg_Hotkey_Abilities[552]='A0FH'
    set udg_Hotkey_Abilities[553]='A0FI'
    set udg_Hotkey_Abilities[554]='A0FD'
    set udg_Hotkey_Abilities[555]='A0FE'
    set udg_Hotkey_Abilities[556]='A0FF'
    set udg_Hotkey_Abilities[557]='A0FJ'
    set udg_Hotkey_Abilities[558]='A0FG'
    set udg_Hotkey_Abilities[559]='A0L5'
    set udg_Hotkey_Abilities[560]='A0L3'
    set udg_Hotkey_Abilities[561]='A0L6'
    set udg_Hotkey_Abilities[562]='A0L7'
    set udg_Hotkey_Abilities[563]='A0L1'
    set udg_Hotkey_Abilities[564]='A0L4'
    set udg_Hotkey_Abilities[565]='A0L2'
    set udg_Hotkey_Abilities[566]='A0LD'
    set udg_Hotkey_Abilities[567]='A0LB'
    set udg_Hotkey_Abilities[568]='A0LE'
    set udg_Hotkey_Abilities[569]='A0LF'
    set udg_Hotkey_Abilities[570]='A0L9'
    set udg_Hotkey_Abilities[571]='A0LC'
    set udg_Hotkey_Abilities[572]='A0LA'
    set udg_Hotkey_Abilities[573]='A0KZ'
    set udg_Hotkey_Abilities[574]='A018'
    set udg_Hotkey_Abilities[575]='A019'
    set udg_Hotkey_Abilities[576]='A014'
    set udg_Hotkey_Abilities[577]='A015'
    set udg_Hotkey_Abilities[578]='A016'
    set udg_Hotkey_Abilities[579]='A01A'
    set udg_Hotkey_Abilities[580]='A017'
    set udg_Hotkey_Abilities[581]='A01F'
    set udg_Hotkey_Abilities[582]='A01D'
    set udg_Hotkey_Abilities[583]='A01G'
    set udg_Hotkey_Abilities[584]='A01H'
    set udg_Hotkey_Abilities[585]='A01B'
    set udg_Hotkey_Abilities[586]='A01E'
    set udg_Hotkey_Abilities[587]='A01C'
    set udg_Hotkey_Abilities[588]='A02E'
    set udg_Hotkey_Abilities[589]='A020'
    set udg_Hotkey_Abilities[590]='A02G'
    set udg_Hotkey_Abilities[591]='A02I'
    set udg_Hotkey_Abilities[592]='A01Y'
    set udg_Hotkey_Abilities[593]='A02C'
    set udg_Hotkey_Abilities[594]='A01Z'
    set udg_Hotkey_Abilities[595]='A036'
    set udg_Hotkey_Abilities[596]='A02U'
    set udg_Hotkey_Abilities[597]='A037'
    set udg_Hotkey_Abilities[598]='A038'
    set udg_Hotkey_Abilities[599]='A02J'
    set udg_Hotkey_Abilities[600]='A02V'
    set udg_Hotkey_Abilities[601]='A02K'
    set udg_Hotkey_Abilities[602]='A03T'
    set udg_Hotkey_Abilities[603]='A03E'
    set udg_Hotkey_Abilities[604]='A03V'
    set udg_Hotkey_Abilities[605]='A03W'
    set udg_Hotkey_Abilities[606]='A03B'
    set udg_Hotkey_Abilities[607]='A03F'
    set udg_Hotkey_Abilities[608]='A03C'
    set udg_Hotkey_Abilities[609]='A04P'
    set udg_Hotkey_Abilities[610]='A04I'
    set udg_Hotkey_Abilities[611]='A04Q'
    set udg_Hotkey_Abilities[612]='A04R'
    set udg_Hotkey_Abilities[613]='A04G'
    set udg_Hotkey_Abilities[614]='A04O'
    set udg_Hotkey_Abilities[615]='A04H'
    set udg_Hotkey_Abilities[616]='A04W'
    set udg_Hotkey_Abilities[617]='A04X'
    set udg_Hotkey_Abilities[618]='A04S'
    set udg_Hotkey_Abilities[619]='A04T'
    set udg_Hotkey_Abilities[620]='A04U'
    set udg_Hotkey_Abilities[621]='A056'
    set udg_Hotkey_Abilities[622]='A04V'
    set udg_Hotkey_Abilities[623]='A0HW'
    set udg_Hotkey_Abilities[624]='A0AT'
    set udg_Hotkey_Abilities[625]='A0HX'
    set udg_Hotkey_Abilities[626]='A0HY'
    set udg_Hotkey_Abilities[627]='A0AR'
    set udg_Hotkey_Abilities[628]='A0HV'
    set udg_Hotkey_Abilities[629]='A0AS'
    set udg_Hotkey_Abilities[630]='A0N9'
    set udg_Hotkey_Abilities[631]='A0N7'
    set udg_Hotkey_Abilities[632]='A0NA'
    set udg_Hotkey_Abilities[633]='A0NB'
    set udg_Hotkey_Abilities[634]='A0N6'
    set udg_Hotkey_Abilities[635]='A0N8'
    set udg_Hotkey_Abilities[636]='A0N5'
    set udg_Hotkey_Abilities[637]='A0NG'
    set udg_Hotkey_Abilities[638]='A0NE'
    set udg_Hotkey_Abilities[639]='A0NH'
    set udg_Hotkey_Abilities[640]='A0NI'
    set udg_Hotkey_Abilities[641]='A0ND'
    set udg_Hotkey_Abilities[642]='A0NF'
    set udg_Hotkey_Abilities[643]='A0NC'
    set udg_Hotkey_Abilities[644]='A0O0'
    set udg_Hotkey_Abilities[645]='A0NY'
    set udg_Hotkey_Abilities[646]='A0O1'
    set udg_Hotkey_Abilities[647]='A0O2'
    set udg_Hotkey_Abilities[648]='A0NW'
    set udg_Hotkey_Abilities[649]='A0NZ'
    set udg_Hotkey_Abilities[650]='A0NX'
    set udg_Hotkey_Abilities[651]='A0OS'
    set udg_Hotkey_Abilities[652]='A0OQ'
    set udg_Hotkey_Abilities[653]='A0OT'
    set udg_Hotkey_Abilities[654]='A0OU'
    set udg_Hotkey_Abilities[655]='A0OO'
    set udg_Hotkey_Abilities[656]='A0OR'
    set udg_Hotkey_Abilities[657]='A0OP'
    set udg_Hotkey_Abilities[658]='A0OZ'
    set udg_Hotkey_Abilities[659]='A0OX'
    set udg_Hotkey_Abilities[660]='A0P0'
    set udg_Hotkey_Abilities[661]='A0P1'
    set udg_Hotkey_Abilities[662]='A0OV'
    set udg_Hotkey_Abilities[663]='A0OY'
    set udg_Hotkey_Abilities[664]='A0OW'
endfunction

//===========================================================================
function InitTrig_Set_Hotkey_Abilities takes nothing returns nothing
    set gg_trg_Set_Hotkey_Abilities=CreateTrigger()
    call TriggerAddAction(gg_trg_Set_Hotkey_Abilities, function Trig_Set_Hotkey_Abilities_Actions)
endfunction

//===========================================================================
// Trigger: Set Hotkeys
//===========================================================================
function Trig_Set_Hotkeys_Actions takes nothing returns nothing
    set udg_Hotkeys[0]="Q"
    set udg_Hotkeys[1]="W"
    set udg_Hotkeys[2]="E"
    set udg_Hotkeys[3]="R"
    set udg_Hotkeys[4]="D"
    set udg_Hotkeys[5]="F"
    set udg_Hotkeys[6]="G"
    call InitHashtableBJ()
    set udg_Hotkey_Htable=GetLastCreatedHashtableBJ()
endfunction

//===========================================================================
function InitTrig_Set_Hotkeys takes nothing returns nothing
    set gg_trg_Set_Hotkeys=CreateTrigger()
    call TriggerAddAction(gg_trg_Set_Hotkeys, function Trig_Set_Hotkeys_Actions)
endfunction

//===========================================================================
// Trigger: Hero buys Ability
//===========================================================================
function Trig_Hero_buys_Ability_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) != 'I02U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func001001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " Q" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func002001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " Q" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func003001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " W" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func004001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " W" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func005001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " E" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func006001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " E" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func007001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " R" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func008001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " R" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func009001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " D" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func010001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " D" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func011001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " F" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func012001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " F" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func013001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " G" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001Func003Func014001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " G" ) )
endfunction

function Trig_Hero_buys_Ability_Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == udg_Abilities_Items[GetForLoopIndexA()] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func002Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexA(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable) == ( GetItemName(GetManipulatedItem()) + ( " " + udg_Hotkeys[GetForLoopIndexA()] ) ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func003C takes nothing returns boolean
    if ( not ( udg_temp_bol == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func005Func003C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I02V' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I03A' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I01K' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I00E' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I02L' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func005C takes nothing returns boolean
    if ( not Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func005Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003C takes nothing returns boolean
    if ( not ( udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable) == "" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func003Func001Func003C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I02V' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I03A' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I01K' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I00E' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I02L' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func003Func001C takes nothing returns boolean
    if ( not Trig_Hero_buys_Ability_Func003Func002Func001Func003Func001Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001Func003C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit()) < 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003Func002Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable) == GetAbilityName(udg_temp_Abilities[GetForLoopIndexB()]) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Func003C takes nothing returns boolean
    if ( not ( udg_temp_item == GetManipulatedItem() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Ability_Actions takes nothing returns nothing
    set bj_forLoopAIndex=0
    set bj_forLoopAIndexEnd=udg_NumberOfAbilities
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Hero_buys_Ability_Func002Func001C() ) then
            set udg_temp_num=GetForLoopIndexA()
            set udg_temp_item=GetManipulatedItem()
            set bj_forLoopBIndex=0
            set bj_forLoopBIndexEnd=700
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " Q" )) ) then // INLINED!!
                    set udg_temp_Abilities[0]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " Q" )) ) then // INLINED!!
                    set udg_temp_integr[0]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " W" )) ) then // INLINED!!
                    set udg_temp_Abilities[1]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " W" )) ) then // INLINED!!
                    set udg_temp_integr[1]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " E" )) ) then // INLINED!!
                    set udg_temp_Abilities[2]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " E" )) ) then // INLINED!!
                    set udg_temp_integr[2]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " R" )) ) then // INLINED!!
                    set udg_temp_Abilities[3]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " R" )) ) then // INLINED!!
                    set udg_temp_integr[3]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " D" )) ) then // INLINED!!
                    set udg_temp_Abilities[4]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " D" )) ) then // INLINED!!
                    set udg_temp_integr[4]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " F" )) ) then // INLINED!!
                    set udg_temp_Abilities[5]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " F" )) ) then // INLINED!!
                    set udg_temp_integr[5]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " G" )) ) then // INLINED!!
                    set udg_temp_Abilities[6]=udg_Hotkey_Abilities[GetForLoopIndexB()]
                else
                    call DoNothing()
                endif
                if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_temp_num] + " G" )) ) then // INLINED!!
                    set udg_temp_integr[6]=GetForLoopIndexB()
                else
                    call DoNothing()
                endif
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if ( Trig_Hero_buys_Ability_Func003C() ) then
        set bj_forLoopBIndex=0
        set bj_forLoopBIndexEnd=7
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            if ( Trig_Hero_buys_Ability_Func003Func002Func001C() ) then
                // Upgrade Ability----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                if ( Trig_Hero_buys_Ability_Func003Func002Func001Func003C() ) then
                    call SetUnitAbilityLevelSwapped(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit(), ( GetUnitAbilityLevelSwapped(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit()) + 1 ))
                    set udg_retraining_levelof_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=GetUnitAbilityLevelSwapped(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit())
                    set udg_retraining_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=udg_temp_Abilities[GetForLoopIndexB()]
                    set udg_retraining_item_type[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetItemTypeId(GetManipulatedItem())
                else
                    if ( Trig_Hero_buys_Ability_Func003Func002Func001Func003Func001C() ) then
                        call AdjustPlayerStateBJ(20, GetOwningPlayer(GetManipulatingUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                    else
                        call AdjustPlayerStateBJ(10, GetOwningPlayer(GetManipulatingUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                    endif
                    call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetManipulatingUnit())), "TRIGSTR_127")
                    set udg_retraining_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=udg_temp_Abilities[GetForLoopIndexB()]
                    set udg_retraining_levelof_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=10
                    set udg_retraining_item_type[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetItemTypeId(GetManipulatedItem())
                endif
                return
            else
                if ( Trig_Hero_buys_Ability_Func003Func002Func001Func001C() ) then
                    // New Ability--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    if ( Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003C() ) then
                        call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetManipulatingUnit())), "TRIGSTR_124")
                        if ( Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func005C() ) then
                            call AdjustPlayerStateBJ(20, GetOwningPlayer(GetManipulatingUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                        else
                            call AdjustPlayerStateBJ(10, GetOwningPlayer(GetManipulatingUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                        endif
                        return
                    else
                        set udg_temp_bol=false
                        set bj_forLoopAIndex=0
                        set bj_forLoopAIndexEnd=6
                        loop
                            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                            if ( Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func002Func001C() ) then
                                set udg_temp_bol=true
                            else
                            endif
                            set bj_forLoopAIndex=bj_forLoopAIndex + 1
                        endloop
                        if ( Trig_Hero_buys_Ability_Func003Func002Func001Func001Func003Func003C() ) then
                            call UnitAddAbilityBJ(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit())
                            call SaveStringBJ(GetAbilityName(udg_temp_Abilities[GetForLoopIndexB()]), GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable)
                            set udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=( udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] + 1 )
                            set udg_retraining_levelof_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=1
                            set udg_retraining_Ability[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=udg_temp_Abilities[GetForLoopIndexB()]
                            set udg_retraining_item_type[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetItemTypeId(GetManipulatedItem())
                            call SaveIntegerBJ(udg_temp_integr[GetForLoopIndexB()], GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_maxabilities)
                            call AddAbility(GetTriggerPlayer() , bj_forLoopBIndex + 1 , udg_temp_Abilities[bj_forLoopBIndex])
                            return
                        else
                        endif
                    endif
                else
                endif
            endif
            set bj_forLoopBIndex=bj_forLoopBIndex + 1
        endloop
    else
    endif
endfunction

//===========================================================================
function InitTrig_Hero_buys_Ability takes nothing returns nothing
    set gg_trg_Hero_buys_Ability=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hero_buys_Ability, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Hero_buys_Ability, Condition(function Trig_Hero_buys_Ability_Conditions))
    call TriggerAddAction(gg_trg_Hero_buys_Ability, function Trig_Hero_buys_Ability_Actions)
endfunction

//===========================================================================
// Trigger: Hero buys Random Ability
//===========================================================================
function Trig_Hero_buys_Random_Ability_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I02U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func001001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func002001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func003001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func004001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func005001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func006001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func007001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func008001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func009001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func010001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func011001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func012001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func013001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func002Func014001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" ) )
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001Func001Func004Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexA(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable) == ( udg_Abilities[udg_chance] + ( " " + udg_Hotkeys[GetForLoopIndexA()] ) ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001Func001Func005C takes nothing returns boolean
    if ( not ( udg_temp_bol == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable) == "" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001Func004Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_maxabilities)], GetManipulatingUnit()) <= 9 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001Func005C takes nothing returns boolean
    if ( not ( udg_temp_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Func003Func001C takes nothing returns boolean
    if ( not ( udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hero_buys_Random_Ability_Actions takes nothing returns nothing
    set udg_chance=GetRandomInt(0, udg_NumberOfAbilities)
    set bj_forLoopBIndex=0
    set bj_forLoopBIndexEnd=700
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" )) ) then // INLINED!!
            set udg_temp_Abilities[0]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" )) ) then // INLINED!!
            set udg_temp_integr[0]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" )) ) then // INLINED!!
            set udg_temp_Abilities[1]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" )) ) then // INLINED!!
            set udg_temp_integr[1]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" )) ) then // INLINED!!
            set udg_temp_Abilities[2]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" )) ) then // INLINED!!
            set udg_temp_integr[2]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" )) ) then // INLINED!!
            set udg_temp_Abilities[3]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" )) ) then // INLINED!!
            set udg_temp_integr[3]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" )) ) then // INLINED!!
            set udg_temp_Abilities[4]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" )) ) then // INLINED!!
            set udg_temp_integr[4]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" )) ) then // INLINED!!
            set udg_temp_Abilities[5]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" )) ) then // INLINED!!
            set udg_temp_integr[5]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" )) ) then // INLINED!!
            set udg_temp_Abilities[6]=udg_Hotkey_Abilities[GetForLoopIndexB()]
        else
            call DoNothing()
        endif
        if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" )) ) then // INLINED!!
            set udg_temp_integr[6]=GetForLoopIndexB()
        else
            call DoNothing()
        endif
        set bj_forLoopBIndex=bj_forLoopBIndex + 1
    endloop
    set bj_forLoopBIndex=0
    set bj_forLoopBIndexEnd=7
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        if ( Trig_Hero_buys_Random_Ability_Func003Func001C() ) then
            // Upgrade Ability----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            set udg_temp_num=0
            set bj_forLoopAIndex=0
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Hero_buys_Random_Ability_Func003Func001Func004Func001C() ) then
                    set udg_temp_num=( udg_temp_num + 1 )
                    set udg_temp_Abilities_1[udg_temp_num]=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_maxabilities)]
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
            if ( Trig_Hero_buys_Random_Ability_Func003Func001Func005C() ) then
                call AdjustPlayerStateBJ(5, GetOwningPlayer(GetManipulatingUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetManipulatingUnit())), "TRIGSTR_118")
            else
            endif
            set udg_chance=GetRandomInt(1, udg_temp_num)
            call SetUnitAbilityLevelSwapped(udg_temp_Abilities_1[udg_chance], GetManipulatingUnit(), ( GetUnitAbilityLevelSwapped(udg_temp_Abilities_1[udg_chance], GetManipulatingUnit()) + 1 ))
            return
        else
            if ( Trig_Hero_buys_Random_Ability_Func003Func001Func001C() ) then
                // New Ability--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                set udg_temp_bol=false
                set bj_forLoopAIndex=0
                set bj_forLoopAIndexEnd=6
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    if ( Trig_Hero_buys_Random_Ability_Func003Func001Func001Func004Func001C() ) then
                        set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_maxabilities)]
                        call SetUnitAbilityLevelSwapped(udg_temp_Ability, GetManipulatingUnit(), ( GetUnitAbilityLevelSwapped(udg_temp_Ability, GetManipulatingUnit()) + 1 ))
                        set udg_temp_bol=true
                        return
                    else
                    endif
                    set bj_forLoopAIndex=bj_forLoopAIndex + 1
                endloop
                if ( Trig_Hero_buys_Random_Ability_Func003Func001Func001Func005C() ) then
                    call UnitAddAbilityBJ(udg_temp_Abilities[GetForLoopIndexB()], GetManipulatingUnit())
                    call SaveStringBJ(GetAbilityName(udg_temp_Abilities[GetForLoopIndexB()]), GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_Hotkey_Htable)
                    call SaveIntegerBJ(udg_temp_integr[GetForLoopIndexB()], GetForLoopIndexB(), GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit())), udg_maxabilities)
                    set udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]=( udg_maxabilities_counter[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] + 1 )
                    call AddAbility(GetTriggerPlayer() , bj_forLoopBIndex + 1 , udg_temp_Abilities[bj_forLoopBIndex])
                    return
                else
                endif
            else
            endif
        endif
        set bj_forLoopBIndex=bj_forLoopBIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Hero_buys_Random_Ability takes nothing returns nothing
    set gg_trg_Hero_buys_Random_Ability=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hero_buys_Random_Ability, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Hero_buys_Random_Ability, Condition(function Trig_Hero_buys_Random_Ability_Conditions))
    call TriggerAddAction(gg_trg_Hero_buys_Random_Ability, function Trig_Hero_buys_Random_Ability_Actions)
endfunction

//===========================================================================
// Trigger: Set Abilities and Items
//===========================================================================
function Trig_Set_Abilities_and_Items_Actions takes nothing returns nothing
    // Abilities
    set udg_Abilities[0]="Storm Bolt"
    set udg_Abilities[1]="Anti-magic Shell"
    set udg_Abilities[2]="Bash"
    set udg_Abilities[3]="Battle Roar"
    set udg_Abilities[4]="Blizzard"
    set udg_Abilities[5]="Bloodlust"
    set udg_Abilities[6]="Brilliance Aura"
    set udg_Abilities[7]="Cannibalize"
    set udg_Abilities[8]="Command Aura"
    set udg_Abilities[9]="Cripple"
    set udg_Abilities[10]="Critical Strike"
    set udg_Abilities[11]="Curse"
    set udg_Abilities[12]="Cyclone"
    set udg_Abilities[13]="Death Coil"
    set udg_Abilities[14]="Dispel Magic"
    set udg_Abilities[15]="Elune's Grace"
    set udg_Abilities[16]="Endurance Aura"
    set udg_Abilities[17]="Entangling Roots"
    set udg_Abilities[18]="Envenomed Spears"
    set udg_Abilities[19]="Evasion"
    set udg_Abilities[20]="Faerie Fire"
    set udg_Abilities[21]="Fan of Knives"
    set udg_Abilities[22]="Feedback"
    set udg_Abilities[23]="Flame Strike"
    set udg_Abilities[24]="Frost Armor"
    set udg_Abilities[25]="Frost Nova"
    set udg_Abilities[26]="Hardened Skin"
    set udg_Abilities[27]="Healing Ward"
    set udg_Abilities[28]="Healing Wave"
    set udg_Abilities[29]="Hex"
    set udg_Abilities[30]="Holy Light"
    set udg_Abilities[31]="Immolation"
    set udg_Abilities[32]="Summon Water Elemental"
    set udg_Abilities[33]="Inner Fire"
    set udg_Abilities[34]="Life Drain"
    set udg_Abilities[35]="Lightning Shield"
    set udg_Abilities[36]="Mana Burn"
    set udg_Abilities[37]="Mirror Image"
    set udg_Abilities[38]="Permanent Immolation"
    set udg_Abilities[39]="Raise Dead"
    set udg_Abilities[40]="Serpent Ward"
    set udg_Abilities[41]="Shadow Strike"
    set udg_Abilities[42]="Slow"
    set udg_Abilities[43]="Soul Burn"
    set udg_Abilities[44]="Spiked Carapace"
    set udg_Abilities[45]="Summon Bear"
    set udg_Abilities[46]="Summon Lava Spawn"
    set udg_Abilities[47]="Summon Quilbeast"
    set udg_Abilities[48]="Thorns Aura"
    set udg_Abilities[49]="Thunder Clap"
    set udg_Abilities[50]="Unholy Aura"
    set udg_Abilities[51]="Unholy Frenzy"
    set udg_Abilities[52]="Vampiric Aura"
    set udg_Abilities[53]="War Stomp"
    set udg_Abilities[54]="Force of Nature"
    set udg_Abilities[55]="Chain Lightning"
    set udg_Abilities[56]="Inferno"
    set udg_Abilities[57]="Trueshot Aura"
    set udg_Abilities[58]="Devotion Aura"
    set udg_Abilities[59]="Aerial Shackles"
    set udg_Abilities[60]="Heal"
    set udg_Abilities[61]="Forked Lightning"
    set udg_Abilities[62]="Siphon Mana"
    set udg_Abilities[63]="Parasite"
    set udg_Abilities[64]="Polymorph"
    set udg_Abilities[65]="Rejuvenation"
    set udg_Abilities[66]="Pocket Factory"
    set udg_Abilities[67]="Spirit Link"
    set udg_Abilities[68]="Banish"
    set udg_Abilities[69]="Rain of Fire"
    set udg_Abilities[70]="Volcano"
    set udg_Abilities[71]="Stampede"
    set udg_Abilities[72]="Carrion Swarm"
    set udg_Abilities[73]="Shockwave"
    set udg_Abilities[74]="Drunken Brawler"
    set udg_Abilities[75]="Finger of Death"
    set udg_Abilities[76]="Carrion Beetles"
    set udg_Abilities[77]="Death And Decay"
    set udg_Abilities[78]="Pulverize"
    set udg_Abilities[79]="Acid Bomb"
    set udg_Abilities[80]="Animate Dead"
    set udg_Abilities[81]="Purge"
    set udg_Abilities[82]="Mana Shield"
    set udg_Abilities[83]="Wind Walk"
    set udg_Abilities[84]="Cleaving Attack"
    set udg_Abilities[85]="Blink"
    set udg_Abilities[86]="Sleep"
    set udg_Abilities[87]="Dark Ritual"
    set udg_Abilities[88]="Monsoon"
    set udg_Abilities[89]="Ensnare"
    set udg_Abilities[90]="Telekinesis"
    set udg_Abilities[91]="Force Pull"
    set udg_Abilities[92]="Smoke Bomb"
    set udg_Abilities[93]="Impale"
    set udg_Abilities[94]="Frost Strike"
    // Items
    set udg_Abilities_Items[1]='I01I'
    set udg_Abilities_Items[2]='I00F'
    set udg_Abilities_Items[3]='I01R'
    set udg_Abilities_Items[4]='I00R'
    set udg_Abilities_Items[5]='I02G'
    set udg_Abilities_Items[6]='I010'
    set udg_Abilities_Items[7]='I01N'
    set udg_Abilities_Items[8]='I011'
    set udg_Abilities_Items[10]='I00N'
    set udg_Abilities_Items[14]='I01C'
    set udg_Abilities_Items[16]='I00Z'
    set udg_Abilities_Items[17]='I01F'
    set udg_Abilities_Items[18]='I01G'
    set udg_Abilities_Items[19]='I00V'
    set udg_Abilities_Items[21]='I029'
    set udg_Abilities_Items[22]='I01H'
    set udg_Abilities_Items[23]='I00Q'
    set udg_Abilities_Items[24]='I027'
    set udg_Abilities_Items[25]='I00I'
    set udg_Abilities_Items[27]='I01W'
    set udg_Abilities_Items[28]='I014'
    set udg_Abilities_Items[29]='I01D'
    set udg_Abilities_Items[30]='I016'
    set udg_Abilities_Items[31]='I012'
    set udg_Abilities_Items[32]='I01V'
    set udg_Abilities_Items[33]='I01Z'
    set udg_Abilities_Items[34]='I015'
    set udg_Abilities_Items[35]='I021'
    set udg_Abilities_Items[37]='I01A'
    set udg_Abilities_Items[38]='I020'
    set udg_Abilities_Items[39]='I01M'
    set udg_Abilities_Items[40]='I00K'
    set udg_Abilities_Items[41]='I00G'
    set udg_Abilities_Items[43]='I01Y'
    set udg_Abilities_Items[44]='I00U'
    set udg_Abilities_Items[45]='I00J'
    set udg_Abilities_Items[46]='I01J'
    set udg_Abilities_Items[47]='I01B'
    set udg_Abilities_Items[48]='I01Q'
    set udg_Abilities_Items[49]='I013'
    set udg_Abilities_Items[50]='I00Y'
    set udg_Abilities_Items[51]='I00T'
    set udg_Abilities_Items[52]='I01U'
    set udg_Abilities_Items[53]='I00P'
    set udg_Abilities_Items[54]='I02S'
    set udg_Abilities_Items[55]='I02T'
    set udg_Abilities_Items[56]='I02V'
    set udg_Abilities_Items[57]='I02W'
    set udg_Abilities_Items[58]='I02X'
    set udg_Abilities_Items[60]='I035'
    set udg_Abilities_Items[61]='I033'
    set udg_Abilities_Items[65]='I034'
    set udg_Abilities_Items[66]='I037'
    set udg_Abilities_Items[69]='I03C'
    set udg_Abilities_Items[70]='I00E'
    set udg_Abilities_Items[71]='I03A'
    set udg_Abilities_Items[72]='I03E'
    set udg_Abilities_Items[73]='I039'
    set udg_Abilities_Items[74]='I018'
    set udg_Abilities_Items[75]='I03B'
    set udg_Abilities_Items[76]='I03H'
    set udg_Abilities_Items[78]='I00M'
    set udg_Abilities_Items[79]='I03D'
    set udg_Abilities_Items[80]='I03L'
    set udg_Abilities_Items[82]='I002'
    set udg_Abilities_Items[83]='I02E'
    set udg_Abilities_Items[84]='I024'
    set udg_Abilities_Items[85]='I02I'
    set udg_Abilities_Items[92]='I03Y'
    set udg_Abilities_Items[93]='I043'
    set udg_Abilities_Items[94]='I044'
endfunction

//===========================================================================
function InitTrig_Set_Abilities_and_Items takes nothing returns nothing
    set gg_trg_Set_Abilities_and_Items=CreateTrigger()
    call TriggerAddAction(gg_trg_Set_Abilities_and_Items, function Trig_Set_Abilities_and_Items_Actions)
endfunction

//===========================================================================
// Trigger: Tome of Retraining
//===========================================================================
function Trig_Tome_of_Retraining_Actions takes nothing returns nothing
    set udg_temp_Unit=udg_NICKHeroArray[udg_X]
    set udg_temp_int=udg_RetrainNr[udg_X]
    set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(udg_RetrainNr[udg_X], udg_X, udg_maxabilities)]
    call UnitRemoveAbilityBJ(udg_temp_Ability, udg_NICKHeroArray[udg_X])
    set udg_maxabilities_counter[udg_X]=( udg_maxabilities_counter[udg_X] - 1 )
    call Unlearn(GetTriggerPlayer() , udg_temp_int)
    call SaveStringBJ("", udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_Hotkey_Htable)
    call SaveStringBJ("", udg_temp_int, GetConvertedPlayerId(GetTriggerPlayer()), udg_maxabilities)
endfunction

//===========================================================================
function InitTrig_Tome_of_Retraining takes nothing returns nothing
    set gg_trg_Tome_of_Retraining=CreateTrigger()
    call TriggerAddAction(gg_trg_Tome_of_Retraining, function Trig_Tome_of_Retraining_Actions)
endfunction

//===========================================================================
// Trigger: Remove Tomes
//===========================================================================
function Trig_Remove_Tomes_Conditions takes nothing returns boolean
    if ( not ( GetItemType(GetManipulatedItem()) == ITEM_TYPE_POWERUP ) ) then
        return false
    endif
    return true
endfunction

function Trig_Remove_Tomes_Actions takes nothing returns nothing
    call RemoveItem(GetManipulatedItem())
endfunction

//===========================================================================
function InitTrig_Remove_Tomes takes nothing returns nothing
    set gg_trg_Remove_Tomes=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Remove_Tomes, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Remove_Tomes, Condition(function Trig_Remove_Tomes_Conditions))
    call TriggerAddAction(gg_trg_Remove_Tomes, function Trig_Remove_Tomes_Actions)
endfunction

//===========================================================================
// Trigger: Preload Abilities
//===========================================================================
function Trig_Preload_Abilities_Func001Func002Func001001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func002001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func003001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func004001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func005001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func006001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func007001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func008001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func009001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func010001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func011001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func012001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func013001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" ) )
endfunction

function Trig_Preload_Abilities_Func001Func002Func014001 takes nothing returns boolean
    return ( GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" ) )
endfunction

function Trig_Preload_Abilities_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=udg_NumberOfAbilities
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_chance=GetForLoopIndexA()
        set bj_forLoopBIndex=0
        set bj_forLoopBIndexEnd=700
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" )) ) then // INLINED!!
                set udg_temp_Abilities[0]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " Q" )) ) then // INLINED!!
                set udg_temp_integr[0]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" )) ) then // INLINED!!
                set udg_temp_Abilities[1]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " W" )) ) then // INLINED!!
                set udg_temp_integr[1]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" )) ) then // INLINED!!
                set udg_temp_Abilities[2]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " E" )) ) then // INLINED!!
                set udg_temp_integr[2]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" )) ) then // INLINED!!
                set udg_temp_Abilities[3]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " R" )) ) then // INLINED!!
                set udg_temp_integr[3]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" )) ) then // INLINED!!
                set udg_temp_Abilities[4]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " D" )) ) then // INLINED!!
                set udg_temp_integr[4]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" )) ) then // INLINED!!
                set udg_temp_Abilities[5]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " F" )) ) then // INLINED!!
                set udg_temp_integr[5]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" )) ) then // INLINED!!
                set udg_temp_Abilities[6]=udg_Hotkey_Abilities[GetForLoopIndexB()]
            else
                call DoNothing()
            endif
            if ( (GetAbilityName(udg_Hotkey_Abilities[GetForLoopIndexB()]) == ( udg_Abilities[udg_chance] + " G" )) ) then // INLINED!!
                set udg_temp_integr[6]=GetForLoopIndexB()
            else
                call DoNothing()
            endif
            set bj_forLoopBIndex=bj_forLoopBIndex + 1
        endloop
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Preload_Abilities takes nothing returns nothing
    set gg_trg_Preload_Abilities=CreateTrigger()
    call TriggerAddAction(gg_trg_Preload_Abilities, function Trig_Preload_Abilities_Actions)
endfunction

//===========================================================================
// Trigger: Channeling Spells Cast
//===========================================================================
function Trig_Channeling_Spells_Cast_Func008C takes nothing returns boolean
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Rain of Fire" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Blizzard" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Stampede" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Volcano" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Death And Decay" ) ) then
        return true
    endif
    if ( ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Smoke Bomb" ) ) then
        return true
    endif
    return false
endfunction

function Trig_Channeling_Spells_Cast_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) != Player(20) ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetSpellAbilityUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not Trig_Channeling_Spells_Cast_Func008C() ) then
        return false
    endif
    return true
endfunction

function Trig_Channeling_Spells_Cast_Func003Func001C takes nothing returns boolean
    if ( not ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Volcano" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Channeling_Spells_Cast_Func003C takes nothing returns boolean
    if ( not ( SubStringBJ(GetAbilityName(GetSpellAbilityId()), 1, ( StringLength(GetAbilityName(GetSpellAbilityId())) - 2 )) == "Death And Decay" ) ) then
        return false
    endif
    return true
endfunction

function Trig_Channeling_Spells_Cast_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h00Q', GetTriggerPlayer(), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    set udg_temp_Unit=GetLastCreatedUnit()
    if ( Trig_Channeling_Spells_Cast_Func003C() ) then
        call SetUnitAbilityLevelSwapped('A0E6', udg_temp_Unit, GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()))
        call IssuePointOrderLocBJ(udg_temp_Unit, "deathanddecay", GetSpellTargetLoc())
    else
        if ( Trig_Channeling_Spells_Cast_Func003Func001C() ) then
            call RemoveUnit(udg_VolcanoDummy[GetConvertedPlayerId(GetTriggerPlayer())])
            set udg_VolcanoDummy[GetConvertedPlayerId(GetTriggerPlayer())]=udg_temp_Unit
            call SetUnitAbilityLevelSwapped('A0E5', udg_temp_Unit, GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()))
            call IssuePointOrderLocBJ(udg_temp_Unit, "volcano", GetSpellTargetLoc())
        else
            call UnitAddAbilityBJ(GetSpellAbilityId(), udg_temp_Unit)
            call SetUnitAbilityLevelSwapped(GetSpellAbilityId(), udg_temp_Unit, GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()))
            call IssuePointOrderLocBJ(udg_temp_Unit, "rainoffire", GetSpellTargetLoc())
            call IssuePointOrderLocBJ(udg_temp_Unit, "stampede", GetSpellTargetLoc())
            call IssuePointOrderLocBJ(udg_temp_Unit, "stampede", GetUnitLoc(GetSpellTargetUnit()))
            call IssuePointOrderLocBJ(udg_temp_Unit, "blizzard", GetSpellTargetLoc())
            call IssuePointOrderLocBJ(udg_temp_Unit, "cloudoffog", GetSpellTargetLoc())
        endif
    endif
    call TriggerSleepAction(0.10)
    call IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
endfunction

//===========================================================================
function InitTrig_Channeling_Spells_Cast takes nothing returns nothing
    set gg_trg_Channeling_Spells_Cast=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Channeling_Spells_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Channeling_Spells_Cast, Condition(function Trig_Channeling_Spells_Cast_Conditions))
    call TriggerAddAction(gg_trg_Channeling_Spells_Cast, function Trig_Channeling_Spells_Cast_Actions)
endfunction

//===========================================================================
// Trigger: Channeling Spells finish
//===========================================================================
function Trig_Channeling_Spells_finish_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'h00Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Channeling_Spells_finish_Actions takes nothing returns nothing
    call RemoveUnit(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Channeling_Spells_finish takes nothing returns nothing
    set gg_trg_Channeling_Spells_finish=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Channeling_Spells_finish, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Channeling_Spells_finish, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_Channeling_Spells_finish, Condition(function Trig_Channeling_Spells_finish_Conditions))
    call TriggerAddAction(gg_trg_Channeling_Spells_finish, function Trig_Channeling_Spells_finish_Actions)
endfunction

//===========================================================================
// Trigger: Move Projectiles
//===========================================================================
function Trig_Move_Projectiles_Func001Func001C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(GetEnumUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Move_Projectiles_Func001A takes nothing returns nothing
    if ( Trig_Move_Projectiles_Func001Func001C() ) then
        set udg_temp_Point=GetUnitLoc(GetEnumUnit())
        call SetUnitPositionLoc(GetEnumUnit(), PolarProjectionBJ(udg_temp_Point, GetUnitDefaultMoveSpeed(GetEnumUnit()), GetUnitFacing(GetEnumUnit())))
        call RemoveLocation(udg_temp_Point)
    else
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_move_projectiles_group)
    endif
endfunction

function Trig_Move_Projectiles_Actions takes nothing returns nothing
    call ForGroupBJ(udg_move_projectiles_group, function Trig_Move_Projectiles_Func001A)
endfunction

//===========================================================================
function InitTrig_Move_Projectiles takes nothing returns nothing
    set gg_trg_Move_Projectiles=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Move_Projectiles, 0.03)
    call TriggerAddAction(gg_trg_Move_Projectiles, function Trig_Move_Projectiles_Actions)
endfunction

//===========================================================================
// Trigger: Return Damage Pillar
//===========================================================================
function Trig_Return_Damage_Pillar_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventTarget == gg_unit_n02S_0002 ) ) then
        return false
    endif
    if ( not ( udg_reward_returndmg_pillar > 0 ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(udg_DamageEventSource) != GetOwningPlayer(udg_DamageEventTarget) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Return_Damage_Pillar_Actions takes nothing returns nothing
    call UnitDamageTargetBJ(udg_DamageEventTarget, udg_DamageEventSource, ( udg_DamageEventAmount * ( I2R(udg_reward_returndmg_pillar) * 0.50 ) ), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
endfunction

//===========================================================================
function InitTrig_Return_Damage_Pillar takes nothing returns nothing
    set gg_trg_Return_Damage_Pillar=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Return_Damage_Pillar, "udg_AfterDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Return_Damage_Pillar, Condition(function Trig_Return_Damage_Pillar_Conditions))
    call TriggerAddAction(gg_trg_Return_Damage_Pillar, function Trig_Return_Damage_Pillar_Actions)
endfunction

//===========================================================================
// Trigger: frost strike init
//===========================================================================
function Trig_frost_strike_init_Actions takes nothing returns nothing
    set udg_froststrike_dmg[1]=90.00
    set udg_froststrike_dmg[2]=180.00
    set udg_froststrike_dmg[3]=270.00
    set udg_froststrike_dmg[4]=360.00
    set udg_froststrike_dmg[5]=450.00
    set udg_froststrike_dmg[6]=540.00
    set udg_froststrike_dmg[7]=630.00
    set udg_froststrike_dmg[8]=720.00
    set udg_froststrike_dmg[9]=810.00
    set udg_froststrike_dmg[10]=900.00
endfunction

//===========================================================================
function InitTrig_frost_strike_init takes nothing returns nothing
    set gg_trg_frost_strike_init=CreateTrigger()
    call TriggerAddAction(gg_trg_frost_strike_init, function Trig_frost_strike_init_Actions)
endfunction

//===========================================================================
// Trigger: frost strike
//===========================================================================
function Trig_frost_strike_Func004C takes nothing returns boolean
    if ( ( GetSpellAbilityId() == 'A0OZ' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0OX' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0P0' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0P1' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0OV' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0OY' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A0OW' ) ) then
        return true
    endif
    return false
endfunction

function Trig_frost_strike_Conditions takes nothing returns boolean
    if ( not Trig_frost_strike_Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_frost_strike_Func001002003001 takes nothing returns boolean
    return ( IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == true )
endfunction

function Trig_frost_strike_Func001002003002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_frost_strike_Func001002003 takes nothing returns boolean
    return GetBooleanAnd((IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_frost_strike_Func002A takes nothing returns nothing
    set udg_temp_Point=GetUnitLoc(GetEnumUnit())
    call CreateNUnitsAtLoc(1, 'h01S', GetOwningPlayer(GetSpellAbilityUnit()), udg_temp_Point, bj_UNIT_FACING)
    call RemoveLocation(udg_temp_Point)
    call UnitAddAbilityBJ('A0P2', GetLastCreatedUnit())
    call SetUnitAbilityLevelSwapped('A0P2', GetLastCreatedUnit(), GetUnitAbilityLevelSwapped(GetSpellAbilityId(), GetSpellAbilityUnit()))
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", GetEnumUnit())
    call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
endfunction

function Trig_frost_strike_Actions takes nothing returns nothing
    set udg_temp_unit_group=GetUnitsInRangeOfLocMatching(225.00, GetUnitLoc(GetSpellTargetUnit()), Condition(function Trig_frost_strike_Func001002003))
    call ForGroupBJ(udg_temp_unit_group, function Trig_frost_strike_Func002A)
    call DestroyGroup(udg_temp_unit_group)
endfunction

//===========================================================================
function InitTrig_frost_strike takes nothing returns nothing
    set gg_trg_frost_strike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_frost_strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_frost_strike, Condition(function Trig_frost_strike_Conditions))
    call TriggerAddAction(gg_trg_frost_strike, function Trig_frost_strike_Actions)
endfunction

//===========================================================================
// Trigger: frost strike dmg
//===========================================================================
function Trig_frost_strike_dmg_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h01S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_frost_strike_dmg_Actions takes nothing returns nothing
    set udg_DamageEventAmount=0.10
    call UnitDamageTargetBJ(udg_NICKHeroArray[GetConvertedPlayerId(GetOwningPlayer(udg_DamageEventSource))], udg_DamageEventTarget, udg_froststrike_dmg[GetUnitAbilityLevelSwapped('A0P2', udg_DamageEventSource)], ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
endfunction

//===========================================================================
function InitTrig_frost_strike_dmg takes nothing returns nothing
    set gg_trg_frost_strike_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_frost_strike_dmg, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_frost_strike_dmg, Condition(function Trig_frost_strike_dmg_Conditions))
    call TriggerAddAction(gg_trg_frost_strike_dmg, function Trig_frost_strike_dmg_Actions)
endfunction

//===========================================================================
// Trigger: DraftStart
//
// DR mode gets picked
// Draft items in waves/waves
//===========================================================================
function Trig_DraftStart_Actions takes nothing returns nothing
    set udg_Draft_item_options1[1]='ckng'
    set udg_Draft_item_options1[2]='gcel'
    set udg_Draft_item_options1[3]='shrs'
    set udg_Draft_item_options1[4]='rat6'
    set udg_Draft_item_options1[5]='rde2'
    set udg_Draft_item_options1[6]='pres'
    set udg_Draft_item_options1[7]='ches'
    set udg_Draft_item_options1[8]='sorf'
    set udg_Draft_item_options1[9]='drph'
    set udg_Draft_item_options1[10]='hcun'
    set udg_Draft_item_options1[11]='hval'
    set udg_Draft_item_options1[12]='rwiz'
    set udg_Draft_item_options1[13]='gcel'
    set udg_Draft_item_options1[14]='rlif'
    set udg_Draft_item_options1[15]='tmmt'
    set udg_Draft_item_options1[16]='rat6'
    set udg_Draft_item_options1[17]='rag1'
    set udg_Draft_item_options1[18]='ches'
    set udg_Draft_item_options1[19]='fgdg'
    set udg_Draft_item_options1[20]='vamp'
    set udg_Draft_item_options1[21]='whwd'
    set udg_Draft_item_options1[22]='sxpl'
    set udg_Draft_item_options1[23]='infs'
    set udg_Draft_item_options1[24]='lmbr'
    set udg_Draft_item_options1[25]='I04O'
    set udg_Draft_item_options1[26]='I04O'
    set udg_Draft_item_options1[27]='I00L'
    set udg_Draft_max1=27
    set udg_Draft_item_options2[1]='klmm'
    set udg_Draft_item_options2[2]='I01T'
    set udg_Draft_item_options2[3]='I00A'
    set udg_Draft_item_options2[4]='sbch'
    set udg_Draft_item_options2[5]='frhg'
    set udg_Draft_item_options2[6]='I028'
    set udg_Draft_item_options2[7]='I02D'
    set udg_Draft_item_options2[8]='I01P'
    set udg_Draft_item_options2[9]='rugt'
    set udg_Draft_item_options2[10]='I01O'
    set udg_Draft_item_options2[11]='mlst'
    set udg_Draft_item_options2[12]='shcw'
    set udg_Draft_item_options2[13]='I02P'
    set udg_Draft_item_options2[14]='I04M'
    set udg_Draft_item_options2[15]='I03U'
    set udg_Draft_item_options2[16]='I03O'
    set udg_Draft_item_options2[17]='I03P'
    set udg_Draft_item_options2[18]='I04Q'
    set udg_Draft_item_options2[19]='I04I'
    set udg_Draft_item_options2[20]='glsk'
    set udg_Draft_max2=20
    set udg_Draft_item_options3[1]='I005'
    set udg_Draft_item_options3[2]='I006'
    set udg_Draft_item_options3[3]='I007'
    set udg_Draft_item_options3[4]='I000'
    set udg_Draft_item_options3[5]='I04X'
    set udg_Draft_item_options3[6]='I022'
    set udg_Draft_item_options3[7]='I02B'
    set udg_Draft_item_options3[8]='azhr'
    set udg_Draft_item_options3[9]='mnsf'
    set udg_Draft_item_options3[10]='gvsm'
    set udg_Draft_item_options3[11]='sbok'
    set udg_Draft_item_options3[12]='I04E'
    set udg_Draft_item_options3[13]='I04L'
    set udg_Draft_item_options3[14]='I04T'
    set udg_Draft_item_options3[15]='I03V'
    set udg_Draft_item_options3[16]='I030'
    set udg_Draft_item_options3[17]='I047'
    set udg_Draft_item_options3[18]='I02M'
    set udg_Draft_item_options3[19]='I03N'
    set udg_Draft_item_options3[20]='I04C'
    set udg_Draft_item_options3[21]='I04D'
    set udg_Draft_max3=21
    set udg_Draft_item_options4[1]='modt'
    set udg_Draft_item_options4[2]='I03J'
    set udg_Draft_item_options4[3]='I017'
    set udg_Draft_item_options4[4]='I003'
    set udg_Draft_item_options4[5]='btst'
    set udg_Draft_item_options4[6]='I03I'
    set udg_Draft_item_options4[7]='I026'
    set udg_Draft_item_options4[8]='I02Z'
    set udg_Draft_item_options4[9]='war2'
    set udg_Draft_item_options4[10]='sehr'
    set udg_Draft_item_options4[11]='rots'
    set udg_Draft_item_options4[12]='bfhr'
    set udg_Draft_item_options4[13]='I02N'
    set udg_Draft_item_options4[14]='I02Q'
    set udg_Draft_item_options4[15]='I04G'
    set udg_Draft_item_options4[16]='I00L'
    set udg_Draft_item_options4[17]='I04F'
    set udg_Draft_max4=17
    set udg_Draft_item_options5[1]='I009'
    set udg_Draft_item_options5[2]='I008'
    set udg_Draft_item_options5[3]='arsh'
    set udg_Draft_item_options5[4]='I02A'
    set udg_Draft_item_options5[5]='I02C'
    set udg_Draft_item_options5[6]='I02Y'
    set udg_Draft_item_options5[7]='crdt'
    set udg_Draft_item_options5[8]='I001'
    set udg_Draft_item_options5[9]='I01L'
    set udg_Draft_item_options5[10]='shen'
    set udg_Draft_item_options5[11]='I03Z'
    set udg_Draft_item_options5[12]='I04Y'
    set udg_Draft_item_options5[13]='I02R'
    set udg_Draft_item_options5[14]='I04R'
    set udg_Draft_item_options5[15]='I025'
    set udg_Draft_item_options5[16]='mcou'
    set udg_Draft_item_options5[17]='I019'
    set udg_Draft_item_options5[18]='I04J'
    set udg_Draft_item_options5[19]='I04K'
    set udg_Draft_max5=19
endfunction

//===========================================================================
function InitTrig_DraftStart takes nothing returns nothing
    set gg_trg_DraftStart=CreateTrigger()
    call TriggerAddAction(gg_trg_DraftStart, function Trig_DraftStart_Actions)
endfunction

//===========================================================================
// Trigger: Item Stack
//===========================================================================
function Trig_Item_Stack_Func015C takes nothing returns boolean
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'sxpl' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'I00L' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'tmmt' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'ches' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'rat6' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'ckng' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'gcel' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'hval' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'hcun' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'drph' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'shrs' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'rag1' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'rde2' ) ) then
        return true
    endif
    if ( ( GetItemTypeId(GetManipulatedItem()) == 'rwiz' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Item_Stack_Conditions takes nothing returns boolean
    if ( not Trig_Item_Stack_Func015C() ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'sxpl' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func002C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'tmmt' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func003C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'ches' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func004C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'rat6' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func005C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'ckng' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func006C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func007C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'gcel' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func008C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'hval' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func009C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'hcun' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func010C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'drph' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func011C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'shrs' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func012C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'rag1' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func013C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'rde2' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Func014C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'rwiz' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Stack_Actions takes nothing returns nothing
    if ( Trig_Item_Stack_Func001C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_MANA_POINTS_GAINED_IMPG, 0, ( 150 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func002C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_STRENGTH_BONUS_ISTR, 0, ( 5 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func003C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_DEFENSE_BONUS_IDEF, 0, ( 1 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 1), ABILITY_ILF_ATTACK_BONUS, 0, ( 6 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func004C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_ATTACK_BONUS, 0, ( 9 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func005C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_STRENGTH_BONUS_ISTR, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_INTELLIGENCE_BONUS, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_AGILITY_BONUS, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func006C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_STRENGTH_BONUS_ISTR, 0, ( 25 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_INTELLIGENCE_BONUS, 0, ( 25 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_AGILITY_BONUS, 0, ( 25 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func007C() ) then
        call BlzSetAbilityRealLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, 0, ( I2R(GetItemCharges(GetManipulatedItem())) * 0.12 ))
    else
    endif
    if ( Trig_Item_Stack_Func008C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_STRENGTH_BONUS_ISTR, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_AGILITY_BONUS, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func009C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_AGILITY_BONUS, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_INTELLIGENCE_BONUS, 0, ( 4 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func010C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_INTELLIGENCE_BONUS, 0, ( 5 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func011C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_HIT_POINTS_GAINED_IHPG, 0, ( 100 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func012C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_AGILITY_BONUS, 0, ( 5 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func013C() ) then
        call BlzSetAbilityIntegerLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_ILF_DEFENSE_BONUS_IDEF, 0, ( 2 * GetItemCharges(GetManipulatedItem()) ))
    else
    endif
    if ( Trig_Item_Stack_Func014C() ) then
        call BlzSetAbilityRealLevelFieldBJ(BlzGetItemAbilityByIndex(GetManipulatedItem(), 0), ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL, 0, ( I2R(GetItemCharges(GetManipulatedItem())) * 0.50 ))
    else
    endif
endfunction

//===========================================================================
function InitTrig_Item_Stack takes nothing returns nothing
    set gg_trg_Item_Stack=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Stack, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Item_Stack, Condition(function Trig_Item_Stack_Conditions))
    call TriggerAddAction(gg_trg_Item_Stack, function Trig_Item_Stack_Actions)
endfunction

//===========================================================================
// Trigger: InitMB
//===========================================================================
function Trig_InitMB_Actions takes nothing returns nothing
    local integer i
    local player p
    call InitMB()
    call BlzFrameSetVisible(UIB, true)
    call TriggerAddCondition(TrigUI, Filter(function SwapUI))
    set i=1
    loop
    exitwhen i > 4
    set p=Player(i - 1)
    call AddTrait(p , 1 , 1093677621)
    call AddTrait(p , 2 , 1093677620)
    set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_InitMB takes nothing returns nothing
    set gg_trg_InitMB=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_InitMB, 8.00)
    call TriggerAddAction(gg_trg_InitMB, function Trig_InitMB_Actions)
endfunction

//===========================================================================
// Trigger: Reward Init
//===========================================================================
function Trig_Reward_Init_Actions takes nothing returns nothing
    set udg_reward_trigger_list[1]=gg_trg_Learn_Ability
    set udg_reward_trigger_list[2]=gg_trg_Upgrade_Ability
    set udg_reward_trigger_list[3]=gg_trg_Cheap_Item
    set udg_reward_trigger_list[4]=gg_trg_Gain_stats_per_level
    set udg_reward_trigger_list[5]=gg_trg_Reduce_Difficulty_Level
    set udg_reward_trigger_list[6]=gg_trg_Gain_Spell_Damage
    set udg_reward_trigger_list[7]=gg_trg_Upgrade_Summons
    set udg_reward_trigger_list[8]=gg_trg_Upgrade_Pillar
    set udg_reward_trigger_list[9]=gg_trg_Sacrifice_stats_for_reward
    set udg_reward_trigger_list[10]=gg_trg_Attribute_Rewards
    set udg_reward_trigger_list[11]=gg_trg_Base_Damage_Bonus
    set udg_reward_trigger_list[12]=gg_trg_Armor_Bonus
    set udg_reward_trigger_list[13]=gg_trg_Lifesteal_Bonus
    set udg_reward_trigger_list[14]=gg_trg_Movement_Speed_Bonus
    set udg_reward_trigger_list[15]=gg_trg_Spend_All_gold_for_reward
    set udg_reward_trigger_list[16]=gg_trg_Attack_Cooldown_Reduction
    set udg_reward_trigger_list[17]=gg_trg_Expensive_Item
    set udg_reward_trigger_list[18]=gg_trg_Reduce_CD_Ability
endfunction

//===========================================================================
function InitTrig_Reward_Init takes nothing returns nothing
    set gg_trg_Reward_Init=CreateTrigger()
    call TriggerAddAction(gg_trg_Reward_Init, function Trig_Reward_Init_Actions)
endfunction

//===========================================================================
// Trigger: Reward Round
//===========================================================================
function Trig_Reward_Round_Func003Func001Func005Func001Func001C takes nothing returns boolean
    if ( ( ModuloInteger(udg_current_wave, 4) == 0 ) ) then
        return true
    endif
    if ( ( udg_current_wave == 2 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001Func005Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_r_temp_num, 10) == 5 ) ) then
        return false
    endif
    if ( not ( ModuloInteger(udg_current_wave, 6) == 0 ) ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 10) != 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001Func005C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_r_temp_num, 10) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001Func006C takes nothing returns boolean
    if ( not ( udg_reward_trigger_taken[udg_chance] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001Func007C takes nothing returns boolean
    if ( ( udg_maxabilities_counter[udg_N] < 7 ) ) then
        return true
    endif
    if ( ( GetRandomInt(1, 2) == 1 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001Func008C takes nothing returns boolean
    if ( ( udg_current_wave < 22 ) ) then
        return true
    endif
    if ( ( ModuloInteger(udg_r_temp_num, 10) == 1 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Reward_Round_Func003Func001Func005Func001C takes nothing returns boolean
    if ( not Trig_Reward_Round_Func003Func001Func005Func001Func001C() ) then
        return false
    endif
    if ( not Trig_Reward_Round_Func003Func001Func005Func001Func007C() ) then
        return false
    endif
    if ( not Trig_Reward_Round_Func003Func001Func005Func001Func008C() ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Func003Func001Func006C takes nothing returns boolean
    if ( not ( GetPlayerState(ConvertedPlayer(udg_N), PLAYER_STATE_RESOURCE_LUMBER) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Func003Func001Func008001 takes nothing returns boolean
    return ( GetPlayerController(ConvertedPlayer(udg_N)) == MAP_CONTROL_USER )
endfunction

function Trig_Reward_Round_Func003Func001Func008002 takes nothing returns boolean
    return ( GetPlayerSlotState(ConvertedPlayer(udg_N)) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_Reward_Round_Func003Func001C takes nothing returns boolean
    if ( not GetBooleanAnd((GetPlayerController(ConvertedPlayer(udg_N)) == MAP_CONTROL_USER), (GetPlayerSlotState(ConvertedPlayer(udg_N)) == PLAYER_SLOT_STATE_PLAYING)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Reward_Round_Actions takes nothing returns nothing
    set udg_ChoosePlayers=0
    set udg_reward_chosenbutton_num=0
    set udg_N=1
    loop
        exitwhen udg_N > 4
        if ( Trig_Reward_Round_Func003Func001C() ) then
            set udg_ChoosePlayers=( udg_ChoosePlayers + 1 )
            set bj_forLoopBIndex=1
            set bj_forLoopBIndexEnd=19
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_reward_trigger_taken[GetForLoopIndexB()]=false
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
            call DialogClearBJ(udg_reward_dialog_Copy[udg_N])
            call DialogSetMessageBJ(udg_reward_dialog_Copy[udg_N], "TRIGSTR_7433")
            set udg_r_temp_num=( ( 10 * udg_N ) + 1 )
            loop
                exitwhen udg_r_temp_num > ( ( 10 * udg_N ) + 6 )
                set udg_reward_dialog_button[udg_r_temp_num]=null
                set udg_r_temp_num=udg_r_temp_num + 1
            endloop
            set udg_r_temp_num=( ( 10 * udg_N ) + 1 )
            loop
                exitwhen udg_r_temp_num > ( ( 10 * udg_N ) + 5 )
                if ( Trig_Reward_Round_Func003Func001Func005Func001C() ) then
                    set udg_reward_trigger[udg_r_temp_num]=udg_reward_trigger_list[1]
                    set udg_reward_trigger_taken[1]=true
                    call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
                else
                    if ( Trig_Reward_Round_Func003Func001Func005Func001Func005C() ) then
                        set udg_chance=GetRandomInt(1, 3)
                    else
                        if ( Trig_Reward_Round_Func003Func001Func005Func001Func005Func001C() ) then
                            set udg_chance=9
                        else
                            set udg_chance=GetRandomInt(4, 18)
                        endif
                    endif
                    if ( Trig_Reward_Round_Func003Func001Func005Func001Func006C() ) then
                        set udg_reward_trigger_taken[udg_chance]=true
                        set udg_reward_trigger[udg_r_temp_num]=udg_reward_trigger_list[udg_chance]
                        call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
                    else
                        set udg_r_temp_num=( udg_r_temp_num - 1 )
                    endif
                endif
                set udg_r_temp_num=udg_r_temp_num + 1
            endloop
            if ( Trig_Reward_Round_Func003Func001Func006C() ) then
                set udg_reward_trigger_taken[udg_r_temp_num]=true
                set udg_reward_trigger[udg_r_temp_num]=gg_trg_RewardReroll
                call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
            else
            endif
            call DialogDisplayBJ(true, udg_reward_dialog_Copy[udg_N], ConvertedPlayer(udg_N))
        else
        endif
        set udg_N=udg_N + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Reward_Round takes nothing returns nothing
    set gg_trg_Reward_Round=CreateTrigger()
    call TriggerAddAction(gg_trg_Reward_Round, function Trig_Reward_Round_Actions)
endfunction

//===========================================================================
// Trigger: Reward Chosen
//===========================================================================
function Trig_Reward_Chosen_Func002Func002C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_reward_dialog_button[udg_r_temp_num] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reward_Chosen_Actions takes nothing returns nothing
 local integer endslot= ( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 6 )
 local boolean found= false
    set udg_ChoosePlayers=( udg_ChoosePlayers - 1 )
    set udg_r_temp_num=( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 1 )
    loop
        exitwhen udg_r_temp_num > endslot
        set udg_reward_learn_option_taken[udg_r_temp_num]=0
        set udg_r_temp_num=udg_r_temp_num + 1
    endloop
    set udg_r_temp_num=( ( 10 * GetConvertedPlayerId(GetTriggerPlayer()) ) + 1 )
    loop
        exitwhen found or udg_r_temp_num > endslot
        if ( Trig_Reward_Chosen_Func002Func002C() ) then
            set found=true
            set udg_reward_chosenbutton_num=udg_r_temp_num
            call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
        else
        endif
        set udg_r_temp_num=udg_r_temp_num + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Reward_Chosen takes nothing returns nothing
    set gg_trg_Reward_Chosen=CreateTrigger()
    call TriggerRegisterDialogEventBJ(gg_trg_Reward_Chosen, udg_reward_dialog_Copy[1])
    call TriggerRegisterDialogEventBJ(gg_trg_Reward_Chosen, udg_reward_dialog_Copy[2])
    call TriggerRegisterDialogEventBJ(gg_trg_Reward_Chosen, udg_reward_dialog_Copy[3])
    call TriggerRegisterDialogEventBJ(gg_trg_Reward_Chosen, udg_reward_dialog_Copy[4])
    call TriggerAddAction(gg_trg_Reward_Chosen, function Trig_Reward_Chosen_Actions)
endfunction

//===========================================================================
// Trigger: RewardReroll
//===========================================================================
function Trig_RewardReroll_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func001C takes nothing returns boolean
    if ( ( ModuloInteger(udg_current_wave, 4) == 0 ) ) then
        return true
    endif
    if ( ( udg_current_wave == 2 ) ) then
        return true
    endif
    return false
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func005Func001C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_r_temp_num, 10) == 5 ) ) then
        return false
    endif
    if ( not ( ModuloInteger(udg_current_wave, 6) == 0 ) ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 10) != 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func005C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_r_temp_num, 10) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func006C takes nothing returns boolean
    if ( not ( udg_reward_trigger_taken[udg_chance] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func007C takes nothing returns boolean
    if ( ( udg_maxabilities_counter[udg_N] < 7 ) ) then
        return true
    endif
    if ( ( GetRandomInt(1, 2) == 1 ) ) then
        return true
    endif
    return false
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001Func008C takes nothing returns boolean
    if ( ( udg_current_wave < 22 ) ) then
        return true
    endif
    if ( ( ModuloInteger(udg_r_temp_num, 10) == 1 ) ) then
        return true
    endif
    return false
endfunction

function Trig_RewardReroll_Func003Func008Func005Func001C takes nothing returns boolean
    if ( not Trig_RewardReroll_Func003Func008Func005Func001Func001C() ) then
        return false
    endif
    if ( not Trig_RewardReroll_Func003Func008Func005Func001Func007C() ) then
        return false
    endif
    if ( not Trig_RewardReroll_Func003Func008Func005Func001Func008C() ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func006C takes nothing returns boolean
    if ( not ( GetPlayerState(ConvertedPlayer(udg_N), PLAYER_STATE_RESOURCE_LUMBER) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003Func008Func008001 takes nothing returns boolean
    return ( GetPlayerController(ConvertedPlayer(udg_N)) == MAP_CONTROL_USER )
endfunction

function Trig_RewardReroll_Func003Func008Func008002 takes nothing returns boolean
    return ( GetPlayerSlotState(ConvertedPlayer(udg_N)) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_RewardReroll_Func003Func008C takes nothing returns boolean
    if ( not GetBooleanAnd((GetPlayerController(ConvertedPlayer(udg_N)) == MAP_CONTROL_USER), (GetPlayerSlotState(ConvertedPlayer(udg_N)) == PLAYER_SLOT_STATE_PLAYING)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RewardReroll_Actions takes nothing returns nothing
 local integer L_N
    if ( Trig_RewardReroll_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_RewardReroll_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_RewardReroll_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_RewardReroll_Func003C() ) then
        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_3501")
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        // Send Reroll for plX
        set udg_N=udg_X
        set L_N=udg_X
        call AdjustPlayerStateBJ(- 1, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_LUMBER)
        set udg_reward_chosenbutton_num=0
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + "rerolled" ))
        if ( Trig_RewardReroll_Func003Func008C() ) then
            set bj_forLoopBIndex=1
            set bj_forLoopBIndexEnd=19
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_reward_trigger_taken[GetForLoopIndexB()]=false
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
            call TriggerSleepAction(0.00)
            set udg_N=L_N
            set udg_X=L_N
            set udg_reward_chosenbutton_num=0
            call DialogClearBJ(udg_reward_dialog_Copy[udg_N])
            call DialogSetMessageBJ(udg_reward_dialog_Copy[udg_N], "TRIGSTR_3502")
            set udg_r_temp_num=( ( 10 * udg_N ) + 1 )
            loop
                exitwhen udg_r_temp_num > ( ( 10 * udg_N ) + 6 )
                set udg_reward_dialog_button[udg_r_temp_num]=null
                set udg_r_temp_num=udg_r_temp_num + 1
            endloop
            set udg_r_temp_num=( ( 10 * udg_N ) + 1 )
            loop
                exitwhen udg_r_temp_num > ( ( 10 * udg_N ) + 5 )
                if ( Trig_RewardReroll_Func003Func008Func005Func001C() ) then
                    set udg_reward_trigger[udg_r_temp_num]=udg_reward_trigger_list[1]
                    set udg_reward_trigger_taken[1]=true
                    call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
                else
                    if ( Trig_RewardReroll_Func003Func008Func005Func001Func005C() ) then
                        set udg_chance=GetRandomInt(1, 3)
                    else
                        if ( Trig_RewardReroll_Func003Func008Func005Func001Func005Func001C() ) then
                            set udg_chance=9
                        else
                            set udg_chance=GetRandomInt(4, 19)
                        endif
                    endif
                    if ( Trig_RewardReroll_Func003Func008Func005Func001Func006C() ) then
                        set udg_reward_trigger_taken[udg_chance]=true
                        set udg_reward_trigger[udg_r_temp_num]=udg_reward_trigger_list[udg_chance]
                        call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
                    else
                        set udg_r_temp_num=( udg_r_temp_num - 1 )
                    endif
                endif
                set udg_r_temp_num=udg_r_temp_num + 1
            endloop
            if ( Trig_RewardReroll_Func003Func008Func006C() ) then
                set udg_reward_trigger_taken[udg_r_temp_num]=true
                set udg_reward_trigger[udg_r_temp_num]=gg_trg_RewardReroll
                call ConditionalTriggerExecute(udg_reward_trigger[udg_r_temp_num])
            else
            endif
            call DialogDisplayBJ(true, udg_reward_dialog_Copy[udg_N], ConvertedPlayer(udg_N))
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_RewardReroll takes nothing returns nothing
    set gg_trg_RewardReroll=CreateTrigger()
    call TriggerAddAction(gg_trg_RewardReroll, function Trig_RewardReroll_Actions)
endfunction

//===========================================================================
// Trigger: Attribute Rewards
//===========================================================================
function Trig_Attribute_Rewards_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func006C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func008C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 6 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func009C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func010C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 6 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003Func015C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attribute_Rewards_Actions takes nothing returns nothing
    if ( Trig_Attribute_Rewards_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Attribute_Rewards_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Attribute_Rewards_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Attribute_Rewards_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 8)
        set udg_temp_num=( 2 * udg_current_wave )
        if ( Trig_Attribute_Rewards_Func003Func015C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, ( "|cffff0000+" + ( I2S(udg_temp_num) + " Strength|r" ) ))
        else
            if ( Trig_Attribute_Rewards_Func003Func015Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cff3763ff+" + ( I2S(udg_temp_num) + " Intelligence|r" ) ))
            else
                if ( Trig_Attribute_Rewards_Func003Func015Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cff00ff00+" + ( I2S(udg_temp_num) + " Agillity|r" ) ))
                else
                    if ( Trig_Attribute_Rewards_Func003Func015Func001Func001Func001C() ) then
                        set udg_temp_num=( 1 + ( udg_current_wave / 6 ) )
                        call DialogAddButtonBJ(udg_reward_dialog, ( "|cff8080ffx" + ( I2S(udg_temp_num) + " Tome of Power|r" ) ))
                    else
                        if ( Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001C() ) then
                            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_198")
                        else
                            if ( Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001C() ) then
                                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_232")
                            else
                                if ( Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001Func001C() ) then
                                    call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_238")
                                else
                                    if ( Trig_Attribute_Rewards_Func003Func015Func001Func001Func001Func001Func001Func001Func001C() ) then
                                        set udg_temp_num=( 1 + ( udg_current_wave / 5 ) )
                                        call DialogAddButtonBJ(udg_reward_dialog, ( "|cff008000+" + ( I2S(( udg_temp_num * 5 )) + " Health Regen|r" ) ))
                                    else
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        set udg_temp_num=( 2 * udg_current_wave )
        if ( Trig_Attribute_Rewards_Func003Func003C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, udg_temp_num)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff0000+" + ( I2S(udg_temp_num) + " Strength|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func004C() ) then
            call ModifyHeroStat(bj_HEROSTAT_INT, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, udg_temp_num)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff3763ff+" + ( I2S(udg_temp_num) + " Intelligence|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func005C() ) then
            call ModifyHeroStat(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, udg_temp_num)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff00ff00+" + ( I2S(udg_temp_num) + " Agility|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func006C() ) then
            set udg_temp_num=( 1 + ( udg_current_wave / 6 ) )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff8080ffx" + ( I2S(udg_temp_num) + " Tome of Power" ) ) ))
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=udg_temp_num
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call CreateItemLoc('tkno', GetRectCenter(gg_rct_item_spawn))
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func007C() ) then
            call ModifyHeroStat(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_SET, R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], false)) * 1.20 )))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff00ff00x1.2" + ( " Agility|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func008C() ) then
            call ModifyHeroStat(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_SET, R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], false)) * 1.10 )))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff0000x1.1" + ( " Strength|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func009C() ) then
            call ModifyHeroStat(bj_HEROSTAT_INT, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_SET, R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_INT, udg_NICKHeroArray[udg_X], false)) * 1.30 )))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff3763ffx1.3" + ( " Intelligence|r" ) ) ))
        else
        endif
        if ( Trig_Attribute_Rewards_Func003Func010C() ) then
            set udg_temp_num=( 1 + ( udg_current_wave / 5 ) )
            set udg_reward_regen_Copy[udg_X]=( udg_reward_regen_Copy[udg_X] + ( I2R(udg_temp_num) * 5.00 ) )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff008000+" + ( I2S(( udg_temp_num * 5 )) + " Health Regen" ) ) ))
        else
        endif
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Attribute_Rewards takes nothing returns nothing
    set gg_trg_Attribute_Rewards=CreateTrigger()
    call TriggerAddAction(gg_trg_Attribute_Rewards, function Trig_Attribute_Rewards_Actions)
endfunction

//===========================================================================
// Trigger: Base Damage Bonus
//===========================================================================
function Trig_Base_Damage_Bonus_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func011Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func011Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003Func011C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Base_Damage_Bonus_Actions takes nothing returns nothing
    if ( Trig_Base_Damage_Bonus_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Base_Damage_Bonus_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Base_Damage_Bonus_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Base_Damage_Bonus_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
        set udg_temp_num=( 7 + R2I(( I2R(udg_current_wave) * 1.50 )) )
        set udg_reward_list_randomnum2[udg_r_temp_num]=udg_temp_num
        if ( Trig_Base_Damage_Bonus_Func003Func011C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, ( "|cffff5e19+" + ( I2S(udg_temp_num) + " Base Damage|r" ) ))
        else
            if ( Trig_Base_Damage_Bonus_Func003Func011Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cffff5e19+" + ( I2S(R2I(( I2R(udg_temp_num) * 1.50 ))) + " Base Damage|r|n|cff707370+3 Difficulty Level|r" ) ))
            else
                if ( Trig_Base_Damage_Bonus_Func003Func011Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cffff5e19+" + ( I2S(( udg_temp_num * 2 )) + " Base Damage|r|n|cff707370+6 Difficulty Level|r" ) ))
                else
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        set udg_temp_num=udg_reward_list_randomnum2[udg_r_temp_num]
        if ( Trig_Base_Damage_Bonus_Func003Func003C() ) then
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0) + udg_temp_num ), 0)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff5e19+" + ( I2S(udg_temp_num) + " Base Damage" ) ) ))
        else
        endif
        if ( Trig_Base_Damage_Bonus_Func003Func004C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff5e19+" + ( I2S(R2I(( I2R(udg_temp_num) * 1.50 ))) + " Base Damage|r / |cff707370+3 Difficulty Level|r" ) ) ))
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0) + R2I(( I2R(udg_temp_num) * 1.50 )) ), 0)
            call AdjustPlayerStateBJ(3, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
        else
        endif
        if ( Trig_Base_Damage_Bonus_Func003Func005C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff5e19+" + ( I2S(( udg_temp_num * 2 )) + " Base Damage|r / |cff707370+6 Difficulty Level|r" ) ) ))
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0) + ( udg_temp_num * 2 ) ), 0)
            call AdjustPlayerStateBJ(6, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
        else
        endif
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Base_Damage_Bonus takes nothing returns nothing
    set gg_trg_Base_Damage_Bonus=CreateTrigger()
    call TriggerAddAction(gg_trg_Base_Damage_Bonus, function Trig_Base_Damage_Bonus_Actions)
endfunction

//===========================================================================
// Trigger: Armor Bonus
//===========================================================================
function Trig_Armor_Bonus_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func008Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func008Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003Func008C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Armor_Bonus_Actions takes nothing returns nothing
    if ( Trig_Armor_Bonus_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Armor_Bonus_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Armor_Bonus_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Armor_Bonus_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
        if ( Trig_Armor_Bonus_Func003Func008C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10448")
        else
            if ( Trig_Armor_Bonus_Func003Func008Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10447")
            else
                if ( Trig_Armor_Bonus_Func003Func008Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10446")
                else
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Armor_Bonus_Func003Func002C() ) then
            call BlzSetUnitArmor(udg_NICKHeroArray[udg_X], ( BlzGetUnitArmor(udg_NICKHeroArray[udg_X]) + 4.00 ))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen|cffc0c0c0 +" + ( "4 Armor" ) ) ))
        else
        endif
        if ( Trig_Armor_Bonus_Func003Func003C() ) then
            call BlzSetUnitArmor(udg_NICKHeroArray[udg_X], ( BlzGetUnitArmor(udg_NICKHeroArray[udg_X]) + 7.00 ))
            call AdjustPlayerStateBJ(3, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen|cffc0c0c0 +" + ( "7 Armor|r / |cff707370+3 Difficulty Level|r" ) ) ))
        else
        endif
        if ( Trig_Armor_Bonus_Func003Func004C() ) then
            call BlzSetUnitArmor(udg_NICKHeroArray[udg_X], ( BlzGetUnitArmor(udg_NICKHeroArray[udg_X]) + 10.00 ))
            call AdjustPlayerStateBJ(7, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen|cffc0c0c0 +" + ( "10 Armor|r / |cff707370+7 Difficulty Level|r" ) ) ))
        else
        endif
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Armor_Bonus takes nothing returns nothing
    set gg_trg_Armor_Bonus=CreateTrigger()
    call TriggerAddAction(gg_trg_Armor_Bonus, function Trig_Armor_Bonus_Actions)
endfunction

//===========================================================================
// Trigger: Lifesteal Bonus
//===========================================================================
function Trig_Lifesteal_Bonus_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func003Func007Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func003Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifesteal_Bonus_Actions takes nothing returns nothing
    if ( Trig_Lifesteal_Bonus_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Lifesteal_Bonus_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Lifesteal_Bonus_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Lifesteal_Bonus_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 2)
        if ( Trig_Lifesteal_Bonus_Func003Func007C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10422")
        else
            if ( Trig_Lifesteal_Bonus_Func003Func007Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10421")
            else
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Lifesteal_Bonus_Func003Func002C() ) then
            set udg_reward_lifesteal_Copy[udg_X]=( udg_reward_lifesteal_Copy[udg_X] + 0.02 )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff0000+2% Life Steal|r" + ( "" ) ) ))
        else
        endif
        if ( Trig_Lifesteal_Bonus_Func003Func003C() ) then
            set udg_reward_lifesteal_Copy[udg_X]=( udg_reward_lifesteal_Copy[udg_X] + 0.04 )
            call AdjustPlayerStateBJ(5, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff0000+4% Life Steal|r / |cff707370+5 Difficulty Level|r" + ( "" ) ) ))
        else
        endif
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Lifesteal_Bonus takes nothing returns nothing
    set gg_trg_Lifesteal_Bonus=CreateTrigger()
    call TriggerAddAction(gg_trg_Lifesteal_Bonus, function Trig_Lifesteal_Bonus_Actions)
endfunction

//===========================================================================
// Trigger: Attack Cooldown Reduction
//===========================================================================
function Trig_Attack_Cooldown_Reduction_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func003Func007Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func003Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Attack_Cooldown_Reduction_Actions takes nothing returns nothing
    if ( Trig_Attack_Cooldown_Reduction_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Attack_Cooldown_Reduction_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Attack_Cooldown_Reduction_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Attack_Cooldown_Reduction_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 2)
        if ( Trig_Attack_Cooldown_Reduction_Func003Func007C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10481")
        else
            if ( Trig_Attack_Cooldown_Reduction_Func003Func007Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10482")
            else
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Attack_Cooldown_Reduction_Func003Func002C() ) then
            call BlzSetUnitAttackCooldown(udg_NICKHeroArray[udg_X], ( BlzGetUnitAttackCooldown(udg_NICKHeroArray[udg_X], 0) * 0.92 ), ( 0 + 0 ))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808000-8% Attack Cooldown|r" ))
        else
        endif
        if ( Trig_Attack_Cooldown_Reduction_Func003Func003C() ) then
            call BlzSetUnitAttackCooldown(udg_NICKHeroArray[udg_X], ( BlzGetUnitAttackCooldown(udg_NICKHeroArray[udg_X], 0) * 0.88 ), ( 0 + 0 ))
            call AdjustPlayerStateBJ(5, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808000-12% Attack Cooldown|r / |cff707370+5 Difficulty Level|r" ))
        else
        endif
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Attack_Cooldown_Reduction takes nothing returns nothing
    set gg_trg_Attack_Cooldown_Reduction=CreateTrigger()
    call TriggerAddAction(gg_trg_Attack_Cooldown_Reduction, function Trig_Attack_Cooldown_Reduction_Actions)
endfunction

//===========================================================================
// Trigger: Spend All gold for reward
//===========================================================================
function Trig_Spend_All_gold_for_reward_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001Func001C takes nothing returns boolean
    if ( ( GetPlayerState(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_GOLD) < ( 1000 + ( udg_current_wave * 25 ) ) ) ) then
        return true
    endif
    if ( ( udg_SmallUp[udg_X] < ( udg_current_wave / 20 ) ) ) then
        return true
    endif
    return false
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002Func002Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func001C takes nothing returns boolean
    if ( not Trig_Spend_All_gold_for_reward_Func003Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003Func006C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spend_All_gold_for_reward_Actions takes nothing returns nothing
    if ( Trig_Spend_All_gold_for_reward_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Spend_All_gold_for_reward_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Spend_All_gold_for_reward_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Spend_All_gold_for_reward_Func003C() ) then
        if ( Trig_Spend_All_gold_for_reward_Func003Func001C() ) then
            set udg_r_temp_num=( udg_r_temp_num - 1 )
        else
            set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 4)
            if ( Trig_Spend_All_gold_for_reward_Func003Func001Func003C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10466")
            else
                if ( Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_318")
                else
                    if ( Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002Func002C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10464")
                    else
                        if ( Trig_Spend_All_gold_for_reward_Func003Func001Func003Func002Func002Func001C() ) then
                            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_6376")
                        else
                        endif
                    endif
                endif
            endif
            set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
        endif
    else
        // Click Button
        if ( Trig_Spend_All_gold_for_reward_Func003Func003C() ) then
            set udg_SmallUp[udg_X]=( udg_SmallUp[udg_X] + 1 )
            call ModifyHeroStat(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_SET, R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], true)) * 1.50 )))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen: Spend All |cffffff00Gold|r for |cff00ff00x1.5 Agility|r" ))
        else
        endif
        if ( Trig_Spend_All_gold_for_reward_Func003Func004C() ) then
            set udg_SmallUp[udg_X]=( udg_SmallUp[udg_X] + 1 )
            call ModifyHeroStat(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_SET, R2I(( I2R(GetHeroStatBJ(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], true)) * 1.40 )))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen: Spend All |cffffff00Gold|r for |cffff0000x1.4 Strength|r" ))
        else
        endif
        if ( Trig_Spend_All_gold_for_reward_Func003Func005C() ) then
            call BlzSetUnitArmor(udg_NICKHeroArray[udg_X], ( BlzGetUnitArmor(udg_NICKHeroArray[udg_X]) + 15.00 ))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen: Spend All |cffffff00Gold|r for |cff80a8a8+15 Armor|r" ))
        else
        endif
        if ( Trig_Spend_All_gold_for_reward_Func003Func006C() ) then
            set udg_SmallUp[udg_X]=( udg_SmallUp[udg_X] + 1 )
            call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], R2I(( I2R(BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0)) * 1.40 )), 0)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen: Spend All |cffffff00Gold|r for |cffff5e19x1.4 Base Damage|r" ))
        else
        endif
        call SetPlayerStateBJ(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_GOLD, 0)
        set udg_PGold[udg_X]=0.00
    endif
endfunction

//===========================================================================
function InitTrig_Spend_All_gold_for_reward takes nothing returns nothing
    set gg_trg_Spend_All_gold_for_reward=CreateTrigger()
    call TriggerAddAction(gg_trg_Spend_All_gold_for_reward, function Trig_Spend_All_gold_for_reward_Actions)
endfunction

//===========================================================================
// Trigger: Sacrifice stats for reward
//===========================================================================
function Trig_Sacrifice_stats_for_reward_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_current_wave > 60 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_BigUp[udg_X] < ( udg_current_wave / 25 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func001C takes nothing returns boolean
    if ( not ( udg_current_wave > 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func004Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006Func005Func006C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func005Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum2[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sacrifice_stats_for_reward_Actions takes nothing returns nothing
    if ( Trig_Sacrifice_stats_for_reward_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Sacrifice_stats_for_reward_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Sacrifice_stats_for_reward_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Sacrifice_stats_for_reward_Func003C() ) then
        if ( Trig_Sacrifice_stats_for_reward_Func003Func001C() ) then
            set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002C() ) then
                if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001C() ) then
                    set udg_reward_list_randomnum2[udg_r_temp_num]=GetRandomInt(1, 4)
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_17045")
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001C() ) then
                            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_17044")
                        else
                            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001C() ) then
                                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_17042")
                            else
                                if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001Func002C() ) then
                                    if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func002Func001Func003Func001Func001Func002Func001C() ) then
                                        set udg_r_temp_num=( udg_r_temp_num - 1 )
                                    else
                                        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_17043")
                                    endif
                                else
                                endif
                            endif
                        endif
                    endif
                else
                    set udg_r_temp_num=( udg_r_temp_num - 1 )
                    set udg_reward_list_randomnum[udg_r_temp_num]=0
                endif
            else
            endif
            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func003C() ) then
                set udg_reward_list_randomnum2[udg_r_temp_num]=GetRandomInt(1, 4)
                if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cffbc0000-500 Pillar Health|r for |cff00ff00+" + ( I2S(( udg_current_wave * 4 )) + " Agillity|r" ) ))
                else
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog, ( "|cffbc0000-500 Pillar Health|r for |cffff0000+" + ( I2S(( udg_current_wave * 4 )) + " Strength|r" ) ))
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001Func001C() ) then
                            call DialogAddButtonBJ(udg_reward_dialog, ( "|cffbc0000-500 Pillar Health|r for |cff3763ff+" + ( I2S(( udg_current_wave * 4 )) + " Intelligence|r" ) ))
                        else
                            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func003Func002Func001Func001Func001C() ) then
                                call DialogAddButtonBJ(udg_reward_dialog, ( "|cffbc0000-500 Pillar Health|r for |cffff00ff+" + ( I2S(( udg_current_wave * 5 )) + " Spell Damage|r" ) ))
                            else
                            endif
                        endif
                    endif
                endif
            else
            endif
            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func004C() ) then
                set udg_reward_list_randomnum2[udg_r_temp_num]=GetRandomInt(1, 4)
                if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002C() ) then
                    set udg_temp_num=( 300 + ( udg_current_wave * 100 ) )
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cff6c6c0020% Slowed Attack Cooldown|r for |cff00ff00+" + ( I2S(udg_temp_num) + " Max HP|r" ) ))
                else
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002C() ) then
                        set udg_temp_num=( 2 + ( udg_current_wave / 3 ) )
                        call DialogAddButtonBJ(udg_reward_dialog, ( "|cff808080-10 Armor|r for |cff008000+" + ( I2S(( udg_temp_num * 5 )) + " Health Regen|r" ) ))
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002Func003C() ) then
                            set udg_temp_num=( 25 + R2I(( I2R(udg_current_wave) * 8.50 )) )
                            call DialogAddButtonBJ(udg_reward_dialog, ( "|cff008080-75 Movement Speed|r for |cffff5e19+" + ( I2S(udg_temp_num) + " Base Damage|r" ) ))
                        else
                            if ( Trig_Sacrifice_stats_for_reward_Func003Func001Func004Func002Func002Func003Func002C() ) then
                                set udg_temp_num=( ( ( udg_current_wave / 5 ) + 1 ) * 4 )
                                call DialogAddButtonBJ(udg_reward_dialog, ( "|cff006f9e1/2 Max Mana|r for |cff80ff80+" + ( I2S(( udg_temp_num * 10 )) + " Summon Damage|r" ) ))
                            else
                            endif
                        endif
                    endif
                endif
            else
            endif
            set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
        else
            set udg_r_temp_num=( udg_r_temp_num - 1 )
        endif
    else
        // Click Button
        if ( Trig_Sacrifice_stats_for_reward_Func003Func003C() ) then
            set udg_BigUp[udg_X]=( udg_BigUp[udg_X] + 1 )
            set udg_temp_real=GetUnitLifePercent(udg_NICKHeroArray[udg_X])
            call BlzSetUnitMaxHP(udg_NICKHeroArray[udg_X], ( BlzGetUnitMaxHP(udg_NICKHeroArray[udg_X]) / 2 ))
            call SetUnitLifePercentBJ(udg_NICKHeroArray[udg_X], udg_temp_real)
            if ( Trig_Sacrifice_stats_for_reward_Func003Func003Func005C() ) then
                call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808080-50% Max HP|r for |cffc311ffx1.35 Spell Damage (%)|r" ))
                set udg_reward_spelldmg[( udg_Y + 1 )]=( udg_reward_spelldmg[( udg_Y + 1 )] + ( udg_spelldamage[udg_X] * 0.35 ) )
            else
                if ( Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001C() ) then
                    call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808080-50% Max HP|r for |cffff5e19x1.8 Base Damage|r" ))
                    call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], R2I(( I2R(BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0)) * 1.80 )), 0)
                else
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001Func002C() ) then
                        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808080-50% Max HP|r for |cff80ff80x1.75 Summon Damage (%)|r" ))
                        set udg_reward_upsummons[( udg_Y + 1 )]=R2I(( ( ( I2R(udg_reward_upsummons[( udg_Y + 1 )]) + 100.00 ) * 1.75 ) - 100.00 ))
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func003Func005Func001Func002Func002C() ) then
                            call SetPlayerHandicapXPBJ(ConvertedPlayer(udg_X), ( GetPlayerHandicapXPBJ(ConvertedPlayer(udg_X)) * 4.00 ))
                            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff808080-50% Max HP|r for |cffffff00+100% Experience Rate|r" ))
                        else
                        endif
                    endif
                endif
            endif
        else
        endif
        if ( Trig_Sacrifice_stats_for_reward_Func003Func004C() ) then
            call SetUnitLifeBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) - 500.00 ))
            if ( Trig_Sacrifice_stats_for_reward_Func003Func004Func002C() ) then
                call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffbc0000-500 Pillar Health|r for |cff00ff00+" + ( I2S(( udg_current_wave * 4 )) + " Agility|r" ) ) ))
                call ModifyHeroStat(bj_HEROSTAT_AGI, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, ( udg_current_wave * 4 ))
            else
                if ( Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003C() ) then
                    call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffbc0000-500 Pillar Health|r for |cffff0000+" + ( I2S(( udg_current_wave * 4 )) + " Strength|r" ) ) ))
                    call ModifyHeroStat(bj_HEROSTAT_STR, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, ( udg_current_wave * 4 ))
                else
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003Func003C() ) then
                        call ModifyHeroStat(bj_HEROSTAT_INT, udg_NICKHeroArray[udg_X], bj_MODIFYMETHOD_ADD, ( udg_current_wave * 4 ))
                        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffbc0000-500 Pillar Health|r for |cff3763ff+" + ( I2S(( udg_current_wave * 4 )) + " Intelligence|r" ) ) ))
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func004Func002Func003Func003Func003C() ) then
                            set udg_temp_num=( 5 * udg_current_wave )
                            set udg_reward_spelldmg[( udg_Y + 2 )]=( udg_reward_spelldmg[( udg_Y + 2 )] + I2R(udg_temp_num) )
                            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffbc0000-500 Pillar Health|r for |cffff00ff+" + ( I2S(( udg_current_wave * 5 )) + " Spell Damage|r" ) ) ))
                        else
                        endif
                    endif
                endif
            endif
        else
        endif
        if ( Trig_Sacrifice_stats_for_reward_Func003Func005C() ) then
            if ( Trig_Sacrifice_stats_for_reward_Func003Func005Func001C() ) then
                set udg_temp_num=( 300 + ( udg_current_wave * 100 ) )
                call BlzSetUnitAttackCooldown(udg_NICKHeroArray[udg_X], ( BlzGetUnitAttackCooldown(udg_NICKHeroArray[udg_X], 0) * 1.20 ), ( 0 + 0 ))
                call BlzSetUnitMaxHP(udg_NICKHeroArray[udg_X], ( BlzGetUnitMaxHP(udg_NICKHeroArray[udg_X]) + udg_temp_num ))
                call SetUnitLifeBJ(udg_NICKHeroArray[udg_X], ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_X]) + I2R(udg_temp_num) ))
                call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff6c6c0020% Slowed Attack Cooldown|r for |cff00ff00+" + ( I2S(udg_temp_num) + " Max HP|r" ) ) ))
            else
                if ( Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006C() ) then
                    call BlzSetUnitArmor(udg_NICKHeroArray[udg_X], ( BlzGetUnitArmor(udg_NICKHeroArray[udg_X]) - 10.00 ))
                    set udg_temp_num=( 2 + ( udg_current_wave / 3 ) )
                    set udg_reward_regen_Copy[udg_X]=( udg_reward_regen_Copy[udg_X] + ( I2R(udg_temp_num) * 5.00 ) )
                    call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff808080-10 Armor|r for |cff008000+" + ( I2S(( udg_temp_num * 5 )) + " Health Regen|r" ) ) ))
                else
                    if ( Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006Func005C() ) then
                        set udg_temp_num=( 25 + R2I(( I2R(udg_current_wave) * 8.50 )) )
                        set udg_MSInt[udg_X]=( udg_MSInt[udg_X] - 3 )
                        call SetUnitMoveSpeed(udg_NICKHeroArray[udg_X], ( ( I2R(udg_MSInt[udg_X]) * 25.00 ) + 300.00 ))
                        call BlzSetUnitBaseDamage(udg_NICKHeroArray[udg_X], ( BlzGetUnitBaseDamage(udg_NICKHeroArray[udg_X], 0) + udg_temp_num ), 0)
                        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff008080-75 Movement Speed|r for |cffff5e19+" + ( I2S(udg_temp_num) + " Base Damage|r" ) ) ))
                    else
                        if ( Trig_Sacrifice_stats_for_reward_Func003Func005Func001Func006Func005Func006C() ) then
                            set udg_temp_real=GetUnitManaPercent(udg_NICKHeroArray[udg_X])
                            call BlzSetUnitMaxMana(udg_NICKHeroArray[udg_X], ( BlzGetUnitMaxMana(udg_NICKHeroArray[udg_X]) / 2 ))
                            call SetUnitManaPercentBJ(udg_NICKHeroArray[udg_X], udg_temp_real)
                            set udg_temp_num=( ( ( udg_current_wave / 5 ) + 1 ) * 4 )
                            set udg_reward_upsummons[( udg_Y + 2 )]=( udg_reward_upsummons[( udg_Y + 2 )] + udg_temp_num )
                            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff006f9e1/2 Max Mana|r for |cff80ff80+" + ( I2S(( udg_temp_num * 10 )) + " Summon Damage|r" ) ) ))
                        else
                        endif
                    endif
                endif
            endif
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Sacrifice_stats_for_reward takes nothing returns nothing
    set gg_trg_Sacrifice_stats_for_reward=CreateTrigger()
    call TriggerAddAction(gg_trg_Sacrifice_stats_for_reward, function Trig_Sacrifice_stats_for_reward_Actions)
endfunction

//===========================================================================
// Trigger: Expensive Item
//===========================================================================
function Trig_Expensive_Item_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func003Func003Func001C takes nothing returns boolean
    if ( not ( UnitItemInSlotBJ(udg_NICKHeroArray[udg_X], GetForLoopIndexA()) == null ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func003Func004C takes nothing returns boolean
    if ( not ( udg_temp_bol == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func003Func005C takes nothing returns boolean
    if ( not ( udg_current_wave <= 28 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func003Func008C takes nothing returns boolean
    if ( not ( udg_current_wave <= 28 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expensive_Item_Actions takes nothing returns nothing
    if ( Trig_Expensive_Item_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Expensive_Item_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Expensive_Item_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Expensive_Item_Func003C() ) then
        call CreateItemLoc(ChooseRandomItemExBJ(1, ITEM_TYPE_PERMANENT), GetRectCenter(GetPlayableMapRect()))
        set udg_reward_expensiveitem_Copy[udg_X]=GetItemTypeId(GetLastCreatedItem())
        if ( Trig_Expensive_Item_Func003Func008C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, ( ( "|cff0045ff" + GetItemName(GetLastCreatedItem()) ) + "|n|cff707370+10 Level Difficulty|r" ))
        else
            call DialogAddButtonBJ(udg_reward_dialog, ( ( "|cff0045ff" + GetItemName(GetLastCreatedItem()) ) + "|r" ))
        endif
        call RemoveItem(GetLastCreatedItem())
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        call CreateItemLoc(udg_reward_expensiveitem_Copy[udg_X], GetRectCenter(gg_rct_item_spawn))
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=6
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_Expensive_Item_Func003Func003Func001C() ) then
                set udg_temp_bol=true
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        if ( Trig_Expensive_Item_Func003Func004C() ) then
            call UnitAddItemSwapped(GetLastCreatedItem(), udg_NICKHeroArray[udg_X])
        else
        endif
        if ( Trig_Expensive_Item_Func003Func005C() ) then
            call AdjustPlayerStateBJ(10, ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff0045ff" + ( GetItemName(GetLastCreatedItem()) + " / |cff707370+10 Level Difficulty|r" ) ) ))
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=4
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
                call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff0045ff" + GetItemName(GetLastCreatedItem()) ) ))
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Expensive_Item takes nothing returns nothing
    set gg_trg_Expensive_Item=CreateTrigger()
    call TriggerAddAction(gg_trg_Expensive_Item, function Trig_Expensive_Item_Actions)
endfunction

//===========================================================================
// Trigger: Cheap Item
//===========================================================================
function Trig_Cheap_Item_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Func003Func011Func001C takes nothing returns boolean
    if ( not ( UnitItemInSlotBJ(udg_NICKHeroArray[udg_X], GetForLoopIndexA()) == null ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Func003Func012C takes nothing returns boolean
    if ( not ( udg_temp_bol == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cheap_Item_Actions takes nothing returns nothing
    if ( Trig_Cheap_Item_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Cheap_Item_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Cheap_Item_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Cheap_Item_Func003C() ) then
        set udg_temp_num=( 1 + ( udg_current_wave / 3 ) )
        set udg_chance=GetRandomInt(1, 22)
        call CreateItemLoc(udg_Draft_item_options1[udg_chance], GetRectCenter(GetPlayableMapRect()))
        call DialogAddButtonBJ(udg_reward_dialog, ( ( "|cff00a1aax" + I2S(udg_temp_num) ) + ( " " + GetItemName(GetLastCreatedItem()) ) ))
        set udg_reward_cheapitem_Copy[udg_X]=GetItemTypeId(GetLastCreatedItem())
        call RemoveItem(GetLastCreatedItem())
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        set udg_temp_num=( 1 + ( udg_current_wave / 3 ) )
        call CreateItemLoc(udg_reward_cheapitem_Copy[udg_X], GetRectCenter(gg_rct_item_spawn))
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( ( " has chosen |cff00a1aax" + I2S(udg_temp_num) ) + ( " " + GetItemName(GetLastCreatedItem()) ) ) ))
        call SetItemCharges(GetLastCreatedItem(), udg_temp_num)
        set udg_temp_bol=false
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=6
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_Cheap_Item_Func003Func011Func001C() ) then
                set udg_temp_bol=true
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        if ( Trig_Cheap_Item_Func003Func012C() ) then
            call UnitAddItemSwapped(GetLastCreatedItem(), udg_NICKHeroArray[udg_X])
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Cheap_Item takes nothing returns nothing
    set gg_trg_Cheap_Item=CreateTrigger()
    call TriggerAddAction(gg_trg_Cheap_Item, function Trig_Cheap_Item_Actions)
endfunction

//===========================================================================
// Trigger: Summon Units
//===========================================================================
function Trig_Summon_Units_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func007Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func007Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Summon_Units_Actions takes nothing returns nothing
    if ( Trig_Summon_Units_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Summon_Units_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Summon_Units_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Summon_Units_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
        if ( Trig_Summon_Units_Func003Func007C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, ( "|cffe42828Three " + ( I2S(( 200 + ( 75 * udg_current_wave ) )) + ( " HP " + ( I2S(( 10 + ( 6 * udg_current_wave ) )) + " DMG summons" ) ) ) ))
        else
            if ( Trig_Summon_Units_Func003Func007Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cffe42828Two " + ( I2S(( 300 + ( 100 * udg_current_wave ) )) + ( " HP " + ( I2S(( 15 + ( 12 * udg_current_wave ) )) + " DMG summons" ) ) ) ))
            else
                if ( Trig_Summon_Units_Func003Func007Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cffe42828One " + ( I2S(( 500 + ( 150 * udg_current_wave ) )) + ( " HP " + ( I2S(( 20 + ( 18 * udg_current_wave ) )) + " DMG summon" ) ) ) ))
                else
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Summon_Units_Func003Func002C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen " + ( "|cffe42828Three " + ( I2S(( ( 75 * udg_current_wave ) + 200 )) + ( " HP +" + ( I2S(( 10 + ( udg_current_wave * 6 ) )) + " DMG summons|r" ) ) ) ) ) ))
            set udg_unit_type_temp=ChooseRandomCreepBJ(GetRandomInt(1, 2))
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=3
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call CreateNUnitsAtLoc(1, udg_unit_type_temp, ConvertedPlayer(udg_X), GetRectCenter(gg_rct_item_spawn), bj_UNIT_FACING)
                call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( 200 + ( udg_current_wave * 75 ) ))
                call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100)
                call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 10 + ( udg_current_wave * 6 ) ), 0)
                call UnitApplyTimedLifeBJ(10.00, 'BEfn', GetLastCreatedUnit())
                call UnitPauseTimedLifeBJ(true, GetLastCreatedUnit())
                call BlzSetUnitArmor(GetLastCreatedUnit(), ( BlzGetUnitArmor(GetLastCreatedUnit()) + 4.00 ))
                call UnitRemoveTypeBJ(UNIT_TYPE_PEON, GetLastCreatedUnit())
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        if ( Trig_Summon_Units_Func003Func003C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen " + ( "|cffe42828Two " + ( I2S(( ( 100 * udg_current_wave ) + 300 )) + ( " HP +" + ( I2S(( 15 + ( udg_current_wave * 12 ) )) + " DMG summons|r" ) ) ) ) ) ))
            set udg_unit_type_temp=ChooseRandomCreepBJ(GetRandomInt(3, 4))
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call CreateNUnitsAtLoc(1, udg_unit_type_temp, ConvertedPlayer(udg_X), GetRectCenter(gg_rct_item_spawn), bj_UNIT_FACING)
                call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( 300 + ( udg_current_wave * 100 ) ))
                call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100)
                call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 15 + ( udg_current_wave * 12 ) ), 0)
                call UnitApplyTimedLifeBJ(10.00, 'BEfn', GetLastCreatedUnit())
                call UnitPauseTimedLifeBJ(true, GetLastCreatedUnit())
                call BlzSetUnitArmor(GetLastCreatedUnit(), ( BlzGetUnitArmor(GetLastCreatedUnit()) + 7.00 ))
                call UnitRemoveTypeBJ(UNIT_TYPE_PEON, GetLastCreatedUnit())
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        if ( Trig_Summon_Units_Func003Func004C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen " + ( "|cffe42828One " + ( I2S(( ( 150 * udg_current_wave ) + 500 )) + ( " HP +" + ( I2S(( 20 + ( udg_current_wave * 18 ) )) + " DMG summon|r" ) ) ) ) ) ))
            set udg_unit_type_temp=ChooseRandomCreepBJ(GetRandomInt(5, 7))
            set bj_forLoopAIndex=1
            set bj_forLoopAIndexEnd=1
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call CreateNUnitsAtLoc(1, udg_unit_type_temp, ConvertedPlayer(udg_X), GetRectCenter(gg_rct_item_spawn), bj_UNIT_FACING)
                call BlzSetUnitMaxHP(GetLastCreatedUnit(), ( 500 + ( udg_current_wave * 150 ) ))
                call SetUnitLifePercentBJ(GetLastCreatedUnit(), 100)
                call BlzSetUnitBaseDamage(GetLastCreatedUnit(), ( 20 + ( udg_current_wave * 18 ) ), 0)
                call UnitApplyTimedLifeBJ(10.00, 'BEfn', GetLastCreatedUnit())
                call UnitPauseTimedLifeBJ(true, GetLastCreatedUnit())
                call BlzSetUnitArmor(GetLastCreatedUnit(), ( BlzGetUnitArmor(GetLastCreatedUnit()) + 10.00 ))
                call UnitRemoveTypeBJ(UNIT_TYPE_PEON, GetLastCreatedUnit())
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Summon_Units takes nothing returns nothing
    set gg_trg_Summon_Units=CreateTrigger()
    call TriggerAddAction(gg_trg_Summon_Units, function Trig_Summon_Units_Actions)
endfunction

//===========================================================================
// Trigger: Upgrade Pillar
//===========================================================================
function Trig_Upgrade_Pillar_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func008Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func008Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func008Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func008Func002C takes nothing returns boolean
    if ( not ( GetUnitLifePercent(gg_unit_n02S_0002) >= 50.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003Func008C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Pillar_Actions takes nothing returns nothing
    if ( Trig_Upgrade_Pillar_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Upgrade_Pillar_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Upgrade_Pillar_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Upgrade_Pillar_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 4)
        if ( Trig_Upgrade_Pillar_Func003Func008C() ) then
            if ( Trig_Upgrade_Pillar_Func003Func008Func002C() ) then
                set udg_r_temp_num=( udg_r_temp_num - 1 )
            else
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_1223")
                set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
            endif
        else
            if ( Trig_Upgrade_Pillar_Func003Func008Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_264")
                set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
            else
                if ( Trig_Upgrade_Pillar_Func003Func008Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_2026")
                    set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
                else
                    if ( Trig_Upgrade_Pillar_Func003Func008Func001Func001Func001C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_945")
                        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
                    else
                    endif
                endif
            endif
        endif
    else
        // Click Button
        if ( Trig_Upgrade_Pillar_Func003Func002C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff00ff00+75% Missing Health for Pillar|r" ))
            call SetUnitLifePercentBJ(gg_unit_n02S_0002, ( GetUnitLifePercent(gg_unit_n02S_0002) + ( ( 100.00 - GetUnitLifePercent(gg_unit_n02S_0002) ) * 0.75 ) ))
        else
        endif
        if ( Trig_Upgrade_Pillar_Func003Func003C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff00ff00+40% Bonus HP for Pillar|r" ))
            set udg_temp_real=( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, gg_unit_n02S_0002) * 0.40 )
            call BlzSetUnitMaxHP(gg_unit_n02S_0002, ( BlzGetUnitMaxHP(gg_unit_n02S_0002) + R2I(udg_temp_real) ))
            call SetUnitLifeBJ(gg_unit_n02S_0002, ( GetUnitStateSwap(UNIT_STATE_LIFE, gg_unit_n02S_0002) + udg_temp_real ))
        else
        endif
        if ( Trig_Upgrade_Pillar_Func003Func004C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cffa0a0a0+20% Return Damage for Pillar|r" ))
            set udg_reward_returndmg_pillar=( udg_reward_returndmg_pillar + 1 )
        else
        endif
        if ( Trig_Upgrade_Pillar_Func003Func005C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cffaf6ff8+5 Mana Regen for Pillar|r" ))
            set udg_reward_manaregen_pillar=( udg_reward_manaregen_pillar + 5.00 )
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Upgrade_Pillar takes nothing returns nothing
    set gg_trg_Upgrade_Pillar=CreateTrigger()
    call TriggerAddAction(gg_trg_Upgrade_Pillar, function Trig_Upgrade_Pillar_Actions)
endfunction

//===========================================================================
// Trigger: Movement Speed Bonus
//===========================================================================
function Trig_Movement_Speed_Bonus_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Movement_Speed_Bonus_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Movement_Speed_Bonus_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Movement_Speed_Bonus_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Movement_Speed_Bonus_Actions takes nothing returns nothing
    if ( Trig_Movement_Speed_Bonus_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Movement_Speed_Bonus_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Movement_Speed_Bonus_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Movement_Speed_Bonus_Func003C() ) then
        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10463")
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        set udg_MSInt[udg_X]=( udg_MSInt[udg_X] + 1 )
        call SetUnitMoveSpeed(udg_NICKHeroArray[udg_X], ( ( I2R(udg_MSInt[udg_X]) * 25.00 ) + 300.00 ))
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cffbcffff+25 Movement Speed|r" ))
    endif
endfunction

//===========================================================================
function InitTrig_Movement_Speed_Bonus takes nothing returns nothing
    set gg_trg_Movement_Speed_Bonus=CreateTrigger()
    call TriggerAddAction(gg_trg_Movement_Speed_Bonus, function Trig_Movement_Speed_Bonus_Actions)
endfunction

//===========================================================================
// Trigger: Reduce Difficulty Level
//===========================================================================
function Trig_Reduce_Difficulty_Level_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_Difficulty_Level_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_Difficulty_Level_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_Difficulty_Level_Func003Func001Func001C takes nothing returns boolean
    if ( ( GetPlayerState(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED) < ( udg_current_wave + 15 ) ) ) then
        return true
    endif
    if ( ( udg_current_wave > 42 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Reduce_Difficulty_Level_Func003Func001C takes nothing returns boolean
    if ( not Trig_Reduce_Difficulty_Level_Func003Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_Difficulty_Level_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_Difficulty_Level_Actions takes nothing returns nothing
    if ( Trig_Reduce_Difficulty_Level_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Reduce_Difficulty_Level_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Reduce_Difficulty_Level_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Reduce_Difficulty_Level_Func003C() ) then
        if ( Trig_Reduce_Difficulty_Level_Func003Func001C() ) then
            set udg_r_temp_num=( udg_r_temp_num - 1 )
        else
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_10420")
            set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
        endif
    else
        // Click Button
        call SetPlayerStateBJ(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED, ( GetPlayerState(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED) - ( GetPlayerState(ConvertedPlayer(udg_X), PLAYER_STATE_RESOURCE_FOOD_USED) / 4 ) ))
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cffff8080-25% Mob Difficulty Level|r" ))
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(1), PLAYER_STATE_RESOURCE_FOOD_USED) + ( GetPlayerState(Player(2), PLAYER_STATE_RESOURCE_FOOD_USED) + GetPlayerState(Player(3), PLAYER_STATE_RESOURCE_FOOD_USED) ) ) ))
            call BlzFrameSetText(TLiveT[bj_forLoopAIndex], I2S(GetPlayerState(Player(bj_forLoopAIndex - 1), PLAYER_STATE_RESOURCE_FOOD_USED)))
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_Reduce_Difficulty_Level takes nothing returns nothing
    set gg_trg_Reduce_Difficulty_Level=CreateTrigger()
    call TriggerAddAction(gg_trg_Reduce_Difficulty_Level, function Trig_Reduce_Difficulty_Level_Actions)
endfunction

//===========================================================================
// Trigger: Gain stats per level
//===========================================================================
function Trig_Gain_stats_per_level_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func006C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func009Func001Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func009Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003Func009C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_stats_per_level_Actions takes nothing returns nothing
    if ( Trig_Gain_stats_per_level_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Gain_stats_per_level_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Gain_stats_per_level_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Gain_stats_per_level_Func003C() ) then
        set udg_temp_num=( 1 + ( udg_current_wave / 9 ) )
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
        if ( Trig_Gain_stats_per_level_Func003Func009C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, ( "|cff00ffff+" + ( I2S(udg_temp_num) + " Strength per Level|r" ) ))
        else
            if ( Trig_Gain_stats_per_level_Func003Func009Func001C() ) then
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cff00ffff+" + ( I2S(udg_temp_num) + " Intelligence per Level|r" ) ))
            else
                if ( Trig_Gain_stats_per_level_Func003Func009Func001Func001C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cff00ffff+" + ( I2S(udg_temp_num) + " Agility per Level|r" ) ))
                else
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        set udg_temp_int=( 1 + ( udg_current_wave / 9 ) )
        if ( Trig_Gain_stats_per_level_Func003Func004C() ) then
            set udg_reward_stats_perlvl[( udg_Y + 1 )]=( udg_reward_stats_perlvl[( udg_Y + 1 )] + udg_temp_int )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff00ffff+" + ( I2S(udg_temp_int) + " Strength per Level|r" ) ) ))
        else
        endif
        if ( Trig_Gain_stats_per_level_Func003Func005C() ) then
            set udg_reward_stats_perlvl[( udg_Y + 2 )]=( udg_reward_stats_perlvl[( udg_Y + 2 )] + udg_temp_int )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff00ffff+" + ( I2S(udg_temp_int) + " Intelligence per Level|r" ) ) ))
        else
        endif
        if ( Trig_Gain_stats_per_level_Func003Func006C() ) then
            set udg_reward_stats_perlvl[( udg_Y + 3 )]=( udg_reward_stats_perlvl[( udg_Y + 3 )] + udg_temp_int )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff00ffff+" + ( I2S(udg_temp_int) + " Agility per Level|r" ) ) ))
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Gain_stats_per_level takes nothing returns nothing
    set gg_trg_Gain_stats_per_level=CreateTrigger()
    call TriggerAddAction(gg_trg_Gain_stats_per_level, function Trig_Gain_stats_per_level_Actions)
endfunction

//===========================================================================
// Trigger: Gain Spell Damage
//===========================================================================
function Trig_Gain_Spell_Damage_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func007Func001Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func007Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gain_Spell_Damage_Actions takes nothing returns nothing
    if ( Trig_Gain_Spell_Damage_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Gain_Spell_Damage_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Gain_Spell_Damage_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Gain_Spell_Damage_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 3)
        if ( Trig_Gain_Spell_Damage_Func003Func007C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_6826")
        else
            if ( Trig_Gain_Spell_Damage_Func003Func007Func001C() ) then
                set udg_temp_num=( 5 * ( 1 + R2I(( I2R(udg_current_wave) * 0.65 )) ) )
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cffff00ff+" + ( I2S(udg_temp_num) + " Spell Damage|r" ) ))
            else
                if ( Trig_Gain_Spell_Damage_Func003Func007Func001Func002C() ) then
                    call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_460")
                else
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Gain_Spell_Damage_Func003Func002C() ) then
            set udg_reward_spelldmg[( udg_Y + 1 )]=( udg_reward_spelldmg[( udg_Y + 1 )] + 0.20 )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffc311ff+20% Spell Damage|r" ) ))
        else
        endif
        if ( Trig_Gain_Spell_Damage_Func003Func003C() ) then
            set udg_temp_num=( 5 * ( 1 + R2I(( I2R(udg_current_wave) * 0.65 )) ) )
            set udg_reward_spelldmg[( udg_Y + 2 )]=( udg_reward_spelldmg[( udg_Y + 2 )] + I2R(udg_temp_num) )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cffff00ff+" + ( I2S(udg_temp_num) + " Spell Damage|r" ) ) ))
        else
        endif
        if ( Trig_Gain_Spell_Damage_Func003Func004C() ) then
            set udg_reward_spelldmg[( udg_Y + 1 )]=( udg_reward_spelldmg[( udg_Y + 1 )] + ( udg_spelldamage[udg_X] * 0.15 ) )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cffc311ffx1.15 Spell Damage (%)|r" ))
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Gain_Spell_Damage takes nothing returns nothing
    set gg_trg_Gain_Spell_Damage=CreateTrigger()
    call TriggerAddAction(gg_trg_Gain_Spell_Damage, function Trig_Gain_Spell_Damage_Actions)
endfunction

//===========================================================================
// Trigger: Upgrade Summons
//===========================================================================
function Trig_Upgrade_Summons_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func005C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func008Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func008Func001Func002C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func008Func001C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003Func008C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Summons_Actions takes nothing returns nothing
    if ( Trig_Upgrade_Summons_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Upgrade_Summons_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Upgrade_Summons_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Upgrade_Summons_Func003C() ) then
        set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 4)
        if ( Trig_Upgrade_Summons_Func003Func008C() ) then
            call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_8516")
        else
            if ( Trig_Upgrade_Summons_Func003Func008Func001C() ) then
                set udg_temp_num=( 1 + ( udg_current_wave / 4 ) )
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cff80ff80+" + ( I2S(( udg_temp_num * 10 )) + " Summons Damage|r" ) ))
            else
                if ( Trig_Upgrade_Summons_Func003Func008Func001Func002C() ) then
                    set udg_temp_num=( 1 + ( udg_current_wave / 6 ) )
                    call DialogAddButtonBJ(udg_reward_dialog, ( "|cff80ff80+" + ( I2S(( udg_temp_num * 150 )) + " Bonus Hp Summons|r" ) ))
                else
                    if ( Trig_Upgrade_Summons_Func003Func008Func001Func002Func001C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog, "TRIGSTR_633")
                    else
                    endif
                endif
            endif
        endif
        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
    else
        // Click Button
        if ( Trig_Upgrade_Summons_Func003Func002C() ) then
            set udg_reward_upsummons[( udg_Y + 1 )]=( udg_reward_upsummons[( udg_Y + 1 )] + 40 )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff80ff80+40% Summons Damage|r" ))
        else
        endif
        if ( Trig_Upgrade_Summons_Func003Func003C() ) then
            set udg_temp_num=( 1 + ( udg_current_wave / 4 ) )
            set udg_reward_upsummons[( udg_Y + 2 )]=( udg_reward_upsummons[( udg_Y + 2 )] + udg_temp_num )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff80ff80+" + ( I2S(( udg_temp_num * 10 )) + " Summons Damage|r" ) ) ))
        else
        endif
        if ( Trig_Upgrade_Summons_Func003Func004C() ) then
            set udg_temp_num=( 1 + ( udg_current_wave / 6 ) )
            set udg_reward_upsummons[( udg_Y + 3 )]=( udg_reward_upsummons[( udg_Y + 3 )] + udg_temp_num )
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff80ff80+" + ( I2S(( udg_temp_num * 150 )) + " Bonus Hp Summons|r" ) ) ))
        else
        endif
        if ( Trig_Upgrade_Summons_Func003Func005C() ) then
            set udg_reward_upsummons[( udg_Y + 1 )]=R2I(( ( ( I2R(udg_reward_upsummons[( udg_Y + 1 )]) + 100.00 ) * 1.25 ) - 100.00 ))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + " has chosen |cff80ff80x1.25 Summons Damage (%)|r" ))
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Upgrade_Summons takes nothing returns nothing
    set gg_trg_Upgrade_Summons=CreateTrigger()
    call TriggerAddAction(gg_trg_Upgrade_Summons, function Trig_Upgrade_Summons_Actions)
endfunction

//===========================================================================
// Trigger: Learn Ability
//===========================================================================
function Trig_Learn_Ability_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func002Func010Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_X == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func002Func010Func001Func001C takes nothing returns boolean
    if ( not ( udg_X == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func002Func010Func001C takes nothing returns boolean
    if ( not ( udg_X == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func002Func010C takes nothing returns boolean
    if ( not ( udg_X == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func002C takes nothing returns boolean
    if ( not ( udg_RetrainNr[udg_X] == - 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func002Func001C takes nothing returns boolean
    if ( not ( LoadStringBJ(GetForLoopIndexA(), udg_X, udg_Hotkey_Htable) == ( udg_Abilities[udg_chance] + ( " " + udg_Hotkeys[GetForLoopIndexA()] ) ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func003Func001C takes nothing returns boolean
    if ( not ( udg_chance == udg_reward_learn_option_taken[GetForLoopIndexA()] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func001C takes nothing returns boolean
    if ( not ( udg_X == 1 ) ) then
        return false
    endif
    if ( not ( udg_AbilLearned1[udg_chance] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func002C takes nothing returns boolean
    if ( not ( udg_X == 2 ) ) then
        return false
    endif
    if ( not ( udg_AbilLearned2[udg_chance] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func003C takes nothing returns boolean
    if ( not ( udg_X == 3 ) ) then
        return false
    endif
    if ( not ( udg_AbilLearned3[udg_chance] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func004C takes nothing returns boolean
    if ( not ( udg_X == 4 ) ) then
        return false
    endif
    if ( not ( udg_AbilLearned4[udg_chance] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002C takes nothing returns boolean
    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func001C() ) then
        return true
    endif
    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func002C() ) then
        return true
    endif
    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func003C() ) then
        return true
    endif
    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002Func004C() ) then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func004C takes nothing returns boolean
    if ( not Trig_Learn_Ability_Func003Func003Func006Func002Func004Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func005C takes nothing returns boolean
    if ( not ( IsUnitType(udg_NICKHeroArray[udg_X], UNIT_TYPE_RANGED_ATTACKER) == true ) ) then
        return false
    endif
    if ( not ( udg_chance == 84 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002Func006C takes nothing returns boolean
    if ( not ( udg_temp_bol == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003Func006Func002C takes nothing returns boolean
    if ( not ( udg_Abilities_Items[udg_chance] == GetItemTypeId(null) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003Func003C takes nothing returns boolean
    if ( not ( udg_maxabilities_counter[udg_X] == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Actions takes nothing returns nothing
    if ( Trig_Learn_Ability_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Learn_Ability_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Learn_Ability_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Learn_Ability_Func003C() ) then
        if ( Trig_Learn_Ability_Func003Func003C() ) then
            set udg_RetrainNr[udg_X]=GetRandomInt(0, 6)
            set udg_reward_retrainnr_taken[udg_r_temp_num]=udg_RetrainNr[udg_X]
            set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(udg_RetrainNr[udg_X], udg_X, udg_maxabilities)]
            set udg_temp_string=SubStringBJ(GetAbilityName(udg_temp_Ability), 1, ( StringLength(GetAbilityName(udg_temp_Ability)) - 2 ))
            call DialogAddButtonBJ(udg_reward_dialog, ( "|cf0ff4f06Unlearn " + ( udg_temp_string + "|r" ) ))
            set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
        else
            set udg_temp_int=1
            loop
                exitwhen udg_temp_int > 1
                set udg_chance=GetRandomInt(1, udg_NumberOfAbilities)
                if ( Trig_Learn_Ability_Func003Func003Func006Func002C() ) then
                    set udg_temp_int=( udg_temp_int - 1 )
                else
                    set udg_temp_bol=false
                    set bj_forLoopAIndex=0
                    set bj_forLoopAIndexEnd=6
                    loop
                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                        if ( Trig_Learn_Ability_Func003Func003Func006Func002Func002Func001C() ) then
                            set udg_temp_bol=true
                        else
                        endif
                        set bj_forLoopAIndex=bj_forLoopAIndex + 1
                    endloop
                    set bj_forLoopAIndex=( ( udg_X * 10 ) + 1 )
                    set bj_forLoopAIndexEnd=udg_r_temp_num
                    loop
                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                        if ( Trig_Learn_Ability_Func003Func003Func006Func002Func003Func001C() ) then
                            set udg_temp_bol=true
                        else
                        endif
                        set bj_forLoopAIndex=bj_forLoopAIndex + 1
                    endloop
                    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func004C() ) then
                        set udg_temp_bol=true
                    else
                    endif
                    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func005C() ) then
                        set udg_temp_bol=true
                    else
                    endif
                    if ( Trig_Learn_Ability_Func003Func003Func006Func002Func006C() ) then
                        set udg_reward_list_randomnum[udg_r_temp_num]=udg_chance
                        call DialogAddButtonBJ(udg_reward_dialog, ( "|cffffff00Learn " + udg_Abilities[udg_reward_list_randomnum[udg_r_temp_num]] ))
                        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
                        set udg_reward_learn_option_taken[udg_r_temp_num]=udg_chance
                    else
                        set udg_temp_int=( udg_temp_int - 1 )
                    endif
                endif
                set udg_temp_int=udg_temp_int + 1
            endloop
        endif
    else
        // Click Button
        if ( Trig_Learn_Ability_Func003Func002C() ) then
            call UnitAddItemByIdSwapped(udg_Abilities_Items[udg_reward_list_randomnum[udg_reward_chosenbutton_num]], udg_NICKHeroArray[udg_X])
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " learned |c00FFFF00" + ( udg_Abilities[udg_reward_list_randomnum[udg_r_temp_num]] + "|r" ) ) ))
            if ( Trig_Learn_Ability_Func003Func002Func010C() ) then
                set udg_AbilLearned1[udg_reward_list_randomnum[udg_reward_chosenbutton_num]]=1
            else
                if ( Trig_Learn_Ability_Func003Func002Func010Func001C() ) then
                    set udg_AbilLearned2[udg_reward_list_randomnum[udg_reward_chosenbutton_num]]=1
                else
                    if ( Trig_Learn_Ability_Func003Func002Func010Func001Func001C() ) then
                        set udg_AbilLearned3[udg_reward_list_randomnum[udg_reward_chosenbutton_num]]=1
                    else
                        if ( Trig_Learn_Ability_Func003Func002Func010Func001Func001Func001C() ) then
                            set udg_AbilLearned4[udg_reward_list_randomnum[udg_reward_chosenbutton_num]]=1
                        else
                        endif
                    endif
                endif
            endif
        else
            set udg_RetrainNr[udg_X]=udg_reward_retrainnr_taken[udg_reward_chosenbutton_num]
            set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(udg_RetrainNr[udg_X], udg_X, udg_maxabilities)]
            set udg_temp_string=SubStringBJ(GetAbilityName(udg_temp_Ability), 1, ( StringLength(GetAbilityName(udg_temp_Ability)) - 2 ))
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " unlearned |c00FFFF00" + ( udg_temp_string + "|r" ) ) ))
            call UnitAddItemByIdSwapped('tret', udg_NICKHeroArray[udg_X])
            call TriggerExecute(gg_trg_Tome_of_Retraining)
            call TriggerSleepAction(0.10)
            set udg_RetrainNr[udg_X]=- 1
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Learn_Ability takes nothing returns nothing
    set gg_trg_Learn_Ability=CreateTrigger()
    call TriggerAddAction(gg_trg_Learn_Ability, function Trig_Learn_Ability_Actions)
endfunction

//===========================================================================
// Trigger: Upgrade Ability
//===========================================================================
function Trig_Upgrade_Ability_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func001Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], udg_NICKHeroArray[udg_X]) <= 9 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], udg_NICKHeroArray[udg_X]) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func001Func003Func004Func007C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func001Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_r_temp_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func001Func003C takes nothing returns boolean
    if ( not ( udg_temp_num > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func001C takes nothing returns boolean
    if ( not ( udg_maxabilities_counter[udg_X] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func003Func001Func001Func004C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_temp_Ability, udg_NICKHeroArray[udg_X]) < 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func003Func001Func001C takes nothing returns boolean
    if ( not ( GetForLoopIndexA() == udg_UpAbil[udg_X] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func003C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func004Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], udg_NICKHeroArray[udg_X]) <= 9 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], udg_NICKHeroArray[udg_X]) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003Func004C takes nothing returns boolean
    if ( not ( udg_reward_list_randomnum[udg_reward_chosenbutton_num] == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Upgrade_Ability_Actions takes nothing returns nothing
    if ( Trig_Upgrade_Ability_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Upgrade_Ability_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Upgrade_Ability_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Upgrade_Ability_Func003C() ) then
        if ( Trig_Upgrade_Ability_Func003Func001C() ) then
            set udg_temp_num=0
            set bj_forLoopAIndex=0
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Upgrade_Ability_Func003Func001Func002Func001C() ) then
                    set udg_IntArray[udg_temp_num]=GetForLoopIndexA()
                    set udg_temp_Abilities_1[udg_temp_num]=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)]
                    set udg_temp_num=( udg_temp_num + 1 )
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
            if ( Trig_Upgrade_Ability_Func003Func001Func003C() ) then
                set udg_reward_list_randomnum[udg_r_temp_num]=GetRandomInt(1, 2)
                if ( Trig_Upgrade_Ability_Func003Func001Func003Func004C() ) then
                    set udg_chance=GetRandomInt(0, ( udg_temp_num - 1 ))
                    set udg_reward_list_randomnum2[udg_r_temp_num]=udg_chance
                    set udg_temp_Ability=udg_temp_Abilities_1[udg_chance]
                    call DialogAddButtonBJ(udg_reward_dialog_Copy[udg_X], ( "|cffffff00x2 Upgrade " + SubStringBJ(GetAbilityName(udg_temp_Ability), 1, ( StringLength(GetAbilityName(udg_temp_Ability)) - 2 )) ))
                    set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
                    set udg_UpAbil[udg_X]=udg_IntArray[udg_chance]
                else
                    if ( Trig_Upgrade_Ability_Func003Func001Func003Func004Func007C() ) then
                        call DialogAddButtonBJ(udg_reward_dialog_Copy[udg_X], "TRIGSTR_10439")
                        set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
                    else
                    endif
                endif
            else
                set udg_r_temp_num=( udg_r_temp_num - 1 )
            endif
        else
            set udg_r_temp_num=( udg_r_temp_num - 1 )
        endif
    else
        // Click Button
        if ( Trig_Upgrade_Ability_Func003Func003C() ) then
            set bj_forLoopAIndex=0
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Upgrade_Ability_Func003Func003Func001Func001C() ) then
                    set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)]
                    call IncUnitAbilityLevelSwapped(udg_temp_Ability, udg_NICKHeroArray[udg_X])
                    if ( Trig_Upgrade_Ability_Func003Func003Func001Func001Func004C() ) then
                        call IncUnitAbilityLevelSwapped(udg_temp_Ability, udg_NICKHeroArray[udg_X])
                    else
                    endif
                    call AddAbility(Player(udg_X - 1) , bj_forLoopAIndex + 1 , udg_temp_Ability)
                    call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |c00FFFF00x2 Upgrade " + ( SubStringBJ(GetAbilityName(udg_temp_Ability), 1, ( StringLength(GetAbilityName(udg_temp_Ability)) - 2 )) + "|r" ) ) ))
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        if ( Trig_Upgrade_Ability_Func003Func004C() ) then
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |c00FFFF00Upgrade " + ( "All Abilities|r" ) ) ))
            set bj_forLoopAIndex=0
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Upgrade_Ability_Func003Func004Func002Func001C() ) then
                    set udg_temp_Ability=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)]
                    call IncUnitAbilityLevelSwapped(udg_temp_Ability, udg_NICKHeroArray[udg_X])
                    call AddAbility(Player(udg_X - 1) , bj_forLoopAIndex + 1 , udg_temp_Ability)
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
        else
        endif
        set udg_UpAbil[udg_X]=- 1
    endif
endfunction

//===========================================================================
function InitTrig_Upgrade_Ability takes nothing returns nothing
    set gg_trg_Upgrade_Ability=CreateTrigger()
    call TriggerAddAction(gg_trg_Upgrade_Ability, function Trig_Upgrade_Ability_Actions)
endfunction

//===========================================================================
// Trigger: Reduce CD Ability
//===========================================================================
function Trig_Reduce_CD_Ability_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func001Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 30 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func001C takes nothing returns boolean
    if ( not ( udg_r_temp_num < 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func003Func001Func002Func001C takes nothing returns boolean
    if ( not ( BlzGetAbilityManaCost(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], 2) > 0 ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped(udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)], udg_NICKHeroArray[udg_X]) > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func003Func001Func003C takes nothing returns boolean
    if ( not ( udg_temp_num > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func003Func001C takes nothing returns boolean
    if ( not ( udg_maxabilities_counter[udg_X] > 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Func003C takes nothing returns boolean
    if ( not ( udg_reward_chosenbutton_num == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reduce_CD_Ability_Actions takes nothing returns nothing
    if ( Trig_Reduce_CD_Ability_Func001C() ) then
        set udg_reward_dialog=udg_reward_dialog_Copy[1]
        set udg_X=1
        set udg_Y=10
    else
        if ( Trig_Reduce_CD_Ability_Func001Func001C() ) then
            set udg_reward_dialog=udg_reward_dialog_Copy[2]
            set udg_X=2
            set udg_Y=20
        else
            if ( Trig_Reduce_CD_Ability_Func001Func001Func001C() ) then
                set udg_reward_dialog=udg_reward_dialog_Copy[3]
                set udg_X=3
                set udg_Y=30
            else
                set udg_reward_dialog=udg_reward_dialog_Copy[4]
                set udg_X=4
                set udg_Y=40
            endif
        endif
    endif
    // Create Button
    if ( Trig_Reduce_CD_Ability_Func003C() ) then
        if ( Trig_Reduce_CD_Ability_Func003Func001C() ) then
            set udg_temp_num=0
            set bj_forLoopAIndex=0
            set bj_forLoopAIndexEnd=6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Reduce_CD_Ability_Func003Func001Func002Func001C() ) then
                    set udg_temp_Abilities_1[udg_temp_num]=udg_Hotkey_Abilities[LoadIntegerBJ(GetForLoopIndexA(), udg_X, udg_maxabilities)]
                    set udg_temp_num=( udg_temp_num + 1 )
                else
                endif
                set bj_forLoopAIndex=bj_forLoopAIndex + 1
            endloop
            if ( Trig_Reduce_CD_Ability_Func003Func001Func003C() ) then
                set udg_chance=GetRandomInt(0, ( udg_temp_num - 1 ))
                set udg_reward_list_randomnum2[udg_r_temp_num]=udg_chance
                set udg_reward_cd_ability_Copy[udg_X]=udg_temp_Abilities_1[udg_chance]
                call DialogAddButtonBJ(udg_reward_dialog, ( "|cff36a5be-33% Cooldown for " + SubStringBJ(GetAbilityName(udg_reward_cd_ability_Copy[udg_X]), 1, ( StringLength(GetAbilityName(udg_reward_cd_ability_Copy[udg_X])) - 2 )) ))
                set udg_reward_dialog_button[udg_r_temp_num]=GetLastCreatedButtonBJ()
            else
                set udg_r_temp_num=( udg_r_temp_num - 1 )
            endif
        else
            set udg_r_temp_num=( udg_r_temp_num - 1 )
        endif
    else
        // Click Button
        set bj_forLoopBIndex=0
        set bj_forLoopBIndexEnd=11
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call BlzSetAbilityRealLevelFieldBJ(BlzGetUnitAbility(udg_NICKHeroArray[udg_X], udg_reward_cd_ability_Copy[udg_X]), ABILITY_RLF_COOLDOWN, GetForLoopIndexB(), ( BlzGetUnitAbilityCooldown(udg_NICKHeroArray[udg_X], udg_reward_cd_ability_Copy[udg_X], GetForLoopIndexB()) * 0.33 ))
            set bj_forLoopBIndex=bj_forLoopBIndex + 1
        endloop
        call DisplayTimedTextToForce(GetPlayersAll(), 10.00, ( udg_Pcolorname[udg_X] + ( " has chosen |cff36a5be-33% Cooldown for " + ( SubStringBJ(GetAbilityName(udg_reward_cd_ability_Copy[udg_X]), 1, ( StringLength(GetAbilityName(udg_reward_cd_ability_Copy[udg_X])) - 2 )) + "|r" ) ) ))
        call BlzStartUnitAbilityCooldown(udg_NICKHeroArray[udg_X], udg_reward_cd_ability_Copy[udg_X], ( BlzGetUnitAbilityCooldownRemaining(udg_NICKHeroArray[udg_X], udg_reward_cd_ability_Copy[udg_X]) * 0.66 ))
    endif
endfunction

//===========================================================================
function InitTrig_Reduce_CD_Ability takes nothing returns nothing
    set gg_trg_Reduce_CD_Ability=CreateTrigger()
    call TriggerAddAction(gg_trg_Reduce_CD_Ability, function Trig_Reduce_CD_Ability_Actions)
endfunction

//===========================================================================
// Trigger: goldshare
//===========================================================================
function Trig_goldshare_Func002Func001C takes nothing returns boolean
    if ( not ( GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD) > R2I(udg_PGold[GetConvertedPlayerId(GetEnumPlayer())]) ) ) then
        return false
    endif
    return true
endfunction

function Trig_goldshare_Func002A takes nothing returns nothing
    if ( Trig_goldshare_Func002Func001C() ) then
        set udg_temp_real=( udg_temp_real + ( ( I2R(GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)) - udg_PGold[GetConvertedPlayerId(GetEnumPlayer())] ) / I2R(udg_Pint) ) )
    else
    endif
endfunction

function Trig_goldshare_Func003Func001A takes nothing returns nothing
    set udg_PGold[GetConvertedPlayerId(GetEnumPlayer())]=( udg_temp_real + udg_PGold[GetConvertedPlayerId(GetEnumPlayer())] )
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, R2I(udg_PGold[GetConvertedPlayerId(GetEnumPlayer())]))
endfunction

function Trig_goldshare_Func003C takes nothing returns boolean
    if ( not ( udg_temp_real >= 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_goldshare_Actions takes nothing returns nothing
    set udg_temp_real=0.00
    call ForForce(udg_Activeplayers, function Trig_goldshare_Func002A)
    if ( Trig_goldshare_Func003C() ) then
        call ForForce(udg_Activeplayers, function Trig_goldshare_Func003Func001A)
    else
    endif
endfunction

//===========================================================================
function InitTrig_goldshare takes nothing returns nothing
    set gg_trg_goldshare=CreateTrigger()
    call DisableTrigger(gg_trg_goldshare)
    call TriggerRegisterTimerEventPeriodic(gg_trg_goldshare, 0.03)
    call TriggerAddAction(gg_trg_goldshare, function Trig_goldshare_Actions)
endfunction

//===========================================================================
// Trigger: Item bought from obelisk
//===========================================================================
function Trig_Item_bought_from_obelisk_Actions takes nothing returns nothing
    set udg_PGold[GetConvertedPlayerId(GetOwningPlayer(GetBuyingUnit()))]=I2R(GetPlayerState(GetOwningPlayer(GetBuyingUnit()), PLAYER_STATE_RESOURCE_GOLD))
endfunction

//===========================================================================
function InitTrig_Item_bought_from_obelisk takes nothing returns nothing
    set gg_trg_Item_bought_from_obelisk=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_bought_from_obelisk, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddAction(gg_trg_Item_bought_from_obelisk, function Trig_Item_bought_from_obelisk_Actions)
endfunction

//===========================================================================
// Trigger: Item Sold
//===========================================================================
function Trig_Item_Sold_Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I048' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Sold_Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I02B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Sold_Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'azhr' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Sold_Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'rugt' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Sold_Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'mlst' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_Sold_Actions takes nothing returns nothing
    if ( Trig_Item_Sold_Func001C() ) then
        set udg_item_6[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))]=0
        call DestroyEffectBJ(udg_item_6_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))])
    else
        if ( Trig_Item_Sold_Func001Func001C() ) then
            set udg_stormhammer[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))]=0
            call DestroyEffectBJ(udg_stormhammer_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))])
        else
            if ( Trig_Item_Sold_Func001Func001Func001C() ) then
                set udg_item_9[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))]=0
                call DestroyEffectBJ(udg_item_9_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))])
            else
                if ( Trig_Item_Sold_Func001Func001Func001Func001C() ) then
                    set udg_item_35[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))]=0
                    call DestroyEffectBJ(udg_item_35_SpecialEffect[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))])
                else
                    if ( Trig_Item_Sold_Func001Func001Func001Func001Func001C() ) then
                        call DestroyEffectBJ(udg_item_energy_staff[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))])
                        set udg_NICKWandofSorcery[GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))]=0
                    else
                    endif
                endif
            endif
        endif
    endif
    call StartTimerBJ(udg_GStimer, false, 0.00)
endfunction

//===========================================================================
function InitTrig_Item_Sold takes nothing returns nothing
    set gg_trg_Item_Sold=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Sold, EVENT_PLAYER_UNIT_PAWN_ITEM)
    call TriggerAddAction(gg_trg_Item_Sold, function Trig_Item_Sold_Actions)
endfunction

//===========================================================================
// Trigger: SetGoldValue
//===========================================================================
function Trig_SetGoldValue_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_PGold[GetForLoopIndexA()]=I2R(GetPlayerState(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_GOLD))
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_SetGoldValue takes nothing returns nothing
    set gg_trg_SetGoldValue=CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ(gg_trg_SetGoldValue, udg_GStimer)
    call TriggerAddAction(gg_trg_SetGoldValue, function Trig_SetGoldValue_Actions)
endfunction

//===========================================================================
// Trigger: Ending start
//===========================================================================
function Trig_Ending_start_Func058Func001C takes nothing returns boolean
    if ( not ( udg_temp_bol == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ending_start_Actions takes nothing returns nothing
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_USED, 666)
        call SetPlayerStateBJ(ConvertedPlayer(GetForLoopIndexA()), PLAYER_STATE_RESOURCE_FOOD_CAP, 666)
        call BlzFrameSetText(TLiveT[bj_forLoopAIndex], " ")
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call SetTimeOfDayScalePercentBJ(0.00)
    call SetTimeOfDay(24.00)
    call DisableTrigger(gg_trg_Walls)
    call DisableTrigger(gg_trg_lose_condition)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=100
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call DestroyEffectBJ(udg_walls_effect[GetForLoopIndexA()])
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call SetUnitInvulnerable(gg_unit_n02S_0002, true)
    call PauseTimerBJ(true, udg_wavesDecay_timer)
    call PauseTimerBJ(true, udg_wavesDecay_warning_timer)
    call DestroyTimerDialogBJ(udg_wavesDecay_timer_window)
    call CinematicModeBJ(true, GetPlayersAll())
    call ClearTextMessagesBJ(GetPlayersAll())
    call LeaderboardDisplayBJ(false, GetLastCreatedLeaderboard())
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_MUSIC, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_AMBIENTSOUNDS, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_SPELLS, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_COMBAT, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_FIRE, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_UNITMOVEMENT, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_UNITSOUNDS, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_UI, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_GENERAL, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_AMBIENT, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_MUSIC, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_DIALOGUE, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_1, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_2, 0.00)
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_3, 0.00)
    call BlzHideOriginFrames(true)
    call BlzFrameSetVisible(BlzGetFrameByName("ConsoleUIBackdrop", 0), false)
    call BlzFrameSetVisible(BlzGetFrameByName("CinematicBottomBorder", 0), false)
    call BlzFrameSetVisible(BlzGetFrameByName("CinematicTopBorder", 0), false)
    call SetUserControlForceOff(GetPlayersAll())
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 0.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0, 0, 0, 0)
    call TriggerSleepAction(7.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_555")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_795")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2625")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2660")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_12092")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_10444")
    call TriggerSleepAction(10.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_12090")
    call TriggerSleepAction(15.00)
    call SetUserControlForceOn(GetPlayersAll())
    call DialogClearBJ(udg_ending_dialog)
    call DialogSetMessageBJ(udg_ending_dialog, "TRIGSTR_12093")
    call DialogAddButtonBJ(udg_ending_dialog, "TRIGSTR_12094")
    set udg_ending_dialog_button[1]=GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(udg_ending_dialog, "TRIGSTR_12095")
    set udg_ending_dialog_button[2]=GetLastCreatedButtonBJ()
    set udg_temp_bol=true
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Ending_start_Func058Func001C() ) then
            set udg_temp_bol=false
            call DialogDisplayBJ(true, udg_ending_dialog, ConvertedPlayer(GetForLoopIndexA()))
        else
        endif
        call SetUnitPositionLoc(udg_NICKHeroArray[GetForLoopIndexA()], PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(400.00, 900.00), GetRandomDirectionDeg()))
        call SetUnitLifePercentBJ(udg_NICKHeroArray[GetForLoopIndexA()], 4.00)
        call SetUnitInvulnerable(udg_NICKHeroArray[GetForLoopIndexA()], false)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call AddUnitAnimationPropertiesBJ(true, "work", gg_unit_n02S_0002)
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'FDrh')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call SetTerrainFogExBJ(0, 100.00, 5000.00, 0.40, 100, 0.00, 0.00)
    call SetDayNightModels("Environment\\DNC\\DNCDungeon\\DNCDungeonTerrain\\DNCDungeonTerrain.mdl", "Environment\\DNC\\DNCDungeon\\DNCDungeonUnit\\DNCDungeonUnit.mdl")
endfunction

//===========================================================================
function InitTrig_Ending_start takes nothing returns nothing
    set gg_trg_Ending_start=CreateTrigger()
    call TriggerAddAction(gg_trg_Ending_start, function Trig_Ending_start_Actions)
endfunction

//===========================================================================
// Trigger: Ending button clicked
//===========================================================================
function Trig_Ending_button_clicked_Func006C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_ending_dialog_button[1] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ending_button_clicked_Func007C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_ending_dialog_button[2] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ending_button_clicked_Actions takes nothing returns nothing
    call SetUserControlForceOff(GetPlayersAll())
    call DialogDisplayBJ(false, udg_ending_dialog, Player(0))
    call DialogDisplayBJ(false, udg_ending_dialog, Player(1))
    call DialogDisplayBJ(false, udg_ending_dialog, Player(2))
    call DialogDisplayBJ(false, udg_ending_dialog, Player(3))
    if ( Trig_Ending_button_clicked_Func006C() ) then
        call TriggerSleepAction(3.00)
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_12096")
        call TriggerSleepAction(10.00)
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call CreateNUnitsAtLoc(1, 'h000', ConvertedPlayer(GetForLoopIndexA()), GetRectCenter(GetPlayableMapRect()), bj_UNIT_FACING)
            call UnitAddItemByIdSwapped('I03M', GetLastCreatedUnit())
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
    else
    endif
    if ( Trig_Ending_button_clicked_Func007C() ) then
        call TriggerSleepAction(3.00)
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_12097")
        call TriggerSleepAction(5.00)
        call ConditionalTriggerExecute(gg_trg_Ending_2_start)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Ending_button_clicked takes nothing returns nothing
    set gg_trg_Ending_button_clicked=CreateTrigger()
    call TriggerRegisterDialogEventBJ(gg_trg_Ending_button_clicked, udg_ending_dialog)
    call TriggerAddAction(gg_trg_Ending_button_clicked, function Trig_Ending_button_clicked_Actions)
endfunction

//===========================================================================
// Trigger: Ending 2 start
//===========================================================================
function Trig_Ending_2_start_Func001Func004Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitBooleanField(GetLastCreatedUnit(), UNIT_BF_RAISABLE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ending_2_start_Func001Func005C takes nothing returns boolean
    if ( not ( BlzGetUnitBooleanField(GetLastCreatedUnit(), UNIT_BF_RAISABLE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ending_2_start_Actions takes nothing returns nothing
    set bj_forLoopBIndex=1
    set bj_forLoopBIndexEnd=60
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(100.00, 2000.00), I2R(( GetForLoopIndexB() * 6 )))
        call CreateCorpseLocBJ(ChooseRandomCreepBJ(GetRandomInt(1, 10)), Player(20), udg_TP)
        call RemoveLocation(udg_TP)
        set bj_forLoopAIndex=1
        set bj_forLoopAIndexEnd=10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_Ending_2_start_Func001Func004Func001C() ) then
                call RemoveUnit(GetLastCreatedUnit())
                set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(100.00, 2000.00), I2R(( GetForLoopIndexB() * 6 )))
                call CreateCorpseLocBJ(ChooseRandomCreepBJ(GetRandomInt(1, 10)), Player(20), udg_TP)
                call RemoveLocation(udg_TP)
            else
            endif
            set bj_forLoopAIndex=bj_forLoopAIndex + 1
        endloop
        if ( Trig_Ending_2_start_Func001Func005C() ) then
            call RemoveUnit(GetLastCreatedUnit())
            set udg_TP=PolarProjectionBJ(GetUnitLoc(gg_unit_n02S_0002), GetRandomReal(100.00, 2000.00), I2R(( GetForLoopIndexB() * 6 )))
            call CreateCorpseLocBJ('hcth', Player(20), udg_TP)
            call RemoveLocation(udg_TP)
        else
        endif
        set bj_forLoopBIndex=bj_forLoopBIndex + 1
    endloop
    call TriggerSleepAction(60.00)
    call PlaySoundBJ(gg_snd_One_Eternity_Later)
    call CinematicFilterGenericBJ(0.00, BLEND_MODE_BLEND, "war3mapImported\\687.blp", 100, 100.00, 100.00, 0.00, 100.00, 100.00, 100.00, 0.00)
    call DisplayCineFilterBJ(true)
    call TriggerSleepAction(3.00)
    call VolumeGroupResetBJ()
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_MUSIC, 0.00)
    call SetUserControlForceOn(GetPlayersAll())
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 0.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0, 0, 0, 0)
    call LeaderboardDisplayBJ(true, GetLastCreatedLeaderboard())
    call LeaderboardSetPlayerItemLabelBJ(Player(0), GetLastCreatedLeaderboard(), "TRIGSTR_12099")
    call LeaderboardSetPlayerItemLabelBJ(Player(1), GetLastCreatedLeaderboard(), "TRIGSTR_7450")
    call LeaderboardSetPlayerItemLabelBJ(Player(2), GetLastCreatedLeaderboard(), "TRIGSTR_7471")
    call LeaderboardSetPlayerItemLabelBJ(Player(3), GetLastCreatedLeaderboard(), "TRIGSTR_7472")
    call BlzHideOriginFrames(false)
    call BlzFrameSetVisible(BlzGetFrameByName("ConsoleUIBackdrop", 0), true)
    call CinematicModeBJ(false, GetPlayersAll())
    call TriggerSleepAction(1.00)
    call DisplayCineFilterBJ(false)
    call ConditionalTriggerExecute(gg_trg_Ending_pillar_channel)
    call TriggerSleepAction(3.00)
    call PlaySoundBJ(gg_snd_LichKingTheme)
endfunction

//===========================================================================
function InitTrig_Ending_2_start takes nothing returns nothing
    set gg_trg_Ending_2_start=CreateTrigger()
    call TriggerAddAction(gg_trg_Ending_2_start, function Trig_Ending_2_start_Actions)
endfunction

//===========================================================================
// Trigger: Ending pillar channel
//===========================================================================
function Trig_Ending_pillar_channel_Actions takes nothing returns nothing
    call SetPlayerAllianceStateBJ(Player(20), Player(21), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(Player(21), Player(20), bj_ALLIANCE_ALLIED_VISION)
    call DisableTrigger(gg_trg_lose_condition)
    call DisableTrigger(gg_trg_Walls)
    set udg_end_boss_sound[1]=gg_snd_ObsidianAvengerPissed1
    set udg_end_boss_sound[2]=gg_snd_ObsidianStatueMorph
    set udg_end_boss_sound[3]=gg_snd_ObsidianStatueYes2
    set udg_end_boss_sound[4]=gg_snd_ObsidianStatueYes3
    call TriggerSleepAction(30.00)
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl")
    set udg_pillar_effect[1]=GetLastCreatedEffectBJ()
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 2.00)
    call BlzSetSpecialEffectZ(GetLastCreatedEffectBJ(), 1000.00)
    call TriggerSleepAction(7.00)
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "war3mapImported\\Mana Storm.mdx")
    set udg_pillar_effect[2]=GetLastCreatedEffectBJ()
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 2.00)
    call BlzSetSpecialEffectZ(GetLastCreatedEffectBJ(), - 50.00)
    call TriggerSleepAction(14.00)
    call StopSoundBJ(gg_snd_LichKingTheme, false)
    call PlaySoundBJ(gg_snd_Tension)
    call SetSpeechVolumeGroupsBJ()
    call SetAmbientDaySound("DungeonCaveDay")
    call SetAmbientNightSound("DungeonCaveNight")
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "war3mapImported\\IceTornado.mdx")
    set udg_pillar_effect[3]=GetLastCreatedEffectBJ()
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 2.00)
    call CameraSetEQNoiseForPlayer(Player(0), 3)
    call CameraSetEQNoiseForPlayer(Player(1), 3)
    call CameraSetEQNoiseForPlayer(Player(2), 3)
    call CameraSetEQNoiseForPlayer(Player(3), 3)
    call TriggerSleepAction(10.00)
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call TriggerSleepAction(2.00)
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_n02S_0002), "war3mapImported\\ArcaneExplosion.mdx")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call TriggerSleepAction(2.00)
    call ResetTerrainFogBJ()
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call TerrainDeformationCraterBJ(0.5, true, GetRectCenter(GetPlayableMapRect()), 512, 64)
    call SetTerrainTypeBJ(GetUnitLoc(gg_unit_n02S_0002), 'Nsnw', - 1, 5, 0)
    call SetBlightRadiusLocBJ(true, Player(20), GetUnitLoc(gg_unit_n02S_0002), 512)
    call CreateDestructableLoc('B007', GetUnitLoc(gg_unit_n02S_0002), GetRandomDirectionDeg(), 4.00, 0)
    set udg_end_voidtear=GetLastCreatedDestructable()
    call RemoveUnit(gg_unit_n02S_0002)
    call CameraClearNoiseForPlayer(Player(0))
    call CameraClearNoiseForPlayer(Player(1))
    call CameraClearNoiseForPlayer(Player(2))
    call CameraClearNoiseForPlayer(Player(3))
    call DestroyEffectBJ(udg_pillar_effect[1])
    call DestroyEffectBJ(udg_pillar_effect[2])
    call DestroyEffectBJ(udg_pillar_effect[3])
    call SetWaterBaseColorBJ(0.00, 0.00, 0.00, 0)
    call SetTerrainFogExBJ(0, 100.00, 4000.00, 0.40, 0.00, 0.00, 0.00)
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call TriggerSleepAction(3.00)
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call CreateFogModifierRectBJ(true, Player(0), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call TriggerSleepAction(30.00)
    call DisableTrigger(gg_trg_Creeps_Enter_Map)
    call CreateNUnitsAtLoc(1, 'h01T', Player(20), GetDestructableLoc(udg_end_voidtear), bj_UNIT_FACING)
    set udg_end_boss=GetLastCreatedUnit()
    call CameraSetEQNoiseForPlayer(Player(0), 2.00)
    call SetUnitAnimation(GetLastCreatedUnit(), "birth")
    call PlaySoundBJ(gg_snd_EarthquakeRock)
    call PlaySoundBJ(gg_snd_EarthquakeLoop1)
    call TriggerSleepAction(12.00)
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call TriggerSleepAction(6.00)
    call StopSoundBJ(gg_snd_EarthquakeLoop1, false)
    call RemoveDestructable(udg_end_voidtear)
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 0.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call QueueUnitAnimationBJ(udg_end_boss, "stand")
    call SetDayNightModels("Environment\\DNC\\DNCUnderground\\DNCUndergroundTerrain\\DNCUndergroundTerrain.mdl", "Environment\\DNC\\DNCUnderground\\DNCUndergroundUnit\\DNCUndergroundUnit.mdl")
    call TriggerSleepAction(6.00)
    call VolumeGroupResetBJ()
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_MUSIC, 0.00)
    call PlaySoundBJ(gg_snd_PH1)
    call TriggerSleepAction(6.00)
    call UnitRemoveAbilityBJ('Avul', udg_end_boss)
    call ConditionalTriggerExecute(gg_trg_end_boss_spell)
    call EnableTrigger(gg_trg_end_lose_condition)
    call EnableTrigger(gg_trg_Creeps_Enter_Map)
endfunction

//===========================================================================
function InitTrig_Ending_pillar_channel takes nothing returns nothing
    set gg_trg_Ending_pillar_channel=CreateTrigger()
    call TriggerAddAction(gg_trg_Ending_pillar_channel, function Trig_Ending_pillar_channel_Actions)
endfunction

//===========================================================================
// Trigger: end boss spell
//===========================================================================
function Trig_end_boss_spell_Conditions takes nothing returns boolean
    if ( not ( IsTriggerEnabled(GetTriggeringTrigger()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func007Func002C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func007Func004C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func007Func006C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func008Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[GetForLoopIndexA()]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func009Func002C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func009Func003C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func009C takes nothing returns boolean
    if ( not ( udg_end_spell_int >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func010Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_NICKHeroArray[udg_chance]) >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Func010C takes nothing returns boolean
    if ( not ( udg_end_spell_int >= 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_spell_Actions takes nothing returns nothing
    set udg_temp_Point=GetRectCenter(GetPlayableMapRect())
    call CreateNUnitsAtLoc(1, 'h000', Player(21), udg_temp_Point, GetRandomDirectionDeg())
    call UnitAddAbilityBJ('A0PF', GetLastCreatedUnit())
    call IssuePointOrderLocBJ(GetLastCreatedUnit(), "stampede", PolarProjectionBJ(GetUnitLoc(GetLastCreatedUnit()), 50.00, GetRandomDirectionDeg()))
    call UnitApplyTimedLifeBJ(20.00, 'BTLF', GetLastCreatedUnit())
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=udg_end_spell_int
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_chance=GetRandomInt(1, 4)
        if ( Trig_end_boss_spell_Func007Func002C() ) then
            set udg_TP=PolarProjectionBJ(GetUnitLoc(udg_NICKHeroArray[udg_chance]), GetRandomReal(100.00, 1000.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, 'h000', Player(21), udg_TP, GetRandomDirectionDeg())
            call RemoveLocation(udg_TP)
            call UnitAddAbilityBJ('A0PG', GetLastCreatedUnit())
            set udg_TP=PolarProjectionBJ(GetUnitLoc(GetLastCreatedUnit()), 50.00, GetRandomDirectionDeg())
            call IssuePointOrderLocBJ(GetLastCreatedUnit(), "flamestrike", udg_TP)
            call RemoveLocation(udg_TP)
            call UnitApplyTimedLifeBJ(10.00, 'BTLF', GetLastCreatedUnit())
        else
        endif
        set udg_chance=GetRandomInt(1, 4)
        if ( Trig_end_boss_spell_Func007Func004C() ) then
            set udg_TP=PolarProjectionBJ(GetUnitLoc(udg_NICKHeroArray[udg_chance]), GetRandomReal(100.00, 2000.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, 'h01U', Player(21), udg_TP, GetRandomDirectionDeg())
            call RemoveLocation(udg_TP)
            call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
        else
        endif
        set udg_chance=GetRandomInt(1, 4)
        if ( Trig_end_boss_spell_Func007Func006C() ) then
            set udg_TP=PolarProjectionBJ(GetUnitLoc(udg_NICKHeroArray[udg_chance]), GetRandomReal(100.00, 2000.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, 'h01U', Player(21), udg_TP, GetRandomDirectionDeg())
            call RemoveLocation(udg_TP)
            call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=4
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_end_boss_spell_Func008Func001C() ) then
            set bj_forLoopBIndex=1
            set bj_forLoopBIndexEnd=2
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_TP=PolarProjectionBJ(udg_temp_Point, GetRandomReal(100.00, 2000.00), GetRandomDirectionDeg())
                call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(- 1), Player(20), udg_TP, bj_UNIT_FACING)
                call RemoveLocation(udg_TP)
                call SetUnitVertexColorBJ(GetLastCreatedUnit(), 0.00, 0.00, 0.00, 30.00)
                call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
                call IssuePointOrderLocBJ(GetLastCreatedUnit(), "attack", GetUnitLoc(udg_NICKHeroArray[GetForLoopIndexA()]))
                set bj_forLoopBIndex=bj_forLoopBIndex + 1
            endloop
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if ( Trig_end_boss_spell_Func009C() ) then
        set udg_chance=GetRandomInt(1, 4)
        if ( Trig_end_boss_spell_Func009Func002C() ) then
            call SetUnitUserData(GetLastCreatedUnit(), 32)
            set udg_TP=PolarProjectionBJ(udg_temp_Point, GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(- 1), Player(20), udg_TP, bj_UNIT_FACING)
            call RemoveLocation(udg_TP)
            call SetUnitVertexColorBJ(GetLastCreatedUnit(), 0.00, 0.00, 0.00, 30.00)
            call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
            call IssuePointOrderLocBJ(GetLastCreatedUnit(), "attack", GetUnitLoc(udg_NICKHeroArray[udg_chance]))
        else
        endif
        if ( Trig_end_boss_spell_Func009Func003C() ) then
            set udg_TP=PolarProjectionBJ(udg_temp_Point, GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(- 1), Player(20), udg_TP, bj_UNIT_FACING)
            call RemoveLocation(udg_TP)
            call SetUnitUserData(GetLastCreatedUnit(), 32)
            call SetUnitVertexColorBJ(GetLastCreatedUnit(), 0.00, 0.00, 0.00, 30.00)
            call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
            call IssuePointOrderLocBJ(GetLastCreatedUnit(), "attack", GetUnitLoc(udg_NICKHeroArray[udg_chance]))
        else
        endif
    else
    endif
    if ( Trig_end_boss_spell_Func010C() ) then
        if ( Trig_end_boss_spell_Func010Func001C() ) then
            set udg_TP=PolarProjectionBJ(udg_temp_Point, GetRandomReal(2800.00, 3500.00), GetRandomDirectionDeg())
            call CreateNUnitsAtLoc(1, ChooseRandomCreepBJ(- 1), Player(20), udg_TP, bj_UNIT_FACING)
            call RemoveLocation(udg_TP)
            call SetUnitUserData(GetLastCreatedUnit(), 32)
            call SetUnitVertexColorBJ(GetLastCreatedUnit(), 0.00, 0.00, 0.00, 30.00)
            call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
            call IssuePointOrderLocBJ(GetLastCreatedUnit(), "attack", GetUnitLoc(udg_NICKHeroArray[udg_chance]))
        else
        endif
    else
    endif
    call RemoveLocation(udg_temp_Point)
    call TriggerSleepAction(20.00)
    call ConditionalTriggerExecute(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_end_boss_spell takes nothing returns nothing
    set gg_trg_end_boss_spell=CreateTrigger()
    call TriggerAddCondition(gg_trg_end_boss_spell, Condition(function Trig_end_boss_spell_Conditions))
    call TriggerAddAction(gg_trg_end_boss_spell, function Trig_end_boss_spell_Actions)
endfunction

//===========================================================================
// Trigger: end boss takes dmg
//===========================================================================
function Trig_end_boss_takes_dmg_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventTarget == udg_end_boss ) ) then
        return false
    endif
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventSource)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    if ( not ( udg_DamageEventAmount >= 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Func018C takes nothing returns boolean
    if ( not ( udg_end_spell_int == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Func019C takes nothing returns boolean
    if ( not ( udg_end_spell_int == 19 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Func020C takes nothing returns boolean
    if ( not ( GetUnitLifePercent(udg_end_boss) < 40.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Func021C takes nothing returns boolean
    if ( not ( udg_end_spell_int > 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Func022C takes nothing returns boolean
    if ( not ( udg_DamageEventAmount >= 500000.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_takes_dmg_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call TriggerSleepAction(6.00)
    call SetUnitAnimation(udg_end_boss, "spell")
    call QueueUnitAnimationBJ(udg_end_boss, "stand")
    call TriggerSleepAction(2)
    set udg_temp_Point=PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()), GetRandomReal(0, 3000.00), GetRandomDirectionDeg())
    set udg_TP=GetRectCenter(GetPlayableMapRect())
    call SetUnitPositionLocFacingLocBJ(udg_end_boss, udg_temp_Point, udg_TP)
    call RemoveLocation(udg_TP)
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=10
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TP=PolarProjectionBJ(udg_temp_Point, GetRandomReal(300.00, 600.00), GetRandomDirectionDeg())
        call CreateNUnitsAtLoc(1, 'h01U', Player(21), udg_TP, GetRandomDirectionDeg())
        call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit())
        call RemoveLocation(udg_TP)
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call RemoveLocation(udg_temp_Point)
    set udg_end_spell_int=( udg_end_spell_int + 1 )
    call PlaySoundBJ(udg_end_boss_sound[GetRandomInt(1, 4)])
    if ( Trig_end_boss_takes_dmg_Func018C() ) then
        call BlzSetUnitMaxHP(udg_end_boss, 1000000000)
        call SetUnitLifePercentBJ(udg_end_boss, 100.00)
        call BlzSetUnitRealFieldBJ(udg_end_boss, UNIT_RF_SELECTION_SCALE, 3.00)
    else
        set udg_DamageEventAmount=( udg_DamageEventAmount / 100000.00 )
    endif
    if ( Trig_end_boss_takes_dmg_Func019C() ) then
        call BlzSetUnitIntegerFieldBJ(udg_end_boss, UNIT_IF_DEFENSE_TYPE, 1)
    else
    endif
    if ( Trig_end_boss_takes_dmg_Func020C() ) then
        call SetUnitMoveSpeed(udg_end_boss, 190.00)
    else
    endif
    if ( Trig_end_boss_takes_dmg_Func021C() ) then
        set udg_end_spell_int=20
    else
    endif
    if ( Trig_end_boss_takes_dmg_Func022C() ) then
        set udg_DamageEventAmount=500000.00
    else
    endif
    call EnableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_end_boss_takes_dmg takes nothing returns nothing
    set gg_trg_end_boss_takes_dmg=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_end_boss_takes_dmg, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_end_boss_takes_dmg, Condition(function Trig_end_boss_takes_dmg_Conditions))
    call TriggerAddAction(gg_trg_end_boss_takes_dmg, function Trig_end_boss_takes_dmg_Actions)
endfunction

//===========================================================================
// Trigger: void trap effect
//===========================================================================
function Trig_void_trap_effect_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h01U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_void_trap_effect_Actions takes nothing returns nothing
    call RemoveUnit(udg_DamageEventSource)
    set udg_temp_Point=GetUnitLoc(udg_DamageEventSource)
    call AddSpecialEffectLocBJ(udg_temp_Point, "war3mapImported\\DarkNova.mdx")
    call RemoveLocation(udg_temp_Point)
    call BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 0.50)
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

//===========================================================================
function InitTrig_void_trap_effect takes nothing returns nothing
    set gg_trg_void_trap_effect=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_void_trap_effect, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_void_trap_effect, Condition(function Trig_void_trap_effect_Conditions))
    call TriggerAddAction(gg_trg_void_trap_effect, function Trig_void_trap_effect_Actions)
endfunction

//===========================================================================
// Trigger: end boss deals dammage
//===========================================================================
function Trig_end_boss_deals_dammage_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_DamageEventSource) == Player(21) ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_deals_dammage_Func001Func004C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetItemOfTypeFromUnitBJ(udg_DamageEventTarget, 'I019')) == 'I019' ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_deals_dammage_Func001C takes nothing returns boolean
    if ( not ( GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) == MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_deals_dammage_Actions takes nothing returns nothing
    if ( Trig_end_boss_deals_dammage_Func001C() ) then
        set udg_DamageEventAmount=( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, udg_DamageEventTarget) * 0.10 )
        if ( Trig_end_boss_deals_dammage_Func001Func004C() ) then
            set udg_DamageEventAmount=( udg_DamageEventAmount * 0.30 )
        else
        endif
    else
        set udg_DamageEventAmount=0.00
    endif
endfunction

//===========================================================================
function InitTrig_end_boss_deals_dammage takes nothing returns nothing
    set gg_trg_end_boss_deals_dammage=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_end_boss_deals_dammage, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_end_boss_deals_dammage, Condition(function Trig_end_boss_deals_dammage_Conditions))
    call TriggerAddAction(gg_trg_end_boss_deals_dammage, function Trig_end_boss_deals_dammage_Actions)
endfunction

//===========================================================================
// Trigger: end boss dies
//===========================================================================
function Trig_end_boss_dies_Conditions takes nothing returns boolean
    if ( not ( GetTriggerUnit() == udg_end_boss ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_boss_dies_Func017A takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_end_boss_dies_Func018A takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_end_boss_dies_Actions takes nothing returns nothing
    call PlaySoundBJ(gg_snd_QuestCompleted)
    call StopSoundBJ(gg_snd_PH1, false)
    call DisableTrigger(GetTriggeringTrigger())
    call CameraClearNoiseForPlayer(Player(0))
    call CameraClearNoiseForPlayer(Player(1))
    call CameraClearNoiseForPlayer(Player(2))
    call CameraClearNoiseForPlayer(Player(3))
    call SetSpeechVolumeGroupsBJ()
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_MUSIC, 0.00)
    call DisableTrigger(gg_trg_end_boss_spell)
    call SetUnitInvulnerable(udg_NICKHeroArray[1], true)
    call SetUnitInvulnerable(udg_NICKHeroArray[2], true)
    call SetUnitInvulnerable(udg_NICKHeroArray[3], true)
    call SetUnitInvulnerable(udg_NICKHeroArray[4], true)
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call TriggerSleepAction(6.00)
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(20)), function Trig_end_boss_dies_Func017A)
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(21)), function Trig_end_boss_dies_Func018A)
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call SetTimeOfDay(12)
    call ResetTerrainFogBJ()
    call SetWaterBaseColorBJ(100, 100, 100, 0)
    call RemoveWeatherEffectBJ(udg_weather_effect)
    call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'LRaa')
    call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
    set udg_weather_effect=GetLastCreatedWeatherEffect()
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0)
    call TriggerSleepAction(4.00)
    call VolumeGroupResetBJ()
    call VolumeGroupSetVolumeBJ(SOUND_VOLUMEGROUP_MUSIC, 0.00)
    call TriggerSleepAction(4.00)
    call PlaySoundBJ(gg_snd_HeroicVictory01)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_12112")
    call TriggerSleepAction(60.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
endfunction

//===========================================================================
function InitTrig_end_boss_dies takes nothing returns nothing
    set gg_trg_end_boss_dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_end_boss_dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_end_boss_dies, Condition(function Trig_end_boss_dies_Conditions))
    call TriggerAddAction(gg_trg_end_boss_dies, function Trig_end_boss_dies_Actions)
endfunction

//===========================================================================
// Trigger: end lose condition
//===========================================================================
function Trig_end_lose_condition_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_lose_condition_Func004Func011001001002001 takes nothing returns boolean
    return ( GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER )
endfunction

function Trig_end_lose_condition_Func004Func011001001002002001 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_end_lose_condition_Func004Func011001001002002002 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_end_lose_condition_Func004Func011001001002002 takes nothing returns boolean
    return GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)) // INLINED!!
endfunction

function Trig_end_lose_condition_Func004Func011001001002 takes nothing returns boolean
    return GetBooleanAnd((GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_USER), (GetBooleanAnd((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true), (IsUnitAliveBJ(GetFilterUnit()) == true)))) // INLINED!!
endfunction

function Trig_end_lose_condition_Func004C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_end_lose_condition_Func004Func011001001002))) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_end_lose_condition_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( "|cffff0000" + ( GetPlayerName(GetTriggerPlayer()) + "'s Hero has died!|r" ) ))
    set bj_wantDestroyGroup=true
    if ( Trig_end_lose_condition_Func004C() ) then
        call PlaySoundBJ(gg_snd_QuestFailed)
        call StopSoundBJ(gg_snd_PH1, false)
        call DisableTrigger(GetTriggeringTrigger())
        call TriggerSleepAction(2)
        call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 4.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100.00, 100.00, 100.00, 0)
        call TriggerSleepAction(6.00)
        call CustomDefeatBJ(Player(0), "TRIGSTR_229")
        call CustomDefeatBJ(Player(1), "TRIGSTR_236")
        call CustomDefeatBJ(Player(2), "TRIGSTR_262")
        call CustomDefeatBJ(Player(3), "TRIGSTR_1781")
    else
    endif
endfunction

//===========================================================================
function InitTrig_end_lose_condition takes nothing returns nothing
    set gg_trg_end_lose_condition=CreateTrigger()
    call DisableTrigger(gg_trg_end_lose_condition)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_end_lose_condition, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_end_lose_condition, Condition(function Trig_end_lose_condition_Conditions))
    call TriggerAddAction(gg_trg_end_lose_condition, function Trig_end_lose_condition_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_SLASHOnKill()
    call InitTrig_SLASHOnHit()
    call InitTrig_SLASHOnPick()
    call InitTrig_SLASHOnItem()
    call InitTrig_SLASHOnAbility()
    call InitTrig_SLASHLevelUp()
    call InitTrig_SLASHPeriodic()
    call InitTrig_on_damage_items()
    call InitTrig_on_summon_items()
    call InitTrig_Reward_Life_Steal()
    call InitTrig_SLASHAfterDamage()
    call InitTrig_SLASHSanta()
    call InitTrig_SLASHJaina1()
    call InitTrig_SLASHJaina2()
    call InitTrig_SLASHKael()
    call InitTrig_SLASHLock()
    call InitTrig_SLASHBossZerk()
    call InitTrig_SLASHWaveLoot()
    call InitTrig_Change_Item_Description()
    call InitTrig_Nick_Unit_starts_effect_of_an_ability()
    call InitTrig_Nick_Item_Acquired()
    call InitTrig_Nick_Item_Lost()
    call InitTrig_Nick_Periodic()
    call InitTrig_Damage_Engine_Config()
    //Function not found: call InitTrig_Damage_Engine()
    call InitTrig_SpellDMG_Check()
    call InitTrig_Key_Of_Balance()
    call InitTrig_Item_Used()
    call InitTrig_Infinity_Tome()
    call InitTrig_Staff_of_Lightning()
    call InitTrig_clear_drops()
    call InitTrig_Heart_of_Aszune()
    call InitTrig_Helm_of_Battlethirst()
    call InitTrig_Bloodfeathers_Heart()
    call InitTrig_Storm_Hammer()
    call InitTrig_Crown_of_the_Manalord()
    call InitTrig_Wand_of_Sorcery()
    call InitTrig_Skeletal_Rod()
    call InitTrig_Energy_Staff()
    call InitTrig_Energy_Staff_on_dmg()
    call InitTrig_Lightning_Javelin()
    call InitTrig_Orb_of_Fire()
    call InitTrig_Orb_of_Fire_on_dmg()
    call InitTrig_Orb_of_Corruption()
    call InitTrig_Searing_Blade_aura_taken()
    call InitTrig_Searing_Blade_aura_dies()
    call InitTrig_Tome_of_Heresy()
    call InitTrig_Sundering_Blade()
    call InitTrig_Cloak_of_Frost()
    call InitTrig_Power_Staff()
    call InitTrig_divinity_gauntlet()
    call InitTrig_divinity_gauntlet_periodic()
    call InitTrig_divinity_gauntlet_on_dmg()
    call InitTrig_Angry_Totem()
    call InitTrig_angry_totem_timer()
    call InitTrig_demonic_blade_init()
    call InitTrig_demonic_blade()
    call InitTrig_Mask_of_Death()
    call InitTrig_Claws_of_Frenzy()
    call InitTrig_Engulfing_Blade()
    call InitTrig_leave()
    call InitTrig_weather1()
    call InitTrig_weather2()
    call InitTrig_weather3()
    call InitTrig_weather4()
    call InitTrig_weather5()
    call InitTrig_weather6()
    call InitTrig_weather7()
    call InitTrig_weather8()
    call InitTrig_lose_condition()
    call InitTrig_Walls()
    call InitTrig_obelisk_takes_dmg()
    call InitTrig_obelisk_prevent_focus()
    call InitTrig_sound_deaths()
    call InitTrig_fel_spawns()
    call InitTrig_doodads()
    call InitTrig_doodads_die()
    call InitTrig_trigger_tk_prevent()
    call InitTrig_permanent_immo_bug_fix()
    call InitTrig_perm_immo_ability_effect()
    call InitTrig_illusion_stat_fix()
    call InitTrig_bonus_leveling_hero()
    call InitTrig_Tips()
    call InitTrig_Repair_Pillar_Item()
    call InitTrig_Item_Reroll()
    call InitTrig_set_random_heroes()
    call InitTrig_start()
    call InitTrig_Nick_Monitor_Heroes()
    call InitTrig_endpick()
    call InitTrig_afterpick()
    call InitTrig_wavesStart()
    call InitTrig_waves()
    call InitTrig_wave_units_spawn()
    call InitTrig_wave_clear()
    call InitTrig_wavesDecaywarningtimer()
    call InitTrig_wavesDecaytimer()
    call InitTrig_wavesDecay()
    call InitTrig_boss_spell_init()
    call InitTrig_boss_spell()
    call InitTrig_Creeps_Enter_Map()
    call InitTrig_Creeps_Get_Attacked()
    call InitTrig_Stronger_Creep_Abilities()
    call InitTrig_Order_Creeps_Obelisk()
    call InitTrig_Skip_command()
    call InitTrig_Hero_Info_command()
    call InitTrig_Continue_Command()
    call InitTrig_Kick_command()
    call InitTrig_clear_Command()
    call InitTrig_enum()
    call InitTrig_Swap_Commannd()
    call InitTrig_Floating_Text_dmg()
    call InitTrig_Floating_Text_periodic()
    call InitTrig_Set_Hotkey_Abilities()
    call InitTrig_Set_Hotkeys()
    call InitTrig_Hero_buys_Ability()
    call InitTrig_Hero_buys_Random_Ability()
    call InitTrig_Set_Abilities_and_Items()
    call InitTrig_Tome_of_Retraining()
    call InitTrig_Remove_Tomes()
    call InitTrig_Preload_Abilities()
    call InitTrig_Channeling_Spells_Cast()
    call InitTrig_Channeling_Spells_finish()
    call InitTrig_Move_Projectiles()
    call InitTrig_Return_Damage_Pillar()
    call InitTrig_frost_strike_init()
    call InitTrig_frost_strike()
    call InitTrig_frost_strike_dmg()
    call InitTrig_DraftStart()
    call InitTrig_Item_Stack()
    call InitTrig_InitMB()
    call InitTrig_Reward_Init()
    call InitTrig_Reward_Round()
    call InitTrig_Reward_Chosen()
    call InitTrig_RewardReroll()
    call InitTrig_Attribute_Rewards()
    call InitTrig_Base_Damage_Bonus()
    call InitTrig_Armor_Bonus()
    call InitTrig_Lifesteal_Bonus()
    call InitTrig_Attack_Cooldown_Reduction()
    call InitTrig_Spend_All_gold_for_reward()
    call InitTrig_Sacrifice_stats_for_reward()
    call InitTrig_Expensive_Item()
    call InitTrig_Cheap_Item()
    call InitTrig_Summon_Units()
    call InitTrig_Upgrade_Pillar()
    call InitTrig_Movement_Speed_Bonus()
    call InitTrig_Reduce_Difficulty_Level()
    call InitTrig_Gain_stats_per_level()
    call InitTrig_Gain_Spell_Damage()
    call InitTrig_Upgrade_Summons()
    call InitTrig_Learn_Ability()
    call InitTrig_Upgrade_Ability()
    call InitTrig_Reduce_CD_Ability()
    call InitTrig_goldshare()
    call InitTrig_Item_bought_from_obelisk()
    call InitTrig_Item_Sold()
    call InitTrig_SetGoldValue()
    call InitTrig_Ending_start()
    call InitTrig_Ending_button_clicked()
    call InitTrig_Ending_2_start()
    call InitTrig_Ending_pillar_channel()
    call InitTrig_end_boss_spell()
    call InitTrig_end_boss_takes_dmg()
    call InitTrig_void_trap_effect()
    call InitTrig_end_boss_deals_dammage()
    call InitTrig_end_boss_dies()
    call InitTrig_end_lose_condition()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Damage_Engine_Config)
    call ConditionalTriggerExecute(gg_trg_demonic_blade_init)
    call ConditionalTriggerExecute(gg_trg_doodads)
    call ConditionalTriggerExecute(gg_trg_Tips)
    call ConditionalTriggerExecute(gg_trg_set_random_heroes)
    call ConditionalTriggerExecute(gg_trg_start)
    call ConditionalTriggerExecute(gg_trg_boss_spell_init)
    call ConditionalTriggerExecute(gg_trg_Set_Hotkey_Abilities)
    call ConditionalTriggerExecute(gg_trg_Set_Hotkeys)
    call ConditionalTriggerExecute(gg_trg_Set_Abilities_and_Items)
    call ConditionalTriggerExecute(gg_trg_Preload_Abilities)
    call ConditionalTriggerExecute(gg_trg_frost_strike_init)
    call ConditionalTriggerExecute(gg_trg_Reward_Init)
endfunction

//***************************************************************************
//*
//*  Upgrades
//*
//***************************************************************************

function InitUpgrades_Player0 takes nothing returns nothing
    call SetPlayerTechResearched(Player(0), 'Rhde', 1)
    call SetPlayerTechResearched(Player(0), 'Rhpt', 2)
    call SetPlayerTechResearched(Player(0), 'Rhst', 2)
    call SetPlayerTechResearched(Player(0), 'Rhlh', 2)
    call SetPlayerTechResearched(Player(0), 'Rhse', 1)
    call SetPlayerTechResearched(Player(0), 'Rhrt', 1)
    call SetPlayerTechResearched(Player(0), 'Rhss', 1)
    call SetPlayerTechResearched(Player(0), 'Rhfl', 1)
    call SetPlayerTechResearched(Player(0), 'Rhfc', 1)
    call SetPlayerTechResearched(Player(0), 'Rhfs', 1)
    call SetPlayerTechResearched(Player(0), 'Rhcd', 1)
    call SetPlayerTechResearched(Player(0), 'Rwdm', 1)
    call SetPlayerTechResearched(Player(0), 'Rovs', 1)
    call SetPlayerTechResearched(Player(0), 'Roen', 1)
    call SetPlayerTechResearched(Player(0), 'Rowd', 2)
    call SetPlayerTechResearched(Player(0), 'Rolf', 1)
    call SetPlayerTechResearched(Player(0), 'Rost', 2)
    call SetPlayerTechResearched(Player(0), 'Rosp', 2)
    call SetPlayerTechResearched(Player(0), 'Rowt', 2)
    call SetPlayerTechResearched(Player(0), 'Rotr', 1)
    call SetPlayerTechResearched(Player(0), 'Robk', 1)
    call SetPlayerTechResearched(Player(0), 'Rorb', 1)
    call SetPlayerTechResearched(Player(0), 'Robs', 1)
    call SetPlayerTechResearched(Player(0), 'Rows', 1)
    call SetPlayerTechResearched(Player(0), 'Ruac', 1)
    call SetPlayerTechResearched(Player(0), 'Rugf', 1)
    call SetPlayerTechResearched(Player(0), 'Ruwb', 1)
    call SetPlayerTechResearched(Player(0), 'Rune', 2)
    call SetPlayerTechResearched(Player(0), 'Rusf', 1)
    call SetPlayerTechResearched(Player(0), 'Ruba', 2)
    call SetPlayerTechResearched(Player(0), 'Rufb', 1)
    call SetPlayerTechResearched(Player(0), 'Rusl', 1)
    call SetPlayerTechResearched(Player(0), 'Rusp', 1)
    call SetPlayerTechResearched(Player(0), 'Ruex', 1)
    call SetPlayerTechResearched(Player(0), 'Reuv', 1)
    call SetPlayerTechResearched(Player(0), 'Renb', 1)
    call SetPlayerTechResearched(Player(0), 'Remg', 1)
    call SetPlayerTechResearched(Player(0), 'Resc', 1)
    call SetPlayerTechResearched(Player(0), 'Reib', 1)
    call SetPlayerTechResearched(Player(0), 'Remk', 1)
    call SetPlayerTechResearched(Player(0), 'Redt', 2)
    call SetPlayerTechResearched(Player(0), 'Redc', 2)
    call SetPlayerTechResearched(Player(0), 'Resi', 1)
    call SetPlayerTechResearched(Player(0), 'Reht', 1)
    call SetPlayerTechResearched(Player(0), 'Repb', 1)
    call SetPlayerTechResearched(Player(0), 'Recb', 1)
    call SetPlayerTechResearched(Player(0), 'Rers', 1)
    call SetPlayerTechResearched(Player(0), 'Reeb', 1)
    call SetPlayerTechResearched(Player(0), 'Rehs', 1)
    call SetPlayerTechResearched(Player(0), 'Rews', 1)
    call SetPlayerTechResearched(Player(0), 'Reec', 1)
    call SetPlayerTechResearched(Player(0), 'Rnen', 1)
    call SetPlayerTechResearched(Player(0), 'Rnsw', 2)
    call SetPlayerTechResearched(Player(0), 'Rnsi', 1)
    call SetPlayerTechResearched(Player(0), 'Rnam', 3)
    call SetPlayerTechResearched(Player(0), 'Rnsb', 1)
    call SetPlayerTechMaxAllowed(Player(0), 'Rhpm', 0)
    call SetPlayerTechMaxAllowed(Player(0), 'Ropm', 0)
    call SetPlayerTechMaxAllowed(Player(0), 'Rupm', 0)
    call SetPlayerTechResearched(Player(0), 'Rnat', 3)
    call SetPlayerTechMaxAllowed(Player(0), 'Rupc', 0)
    call SetPlayerTechResearched(Player(0), 'Rusm', 1)
    call SetPlayerTechResearched(Player(0), 'Rhme', 3)
    call SetPlayerTechResearched(Player(0), 'Rhra', 3)
    call SetPlayerTechResearched(Player(0), 'Rhhb', 1)
    call SetPlayerTechResearched(Player(0), 'Rhar', 3)
    call SetPlayerTechResearched(Player(0), 'Rhgb', 1)
    call SetPlayerTechResearched(Player(0), 'Rhri', 1)
    call SetPlayerTechResearched(Player(0), 'Rhla', 3)
    call SetPlayerTechResearched(Player(0), 'Rhsb', 1)
    call SetPlayerTechResearched(Player(0), 'Rhac', 3)
    call SetPlayerTechResearched(Player(0), 'Rhan', 1)
    call SetPlayerTechResearched(Player(0), 'Rome', 3)
    call SetPlayerTechResearched(Player(0), 'Rora', 3)
    call SetPlayerTechResearched(Player(0), 'Roar', 3)
    call SetPlayerTechResearched(Player(0), 'Ropg', 1)
    call SetPlayerTechResearched(Player(0), 'Robf', 1)
    call SetPlayerTechResearched(Player(0), 'Rume', 3)
    call SetPlayerTechResearched(Player(0), 'Rura', 3)
    call SetPlayerTechResearched(Player(0), 'Ruar', 3)
    call SetPlayerTechResearched(Player(0), 'Rucr', 3)
    call SetPlayerTechResearched(Player(0), 'Rubu', 1)
    call SetPlayerTechResearched(Player(0), 'Resm', 3)
    call SetPlayerTechResearched(Player(0), 'Resw', 3)
    call SetPlayerTechResearched(Player(0), 'Rema', 3)
    call SetPlayerTechResearched(Player(0), 'Rerh', 3)
    call SetPlayerTechMaxAllowed(Player(0), 'Repm', 0)
endfunction

function InitUpgrades_Player1 takes nothing returns nothing
    call SetPlayerTechResearched(Player(1), 'Rhde', 1)
    call SetPlayerTechResearched(Player(1), 'Rhpt', 2)
    call SetPlayerTechResearched(Player(1), 'Rhst', 2)
    call SetPlayerTechResearched(Player(1), 'Rhlh', 2)
    call SetPlayerTechResearched(Player(1), 'Rhse', 1)
    call SetPlayerTechResearched(Player(1), 'Rhrt', 1)
    call SetPlayerTechResearched(Player(1), 'Rhss', 1)
    call SetPlayerTechResearched(Player(1), 'Rhfl', 1)
    call SetPlayerTechResearched(Player(1), 'Rhfc', 1)
    call SetPlayerTechResearched(Player(1), 'Rhfs', 1)
    call SetPlayerTechResearched(Player(1), 'Rhcd', 1)
    call SetPlayerTechResearched(Player(1), 'Rwdm', 1)
    call SetPlayerTechResearched(Player(1), 'Rovs', 1)
    call SetPlayerTechResearched(Player(1), 'Roen', 1)
    call SetPlayerTechResearched(Player(1), 'Rowd', 2)
    call SetPlayerTechResearched(Player(1), 'Rolf', 1)
    call SetPlayerTechResearched(Player(1), 'Rost', 2)
    call SetPlayerTechResearched(Player(1), 'Rosp', 2)
    call SetPlayerTechResearched(Player(1), 'Rowt', 2)
    call SetPlayerTechResearched(Player(1), 'Rotr', 1)
    call SetPlayerTechResearched(Player(1), 'Robk', 1)
    call SetPlayerTechResearched(Player(1), 'Rorb', 1)
    call SetPlayerTechResearched(Player(1), 'Robs', 1)
    call SetPlayerTechResearched(Player(1), 'Rows', 1)
    call SetPlayerTechResearched(Player(1), 'Ruac', 1)
    call SetPlayerTechResearched(Player(1), 'Rugf', 1)
    call SetPlayerTechResearched(Player(1), 'Ruwb', 1)
    call SetPlayerTechResearched(Player(1), 'Rune', 2)
    call SetPlayerTechResearched(Player(1), 'Rusf', 1)
    call SetPlayerTechResearched(Player(1), 'Ruba', 2)
    call SetPlayerTechResearched(Player(1), 'Rufb', 1)
    call SetPlayerTechResearched(Player(1), 'Rusl', 1)
    call SetPlayerTechResearched(Player(1), 'Rusp', 1)
    call SetPlayerTechResearched(Player(1), 'Ruex', 1)
    call SetPlayerTechResearched(Player(1), 'Reuv', 1)
    call SetPlayerTechResearched(Player(1), 'Renb', 1)
    call SetPlayerTechResearched(Player(1), 'Remg', 1)
    call SetPlayerTechResearched(Player(1), 'Resc', 1)
    call SetPlayerTechResearched(Player(1), 'Reib', 1)
    call SetPlayerTechResearched(Player(1), 'Remk', 1)
    call SetPlayerTechResearched(Player(1), 'Redt', 2)
    call SetPlayerTechResearched(Player(1), 'Redc', 2)
    call SetPlayerTechResearched(Player(1), 'Resi', 1)
    call SetPlayerTechResearched(Player(1), 'Reht', 1)
    call SetPlayerTechResearched(Player(1), 'Repb', 1)
    call SetPlayerTechResearched(Player(1), 'Recb', 1)
    call SetPlayerTechResearched(Player(1), 'Rers', 1)
    call SetPlayerTechResearched(Player(1), 'Reeb', 1)
    call SetPlayerTechResearched(Player(1), 'Rehs', 1)
    call SetPlayerTechResearched(Player(1), 'Rews', 1)
    call SetPlayerTechResearched(Player(1), 'Reec', 1)
    call SetPlayerTechResearched(Player(1), 'Rnen', 1)
    call SetPlayerTechResearched(Player(1), 'Rnsw', 2)
    call SetPlayerTechResearched(Player(1), 'Rnsi', 1)
    call SetPlayerTechResearched(Player(1), 'Rnam', 3)
    call SetPlayerTechResearched(Player(1), 'Rnsb', 1)
    call SetPlayerTechMaxAllowed(Player(1), 'Rhpm', 0)
    call SetPlayerTechMaxAllowed(Player(1), 'Ropm', 0)
    call SetPlayerTechMaxAllowed(Player(1), 'Rupm', 0)
    call SetPlayerTechResearched(Player(1), 'Rnat', 3)
    call SetPlayerTechMaxAllowed(Player(1), 'Rupc', 0)
    call SetPlayerTechResearched(Player(1), 'Rusm', 1)
    call SetPlayerTechResearched(Player(1), 'Rhme', 3)
    call SetPlayerTechResearched(Player(1), 'Rhra', 3)
    call SetPlayerTechResearched(Player(1), 'Rhhb', 1)
    call SetPlayerTechResearched(Player(1), 'Rhar', 3)
    call SetPlayerTechResearched(Player(1), 'Rhgb', 1)
    call SetPlayerTechResearched(Player(1), 'Rhri', 1)
    call SetPlayerTechResearched(Player(1), 'Rhla', 3)
    call SetPlayerTechResearched(Player(1), 'Rhsb', 1)
    call SetPlayerTechResearched(Player(1), 'Rhac', 3)
    call SetPlayerTechResearched(Player(1), 'Rhan', 1)
    call SetPlayerTechResearched(Player(1), 'Rome', 3)
    call SetPlayerTechResearched(Player(1), 'Rora', 3)
    call SetPlayerTechResearched(Player(1), 'Roar', 3)
    call SetPlayerTechResearched(Player(1), 'Ropg', 1)
    call SetPlayerTechResearched(Player(1), 'Robf', 1)
    call SetPlayerTechResearched(Player(1), 'Rume', 3)
    call SetPlayerTechResearched(Player(1), 'Rura', 3)
    call SetPlayerTechResearched(Player(1), 'Ruar', 3)
    call SetPlayerTechResearched(Player(1), 'Rucr', 3)
    call SetPlayerTechResearched(Player(1), 'Rubu', 1)
    call SetPlayerTechResearched(Player(1), 'Resm', 3)
    call SetPlayerTechResearched(Player(1), 'Resw', 3)
    call SetPlayerTechResearched(Player(1), 'Rema', 3)
    call SetPlayerTechResearched(Player(1), 'Rerh', 3)
    call SetPlayerTechMaxAllowed(Player(1), 'Repm', 0)
endfunction

function InitUpgrades_Player2 takes nothing returns nothing
    call SetPlayerTechResearched(Player(2), 'Rhde', 1)
    call SetPlayerTechResearched(Player(2), 'Rhpt', 2)
    call SetPlayerTechResearched(Player(2), 'Rhst', 2)
    call SetPlayerTechResearched(Player(2), 'Rhlh', 2)
    call SetPlayerTechResearched(Player(2), 'Rhse', 1)
    call SetPlayerTechResearched(Player(2), 'Rhrt', 1)
    call SetPlayerTechResearched(Player(2), 'Rhss', 1)
    call SetPlayerTechResearched(Player(2), 'Rhfl', 1)
    call SetPlayerTechResearched(Player(2), 'Rhfc', 1)
    call SetPlayerTechResearched(Player(2), 'Rhfs', 1)
    call SetPlayerTechResearched(Player(2), 'Rhcd', 1)
    call SetPlayerTechResearched(Player(2), 'Rwdm', 1)
    call SetPlayerTechResearched(Player(2), 'Rovs', 1)
    call SetPlayerTechResearched(Player(2), 'Roen', 1)
    call SetPlayerTechResearched(Player(2), 'Rowd', 2)
    call SetPlayerTechResearched(Player(2), 'Rolf', 1)
    call SetPlayerTechResearched(Player(2), 'Rost', 2)
    call SetPlayerTechResearched(Player(2), 'Rosp', 2)
    call SetPlayerTechResearched(Player(2), 'Rowt', 2)
    call SetPlayerTechResearched(Player(2), 'Rotr', 1)
    call SetPlayerTechResearched(Player(2), 'Robk', 1)
    call SetPlayerTechResearched(Player(2), 'Rorb', 1)
    call SetPlayerTechResearched(Player(2), 'Robs', 1)
    call SetPlayerTechResearched(Player(2), 'Rows', 1)
    call SetPlayerTechResearched(Player(2), 'Ruac', 1)
    call SetPlayerTechResearched(Player(2), 'Rugf', 1)
    call SetPlayerTechResearched(Player(2), 'Ruwb', 1)
    call SetPlayerTechResearched(Player(2), 'Rune', 2)
    call SetPlayerTechResearched(Player(2), 'Rusf', 1)
    call SetPlayerTechResearched(Player(2), 'Ruba', 2)
    call SetPlayerTechResearched(Player(2), 'Rufb', 1)
    call SetPlayerTechResearched(Player(2), 'Rusl', 1)
    call SetPlayerTechResearched(Player(2), 'Rusp', 1)
    call SetPlayerTechResearched(Player(2), 'Ruex', 1)
    call SetPlayerTechResearched(Player(2), 'Reuv', 1)
    call SetPlayerTechResearched(Player(2), 'Renb', 1)
    call SetPlayerTechResearched(Player(2), 'Remg', 1)
    call SetPlayerTechResearched(Player(2), 'Resc', 1)
    call SetPlayerTechResearched(Player(2), 'Reib', 1)
    call SetPlayerTechResearched(Player(2), 'Remk', 1)
    call SetPlayerTechResearched(Player(2), 'Redt', 2)
    call SetPlayerTechResearched(Player(2), 'Redc', 2)
    call SetPlayerTechResearched(Player(2), 'Resi', 1)
    call SetPlayerTechResearched(Player(2), 'Reht', 1)
    call SetPlayerTechResearched(Player(2), 'Repb', 1)
    call SetPlayerTechResearched(Player(2), 'Recb', 1)
    call SetPlayerTechResearched(Player(2), 'Rers', 1)
    call SetPlayerTechResearched(Player(2), 'Reeb', 1)
    call SetPlayerTechResearched(Player(2), 'Rehs', 1)
    call SetPlayerTechResearched(Player(2), 'Rews', 1)
    call SetPlayerTechResearched(Player(2), 'Reec', 1)
    call SetPlayerTechResearched(Player(2), 'Rnen', 1)
    call SetPlayerTechResearched(Player(2), 'Rnsw', 2)
    call SetPlayerTechResearched(Player(2), 'Rnsi', 1)
    call SetPlayerTechResearched(Player(2), 'Rnam', 3)
    call SetPlayerTechResearched(Player(2), 'Rnsb', 1)
    call SetPlayerTechMaxAllowed(Player(2), 'Rhpm', 0)
    call SetPlayerTechMaxAllowed(Player(2), 'Ropm', 0)
    call SetPlayerTechMaxAllowed(Player(2), 'Rupm', 0)
    call SetPlayerTechResearched(Player(2), 'Rnat', 3)
    call SetPlayerTechMaxAllowed(Player(2), 'Rupc', 0)
    call SetPlayerTechResearched(Player(2), 'Rusm', 1)
    call SetPlayerTechResearched(Player(2), 'Rhme', 3)
    call SetPlayerTechResearched(Player(2), 'Rhra', 3)
    call SetPlayerTechResearched(Player(2), 'Rhhb', 1)
    call SetPlayerTechResearched(Player(2), 'Rhar', 3)
    call SetPlayerTechResearched(Player(2), 'Rhgb', 1)
    call SetPlayerTechResearched(Player(2), 'Rhri', 1)
    call SetPlayerTechResearched(Player(2), 'Rhla', 3)
    call SetPlayerTechResearched(Player(2), 'Rhsb', 1)
    call SetPlayerTechResearched(Player(2), 'Rhac', 3)
    call SetPlayerTechResearched(Player(2), 'Rhan', 1)
    call SetPlayerTechResearched(Player(2), 'Rome', 3)
    call SetPlayerTechResearched(Player(2), 'Rora', 3)
    call SetPlayerTechResearched(Player(2), 'Roar', 3)
    call SetPlayerTechResearched(Player(2), 'Ropg', 1)
    call SetPlayerTechResearched(Player(2), 'Robf', 1)
    call SetPlayerTechResearched(Player(2), 'Rume', 3)
    call SetPlayerTechResearched(Player(2), 'Rura', 3)
    call SetPlayerTechResearched(Player(2), 'Ruar', 3)
    call SetPlayerTechResearched(Player(2), 'Rucr', 3)
    call SetPlayerTechResearched(Player(2), 'Rubu', 1)
    call SetPlayerTechResearched(Player(2), 'Resm', 3)
    call SetPlayerTechResearched(Player(2), 'Resw', 3)
    call SetPlayerTechResearched(Player(2), 'Rema', 3)
    call SetPlayerTechResearched(Player(2), 'Rerh', 3)
    call SetPlayerTechMaxAllowed(Player(2), 'Repm', 0)
endfunction

function InitUpgrades_Player3 takes nothing returns nothing
    call SetPlayerTechResearched(Player(3), 'Rhde', 1)
    call SetPlayerTechResearched(Player(3), 'Rhpt', 2)
    call SetPlayerTechResearched(Player(3), 'Rhst', 2)
    call SetPlayerTechResearched(Player(3), 'Rhlh', 2)
    call SetPlayerTechResearched(Player(3), 'Rhse', 1)
    call SetPlayerTechResearched(Player(3), 'Rhrt', 1)
    call SetPlayerTechResearched(Player(3), 'Rhss', 1)
    call SetPlayerTechResearched(Player(3), 'Rhfl', 1)
    call SetPlayerTechResearched(Player(3), 'Rhfc', 1)
    call SetPlayerTechResearched(Player(3), 'Rhfs', 1)
    call SetPlayerTechResearched(Player(3), 'Rhcd', 1)
    call SetPlayerTechResearched(Player(3), 'Rwdm', 1)
    call SetPlayerTechResearched(Player(3), 'Rovs', 1)
    call SetPlayerTechResearched(Player(3), 'Roen', 1)
    call SetPlayerTechResearched(Player(3), 'Rowd', 2)
    call SetPlayerTechResearched(Player(3), 'Rolf', 1)
    call SetPlayerTechResearched(Player(3), 'Rost', 2)
    call SetPlayerTechResearched(Player(3), 'Rosp', 2)
    call SetPlayerTechResearched(Player(3), 'Rowt', 2)
    call SetPlayerTechResearched(Player(3), 'Rotr', 1)
    call SetPlayerTechResearched(Player(3), 'Robk', 1)
    call SetPlayerTechResearched(Player(3), 'Rorb', 1)
    call SetPlayerTechResearched(Player(3), 'Robs', 1)
    call SetPlayerTechResearched(Player(3), 'Rows', 1)
    call SetPlayerTechResearched(Player(3), 'Ruac', 1)
    call SetPlayerTechResearched(Player(3), 'Rugf', 1)
    call SetPlayerTechResearched(Player(3), 'Ruwb', 1)
    call SetPlayerTechResearched(Player(3), 'Rune', 2)
    call SetPlayerTechResearched(Player(3), 'Rusf', 1)
    call SetPlayerTechResearched(Player(3), 'Ruba', 2)
    call SetPlayerTechResearched(Player(3), 'Rufb', 1)
    call SetPlayerTechResearched(Player(3), 'Rusl', 1)
    call SetPlayerTechResearched(Player(3), 'Rusp', 1)
    call SetPlayerTechResearched(Player(3), 'Ruex', 1)
    call SetPlayerTechResearched(Player(3), 'Reuv', 1)
    call SetPlayerTechResearched(Player(3), 'Renb', 1)
    call SetPlayerTechResearched(Player(3), 'Remg', 1)
    call SetPlayerTechResearched(Player(3), 'Resc', 1)
    call SetPlayerTechResearched(Player(3), 'Reib', 1)
    call SetPlayerTechResearched(Player(3), 'Remk', 1)
    call SetPlayerTechResearched(Player(3), 'Redt', 2)
    call SetPlayerTechResearched(Player(3), 'Redc', 2)
    call SetPlayerTechResearched(Player(3), 'Resi', 1)
    call SetPlayerTechResearched(Player(3), 'Reht', 1)
    call SetPlayerTechResearched(Player(3), 'Repb', 1)
    call SetPlayerTechResearched(Player(3), 'Recb', 1)
    call SetPlayerTechResearched(Player(3), 'Rers', 1)
    call SetPlayerTechResearched(Player(3), 'Reeb', 1)
    call SetPlayerTechResearched(Player(3), 'Rehs', 1)
    call SetPlayerTechResearched(Player(3), 'Rews', 1)
    call SetPlayerTechResearched(Player(3), 'Reec', 1)
    call SetPlayerTechResearched(Player(3), 'Rnen', 1)
    call SetPlayerTechResearched(Player(3), 'Rnsw', 2)
    call SetPlayerTechResearched(Player(3), 'Rnsi', 1)
    call SetPlayerTechResearched(Player(3), 'Rnam', 3)
    call SetPlayerTechResearched(Player(3), 'Rnsb', 1)
    call SetPlayerTechMaxAllowed(Player(3), 'Rhpm', 0)
    call SetPlayerTechMaxAllowed(Player(3), 'Ropm', 0)
    call SetPlayerTechMaxAllowed(Player(3), 'Rupm', 0)
    call SetPlayerTechResearched(Player(3), 'Rnat', 3)
    call SetPlayerTechMaxAllowed(Player(3), 'Rupc', 0)
    call SetPlayerTechResearched(Player(3), 'Rusm', 1)
    call SetPlayerTechResearched(Player(3), 'Rhme', 3)
    call SetPlayerTechResearched(Player(3), 'Rhra', 3)
    call SetPlayerTechResearched(Player(3), 'Rhhb', 1)
    call SetPlayerTechResearched(Player(3), 'Rhar', 3)
    call SetPlayerTechResearched(Player(3), 'Rhgb', 1)
    call SetPlayerTechResearched(Player(3), 'Rhri', 1)
    call SetPlayerTechResearched(Player(3), 'Rhla', 3)
    call SetPlayerTechResearched(Player(3), 'Rhsb', 1)
    call SetPlayerTechResearched(Player(3), 'Rhac', 3)
    call SetPlayerTechResearched(Player(3), 'Rhan', 1)
    call SetPlayerTechResearched(Player(3), 'Rome', 3)
    call SetPlayerTechResearched(Player(3), 'Rora', 3)
    call SetPlayerTechResearched(Player(3), 'Roar', 3)
    call SetPlayerTechResearched(Player(3), 'Ropg', 1)
    call SetPlayerTechResearched(Player(3), 'Robf', 1)
    call SetPlayerTechResearched(Player(3), 'Rume', 3)
    call SetPlayerTechResearched(Player(3), 'Rura', 3)
    call SetPlayerTechResearched(Player(3), 'Ruar', 3)
    call SetPlayerTechResearched(Player(3), 'Rucr', 3)
    call SetPlayerTechResearched(Player(3), 'Rubu', 1)
    call SetPlayerTechResearched(Player(3), 'Resm', 3)
    call SetPlayerTechResearched(Player(3), 'Resw', 3)
    call SetPlayerTechResearched(Player(3), 'Rema', 3)
    call SetPlayerTechResearched(Player(3), 'Rerh', 3)
    call SetPlayerTechMaxAllowed(Player(3), 'Repm', 0)
endfunction

function InitUpgrades_Player20 takes nothing returns nothing
    call SetPlayerTechResearched(Player(20), 'Rhde', 1)
    call SetPlayerTechResearched(Player(20), 'Rhpt', 2)
    call SetPlayerTechResearched(Player(20), 'Rhst', 2)
    call SetPlayerTechResearched(Player(20), 'Rhlh', 2)
    call SetPlayerTechResearched(Player(20), 'Rhse', 1)
    call SetPlayerTechResearched(Player(20), 'Rhrt', 1)
    call SetPlayerTechResearched(Player(20), 'Rhss', 1)
    call SetPlayerTechResearched(Player(20), 'Rhfl', 1)
    call SetPlayerTechResearched(Player(20), 'Rhfc', 1)
    call SetPlayerTechResearched(Player(20), 'Rhfs', 1)
    call SetPlayerTechResearched(Player(20), 'Rhcd', 1)
    call SetPlayerTechResearched(Player(20), 'Rwdm', 1)
    call SetPlayerTechResearched(Player(20), 'Rovs', 1)
    call SetPlayerTechResearched(Player(20), 'Roen', 1)
    call SetPlayerTechResearched(Player(20), 'Rowd', 2)
    call SetPlayerTechResearched(Player(20), 'Rolf', 1)
    call SetPlayerTechResearched(Player(20), 'Rost', 2)
    call SetPlayerTechResearched(Player(20), 'Rosp', 2)
    call SetPlayerTechResearched(Player(20), 'Rowt', 2)
    call SetPlayerTechResearched(Player(20), 'Rotr', 1)
    call SetPlayerTechResearched(Player(20), 'Robk', 1)
    call SetPlayerTechResearched(Player(20), 'Rorb', 1)
    call SetPlayerTechResearched(Player(20), 'Robs', 1)
    call SetPlayerTechResearched(Player(20), 'Rows', 1)
    call SetPlayerTechResearched(Player(20), 'Ruac', 1)
    call SetPlayerTechResearched(Player(20), 'Rugf', 1)
    call SetPlayerTechResearched(Player(20), 'Ruwb', 1)
    call SetPlayerTechResearched(Player(20), 'Rune', 2)
    call SetPlayerTechResearched(Player(20), 'Rusf', 1)
    call SetPlayerTechResearched(Player(20), 'Ruba', 2)
    call SetPlayerTechResearched(Player(20), 'Rufb', 1)
    call SetPlayerTechResearched(Player(20), 'Rusl', 1)
    call SetPlayerTechResearched(Player(20), 'Rusp', 1)
    call SetPlayerTechResearched(Player(20), 'Ruex', 1)
    call SetPlayerTechResearched(Player(20), 'Reuv', 1)
    call SetPlayerTechResearched(Player(20), 'Renb', 1)
    call SetPlayerTechResearched(Player(20), 'Remg', 1)
    call SetPlayerTechResearched(Player(20), 'Resc', 1)
    call SetPlayerTechResearched(Player(20), 'Reib', 1)
    call SetPlayerTechResearched(Player(20), 'Remk', 1)
    call SetPlayerTechResearched(Player(20), 'Redt', 2)
    call SetPlayerTechResearched(Player(20), 'Redc', 2)
    call SetPlayerTechResearched(Player(20), 'Resi', 1)
    call SetPlayerTechResearched(Player(20), 'Reht', 1)
    call SetPlayerTechResearched(Player(20), 'Repb', 1)
    call SetPlayerTechResearched(Player(20), 'Recb', 1)
    call SetPlayerTechResearched(Player(20), 'Rers', 1)
    call SetPlayerTechResearched(Player(20), 'Reeb', 1)
    call SetPlayerTechResearched(Player(20), 'Rehs', 1)
    call SetPlayerTechResearched(Player(20), 'Rews', 1)
    call SetPlayerTechResearched(Player(20), 'Reec', 1)
    call SetPlayerTechResearched(Player(20), 'Repm', 1)
    call SetPlayerTechMaxAllowed(Player(20), 'Rgfo', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Roch', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rguv', 0)
    call SetPlayerTechResearched(Player(20), 'Rnen', 1)
    call SetPlayerTechResearched(Player(20), 'Rnsw', 2)
    call SetPlayerTechResearched(Player(20), 'Rnsi', 1)
    call SetPlayerTechResearched(Player(20), 'Rnam', 3)
    call SetPlayerTechResearched(Player(20), 'Rnsb', 1)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhme', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhra', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhar', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhac', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhgb', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhhb', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhan', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhla', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhri', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhpm', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rhsb', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rome', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rora', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Roar', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Ropg', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Ropm', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Robf', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rume', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rura', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Ruar', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rucr', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rupm', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Resm', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Resw', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rema', 0)
    call SetPlayerTechMaxAllowed(Player(20), 'Rerh', 0)
    call SetPlayerTechResearched(Player(20), 'Rnat', 3)
    call SetPlayerTechMaxAllowed(Player(20), 'Rupc', 0)
    call SetPlayerTechResearched(Player(20), 'Rusm', 1)
    call SetPlayerTechMaxAllowed(Player(20), 'Rubu', 0)
endfunction

function InitUpgrades takes nothing returns nothing
    call InitUpgrades_Player0()
    call InitUpgrades_Player1()
    call InitUpgrades_Player2()
    call InitUpgrades_Player3()
    call InitUpgrades_Player20()
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)

    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)

    // Player 20
    call SetPlayerStartLocation(Player(20), 4)
    call ForcePlayerStartLocation(Player(20), 4)
    call SetPlayerColor(Player(20), ConvertPlayerColor(20))
    call SetPlayerRacePreference(Player(20), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(20), false)
    call SetPlayerController(Player(20), MAP_CONTROL_COMPUTER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_235
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)

    // Force: TRIGSTR_314
    call SetPlayerTeam(Player(20), 1)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 3)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 2)
    call SetStartLocPrio(1, 0, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 1, 3, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(2, 2)
    call SetStartLocPrio(2, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 1, 3, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(3, 2)
    call SetStartLocPrio(3, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 1, 2, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(4, 4)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(4, 3)
    call SetEnemyStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(4, 1, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 2, 2, MAP_LOC_PRIO_LOW)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(4864.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 10368.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 11904.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3328.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 4864.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3328.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 11904.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 10368.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call SetWaterBaseColor(0, 255, 255, 255)
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("NorthrendDay")
    call SetAmbientNightSound("NorthrendNight")
    call SetMapMusic("Music", true, 0)
    call InitSounds()
    call CreateRegions()
    call CreateCameras()
    call InitUpgrades()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs169619796")
call ExecuteFunc("DamageEngine___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_035")
    call SetMapDescription("TRIGSTR_037")
    call SetPlayers(5)
    call SetTeams(5)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 12224.0, - 2944.0)
    call DefineStartLocation(1, 8448.0, - 6976.0)
    call DefineStartLocation(2, 8448.0, - 6976.0)
    call DefineStartLocation(3, 8448.0, - 6976.0)
    call DefineStartLocation(4, 12224.0, - 2944.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype6_DamageEngine___PreSetup takes nothing returns boolean
    call DamageEngine___PreSetup(f__arg_trigger1,f__arg_string1,f__arg_limitop1,f__arg_real1)
    return true
endfunction

function jasshelper__initstructs169619796 takes nothing returns nothing
    set st___prototype6[1]=CreateTrigger()
    call TriggerAddAction(st___prototype6[1],function sa___prototype6_DamageEngine___PreSetup)
    call TriggerAddCondition(st___prototype6[1],Condition(function sa___prototype6_DamageEngine___PreSetup))

endfunction

