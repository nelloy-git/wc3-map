--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

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
---@param child Unit | nil
---@return Unit
function override.new(unit_id, x, y, owner, child)
    isTypeErr(unit_id, 'number', 'unit_id')
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y')
    isTypeErr(owner, 'player', 'owner')
    if child then
        isTypeErr(child, Unit, 'child')
    end

    local instance = child or Class.allocate(Unit)
    instance = Handle.new(CreateUnit(owner, unit_id, x, y, 0), RemoveUnit, instance)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetUnitX(self:getData())
end

---@return number
function public:getY()
    return GetUnitY(self:getData())
end

---@return number
function public:getZ()
    return GetUnitFlyHeight(self:getData())
end

---@param x number
function public:setX(x)
    SetUnitX(self:getData(), x)
end

---@param y number
function public:setY(y)
    SetUnitY(self:getData(), y)
end

---@param z number
---@param rate number | nil
function public:setZ(z, rate)
    SetUnitFlyHeight(self:getData(), z, rate or 0)
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

---@param val number
function public:setMana(val)
    SetUnitState(self:getData(), UNIT_STATE_MANA, val)
end

---@return number
function public:getMana()
    return GetUnitState(self:getData(), UNIT_STATE_MANA)
end

---@return number
function public:getMaxMana()
    return GetUnitState(self:getData(), UNIT_STATE_MAX_MANA)
end

---@return number
function public:getHealth()
    return GetUnitState(self:getData(), UNIT_STATE_LIFE)
end

---@return number
function public:getMaxHealth()
    return GetUnitState(self:getData(), UNIT_STATE_MAX_LIFE)
end

---@param other_unit Unit
---@return boolean
function public:isEnemy(other_unit)
    return IsUnitEnemy(self:getData(), private.data[other_unit].owner)
end

---@param other_unit Unit
---@return boolean
function public:isAlly(other_unit)
    return IsUnitAlly(self:getData(), private.data[other_unit].owner)
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