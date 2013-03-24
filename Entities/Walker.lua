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
	self.image = picWalker
	self.xx = Reso.Width / 6
	self.yy = Reso.Height / 6
end

--- Code a executer avant la destruction de l'entite.
function ent:Die()
	love.audio.play(SonExplosion)
	ents.Create("Explosion", self.x, self.y)
	Tank.Score = Tank.Score + 20

	if (math.random(10) <= 2) then
		ents.Create("Vitesse", self.x, self.y)
	end
end

--- Fait pivoter le Walker.
-- Calcul le nouvel angle du walker.
-- @param dt Delta Temps.
function	ent:pivoter(dt)
   self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
end

--- Fait avancer le Walker.
-- Calcul des nouvelles coordonnees du Walker.
-- @param dt Delta Temps.
function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
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
	
	self.xx = self.xx + self.xx / distance
	self.yy = self.yy + self.yy / distance
end

--- Affiche l'entite.
function ent:draw()
	love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
	--[[ Apparition sur le radar
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", Reso.Width - self.xx / 2, self.yy / 2, 5, 5)
	love.graphics.reset()]]
end

return ent;
