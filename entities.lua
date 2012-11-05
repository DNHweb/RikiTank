-- 
-- C'est ici que l'on gere les entities.
-- Les entites sont des objets, ils vont correspondre a nos tank ennemis
-- 

ents = {}
ents.objects = {}				-- liste contenant les objects actifs
ents.objectpath = "entities/"	-- ou sont les objects
local register = {}
local id = 0

-- on remplie le registre avec nos objets
function	ents.Startup()
   register["tankEnnemie"] = love.filesystem.load(ents.objectpath .. "tankEnnemie.lua")
end

-- un peu comme une fonction d'heritage
-- quand on va creer un objet, ca decoulera de ca
function	ents.Derive(name)
   return love.filesystem.load(ents.objectpath .. name .. ".lua")()
end

function	ents.Create(name, x, y)
   if not x then
      x = 50
   end
   
   if not y then
      y = 50
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
