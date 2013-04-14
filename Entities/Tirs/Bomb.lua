-- 
-- @file Bomb.lua
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

--- Fixer une position.
-- @param x Position en x.
-- @param y Position en y.
function ent:setPos( x, y )
   self.x = x
   self.y = y
end

--- Charge les parametres en memoire.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   self.size = math.random(50, Reso.Width / 6)
   self.creationTime = love.timer.getTime()
end

--- Code a executer avant la destruction de l'entite.
function ent:Die()
   ents.Create("ExplosionBomb", self.x - self.size / 2, self.y - self.size / 2)
end

--- Mise-a-jour de l'entite.
-- Si le temps d'apparition de la bombe est superieur a 4 secondes
-- alors on la detruit.
-- @param dt Delta Temps
function ent:update(dt)
   local newTime = love.timer.getTime()
   if (newTime - self.creationTime >= 4) then
      ents.Destroy(self.id)
   end
end

--- Affiche l'entite.
function ent:draw()
   local newTime = love.timer.getTime()
   if (newTime - self.creationTime >= 1 and newTime - self.creationTime < 2) then
      love.graphics.print("3", self.x, self.y)
   elseif (newTime - self.creationTime >= 2 and newTime - self.creationTime < 3) then
      love.graphics.print("2", self.x, self.y)
   elseif (newTime - self.creationTime >= 3) then
      love.graphics.print("1", self.x, self.y)
   end
   love.graphics.circle("line", self.x, self.y, self.size, self.size)
end

return ent;