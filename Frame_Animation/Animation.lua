Animation = {}

-- divide Sprite para animação
-- image = Objeto Image
-- width = Largura da frame
-- height = Altura da frame
-- frames_x = quantidades de frames no eixo x
-- frames_y = quantidades de frames no eixo y
-- duration = intervalo entre cada frame
function Animation.new(image, width, height, frames_x, frames_y ,duration)
	local anima = {}
	anima.spriteSheet = image;
	anima.quads = {}

	for y = 0, image:getHeight() - height, height do
		for x = 0, image:getWidth() - width, width do
			table.insert(anima.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
		end
	end

	anima.duration = duration or 1
	anima.currentTime = 0

	return anima
end
