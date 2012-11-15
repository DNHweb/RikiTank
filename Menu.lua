-- 
-- @file Menu.lua
-- This file is a part of RikiTank project, an amazing tank game !
-- Copyright (C) 2012  Riki-Team
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 

require "Sound"
require "Entities"

EtatJeu = "Menu"	-- on initialise EtatJeu à Menu
checkMusic = 0		-- variable de verification, si 1 la music est deja en lecture.

function ChoixTankLoad()
   JouerOn = love.graphics.newImage("Images/Menu/JouerOn.png")
   JouerOff = love.graphics.newImage("Images/Menu/JouerOff.png")
   MenuOn = love.graphics.newImage("Images/Menu/MenuOn.png")
   MenuOff = love.graphics.newImage("Images/Menu/MenuOff.png")
   QuitterOn = love.graphics.newImage("Images/Menu/QuitterOn.png")
   QuitterOff = love.graphics.newImage("Images/Menu/QuitterOff.png")
   Tank1On = love.graphics.newImage("Images/Menu/Tank1On.png")
   Tank1Off = love.graphics.newImage("Images/Menu/Tank1Off.png")
   Tank2On = love.graphics.newImage("Images/Menu/Tank2On.png")
   Tank2Off = love.graphics.newImage("Images/Menu/Tank2Off.png")
   Tank3On = love.graphics.newImage("Images/Menu/Tank3On.png")
   Tank3Off = love.graphics.newImage("Images/Menu/Tank3Off.png")
   
   Bouton = {
      Main = 	{
	 Jouer = {On = JouerOn, Off = JouerOff, x = 100, y = (Reso.Height/3)-35, Width = 260, Height = 70, Id = "GoChoixTank"},
	 Quitter1 = {On = QuitterOn, Off = QuitterOff, x = 100, y =(2*Reso.Height/3)-35, Width = 260, Height = 70, Id = "Quitter1"}
      },
      Pause = {
	 Reprendre = {On = JouerOn, Off = JouerOff, x = 100, y =(Reso.Height/4)-35, Width = 260, Height = 70, Id = "Reprendre"},
	 Menu = {On = MenuOn, Off = MenuOff, x = 100, y = (Reso.Height/2)-35, Width = 260, Height = 70, Id = "Menu"},
	 Quitter2 = {On = QuitterOn, Off = QuitterOff, x = 100, y = (3*Reso.Height/4)-35, Width = 260, Height = 70, Id = "Quitter2"}
      },
      Choix = {
	 Tank1 = {On = Tank1On, Off = Tank1Off, x = (Reso.Width/4)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank1"},
	 Tank2 = {On = Tank2On, Off = Tank2Off, x = (Reso.Width/2)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank2"},
	 Tank3 = {On = Tank3On, Off = Tank3Off, x = (3*Reso.Width/4)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank3"}
      }
   }
end

local function drawButton(off, on, x, y, w, h, mx, my)
   love.graphics.setBackgroundColor( 190, 190, 190, 255 )
   local px = love.mouse.getX()
   local py = love.mouse.getY()
   if px > x and px < x + w and py > y and  py < y + h then
      love.graphics.draw(on, x, y)
   else
      love.graphics.draw(off, x, y)
   end
end


function EtatJeuDraw()
   local x = love.mouse.getX( )
   local y = love.mouse.getY( )
   
   if checkMusic == 0 then
      love.audio.play(music)
      checkMusic = 1
   end
   
   if EtatJeu == "Menu" then
      love.mouse.setVisible(true)
      for k, v in pairs(Bouton.Main) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   if EtatJeu == "Choix" then
      love.mouse.setVisible(true)
      for k, v in pairs(Bouton.Choix) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   if EtatJeu == "Pause" then
      love.mouse.setVisible(true)
      for k, v in pairs(Bouton.Pause) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   --> Si on est en jeu <--
   if EtatJeu == "EnJeu" then
      love.mouse.setVisible(false)
      GroundDraw()						-- on affiche le sol du jeu
      ents:draw()
      TankDraw()						-- Et le tank
      love.audio.stop(music)                                   -- Et on arrete la musique epique !
      checkMusic = 0
      love.graphics.print("vie :                   " .. Tank.Health, 10,10)
      love.graphics.print("vitesse :            " .. Tank.Vitesse, 10,30)
      love.graphics.print("Cadence :         " .. Tank.CadenceTir, 10,50)
      love.graphics.print("Degats :           " .. Tank.Dammage, 10,70)
      love.graphics.print("Delta Time dt :  " .. tostring(love.timer.getDelta()), 10, 90)
      if love.mouse.isDown("l") then
	 xMissile = Tank.Position.x + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.cos(Tank.Angle.Tourelle)
	 yMissile = Tank.Position.y + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.sin(Tank.Angle.Tourelle)
	 ents.Create("Missile", xMissile, yMissile)
      end
   end
end

function love.mousepressed(x, y, button )
   if button == "l" then
      if EtatJeu == "Menu" then
	 for k, v in pairs(Bouton.Main) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "GoChoixTank" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Choix"
	       elseif v.Id == "Quitter1" then
		  love.event.push("quit")
	       end
	    end
	 end
	 
      elseif EtatJeu == "Choix" then
	 for k, v in pairs(Bouton.Choix) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       --> Si on choisit le Tank 1 <--
	       if v.Id == "Tank1" then
		  love.audio.play(SonMenu2)
		  ChargerTank1()
		  EtatJeu = "EnJeu"
	       end
	       --> Si on choisit le Tank 2 <--
	       if v.Id == "Tank2" then
		  love.audio.play(SonMenu2)
		  ChargerTank2()
		  EtatJeu = "EnJeu"
	       end
	       --> Si on choisit le Tank 3 <--
	       if v.Id == "Tank3" then
		  love.audio.play(SonMenu2)
		  ChargerTank3()
		  EtatJeu = "EnJeu"
	       end
	    end
	 end
	 
      elseif EtatJeu == "Pause" then
	 for k, v in pairs(Bouton.Pause) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Reprendre" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "EnJeu"
		  --> Si on choisit le bouton menu du menu pause <--
	       elseif v.Id == "Menu" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Menu"
		  --> Si on choisit le bouton quitter du menu pause <--
	       elseif v.Id == "Quitter2" then
		  love.event.push("quit")
	       end
	    end
	 end
      end
   end
end

function love.keypressed(key)
   if key == "escape" and EtatJeu=="EnJeu" then
      EtatJeu = "Pause"
   elseif key == "escape" and EtatJeu=="Pause" then
      EtatJeu = "EnJeu"
   end
end

function ChargerTank1()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank1.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank1.png")
   Tank.RotTourelleWidth = 89
   Tank.Vitesse = (Speed * 5)/7
   Tank.Dammage = 40
   Tank.health = 225
   Tank.CadenceTir = 1.7
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2 
   Tank.Angle.Base = 0
end

function ChargerTank2()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank2.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank2.png")
   Tank.RotTourelleWidth = 103
   Tank.Vitesse = (Speed * 3)/7
   Tank.Dammage = 48
   Tank.health = 360
   Tank.CadenceTir = 1.02
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2 
   Tank.Angle.Base = 0
end

function ChargerTank3()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank3.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank3.png")
   Tank.RotTourelleWidth = 50
   Tank.Vitesse = Speed
   Tank.Dammage = 24
   Tank.health = 135
   Tank.CadenceTir = 2.38
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2 
   Tank.Angle.Base = 0
end
