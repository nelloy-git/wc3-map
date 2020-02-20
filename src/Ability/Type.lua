--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type CompiletimeDataClass
local CompiletimeData = require('Utils.CompiletimeData')

--=======
-- Class
--=======

local AbilityType = Class.new('AbilityType')
---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type AbilityTypeClass
local override = AbilityType.override
local private = {}

--========
-- Static
--========

---@alias AbilityTargetingTypeEnum number

---@type table<string, AbilityTargetingTypeEnum>
static.TargetingType = {}
---@type AbilityTargetingTypeEnum
static.TargetingType.None = 1
---@type AbilityTargetingTypeEnum
static.TargetingType.Point = 2
---@type AbilityTargetingTypeEnum
static.TargetingType.Unit = 3
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitOrPoint = 4
---@type AbilityTargetingTypeEnum
static.TargetingType.PointWithArea = 5
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitWithArea = 6
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitOrPointWithArea = 7

---@alias AbilityStatus number

---@type table<string, AbilityStatus>
static.Status = {}
---@type AbilityStatus
static.Status.OK = 1
---@type AbilityStatus
static.Status.CANCEL = 2
---@type AbilityStatus
static.Status.INTERRUPT = 3
---@type AbilityStatus
static.Status.FINISH = 4
---@type AbilityStatus
static.Status.REMOVE = 5

---@param uniq_name string
---@param target_type AbilityTargetingTypeEnum
---@return AbilityType
function static.new(uniq_name, target_type, child_instance)
    if not child_instance then
        Log.error(AbilityType, 'can not create instance of abstract class', 2)
    end

    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'unknown AbilityTargetingTypeEnum.', 2)
    end

    local instance = child_instance
    private.newData(instance, uniq_name, target_type)

    return instance
end

---@return string
function static.getOrder()
    return private.orderId
end

---@return AbilityType
function static.getInstance(id)
    return private.id2abil[id]
end

--========
-- Public
--========

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return AbilityStatus
function public:start(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return AbilityStatus
function public:cast(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:cancel(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:interrupt(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:finish(caster, target, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getName(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getIcon(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getDescription(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getCastingTime(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getCooldown(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getManaCost(owner, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getRange(owner, lvl)
end

---@return number
function public:getId()
    return private.data[self].id
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.id2abil = setmetatable({}, {__mode = 'kv'})

private.CompiletimeData = CompiletimeData.new(AbilityType)
private.order_func = {
    [static.TargetingType.None] = function(caster, target)
        IssueImmediateOrder(caster:getObj(), private.orderId)
    end,

    [static.TargetingType.Point] = function(caster, target)
        IssuePointOrder(caster:getObj(), private.orderId, target:getX(), target:getY())
    end,

    [static.TargetingType.Unit] = function(caster, target)
        IssueTargetOrder(caster:getObj(), private.orderId, target:getObj())
    end,

    [static.TargetingType.UnitOrPoint] = function(caster, target)  end,
    [static.TargetingType.PointWithArea] = function(caster, target)  end,
    [static.TargetingType.UnitWithArea] = function(caster, target)  end,
    [static.TargetingType.UnitOrPointWithArea] = function(caster, target)  end,
}

if not IsCompiletime() then
    private.local_player = GetLocalPlayer()
end

---@param target_type any
---@return boolean
function private.isTargetType(target_type)
    for _, v in pairs(static.TargetingType) do
        if target_type == v then
            return true
        end
    end
    return false
end

---@param self AbilityType
---@param uniq_name string | number
---@param target_type AbilityTargetingTypeEnum
function private.newData(self, uniq_name, target_type, user_data)
    local priv = {}

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(AbilityType, 'name is not unique.', 2)
        end
        priv.we_abil = private.createWc3Ability(uniq_name, target_type)
        private.CompiletimeData:set(uniq_name, priv.we_abil:getId())
    end

    priv.name = uniq_name
    priv.id = ID(private.CompiletimeData:get(uniq_name))
    priv.target_type = target_type

    private.data[self] = priv
    private.id2abil[priv.id] = self
end

--=============
-- Compiletime
--=============

private.ANcl_TargetType = {
    [static.TargetingType.None] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_None),
    [static.TargetingType.Point] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Point),
    [static.TargetingType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Point),
    [static.TargetingType.Unit] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Unit),
    [static.TargetingType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_UnitOrPoint),
    [static.TargetingType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_UnitOrPoint),
    [static.TargetingType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Unit),
}

private.ANcl_Options = {
    [static.TargetingType.None] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.Point] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
    [static.TargetingType.Unit] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
    [static.TargetingType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
}

private.orderId = Compiletime(function()
    return require('compiletime.ObjectEdit').getOrderId()
end)

-- Compiletime only.
---@param target_type AbilityTargetingTypeEnum
---@param name string
---@return string
function private.createWc3Ability(name, target_type)
    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'wrong target type.', 3)
    end

    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local Field = WeAbility.Field

    local id = ObjEdit.getAbilityId()
    local abil = WeAbility.new(id, 'ANcl', name)

    abil:setField(Field.TooltipNormal, 1, name)
    abil:setField(Field.TooltipNormalExtended, 1, '')
    abil:setField(Field.IconNormal, 0, '')
    abil:setField(Field.CastingTime, 1, 0)
    abil:setField(Field.Cooldown, 1, 0)
    abil:setField(Field.ArtCaster, 0, '')
    abil:setField(Field.ArtEffect, 0, '')
    abil:setField(Field.ArtSpecial, 0, '')
    abil:setField(Field.ArtTarget, 0, '')
    abil:setField(Field.AnimationNames, 0, '')
    abil:setField(Field.ManaCost, 1, 0)
    abil:setField(Field.HotkeyNormal, 0, 'Q')
    abil:setField(Field.ANcl_FollowThroughTime, 1, 0)
    abil:setField(Field.ANcl_TargetType, 1, private.ANcl_TargetType[target_type])
    abil:setField(Field.ANcl_Options, 1, private.ANcl_Options[target_type])
    abil:setField(Field.ANcl_BaseOrderID, 1, private.orderId)

    return abil
end

return static