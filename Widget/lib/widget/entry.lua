-- Love Script
--
-- Here conteins base and functions
-- from entry box
--
local widget = require "lib/widget"
local entry = {}
local entry_base = {
	focus = false
}

function entry.new(parent)
	local _new = widget.new(parent)
	for prop, dta in pairs(entry_base) do
		_new[prop] = dta
	end
	_new.color = {238,238,236}

	return _new
end

function entry_base:applyChar(char)
	if self.text == nil then self.text = "" end
	if self.focus == true then
		if string.len(char) == 1 then
			self.text = self.text..char
		elseif char == "backspace" then
			self.text = self.text:sub(1,-2)
		elseif char == "space" then
			self.text = self.text.." "
		end
	end
end

function entry_base:draw()
	local g = love.graphics
	local rect = g.rectangle
	local x = self.x
	local y = self.y
	
	g.setColor(60,60,60)
	rect("line", x, y, self.width, self.height)
	g.setColor(self.color[1], self.color[2], self.color[3])
	rect("fill", x+1, y+1, self.width-2, self.height-2)

	x = x+2
	y = y+(self.height/2 - 6)
	g.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
	if self.text ~= nil then
		g.print(self.text, x, y)
	end
end

return entry
