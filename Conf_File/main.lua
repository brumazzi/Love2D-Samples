function love.load()
	local tux = {
		"Gentoo",
		"Goku",
		"Jedi",
		"Kakashi",
		"Mago",
		"Paladino",
		"Rambo"
	}
	tux_def = 1;
	tux_img = {}
	for i,n in pairs(tux) do
		table.insert(tux_img,love.graphics.newImage("rescue/tux"..n..".png"))
	end
end

function love.update(dt)
	if love.keyboard.isDown("down") then
		tux_def = tux_def - 1
		if tux_def == 0 then
			tux_def = 7
		end
	end
	if love.keyboard.isDown("up") then
		tux_def = tux_def + 1
		if tux_def == 8 then
			tux_def = 1
		end
	end
end

function love.draw()
	love.graphics.draw(tux_img[tux_def], 10, 10)
end
