return {
    name = "setfg",
    run = function(r, g, b, a)
        print(r, g, b, a)
        love.graphics.setColor(tonumber(r) / 255 or 1, tonumber(g) / 255 or 1, tonumber(b) / 255 or 1, tonumber(a) / 255)
    end
}