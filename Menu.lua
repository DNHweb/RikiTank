-- 
-- @file Menu.lua
-- This file is a part of RikiTank project, an amazing tank game !
--1;2403;0c- Copyright (C) 2012  Riki-Team
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

require "Initialisation"
require "Util"
require "Entities"
require "ATH"
require "EnJeu"

EtatJeu = "Menu"
startTime = love.timer.getTime()
stime = love.timer.getTime()
bombTime = love.timer.getTime()
nbSeconde = 5
ChoixTank = 0
ChoixSort = 0

--- Affiche un bouton.
-- Si la souris est sur le bouton, un contour orange sera autour du bouton,
-- sinon un contour noir.
-- @param off Image du bouton avec le contour noir.
-- @param on Image du bouton avec le contour orange.
-- @param x Position x du bouton.
-- @param y Position y du bouton.
-- @param w Longeur du bouton.
-- @param h Largeur du bouton.
local function drawButton(off, on, x, y, w, h)
   love.graphics.setBackgroundColor( 190, 190, 190, 255 )
   local px = love.mouse.getX()
   local py = love.mouse.getY()
   if px > x and px < x + w and py > y and  py < y + h then
      love.graphics.draw(on, x, y)
   else
      love.graphics.draw(off, x, y)
   end
end

--- Gere les differents etat de jeu.
-- Etat de jeu : choix, pause, countdown, en jeu.
-- Dans cette fonction on a la gestion des menus et la gestion d'une partie.
function EtatJeuDraw()
   local x = love.mouse.getX( )
   local y = love.mouse.getY( )
   
   love.audio.play(musicMenu)
   if EtatJeu == "Menu" then
      love.graphics.draw(LogoRT, Reso.Width/2 - (LogoRT:getWidth()/2), 15)
      love.graphics.draw(ImageTankMenu, Reso.Width - ImageTankMenu:getWidth(), Reso.Height - ImageTankMenu:getHeight())
      love.mouse.setVisible(true)
      for k, v in pairs(Bouton.Main) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   if EtatJeu == "Regles" then
      love.mouse.setVisible(true)
      love.graphics.setFont(normalFont)
      love.graphics.printf("Ici prochainement les regles du jeu.", (Reso.Width/2)-250, Reso.Height/2, 500, "center")
      for k, v in pairs(Bouton.Regles) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   if EtatJeu == "Choix" then
      love.mouse.setVisible(true)
      love.graphics.setFont(menuFont)
      love.graphics.setColor(224, 157, 40, 200)
      love.graphics.printf("selectionnez votre tank", (Reso.Width/2)-400, 15, 800, "center")
      love.graphics.printf("selectionnez votre soutien", (Reso.Width/2)-500, (Reso.Height/2)+63, 1000, "center")
      love.graphics.reset()
      love.graphics.draw(InfoTankVide, (Reso.Width/2)-50, (Reso.Height/4)-100)
      for k, v in pairs(Bouton.Choix) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      for k, v in pairs(Bouton.Regles) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      if ChoixTank == 1 then
	 love.graphics.draw(Tank1On, (Reso.Width/4)-58, (Reso.Height/4)-100)
	 love.graphics.draw(InfoTank1, (Reso.Width/2)-50, (Reso.Height/4)-100)
      elseif ChoixTank == 2 then
	 love.graphics.draw(Tank2On, (Reso.Width/3), (Reso.Height/4)-100)
	 love.graphics.draw(InfoTank2, (Reso.Width/2)-50, (Reso.Height/4)-100)
      elseif ChoixTank == 3 then
	 love.graphics.draw(Tank3On, (Reso.Width/4)-58, (Reso.Height/2)-120)
	 love.graphics.draw(InfoTank3, (Reso.Width/2)-50, (Reso.Height/4)-100)
      end
      if ChoixSort == 1 then
	 love.graphics.draw(BlastOn, (Reso.Width/4)-40, (Reso.Height/2)+138)
      elseif ChoixSort == 2 then
	 love.graphics.draw(FlashOn, (Reso.Width/4)+63, (Reso.Height/2)+138)
      elseif ChoixSort == 3 then
	 love.graphics.draw(SoinOn, (Reso.Width/3)+52, (Reso.Height/2)+138)
      end
   end
   
   if EtatJeu == "Pause" then
      love.mouse.setVisible(true)
      love.graphics.setFont(countdownFont)
      love.graphics.printf("Pause", (Reso.Width/2)-100, 70, 200, "center")
      love.graphics.draw(ImageTankPause, Reso.Width - ImageTankPause:getWidth(), Reso.Height - ImageTankPause:getHeight() - 50)
      for k, v in pairs(Bouton.Pause) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.setFont(normalFont)
   end
   
   if EtatJeu == "GameOver" then
      love.audio.stop()
      love.mouse.setVisible(true)
      GroundDraw()
      Map()
      love.graphics.setFont(countdownFont)
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      love.graphics.draw(GameOver, Reso.Width/2, (Reso.Height/3)+140, 0, 1, 1, GameOver:getWidth()/2, GameOver:getHeight()/2)
      love.graphics.printf("Score " .. Tank.Score, (Reso.Width/2)-15, 30, 30, "center")
      love.graphics.setFont(normalFont)
      for k, v in pairs(Bouton.GameOver) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
   end
   
   --> Validation de continuer ou non la partie <--
   if EtatJeu == "Valide1" then
      love.mouse.setVisible(true)
      love.graphics.setFont(countdownFont)
      love.graphics.printf("Pause", (Reso.Width/2)-100, 70, 200, "center")
      love.graphics.draw(ImageTankPause, Reso.Width - ImageTankPause:getWidth(), Reso.Height - ImageTankPause:getHeight() - 50)
      for k, v in pairs(Bouton.Pause) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      for k, v in pairs(Bouton.Valide) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.setFont(normalFont)
      love.graphics.printf("Etes-vous sur de vouloir quitter la partie en cours et revenir au menu principal ?", Reso.Width/2-200, (Reso.Height/2)-50, 400, "center")
   end
   
   --> Validation de quitter le jeu ou non dans le menu pause <--
   if EtatJeu == "Valide2" then
      love.mouse.setVisible(true)
      love.graphics.setFont(countdownFont)
      love.graphics.printf("Pause", (Reso.Width/2)-100, 70, 200, "center")
      love.graphics.draw(ImageTankPause, Reso.Width - ImageTankPause:getWidth(), Reso.Height - ImageTankPause:getHeight() - 50)
      for k, v in pairs(Bouton.Pause) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      for k, v in pairs(Bouton.Valide) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.setFont(normalFont)
      love.graphics.printf("Etes-vous sur de vouloir quitter la partie en cours et revenir au bureau ?", Reso.Width/2-175, (Reso.Height/2)-50, 350, "center")
   end
   
   --> Validation de quitter le jeu ou non dans le menu principal <--
   if EtatJeu == "Valide3" then
      love.mouse.setVisible(true)
      love.graphics.setFont(normalFont)
      love.graphics.draw(LogoRT, Reso.Width/2 - (LogoRT:getWidth()/2), 15)
      love.graphics.draw(ImageTankMenu, Reso.Width - ImageTankMenu:getWidth(), Reso.Height - ImageTankMenu:getHeight())
      for k, v in pairs(Bouton.Main) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      for k, v in pairs(Bouton.Valide) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.printf("Etes-vous sur de vouloir quitter la partie en cours et revenir au bureau ?", (Reso.Width/2)-175, (Reso.Height/2)-50, 350, "center")
   end
   
   if EtatJeu == "Valide4" then
      love.mouse.setVisible(true)
      love.graphics.setFont(menuFont)
      love.graphics.setColor(224, 157, 40, 200)
      love.graphics.printf("selectionnez votre tank", (Reso.Width/2)-400, 15, 800, "center")
      love.graphics.printf("selectionnez votre soutien", (Reso.Width/2)-500, (Reso.Height/2)+63, 1000, "center")
      love.graphics.reset()
      love.graphics.draw(InfoTankVide, (Reso.Width/2)-50, (Reso.Height/4)-100)
      love.graphics.setFont(normalFont)
      for k, v in pairs(Bouton.Choix) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      for k, v in pairs(Bouton.Regles) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      for k, v in pairs(Bouton.Ok) do
	 drawButton( v.Off, v.On, v.x, v.y, v.Width, v.Height, x, y )
      end
      
      love.graphics.printf("Vous devez selectionner un tank et un sort pour pouvoir commencer la partie", (Reso.Width/2)-175, (Reso.Height/2)-50, 350, "center")
   end
   
   if EtatJeu == "Countdown" then
      love.mouse.setVisible(false)
      GroundDraw()
      Map()
      TankDraw()
      ATH_Life()
      love.graphics.draw(Transparent, 0, 0, 0, Reso.Width/2, Reso.Height/2)
      love.graphics.printf("La partie debute dans :",( Reso.Width/2)-100, (Reso.Height/2)-50, 200, "center")
      love.graphics.setFont(countdownFont)
      love.graphics.printf(Countdown, (Reso.Width/2)-10, Reso.Height/2, 10, "center")
      love.graphics.setFont(normalFont)
   end
   
   if EtatJeu == "EnJeu" then
      EnJeu()
   end
   
   if EtatJeu == "Boss" then
      Boss()
   end
   
   if love.mouse.isDown("l") and (EtatJeu == "EnJeu" or EtatJeu == "Boss") then
      local dt2 = love.timer.getTime()
      if ((dt2 - Tank.Tir) > 1 / Tank.CadenceTir) then
	 xMissile = Tank.Position.x + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.cos(Tank.Angle.Tourelle)
	 yMissile = Tank.Position.y + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.sin(Tank.Angle.Tourelle)
	 ents.Create("Missile", xMissile, yMissile)
	 --love.audio.play(SonTir)
	 Tank.Tir = love.timer.getTime()
      end
   end
end

--- Verifie le clique souris.
-- Differente reaction en fonction de ou le joueur a clique;
-- par exemple, dans un menu, si le joueur clique sur "Jouer", alors on lance le jeu.
-- @param x Position x de la souris.
-- @param y Position y de la souris.
-- @param button Le bouton presse sur la souris.
function love.mousepressed(x, y, button)

   if button == "l" then
      if EtatJeu == "Menu" then
	 for k, v in pairs(Bouton.Main) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "GoChoixTank" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Choix"
	       elseif v.Id == "Regles" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Regles"
	       elseif v.Id == "Quitter1" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Valide3"
	       end
	    end
	 end
      elseif EtatJeu == "Regles" then
	 for k, v in pairs(Bouton.Regles) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       love.audio.play(Retour)
	       EtatJeu = "Menu"
	    end
	 end
      elseif EtatJeu == "Choix" then
	 for k, v in pairs(Bouton.Choix) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       --> Si on choisit le Tank 1 <--
	       if v.Id == "Tank1" then
		  ChoixTank = 1
	       end
	       --> Si on choisit le Tank 2 <--
	       if v.Id == "Tank2" then
		  ChoixTank = 2
	       end
	       --> Si on choisit le Tank 3 <--
	       if v.Id == "Tank3" then
		  ChoixTank = 3
	       end
	       if v.Id == "Blast" then
		  ChoixSort = 1
	       end
	       if v.Id == "Flash" then
		  ChoixSort = 2
	       end
	       if v.Id == "Soin" then
		  ChoixSort = 3
	       end
	       if v.Id == "Demarrer" then
		  if (ChoixTank == 0 or ChoixSort == 0) then
		     love.audio.play(SonMenu2)
		     EtatJeu = "Valide4"
		  elseif (ChoixTank ~= 0 and ChoixSort ~= 0) then
		     love.audio.play(SonMenu2)
		     if ChoixTank == 1 then
			ChargerTank1()
			EtatJeu = "Countdown"
			CountdownSort = 0
		     elseif ChoixTank == 2 then
			ChargerTank2()
			EtatJeu = "Countdown"
			CountdownSort = 0
		     elseif ChoixTank == 3 then
			ChargerTank3()
			EtatJeu = "Countdown"
			CountdownSort = 0
		     end
		  end
	       end
	       ents.objects = {}
	    end
	 end
	 for k, v in pairs(Bouton.Regles) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Retour" then
		  love.audio.play(Retour)
		  EtatJeu = "Menu"
		  ChoixTank = 0
		  ChoixSort = 0
		  CountdownSort = 0
		  PopHeavyTank = 0
	       end
	    end
	 end
      elseif EtatJeu == "Valide1" then
	 for k, v in pairs(Bouton.Valide) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Valider" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Menu"
		  ChoixTank = 0
		  ChoixSort = 0
		  CountdownSort = 0
		  PopHeavyTank = 0
	       elseif v.Id == "Annuler" then
		  love.audio.play(Retour)
		  EtatJeu = "Pause"
	       end
	    end
	 end
      elseif EtatJeu == "Valide4" then
	 for k, v in pairs(Bouton.Ok) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Ok" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Choix"
	       end
	    end
	 end
      elseif EtatJeu == "Valide2" then
	 for k, v in pairs(Bouton.Valide) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Valider" then
		  love.audio.play(SonMenu2)
		  love.event.push("quit")
	       elseif v.Id == "Annuler" then
		  love.audio.play(Retour)
		  EtatJeu = "Pause"
	       end
	    end
	 end
      elseif EtatJeu == "Valide3" then
	 for k, v in pairs(Bouton.Valide) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Valider" then
		  love.audio.play(SonMenu2)
		  love.event.push("quit")
	       elseif v.Id == "Annuler" then
		  love.audio.play(Retour)
		  EtatJeu = "Menu"
	       end
	    end
	 end
      elseif EtatJeu == "GameOver" then
	 for k, v in pairs(Bouton.GameOver) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Menu" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Menu"
		  CountdownSort = 0
		  ChoixTank = 0
		  ChoixSort = 0
		  PopHeavyTank = 0
	       end
	    end
	 end
      elseif EtatJeu == "Pause" then
	 for k, v in pairs(Bouton.Pause) do
	    if x > v.x and x < v.x + v.Width and y > v.y and  y < v.y + v.Height then
	       if v.Id == "Reprendre" then
		  love.audio.play(SonMenu2)
		  if oldEJ == 0 then
		     EtatJeu = "EnJeu"
		  elseif oldEJ == 1 then
		     EtatJeu = "Boss"
		  end
		  --> Si on choisit le bouton menu du menu pause <--
	       elseif v.Id == "Menu" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Valide1"
		  --> Si on choisit le bouton quitter du menu pause <--
	       elseif v.Id == "Quitter2" then
		  love.audio.play(SonMenu2)
		  EtatJeu = "Valide2"
	       end
	    end
	 end
      end
   end
end

--- Verifie les touches tape au clavier.
-- Si on clique sur Echappe pendant une partie, le jeu se met en pause.
-- Si on clique sur Echappe dans le menu pause, le jeu reprend.
-- @param key La touche tape sur le clavier.
function love.keypressed(key)
	if EtatJeu == "EnJeu" or EtatJeu == "Boss" then
		if ChoixSort == 1 and key == " " then
			Blast(CountdownSort)
		elseif ChoixSort == 2 and key == " " then
			Flash(CountdownSort)
		elseif ChoixSort == 3 and key == " " then
			Soin(CountdownSort)
		end
		if ChoixTank == 1 and key == "f" then
			PouvoirTank1(Tank.PourcentagePouvoir)
		elseif ChoixTank == 2 and key == "f" then
			PouvoirTank2(Tank.PourcentagePouvoir)
		elseif ChoixTank == 3 and key == "f" then
			PouvoirTank3(Tank.PourcentagePouvoir)
		end
		if key == "escape" then
			if EtatJeu == "Boss" then
				oldEJ = 1
			else
				oldEJ = 0
			end
			EtatJeu = "Pause"
		elseif key == "escape" and EtatJeu=="Pause" then
			if oldEJ == 1 then
				EtatJeu = "Boss"
			elseif oldEJ == 0 then
				EtatJeu = "EnJeu"
			end
		end
	end
end

--- Charge le tank 1.
function ChargerTank1()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank1.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank1.png")
   Tank.RotTourelleWidth = 89
   Tank.Vitesse = (Speed * 5)/7
   Tank.Dammage = 40 + 40 * 0.02
   Tank.Health = 225
   Tank.HealthBase = 225
   Tank.CadenceTir = 1.7 + 1.7 * 0.03
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2
   Tank.Angle.Base = 0
   Tank.Score = 0
   Tank.PopBoss = 0
   Tank.PourcentagePouvoir = 0
   Tank.Niveau = 1
   Tank.Exp = 0
end

--- Charge le tank 2.
function ChargerTank2()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank2.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank2.png")
   Tank.RotTourelleWidth = 103
   Tank.Vitesse = (Speed * 4)/7 + (Speed * 4)/7 * 0.03
   Tank.Dammage = 48
   Tank.Health = 315
   Tank.HealthBase = 315
   Tank.CadenceTir = 1.02 + 1.02 * 0.02
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2 
   Tank.Angle.Base = 0
   Tank.Score = 0
   Tank.PopBoss = 0
   Tank.PourcentagePouvoir = 0
   Tank.Niveau = 1
   Tank.Exp = 0
   CreateBulle = 0
end

--- Charge le tank 3.
function ChargerTank3()
   Tank.BaseImage = love.graphics.newImage("Images/BaseTank3.png")
   Tank.TourelleImage = love.graphics.newImage("Images/TourelleTank3.png")
   Tank.RotTourelleWidth = 50
   Tank.Vitesse = (Speed * 6) / 7
   Tank.Dammage = 24 + 24 * 0.03
   Tank.Health = 180 + 180 * 0.02
   Tank.HealthBase = 180 + 180 * 0.02
   Tank.CadenceTir = 2.38
   Tank.Position.x = Reso.Width/2
   Tank.Position.y = Reso.Height/2
   Tank.Angle.Base = 0
   Tank.Score = 0
   Tank.PopBoss = 0
   Tank.PourcentagePouvoir = 0
   Tank.Niveau = 1
   Tank.Exp = 0
end