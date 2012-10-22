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
end