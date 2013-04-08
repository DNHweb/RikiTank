-- 
-- @file EnJeu.lua
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

startTime = love.timer.getTime()
stime = love.timer.getTime()
bombTime = love.timer.getTime()
PopHeavyTank = 0
creerMastodonte = 0
BossScore = 0

--- Le jeu se deroule ici.
-- C'est la boucle qui fait tourner la partie,
-- utilisation de variable de temps pour l'apparition des ennemis a certain intervalle de temps.
-- On cree les ennemis ici, on dessine l'ATH et le tank.
-- Si la partie est termine, le contenu du tableau d'objets est efface, on lance le game over.
function		EnJeu()
   love.audio.stop(musicMenu)
   love.mouse.setVisible(false)
   GroundDraw()
   
   if Tank.Health > 0 then
      -- Timer pour l'apparition des ennemis
      local etime = love.timer.getTime()
      local bombCheck = love.timer.getTime()
      
      if etime - stime > nbSeconde then
	 local xTE, yTE = getRandomCoord()
	 ents.Create("TankEnnemie", xTE, yTE)
	 local xWalker, yWalker = getRandomCoord()
	 ents.Create("Walker", xWalker, yWalker)
	 PopHeavyTank = PopHeavyTank + 1
	 if PopHeavyTank >= 10 then
	    local xHT, yHT = getRandomCoord()
	    ents.Create("HeavyTank", xHT, yHT)
	    stime = love.timer.getTime()
	    PopHeavyTank = 0
	 end
	 stime = love.timer.getTime()
      end
      
      if Tank.PopBoss >= 750 then
	 EtatJeu = "Boss"
      end
      
      --[[
      if bombCheck - bombTime >= 23 then
	 bombTime = love.timer.getTime()
	 ents.Create("Bomb", 400, 400)
      end]]--
	  TankDraw()
ents:draw()
ATH_Life()
else
   ents.objects = {}
   if Tank.Score > Tank.Old_Score then
      Tank.Old_Score = Tank.Score
   end
   EtatJeu = "GameOver"
   --love.audio.play(ExplosionTank)
end
end

function 		Boss()
   love.audio.stop(musicMenu)
   GroundDraw()
   
   if Tank.Health > 0 then
      TankDraw()
      ATH_Life()
      if creerMastodonte == 0 then
	 local xMastodonte, yMastodonte = getRandomCoord()
	 Mastodonte = ents.Create("Mastodonte", xMastodonte, yMastodonte)
	 creerMastodonte = 1
      end
   else
      Tank.Health = 0
      ents.objects = {}
      EtatJeu = "GameOver"
   end
   ents:draw()
      ATH_Life()
end