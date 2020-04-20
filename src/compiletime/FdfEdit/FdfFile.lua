--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.API')

---@type FdfObjectClass
local FdfObject = require('compiletime.FdfEdit.FdfObject')

--=======
-- Class
--=======

local FdfFile = Class.new('FdfFile')
---@class FdfFile
local public = FdfFile.public
---@class FdfFileClass
local static = FdfFile.static
---@type FdfFileClass
local override = FdfFile.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfFile | nil
---@return FdfFile
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfFile)
    private.newData(instance, name)

    return instance
end

--========
-- Public
--========

---@param obj FdfObject
function public:addObject(obj)
    local priv = private.data[self]
    table.insert(priv.objects, #priv.objects + 1, obj)
end

---@return table
function public:toRuntime()
    local priv = private.data[self]

    local res = {}
    res.fdf = string.gsub(private.dst_path..priv.name..'.fdf', '\\', '\\\\')
    res.toc = string.gsub(private.dst_path..priv.name..'.toc', '\\', '\\\\')
    for i = 1, #priv.objects do
        res[priv.objects[i]:getName()] = priv.objects[i]:toRuntime()
    end
    return res
end

function public:free()
    private.save(self)
    private.free(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

local sep = package.config:sub(1,1)
private.dst_path = 'war3mapImported'..sep..'GeneratedFdfFiles'..sep
private.full_dst_path = GetDstDir()..sep..private.dst_path

---@param self FdfFile
---@param name string
function private.newData(self, name)
    ---@class FdfFilePrivate
    local priv = {
        name = name,
        objects = {}
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(priv)
        local log_msg = string.format("created new %s fdf file.", priv.name)
        local content = ""

        for i = 1, #priv.objects do
            local obj = priv.objects[i]
            local obj_string = obj:serialize().."\n\n"
            content = content..obj_string

            log_msg = log_msg..string.format('\n\tadded %s object.', obj:getName())
        end
        --Log(Log.Msg, FdfFile, log_msg)

        local dir = private.full_dst_path
        if not private.isFileExists(dir) then
            os.execute('mkdir '..dir)
        end

        local fdf = assert(io.open(private.full_dst_path..priv.name..'.fdf', "w"))
        fdf:write(content)
        fdf:close()

        local toc = assert(io.open(private.full_dst_path..priv.name..'.toc', "w"))
        toc:write(private.dst_path..priv.name..".fdf\n")
        toc:close()
    end
}

---@param path string
function private.isFileExists(path)
    local ok, _, code = os.rename(path, path)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok
end

-- Clear previous files
if private.isFileExists(private.full_dst_path) then
    local home = os.getenv('HOME')
    if not home then --Windows
        os.execute('del /q '..private.full_dst_path..'*')
        os.execute('for /d %x in ('..private.full_dst_path..'*) do @rd /s /q \"%x\"')
    else
        os.execute('rm -r '..private.full_dst_path)
    end
end

return static