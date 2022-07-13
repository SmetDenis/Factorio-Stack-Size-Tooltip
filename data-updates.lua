--[[
Prototypes (https://wiki.factorio.com/Prototype_definitions)

Prototype/Item                            item
    Prototype/AmmoItem                    ammo
    Prototype/Capsule                     capsule
    Prototype/Gun                         gun
    Prototype/ItemWithEntityData          item-with-entity-data
    Prototype/ItemWithLabel               item-with-label
        Prototype/ItemWithInventory       item-with-inventory
            Prototype/BlueprintBook       blueprint-book
        Prototype/ItemWithTags            item-with-tags
        Prototype/SelectionTool           selection-tool
            Prototype/BlueprintItem       blueprint
            Prototype/CopyPasteTool       copy-paste-tool
            Prototype/DeconstructionItem  deconstruction-item
            Prototype/UpgradeItem         upgrade-item
    Prototype/Module                      module
    Prototype/RailPlanner                 rail-planner
    Prototype/Tool                        tool
        Prototype/Armor                   armor
        Prototype/MiningTool              mining-tool (for migration, cannot be used)
        Prototype/RepairTool              repair-tool
]]

-- set to true if log should show all touched items
local debug = false

-- Append only stack size as description
function set_simple_description(item)
    if item == nil then return end

    if item.stack_size ~= nil then
		local tmp = item.localised_description
		if tmp == nil then tmp = "" end
        item.localised_description = {"", tmp, {"other.stack-size-description", 
		item.stack_size}}
        if debug == true then 
            log(
                "S: " .. 
                item.type .. 
                " / " .. 
                item.name .. 
                " / stack size: " .. 
                item.stack_size
            )
        end    end
end

-- Combine stack size with initial description
function set_extended_description(item, description)
    if item == nil then return end
    if description == nil then description = {"item-description." .. item.name} end

    if item.stack_size ~= nil then
		local tmp = item.localised_description
		if tmp == nil then tmp = "" end
        item.localised_description = {"", tmp,  {"other.stack-size-description", item.stack_size}, "\n", description}
        if debug == true then 
            log(
                "E: " .. 
                item.type .. 
                " / " .. 
                item.name .. 
                " / stack size: " .. 
                item.stack_size
            )
        end
    end
end

-- Iterate over items with given prototype and set description
function get_items_from_prototype(prototype)
    if prototype == nil then return end

    for _, item in pairs(data.raw[prototype]) do
        set_simple_description(item)
    end
end

-- Prototype/Item
for _, item in pairs(data.raw["item"]) do
    if 
        item.name == "battery-equipment" or 
        item.name == "battery-mk2-equipment" 
    then
        set_extended_description(item, {"item-description.battery-equipment"})
    elseif 
        item.name == "energy-shield-equipment" or 
        item.name == "energy-shield-mk2-equipment" 
    then
        set_extended_description(item, {"item-description.energy-shield-equipment"})
    elseif 
        item.name == "personal-roboport-equipment" or 
        item.name == "personal-roboport-mk2-equipment" 
    then
        set_extended_description(item, {"item-description.personal-roboport-equipment"})
    elseif 
        item.name == "belt-immunity-equipment" or 
        item.name == "copper-cable" or 
        item.name == "red-wire" or 
        item.name == "green-wire" or 
        item.name == "landfill" or 
        item.name == "discharge-defense-equipment" or
        item.name == "exoskeleton-equipment" or 
        item.name == "fusion-reactor-equipment" or 
        item.name == "solar-panel-equipment" or
        item.name == "night-vision-equipment" or 
        item.name == "land-mine" or 
        item.name == "satellite" or 
        item.name == "satellite" 
    then
        set_extended_description(item) 
    elseif 
        item.name == "centrifuge" or 
        item.name == "logistic-robot" or 
        item.name == "construction-robot" or 
        item.name == "logistic-chest-active-provider" or 
        item.name == "logistic-chest-passive-provider" or 
        item.name == "logistic-chest-storage" or 
        item.name == "logistic-chest-buffer" or 
        item.name == "logistic-chest-requester" or 
        item.name == "splitter" or 
        item.name == "fast-splitter" or 
        item.name == "express-splitter" or 
        item.name == "flamethrower-turret" or 
        item.name == "artillery-turret" or 
        item.name == "power-switch" or 
        item.name == "radar" or 
        item.name == "beacon" or 
        item.name == "arithmetic-combinator" or 
        item.name == "decider-combinator" or 
        item.name == "constant-combinator" or 
        item.name == "boiler" or 
        item.name == "nuclear-reactor" or 
        item.name == "heat-exchanger" or 
        item.name == "steam-engine" or 
        item.name == "steam-turbine" or 
        item.name == "accumulator" or 
        item.name == "offshore-pump" or 
        item.name == "rocket-silo" or 
        item.name == "train-stop" or 
        item.name == "rail-signal" or 
        item.name == "rail-chain-signal" or 
        item.name == "item-request-proxy" or 
        item.name == "crash-site-assembling-machine-1-broken" or 
        item.name == "crash-site-assembling-machine-2-broken" or 
        item.name == "crash-site-assembling-machine-1-repaired" or 
        item.name == "crash-site-assembling-machine-2-repaired" or 
        item.name == "crash-site-lab-broken" or 
        item.name == "crash-site-lab-repaired" or 
        item.name == "crash-site-generator" or 
        item.name == "crash-site-chest-1" or 
        item.name == "crash-site-chest-2" or 
        item.name == "big-ship-wreck-1" or 
        item.name == "big-ship-wreck-2" or 
        item.name == "big-ship-wreck-3" or 
        item.name == "compilatron" or 
        item.name == "compilatron-chest" or 
        item.name == "roboport" or 
        item.name == "programmable-speaker" 
    then
        set_extended_description(item, {"entity-description." .. item.name}) 
    else
        set_simple_description(item)
    end
end

-- Prototype/AmmoItem
get_items_from_prototype("ammo")

-- Prototype/Capsule
for _, item in pairs(data.raw.capsule) do
    if 
        item.name == "artillery-targeting-remote" or 
        item.name == "slowdown-capsule" 
    then 
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/Gun
get_items_from_prototype("gun")

-- Prototype/ItemWithEntityData
for _, item in pairs(data.raw["item-with-entity-data"]) do
    if 
        item.name == "locomotive" or 
        item.name == "car" or 
        item.name == "tank"
    then
        set_extended_description(item, {"entity-description." .. item.name}) 
    else
        set_simple_description(item)
    end
end

-- Prototype/ItemWithLabel
get_items_from_prototype("item-with-label")

-- Prototype/ItemWithInventory
get_items_from_prototype("item-with-inventory")

-- Prototype/BlueprintBook
get_items_from_prototype("blueprint-book")

-- Prototype/ItemWithTags
get_items_from_prototype("item-with-tags")

-- Prototype/SelectionTool
get_items_from_prototype("selection-tool")

-- Prototype/BlueprintItem
for _, item in pairs(data.raw["blueprint"]) do
    if 
        item.name == "blueprint" 
    then
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/DeconstructionItem
for _, item in pairs(data.raw["deconstruction-item"]) do
    if 
        item.name == "deconstruction-planner" 
    then
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/UpgradeItem
for _, item in pairs(data.raw["upgrade-item"]) do
    if 
        item.name == "upgrade-planner" 
    then
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/Module
for _, item in pairs(data.raw["module"]) do
    if 
        item.name == "speed-module" or 
        item.name == "speed-module-2" or 
        item.name == "speed-module-3" 
    then 
        set_extended_description(item, {"item-description.speed-module"})
    elseif 
        item.name == "effectivity-module" or 
        item.name == "effectivity-module-2" or 
        item.name == "effectivity-module-3" 
    then 
        set_extended_description(item, {"item-description.effectivity-module"})
    elseif 
        item.name == "productivity-module" or 
        item.name == "productivity-module-2" or 
        item.name == "productivity-module-3" 
    then 
        set_extended_description(item, {"item-description.productivity-module"})
    else
        set_simple_description(item)
    end
end

-- Prototype/RailPlanner
for _, item in pairs(data.raw["rail-planner"]) do
    if 
        item.name == "rail" 
    then
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/Tool
for _, item in pairs(data.raw["tool"]) do
    if 
        item.name == "automation-science-pack" or 
        item.name == "logistic-science-pack" or 
        item.name == "chemical-science-pack" or
        item.name == "military-science-pack" or 
        item.name == "production-science-pack" or 
        item.name == "utility-science-pack" 
    then  
        set_extended_description(item, {"item-description.science-pack"})
    elseif 
        item.name == "space-science-pack" 
    then 
        set_extended_description(item)
    else
        set_simple_description(item)
    end
end

-- Prototype/Armor
get_items_from_prototype("armor")

-- Prototype/MiningTool
for _, item in pairs(data.raw["mining-tool"]) do
    if 
        item.name == "dummy-steel-axe" 
    then
        set_extended_description(item, {"item-description.mining-tool"})
    else
        set_simple_description(item)
    end
end

-- Prototype/RepairTool
for _, item in pairs(data.raw["repair-tool"]) do
    if 
        item.name == "repair-pack" 
    then
        set_extended_description(item, {"item-description.repair-pack"})
    else
        set_simple_description(item)
    end
end