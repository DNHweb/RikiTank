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

function ent:load(x, y)
	self:setPos(x, y)
	self.w = 95
	self.h = 54
end

function ent:setSize(w, h)
	self.w = w
	self.h = h
end

function ent:getSize()
	return self.w, self.h
end

function ent:update(dt)
	-- a coder l'IA ici normalement
	-- pour le moment on va juste le faire rouler de gauche a droite de l'ecran
	if self.x > Reso.Width then
		self.x = 50
	end
	self.x = self.x + 75 * dt
end

function ent:draw()
	local x, y = self:getPos()
	local w, h = self:getSize()
   
	love.graphics.draw(tankEnnemiePic, x, y)
end

return ent;