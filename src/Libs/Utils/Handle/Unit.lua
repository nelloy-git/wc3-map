--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr

local GetUnitX = GetUnitX
local GetUnitY = GetUnitY
local GetUnitFlyHeight = GetUnitFlyHeight
local SetUnitX = SetUnitX
local SetUnitY = SetUnitY
local SetUnitFlyHeight = SetUnitFlyHeight

--=======
-- Class
--=======

local Unit = Class.new('Unit', Handle)
---@class Unit : Handle
local public = Unit.public
---@class UnitClass : HandleClass
local static = Unit.static
---@type UnitClass
local override = Unit.override
local private = {}

--=========
-- Static
--=========

---@param unit_id number
---@param x number
---@param y number
---@param owner player
---@param child_instance Unit | nil
---@return Unit
function override.new(unit_id, x, y, owner, child_instance)
    checkTypeErr(unit_id, 'number', 'unit_id')
    checkTypeErr(x, 'number', 'x')
    checkTypeErr(y, 'number', 'y')
    checkTypeErr(owner, 'player', 'owner')
    if child_instance then
        checkTypeErr(child_instance, Unit, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Unit)
    instance = Handle.new(CreateUnit(owner, unit_id, x, y, 0), RemoveUnit, instance)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetUnitX(self:getHandleData())
end

---@return number
function public:getY()
    return GetUnitY(self:getHandleData())
end

---@return number
function public:getZ()
    return GetUnitFlyHeight(self:getHandleData())
end

---@param x number
function public:setX(x)
    SetUnitX(self:getHandleData(), x)
end

---@param y number
function public:setY(y)
    SetUnitY(self:getHandleData(), y)
end

---@param z number
---@param rate number | nil
function public:setZ(z, rate)
    SetUnitFlyHeight(self:getHandleData(), z, rate or 0)
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

---@param val number
function public:setMana(val)
    SetUnitState(self:getHandleData(), UNIT_STATE_MANA, val)
end

---@return number
function public:getMana()
    return GetUnitState(self:getHandleData(), UNIT_STATE_MANA)
end

---@return number
function public:getHealth()
    return GetUnitState(self:getHandleData(), UNIT_STATE_LIFE)
end

---@param other_unit Unit
---@return boolean
function public:isEnemy(other_unit)
    return IsUnitEnemy(self:getHandleData(), private.data[other_unit].owner)
end

---@param other_unit Unit
---@return boolean
function public:isAlly(other_unit)
    return IsUnitAlly(self:getHandleData(), private.data[other_unit].owner)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
function private.newData(self, owner)
    local priv = {
        owner = owner
    }
    private.data[self] = priv
end

return static