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
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.setFont(HealthFont)
   love.graphics.print("VIE : ", 10, 15)
   love.graphics.setFont(normalFont)
   love.graphics.reset()
   love.graphics.setColor(255, 0, 0, 100)
   love.graphics.rectangle("fill", 80, 10, 200 * Reso.Width / Reso.Height, 30)
   love.graphics.reset()
   love.graphics.setColor(52, 255, 52, 100)
   love.graphics.rectangle("fill", 80, 10, Tank.Health / Tank.HealthBase * 200 * Reso.Width / Reso.Height, 30)
   love.graphics.reset()
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.setFont(HealthFont)
   love.graphics.printf(Tank.Health .. " / " .. Tank.HealthBase, 80, 17, 200 * Reso.Width / Reso.Height, "center")
   love.graphics.reset()
   
   -- Score
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.setFont(HealthFont)
   love.graphics.print("Score : " .. Tank.Score, 10, 50)
   love.graphics.setFont(normalFont)
   love.graphics.reset()
   
   -- Sort
	if ChoixSort == 1 then
		love.graphics.draw(BlastOn, 10, 80)
	elseif ChoixSort == 2 then
		love.graphics.draw(FlashOn, 10, 80)
	elseif ChoixSort == 3 then
		love.graphics.draw(SoinOn, 10, 80)
	end
	if CountdownSort ~= 0 then
		love.graphics.setColor(50, 50, 50, 190)
		love.graphics.rectangle("fill", 12, 148 - 100 * CountdownSort / 180, 90, 25 + (100 * CountdownSort / 180))
		love.graphics.reset()
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.setFont(CDSortFont)
		love.graphics.printf(CountdownSort, 53, 118, 10, "center")
		love.graphics.reset()
		love.graphics.setFont(normalFont)
	end
	
	-- Barre de Passif
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.setFont(HealthFont)
	love.graphics.print("PASSIF : ", Reso.Width/2 - 110, 15)
	love.graphics.setFont(normalFont)
	love.graphics.reset()
	love.graphics.setColor(0, 0, 0, 100)
	love.graphics.rectangle("fill", Reso.Width/2, 10, 200 * Reso.Width / Reso.Height, 30)
	love.graphics.reset()
	if Tank.PourcentagePassif > 100 then
		Tank.PourcentagePassif = 100
	end
	love.graphics.setColor(0, 0, 255, 100)
	love.graphics.rectangle("fill", Reso.Width/2, 10, Tank.PourcentagePassif / 100 * 200 * Reso.Width / Reso.Height, 30)
	love.graphics.reset()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.setFont(HealthFont)
	love.graphics.printf(Tank.PourcentagePassif .. " %", Reso.Width/2, 17, 200 * Reso.Width / Reso.Height, "center")
	love.graphics.reset()
	love.graphics.setFont(normalFont)
	
end