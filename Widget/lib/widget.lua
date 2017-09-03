-- Love Script
--
-- Here contains base of struct and functions
-- of widget used in the game
--
local object = require "lib/object"
local widget = {}
local widget_base = {
	id = nil,
	name = nil,
	text = "",
	parent = nil,
	childs = nil,
	color = {211,215,207},
	text_color = {46,52,54}
}

-- create a new widget, "parent" and "text"
-- are not necessary
function widget.new(parent, text)
	local _new = object.new()
	for prop, dta in pairs(widget_base) do
		_new[prop] = dta
	end

	_new.text = text
	if parent ~= nil then
		if parent.childs == nil then parent.childs = {} end
		table.insert(parent.childs, _new)
		_new.parent = parent
	end

	return _new
end

function widget:pack(widg)

	if widg.childs == nil then
		return false
	end
	for index, wd in pairs(widg.childs) do
		if type(wd) == "table" then
			wd.x = wd.x+widg.x
			wd.y = wd.y+widg.y
			widget:pack(wd)
		end
	end
end

-- append a new child in widget
function widget_base:addChild(child)
	table.insert(self.childs, child)
	child.parent = self
end

-- remove the child with:
-- <string: name> | <string: id> | <table: object> | <number: index>
function widget_base:removeChild(child)
	if type(child) == "string" then
		for index, data in pairs(self.childs) do
			if data.name == child or data.id == child then
				table.remove(self.childs, index)
				break
			end
		end
	elseif type(child) == "table" then
		for index, data in pairs(self.childs) do
			if data == child then
				table.remove(self.childs, index)
				break
			end
		end
	elseif type(child) == "number" then
		table.remove(self.childs, child)
	end
end

function widget.drawAll(widg)
	if widg == nil then
		return false
	end

	widg:draw()
	if widg.childs == nil then
		return false
	end
	for prop, dat in pairs(widg.childs) do
		widget.drawAll(dat)
	end
end

function widget_base:destroy()
	for index, data in pairs(self.childs) do
		if data ~= nil then
			data:destroy()
		end
	end

	self = nil
end

return widget
