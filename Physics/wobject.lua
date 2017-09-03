WObject = {}

local WObjectBase = {
	body = {},
	shape = {},
	fixture = nil,
}

local phy = love.physics

function WObject.new(world, shape, position, type)
	local _new = {}
	setmetatable(_new, {__index=WObjectBase})

	if type == nil then
		_new.body = phy.newBody(world, position[1], position[2])
	else
		_new.body = phy.newBody(world, position[1], position[2], type)
	end
	_new.shape = shape
	_new.fixture = phy.newFixture(_new.body, _new.shape)

	return _new
end

return WObject;
