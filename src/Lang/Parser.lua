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
    Parser.stack = {}
    Parser.inst = function()
        for line in love.filesystem.lines(Parser.file) do
            local tokens = split(line)
            local cmd = tokens[1]
            table.remove(tokens, 1)
            if cmd ~= ";;" then
                _runCommand(cmd, unpack(tokens))
            end
            tokens = {}
        end
        table.remove(_instances, self)
    end
    table.insert(_instances, Parser)
    Parser.inst(Parser.file)
end

--------------------------------------------------

function _runCommand(cmd, ...)
    local params = pack(...)
    command = _findCommandByName(cmd)
    for p = 1, #params, 1 do
        if string.match(params[p], "$") then
            for n = 1, #Parser.stack, 1 do
                if "$" .. Parser.stack[n].name == params[p] then
                    if Parser.stack[n].type == "str" then
                        params[p] = unpack(Parser.stack[n].values)
                    elseif Parser.stack[n].type == "num" then
                        params[p] = Parser.stack[n].values[1]
                    elseif Parser.stack[n].type == "color" then
                        --print(pack(Parser.stack[n].values))
                        table.remove(params, p)
                        for v = 1, #Parser.stack[n].values, 1 do
                            table.insert(params, Parser.stack[n].values[v])
                        end
                    else
                        print("Invalid type")
                    end
                    print("value : " .. debug.getTableContent(Parser.stack[n].values))
                else
                    --print("not found name")
                end
            end
        else
            print("not found $")
        end
    end
    --print(debug.getTableContent(params))
    ok, err = pcall(command, unpack(params))
    params = {}
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

function startswith(str, start)
    return string.sub(str, 1, #start) == start
end

function contains(str, sub)
    return string.find(str, sub, 1, true) ~= nil
end

return parser