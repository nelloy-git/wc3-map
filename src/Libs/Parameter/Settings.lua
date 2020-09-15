--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type TypesLib
local TypeLib = lib_dep.Types or error('')
local DamageType = TypeLib.DamageTypeEnum or error('')

--========
-- Module
--========

---@class ParameterSettings
local ParameterSettings = {}

ParameterSettings.PAtk = DamageType.NORMAL
ParameterSettings.MAtk = DamageType.ENHANCED
ParameterSettings.PSpl = DamageType.FORCE
ParameterSettings.MSpl = DamageType.MAGIC

ParameterSettings.PAtkDispersion = 0.3
ParameterSettings.MAtkDispersion = 0.3

ParameterSettings.DamageEventPriority = 0

return ParameterSettings