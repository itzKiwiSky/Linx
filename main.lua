function love.load()
    --drawEngine = require 'src.DrawEngine'
    --% addons loader --
    Addons = love.filesystem.getDirectoryItems("libraries/addons")
    for addon = 1, #Addons, 1 do
        require("libraries.addons." .. string.gsub(Addons[addon], ".lua", ""))
    end

    linx = require 'src'
end

function love.draw()
    --drawEngine:render()
    love.graphics.setFont(love.graphics.newFont(20))
    linx:render()
end

function love.update(elapsed)
end

function love.keypressed(k)
    if k == "return" then
        linx:load("Tests/DefvarTest.linx")
        --linx:load("Tests/marioBlock.linx")
    end
end

function pack(...)
    return {...}
end

