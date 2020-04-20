--=========
-- Include
--=========

local Class = require('Utils.Class.API')
local Log = require('Utils.Log')

--=======
-- Class
--=======

local ParameterValue = Class.new('ParameterValue')

---@class ParameterValue
local public = ParameterValue.public
---@class ParameterValueClass
local static = ParameterValue.static
---@type ParameterValueClass
local override = ParameterValue.override
local private = {}


--========
-- Static
--========

---@alias ParameterValueTypeEnum number

---@type table<string,ParameterValueTypeEnum>
static.ValuePos = {}
---@type ParameterValueTypeEnum
static.ValuePos.BASE = 1
---@type ParameterValueTypeEnum
static.ValuePos.MULT = 2
---@type ParameterValueTypeEnum
static.ValuePos.ADDIT = 3

---@return ParameterValue
function override.new()
    local instance = Class.allocate(ParameterValue)
    private.newData(instance)

    return instance
end


--========
-- Public
--========

---@param value_type ParameterValueTypeEnum
---@param value number
function public:set(value_type, value)
    if not private.isValueType(value_type) then
        Log.error(self, 'unknown ParameterValueTypeEnum', 2)
    end
    private.data[self][value_type] = value
end

---@param value_type ParameterValueTypeEnum
---@param value number
function public:add(value_type, value)
    if not private.isValueType(value_type) then
        Log.error(self, 'unknown ParameterValueTypeEnum', 2)
    end
    private.data[self][value_type] = private.data[self][value_type] + value
end

---@param value_type ParameterValueTypeEnum
---@return number
function public:get(value_type)
    if not private.isValueType(value_type) then
        Log.error(self, 'unknown ParameterValueTypeEnum', 2)
    end
    return private.data[self][value_type]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

function private.isValueType(value_type)
    for _, v in pairs(static.ValuePos) do
        if value_type == v then
            return true
        end
    end
    return false
end

private.default_value = {
    [static.ValuePos.BASE] = 0,
    [static.ValuePos.MULT] = 1,
    [static.ValuePos.ADDIT] = 0,
}

---@param self ParameterValue
function private.newData(self)
    local priv = {}
    for _, value_type in pairs(static.ValuePos) do
        priv[value_type] = private.default_value[value_type]
    end

    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(priv) end
}

return static