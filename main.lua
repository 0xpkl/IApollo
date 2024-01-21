local Ship = {}
Ship.x = 0
Ship.y = 0
Ship.angle = math.rad(270)
Ship.vx = 0
Ship.vy = 0
Ship.speed = 2
Ship.img = love.graphics.newImage("Images/ship.png")
Ship.imgEngine = love.graphics.newImage("Images/engine.png")

function love.load()
    --changement du filtre
    love.graphics.setDefaultFilter("nearest", "nearest")
    --Récupération Taille écran
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    --Paramètres image Ship
    Ship.x = width / 2
    Ship.y = height / 2
    oxShip = Ship.img:getWidth() / 2
    oyShip = Ship.img:getHeight() / 2
    --Paramètres image Engine
    oxEngine = Ship.imgEngine:getWidth() / 2
    oyEngine = Ship.imgEngine:getHeight() / 2

    --Affichage Console
    print("Height Ship = ", Ship.img:getHeight())
    print("Width Ship = ", Ship.img:getWidth())
end

function love.update(dt)
    --Gravité
    Ship.vy = Ship.vy + (0.6 * dt)

    --Déplacement avec vélocité
    Ship.x = Ship.x + Ship.vx
    Ship.y = Ship.y + Ship.vy

    --Déplacement avec touches
    if love.keyboard.isDown("up") then
        TurnEngineOn = true
        --Application Vitesse Ship
        force_x = math.cos(Ship.angle) * Ship.speed * dt
        force_y = math.sin(Ship.angle) * Ship.speed * dt
        Ship.vx = Ship.vx + force_x
        Ship.vy = Ship.vy + force_y
    else
        TurnEngineOn = false
    end

    --Limite Vitesse
    if math.abs(Ship.vx) <= 0.9 then
    else
        if Ship.vx > 0 then
            Ship.vx = 0.9
        else
            Ship.vx = -0.9
        end
    end
    if math.abs(Ship.vy) < 0.9 then
    else
        if Ship.vy > 0 then
            Ship.vy = 0.9
        else
            Ship.vy = -0.9
        end
    end
    --Fin Limite Vitesse

    if love.keyboard.isDown("right") then
        Ship.angle = Ship.angle + math.rad(90) * dt
        if Ship.angle > math.rad(360) then
            Ship.angle = math.rad(0)
        end
    end
    if love.keyboard.isDown("left") then
        Ship.angle = Ship.angle - math.rad(90) * dt
        if Ship.angle < math.rad(0) then
            Ship.angle = math.rad(360)
        end
    end

    --Remettre le vaisseau à l'écran
    if Ship.y > height + 10 then
        Ship.y = 10
    end
    if Ship.y < 0.001 then
        Ship.y = height
    end
    if Ship.x > width + 8 then
        Ship.x = 8
    end
    if Ship.x < 0.001 then
        Ship.x = width
    end
end

function love.draw()
    love.graphics.draw(Ship.img, Ship.x, Ship.y, Ship.angle, 1, 1, oxShip, oyShip)
    if TurnEngineOn == true then
        love.graphics.draw(Ship.imgEngine, Ship.x, Ship.y, Ship.angle, 1, 1, oxEngine, oyEngine)
    end

    local sDebug = "Debug : "
    sDebug = sDebug .. "angle = " .. tostring(Ship.angle * 180 / math.pi)
    sDebug = sDebug .. " vy = " .. tostring(Ship.vy)
    sDebug = sDebug .. " vx = " .. tostring(Ship.vx)
    love.graphics.print(sDebug, 0, 0)
end
