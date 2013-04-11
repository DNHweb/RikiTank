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
	
	-- Exp
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 100, 12, 165, 18)
	love.graphics.reset()
	if Tank.Niveau ~= 5 then
		if Tank.Exp >= 250 then
			Caracteristique()
			Tank.Exp = Tank.Exp - 250
			Tank.Niveau = Tank.Niveau + 1
		end
		love.graphics.setColor(8, 97, 186, 200)
		love.graphics.rectangle("fill", 100, 12, Tank.Exp / 250 * 93 * Reso.Width / Reso.Height, 18)
		love.graphics.reset()
	else
		love.graphics.setColor(8, 97, 186, 200)
		love.graphics.rectangle("fill", 100, 12, 93 * Reso.Width / Reso.Height, 18)
		love.graphics.reset()
	end

   -- Interface
   love.graphics.draw(Interface, 10, 10)

   -- Point de vie
   love.graphics.setFont(HealthFont)
   love.graphics.setColor(100, 100, 100, 100)
   love.graphics.rectangle("fill", 103, 38, 73 * Reso.Width / Reso.Height, 14)
   love.graphics.reset()
   love.graphics.setColor(0, 174, 5, 200)
   local pourcent = Tank.Health / Tank.HealthBase
   if (pourcent > 0.5) then
      color = math.floor((1 - pourcent) * 500) 
      love.graphics.setColor(color, 255, 0, 235)
      love.graphics.rectangle("fill", 103, 38, pourcent * 73 * Reso.Width / Reso.Height, 14)
      love.graphics.reset()
   else
      color = math.floor((0.5 - pourcent) * 530)
      color = 250 - color
      if (color < 0) then
	 color = 0
      end
      love.graphics.setColor(255, color, 0, 235)
      love.graphics.rectangle("fill", 103, 38, pourcent * 73 * Reso.Width / Reso.Height, 14)
      love.graphics.reset()
   end
   love.graphics.reset()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.printf(math.floor(Tank.Health) .. "/" .. math.floor(Tank.HealthBase), 103, 40, 73 * Reso.Width / Reso.Height, "center")
   love.graphics.printf(math.floor(Tank.Health * 100 / Tank.HealthBase) .. "%", 180, 40, 75 * Reso.Width / Reso.Height, "center")
   love.graphics.reset()
   
   -- Barre de Pouvoir
   love.graphics.setColor(100, 100, 100, 100)
   love.graphics.rectangle("fill", 103, 55, 73 * Reso.Width / Reso.Height, 14)
   love.graphics.reset()
   if Tank.PourcentagePouvoir > 100 then
      Tank.PourcentagePouvoir = 100
   end
   love.graphics.setColor(185, 16, 22, 200)
   love.graphics.rectangle("fill", 103, 55, Tank.PourcentagePouvoir / 100 * 73 * Reso.Width / Reso.Height, 14)
   love.graphics.reset()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.printf(Tank.PourcentagePouvoir .. "/100",103, 57, 73 * Reso.Width / Reso.Height, "center")
   love.graphics.printf(Tank.PourcentagePouvoir .. "%", 180, 57, 75 * Reso.Width / Reso.Height, "center")
   love.graphics.reset()

   -- Score
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.printf("Score : " .. Tank.Score, 95, 16, 93 * Reso.Width / Reso.Height, "center")
   love.graphics.reset()

   -- Niveau
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.printf(Tank.Niveau, 10, 15, 20, "center")
   love.graphics.reset()

   -- Sort
   if ChoixSort == 1 then
      love.graphics.draw(BlastOn, 34, 11, 0, 0.65, 0.652)
   elseif ChoixSort == 2 then
      love.graphics.draw(FlashOn, 34, 11, 0, 0.65, 0.652)
   elseif ChoixSort == 3 then
      love.graphics.draw(SoinOn, 34, 11, 0, 0.65, 0.652)
   end
   if CountdownSort ~= 0 then
      love.graphics.setColor(50, 50, 50, 190)
      love.graphics.rectangle("fill", 35, 80 - 100 * CountdownSort / 135, 58, (100 * CountdownSort / 135) - 10)
      love.graphics.reset()
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.setFont(CDSortFont)
      love.graphics.printf(CountdownSort, 58, 35, 10, "center")
      love.graphics.reset()
      love.graphics.setFont(normalFont)
      end
	  
	  -- Viseur
	  love.graphics.draw(Viseur, love.mouse.getX(), love.mouse.getY(), 0, 0.33, 0.33, Viseur:getWidth() / 2, Viseur:getHeight() / 2)
end