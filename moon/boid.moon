class boid 
    new: (world) =>
        W,H = love.window.getDimensions()
        @r = 10
        @x = math.random 0, W
        @y = math.random 0, H
        @c = {
            math.random(50,255),
            math.random(50,255),
            math.random(50,255)
        }
        @body = love.physics.newBody world, @x + @r, @y + @r, "dynamic"
        @shape = love.physics.newCircleShape @r 
        @fixture = love.physics.newFixture @body, @shape, 1
        @fixture\setRestitution 0.5
        @fixture\setFriction 0.7

    draw: =>
        love.graphics.setColor @c
        love.graphics.circle "fill", @body\getX!, @body\getY!, @shape\getRadius!
    reset: => 
        W,H = love.window.getDimensions()
        @body\setPosition math.random(0,W), math.random(0,H)
    update: (dt) =>
        mx, my = love.mouse.getPosition!
        if love.mouse.isDown "l" then
            @body\applyForce mx - @body\getX!, my - @body\getY!
        if love.mouse.isDown "r" then
            @body\applyForce @body\getX! - mx, @body\getY! - my
        if love.keyboard.isDown "w" then
            @\reset!
        if love.keyboard.isDown "q" then
            @body\setLinearVelocity 0,0 
        

    
boid
