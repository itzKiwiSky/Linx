return {
    name = "plgn",
    run = function(mode, ...)
        love.graphics.line(mode, unpack(...))
    end,
}