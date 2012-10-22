function love.keypressed(key)
	if key=="0" then
		love.graphics.print("lol", 200, 200)
	elseif key == "escape" then
		love.event.push("quit")
	end
end
--love.mousepressed(key)
--if key=="R" then