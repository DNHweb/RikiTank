 -- 
-- @file Passif.lua
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

function PouvoirTank1(PourcentageP)
	if PourcentageP > 100 then
		PourcentageP = 100
	end
end

function PouvoirTank1(PourcentageP)
	if PourcentageP >= 30 then
		--todo
		Tank.PourcentagePouvoir = Tank.PourcentagePouvoir - 30
	end
end

function PouvoirTank2(PourcentageP)
	if PourcentageP >= 30 then
		xBulle = Tank.Position.x - (Tank.BaseImage:getWidth()/2)
		yBulle = Tank.Position.y - (Tank.TourelleImage:getHeight()/2)
		if CreateBulle == 0 then
			ents.Create("Bulle", xBulle, yBulle)
			Tank.PourcentagePouvoir = Tank.PourcentagePouvoir - 30
			CreateBulle = 1
		end
	end
end

function PouvoirTank3(PourcentageP)
	if PourcentageP >= 30 then
		--todo
		Tank.PourcentagePouvoir = Tank.PourcentagePouvoir - 30
	end
end