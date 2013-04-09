--
-- @file main.lua
-- This file is a part of RikiTank project, an amazing tank game !
-- Copyright (C) 2012 Riki-Team
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

require "Tank"
require "Ground"
require "Menu"
require "Entities"
require "Initialisation"
require "AnAL"
require "Sort"
require "Passif"

--[[ ---------------------------------------
-- | Declaration des structures et variables
]]-- ---------------------------------------

--- 
-- Table contenant les proprietes d'affichage
-- 
Reso = {
   Width,
   Height,
   Scale
}

--- 
-- Table contenant les proprietes du tank
-- 
Tank = {
   Choix = 1,
   Position = {x = 1024, y = 768},
   OldPosition = {x, y},
   Vitesse = Speed,
   Angle = {Base = 0, Tourelle = 0},
   RotTourelleWidth = 0,
   HealthBase = 0,
   Health = 0,
   Dammage = 0,
   CadenceTir = 0,
   Tir = love.timer.getTime(),
   Score = 0,
   PopBoss = 0,
   Old_Score = 0,
   PourcentagePouvoir = 0,
   Niveau = 0,
   Exp = 0
}

Countdown = 3
CountdownSpeed = 1
CountdownTimer = 0

CountdownSpeedSort = 1
CountdownTimerSort = 0

--[[ ---------------------
-- | Fonctions principales
]]-----------------------


--- Fonction de chargement.
-- Cette fonction est appelée une seule fois, lorsque le jeu est lancé, 
-- et est généralement celle où vous chargez des ressources,
-- initialisez des variables et des paramètres spécifiques ce qui économise beaucoup de ressources système.
function		love.load()
	resolution()
	ChoixTankLoad()
	SoundMenu()
	GroundLoad()
	FontLoad()
    ents.Startup()

   --[[if love.filesystem.exists("highscore.lst") then
      print("found the highscore file")
      for line in love.filesystem.lines("highscore.lst") do
	 Tank.Old_Score = tonumber(line)
      end
   else
      print("didn find the highscore file")
      file = love.filesystem.newFile("highscore.lst")
      file:open('w')
   end
print("Ancien Score : " .. Tank.Old_Score)]]--
end

--- Fonction de dessin.
-- C'est l'endroit pour tout ce qui concerne l'affichage et si vous appelez l'un des love.graphics.draw
-- en dehors de cette fonction elle n'aura pas d'effet. Cette fonction est aussi appelée en permanence.
function 		love.draw()
   EtatJeuDraw()
end

--- Fonction de mise-a-jour.
-- Cette fonction est appelée en permanence c’est l'endroit où la plupart des calculs sont fait.
-- 'dt' signifie "delta temps", c'est le nombre de secondes depuis la dernière fois que cette fonction a été appelée.
-- @param dt Nombre de seconde depuis le dernier appel a cette fonction.
function 		love.update(dt)

   if EtatJeu == "Countdown" then
      if EtatJeu == "Countdown" then
	 CountdownTimer = CountdownTimer + dt
      end
      if EtatJeu == "Countdown" and Countdown > 0 and CountdownTimer >= CountdownSpeed then
	 Countdown = Countdown - 1
	 CountdownTimer = 0
      end
      if EtatJeu == "Countdown" and Countdown == 0 then
	 Countdown = 3
	 EtatJeu = "EnJeu"
      end
   end
   
   if EtatJeu == "EnJeu" then
      TankUpdate(dt)
      ents:update(dt)
   end
   
   if EtatJeu == "Boss" or EtatJeu == "EnJeu" then
		CountdownTimerSort = CountdownTimerSort + dt
		if CountdownSort > 0 and CountdownTimerSort >= CountdownSpeedSort then
			CountdownSort = CountdownSort - 1
			CountdownTimerSort = 0	
		end
   end
   
   if EtatJeu == "Boss" then
      TankUpdate(dt)
      ents:update(dt)
   end
  
end

--- La fonction qui est appele avant de quitter le jeu.
-- On rentre le plus gros score du joueur dans le fichier de score.
-- 
function		love.quit()
   --[[ success = love.filesystem.write("highscore.lst", Tank.Old_Score, #tostring(Tank.Old_Score))
   if success == false then
      print("Erreur d'ecriture du score")
   end ]]--
end