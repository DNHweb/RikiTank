--
-- @file baseTank.lua
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

--> marche avant <--
function Avancer(x, y, Angle, Vitesse, dt)
	if (love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("z")) then
		Tank.OldPosition.x = x
		Tank.OldPosition.y = y
		avX = math.cos(Angle) * Vitesse * dt / 0.002		-- calcule de l'avancement en X selon la vitesse choisie et l'angle du tank
		avY = math.sin(Angle) * Vitesse * dt / 0.002		-- calcule de l'avancement en Y selon la vitesse choisie et l'angle du tank
		x = x + avX
		y = y + avY
	end
	return x, y
end

--> marche arrière <--
function Reculer(x, y, Angle, Vitesse, dt)
	if (love.keyboard.isDown("s") or love.keyboard.isDown("down")) then
		Tank.OldPosition.x = x
		Tank.OldPosition.y = y
		avX = math.cos(Angle) * Vitesse * dt / 0.002
		avY = math.sin(Angle)* Vitesse * dt / 0.002
		x = x - avX
		y = y - avY
	end
	return x, y
end

--> Pivoter le tank <--
function Pivoter(Angle, dt)
	local Angle2 = Angle
	--> Tourner en avançant <--
	if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) then
		if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
			Angle2 = TourneDroite(Angle, dt)
		end
		if (love.keyboard.isDown("a") or love.keyboard.isDown("left") or love.keyboard.isDown("q")) then
			Angle2 = TourneGauche(Angle, dt)
		end
	end
	--> Tourner en reculant <--
	if (love.keyboard.isDown("s") or love.keyboard.isDown("down")) then
		if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
			Angle2 = TourneGauche(Angle, dt)
		end
		if (love.keyboard.isDown("a") or love.keyboard.isDown("left") or love.keyboard.isDown("q")) then
			Angle2 = TourneDroite(Angle, dt)
		end
	end
	--> Tourner sur place <--
	if (not love.keyboard.isDown("w") and not love.keyboard.isDown("up") and not love.keyboard.isDown("s") and not love.keyboard.isDown("down")) then
		if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
			Angle2 = TourneDroite(Angle, dt)
		end
		if (love.keyboard.isDown("a") or love.keyboard.isDown("left") or love.keyboard.isDown("q")) then
			Angle2 = TourneGauche(Angle, dt)
		end
	end
	return Angle2
end

--> tourner à droite <--
function TourneDroite(Angle, dt)
	Angle = Angle + dt * math.pi/2	-- Calcule de
	Angle = Angle % (2*math.pi)		-- l'angle
	return Angle
end

--> tourner à gauche <--
function TourneGauche(Angle, dt)
	Angle = Angle - dt * math.pi/2
	Angle = Angle % (2*math.pi)
	return Angle
end

--> MAJ des carac de l'image en fonction des actions de l'utilisateur <--
function BaseTankUpdate(x, y, Angle, Vitesse, dt)
	Angle = Pivoter(Angle, dt)
	x, y = Avancer(x, y, Angle, Vitesse, dt)
	x, y = Reculer(x, y, Angle, Vitesse, dt)
	return x, y, Angle
end

--> Dessiner le tank en fonction de son angle et de sa position et de son centre de rotation <--
function BaseTankDraw(Image, x, y, Angle)
	Width = Image:getWidth()/2
	Height = Image:getHeight()/2
	love.graphics.draw(Image, x, y, Angle, Reso.Scale, Reso.Scale, Width, Height)
end