Unit = {
    unit = nil
}

local Unit_mt = {__index = Unit}

function Unit.new(player_id, i_unitid, r_x, r_y, r_face)
    local instance = {}
    setmetatable(instance, Unit_mt)
    instance.unit = Unit.create(player_id, i_unitid, r_x, r_y, r_face)
    return instance
end

--============================================================================

-- Unit API

-- Facing arguments are specified in degrees

function Unit.create(player_id, i_unitid, r_x, r_y, r_face) return CreateUnit(player_id, i_unitid, r_x, r_y, r_face) end
function Unit.createByName(player_whichPlayer, s_unitname, r_x, r_y, r_face) return CreateUnitByName(player_whichPlayer, s_unitname, r_x, r_y, r_face) end
function Unit.createAtLoc(player_id, i_unitid, location_whichLocation, r_face) return CreateUnitAtLoc(player_id, i_unitid, location_whichLocation, r_face) end
function Unit.createAtLocByName(player_id, s_unitname, location_whichLocation, r_face) return CreateUnitAtLocByName(player_id, s_unitname, location_whichLocation, r_face) end
function Unit.createCorpse(player_whichPlayer, i_unitid, r_x, r_y, r_face) return CreateCorpse(player_whichPlayer, i_unitid, r_x, r_y, r_face) end
function Unit:kill() KillUnit(self.unit) end
function Unit:remove() RemoveUnit(self.unit) end
function Unit:show(b_show) ShowUnit(self.unit, b_show) end
function Unit:setState(unitstate_whichUnitState, r_newVal) SetUnitState(self.unit, unitstate_whichUnitState, r_newVal) end
function Unit:setX(r_newX) SetUnitX(self.unit, r_newX) end
function Unit:setY(r_newY) SetUnitY(self.unit, r_newY) end
function Unit:setPosition(r_newX, r_newY) SetUnitPosition(self.unit, r_newX, r_newY) end
function Unit:setPositionLoc(location_whichLocation) SetUnitPositionLoc(self.unit, location_whichLocation) end
function Unit:setFacing(r_facingAngle) SetUnitFacing(self.unit, r_facingAngle) end
function Unit:setFacingTimed(r_facingAngle, r_duration) SetUnitFacingTimed(self.unit, r_facingAngle, r_duration) end
function Unit:setMoveSpeed(r_newSpeed) SetUnitMoveSpeed(self.unit, r_newSpeed) end
function Unit:setFlyHeight(r_newHeight, r_rate) SetUnitFlyHeight(self.unit, r_newHeight, r_rate) end
function Unit:setTurnSpeed(r_newTurnSpeed) SetUnitTurnSpeed(self.unit, r_newTurnSpeed) end
function Unit:setPropWindow(r_newPropWindowAngle) SetUnitPropWindow(self.unit, r_newPropWindowAngle) end
function Unit:setAcquireRange(r_newAcquireRange) SetUnitAcquireRange(self.unit, r_newAcquireRange) end
function Unit:setCreepGuard(b_creepGuard) SetUnitCreepGuard(self.unit, b_creepGuard) end
function Unit:getAcquireRange() return GetUnitAcquireRange(self.unit) end
function Unit:getTurnSpeed() return GetUnitTurnSpeed(self.unit) end
function Unit:getPropWindow() return GetUnitPropWindow(self.unit) end
function Unit:getFlyHeight() return GetUnitFlyHeight(self.unit) end
function Unit:getDefaultAcquireRange() return GetUnitDefaultAcquireRange(self.unit) end
function Unit:getDefaultTurnSpeed() return GetUnitDefaultTurnSpeed(self.unit) end
function Unit:getDefaultPropWindow() return GetUnitDefaultPropWindow(self.unit) end
function Unit:getDefaultFlyHeight() return GetUnitDefaultFlyHeight(self.unit) end
function Unit:setOwner(player_whichPlayer, b_changeColor) SetUnitOwner(self.unit, player_whichPlayer, b_changeColor) end
function Unit:setColor(playercolor_whichColor) SetUnitColor(self.unit, playercolor_whichColor) end
function Unit:setScale(r_scaleX, r_scaleY, r_scaleZ) SetUnitScale(self.unit, r_scaleX, r_scaleY, r_scaleZ) end
function Unit:setTimeScale(r_timeScale) SetUnitTimeScale(self.unit, r_timeScale) end
function Unit:setBlendTime(r_blendTime) SetUnitBlendTime(self.unit, r_blendTime) end
function Unit:setVertexColor(i_red, i_green, i_blue, i_alpha) SetUnitVertexColor(self.unit, i_red, i_green, i_blue, i_alpha) end
function Unit:queueAnimation(s_whichAnimation) QueueUnitAnimation(self.unit, s_whichAnimation) end
function Unit:setAnimation(s_whichAnimation) SetUnitAnimation(self.unit, s_whichAnimation) end
function Unit:setAnimationByIndex(i_whichAnimation) SetUnitAnimationByIndex(self.unit, i_whichAnimation) end
function Unit:setAnimationWithRarity(s_whichAnimation, raritycontrol_rarity) SetUnitAnimationWithRarity(self.unit, s_whichAnimation, raritycontrol_rarity) end
function Unit:addAnimationProperties(s_animProperties, b_add) AddUnitAnimationProperties(self.unit, s_animProperties, b_add) end
function Unit:setLookAt(s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) SetUnitLookAt(self.unit, s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) end
function Unit:resetLookAt() ResetUnitLookAt(self.unit) end
function Unit:setRescuable(player_byWhichPlayer, b_flag) SetUnitRescuable(self.unit, player_byWhichPlayer, b_flag) end
function Unit:setRescueRange(r_range) SetUnitRescueRange(self.unit, r_range) end
function Unit.setHeroStr(unit_whichHero, i_newStr, b_permanent) SetHeroStr(unit_whichHero, i_newStr, b_permanent) end
function Unit.setHeroAgi(unit_whichHero, i_newAgi, b_permanent) SetHeroAgi(unit_whichHero, i_newAgi, b_permanent) end
function Unit.setHeroInt(unit_whichHero, i_newInt, b_permanent) SetHeroInt(unit_whichHero, i_newInt, b_permanent) end
function Unit.getHeroStr(unit_whichHero, b_includeBonuses) return GetHeroStr(unit_whichHero, b_includeBonuses) end
function Unit.getHeroAgi(unit_whichHero, b_includeBonuses) return GetHeroAgi(unit_whichHero, b_includeBonuses) end
function Unit.getHeroInt(unit_whichHero, b_includeBonuses) return GetHeroInt(unit_whichHero, b_includeBonuses) end
function Unit.stripHeroLevel(unit_whichHero, i_howManyLevels) return UnitStripHeroLevel(unit_whichHero, i_howManyLevels) end
function Unit.getHeroXP(unit_whichHero) return GetHeroXP(unit_whichHero) end
function Unit.setHeroXP(unit_whichHero, i_newXpVal, b_showEyeCandy) SetHeroXP(unit_whichHero, i_newXpVal, b_showEyeCandy) end
function Unit.getHeroSkillPoints(unit_whichHero) return GetHeroSkillPoints(unit_whichHero) end
function Unit.modifySkillPoints(unit_whichHero, i_skillPointDelta) return UnitModifySkillPoints(unit_whichHero, i_skillPointDelta) end
function Unit.addHeroXP(unit_whichHero, i_xpToAdd, b_showEyeCandy) AddHeroXP(unit_whichHero, i_xpToAdd, b_showEyeCandy) end
function Unit.setHeroLevel(unit_whichHero, i_level, b_showEyeCandy) SetHeroLevel(unit_whichHero, i_level, b_showEyeCandy) end
function Unit.getHeroLevel(unit_whichHero) return GetHeroLevel(unit_whichHero) end
function Unit:getLevel() return GetUnitLevel(self.unit) end
function Unit.getHeroProperName(unit_whichHero) return GetHeroProperName(unit_whichHero) end
function Unit.suspendHeroXP(unit_whichHero, b_flag) SuspendHeroXP(unit_whichHero, b_flag) end
function Unit.isSuspendedXP(unit_whichHero) return IsSuspendedXP(unit_whichHero) end
function Unit.selectHeroSkill(unit_whichHero, i_abilcode) SelectHeroSkill(unit_whichHero, i_abilcode) end
function Unit:getAbilityLevel(i_abilcode) return GetUnitAbilityLevel(self.unit, i_abilcode) end
function Unit:decAbilityLevel(i_abilcode) return DecUnitAbilityLevel(self.unit, i_abilcode) end
function Unit:incAbilityLevel(i_abilcode) return IncUnitAbilityLevel(self.unit, i_abilcode) end
function Unit:setAbilityLevel(i_abilcode, i_level) return SetUnitAbilityLevel(self.unit, i_abilcode, i_level) end
function Unit.reviveHero(unit_whichHero, r_x, r_y, b_doEyecandy) return ReviveHero(unit_whichHero, r_x, r_y, b_doEyecandy) end
function Unit.reviveHeroLoc(unit_whichHero, location_loc, b_doEyecandy) return ReviveHeroLoc(unit_whichHero, location_loc, b_doEyecandy) end
function Unit:setExploded(b_exploded) SetUnitExploded(self.unit, b_exploded) end
function Unit:setInvulnerable(b_flag) SetUnitInvulnerable(self.unit, b_flag) end
function Unit:pause(b_flag) PauseUnit(self.unit, b_flag) end
function Unit.isPaused(unit_whichHero) return IsUnitPaused(unit_whichHero) end
function Unit:setPathing(b_flag) SetUnitPathing(self.unit, b_flag) end
function Unit.clearSelection() ClearSelection() end
function Unit:select(b_flag) SelectUnit(self.unit, b_flag) end
function Unit:getPointValue() return GetUnitPointValue(self.unit) end
function Unit.getPointValueByType(i_unitType) return GetUnitPointValueByType(i_unitType) end
--native SetUnitPointValueByType takes integer unitType, integer newPointValue returns

function Unit:addItem(item_whichItem) return UnitAddItem(self.unit, item_whichItem) end
function Unit:addItemById(i_itemId) return UnitAddItemById(self.unit, i_itemId) end
function Unit:addItemToSlotById(i_itemId, i_itemSlot) return UnitAddItemToSlotById(self.unit, i_itemId, i_itemSlot) end
function Unit:removeItem(item_whichItem) UnitRemoveItem(self.unit, item_whichItem) end
function Unit:removeItemFromSlot(i_itemSlot) return UnitRemoveItemFromSlot(self.unit, i_itemSlot) end
function Unit:hasItem(item_whichItem) return UnitHasItem(self.unit, item_whichItem) end
function Unit:itemInSlot(i_itemSlot) return UnitItemInSlot(self.unit, i_itemSlot) end
function Unit:inventorySize() return UnitInventorySize(self.unit) end
function Unit:dropItemPoint(item_whichItem, r_x, r_y) return UnitDropItemPoint(self.unit, item_whichItem, r_x, r_y) end
function Unit:dropItemSlot(item_whichItem, i_slot) return UnitDropItemSlot(self.unit, item_whichItem, i_slot) end
function Unit:dropItemTarget(item_whichItem, widget_target) return UnitDropItemTarget(self.unit, item_whichItem, widget_target) end
function Unit:useItem(item_whichItem) return UnitUseItem(self.unit, item_whichItem) end
function Unit:useItemPoint(item_whichItem, r_x, r_y) return UnitUseItemPoint(self.unit, item_whichItem, r_x, r_y) end
function Unit:useItemTarget(item_whichItem, widget_target) return UnitUseItemTarget(self.unit, item_whichItem, widget_target) end
function Unit:getX() return GetUnitX(self.unit) end
function Unit:getY() return GetUnitY(self.unit) end
function Unit:getLoc() return GetUnitLoc(self.unit) end
function Unit:getFacing() return GetUnitFacing(self.unit) end
function Unit:getMoveSpeed() return GetUnitMoveSpeed(self.unit) end
function Unit:getDefaultMoveSpeed() return GetUnitDefaultMoveSpeed(self.unit) end
function Unit:getState(unitstate_whichUnitState) return GetUnitState(self.unit, unitstate_whichUnitState) end
function Unit:getOwningPlayer() return GetOwningPlayer(self.unit) end
function Unit:getTypeId() return GetUnitTypeId(self.unit) end
function Unit:getRace() return GetUnitRace(self.unit) end
function Unit:getName() return GetUnitName(self.unit) end
function Unit:getFoodUsed() return GetUnitFoodUsed(self.unit) end
function Unit:getFoodMade() return GetUnitFoodMade(self.unit) end
function Unit.getFoodMade(i_unitId) return GetFoodMade(i_unitId) end
function Unit.getFoodUsed(i_unitId) return GetFoodUsed(i_unitId) end
function Unit:setUseFood(b_useFood) SetUnitUseFood(self.unit, b_useFood) end
function Unit:getRallyPoint() return GetUnitRallyPoint(self.unit) end
function Unit:getRally() return GetUnitRallyUnit(self.unit) end
function Unit:getRallyDestructable() return GetUnitRallyDestructable(self.unit) end
function Unit:isInGroup(group_whichGroup) return IsUnitInGroup(self.unit, group_whichGroup) end
function Unit:isInForce(force_whichForce) return IsUnitInForce(self.unit, force_whichForce) end
function Unit:isOwnedByPlayer(player_whichPlayer) return IsUnitOwnedByPlayer(self.unit, player_whichPlayer) end
function Unit:isAlly(player_whichPlayer) return IsUnitAlly(self.unit, player_whichPlayer) end
function Unit:isEnemy(player_whichPlayer) return IsUnitEnemy(self.unit, player_whichPlayer) end
function Unit:isVisible(player_whichPlayer) return IsUnitVisible(self.unit, player_whichPlayer) end
function Unit:isDetected(player_whichPlayer) return IsUnitDetected(self.unit, player_whichPlayer) end
function Unit:isInvisible(player_whichPlayer) return IsUnitInvisible(self.unit, player_whichPlayer) end
function Unit:isFogged(player_whichPlayer) return IsUnitFogged(self.unit, player_whichPlayer) end
function Unit:isMasked(player_whichPlayer) return IsUnitMasked(self.unit, player_whichPlayer) end
function Unit:isSelected(player_whichPlayer) return IsUnitSelected(self.unit, player_whichPlayer) end
function Unit:isRace(race_whichRace) return IsUnitRace(self.unit, race_whichRace) end
function Unit:isType(unittype_whichUnitType) return IsUnitType(self.unit, unittype_whichUnitType) end
function Unit:is(unit_whichSpecifiedUnit) return IsUnit(self.unit, unit_whichSpecifiedUnit) end
function Unit:isInRange(unit_otherUnit, r_distance) return IsUnitInRange(self.unit, unit_otherUnit, r_distance) end
function Unit:isInRangeXY(r_x, r_y, r_distance) return IsUnitInRangeXY(self.unit, r_x, r_y, r_distance) end
function Unit:isInRangeLoc(location_whichLocation, r_distance) return IsUnitInRangeLoc(self.unit, location_whichLocation, r_distance) end
function Unit:isHidden() return IsUnitHidden(self.unit) end
function Unit:isIllusion() return IsUnitIllusion(self.unit) end
function Unit:isInTransport(unit_whichTransport) return IsUnitInTransport(self.unit, unit_whichTransport) end
function Unit:isLoaded() return IsUnitLoaded(self.unit) end
function Unit.isHeroId(i_unitId) return IsHeroUnitId(i_unitId) end
function Unit.isIdType(i_unitId, unittype_whichUnitType) return IsUnitIdType(i_unitId, unittype_whichUnitType) end
function Unit:shareVision(player_whichPlayer, b_share) UnitShareVision(self.unit, player_whichPlayer, b_share) end
function Unit:suspendDecay(b_suspend) UnitSuspendDecay(self.unit, b_suspend) end
function Unit:addType(unittype_whichUnitType) return UnitAddType(self.unit, unittype_whichUnitType) end
function Unit:removeType(unittype_whichUnitType) return UnitRemoveType(self.unit, unittype_whichUnitType) end
function Unit:addAbility(i_abilityId) return UnitAddAbility(self.unit, i_abilityId) end
function Unit:removeAbility(i_abilityId) return UnitRemoveAbility(self.unit, i_abilityId) end
function Unit:makeAbilityPermanent(b_permanent, i_abilityId) return UnitMakeAbilityPermanent(self.unit, b_permanent, i_abilityId) end
function Unit:removeBuffs(b_removePositive, b_removeNegative) UnitRemoveBuffs(self.unit, b_removePositive, b_removeNegative) end
function Unit:removeBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) UnitRemoveBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:hasBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitHasBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:countBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitCountBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:addSleep(b_add) UnitAddSleep(self.unit, b_add) end
function Unit:canSleep() return UnitCanSleep(self.unit) end
function Unit:addSleepPerm(b_add) UnitAddSleepPerm(self.unit, b_add) end
function Unit:canSleepPerm() return UnitCanSleepPerm(self.unit) end
function Unit:isSleeping() return UnitIsSleeping(self.unit) end
function Unit:wakeUp() UnitWakeUp(self.unit) end
function Unit:applyTimedLife(i_buffId, r_duration) UnitApplyTimedLife(self.unit, i_buffId, r_duration) end
function Unit:ignoreAlarm(b_flag) return UnitIgnoreAlarm(self.unit, b_flag) end
function Unit:ignoreAlarmToggled() return UnitIgnoreAlarmToggled(self.unit) end
function Unit:resetCooldown() UnitResetCooldown(self.unit) end
function Unit:setConstructionProgress(i_constructionPercentage) UnitSetConstructionProgress(self.unit, i_constructionPercentage) end
function Unit:setUpgradeProgress(i_upgradePercentage) UnitSetUpgradeProgress(self.unit, i_upgradePercentage) end
function Unit:pauseTimedLife(b_flag) UnitPauseTimedLife(self.unit, b_flag) end
function Unit:setUsesAltIcon(b_flag) UnitSetUsesAltIcon(self.unit, b_flag) end
function Unit:damagePoint(r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamagePoint(self.unit, r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:damageTarget(widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamageTarget(self.unit, widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:issueImmediateOrder(s_order) return IssueImmediateOrder(self.unit, s_order) end
function Unit:issueImmediateOrderById(i_order) return IssueImmediateOrderById(self.unit, i_order) end
function Unit:issuePointOrder(s_order, r_x, r_y) return IssuePointOrder(self.unit, s_order, r_x, r_y) end
function Unit:issuePointOrderLoc(s_order, location_whichLocation) return IssuePointOrderLoc(self.unit, s_order, location_whichLocation) end
function Unit:issuePointOrderById(i_order, r_x, r_y) return IssuePointOrderById(self.unit, i_order, r_x, r_y) end
function Unit:issuePointOrderByIdLoc(i_order, location_whichLocation) return IssuePointOrderByIdLoc(self.unit, i_order, location_whichLocation) end
function Unit:issueTargetOrder(s_order, widget_targetWidget) return IssueTargetOrder(self.unit, s_order, widget_targetWidget) end
function Unit:issueTargetOrderById(i_order, widget_targetWidget) return IssueTargetOrderById(self.unit, i_order, widget_targetWidget) end
function Unit:issueInstantPointOrder(s_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrder(self.unit, s_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantPointOrderById(i_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrderById(self.unit, i_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantTargetOrder(s_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrder(self.unit, s_order, widget_targetWidget, widget_instantTargetWidget) end
function Unit:issueInstantTargetOrderById(i_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrderById(self.unit, i_order, widget_targetWidget, widget_instantTargetWidget) end
function Unit.issueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) return IssueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) end
function Unit.issueBuildOrderById(unit_whichPeon, i_unitId, r_x, r_y) return IssueBuildOrderById(unit_whichPeon, i_unitId, r_x, r_y) end
function Unit.issueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) return IssueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) end
function Unit.issueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId) return IssueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId) end
function Unit.issueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) return IssueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) end
function Unit.issueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, r_x, r_y) return IssueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, r_x, r_y) end
function Unit.issueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) return IssueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) end
function Unit.issueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, widget_target) return IssueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, widget_target) end
function Unit:getCurrentOrder() return GetUnitCurrentOrder(self.unit) end
function Unit:setResourceAmount(i_amount) SetResourceAmount(self.unit, i_amount) end
function Unit:addResourceAmount(i_amount) AddResourceAmount(self.unit, i_amount) end
function Unit:getResourceAmount() return GetResourceAmount(self.unit) end
function Unit.waygateGetDestinationX(unit_waygate) return WaygateGetDestinationX(unit_waygate) end
function Unit.waygateGetDestinationY(unit_waygate) return WaygateGetDestinationY(unit_waygate) end
function Unit.waygateSetDestination(unit_waygate, r_x, r_y) WaygateSetDestination(unit_waygate, r_x, r_y) end
function Unit.waygateActivate(unit_waygate, b_activate) WaygateActivate(unit_waygate, b_activate) end
function Unit.waygateIsActive(unit_waygate) return WaygateIsActive(unit_waygate) end
function Unit.addItemToAllStock(i_itemId, i_currentStock, i_stockMax) AddItemToAllStock(i_itemId, i_currentStock, i_stockMax) end
function Unit:addItemToStock(i_itemId, i_currentStock, i_stockMax) AddItemToStock(self.unit, i_itemId, i_currentStock, i_stockMax) end
function Unit.addToAllStock(i_unitId, i_currentStock, i_stockMax) AddUnitToAllStock(i_unitId, i_currentStock, i_stockMax) end
function Unit:addToStock(i_unitId, i_currentStock, i_stockMax) AddUnitToStock(self.unit, i_unitId, i_currentStock, i_stockMax) end
function Unit.removeItemFromAllStock(i_itemId) RemoveItemFromAllStock(i_itemId) end
function Unit:removeItemFromStock(i_itemId) RemoveItemFromStock(self.unit, i_itemId) end
function Unit.removeFromAllStock(i_unitId) RemoveUnitFromAllStock(i_unitId) end
function Unit:removeFromStock(i_unitId) RemoveUnitFromStock(self.unit, i_unitId) end
function Unit.setAllItemTypeSlots(i_slots) SetAllItemTypeSlots(i_slots) end
function Unit.setAllTypeSlots(i_slots) SetAllUnitTypeSlots(i_slots) end
function Unit:setItemTypeSlots(i_slots) SetItemTypeSlots(self.unit, i_slots) end
function Unit:setTypeSlots(i_slots) SetUnitTypeSlots(self.unit, i_slots) end
function Unit:getUserData() return GetUnitUserData(self.unit) end
function Unit:setUserData(i_data) SetUnitUserData(self.unit, i_data) end
