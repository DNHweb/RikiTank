function SoundMenu()
   music = love.audio.newSource("Sounds/Menu.mp3")
   music:setVolume(0.25)
   love.audio.play(music)

   SonMenu2 = love.audio.newSource("Sounds/SonMenu2.mp3")
   SonMenu2:setVolume(0.75)

   SonMenu1 = love.audio.newSource("Sounds/SonMenu1.mp3")
   SonMenu1:setVolume(0.75)
end