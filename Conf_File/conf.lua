function love.conf(cfg)
	cfg.identify = "love_cfg_dir"
	cfg.version = "0.10.2"
	cfg.console = false

	cfg.window.title = "Callback test"
	cfg.window.icon = nil
	cfg.window.resizable = false
	cfg.window.fullscreen= true

	cfg.modules.audio = true
	cfg.modules.event = true
	cfg.modules.image = true
	cfg.modules.graphics = true

	-- abilita todos os módulos
	for index, mod in pairs(cfg.modules) do
		if not mod then
			cfg.modules[index] = true
		end
	end
end
