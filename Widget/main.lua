local Button = require "lib/widget/button"
local Entry = require "lib/widget/entry"
local Frame = require "lib/widget/frame"
local widget = require "lib/widget"

function love.load()
	frm = Frame.new(nil)
	btn = Button.new(frm, nil)
	ent = Entry.new(frm, nil)

	btn.text = "Hello World!"
	btn.x = 90
	btn.y = 160
	btn.width = 80
	btn.height = 32

	ent.x = 300
	ent.y = 160
	ent.width = 80
	ent.height = 32

	frm.x = 100
	frm.y = 80
	frm.width = 640
	frm.height = 480

	widget:pack(frm)

	btn.click = function()
		if ent.text == "" or ent.text == nil then
			frm.text = nil
		else
			frm.text = ent.text
		end
	end
end

function love.mousepressed()
	if btn:isClickMe() == true then
		btn.clicked = true
		love.window.setTitle("clicked!")
	end
	if ent:isClickMe() == true then
		ent.focus = true
		love.window.setTitle("entry as focus")
	else
		ent.focus = false
		love.window.setTitle("")
	end
end

function love.mousereleased()
	btn.clicked = false
	love.window.setTitle("")
end

function love.keypressed(key, scancode, isrepeat)
	love.window.setTitle(key)
	ent:applyChar(scancode)
end

function love.draw()
	widget.drawAll(frm)
	local x,y = love.mouse.getPosition()
--	love.window.setTitle("x: "..tostring(x).." | y: "..tostring(y))
end
