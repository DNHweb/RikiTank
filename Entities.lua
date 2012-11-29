-- 
-- @file Entities.lua
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

-- 
-- C'est ici que l'on gere les entities.
-- Les entites sont des objets, ils vont correspondre a nos tank ennemis
-- 

ents = {}
ents.objects = {}				-- liste contenant les objects actifs
ents.objectpath = "Entities/"	-- ou sont les objects
local register = {}
local id = 0

-- on remplie le registre avec nos objets
function	ents.Startup()
   register["TankEnnemie"] = love.filesystem.load(ents.objectpath .. "TankEnnemie.lua")
   register["Walker"] = love.filesystem.load(ents.objectpath .. "Walker.lua")
   register["Missile"] = love.filesystem.load(ents.objectpath .. "Missile.lua")
end

-- un peu comme une fonction d'heritage
-- quand on va creer un objet, ca decoulera de ca
function	ents.Derive(name)
   return love.filesystem.load(ents.objectpath .. name .. ".lua")()
end

function	ents.Create(name, x, y)
   if not x then
      x = -100
   end
   
   if not y then
      y = -100
   end
   
   -- entite existe
   if register[name] then
      -- a chaque fois que l'on cree une entite
      -- on veut lui donner un nouvel id
      id = id + 1
      local ent = register[name]()
      ent:load()
      ent:setPos(x, y)
      ent.id = id
      -- un # devant un nom de tableau retourne le nombre d'element du tableau
      ents.objects[#ents.objects + 1] = ent
      return ents.objects[#ents.objects]
   else
      print("Erreur : l'entite " .. name .. " n'existe pas.")
      return false
   end
end

-- Quand on veut enlever un object du tableau d'objet
function	ents.Destroy(id)
   if ents.objects[id] then
      if ents.objects[id].Die then
	 ents.objects[id]:Die()
      end
      ents.objects[id] = nil
   end
end

-- a chaque fois que cette fonction est appelee
-- elle met a jour les objets du tableau
function	ents:update(dt)
   for i, ent in pairs(ents.objects) do
      if ent.update then
	 ent:update(dt)
      end
   end
end

function	ents:draw()
   for i, ent in pairs(ents.objects) do
      if ent.draw then
	 ent:draw()
      end
   end
end
