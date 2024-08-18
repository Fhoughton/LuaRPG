local bump = require "lib.bump"
local sti = require "lib.sti"

local maps = {}

function maps:load(mapPath)
    mapPath = "maps/" .. mapPath .. ".lua"
    objects = {}
    collision_world = bump.newWorld()
    event_world = bump.newWorld()
  
    player = Player(0, 0, camera)
    table.insert(objects,player)
  
    map = sti(mapPath, {"bump"})
  
    -- Load Map Objects
    if map.layers["Objects"] ~= nil then
        for i,v in ipairs(map.layers.Objects.objects) do
            if v.name == "Box" then
                local newBox = Box(v.x, v.y)
                table.insert(objects,newBox)
                collision_world:add(newBox, v.x, v.y, 32, 32)
                print(v.x, v.y)
            end
        end
        map:removeLayer("Objects")
    else
        --console.warning(("Map %s has no 'Objects' layer! Perhaps it's misnamed?"):format(mapPath))
    end
  
    map:bump_init(collision_world)
  end

function maps:draw() 
    for layerName, layerObject in pairs(map.layers) do
        map:drawLayer(layerObject)
    end
end

function maps:update(dt)
    map:update(dt)
end

return maps