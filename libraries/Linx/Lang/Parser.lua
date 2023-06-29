parser = {}

local _instances = {}

local commands = require 'src.Lang.Commands.Master'
--print(debug.getTableContent(commands))

--[[ legacy
function parser.readFile(file)
    for line in love.filesystem.lines(file) do
        local tokens = split(line)
        local cmd = tokens[1]
        table.remove(tokens, 1)
        _runCommand(cmd, unpack(tokens))
        tokens = {}
    end
end]]--

function parser.run(file)
    if #_instances <= 0 then
        parser.new(file)
    end
end

function parser.new(file)
    Parser = {}
    Parser.file = file
    Parser.inst = function()
        print("Running instance :: " .. Parser.file)
        for line in love.filesystem.lines(Parser.file) do
            local tokens = split(line)
            local cmd = tokens[1]
            table.remove(tokens, 1)
            _runCommand(cmd, unpack(tokens))
            tokens = {}
        end
        table.remove(_instances, self)
    end
    table.insert(_instances, Parser)
    Parser.inst(Parser.file)
end

--------------------------------------------------

function _runCommand(cmd, ...)
    command = _findCommandByName(cmd)
    ok, err = pcall(command, ...)
    if not ok then
        error("Instance causes an error : " .. err)
    end
end

function _findCommandByName(name)
    for c = 1, #commands, 1 do
        if commands[c].name == name then
            return commands[c].run
        end
    end
end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return parser