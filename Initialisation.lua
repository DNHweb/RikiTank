-- 
-- @file Initialisation.lua
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

--[[ -------------------------------
-- | Initialisation de la resolution
]]-- -------------------------------

--- Mise au point de l'ecran
-- Cette fonction va rechercher les differentes resolutions disponible,
-- les classer dans un tableau, puis choisira la plus grande resoltion pour le jeu.
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

--[[ ----------------------
-- | Initialisation du menu
]]-- ----------------------


--- Creation du menu.
-- Charge les boutons et affiche le menu a l'ecran.
function ChoixTankLoad()

	LogoRT = love.graphics.newImage("Images/LogoRT.png")
	ImageTankMenu = love.graphics.newImage("Images/ImageTankMenu.png")
	ImageTankPause = love.graphics.newImage("Images/ImageTankPause.png")
	Viseur = love.graphics.newImage("Images/viseur.png")
	
	JouerOn = love.graphics.newImage("Images/Menu/JouerOn.png")
	JouerOff = love.graphics.newImage("Images/Menu/JouerOff.png")
	MenuOn = love.graphics.newImage("Images/Menu/MenuOn.png")
	MenuOff = love.graphics.newImage("Images/Menu/MenuOff.png")
	RegleOn = love.graphics.newImage("Images/Menu/ReglesOn.png")
	RegleOff = love.graphics.newImage("Images/Menu/ReglesOff.png")
	RetourOn = love.graphics.newImage("Images/Menu/RetourOn.png")
	RetourOff = love.graphics.newImage("Images/Menu/RetourOff.png")
	ValiderOn = love.graphics.newImage("Images/Menu/ValiderOn.png")
	ValiderOff = love.graphics.newImage("Images/Menu/ValiderOff.png")
	AnnulerOn = love.graphics.newImage("Images/Menu/AnnulerOn.png")
	AnnulerOff = love.graphics.newImage("Images/Menu/AnnulerOff.png")
	ReprendreOn = love.graphics.newImage("Images/Menu/ReprendreOn.png")
	ReprendreOff = love.graphics.newImage("Images/Menu/ReprendreOff.png")
	QuitterOn = love.graphics.newImage("Images/Menu/QuitterOn.png")
	QuitterOff = love.graphics.newImage("Images/Menu/QuitterOff.png")
	DemarrerOn = love.graphics.newImage("Images/Menu/DemarrerOn.png")
	DemarrerOff = love.graphics.newImage("Images/Menu/DemarrerOff.png")
   
	Tank1On = love.graphics.newImage("Images/Menu/Tank1On.png")
	Tank1Off = love.graphics.newImage("Images/Menu/Tank1Off.png")
	Tank2On = love.graphics.newImage("Images/Menu/Tank2On.png")
	Tank2Off = love.graphics.newImage("Images/Menu/Tank2Off.png")
	Tank3On = love.graphics.newImage("Images/Menu/Tank3On.png")
	Tank3Off = love.graphics.newImage("Images/Menu/Tank3Off.png")
	Tank4On = love.graphics.newImage("Images/Menu/Tank4On.png")
	Tank4Off = love.graphics.newImage("Images/Menu/Tank4Off.png")
	InfoTankVide = love.graphics.newImage("Images/Menu/InfoTankVide.png")
	InfoTank1 = love.graphics.newImage("Images/Menu/InfoTank1.png")
	InfoTank2 = love.graphics.newImage("Images/Menu/InfoTank2.png")
	InfoTank3 = love.graphics.newImage("Images/Menu/InfoTank3.png")
   
	BlastOn = love.graphics.newImage("Images/Menu/BlastOn.png")
	BlastOff = love.graphics.newImage("Images/Menu/BlastOff.png")
	FlashOn = love.graphics.newImage("Images/Menu/FlashOn.png")
	FlashOff = love.graphics.newImage("Images/Menu/FlashOff.png")
	SoinOn = love.graphics.newImage("Images/Menu/SoinOn.png")
	SoinOff = love.graphics.newImage("Images/Menu/SoinOff.png")
	Interface = love.graphics.newImage("Images/Interface.png")
	Transparent = love.graphics.newImage("Images/Transparent.png")
	GameOver = love.graphics.newImage("Images/GameOver.png")
   
	Bouton = {
		Main = {
			Jouer = {On = JouerOn, Off = JouerOff, x = 120, y = (Reso.Height/3)+15, Width = 260, Height = 70, Id = "GoChoixTank"},
			Regles = {On = RegleOn, Off = RegleOff, x = 120, y = (Reso.Height/2)+22, Width = 260, Height = 70, Id = "Regles"},
			Quitter1 = {On = QuitterOn, Off = QuitterOff, x = 120, y =(3*Reso.Height/4)-35, Width = 260, Height = 70, Id = "Quitter1"}
		},
		Pause = {
			Reprendre = {On = ReprendreOn, Off = ReprendreOff, x = 120, y =(Reso.Height/3)+15, Width = 260, Height = 70, Id = "Reprendre"},
			Menu = {On = MenuOn, Off = MenuOff, x = 120, y = (Reso.Height/2)+22, Width = 260, Height = 70, Id = "Menu"},
			Quitter2 = {On = QuitterOn, Off = QuitterOff, x = 120, y = (3*Reso.Height/4)-35, Width = 260, Height = 70, Id = "Quitter2"}
		},
		Choix = {
			Tank1 = {On = Tank1On, Off = Tank1Off, x = (Reso.Width/4)-58, y = (Reso.Height/4)-100, Width = 164, Height = 164, Id = "Tank1"},
			Tank2 = {On = Tank2On, Off = Tank2Off, x = (Reso.Width/3), y = (Reso.Height/4)-100, Width = 164, Height = 164, Id = "Tank2"},
			Tank3 = {On = Tank3On, Off = Tank3Off, x = (Reso.Width/4)-58, y = (Reso.Height/2)-120, Width = 164, Height = 164, Id = "Tank3"},
			Tank4 = {On = Tank4On, Off = Tank4Off, x = (Reso.Width/3), y = (Reso.Height/2)-120, Width = 164, Height = 164, Id = "Tank4"},
			Demarrer = {On = DemarrerOn, Off = DemarrerOff, x = (Reso.Width/2)-130, y = (Reso.Height)-130, Width = 260, Height = 70, Id = "Demarrer"},
			Blast = {On = BlastOn, Off = BlastOff, x = (Reso.Width/4)-40, y = (Reso.Height/2)+138, Width = 94, Height = 94, Id = "Blast"},
			Flash = {On = FlashOn, Off = FlashOff, x = (Reso.Width/4)+63, y = (Reso.Height/2)+138, Width = 94, Height = 94, Id = "Flash"},
			Soin = {On = SoinOn, Off = SoinOff, x = (Reso.Width/3)+52, y = (Reso.Height/2)+138, Width = 94, Height = 94, Id = "Soin"}			
		},
		GameOver = {
			Menu = {On = MenuOn, Off = MenuOff, x = (Reso.Width/2)-130, y = (Reso.Height)-140, Width = 260, Height = 70, Id = "Menu"}
		},
		Regles = {
			Retour = {On = RetourOn, Off = RetourOff, x = (Reso.Width)-53, y = (Reso.Height)-53, Width = 33, Height = 33, Id = "Retour"}
		},
		Valide = {
			Valider = {On = ValiderOn, Off = ValiderOff, x = (Reso.Width/2)-124, y = (Reso.Height/2), Width = 104, Height = 34, Id = "Valider"},
			Annuler = {On = AnnulerOn, Off = AnnulerOff, x = (Reso.Width/2)+20, y = (Reso.Height/2), Width = 104, Height = 34, Id = "Annuler"}
		},
		Ok = {
			Ok = {On = ValiderOn, Off = ValiderOff, x = (Reso.Width/2)-52, y = (Reso.Height/2), Width = 104, Height = 34, Id = "Ok"}
		}
	}	
end

--[[ --------------------------
-- | Initialisation des polices
]]-- --------------------------

--- Chargement des polices.
-- Charge en memoire les polices composant le jeu.
function FontLoad()
	normalFont = love.graphics.newFont("Fonts/ActionMan.ttf", 18)
	menuFont = love.graphics.newFont("Fonts/old_stamper.ttf", 50)
	countdownFont = love.graphics.newFont("Fonts/ActionMan.ttf", 100)
	HealthFont = love.graphics.newFont("Fonts/ActionMan.ttf", 15)
	CDSortFont = love.graphics.newFont("Fonts/ActionMan.ttf", 25)
end

--[[ -----------------------
-- | Initialisation des sons
]]-- -----------------------

--- Chargement des sons.
-- Charge les sons dans la memoire puis applique des modifications (volume, repeat, ...).
function SoundMenu()
   musicMenu = love.audio.newSource("Sounds/Confusus.mp3", "static")
   musicMenu:setVolume(0.25)
   musicMenu:rewind()
   
   SonMenu1 = love.audio.newSource("Sounds/SonMenu1.mp3")
   SonMenu1:setVolume(0.75)
   SonMenu2 = love.audio.newSource("Sounds/SonMenu2.mp3")
   SonMenu2:setVolume(0.75)
   Retour = love.audio.newSource("Sounds/Retour.mp3")
   SonMenu2:setVolume(0.75)
   
   SonExplosion = love.audio.newSource("Sounds/SonExplosion.mp3", "stream")
   SonExplosion:setVolume(0.75)
   SonTir = love.audio.newSource("Sounds/Tir.mp3")
   SonTir:setVolume(0.75)
   SonSoin = love.audio.newSource("Sounds/Soin.mp3")
   SonSoin:setVolume(0.75)
   ExplosionTank = love.audio.newSource("Sounds/ExplosionTank.mp3")
   ExplosionTank:setVolume(0.75)
end

--[[ ------------------------------------
-- | Initialisation des elements du decor
]]-- ------------------------------------

--- Chargement du decor
-- Charge en memoire les images composant le decor.
function GroundLoad()
	Ground1 = love.graphics.newImage("Images/Ground.jpg")
	Mur1 = love.graphics.newImage("Images/Murs/Horizontal.png")
   
	picWalker = love.graphics.newImage("Images/Walker.png")
	picWalkerRouge = love.graphics.newImage("Images/WalkerRouge.png")
	picTankEBGris = love.graphics.newImage("Images/BaseTank4Gris.png")
	picTankETGris = love.graphics.newImage("Images/TourelleTank4Gris.png")
	picTankEB = love.graphics.newImage("Images/BaseTank4.png")
	picTankET = love.graphics.newImage("Images/TourelleTank4.png")
	picTankHB = love.graphics.newImage("Images/BaseHeavyTank.png")
	picTankHT = love.graphics.newImage("Images/TourelleHeavyTank.png")
	picBaseMastodonte = love.graphics.newImage("Images/BaseMastodonte.png")
	picTourelleMastodonte = love.graphics.newImage("Images/TourelleMastodonte.png")
   
   picMissile = love.graphics.newImage("Images/Missile.png")
   picMissileE = love.graphics.newImage("Images/MissileE.png")
   picMissileM = love.graphics.newImage("Images/MissileM.png")
   picSpecialM = love.graphics.newImage("Images/SpecialM.png")
   BaseBlast = love.graphics.newImage("Images/BlastOld.png")
   picBlast = love.graphics.newImage("Images/Blast.png")

	picMissile = love.graphics.newImage("Images/Missile.png")
	picMissileE = love.graphics.newImage("Images/MissileE.png")
	picMissileM = love.graphics.newImage("Images/MissileM.png")
	picSpecialM = love.graphics.newImage("Images/SpecialM.png")
	BaseBlast = love.graphics.newImage("Images/BlastOld.png")
	picBlast = love.graphics.newImage("Images/Blast.png")
	picBulle = love.graphics.newImage("Images/Bulle.png")
   
	picMedikit = love.graphics.newImage("Images/medikit.png")
	picVitesse = love.graphics.newImage("Images/BonusVitesse.png")
	picResistance = love.graphics.newImage("Images/BonusResistance.png")
   
   Explosion = love.graphics.newImage("Images/explosion.png")
   ExplosionBomb = love.graphics.newImage("Images/explosionBomb.png")
   AnimationSoin = love.graphics.newImage("Images/AnimationSoin.png")
   ExplosionEnnemi = love.graphics.newImage("Images/ExplosionEnnemi.png")
   
	Explosion = love.graphics.newImage("Images/explosion.png")
	ExplosionBomb = love.graphics.newImage("Images/explosionBomb.png")
	AnimationSoin = love.graphics.newImage("Images/AnimationSoin.png")
	ExplosionEnnemie = love.graphics.newImage("Images/ExplosionEnnemie.png")
end