require 'Animation'

LEFT = 1
RIGHT = -1

function love.load()
	local img = love.graphics.newImage('rescue/Tina_step_x.png')
	tina = Animation.new(img, 116, 192, 3, 1, 1) -- Carrega animação do personagem

	direction = LEFT
end

function love.update(dt)
	-- delay da animação
	tina.currentTime = tina.currentTime + dt
	if tina.currentTime >= tina.duration then
		tina.currentTime = tina.currentTime - tina.duration
	end

	-- Direção da sprite
	if love.keyboard.isDown('left') then
		direction = LEFT
	elseif love.keyboard.isDown('right') then
		direction = RIGHT
	end
end

function love.draw()
	-- seleção da frame do personagem
	local spriteNum = math.floor(tina.currentTime / tina.duration * #tina.quads) + 1

	love.graphics.draw(tina.spriteSheet, tina.quads[spriteNum], 100, 100, 0, direction,1, 116/2,192/2)
end
