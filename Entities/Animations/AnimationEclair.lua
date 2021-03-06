-- 
-- @file AnimationEclair.lua
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
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self.anim = newAnimation(AnimationEclair, 96, 96, 0.055, 0)
   self.anim:setMode("once")
end

--- Mise-a-jour de l'entite.
-- Joue l'animation du soin.
-- Si la frame courante est egale a 20 secondes ( la derniere frame )
-- alors on efface la soin.
-- @param dt Delta Temps
function	ent:update(dt)
	self.x = Tank.Position.x - 48
	self.y = Tank.Position.y - 48
	self.anim:update(dt)
   if self.anim:getCurrentFrame() == 20 then
      ents.Destroy(self.id)
   end
end

--- Affiche l'entite.
function ent:draw()
   self.anim:draw(self.x, self.y)
end

return ent;
