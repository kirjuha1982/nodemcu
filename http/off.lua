return function (connection, req, args)

    local i = 0;
    local r = 1;
    local g = 0;
    local b = 0;


    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);
    buffer:fill(0, 0, 0, 0);
    tmr.alarm(1, 1, 0, function()
        buffer:set(1,0,0,0);
        ws2812.write(buffer);
    end )


    connection:send(":-)");

    collectgarbage()
end
