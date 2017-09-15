Camera = {
}

local CAMERA_BASE = {
	x = 0,
	y = 0,
	scaleX = 1,
	scaleY = 1,
	rotate = 0
}

function Camera.new(x,y,sx,sy,r)
	local cam = {}
	setmetatable(cam, {__index=CAMERA_BASE})

	cam.x = x or 0
	cam.y = y or 0
	cam.scaleX = sx or 1
	cam.scaleY = sy or 1
	cam.rotate = r or 0

	return cam
end

function CAMERA_BASE:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotate)
	love.graphics.scale(1*self.scaleX, 1*self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function CAMERA_BASE:unset()
	love.graphics.pop()
end

function CAMERA_BASE:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function CAMERA_BASE:rotate(dr)
	self.rotate = self.rotate + dr
end

function CAMERA_BASE:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function CAMERA_BASE:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function CAMERA_BASE:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end
