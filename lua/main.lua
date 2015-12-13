local boid  = require("boid")
function love.load()
    W,H = love.window.getDimensions()
    boids = {}
    x = nil
    y = nil
    cell = 10
    love.physics.setMeter(cell)
    gravity = 98*cell
    world = love.physics.newWorld(0, 0, true)
    love.physics.newFixture(love.physics.newBody(world, W/2, 0), love.physics.newRectangleShape(W, 10))
    love.physics.newFixture(love.physics.newBody(world, W/2, H), love.physics.newRectangleShape(W, 10))
    love.physics.newFixture(love.physics.newBody(world, W, H/2), love.physics.newRectangleShape(10, H))
    love.physics.newFixture(love.physics.newBody(world, 0, H/2), love.physics.newRectangleShape(10, H))
     control = {
        ["a"] = {"spawn", function() table.insert(boids,boid:load(world)) end},
        ["q"] = {"destroy", function() table.remove(boids,1)end},
        ["s"] = {"gravity on", function() world:setGravity(0,gravity)end},
        ["d"] = {"gravity off", function() world:setGravity(0,0)end},
        ["f"] = {"fullscreen on", function() love.window.setFullscreen(true)end},
        ["g"] = {"fullscreen off", function() love.window.setFullscreen(false)end},
     }
end
function love.update(dt)
    world:update(dt)
    for i,b in pairs(boids) do
        b:update(dt)
    end
    x,y = love.mouse.getPosition()
    for k,v in pairs(control) do
        if love.keyboard.isDown(k) then
                v[2]()
        end
    end
end
function love.draw()
    for i,b in pairs(boids) do
        b:draw()
    end
    love.graphics.setColor(255,255,255)
    local i = 0
    for k,v in pairs(control) do
        love.graphics.print(k.." : "..v[1],0,12*i)
        i = i + 1
    end
    if x and y then
        love.graphics.circle("line",x,y,10)
    end
end
