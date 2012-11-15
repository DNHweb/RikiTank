-- 
-- @file Tir.lua
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

function ShootLoad()
   Bullet = love.graphics.newImage("Images/Missile.png")
end

function ShootDraw(dt)
   if EtatJeu == "EnJeu" then
      local Missile = {
	 Position = {x = Tank.Position.x + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.cos(Tank.Angle.Tourelle), y = Tank.Position.y + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.sin(Tank.Angle.Tourelle)},
	 Angle = Tank.Angle.Tourelle + math.pi/2
      }

      vlargeur = Bullet:getWidth()/2
      vhauteur = Bullet:getHeight()/2
      if love.mouse.isDown("l") then
	 love.graphics.draw(Bullet, Missile.Position.x, Missile.Position.y, Missile.Angle, Reso.Scale, Reso.Scale, vlargeur, vhauteur)			
      end
   end
end