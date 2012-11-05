local ent = ents.Derive("base")

function	ent:load(x, y)
   self:setPos(x, y)
   self.w = 95
   self.h = 54
end

function	ent:setSize(w, h)
   self.w = w
   self.h = h
end

function	ent:getSize()
   return self.w, self.h
end

function	ent:update(dt)
   -- a coder l'IA ici normalement
   -- pour le moment on va juste le faire rouler de gauche a droite de l'ecran
   if self.x > Reso.Width then
      self.x = 50
   end
   self.x = self.x + 75 * dt
end

function	ent:draw()
   local x, y = self:getPos()
   local w, h = self:getSize()
   
   love.graphics.draw(tankEnnemiePic, x, y)
end

return ent;
