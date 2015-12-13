local boid = require("boid")
local createwall
createwall = function(x, y, w, h)
  return love.physics.newFixture(love.physics.newBody(world, x, y), love.physics.newRectangleShape(w, h))
end
love.load = function()
  local W, H = love.window.getDimensions()
  boids = { }
  local cell = 10
  local gravity = 98 * cell
  love.physics.setMeter(cell)
  world = love.physics.newWorld(0, 0, true)
  createwall(W / 2, 0, W, 10)
  createwall(W / 2, H, W, 10)
  createwall(W, H / 2, 10, H)
  createwall(0, H / 2, 10, H)
  control = {
    a = {
      desc = "spawn",
      func = function()
        return table.insert(boids, boid(world))
      end
    },
    q = {
      desc = "destroy",
      func = function()
        return table.remove(boids, 1)
      end
    },
    s = {
      desc = "gravity on",
      func = function()
        return world:setGravity(0, gravity)
      end
    },
    d = {
      desc = "gravity off",
      func = function()
        return world:setGravity(0, 0)
      end
    },
    f = {
      desc = "fullscreen on",
      func = function()
        return love.window.setFullscreen(true)
      end
    },
    g = {
      desc = "fullscreen off",
      func = function()
        return love.window.setFullscreen(false)
      end
    }
  }
end
love.draw = function()
  for i, b in pairs(boids) do
    b:draw()
  end
  love.graphics.setColor(255, 255, 255)
  local i = 0
  for k, v in pairs(control) do
    love.graphics.print(k .. " : " .. v.desc, 0, 12 * i)
    i = i + 1
  end
  if x and y then
    return love.graphics.circle("line", x, y, 10)
  end
end
love.update = function(dt)
  x, y = love.mouse.getPosition()
  world:update(dt)
  for i, b in pairs(boids) do
    b:update(dt)
  end
  for k, v in pairs(control) do
    if love.keyboard.isDown(k) then
      v.func()
    end
  end
end
