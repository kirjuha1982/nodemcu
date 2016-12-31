return function (connection, req, args)
    dofile("http/functions.lc");

    tmr.alarm(1, 1, 0, function()  end )
    ws2812.init();
    local buffer = ws2812.newBuffer(_G.leds, 3);

    --[[
    -- 6 циклов
    -- диоды на циклы
    -- ]]

    local delimiter = (255*6)/_G.leds;
    local r = 0;
    local g = 255;
    local b = 0;
    local color = {};

    for i=1, _G.leds do
        color = wsFunction.nextColor(delimiter, r, g, b);
        r = color.r;
        g = color.g;
        b = color.b;
        buffer:set(i,g,r,b);
    end
    buffer = wsFunction.powBuffer(buffer, args);
    ws2812.write(buffer);

    connection:send(":-)");
    collectgarbage();
end
