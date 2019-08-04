---@class Utils
local Utils = {}

---@return string
function  getErrorPos()
    local str = ''
    local i = 2
    while debug.getinfo(i, 'ln') ~= nil do
        local func = debug.getinfo(i, 'lnS')
        local source_type = func.source:sub(#func.source - 3, #func.source)
        if func.source:sub(#func.source - 3, #func.source) == '.lua' then
            str = '  ' .. func.source .. ':' .. tostring(func.currentline) .. '\n' .. str
        end
        i = i + 1
    end
    return str
end

local __real_print = print
function print(...)
    if is_compiletime == true then
        __real_print(...)
    else
        local s = ''
        for i = 1, select('#', ...) do
            local v = select(i, ...)
            local t = type(v)
            if t == 'integer' or t == 'number' or t == 'table' then
                v = tostring(v)
            elseif t == 'nil' then
                v = 'Nil'
            elseif t == 'userdata' then
                v = 'userdata'
            elseif type(v) ~= 'string' then
                v = ''
            end

            s = s..' '..v
        end

        for i = 0, 23 do
            DisplayTimedTextToPlayer(Player(i), 0, 0, 30, '[Debug]: '..s)
        end
    end
end

---@param id integer|string
---@return integer|nil
function ID(id)
    if type(id) == 'string' then
        return string.unpack(">I4", id)
    elseif type(id) == 'number' and math.fmod(id, 1) == 0 then
        return id
    end
    print('Wrong id fromat')
    print(getErrorPos())
    return nil
end

---@param id integer
---@return string
function ID2str(id)
    return string.pack(">I4", id)
end

function player2index(player)
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        if Player(i) == player then return i end
    end
end

return Utils