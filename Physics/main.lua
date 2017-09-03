require 'wobject'

function love.load()
	love.physics.setMeter(60)
	world = love.physics.newWorld(0, 9.8*60, true)

	ground = WObject.new(world, love.physics.newPolygonShape({0,260,0,440,580,440}), {10,0})
	ball = WObject.new(world, love.physics.newCircleShape(30), {30,30}, "dynamic")
	ball.fixture:setRestitution(0.7)

	love.window.setMode(640,480)
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	love.graphics.setColor(32,120, 14)
	love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))
	love.graphics.setColor(72,60, 130)
	love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
end
