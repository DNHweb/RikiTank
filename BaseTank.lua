--> marche avant <--
function Avancer(x, y, Angle, Vitesse)
   if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) then
      avX = math.cos(Angle) * Vitesse 		-- calcule de l'avancement en X selon la vitesse choisie et l'angle du tank
      avY = math.sin(Angle) * Vitesse 		-- calcule de l'avancement en Y selon la vitesse choisie et l'angle du tank
      x = x + avX
      y = y + avY
   end
   return x, y
end

--> marche arrière <--
function Reculer(x, y, Angle, Vitesse)
   if (love.keyboard.isDown("s") or love.keyboard.isDown("down")) then
      avX = math.cos(Angle) * Vitesse
      avY = math.sin(Angle)* Vitesse
      x = x - avX
      y = y - avY
   end
   return x, y
end

--> Pivoter le tank <--
function Pivoter(Angle, dt)
   local Angle2 = Angle
   --> Tourner en avançant <--
   if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) then
      if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
	 Angle2 = TourneDroite(Angle, dt)
      end
      if (love.keyboard.isDown("a") or love.keyboard.isDown("left")) then
	 Angle2 = TourneGauche(Angle, dt)
      end	
   end
   --> Tourner en reculant <--
   if (love.keyboard.isDown("s") or love.keyboard.isDown("down")) then
      if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
	 Angle2 = TourneGauche(Angle, dt)
      end
      if (love.keyboard.isDown("a") or love.keyboard.isDown("left")) then
	 Angle2 = TourneDroite(Angle, dt)
      end	
   end
   --> Tourner sur place <--
   if (not love.keyboard.isDown("w") and not love.keyboard.isDown("up") and not love.keyboard.isDown("s") and not love.keyboard.isDown("down")) then
      if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
	 Angle2 = TourneDroite(Angle, dt)
      end
      if (love.keyboard.isDown("a") or love.keyboard.isDown("left")) then
	 Angle2 = TourneGauche(Angle, dt)
      end
   end
   return Angle2
end

--> tourner à droite <--
function TourneDroite(Angle, dt)
   Angle = Angle + dt * math.pi/2	-- Calcule de
   Angle = Angle % (2*math.pi)		-- l'angle
   return Angle
end

--> tourner à gauche <--
function TourneGauche(Angle, dt)
   Angle = Angle - dt * math.pi/2
   Angle = Angle % (2*math.pi)
   return Angle
end

--> Charge l'image de la base du tank <--
function BaseTankLoad()
end

--> MAJ des carac de l'image en fonction des actions de l'utilisateur <--
function BaseTankUpdate(x, y, Angle, Vitesse, dt)
   Angle = Pivoter(Angle, dt)
   x, y = Avancer(x, y, Angle, Vitesse)
   x, y = Reculer(x, y, Angle, Vitesse)
   return x, y, Angle
end

--> Dessiner le tank en fonction de son angle et de sa position et de son centre de rotation <--
function BaseTankDraw(Image, x, y, Angle)
   Width = Image:getWidth()/2
   Height = Image:getHeight()/2
   love.graphics.draw(Image, x, y, Angle, Reso.Scale, Reso.Scale, Width, Height)
end