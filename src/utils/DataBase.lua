---@class DataBase
local DataBase = {}
local DataBase_meta = {
    __index = DataBase
}

---@param key_type string
---@param value_type string
---@return DataBase
function DataBase.new(key_type, value_type)
    ---@type DataBase
    local db = {
        __key_type = key_type,
        __value_type = value_type
    }
    setmetatable(db, DataBase_meta)
    return db
end

---@param key any
---@param value any
function DataBase:add(key, value)
    if type(key) ~= self.__key_type then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
    end
    if type(value) ~=self.__value_type then
        error("DataBase: wrong value type. Need "..self.__value_type.." got "..type(value))
    end
    self[key] = value
end

---@param key any
function DataBase:remove(key)
    if type(key) ~= self.__key_type then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
    end
    self[key] = nil
end

---@param key any
---@return any
function DataBase:get(key)
    if key ~= nil and type(key) ~= self.__key_type then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
    end
    return self[key]
end

return DataBase