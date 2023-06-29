drawEngine = {}

parser = require 'src.Lang.Parser'

drawEngine.stack = {}

function drawEngine:prepare(filename)
    self.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setColor(1, 1, 1, 1)
        parser.run(filename)
        love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas()
end

function drawEngine:render()
    if self.canvas ~= nil then
        love.graphics.draw(self.canvas)
    end
end

return drawEngine