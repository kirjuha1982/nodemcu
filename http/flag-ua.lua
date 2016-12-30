return function (connection, req, args)
    dofile("http/functions.lc")
    tmr.alarm(1, 1, 0, function()  end )
    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);

    for i = 1, _G.leds do
        if i < _G.leds/2 then
            buffer:set(i,120, 210, 1);
        else
            buffer:set(i,5, 5, 210);
        end
    end
    buffer = wsFunction.powBuffer(buffer, args);
    ws2812.write(buffer);
    connection:send("<h2>Ok</h2>");

    collectgarbage();
end
--[[b, r, g]]