--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type ParameterClass
local Parameter = require(lib_path..'Parameter') or error('')

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

---@param param Parameter
---@return ParameterValue
function override.new(param)
    isTypeErr(param, Parameter, 'param')

    local instance = Class.allocate(ParameterValue)
    private.newData(instance, param)

    return instance
end

--========
-- Public
--========

---@return Parameter
function public:getParameter()
    return private.data[self].param
end

---@param value number
---@return number
function public:addBase(value)
    local priv = private.data[self]
    priv.base = priv.base + value
    priv.res = priv.base * priv.mult + priv.addit
    return priv.res
end

---@param value number
---@return number
function public:addMult(value)
    local priv = private.data[self]
    priv.mult = priv.mult + value
    priv.res = priv.base * priv.mult + priv.addit
    return priv.res
end

---@param value number
---@return number
function public:addAddit(value)
    local priv = private.data[self]
    priv.addit = priv.addit + value
    priv.res = priv.base * priv.mult + priv.addit
    return priv.res
end

---@return number
function public:getBase()
    return private.data[self].base
end

---@return number
function public:getMult()
    return private.data[self].mult
end

---@return number
function public:getAddit()
    return private.data[self].addit
end

---@return number
function public:getResult()
    return private.data[self].res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValue
---@param param Parameter
function private.newData(self, param)
    local priv = {
        param = param,
        base = param:getDefault(),
        mult = 1,
        addit = 0,
        res = param:getDefault(),
        is_res_ready = true,
    }

    private.data[self] = priv
end

return static