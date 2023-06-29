return {
    name = "defvar",
    run = function(vartype, name, ...)
        local values = pack(...)
        --print(debug.getTableContent(values))
        if vartype == "color" then
            for v = #values, 5, -1 do
                table.remove(values, v)
            end
        elseif vartype == "num" then
            --assert(type(tonumber(values[1])) == "number", "Invalid type, expected 'Number' got " .. type(values[1]))
            if type(tonumber(values[1])) ~= "number" then
                error("Invalid type, expected 'Number' got " .. type(values[1]))
            end
            for v = #values, 2, -1 do
                table.remove(values, v)
            end
        elseif vartype == "str" then
            local strvalue = table.concat(values, " ")
            values = {}
            table.insert(values, strvalue)
        end

        local Var = {}
        Var.type = vartype
        Var.name = name
        Var.values = values
        table.insert(Parser.stack, Var)
        values = {}
        --print("Added to instance :: " .. Parser.file)
        --print(debug.getTableContent(Parser.stack))
    end
}