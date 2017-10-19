require 'camera'
require 'map'

function positive(num)
	if num < 0 then
		return -1*num
	end
	return num
end

function love.load()
	cam = Camera
	world = love.physics.newWorld(0,9.8*60,true)
	sky = love.graphics.newImage("sky_101.bmp")

	-- load scane
	map = load_map("scene.dta", world)

	-- create cube object
	cube = {}
	cube.body = love.physics.newBody(world, 64, 0, "dynamic")
	cube.shape = love.physics.newPolygonShape(0,0,32,0,32,32,0,32)
	cube.fixture = love.physics.newFixture(cube.body, cube.shape)

	WW, WH, WF = love.window.getMode() -- get window dimension
	cam.maxX = #map[1]*64-WW -- define cam limits
	cam.maxY = #map*32-WH -- define cam limits
end

function love.update(dt)
	world:update(dt)

	-- move object by key
	if love.keyboard.isDown("left") then
		local vx,vy = cube.body:getLinearVelocity()
		cube.body:setLinearVelocity(-230, vy)
	elseif love.keyboard.isDown("right") then
		local vx,vy = cube.body:getLinearVelocity()
		cube.body:setLinearVelocity(230, vy)
	end

	local px = cube.body:getX()
	local py = cube.body:getY()

	cam:move(px - (cam.x+WW/2), py - (cam.y+WH/2)) -- move cam
end

function love.keypressed(key, scancode, isrepeat)
	-- jump with space
	if scancode == 'space' then
		cube.body:setLinearVelocity(0,-360)
	end
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

	-- set cam
	cam:set()

	-- draw scene
	map_draw(map) 
	love.graphics.setColor(32,74,135)
	love.graphics.polygon("fill", cube.body:getX(), cube.body:getY(), cube.body:getWorldPoints(cube.shape:getPoints()))

	-- unset cam
	cam:unset()
end
