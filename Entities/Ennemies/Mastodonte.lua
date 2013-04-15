-- 
-- @file Mastodonte.lua
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
   cote = 0
end

--- Charge les parametres en memoire.
-- @param x Position en x.
-- @param y Position en y.
function ent:load( x, y )
   self.vitesse = 0.1
   self.health = 1000
   self:setPos( x, y )
   self.image = picBaseMastodonte
   self.imageT = picTourelleMastodonte
   self.angleT = self.angle
   self.xx = Reso.Width / 6
   self.yy = Reso.Height / 6
   self.stime = love.timer.getTime()
   self.qtime = love.timer.getTime()
end

--- Code a executer avant la destruction de l'entite.
function ent:Die()
   love.audio.play(SonExplosion)
   ents.Create("ExplosionEnnemie", self.x, self.y)
   Tank.Score = Tank.Score + 500
   Tank.PourcentagePouvoir = Tank.PourcentagePouvoir + 20
   Tank.Exp = Tank.Exp + 75
   if (Tank.Health + 100 > Tank.HealthBase) then
      Tank.Health = Tank.HealthBase
   else
      Tank.Health = Tank.Health + 100
   end
   Tank.PopBoss = 0
end

--- Fait pivoter le Mastodonte.
-- Calcul le nouvel angle du Mastodonte.
-- @param dt Delta Temps.
function	ent:pivoter(dt)
   self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
end

--- Fait avancer le Mastodonte.
-- Calcul des nouvelles coordonnees du Mastodonte.
-- @param dt Delta Temps.
function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

--- Mise-a-jour de l'entite.
-- Gestion de l'IA : on fait avancer le Mastodonte jusqu'a une certaine distance
-- du joueur puis le Mastodonte se met a faire feu ( creation de Missile Mastodonte ).
-- Si collision le tank est detruit.
-- @param dt Delta Temps
function	ent:update(dt)
   distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
   local etime = love.timer.getTime()
   
   if distance > (Reso.Width / 2) then
      self:avancer(dt)
	  self:pivoter(dt)
   else
      self.angleT = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
      if etime - self.stime > 0.27 then
	 if (cote == 0) then
	    ax = self.x + 9 * math.cos(self.angleT - (math.pi/2)) + math.cos(self.angleT) * 1.2 * Reso.Scale * dt / 0.002
	    ay = self.y + 9 * math.sin(self.angleT - (math.pi/2)) + math.sin(self.angleT) * 1.2 * Reso.Scale * dt / 0.002
	    ents.Create("MissileM", ax, ay, self.angleT)
	    cote = 1
	 else
	    bx = self.x + 9 * math.cos(self.angleT + (math.pi/2)) + math.cos(self.angleT) * 1.2 * Reso.Scale * dt / 0.002
	    by = self.y + 9 * math.sin(self.angleT + (math.pi/2)) + math.sin(self.angleT) * 1.2 * Reso.Scale * dt / 0.002
	    ents.Create("MissileM", bx, by, self.angleT)
	    cote = 0
	 end
	 self.stime = love.timer.getTime()
      end
   end
   if etime - self.qtime > 10 then
      ents.Create("SpecialM", self.x, self.y, 0)
      ents.Create("SpecialM", self.x, self.y, math.pi / 6)
      ents.Create("SpecialM", self.x, self.y, math.pi / 3)
      ents.Create("SpecialM", self.x, self.y, math.pi / 2)
      ents.Create("SpecialM", self.x, self.y, (2 * math.pi) / 3)
      ents.Create("SpecialM", self.x, self.y, (5 * math.pi) / 6)
      ents.Create("SpecialM", self.x, self.y, math.pi)
      ents.Create("SpecialM", self.x, self.y, (7 * math.pi) / 6)
      ents.Create("SpecialM", self.x, self.y, (4 * math.pi) / 3)
      ents.Create("SpecialM", self.x, self.y, (3 * math.pi) / 2)
      ents.Create("SpecialM", self.x, self.y, (5 * math.pi) / 3)
      ents.Create("SpecialM", self.x, self.y, (11 * math.pi) / 6)
      self.qtime = love.timer.getTime()
   end
   if distance < (self.image:getWidth() / 2 + Tank.BaseImage:getWidth() / 2) * Reso.Scale then
      Tank.Health = 0
   end
end

--- Affiche l'entite.
function ent:draw()
   love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
   love.graphics.draw(self.imageT, self.x, self.y, self.angleT, Reso.Scale, Reso.Scale, self.imageT:getWidth() / 2, self.imageT:getHeight() / 2)
end

return ent;