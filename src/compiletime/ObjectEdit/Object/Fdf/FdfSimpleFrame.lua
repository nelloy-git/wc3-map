--=========
-- Include
--=========

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfObjectClass
local FdfObject = require('compiletime.ObjectEdit.FdfObject')

--=======
-- Class
--=======

---@type FdfSimpleFrameClass
local FdfSimpleFrame = newClass('FdfSimpleFrame', FdfObject)

---@class FdfSimpleFrame
local public = FdfSimpleFrame.public
---@class FdfSimpleFrameClass
local static = FdfSimpleFrame.static
---@type table
local override = FdfSimpleFrame.override
---@type table(FdfSimpleFrame, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSimpleFrame
function override.new(name, instance_data)
    local instance = instance_data or newInstanceData(FdfSimpleFrame)
    instance = FdfObject.new('SIMPLEFRAME', name, instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.serialize_NoArgs)
static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.String = FdfField.new('', 'table', FdfField.serialize_SubobjectList)
static.Texture = FdfField.new('', 'table', FdfField.serialize_SubobjectList)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfSimpleFrame