--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
--endregion

--=======
-- Class
--=======

local AbilityCooldownType = Class.new('AbilityCooldownType')
--region Class
---@class AbilityCooldownType
local public = AbilityCooldownType.public
---@class AbilityCooldownTypeClass
local static = AbilityCooldownType.static
---@type AbilityCooldownTypeClass
local override = AbilityCooldownType.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child_instance AbilityCooldownType | nil
---@return AbilityCooldownType
function override.new(name, child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityCooldownType, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityCooldownType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityCooldownType)
    private.instances[instance] = name

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.instances[self]
end

--- Virtual function
---@param owner Unit
---@return number
function public:getChargesForUse(owner) end
private.virtual_functions['getChargesForUse'] = public.getChargesForUse

--- Virtual function
---@param owner Unit
---@return number
function public:getChargesMax(owner) end
private.virtual_functions['getChargesMax'] = public.getChargesMax

--- Virtual function
---@param owner Unit
---@return number
function public:getChargeCooldown(owner) end
private.virtual_functions['getChargeCooldown'] = public.getChargeCooldown

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.instances = setmetatable({}, {__mode = 'k'})

CompileFinal(function()
    for instance, name in pairs(private.instances) do
        for field, value in pairs(public) do
            local func = private.virtual_functions[field]
            if func ~= nil then
                if value == instance[field] then
                    Log:err(name..': virtual function \"'..field..'\" must be overriden.', 1)
                end
            end
        end
    end
end)

return static