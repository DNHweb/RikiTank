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

--- Fixer une position.
-- @param x Position en x.
-- @param y Position en y.
function ent:setPos( x, y )
   self.x = x
   self.y = y
   self.ang = Tank.Angle.Tourelle
   self.vitesse = 0.90
end

--- Charge les parametres en memoire.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   self.image = picMissile
end

--- Mise-a-jour de l'entite.
-- @param dt Delta Temps
function ent:update(dt)
   if self.id == 1 then
      ents.Destroy( self.id )
   end
   self.x = self.x + math.cos(self.ang) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.ang) * self.vitesse * dt / 0.002
   
   if (self.x > Reso.Width) then
      ents.Destroy( self.id )
   elseif (self.x < 0) then
      ents.Destroy( self.id )
   elseif (self.y < 0) then
      ents.Destroy( self.id )
   elseif (self.y > Reso.Height) then
      ents.Destroy( self.id )
   end
end

--- Affiche l'entite.
function ent:draw()
   love.graphics.draw(self.image, self.x, self.y, self.ang, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

return ent;