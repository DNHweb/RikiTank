require "Tank"
require "Sound"
require "Ground"
require "Menu"
--require "Shoot"

Reso = {
   Width,
   Height,
   Scale
}
resolution()

Tank = {
   Choix = 1,
   Position = {x = 200, y = 200},
   Vitesse = Speed,
   Angle = {Base = 0, Tourelle = 0},
   RotTourelleWidth = 0,
   Health = 0,
   Dammage = 0,
   CadenceTir = 0
}

-- Cette fonction est appelee une seule fois, on charge un max de truc ici au debut du jeu
-- pour economiser les ressources systemes au maximum.
function love.load()
   ChoixTankLoad()
   SoundMenu()
   GroundLoad()
   TankLoad()
end

function love.draw()
   EtatJeuDraw()
end

--Cette fonction est appelée en permanence
--'dt' = "delta temps", nombre de secondes depuis la dernière fois que cette fonction a été appelée

function love.update(dt)
   if EtatJeu == "EnJeu" then		-- si l'état du jeu est Play
      TankUpdate(dt)			-- on actualise la position du tank
   end
end