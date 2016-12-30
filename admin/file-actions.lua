return function (connection, req, args)

    local function split(str, pat)
        local t = {}  -- NOTE: use {n = 0} in Lua-5.0
        local fpat = "(.-)" .. pat
        local last_end = 1
        local s, e, cap = str:find(fpat, 1)
        while s do
            if s ~= 1 or cap ~= "" then
                table.insert(t,cap)
            end
            last_end = e+1
            s, e, cap = str:find(fpat, last_end)
        end
        if last_end <= #str then
            cap = str:sub(last_end)
            table.insert(t, cap)
        end
        return t
    end


if args.actions then

    if args.actions=="delete" then
        if args.file then
            file.remove(args.file);
            connection:send("1");
        else
            connection:send("");
        end
    end


    if args.actions=="edit" then
        if args.file then
            local content = "";
            file.open(args.file, "r")
            local content = "";
            while content ~= nil do
                content = file.readline();
                if content ~= nil then
                    connection:send(content);
                end;
            end
            file.close()
        else
            connection:send("");
        end
    end
else
    connection:send("");
end


if req.method == "POST" then
    local rd = req.getRequestData()
    local file_name = '';
    local file_content = '';
    local file_type = '';

    for name, value in pairs(rd) do

        if(name == "name") then
            file_name = tostring(value);
        end

        if(name == "content") then
            file_content = tostring(value);
        end

        if(name == "type") then
            file_type = tostring(value);
        end

    end

    if file_name ~= '' then
        if file_content ~= '' then
            if file_type ~= '' then

                file.open(file_type.."/"..file_name, "w+");
                file.write("");
                file.close();
                collectgarbage();

                file_content = split(file_content,"\n");

                for k,v in pairs(file_content) do
                    file.open(file_type.."/"..file_name, "a+");
                    file.writeline(v);
                    file.flush();
                    file.close();
                    collectgarbage();
                end
               --[[ if file_type == "http" then
                    connection:send("http");
                    print("http");
                else
                    connection:send("admin");
                    print("admin");
                end]]
                    --[[file.close();]]
                connection:send("ok");

            else
                connection:send("Нет типа");
            end;
        else
            connection:send("Пустой контент");
        end
    else
        connection:send("Пустое имя файла");
    end

end


collectgarbage();
end
