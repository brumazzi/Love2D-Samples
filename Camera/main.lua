require 'camera'

function love.load()
	cam = Camera.new(0,0,1,1)
	img = love.graphics.newImage('background.jpg')
end

function love.update(dt)
	cam:move(4, 0)
end

function love.draw()
	cam:set()

	love.graphics.draw(img, 0, 0)

	cam:unset()
end
