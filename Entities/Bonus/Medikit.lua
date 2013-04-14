 -- 
-- @file Medikit.lua
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

--- Fixer une position.
-- @param x Position en x.
-- @param y Position en y.
function ent:setPos( x, y )
   self.x = x
   self.y = y
end

--- Charge les parametres en memoire.
-- La position du medikit (qui ne changera pas), son image et sa date de creation.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   self.image = picMedikit
   self.stime = love.timer.getTime()
end

--- Mise-a-jour de l'entite.
-- Calcule de la distance, si collision avec le tank alors le joueur regagne de la vie.
-- Si le temps d'apparition du medikit depasse les 10 secondes alors il est detruit.
-- @param dt Delta Temps
function	ent:update(dt)
   distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
   local etime = love.timer.getTime()
   
   if distance < (self.image:getWidth() / 2 + Tank.BaseImage:getWidth() / 2) * Reso.Scale then
      if (Tank.Health + 20 > Tank.HealthBase ) then
	 Tank.Health = Tank.HealthBase
      else
	 Tank.Health = Tank.Health + 20
      end
      ents.Destroy(self.id)
   end
   
   if etime - self.stime >= 10 then
      ents.Destroy(self.id)
   end
end

--- Affiche l'entite.
-- On lui donne un petit effet de transparence.
function ent:draw()
   love.graphics.setColor(255, 255, 255, 150)
   love.graphics.draw(self.image, self.x, self.y, 0, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
   love.graphics.setColor(255, 255, 255)
end

return ent;