-- 
-- @file Tank.lua
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

require "BaseTank"
require "Tourelle"
require "Collision"

--- Affichage du tank et tourelle.
function TankDraw()
   BaseTankDraw(Tank.BaseImage, Tank.Position.x, Tank.Position.y, Tank.Angle.Base)
   TourelleDraw(Tank.TourelleImage , Tank.Position.x, Tank.Position.y, Tank.Angle.Tourelle, Tank.RotTourelleWidth)
end

function Caracteristique()
	if ChoixTank == 1 then
		Tank.Dammage = Tank.Dammage + Tank.Dammage * 0.02
		Tank.CadenceTir = Tank.CadenceTir + Tank.CadenceTir * 0.03
	elseif ChoixTank == 2 then
		Tank.CadenceTir = Tank.CadenceTir + Tank.CadenceTir * 0.02
		Tank.Vitesse = Tank.Vitesse + Tank.Vitesse * 0.03
	elseif ChoixTank == 3 then
		Tank.HealthBase = Tank.HealthBase + Tank.HealthBase * 0.02
		Tank.Health = Tank.Health + Tank.Health * 0.02
		Tank.Dammage = Tank.Dammage + Tank.Dammage * 0.03
	end
end

--- Mise-a-jour du tank et tourelle.
-- On met a jour les coordonnes (x, y), l'angle de la base du tank et de la tourelle.
-- @param dt Delta Temps.
function TankUpdate(dt)
   Tank.Position.x, Tank.Position.y, Tank.Angle.Base = BaseTankUpdate(Tank.Position.x, Tank.Position.y, Tank.Angle.Base, Tank.Vitesse, dt)
   SortieEcran()
   Tank.Angle.Tourelle = TourelleUpdate(Tank.Position.x, Tank.Position.y, Tank.Angle.Tourelle, dt)
end
