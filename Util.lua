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

function	getRandomCoord()
	x = math.random(-500, 500 + Reso.Width)
	y = 0
	
	if x < 0 or x > Reso.Width then
		y = math.random(-500, 500 + Reso.Height)
	else
		while y < 0 or y > Reso.Height do
			y = math.random(-500, 500 + Reso.Height)
		end
	end
	
	return x, y
end