local log_all_changes = false

--=========
-- Include
--=========

local Class = require('Utils.Class.API')
local Log = require('Utils.Log')

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeFile = Class.new('WeFile')
---@class WeFile
local public = WeFile.public
---@class WeFileClass
local static = WeFile.static
---@type WeFileClass
local override = WeFile.override
local private = {}

--========
-- Static
--========

---@param src_path string
---@param dst_path string
---@param child_instance WeFile | nil
---@return WeFile
function override.new(src_path, dst_path, child_instance)
    local instance = child_instance or Class.allocate(WeFile)
    private.newData(instance, src_path, dst_path)

    return instance
end

--========
-- Public
--========

---@param obj WeObject
function public:addObject(obj)
    local priv = private.data[self]
    table.insert(priv.objects, 1, obj)
end

function public:update()
    local priv = private.data[self]

    local content = private.newContent(priv.src_path)
    content = content:sub(1, 8)..WeUtils.int2byte(#priv.objects)..content:sub(13)

    for i = 1, #priv.objects do
        local obj = priv.objects[i]
        local bytes = obj:serialize()

        content = content..bytes
        local str_changes = ''
        if log_all_changes then
            str_changes = '\n'..obj:printChanges()
        end

        local msg = string.format('сreated %s \"%s\" with id \'%s\' based on \'%s\'%s',
                                   obj, obj:getName(), obj:getId(), obj:getBaseId(), str_changes)
        Log(Log.Msg, WeFile, msg)
    end

    local f = assert(io.open(priv.dst_path, "w"))
    f:write(content)
    f:close()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self WeFile
function private.newData(self, src, dst)
    local priv = {
        src_path = src,
        dst_path = dst,
        objects = {}
    }
    private.data[self] = setmetatable(priv, private.metadata)
end

private.metadata = {
    __gc = function(priv)
        local content = private.newContent(priv.src_path)
        content = content:sub(1, 8)..WeUtils.int2byte(#priv.objects)..content:sub(13)

        for i = 1, #priv.objects do
            local obj = priv.objects[i]
            local bytes = obj:serialize()

            content = content..bytes
            local str_changes = ''
            if log_all_changes then
                str_changes = '\n'..obj:printChanges()
            end

            local msg = string.format('сreated %s \"%s\" with id \'%s\' based on \'%s\'%s',
                                       obj, obj:getName(), obj:getId(), obj:getBaseId(), str_changes)
            Log(Log.Msg, WeFile, msg)
        end

        local f = assert(io.open(priv.dst_path, "w"))
        f:write(content)
        f:close() end
}

---@param path string
---@return string
function private.newContent(path)
    local char = string.char
    return char(2)..char(0)..char(0)..char(0)..  -- file version
           char(0)..char(0)..char(0)..char(0)..  -- object tables
           char(0)..char(0)..char(0)..char(0)    -- changes count
end

return WeFile.static