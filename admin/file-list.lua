return function (connection, req, args)




--[[
Задаём типы файлов
1 - папка http
2 - папка admin
3 - системные файлы
-- ]]

local file_type = "1";
local json = "";
if args.type then
    file_type =  args.type;
end
    local l = file.list();
    for k,v in pairs(l) do
        if (file_type=="2") then
            if string.find(k, "admin/") then
                json = json..'{"name":"'..k..'","size":"'..v..'"},';
            end
        else
            if string.find(k, "http/") then
                json = json..'{"name":"'..k..'","size":"'..v..'"},';
            end
        end
    end
    connection:send("["..string.sub (json, 1, (string.len (json) - 1)).."]");
    collectgarbage()
end
