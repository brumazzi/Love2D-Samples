-- Love Script
--
-- Here conteins base and functions
-- from frame
--
local widget = require "lib/widget"
local frame = {}
local frame_base = {
}

function frame.new(parent)
	local _new = widget.new(parent)
	for prop, dta in pairs(frame_base) do
		_new[prop] = dta
	end
	_new.text_color = {46,52,54}
	_new.color = {211,215,207}

	return _new
end

function frame_base:draw()
	local g = love.graphics
	local rect = g.rectangle
	local x = self.x
	local y = self.y

	g.setColor(60,60,60)
	rect("line", x, y, self.width, self.height)
	g.setColor(self.color[1], self.color[2], self.color[3])
	rect("fill", x+1, y+1, self.width-2, self.height-2)

	if self.text ~= nil then
		g.setColor(60,60,60)
		rect("line", x, y, self.width, -17)
		g.setColor(32,74,135);
		rect("fill", x, y-1, self.width, -16)
		x = x+(self.width/2 - string.len(self.text)*6/2)
		y = y - 16
		g.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
		g.print(self.text, x, y)
	end
end

return frame
