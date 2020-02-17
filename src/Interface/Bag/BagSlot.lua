--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceBagSyncClass
local SyncEvent = require('Interface.Bag.Sync')

--=======
-- Class
--=======

local InterfaceBagSlot = Class.new('InterfaceBagSlot', SimpleFrame)
---@class InterfaceBagSlot : SimpleFrame
local public = InterfaceBagSlot.public
---@class InterfaceBagSlotClass : SimpleFrameClass
local static = InterfaceBagSlot.static
---@type InterfaceBagSlotClass
local override = InterfaceBagSlot.override
local private = {}

--=========
-- Static
--=========

---@param bag InterfaceBag
---@param child_instance InterfaceBagSlot | nil
---@return InterfaceBagSlot
function override.new(bag, child_instance)
    local instance = child_instance or Class.allocate(InterfaceBagSlot)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance, bag)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)
    private.update(self)
end

---@param height any number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param item Item | nil
function public:setItem(item)
    local priv = private.data[self]
    priv.item = item

    if item then
        priv.icon:setTexture(item:getIcon())
        priv.icon:setVisible(true)
    else
        priv.icon:setVisible(false)
    end
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    private.data[self].icon:setTooltip(tooltip)
end

---@return Item | nil
function public:getItem()
    return private.data[self].item
end

---@return InterfaceBag
function public:getBag()
    return private.data[self].bag
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 1 / 16

private.background_type = SimpleFrameType.new('InterfaceBagSlotSlotBackground', true)
private.background_type:setWidth(0.040)
private.background_type:setHeight(0.040)
private.background_type:setTexture(Import.Icon.Empty)

private.icon_type = SimpleButtonType.new('InterfaceBagSlotSlotIcon', true)
private.icon_type:setWidth(0.035)
private.icon_type:setHeight(0.035)
private.icon_type:setTexture('')

---@param self InterfaceBagSlot
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = width * private.border_ratio
    local border_y = height * private.border_ratio

    priv.icon:setX(border_x)
    priv.icon:setY(border_y)
    priv.icon:setWidth(width - 2 * border_x)
    priv.icon:setHeight(height - 2 * border_y)
end

---@param icon SimpleButton
---@param player player
---@param mouse_button mousebuttontype
function private.mousePressCallback(icon, player, mouse_button)
    SyncEvent.startBagSlotPressedEvent(icon:getParent(), player, mouse_button)
end

---@param self InterfaceBagSlot
function private.newData(self, bag)
    local priv = {
        bag = bag,
        icon = SimpleButton.new(private.icon_type),
        item = nil,
    }
    private.data[self] = priv

    local icon = priv.icon
    icon:setParent(self)
    icon:setVisible(false)

    icon:addAction(SimpleButton.ActionType.MousePress, private.mousePressCallback)
end


return static