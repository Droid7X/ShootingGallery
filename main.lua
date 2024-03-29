function love.load()
    target = {}
    target.x = 300
    target.y = 200
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1

    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshair = love.graphics.newImage('sprites/crosshair.png')

    love.mouse.setVisible(false)

    
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 0
        gameState = 1
    end

end

function love.draw()

    love.graphics.draw(sprites.sky,0,0)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont) 

    love.graphics.print("Score: " .. score,5,5)
    
    if gameState == 2 then 
        love.graphics.draw(sprites.target, target.x - target.radius, target.y- target.radius)
        love.graphics.printf("Timer: " .. math.ceil(timer), -10, 5, love.graphics.getWidth(), "right")
    end

    if gameState == 1 then
        love.graphics.printf("Click anywhere to get shoot'in!", 0, 250, love.graphics.getWidth(), "center" )
    end

    love.graphics.draw(sprites.crosshair, love.mouse.getX() - 20 , love.mouse.getY() - 20)
    
end

function love.mousepressed(x, y, button, istouch, presses)
    local mouseDistance = distanceBetween(target.x, target.y, x, y)

    if gameState == 2 then
        if mouseDistance <= target.radius then
            if button == 1 then
                score = score + 1
            
            elseif button == 2 then
                score = score + 3
                timer = timer - 1
            end
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif score > 0 then
            score = score - 1
        end 

    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
end