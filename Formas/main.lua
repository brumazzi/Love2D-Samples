function love.load()
	poly = {
		200, 200,
		150, 200,
		300, 290,
		230, 160
	}
end

function love.draw()
	love.graphics.setColor(25,98,40);
	love.graphics.circle("fill", 30,30, 20);

	love.graphics.setColor(25,30, 120);
	love.graphics.arc("fill", 100, 100, 30, 3, 1, 3);

	love.graphics.polygon("fill", poly);

	love.graphics.line(30, 400, 60, 470);

	love.graphics.setColor(125,30, 20);
	love.graphics.ellipse("fill", 200, 30, 45, 10, 10)

	love.graphics.rectangle("fill", 20, 50, 60, 120 );
end
