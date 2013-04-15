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
   self.vitesse = 0.40
   self:setPos( x, y )
   local randW = math.random(10)
   if randW <= 5 then
	self.image = picWalker
   else
	self.image = picWalkerRouge
   end
   self.xx = Reso.Width / 6
   self.yy = Reso.Height / 6
   self.stime = love.timer.getTime()
   self.oldangle = 0
end

--- Code a executer avant la destruction de l'entite.
function ent:Die()
   love.audio.play(SonExplosion)
   ents.Create("ExplosionEnnemie", self.x, self.y)
   Tank.Score = Tank.Score + 20
   Tank.PopBoss = Tank.PopBoss + 20
   Tank.PourcentagePouvoir = Tank.PourcentagePouvoir + 2
   Tank.Exp = Tank.Exp + 5
   if (math.random(10) <= 2) then
      ents.Create("Vitesse", self.x, self.y)
   end
end

--- Fait pivoter le Walker.
-- Calcul le nouvel angle du walker.
-- Utilisation d'un algorithme Brownien pour essayer d'avoir une trajectoire un peu aleatoire
-- jusqu'au tank du joueur.
-- @param dt Delta Temps.
function	ent:pivoter(dt)
   local etime = love.timer.getTime()
   math.randomseed(os.time())
   
   if etime - stime >= 0.5 then
      math.random()
      math.random()
      math.random()
      local aleatoire = math.random(12)

      if aleatoire <= 7 then
	 self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
	 self.oldangle = 0
      elseif aleatoire <= 9 then
	 self.angle = ent:TourneDroite(self.angle, dt)
	 self.oldangle = 1
      else
	 self.angle = ent:TourneGauche(self.angle, dt)
	 self.oldangle = 2
      end
      stime = love.timer.getTime()
   else
      if self.oldangle == 0 then
	 self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
      elseif self.oldangle == 1 then
	 self.angle = ent:TourneDroite(self.angle, dt)
      else
	 self.angle = ent:TourneGauche(self.angle, dt)
      end
   end
end

--- Fait avancer le Walker.
-- Calcul des nouvelles coordonnees du Walker.
-- @param dt Delta Temps.
function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

--- Tourner a droite.
-- @param Angle Angle du walker.
-- @param dt Delta Temps.
-- @return Le nouvel angle du walker.
function	ent:TourneDroite(Angle, dt)
   Angle = Angle + dt * math.pi / 2
   Angle = Angle % (2 * math.pi)
   return Angle
end

--- Tourner a gauche.
-- @param Angle Angle du walker.
-- @param dt Delta Temps.
-- @return Le nouvel angle du walker.
function	ent:TourneGauche(Angle, dt)
   Angle = Angle - dt * math.pi / 2
   Angle = Angle % (2 * math.pi)
   return Angle
end

--- Mise-a-jour de l'entite.
-- On calcul la distance entre le Walker et le tank.
-- Si collision, le joueur perd de la vie et le Walker est detruit.
-- Sinon on dirige le Walker vers le joueur.
-- @param dt Delta Temps
function	ent:update(dt)
   -- IA
   distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
   -- si collision
   if distance < (self.image:getWidth() / 2 + Tank.BaseImage:getWidth() / 2) * Reso.Scale then
      Tank.Health = Tank.Health - 20
      ents.Destroy(self.id)
   end
   self:pivoter(dt)
   self:avancer(dt)
end

--- Affiche l'entite.
function	ent:draw()
   love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

return ent