-- 
-- @file Sort.lua
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

function Blast(CdSort)
   
   if CdSort == 0 then
      xBlast = Tank.Position.x + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.cos(Tank.Angle.Tourelle)
      yBlast = Tank.Position.y + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.sin(Tank.Angle.Tourelle)
      ents.Create("Blast", xBlast, yBlast)
      CountdownSort = 90
   else
      love.audio.play(SonMenu1)
   end
end

function Flash(CdSort)
   if CdSort == 0 then
      Tank.Position.x = Tank.Position.x + math.cos(Tank.Angle.Base) * 300
      Tank.Position.y = Tank.Position.y + math.sin(Tank.Angle.Base) * 300
      CountdownSort = 90
   else
      love.audio.play(SonMenu1)
   end
end

function Soin(CdSort)
   if CdSort == 0 then
      love.audio.play(SonSoin)
      xSoin = Tank.Position.x - (Tank.BaseImage:getWidth()/2)
      ySoin = Tank.Position.y - (Tank.TourelleImage:getHeight()/2)
      ents.Create("AnimationSoin", xSoin, ySoin)
      if (Tank.Health + (Tank.HealthBase * 35)/100 > Tank.HealthBase ) then
	 Tank.Health = Tank.HealthBase
	 CountdownSort = 90
      else
	 Tank.Health = Tank.Health + (Tank.HealthBase * 35)/100
	 CountdownSort = 90
      end
   else
      love.audio.play(SonMenu1)
   end
end