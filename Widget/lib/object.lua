-- Love script
--
-- Here contains functions and object base of
-- all others objects.
--
local object = {}
local object_base = {
	x=0,
	y=0,
	width = 0,
	height = 0,
	depth = 0,
	visible = true,
	image = nil,
	collision_area = {},
	-- functions of object
	mousePressed = nil, -- function(x, y, button, istouch)
	mouseReleased = nil, -- function(x, y, button, istouch)
	keyPressed = nil, -- function(key, [scancode, unicode], [isrepeat])
	keyReleased = nil, -- function(key, [scancode])
	click = nil
}

function object.new()
	local _new = {}
	setmetatable(_new, {__index = object_base})
	return _new
end

function object_base:destroy()
	self = nil
end

-- add new collision area im object
-- starting in position x and y, and
-- going to width and height of the
-- object
function object_base:addCollisionArea(id, x, y, w, h, callback)
	local area_c = {
		id = id,
		x = x,
		y = y,
		w = w,
		h = h,
		callback = callback
	}

	table.insert(self.collision_area, area_c)
end

-- remove collision area by name
function object_base:removeCollisionArea(id)
	for i in self.collision_area do
		if(self.collision_area[i].id == id) then
			table.remove(self.collision_area, i)
			break
		end
	end
end

-- identify if mouse clicked is on object
function object_base:isClickMe()
	local x,y = love.mouse.getPosition()
	if x > self.x and x < self.x+self.width and y > self.y and y < self.y+self.height then
		if self.click ~= nil then
			self:click()
		end
		return true
	end
	return false;
end

return object
