love.mouse.setVisible(false)

function TourelleLoad()
	viseur = love.graphics.newImage("Images/viseur2.png")
end

function TourelleDraw(Image, x, y, Angle, Width)
	local Width2 = Image:getWidth()/2 - width
	local Height = Image:getHeight()/2
	love.graphics.draw(Image, x, y, Angle, Reso.Scale, Reso.Scale, Width2, Height)
	largeur = viseur:getWidth()/2
	hauteur = viseur:getHeight()/2
	love.graphics.draw(viseur , love.mouse.getX(), love.mouse.getY(), 0, Reso.Scale, Reso.Scale, largeur, hauteur)
end

function TourelleUpdate(x, y, Angle,dt)
	Angle = math.atan2(love.mouse.getX() - x, y - love.mouse.getY())-math.pi/2
	return Angle
end