
function GroundLoad()
   Ground1 = love.graphics.newImage("Images/Ground1.png")
   --Ground2 = love.graphics.newImage("Images/Ground2.png")
   --Ground3 = love.graphics.newImage("Images/Ground3.png")
   --Ground4 = love.graphics.newImage("Images/Ground4.png")
end

function GroundDraw()
   width = love.graphics.getWidth( ) / 128
   height = love.graphics.getHeight( ) / 128
   start2 = 0
   for i = 0, width do
      start = 0
      for j = 0, height do
	 love.graphics.draw(Ground1, start2, start)
	 start = start + 128
      end
      start2 = start2 + 128
   end
end