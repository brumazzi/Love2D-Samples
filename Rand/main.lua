function love.draw()
	rand = love.math.random
	w = love.graphics.getWidth()
	h = love.graphics.getHeight()

	for x = 1, 100 do
		love.graphics.setColor(rand(255),rand(255),rand(255))
		love.graphics.rectangle("fill", rand(w)-100, rand(h)-100, rand(100), rand(100))
	end
end
