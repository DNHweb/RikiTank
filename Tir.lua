
function ShootDraw()
	if EtatJeu == "EnJeu" then
	vx = Tank.Position.x + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.cos(Tank.Angle.Tourelle)
	vy = Tank.Position.y + (Tank.TourelleImage:getWidth() - Tank.RotTourelleWidth) * math.sin(Tank.Angle.Tourelle)
	--vangle = math.atan2(love.mouse.getX() - vx, vy - love.mouse.getY())-math.pi/2
	vlargeur = viseur:getWidth()/2
	vhauteur = viseur:getHeight()/2
		if love.mouse.isDown("l") then
			--love.graphics.draw(viseur, vx, vy, Tank.Angle.Tourelle + math.pi/2, Reso.Scale, Reso.Scale, vlargeur, vhauteur)			
			love.graphics.circle("fill", vx, vy, 5)
		end
	end
end