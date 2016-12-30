return function (connection, req, args)
    dofile("http/functions.lc")
    tmr.alarm(1, 1, 0, function()  end )

    ws2812.init();

    local r = 0;
    local g = 0;
    local b = 0;
    local blink = 0;

    for name, value in pairs(args) do

        if name == "r" then
            r = tostring(value)+0;
        end

        if name == "g" then
            g = tostring(value)+0;
        end

        if name == "b" then
            b = tostring(value)+0;
        end

        if name == "blink" then
            blink = tostring(value)+0;
        end
    end


    local buffer = ws2812.newBuffer(_G.leds, 3);

    for i = 1, _G.leds do
        buffer:set(i,g,r,b);
    end
    buffer = wsFunction.powBuffer(buffer, args);
    ws2812.write(buffer);

    connection:send("<h2>Ok</h2>");

    if blink == 1 then
        connection:send("<h2>Blink</h2>");
    end

    collectgarbage();
end
