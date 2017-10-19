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
	sky = love.graphics.newImage("sky_101.png")

	arrow = love.graphics.newImage("arrow.png")

	-- load scane
	map = load_map("scene", world)

	-- create cube object
	cube = {}
	cube.body = love.physics.newBody(world, 64, 32, "dynamic")
	cube.shape = love.physics.newPolygonShape(-16,-16,16,-16,16,16,-16,16)
	cube.fixture = love.physics.newFixture(cube.body, cube.shape)

	WW, WH, WF = love.window.getMode() -- get window dimension
	cam.maxX = #map[1]*64-WW -- define cam limits
	cam.maxY = #map*32-WH -- define cam limits

	world:setCallbacks(beginContact, nil, nil, nil)
	COIN = 5
	v = 0
	speed = 0
	os = love.system.getOS()
end

function love.update(dt)
	world:update(dt)
	local vx,vy = cube.body:getLinearVelocity()

	-- move object by key
	if love.keyboard.isDown("left") then
		speed = -230
	elseif love.keyboard.isDown("right") then
		speed = 230
	end
	cube.body:setLinearVelocity(speed, vy)

	local px = cube.body:getX()+16
	local py = cube.body:getY()+16

	cam:move(px - (cam.x+WW/2), py - (cam.y+WH/2)) -- move cam

	if COIN == 0 then
		love.window.showMessageBox("Game Over", "You Win", "info", false)
		os.exit()
	end
end

function love.keypressed(key, scancode, isrepeat)
	-- jump with space
	if scancode == 'space' then
		cube.body:setLinearVelocity(0,-360)
	end
end

function love.keyreleased(key, scancode)
	local vx, vy = cube.body:getLinearVelocity()
	if scancode == 'left' or scancode == 'right' then
		love.window.setTitle(scancode)
		speed = 0
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(sky, 0, 0)

	-- set cam
	cam:set()

	-- draw scene
	map_draw(map) 
	love.graphics.setColor(204,0,0)
	love.graphics.polygon('fill', cube.body:getWorldPoints(cube.shape:getPoints()))

	-- unset cam
	cam:unset()

	if os == "Android" or os == 'iOS' then

		a1_pos = {16, WH-arrow:getHeight()-16}
		a2_pos = {arrow:getWidth()*2+32, WH-arrow:getHeight()-16}
		a3_pos = {WW-16, WH-arrow:getHeight()-48}

		love.graphics.draw(arrow, a1_pos[1], a1_pos[2])
		love.graphics.draw(arrow, a2_pos[1], a2_pos[2], 0, -1, 1)
		love.graphics.draw(arrow, a3_pos[1], a3_pos[2], 33)
	end
end

function beginContact(a, b, coll)
	local o1 = a:getBody()
	local o2 = b:getBody()

	local os = {o1, o2}
	local td = nil

	for index, obj in pairs(os) do
		if obj:getUserData() then
			local udata = obj:getUserData()
			if udata[1] == "COIN" then
				love.window.setTitle(udata[2].."x"..udata[3])
				map[udata[2]][udata[3]] = nil
				love.timer.sleep(0.001)
				obj:destroy()
				COIN = COIN - 1
				return
			end
		end
	end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
	if x > a1_pos[1] and y > a1_pos[2] and x < a1_pos[1]+arrow:getWidth() and y < a1_pos[2]+arrow:getHeight() then
		speed = -230
	elseif x > a2_pos[1] and y > a2_pos[2] and x < a2_pos[1]+arrow:getWidth() and y < a2_pos[2]+arrow:getHeight() then
		speed = 230
	elseif x > a3_pos[1] and y > a3_pos[2] and x < a3_pos[1]+arrow:getWidth() and y < a3_pos[2]+arrow:getHeight() then
		cube.body:setLinearVelocity(0,-360)
	end
end
