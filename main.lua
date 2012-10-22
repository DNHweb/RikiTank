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

function love.load()
	ChoixTankLoad()
	SoundMenu()
	GroundLoad()
	TankLoad()
end

function love.draw()
	EtatJeuDraw()
	--love.graphics.print(Tank.Choix, 700,150)
end

function love.update(dt)
	if EtatJeu == "EnJeu" then		-- si l'état du jeu est Play
		TankUpdate(dt)				-- on actualise la position du tank
	end
end