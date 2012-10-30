require "BaseTank"
require "Tourelle"


function resolution()
   --> Met l'écran dans la résolution optimale <--
   modes = love.graphics.getModes()
   table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)
   Reso.Height = modes[1].height
   Reso.Width = modes[1].width
   love.graphics.setMode(Reso.Width , Reso.Height, true, false, 0 )

   diag = math.sqrt(Reso.Height*Reso.Height + Reso.Width*Reso.Width)
   defaut = math.sqrt(1366*1366 + 768*768)
   --> Calcule la vitesse en fonction de la résolution <--
   Speed = (diag * 0.35)/defaut

   --> calcule de la taille des images en fonction de la résolution <--
   Reso.Scale = (diag * 0.77) / defaut
end



function TankLoad()
   TourelleLoad()
   BaseTankLoad()
end

function TankDraw()
   BaseTankDraw(Tank.BaseImage, Tank.Position.x, Tank.Position.y, Tank.Angle.Base)
   TourelleDraw(Tank.TourelleImage , Tank.Position.x, Tank.Position.y, Tank.Angle.Tourelle, Tank.RotTourelleWidth)
end

function TankUpdate(dt)
   Tank.Position.x, Tank.Position.y, Tank.Angle.Base = BaseTankUpdate(Tank.Position.x, Tank.Position.y, Tank.Angle.Base, Tank.Vitesse, dt)
   Tank.Angle.Tourelle = TourelleUpdate(Tank.Position.x, Tank.Position.y, Tank.Angle.Tourelle, dt)
   -- ******************** --
   -- CHECK SORTIE D'ECRAN --
   -- ******************** --
   -- Pour alleger le code, peut etre rajouter des 'if' pour verifier que le tank soit proche de la bordure de l'ecran
   -- SI tank proche de la bordure THEN on verifie chaque pixel pour verifier que ca sorte pas END
   -- Comme cela se sera moins lourd !
   -- EN X
   if Tank.Position.x - 0.5 * Tank.BaseImage:getWidth() < 0 then
      Tank.Position.x = 0.5 * Tank.BaseImage:getWidth()
   end
   if Tank.Position.x + 0.5 * Tank.BaseImage:getWidth() > Reso.Width then
      Tank.Position.x = Reso.Width - 0.5 * Tank.BaseImage:getWidth()
   end
   -- EN Y
   if Tank.Position.y - Tank.BaseImage:getHeight() < 0 then
      Tank.Position.y = Tank.BaseImage:getHeight()
   end
   if Tank.Position.y + Tank.BaseImage:getHeight() > Reso.Height then
      Tank.Position.y = Reso.Height - Tank.BaseImage:getHeight()
   end
end