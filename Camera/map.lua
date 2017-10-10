function load_map(name, world)
	local f = io.open(name,"r")
	local content = f:read("*a")
	f:close()

	local map = {{}}
	for i=1, #content, 1 do
		local char = string.sub(content, i, i)
		if char == "\n" then
			table.insert(map, {})
		elseif char == ' ' then
			table.insert(map[#map], '')
		elseif char == 'x' then
			local ground = {}
			ground.body = love.physics.newBody(world, 0, 0)
			ground.shape = love.physics.newPolygonShape(0,0,0,32,32,32,32,0)
			ground.fixture = love.physics.newFixture(ground.body, ground.shape)
			ground.color = {30,160,36}

			table.insert(map[#map], ground)
		end
	end
	
	for i,v1 in pairs(map) do
		for j,v2 in pairs(v1) do
			if v2 ~= '' then
				v2.body:setX((j-1)*32)
				v2.body:setY((i-1)*32)
			end
		end
	end

	return map
end

function map_draw(map)
	for i,v1 in pairs(map) do
		for j,v2 in pairs(v1) do
			if v2 ~= '' then
				love.graphics.setColor(v2.color[1], v2.color[2], v2.color[3])
				love.graphics.polygon("fill", v2.body:getX(), v2.body:getY(), v2.body:getWorldPoints(v2.shape:getPoints()))
			end
		end
	end
end
