c = love.thread.getChannel("test")
for i=0,50,1 do
	c:push(math.random()*10)
end
