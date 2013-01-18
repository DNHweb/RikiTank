-- 
-- @file main.lua
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

require "Tank"
require "Ground"
require "Menu"
require "Entities"
require "Initialisation"
require "AnAL"

--[[ ---------------------------------------
-- | Declaration des structures et variables
]]-- ---------------------------------------

Reso = {
	Width,
	Height,
	Scale
}

Tank = {
	Choix = 1,
	Position = {x = 1024, y = 768},
	OldPosition = {x, y},
	Vitesse = Speed,
	Angle = {Base = 0, Tourelle = 0},
	RotTourelleWidth = 0,
	Health = 0,
	Dammage = 0,
	CadenceTir = 0,
	Tir = 10,
	Score = 0
}

Countdown = 3
CountdownSpeed = 1
CountdownTimer = 0

--[[ ---------------------
-- | Fonctions principales
]]-- ---------------------

function love.load()
   resolution()
   ents.Startup()
   ChoixTankLoad()
   SoundMenu()
   GroundLoad()
   normalFont = love.graphics.newFont("Fonts/Pixel.ttf", 18)
   countdownFont = love.graphics.newFont("Fonts/Pixel.ttf", 100)
   TankLoad()
end

function love.draw()
	EtatJeuDraw()
end

function love.update(dt)
	if EtatJeu == "Countdown" then
		if EtatJeu == "Countdown" then
			CountdownTimer = CountdownTimer + dt
		end
		if EtatJeu == "Countdown" and Countdown > 0 and CountdownTimer >= CountdownSpeed then
			Countdown = Countdown - 1
			CountdownTimer = 0
		end
		if EtatJeu == "Countdown" and Countdown == 0 then
			love.graphics.printf("Go !", Reso.Width/2, Reso.Height/2, 50)
			Countdown = 3
			EtatJeu = "EnJeu"
		end
	end
	
	if EtatJeu == "EnJeu" then
		TankUpdate(dt)
		ents:update(dt)
	end
end
