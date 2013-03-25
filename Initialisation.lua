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
   Speed = (diag * 0.30)/defaut
   
   --> calcule de la taille des images en fonction de la résolution <--
   Reso.Scale = (diag * 0.77) / defaut
end

--[[ ----------------------
-- | Initialisation du menu
]]-- ----------------------


--- Creation du menu.
-- Charge les boutons et affiche le menu a l'ecran.
function ChoixTankLoad()
   JouerOn = love.graphics.newImage("Images/Menu/JouerOn.png")
   JouerOff = love.graphics.newImage("Images/Menu/JouerOff.png")
   MenuOn = love.graphics.newImage("Images/Menu/MenuOn.png")
   MenuOff = love.graphics.newImage("Images/Menu/MenuOff.png")
   QuitterOn = love.graphics.newImage("Images/Menu/QuitterOn.png")
   QuitterOff = love.graphics.newImage("Images/Menu/QuitterOff.png")
   Tank1On = love.graphics.newImage("Images/Menu/Tank1On.png")
   Tank1Off = love.graphics.newImage("Images/Menu/Tank1Off.png")
   Tank2On = love.graphics.newImage("Images/Menu/Tank2On.png")
   Tank2Off = love.graphics.newImage("Images/Menu/Tank2Off.png")
   Tank3On = love.graphics.newImage("Images/Menu/Tank3On.png")
   Tank3Off = love.graphics.newImage("Images/Menu/Tank3Off.png")
   Transparent = love.graphics.newImage("Images/Transparent.png")
   GameOver = love.graphics.newImage("Images/GameOver.png")
   
   Bouton = {
      Main = {
	 Jouer = {On = JouerOn, Off = JouerOff, x = 100, y = (Reso.Height/3)-35, Width = 260, Height = 70, Id = "GoChoixTank"},
	 Quitter1 = {On = QuitterOn, Off = QuitterOff, x = 100, y =(2*Reso.Height/3)-35, Width = 260, Height = 70, Id = "Quitter1"}
      },
      Pause = {
	 Reprendre = {On = JouerOn, Off = JouerOff, x = 100, y =(Reso.Height/4)-35, Width = 260, Height = 70, Id = "Reprendre"},
	 Menu = {On = MenuOn, Off = MenuOff, x = 100, y = (Reso.Height/2)-35, Width = 260, Height = 70, Id = "Menu"},
	 Quitter2 = {On = QuitterOn, Off = QuitterOff, x = 100, y = (3*Reso.Height/4)-35, Width = 260, Height = 70, Id = "Quitter2"}
      },
      Choix = {
	 Tank1 = {On = Tank1On, Off = Tank1Off, x = (Reso.Width/4)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank1"},
	 Tank2 = {On = Tank2On, Off = Tank2Off, x = (Reso.Width/2)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank2"},
	 Tank3 = {On = Tank3On, Off = Tank3Off, x = (3*Reso.Width/4)-115, y = (Reso.Height/2)-115, Width = 230, Height = 230, Id = "Tank3"}
      },
      GameOver = {
	 Menu = {On = MenuOn, Off = MenuOff, x = (Reso.Width/2)-70, y = (Reso.Height/2)-35, Width = 260, Height = 70, Id = "Menu"}
      }
   }
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
   
   SonExplosion = love.audio.newSource("Sounds/SonExplosion.mp3", "stream")
   SonExplosion:setVolume(0.75)
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
   picTankEB = love.graphics.newImage("Images/BaseTank4.png")
   picTankET = love.graphics.newImage("Images/TourelleTank4.png")
   picMastodonte = love.graphics.newImage("Images/Mastodonte.png")
   picMedikit = love.graphics.newImage("Images/medikit.png")
   picMissile = love.graphics.newImage("Images/Missile.png")
   picMissileE = love.graphics.newImage("Images/MissileE.png")
   picMissileM = love.graphics.newImage("Images/MissileM.png")
   picVitesse = love.graphics.newImage("Images/BonusVitesse.png")
   
   Explosion = love.graphics.newImage("Images/explosion.png")
   ExplosionBomb = love.graphics.newImage("Images/explosionBomb.png")
end