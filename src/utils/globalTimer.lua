---@type TimerAction
local TimerAction = require('utils.timerAction')

---@class Timer
local GlobalTimer = {
    timer = nil,
    cur_time = 0,
    precision = 0.03125,
    ---@type TimerAction[]
    actions = {}
}

function GlobalTimer.init()
    GlobalTimer.timer = CreateTimer()
    TimerStart(GlobalTimer.timer, GlobalTimer.precision, true, GlobalTimer.period)
end

function GlobalTimer.period()
    local cur_time = GlobalTimer.cur_time + GlobalTimer.precision
    if #GlobalTimer.actions == 0 then
        return nil
    end
    ---@type TimerAction
    local action = GlobalTimer.actions[1]
    while action.time <= cur_time do
        action:run()
        table.remove(GlobalTimer.actions, 1)
        action = GlobalTimer.actions[1]
    end
    GlobalTimer.cur_time = cur_time
end

---@param time number
---@param first integer
---@param last integer
---@param list TimerAction[]
local function findPos(time, first, last, list)
    local len = last - first + 1
    if len <= 1 then return 1 end

    local i, _ = math.modf(len / 2)
    local pos = first + i
    if list[pos]:getTime() > time then
        return findPos(time, first, pos - 1, list)
    else
        return findPos(time, pos, last, list)
    end
end

---@param delay number
---@param callback function
---@param data any
---@return TimerAction
function GlobalTimer.addAction(delay, callback, data)
    local time = GlobalTimer.cur_time + delay
    local action = TimerAction.new(time, callback, data)
    local pos = findPos(time, 1, #GlobalTimer.actions, GlobalTimer.actions)
    debug(pos)
    table.insert(GlobalTimer.actions, pos, action)
    debug(#GlobalTimer.actions)
    return action
end

---@param action TimerAction
---@return boolean
function GlobalTimer.removeAction(action)
    local count = #GlobalTimer.actions
    for i = 1, count do
        if GlobalTimer.actions[i] == action then
            table.remove(GlobalTimer.actions, i)
            return true
        end
    end
    return false
end


return GlobalTimer