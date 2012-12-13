-- 
-- @file Sound.lua
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

function SoundMenu()
	music = love.audio.newSource("Sounds/Menu.mp3")
	music:setVolume(0.25)
	love.audio.play(music)

	SonMenu2 = love.audio.newSource("Sounds/SonMenu2.mp3")
	SonMenu2:setVolume(0.75)

	SonMenu1 = love.audio.newSource("Sounds/SonMenu1.mp3")
	SonMenu1:setVolume(0.75)
end