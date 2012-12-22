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

local ent = ents.Derive("base")

function ent:setPos( x, y )
	self.x = x
	self.y = y
end

function ent:load( x, y )
	self:setPos( x, y )
	self.image = love.graphics.newImage("Images/Walker.png")
end

function ent:Die()
	ents.Create("Walker", math.random(Reso.Width + 20, Reso.Width + 500), math.random(Reso.Height + 20, Reso.Height + 500))
	ents.Create("Walker", math.random(-500, -20), math.random(-500, Reso.Height + 500))
	Tank.Health = Tank.Health - 20
	print("Tank " .. self.id .. " destroyed.")
end

function	ent:pivoter(dt)
   self.angle = math.atan2(self.x - Tank.Position.x, Tank.Position.y - self.y) + math.pi / 2
end

function	ent:avancer(dt)
   self.x = self.x + math.cos(self.angle) * self.vitesse * dt / 0.002
   self.y = self.y + math.sin(self.angle) * self.vitesse * dt / 0.002
end

function	ent:update(dt)

	-- IA
	distance = ((self.x - Tank.Position.x) ^ 2 + (self.y - Tank.Position.y) ^ 2) ^ 0.5
	-- si collision
	if distance < (self.image:getWidth() / 3 + Tank.BaseImage:getWidth() / 3) then
		ents.Destroy(self.id)
	end
	self:pivoter(dt)
	self:avancer(dt)
end

function ent:draw()
	love.graphics.draw(self.image, self.x, self.y, self.angle, Reso.Scale, Reso.Scale, 0, 0)
end

return ent;
