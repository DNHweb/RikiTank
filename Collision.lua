-- 
-- @file Collision.lua
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

function	Collision(xa, ya, xb, yb)
   x = Tank.Position.x
   y = Tank.Position.y
   if (x > xa) and (x < xb) and (y > ya) and (y < yb) then
      Tank.Position.x = Tank.OldPosition.x
      Tank.Position.y = Tank.OldPosition.y
   end
end

function CollisionMap()
   Width = love.graphics.getWidth()
   Height = love.graphics.getHeight()
   TankW = (Reso.Scale * Tank.BaseImage:getWidth())/2
   TankH = (Reso.Scale * Tank.BaseImage:getHeight())/2
   if ChoixMap == 1 then
      Collision(Width/4 - TankH , (Height/2 - 25 * Reso.Scale) - TankH , (Width * 3 / 4) + TankH , (Height/2 + 25 * Reso.Scale) + TankH)
   end
end

function SortieEcran()
   if Tank.Position.x - (Reso.Scale * Tank.BaseImage:getHeight())/2 < 0 then
      Tank.Position.x = (Reso.Scale * Tank.BaseImage:getHeight())/2
   elseif Tank.Position.x + (Reso.Scale * Tank.BaseImage:getHeight()/2) > Reso.Width then
      Tank.Position.x = Reso.Width - (Reso.Scale * Tank.BaseImage:getHeight())/2
   end
   if Tank.Position.y - (Reso.Scale * Tank.BaseImage:getHeight())/2 < 0 then
      Tank.Position.y = (Reso.Scale * Tank.BaseImage:getHeight())/2
   elseif Tank.Position.y + (Reso.Scale * Tank.BaseImage:getHeight())/2 > Reso.Height then
      Tank.Position.y = Reso.Height - (Reso.Scale * Tank.BaseImage:getHeight())/2
   end


end