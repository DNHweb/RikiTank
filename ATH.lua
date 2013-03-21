-- 
-- @file ATH.lua
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

--- Gestion de l' ATH
-- Un ATH est une interface qui permet au joueur d'avoir des informations sur sa partie (vie, munitions par exemple).
-- Ici : barre de vie, score, radar.
function		ATH_Life()
	-- Point de vie
	love.graphics.print("VIE : ", 10, 15)
	love.graphics.setColor(255, 0, 0, 100)
	love.graphics.rectangle("fill", 60, 10, Tank.Health * Reso.Width / Reso.Height, 30)
	love.graphics.reset()

	-- Score
	love.graphics.print("Score : " .. Tank.Score, 10, 50)
end