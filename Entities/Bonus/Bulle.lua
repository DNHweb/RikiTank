 -- 
-- @file Bulle.lua
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
   self.x = Tank.Position.x
   self.y = Tank.Position.y
end

--- Charge les parametres en memoire.
-- La position de la bulle (qui ne changera pas), son image et sa date de creation.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   self.image = picBulle
   self.stime = love.timer.getTime()
end

--- Mise-a-jour de l'entite.
-- Si le temps d'apparition de la bulle depasse les 5 secondes alors elle est detruite.
-- @param dt Delta Temps
function ent:update(dt)
	self.x = Tank.Position.x - 56
	self.y = Tank.Position.y - 56
	local etime = love.timer.getTime()
   
	if etime - self.stime >= 5 then
		ents.Destroy(self.id)
		CreateBulle = 0
	end
end

--- Affiche l'entite.
function ent:draw()
   love.graphics.draw(self.image, self.x, self.y)
end

return ent;