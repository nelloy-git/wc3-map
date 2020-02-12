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

local FrameType = Class.new('FrameType')
---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
local override = FrameType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param createFdf fun(name:string)
---@param child_instance any
---@return FrameType
function static.new(uniq_name, createFdf, child_instance)
    local instance = child_instance or Class.allocate(FrameType)
    private.newData(instance, uniq_name, createFdf)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return boolean
function public:isSimple()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

---@return number
function public:getWidth()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

---@return number
function public:getHeight()
    Log.error(private.data[self].name, 'virtual function is not declared.', 2)
end

---@return FdfObject
function public:getFdf()
    return private.data[self].fdf
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.compiletime_data = CompiletimeData.new(FrameType)

local _ = Compiletime(function()
    ---@type FdfEdit
    private.FdfEdit = require('compiletime.FdfEdit')
    private.FdfFile = private.FdfEdit.File
end)

---@param self FrameType
---@param uniq_name string
---@param createFdf function
function private.newData(self, uniq_name, createFdf)
    local priv = {}

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(FrameType, 'name is not unique.', 3)
        end

        priv.fdf = createFdf(uniq_name)
        local file = private.FdfFile.new(uniq_name)
        file:addObject(priv.fdf)

        private.compiletime_data:set(uniq_name, file:toRuntime().toc)
    end

    priv.name = uniq_name
    priv.toc = private.compiletime_data:get(uniq_name)
    if not IsCompiletime() then
        if not BlzLoadTOCFile(priv.toc) then
            Log.error(FrameType, 'load toc failed.', 3)
        end
    end

    private.data[self] = priv
end


return static