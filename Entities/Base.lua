-- 
-- @file Base.lua
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

local base = {}
base.x = -100
base.y = -100
base.health = 100
base.angle = 0
base.vitesse = 0.30
base.damage = 0
base.cadenceTir = 0

--- Fixer une position.
-- @param x Position en x.
-- @param y Position en y.
function base:setPos(x, y)
   base.x = x
   base.y = y
end

--- Retourne la position.
-- @return La position en x.
-- @return La position en y.
function base:getPos()
   return base.x, base.y
end

--- Fixe la vitesse.
-- @param v Vitesse.
function base:setVitesse(v)
   base.vitesse = v
end

function base:load()
   
end

return (base)
