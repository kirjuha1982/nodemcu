return function (connection, req, args)
    dofile("http/functions.lc")
    tmr.alarm(1, 1, 0, function()  end )
    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);

    for i = 1, _G.leds do
        if i < _G.leds/3 then
            buffer:set(i,0,225,0);
        elseif i < _G.leds/3*2 then
            buffer:set(i,0,0,225);
        else
            buffer:set(i,127,127,127);
        end

    end

    local blink = 0;


    for name, value in pairs(args) do
        if name == "blink" then
            blink = tonumber(value);
        end

    end


    buffer = wsFunction.powBuffer(buffer, args);



    ws2812.write(buffer);

    connection:send("<h2>Ok</h2>");


    collectgarbage();
end
