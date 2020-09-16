--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

---@class AssetLoader
local Loader = {}

local refs = {}
local loaded = {}
CompiletimeFinalToRuntime(function()
    loaded = Compiletime(function()
        local cache = {}
        for path, ref in pairs(refs) do
            for key, count in pairs(ref) do
                if not cache[path] then
                    cache[path] = {}
                end
                cache[path][key] = loaded[path][key]
            end
        end
        return cache
    end)
end)

local function index(self, key, module)
    if not refs[module] then
        refs[module] = {}
    end
    refs[module][key] = (refs[module][key] or 0) + 1

    return loaded[module][key]
end

---@param package_name string
local function name2path(package_name)
    if type(package_name) ~= 'string'  then
        error('wront package name type.', 3)
    end
    local sep = package.config:sub(1,1)
    return GetSrcDir()..package_name:gsub('%.', sep)..'.lua'
end

--- Loads table from file and transfer used data to runtime.
---@param module string
---@param dst table
function Loader.load(module, dst)
    if IsCompiletime() then
        local file = loadfile(name2path(module))
        loaded[module] = file()
        if type(loaded[module]) ~= 'table' then
            Log:err('AssetLoader can load tables only.', 2)
        end
        if getmetatable(loaded[module]) ~= nil then
            Log:err('AssetLoader can not load table with metatable.', 2)
        end
    end

    local meta = {
        __index = function(self, key)
            return index(self, key, module)
        end
    }
    return setmetatable(dst, meta)
end

return Loader