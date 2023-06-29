return {
    name = "setbg",
    run = function(r, g, b)
        love.graphics.setBackgroundColor(r / 255, g / 255, b / 255)
    end
}