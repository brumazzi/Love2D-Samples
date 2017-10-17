require 'camera'
require 'map'

function love.load()
	cam = Camera
	world = love.physics.newWorld(0,9.8*60,true)
	sky = love.graphics.newImage("sky_101.bmp")

	map = load_map("scenne.dta", world)

	cube = {}
	cube.body = love.physics.newBody(world, 64, 0, "dynamic")
	cube.shape = love.physics.newPolygonShape(0,0,64,0,64,64,0,64)
	cube.fixture = love.physics.newFixture(cube.body, cube.shape)

	WW, WH, WF = love.window.getMode()
	cam.maxX = 32*64-WW
end

function love.update(dt)
	world:update(dt)
	if love.keyboard.isDown("left") then
		local vx,vy = cube.body:getLinearVelocity()
		cube.body:setLinearVelocity(-230, vy)
	elseif love.keyboard.isDown("right") then
		local vx,vy = cube.body:getLinearVelocity()
		cube.body:setLinearVelocity(230, vy)
	end

	local px = cube.body:getX()
	cam:move(px - (cam.x+WW/2),0)
	--[[if cam.x > 0 then
		if px < cam.x + WW/2 + 32 then
			cam:move(px - (cam.x+WW/2),0)
		end
	end
	if cam.x < 32*64-WW then
		if px > cam.x + WW/2 -64 then
			cam:move(px - (cam.x+WW/2),0)
		end
	end]]

	love.window.setTitle(cam.x.."xx"..cube.body:getX())
end

function love.keypressed(key, scancode, isrepeat)
	if scancode == 'space' then
		cube.body:setLinearVelocity(0,-360)
	end
	love.window.setTitle(scancode)
end

function love.keyreleassed(key, scancode)
	local vx, vy = cube.body:getLinearVelocity()
	if scancode == 'left' or scancode == 'right' then
		cube.body:setLinearVelocity(0, vy)
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(sky, 0, 0)
	cam:set()

	map_draw(map)
	love.graphics.polygon("fill", cube.body:getX(), cube.body:getY(), cube.body:getWorldPoints(cube.shape:getPoints()))
	--love.graphics.circle("fill", cube.body:getX(), cube.body:getY(), cube.shape:getRadius())

	cam:unset()
end
