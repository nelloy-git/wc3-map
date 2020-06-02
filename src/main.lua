require('Utils.Globals')

---@type ParameterLib
local ParameterAPI = require(LibList.Parameter)
---@type AbilityLib
local AbilityAPI = require(LibList.Ability)
---@type ObjectLib
local ObjectLib = require(LibList.Object)

if IsCompiletime() then
    return
end

local u = ObjectLib.Unit.new(FourCC('hfoo'), 0, 0, Player(0))

local param_container = ParameterAPI.UnitContainer.new(u:getObj())

local test_abil_type = AbilityAPI.TestType
local abil_container = AbilityAPI.Container.new(u:getObj())
abil_container:set(1, test_abil_type)
--local abil = abil_container:get(1):use(AbilityAPI.TargetNone.new())

--[[
---@type UnitAPI
local UnitAPI = require('Unit.API')
local UnitType = UnitAPI.Type
local UnitTypeClass = UnitAPI.UnitTypeClass
local Unit = UnitAPI.Unit

---@type ItemAPI
ItemAPI = require('Item.API')
---@type InterfaceAPI
InterfaceAPI = require('Interface.API')
---@type ParameterAPI
ParamAPI = require('Parameter.API')
---@type InterfaceFrameParamTableClass
local ParamTable = require('Interface.Frame.ParamTable')

---@type AbilityAPI
local AbilityAPI = require('Ability.API')
local Ability = AbilityAPI.Ability
local TargetUnit = AbilityAPI.TargetUnit

--ExampleAbility = require('Ability.Example')

require('Event.Item')
--require('Event.Ability')
--require('Event.Interface')

footman_type = UnitType.new('Footman', UnitTypeClass.UNIT)

if not IsCompiletime() then
    InterfaceAPI.init()

    u = Unit.new(footman_type, Player(0), -500, -500)
    u:getParameters():set(ParamAPI.ParamType.Mana, ParamAPI.ValueType.BASE,  500)
    SetUnitManaPercentBJ(u:getObj(), 100)

    u2 = Unit.new(footman_type, Player(1), 0, 0)

    u:getAbilities():set(ExampleAbility, 1)
    local abil = u:getAbilities():get(1)
    abil:setMaxCharges(3)

    InterfaceAPI.Bag:setUnitBag(u:getBag())
    InterfaceAPI.Equip:setUnitEquipment(u:getEquipment())

    local param_table = ParamTable.new()
    param_table:setBackground()
    param_table:setPoint(FRAMEPOINT_CENTER, FRAMEPOINT_CENTER, 0, 0)
    param_table:setUnit(u:getParameters())

    --local targ = TargetUnit.new(u2:getObj())
    --print(targ:getObj())
    --abil:use(targ)

    --UnitAddAbility(u:getObj(), ExampleAbility:getId())
    --u2:destroy()
    --u2.Param:set(Param.ParamType.Health, Param.ValueType.BASE, 1000)

    --u2 = nil

    it = ItemAPI.Item.new(ItemAPI.ItemType.BELT)
    it:getParameters():set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.BASE, 10)
    it:getParameters():set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.MULT, 0.1)
    it:getParameters():set(ParamAPI.ParamType.Armor, ParamAPI.ValueType.ADDIT, 5)

    it_model = ItemAPI.ItemModel.new(0, 0)
    it:setModel(it_model)
    
    --InterfaceAPI.setTarget(u, Player(0))

    --it2 = ItemAPI.newItem(0, 0)
    --it3 = ItemAPI.newItem(0, 0)

    --ItemFrame.new(0.4, 0.3, 0.1, 0.1)
end

]]
--print(btn:getControlDisabledName())
