function love.load()
	thread = love.thread.newThread("thread.lua")
	channel = love.thread.getChannel("test")
	thread:start()
	i={}
end
function love.update(dt)
	v = channel:pop()
	if v then
		table.insert(i,v)
	end
	print(v)
end
function love.draw()
	for x,y in pairs(i) do
		love.graphics.print(tostring(y), 10, 10*x)
	end
end
