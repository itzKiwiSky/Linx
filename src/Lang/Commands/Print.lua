return {
    name = "write",
    run = function(x, y, ...)
        local text = {}
        for t = 1, #pack(...), 1 do
            table.insert(text, pack(...)[t])
        end
        love.graphics.print(table.concat(text, " "), x, y)
    end
}