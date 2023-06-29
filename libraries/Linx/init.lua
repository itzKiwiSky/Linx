local BASE = (...) .. "."

linx = {}

local drawEngine = require(BASE .. "drawEngine")

function linx:load(file)
    drawEngine:prepare(file)
end

function linx:render()
    drawEngine:render()
end

return linx