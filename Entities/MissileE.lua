-- 
-- @file MissileE.lua
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
   self.vitesse = 0.90
end

--- Charge les parametres en memoire.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   self.image = picMissileE
end

--- Mise-a-jour de l'entite.
-- Verification de la distance entre le missile et le tank.
-- Si la distance est inferieur a un certain nombre alors il y a collision
-- et joue un son, creer une explosion et detruit le missile.
-- Sinon si le missile sort de l'ecran alors on le detruit.
-- @param dt Delta Temps
function ent:update(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
   local distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
	
   if (distance < (self.image:getWidth() / 2 + Tank.BaseImage:getWidth() / 2) * Reso.Scale) then
      Tank.Health = Tank.Health - 30
      --local SonExplosion = love.audio.newSource("Sounds/SonExplosion.mp3", "stream")
      --SonExplosion:setVolume(0.75)
      love.audio.play(SonExplosion)
      ents.Create("Explosion", self.x, self.y)
      ents.Destroy(self.id)
   elseif (self.x > Reso.Width) then
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
   love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

return ent;