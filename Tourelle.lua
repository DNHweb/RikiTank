-- 
-- @file Tourelle.lua
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

love.mouse.setVisible(false)

--- Affichage du tank et tourelle.
-- On dessine successivement la base du tank puis la tourelle par dessus.
-- @param Image Base du tank.
-- @param x Position en x du tank.
-- @param y Position en y du tank.
-- @param Angle Angle de la base du tank.
-- @param Width Longeur de la tourelle.
function TourelleDraw(Image, x, y, Angle, Width)
   local Width2 = Image:getWidth()/2 - width
   local Height = Image:getHeight()/2
   love.graphics.draw(Image, x, y, Angle, Reso.Scale, Reso.Scale, Width2, Height)
end

--- Mise-a-jour de l'angle de la tourelle.
-- En fonction de la position de la souris, la rotation de la tourelle est modifie.
-- @param x Position en x du tank.
-- @param y Position en y du tank.
-- @param Angle Angle de la tourelle.
-- @param dt Delta Temps.
-- @return Retourne le nouvel angle de la tourelle.
function TourelleUpdate(x, y, Angle,dt)
   Angle = math.atan2(love.mouse.getX() - x, y - love.mouse.getY())-math.pi/2
   return Angle
end