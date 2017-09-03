function love.load()
	world = love.physics.newWorld(0, 0, true)
	ball = {}
	ball.body = love.physics.newBody(world, 320, 360, "dynamic")
	ball.shape = love.physics.newCircleShape(8)
	ball.fixture = love.physics.newFixture(ball.body, ball.shape)

	bar = {}
	bar.body = love.physics.newBody(world, 0, 440, "static")
	bar.shape = love.physics.newPolygonShape(-64,0,64,0,64,16,-64,16)
	bar.fixture = love.physics.newFixture(bar.body, bar.shape)

	wall = {
		top = {},
		left = {},
		right = {}
	}

	wall.top.body = love.physics.newBody(world, 0, 0, "static")
	wall.top.shape = love.physics.newPolygonShape(0,0,640,0,640,20,0,20)
	wall.top.fixture = love.physics.newFixture(wall.top.body, wall.top.shape)
	wall.left.body = love.physics.newBody(world, 0, 0, "static")
	wall.left.shape = love.physics.newPolygonShape(0,0,0,480,20,480,20,0)
	wall.left.fixture = love.physics.newFixture(wall.left.body, wall.left.shape)
	wall.right.body = love.physics.newBody(world, 620, 0, "static")
	wall.right.shape = love.physics.newPolygonShape(0,0,0,480,20,480,20,0)
	wall.right.fixture = love.physics.newFixture(wall.right.body, wall.right.shape)

	ball.fixture:setRestitution(1.052)

	love.mouse.setVisible(false)
	love.window.setMode(640, 480)
	ball.body:setLinearVelocity(60,160)
	love.mouse.setX(640/2)
	love.graphics.setBackgroundColor(10,30,30)

	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	ball.body:setUserData("BALL")
	bar.body:setUserData("BAR")
	wall.top.body:setUserData("WALL")
	wall.left.body:setUserData("WALL")
	wall.right.body:setUserData("WALL")

	local f_block = io.open("scenne.dta")
	local i_block = f_block:read("*a")
	io.close(f_block)

	local i = 0
	block = {}
	local ln = 0
	--[[for i=1, string.len(i_block), 1 do
		local ch = string.sub(i_block, i,i)
		if ch == '1' then
			local body = love.physics.newBody(world, 64*i+64, ln*32+12*i)
			local shape = love.physics.newPolygonShape(0,0,0,32,64,32,64,0)
			local fixture = love.physics.newFixture(body, shape)
			table.insert(block, {
				body = body,
				shape = shape,
				fixture = fixture,
			})
		elseif ch == '\n' then
			ln = ln+1
		end
	end]]
end

function love.update(dt)
	world:update(dt)

	bar.body:setX(love.mouse.getX())
end

function love.draw()
	--love.graphics.setColor(60, 70, 70)
	--love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius()+2)
	love.graphics.setColor(160, 170, 170)
	love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
	love.graphics.setColor(30, 70, 120)
	love.graphics.polygon("fill", bar.body:getX(), bar.body:getY(), bar.body:getWorldPoints(bar.shape:getPoints()))
	love.graphics.setColor(50, 50, 50)
	love.graphics.polygon("fill", wall.top.body:getX(), wall.top.body:getY(), wall.top.body:getWorldPoints(wall.top.shape:getPoints()))
	love.graphics.polygon("fill", wall.left.body:getX(), wall.left.body:getY(), wall.left.body:getWorldPoints(wall.left.shape:getPoints()))
	love.graphics.polygon("fill", wall.right.body:getX(), wall.right.body:getY(), wall.right.body:getWorldPoints(wall.right.shape:getPoints()))

	--for i, b in pairs(block) do
	--	love.graphics.polygon("fill", b.body:getX(), b.body:getY(), b.body:getWorldPoints(b.shape:getPoints()))
	--end
end

function beginContact(a, b, coll)
	local obj1 = a:getBody()
	local obj2 = b:getBody()
	local stat = obj2:getType()

	if obj1:getUserData() == "BAR" then
		calc = obj2:getX() - obj1:getX()
		obj2:setLinearVelocity(calc*6,-160)
	else
		local nor_x, nor_y = coll:getNormal()
		local x,y = obj2:getLinearVelocity()
		if nor_x ~= 0 then
			obj2:setLinearVelocity(nor_x*x, y)
		elseif nor_y ~= 0 then
			obj2:setLinearVelocity(x, nor_y*y)
		end
	end
end
function endContact(a, b, coll)
end
function preSolve(a, b, coll)
end
function postSolve(a, b, coll)
end
