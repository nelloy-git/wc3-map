--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
BlzFrameClearAllPoints(handle)
--- Can not be moved outside of default 0.8x0.6 box.
---@class ChatEditBox
local ChatEditBox = FrameNormalBase.new(handle)
ChatEditBox:setParent(nil)

return ChatEditBox