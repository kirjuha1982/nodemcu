return function (connection, req, args)
    dofile("http/functions.lc")

    local i = 0;
    local r = 1;
    local g = 0;
    local b = 0;
    local color = {};
    local speed = args.speed;
    local step = args.step;

    if speed == nil then speed = 20 end;
    if step == nil then step = 1 end;
    local direction = args.direction;
    if tonumber(speed)<20 then speed = 20 end;
    speed = tonumber(speed);
    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);


    if direction == "1" then
        i = _G.leds;
        tmr.alarm(1, speed, 1, function()

            color = wsFunction.nextColor(step, r, g, b);
            r = color.r;
            g = color.g;
            b = color.b;

            i = i-1;
            if i == 0 then
                i = _G.leds;
            end

            buffer:fade(2);
            buffer:set(i, b, r, g);

            buffer = wsFunction.powBuffer(buffer, args);
            ws2812.write(buffer);
            collectgarbage();
        end )
    else

        tmr.alarm(1, speed, 1, function()
            color = wsFunction.nextColor(step, r, g, b);
            r = color.r;
            g = color.g;
            b = color.b;

            i = i+1;
            buffer:fade(2);
            buffer:set(i, b, r, g);

            buffer = wsFunction.powBuffer(buffer, args);
            ws2812.write(buffer);

            if i == _G.leds then
                i = 0;
            end
            collectgarbage();
        end )

    end




    connection:send(":-)");

    collectgarbage();
end
