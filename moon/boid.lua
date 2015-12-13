local boid
do
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(self.c)
      return love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    end,
    reset = function(self)
      local W, H = love.window.getDimensions()
      return self.body:setPosition(math.random(0, W), math.random(0, H))
    end,
    update = function(self, dt)
      local mx, my = love.mouse.getPosition()
      if love.mouse.isDown("l") then
        self.body:applyForce(mx - self.body:getX(), my - self.body:getY())
      end
      if love.mouse.isDown("r") then
        self.body:applyForce(self.body:getX() - mx, self.body:getY() - my)
      end
      if love.keyboard.isDown("w") then
        self:reset()
      end
      if love.keyboard.isDown("q") then
        return self.body:setLinearVelocity(0, 0)
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, world)
      local W, H = love.window.getDimensions()
      self.r = 10
      self.x = math.random(0, W)
      self.y = math.random(0, H)
      self.c = {
        math.random(50, 255),
        math.random(50, 255),
        math.random(50, 255)
      }
      self.body = love.physics.newBody(world, self.x + self.r, self.y + self.r, "dynamic")
      self.shape = love.physics.newCircleShape(self.r)
      self.fixture = love.physics.newFixture(self.body, self.shape, 1)
      self.fixture:setRestitution(0.5)
      return self.fixture:setFriction(0.7)
    end,
    __base = _base_0,
    __name = "boid"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  boid = _class_0
end
return boid
