function love.load()
	love.window.showMessageBox("Box Hello", "Hello World!", "error");
end

function love.draw()
	love.graphics.print("Hello World", 300, 400)
end
