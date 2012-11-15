-- 
-- @file Missile.lua
-- This file is a part of RikiTank project, an amazing tank game !
-- Copyright (C) 2012  Riki-Team <rikitank.project@gmail.com>
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

local ent = ents.Derive("Base")

function	ent:load()
   self:setVitesse(0.90)
   self.w = 6
   self.h = 19
   self.angle = Tank.Angle.Tourelle
end

function	ent:setSize(w, h)
   self.w = w
   self.h = h
end

function	ent:getSize()
   return self.w, self.h
end

function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

function	ent:update(dt)
   self:avancer(dt)
end

function	ent:draw()
   local x, y = self:getPos()
   local w, h = self:getSize()
   
   if x < Reso.Width and y < Reso.Height then
      love.graphics.draw(Missile, x, y, self.angle, Reso.Scale, Reso.Scale, w / 2, h / 5)
   end
end

return ent;
