function SoundMenu()
	music = love.audio.newSource("Sounds/Menu.mp3")
	love.audio.setVolume(0.25)
	love.audio.play(music)
	
	SonMenu2 = love.audio.newSource("Sounds/SonMenu2.mp3")
	love.audio.setVolume(0.25)
	
	SonMenu1 = love.audio.newSource("Sounds/SonMenu1.mp3")
	love.audio.setVolume(0.25)
end