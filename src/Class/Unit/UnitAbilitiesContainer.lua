--=========
-- Include
--=========

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
---@type AbilityCastingClass
local AbilityCasting = require('Class.Ability.AbilityCasting')

--=======
-- Class
--=======

---@type UnitAbilitiesContainerClass
local UnitAbilitiesContainer = newClass('UnitAbilitiesContainer')

---@class UnitAbilitiesContainer
local public = UnitAbilitiesContainer.public
---@class UnitAbilitiesContainerClass
local static = UnitAbilitiesContainer.static
---@type table
local override = UnitAbilitiesContainer.override
---@type table(UnitAbilitiesContainer, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return UnitAbilitiesContainer
function static.new(instance_data)
    local instance = instance_data or newInstanceData(UnitAbilitiesContainer)
    local priv = {
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

return UnitAbilitiesContainer