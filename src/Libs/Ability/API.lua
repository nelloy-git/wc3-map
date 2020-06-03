---@class AbilityLib
local AbilityLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.Class),
    UtilsLib = require(LibList.Utils)
}

--=====
-- API
--=====

---@type AbilitiesContainerClass
AbilityLibAPI.Container = require(modname..'.Container')
---@type AbilityTypeClass
AbilityLibAPI.Type = require(modname..'.Type')
---@type AbilityType
AbilityLibAPI.TestType = require(modname..'.TestType')

---@type AbilityTargetDestructableClass
AbilityLibAPI.TargetDestructable = require(modname..'.Target.Destructable')
---@type AbilityTargetItemClass
AbilityLibAPI.TargetItem = require(modname..'.Target.Item')
---@type AbilityTargetNoneClass
AbilityLibAPI.TargetNone = require(modname..'.Target.None')
---@type AbilityTargetPointClass
AbilityLibAPI.TargetPoint = require(modname..'.Target.Point')
---@type AbilityTargetUnitClass
AbilityLibAPI.TargetUnit = require(modname..'.Target.Unit')

--[[
-- Enums
AbilityAPI.TargetingType = Type.TargetingType

-- Classes
AbilityAPI.Type = Type
AbilityAPI.Ability = Ability

-- Casting
AbilityAPI.getCastingPeriod = Ability.getCastingPeriod
AbilityAPI.getCastingAbility = Ability.getCastingAbility
AbilityAPI.getCastingTarget = Ability.getCastingTarget
AbilityAPI.getCastingTimeLeft = Ability.getCastingTimeLeft
AbilityAPI.getCastingTimeFull = Ability.getCastingTimeFull
AbilityAPI.cancelCastingAbility = Ability.cancelCastingAbility
AbilityAPI.interruptCastingAbility = Ability.interruptCastingAbility
AbilityAPI.finishCastingAbility = Ability.finishCastingAbility
AbilityAPI.extraPeriodForCastingAbility = Ability.extraPeriodForCastingAbility

-- Targets
AbilityAPI.TargetNone = require('Ability.Target.None')
AbilityAPI.TargetPoint = require('Ability.Target.Point')
AbilityAPI.TargetUnit = require('Ability.Target.Unit')
AbilityAPI.TargetDestructable = require('Ability.Target.Destructable')
AbilityAPI.TargetItem = require('Ability.Target.Item')
]]

Lib.finish()

return AbilityLibAPI