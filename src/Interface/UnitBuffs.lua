--=========
-- Include
--=========

local Class = require(LibList.ClassLib)

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
local FrameNormalBase = FrameLib.Frame.Normal.Base
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log

--=======
-- Class
--=======

local InterfaceUnitBuffs = Class.new('InterfaceUnitBuffs', FrameNormalBase)
---@class InterfaceUnitBuffs : FrameNormalBase
local public = InterfaceUnitBuffs.public
---@class InterfaceUnitBuffsClass : FrameNormalBaseClass
local static = InterfaceUnitBuffs.static
---@type InterfaceUnitBuffsClass
local override = InterfaceUnitBuffs.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceUnitBuffs
---@param buffs_per_line number
function override.new(buffs_per_line)
    local instance = Class.allocate(InterfaceUnitBuffs)
    instance = FrameNormalBase.new(private.fdf, instance)

    private.newData(instance, buffs_per_line)

    return instance
end

--========
-- Public
--========

function public:setPos(x, y)
    FrameNormalBasePublic.setPos(self, x, y)
    private.update(self)
end

---@param width number
---@param height number
function public:setSize(width, height)
    Log:wrn(tostring(InterfaceUnitBuffs)..': it is autosized frame. Use setBuffIconSize instead.')
end

---@param width number
---@param height number
function public:setBuffIconSize(width, height)
    local priv = private.data[self]
    priv.buff_w = width
    priv.buff_h = height
    private.update(self)
end

---@param flag number
function public:setVisible(flag)
    FrameNormalBasePublic.setVisible(self, flag)
    local priv = private.data[self]

    for i = 1, #private.buffs do
        priv.buff_frames[i]:setVisible(flag)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfaceUnitParametersBackground')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

---@param self InterfaceUnitBuffs
function private.newData(self, buffs_per_line)
    local priv = {
        unit_buffs = nil,
        buff_frames = {},

        buffs_per_line = buffs_per_line,
        buff_w = 0.04,
        buff_h = 0.04
    }
    private.data[self] = priv
end

---@param self InterfaceUnitBuffs
function private.clearFrames(self)
    local priv = private.data[self]

    for i = 1, #priv.buff_frames do
        priv.buff_frames[i]:destroy()
    end
    priv.buff_frames = {}
end

---@param self InterfaceUnitBuffs
---@param lines number
function private.fillBuffs(self, lines)
    local priv = private.data[self]

    local x0 = self:getAbsX() + 0.05 * self:getWidth()
    local y0 = self:getAbsY() + 0.95 * self:getHeight()
    local per_line = priv.per_line

    local w = priv.buff_w
    local h = priv.buff_h
    local i = 0
    for l = 1, lines do
        for p = 1, per_line do
            i = i + 1
            ---@type FrameNormalButton
            local buff = priv.buff_frames[i]
            buff:setSize(w, h)
            buff:setPos(x0 + p * w, y0 - l * h)
        end
    end
end

---@param self InterfaceUnitBuffs
function private.update(self)
    local priv = private.data[self]

    local per_line = private.buffs_per_line
    local count = #priv.buff_frames
    local w = priv.buff_w
    local h = priv.buff_h
    local lines, mod = math.modf(count / per_line)
    if mod ~= 0 then lines = lines + 1 end

    FrameNormalBasePublic.setSize(self,
                                  1 / 0.9 * per_line * w,
                                  1 / 0.9 * lines * h)

    -- Is empty
    if not priv.unit_buffs then
        private.clearFrames(self)
    else
        private.fillBuffs(self, lines)
    end
end

return static