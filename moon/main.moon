boid  = require "boid"

createwall = (x,y,w,h) -> 
    love.physics.newFixture love.physics.newBody(world, x, y), love.physics.newRectangleShape(w, h)

love.load = ->
    W,H = love.window.getDimensions!
    export boids = {}
    cell = 10
    gravity = 98*cell
    love.physics.setMeter cell
    export world = love.physics.newWorld 0, 0, true
    createwall W/2, 0,   W,  10
    createwall W/2, H,   W,  10
    createwall W,   H/2, 10, H
    createwall 0,   H/2, 10, H

    export control = {
        a:  {desc: "spawn",          func: -> table.insert boids, boid world }
        q:  {desc: "destroy",        func: -> table.remove boids, 1}
        s:  {desc: "gravity on",     func: -> world\setGravity 0, gravity}
        d:  {desc: "gravity off",    func: -> world\setGravity 0, 0}
        f:  {desc: "fullscreen on",  func: -> love.window.setFullscreen true}
        g:  {desc: "fullscreen off", func: -> love.window.setFullscreen false}
     }

love.draw = -> 
    for i,b in pairs boids do b\draw!
    love.graphics.setColor 255, 255, 255
    i = 0
    for k,v in pairs(control) do
        love.graphics.print k.." : "..v.desc, 0, 12*i
        i+=1
    if x and y then love.graphics.circle "line", x, y, 10

love.update = (dt) -> 
    export x,y = love.mouse.getPosition!
    world\update dt
    for i,b in pairs boids do b\update dt
    for k,v in pairs control do if love.keyboard.isDown k then v.func!
