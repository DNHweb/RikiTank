-- 
-- @file Walker.lua
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

local ent = ents.Derive("Base")

function	ent:load(x, y)
   x = -100
   y = -100
   self:setPos(x, y)
   self.w = 116
   self.h = 59
   self:setVitesse(0.40)
end

function	ent:setSize(w, h)
   self.w = w
   self.h = h
end

function	ent:getSize()
   return self.w, self.h
end

function	ent:pivoter(dt)
   self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
end

function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

function	ent:reculer(dt)
   self.x = self.x - math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y - math.sin(self.angle) * self.vitesse * dt / 0.002
end

function	ent:update(dt)
   -- IA
   distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
   -- si collision
   if distance < (walker_z:getWidth() / 3 + Tank.BaseImage:getWidth() / 3) then
      side = math.random(1, 3)
      newX = math.random(500, 1500)
      newY = math.random(-800, 1800)
      otherSide = math.random(1, 3)
      otherX = math.random(500, 1500)
      otherY = math.random(-800, 1800)
      if side <= 2 then
	 newX = - newX
      else
	 newX = newX + Reso.Width
      end
      self.x = newX
      self.y = newY
      if otherSide <= 2 then
	 otherX = - otherX
      else
	 otherX = otherX + Reso.Width
      end
      -- pour limiter le nombre de walker qui pop
      -- creer un compteur puis modulo 2 sur compteur
      -- si = 0 alors on creer un nouveau walker !
      walker_bis = ents.Create("Walker", otherX, otherY)
   end
   self:pivoter(dt)
   self:avancer(dt)
end

function	ent:draw()
   local x, y = self:getPos()
   local w, h = self:getSize()
   
   love.graphics.draw(walker_z, x, y, self.angle, Reso.Scale, Reso.Scale, w / 2, h / 2)
end

return ent;
