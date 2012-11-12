-- 
-- @file walker.lua
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

local ent = ents.Derive("base")

function	ent:load(x, y)
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
   --
   -- Counter Clock-Wise methode !
   -- base sur la routine de Sedgewick p. 350
   --
   local dx1, dx2, dy1, dy2
   local accuracy

   accuracy = 1.e-06
   dx1 = Tank.Position.x - self.x
   dy1 = Tank.Position.y - self.y
   dx2 = 0 - self.x
   dy2 = Tank.Position.y - self.y
--[[   
   if (math.abs(dx1) < accuracy) then
      dx1 = 0
   end
   if (math.abs(dx2) < accuracy) then
      dx2 = 0
   end
   if (math.abs(dy1) < accuracy) then
      dy1 = 0
   end
   if (math.abs(dy2) < accuracy) then
      dy2 = 0
   end
]]--
   if (dx1 * dy2 > dy1*dx2) then
      self.angle = self.angle + dt * math.pi/2
      self.angle = self.angle % (2*math.pi)
   else
      self.angle = self.angle - dt * math.pi/2
      self.angle = self.angle % (2*math.pi)
   end
   if (dx1 * dx2 < 0 or dy1 * dy2 < 0) then
      self.angle = self.angle - dt * math.pi/2
      self.angle = self.angle % (2*math.pi)
   end
   if (dx1 * dx1 + dy1 * dy1 < dx2 * dx2 + dy2 * dy2) then
      self.angle = self.angle + dt * math.pi/2
      self.angle = self.angle % (2*math.pi)
   end
end

function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

function	ent:update(dt)
   -- coder l'IA ici
   self:pivoter(dt)
   self:avancer(dt)
end

function	ent:draw()
   local x, y = self:getPos()
   local w, h = self:getSize() / 2
   
   love.graphics.draw(walker_z, x, y, self.angle, Reso.Scale, Reso.Scale, w, h)
end

return ent;
