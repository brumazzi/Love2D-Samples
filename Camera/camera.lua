Camera = {
	x = 0,
	y = 0,
	scaleX = 1,
	scaleY = 1,
	rotation = 0,
	minX = 0,
	maxX = 0,
	minY = 0,
	maxY = 0
}

function Camera:set()
	love.graphics.push()
	love.graphics.rotate(self.rotation)
	love.graphics.scale(1*self.scaleX, 1*self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
	love.graphics.pop()
end

function Camera:update()
	if self.x < self.minX then
		self.x = self.minX
	elseif self.x > self.maxX then
		self.x = self.maxX
	end
	if self.y < self.minY then
		self.y = self.minY
	elseif self.y > self.maxY then
		self.y = self.maxY
	end
end

function Camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
	self:update()
end

function Camera:rotate(dr)
	self.rotation = self.rotation + (dr or 0)
end

function Camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function Camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
	self:update()
end

function Camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end
