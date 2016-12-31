return function (connection, req, args)
    dofile("http/functions.lc")
    tmr.alarm(1, 1, 0, function()  end )

    ws2812.init();

    local r = tonumber(args.r);
    local g = tonumber(args.g);
    local b = tonumber(args.b);

    local buffer = ws2812.newBuffer(_G.leds, 3);

    for i = 1, _G.leds do
        buffer:set(i,g,r,b);
    end
    buffer = wsFunction.powBuffer(buffer, args);
    ws2812.write(buffer);
    connection:send(":-)");
    collectgarbage();
end
