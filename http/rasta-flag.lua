return function (connection, req, args)
    dofile("http/functions.lc")
    tmr.alarm(1, 1, 0, function()  end )
    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);
    buffer:fill(0, 0, 0, 0);

    local r = 0;
    local g = 0;
    local b = 0;

    for i = 1, _G.leds do
        if i < _G.leds/3 then
            r = 225;
            g = 1;
            b = 1;
            buffer:set(i,g,r,b);
        elseif i < _G.leds/3*2 then
            r = 120;
            g = 120;
            b = 0;
            buffer:set(i,g,r,b);
        else
            r = 1;
            g = 225;
            b = 1;
            buffer:set(i,g,r,b);
        end

    end

    buffer = wsFunction.powBuffer(buffer, args);
    ws2812.write(buffer);
    connection:send(":-)");


    collectgarbage();
end
