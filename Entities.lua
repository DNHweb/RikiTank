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

--- Demarrage des entites.
-- Une sorte de catalogue qui dit quels objets on peut creer
-- et les charge en memoire.
function ents.Startup()
	register["Missile"] = love.filesystem.load(ents.objectpath .. "Tirs/Missile.lua")
	register["MissileE"] = love.filesystem.load(ents.objectpath .. "Tirs/MissileE.lua")
	register["MissileM"] = love.filesystem.load(ents.objectpath .. "Tirs/MissileM.lua")
	register["SpecialM"] = love.filesystem.load(ents.objectpath .. "Tirs/SpecialM.lua")
	register["Bomb"] = love.filesystem.load(ents.objectpath .. "Tirs/Bomb.lua")

	register["Walker"] = love.filesystem.load(ents.objectpath .. "Ennemies/Walker.lua")
	register["Mastodonte"] = love.filesystem.load(ents.objectpath .. "Ennemies/Mastodonte.lua")
	register["HeavyTank"] = love.filesystem.load(ents.objectpath .. "Ennemies/HeavyTank.lua")
	register["TankEnnemie"] = love.filesystem.load(ents.objectpath .. "Ennemies/TankEnnemie.lua")

	register["Explosion"] = love.filesystem.load(ents.objectpath .. "Animations/Explosion.lua")
	register["ExplosionBomb"] = love.filesystem.load(ents.objectpath .. "Animations/ExplosionBomb.lua")
	register["AnimationSoin"] = love.filesystem.load(ents.objectpath .. "Animations/AnimationSoin.lua")
	register["ExplosionEnnemie"] = love.filesystem.load(ents.objectpath .. "Animations/ExplosionEnnemie.lua")
	
	register["Medikit"] = love.filesystem.load(ents.objectpath .. "Bonus/Medikit.lua")
	register["Vitesse"] = love.filesystem.load(ents.objectpath .. "Bonus/Vitesse.lua")
	register["Resistance"] = love.filesystem.load(ents.objectpath .. "Bonus/Resistance.lua")
	register["SpeedOn"] = love.filesystem.load(ents.objectpath .. "Bonus/SpeedOn.lua")
	register["Blast"] = love.filesystem.load(ents.objectpath .. "Bonus/Blast.lua")
	register["Bulle"] = love.filesystem.load(ents.objectpath .. "Bonus/Bulle.lua")
end

--- Une fonction d'heritage.
-- Quand on va creer un objet, l'objet sera cree en fonction de son modele charge en memoire.
-- Cf : ents.Startup et son register.
function ents.Derive(name)
   return love.filesystem.load(ents.objectpath .. name .. ".lua")()
end

--- Creation d'une nouvelle entite
-- Si on a pas specifie de coordonnes et/ou d'angle on en attribut par defaut.
-- Si le nom de l'objet existe dans le registre alors on lui affecte different attribut
-- (id, type, angle, coordonnees) puis on le stock dans le tableau d'objets a la case correspondant a son id.
-- @return L'objet cree -> si l'entite existe dans le registre.
-- @return False -> si l'entite n'existe pas de le registre.
function ents.Create(name, x, y, angle)
   if not x then
      x = -100
   end

   if not y then
      y = -100
   end
   
   if not angle then
      angle = 0
   end
   
   if register[name] then
      id = id + 1
      local ent = register[name]()
      ent:load()
      ent.type = name
      ent.angle = angle
      ent:setPos(x, y)
      ent.id = id
      ents.objects[id] = ent
      return ents.objects[id]
   else
      print("Erreur : l'entite " .. name .. " n'existe pas.")
      return false
   end
end

--- Destruction d'un objet.
-- Quand on veut enlever un object du tableau d'objet :
-- si il existe un objet dans le tableau d'objet correspondant a l'id donne alors on met cette case du tableau a nil ( = null ).
-- Si l'objet que l'on veut effacer possede une fonction Die() alors on execute cette fonction avec de detruire l'objet.
-- @param id L'id de l'objet a effacer.
function ents.Destroy( id )
   if ents.objects[id] then
      if ents.objects[id].Die then
	 ents.objects[id]:Die()
      end
      ents.objects[id] = nil
   end
end

--- Mise-a-jour des entites.
-- Parcours le tableau d'entites et les met a jour.
-- On gere les collisions entre entites, par exemple : entre les missiles et les walkers.
-- @param dt Delta Temps.
function ents:update(dt)
   for i, ent in pairs(ents.objects) do
      if ent.update then
	 ent:update(dt)
	 if ent.type == "Missile" then
	    for j, obj in pairs(ents.objects) do
	       if obj.type == "Walker" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.5
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale then
		     ents.Destroy(obj.id)
		     ents.Destroy(ent.id)
		     break
		  end
	       elseif obj.type == "TankEnnemie" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.5
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale then
		     obj.health = obj.health - Tank.Dammage
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
		     end
		     ents.Destroy(ent.id)
		     break
		  end
	       elseif obj.type == "HeavyTank" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.5
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale then
		     obj.health = obj.health - Tank.Dammage
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
		     end
		     ents.Destroy(ent.id)
		     break
		  end
	       elseif obj.type == "Mastodonte" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.5
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale then
		     obj.health = obj.health - Tank.Dammage
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
			EtatJeu = "EnJeu"
			creerMastodonte = 0
		     end
		     ents.Destroy(ent.id)
		     break
		  end
	       end
	    end
	 end
	 if ent.type == "Blast" then
	    for j, obj in pairs(ents.objects) do
	       if obj.type == "Walker" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.35
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * (Reso.Scale * 2.1) then
		     ents.Destroy(obj.id)
		  end
	       elseif obj.type == "TankEnnemie" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.35
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale * 2.1 then
		     obj.health = obj.health - 200
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
		     end
		  end
	       elseif obj.type == "HeavyTank" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.35
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale * 2.1 then
		     obj.health = obj.health - 200
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
		     end
		  end
	       elseif obj.type == "Mastodonte" then
		  local distance = ((ent.x - obj.x) ^ 2.5 + (ent.y - obj.y) ^ 2) ^ 0.35
		  if distance < (obj.image:getWidth() / 2 + ent.image:getWidth() / 2) * Reso.Scale * 2.1 then
		     obj.health = obj.health - 200
		     local impact = love.audio.newSource("Sounds/impact.mp3", "stream")
		     impact:setVolume(0.75)
		     love.audio.play(impact)
		     ents.Create("Explosion", obj.x, obj.y)
		     if obj.health < 0 then
			ents.Destroy(obj.id)
			EtatJeu = "EnJeu"
			creerMastodonte = 0
		     end
		  end
	       end
	    end
	 end
      end
   end
end

--- Affichage des entites.
-- Parcours le tableau d'entites et les affiche.
function ents:draw()
   for i, ent in pairs(ents.objects) do
      if ent.draw then
	 ent:draw()
      end
   end
end