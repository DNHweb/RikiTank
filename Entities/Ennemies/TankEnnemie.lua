-- 
-- @file TankEnnemie.lua
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
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self:setPos( x, y )
   local randT = math.random(10)
   if randT <= 5 then
	self.image = picTankEB
	self.imageT = picTankET
   else
	self.image = picTankEBGris
	self.imageT = picTankETGris
   end
   self.angleT = self.angle
   self.stime = love.timer.getTime()
end

--- Code a executer avant la destruction de l'entite.
-- Joue un son d'explosion, on cree l'explosion et augmente le score du joueur,
-- il y a 1 chance sur 10 pour qu'un medikit apparaisse.
function ent:Die()
   love.audio.play(SonExplosion)
   ents.Create("ExplosionEnnemie", self.x, self.y)
   Tank.Score = Tank.Score + 50
   Tank.PopBoss = Tank.PopBoss + 50
   Tank.PourcentagePouvoir = Tank.PourcentagePouvoir + 5
   Tank.Exp = Tank.Exp + 10
   -- Pop des medikits
   if (math.random(10) <= 2) then
      ents.Create("Medikit", self.x, self.y)
   end
end

--- Fait pivoter le Tank Ennemi.
-- Calcul le nouvel angle du Tank Ennemi.
-- @param dt Delta Temps.
function	ent:pivoter(dt)
   self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
end

--- Fait avancer le Tank Ennemi.
-- Calcul des nouvelles coordonnees du Tank Ennemi.
-- @param dt Delta Temps.
function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

--- Mise-a-jour de l'entite.
-- Gestion de l'IA : on fait avancer le tank ennemi jusqu'a une certaine distance
-- du joueur puis le tank ennemi se met a faire feu ( creation de Missile Ennemi ).
-- Si collision le tank ennemi est detruit.
-- @param dt Delta Temps
function	ent:update(dt)
   distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
   local etime = love.timer.getTime()

   if self.x < Reso.Width * 0.1 or self.x > Reso.Width - Reso.Width * 0.1 or
      self.y < Reso.Height * 0.1 or self.y > Reso.Height - Reso.Height * 0.1 then
      self:pivoter(dt)
      self:avancer(dt)
   elseif (distance > (Reso.Width / 3.2)) then
      self:pivoter(dt)
      self:avancer(dt)
   else
      self.angleT = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
      if etime - self.stime > 1.5 then
	 ents.Create("MissileE", self.x, self.y, self.angleT)
	 self.stime = love.timer.getTime()
      end
   end
   if distance < (self.image:getWidth() / 2 + Tank.BaseImage:getWidth() / 2) * Reso.Scale then
      Tank.Health = Tank.Health - 50
      ents.Destroy(self.id)
   end
end

--- Affiche l'entite.
function ent:draw()
   love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
   love.graphics.draw(self.imageT, self.x, self.y, self.angleT, Reso.Scale, Reso.Scale, self.imageT:getWidth() / 2, self.imageT:getHeight() / 2)
end

return ent;