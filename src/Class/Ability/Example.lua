--=========
-- Include
--=========

local Log = require('utils.Log')

---@type AbilityTypeClass
local Type = require('Class.Ability.Type')
---@type AbilityCastInstanceClass
local CastInstance = require('Class.Ability.CastInstance')
---@type BetterTimerClass
local Timer = require('Class.Timer.BetterTimer')

local Event = require('Class.Ability.Event')

local fmt = string.format

--=========
-- Ability
--=========

-- Ability type for using in casting system.
local ExampleAbility = Type.new('Example ability', Type.TargetType.None)

-- ===========
--  Callbacks
-- ===========

---@param cast_data AbilityCastInstance
---@return number
local function getCastingTime(cast_data)
    local caster = cast_data:getCaster()
    local full_time = BlzGetUnitMaxHP(caster) / 100
    if full_time < 3 then
        full_time = 3
    end
    Log(Log.Msg, ExampleAbility:getName(), fmt('full casting time = %.2f (MaxHP / 100, min = 3)', full_time))
    return full_time
end

local state = 'normal'
---@param cast_data AbilityCastInstance
---@return boolean
local function start(cast_data)
    Log(Log.Msg, ExampleAbility:getName(), 'got casting started event. Use more times for different tests.')

    local caster = cast_data:getCaster()
    Log(Log.Msg, ExampleAbility:getName(), fmt('caster %s.', caster))
    if state == 'normal' then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to start normally.')
        state = 'failed'
        return Type.Status.OK
    elseif state == 'failed' then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have not to start.')
        state = 'interrupt'
        return Type.Status.REMOVE
    elseif state == 'interrupt' then
        local interrupt_time = cast_data:getFullCastingTime() / 2
        Log(Log.Msg, ExampleAbility:getName(), fmt('casting have to be interrupted after %.2f sec.', interrupt_time))
        Timer.getGlobalTimer():addAction(interrupt_time, function() cast_data:interrupt() end)
        state = 'cancel'
        return Type.Status.OK
    else
        local cancel_time = cast_data:getFullCastingTime() / 2
        Log(Log.Msg, ExampleAbility:getName(), fmt('casting have to be canceled after %.2f sec.', cancel_time))
        Timer.getGlobalTimer():addAction(cancel_time, function() cast_data:cancel() end)
        state = 'normal'
        return Type.Status.OK
    end
end

local prev = -1
---@param cast_data AbilityCastInstance
---@return boolean
local function casting(cast_data)
    local cur = cast_data:getCastingTimeLeft()
    cur = math.floor(5 * cur) / 5
    if math.floor(cur) ~= prev then
        Log(Log.Msg, ExampleAbility:getName(), fmt('casting time - %.1f', cur))
        prev = math.floor(cur)
    end
    return Type.Status.OK
end

---@param cast_data AbilityCastInstance
local function finish(cast_data)
    Log(Log.Msg, ExampleAbility:getName(), 'casting finished')
end

---@param cast_data AbilityCastInstance
local function cancel(cast_data)
    Log(Log.Msg, ExampleAbility:getName(), 'casting canceled')
end

---@param cast_data AbilityCastInstance
local function interrupt(cast_data)
    Log(Log.Msg, ExampleAbility:getName(), 'casting interrupted')
end

-- Set function for casting time calculating.
ExampleAbility:setCallback(Type.CallbackType.GET_TIME, getCastingTime)
-- Set callback for casting start. Should return true(default) if started successfully.
ExampleAbility:setCallback(Type.CallbackType.START, start)
-- Set callback for casting time loop. Have to return false if casting is interupted.
ExampleAbility:setCallback(Type.CallbackType.CASTING, casting)
-- Set callback for casting finish.
ExampleAbility:setCallback(Type.CallbackType.FINISH, finish)
-- Set callback for casting cancel.
ExampleAbility:setCallback(Type.CallbackType.CANCEL, cancel)
-- Set callback for casting interruption.
ExampleAbility:setCallback(Type.CallbackType.INTERRUPT, interrupt)

return ExampleAbility