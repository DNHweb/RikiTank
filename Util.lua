-- 
-- @file Util.lua
-- This file is a part of RikiTank project, an amazing tank game !
-- Copyright (C) 2012  Riki-Team <rikitank.project@gmail.com>
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

--- Creation de coordonnees aleatoires.
-- Afin de faire apparaitre les ennemis a differents endroits pour un jeu un peu plus intense,
-- cette fonction retourne des coordonnes en dehors de l'ecran.
-- @return Coordonnee aleatoire en x.
-- @return Coordonnee aleatoire en y.
function	getRandomCoord()
   x = math.random(-500, 500 + Reso.Width)
   y = 0
   
   if x < -10 or x > Reso.Width + 10 then
      y = math.random(-500, 500 + Reso.Height)
   else
      while y < -10 or y < Reso.Height + 10 do
	 y = math.random(-500, 500 + Reso.Height)
      end
   end
   return x, y
end