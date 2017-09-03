-- Love Script
--
-- Here Contains button's properts
--
local widget = require "lib/widget"
local button = {}
local button_base = {
	clicked = false
}

function button.new(parent, text)
	local _new = widget.new(parent, text)
	for prop, dta in pairs(button_base) do
		_new[prop] = dta
	end

	return _new
end

function button_base:draw()
	local g = love.graphics
	local rect = g.rectangle
	local x = self.x
	local y = self.y

	if self.clicked == true then
		g.setColor(60,60,60)
		rect("line", x, y, self.width, self.height)
		g.setColor(self.color[1]-60, self.color[2]-60, self.color[3]-60)
		rect("fill", x+1, y+1, self.width-2, self.height-2)
	else
		g.setColor(30,30,30)
		rect("line", x, y, self.width, self.height)
		g.setColor(self.color[1], self.color[2], self.color[3])
		rect("fill", x+1, y+1, self.width-2, self.height-2)
	end

	x = x+(self.width/2 - string.len(self.text)*6/2)
	y = y+(self.height/2 - 6)
	g.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
	g.print(self.text, x, y)
end

return button
