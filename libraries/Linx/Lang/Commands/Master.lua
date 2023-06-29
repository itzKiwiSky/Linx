master = {}

local commands = love.filesystem.getDirectoryItems("src/Lang/Commands")
for c = 1, #commands, 1 do
    if commands[c] ~= "Master.lua" then
        table.insert(master, require("src.Lang.Commands." .. string.gsub(commands[c], ".lua", "")))
    end
end

return master