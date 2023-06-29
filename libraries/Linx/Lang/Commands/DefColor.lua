return {
    name = "defcolor",
    run = function(r, g, b, a)
        love.graphics.setColor(r / 255 or 1, g /255 or 1, b / 255 or 1, a / 255 or 1)
    end
}