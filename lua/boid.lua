local boid = {}
boid.__index = boid
function boid:load(world)
    local o = {}
    local W,H = love.window.getDimensions()
    o.x = math.random(0,W)
    o.y = math.random(0,H)
    o.c = {math.random(50,255),math.random(50,255),math.random(50,255)}
    o.r = 10
    o.body = love.physics.newBody(world, o.x + o.r, o.y + o.r, "dynamic") 
    o.shape = love.physics.newCircleShape( o.r )
    o.fixture = love.physics.newFixture(o.body, o.shape, 1)
    o.fixture:setRestitution(0.5)
    o.fixture:setFriction(0.7)
    setmetatable(o,self)
    return o
end
function boid:update(dt)
    local mx, my = love.mouse.getPosition()
    if love.mouse.isDown("l") then
        self.body:applyForce(mx - self.body:getX(), my - self.body:getY())
        --self.body:setLinearVelocity(mx - self.body:getX(), my - self.body:getY())
        --self.x = self.x - (self.x - mx)*dt
        --self.y = self.y - (self.y - my)*dt
    end
    if love.mouse.isDown("r") then
        self.body:applyForce(self.body:getX() - mx, self.body:getY() - my)
    end
    if love.keyboard.isDown("w") then
            self:reset()
    end
    if love.keyboard.isDown("q") then
        self.body:setLinearVelocity(0,0)
    end
end
function boid:draw()
    love.graphics.setColor(self.c)
    love.graphics.circle("fill",self.body:getX(),self.body:getY(),self.shape:getRadius())
end
function boid:reset()
    self.body:setPosition(math.random(0,W),math.random(0,H))
end
return boid
