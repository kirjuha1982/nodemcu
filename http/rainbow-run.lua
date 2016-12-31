return function (connection, req, args)
    dofile("http/functions.lc");

    ws2812.init();


    local r = 0;
    local g = 255;
    local b = 0;
    local color = {};

    local speed = args.speed;
    local step = args.step;
    local direction = args.direction;


    if speed == nil then speed = 20 end;
    if step == nil then step = 1 end;
    speed = tonumber(speed);
    if speed<20 then speed = 20 end;

    local buffer = ws2812.newBuffer(_G.leds, 3);
    local i = 1;
    buffer:fill(g,r,b);

    if direction == "1" then
        tmr.alarm(1, speed, 1, function()
            color = wsFunction.nextColor(step, r, g, b);
            r = color.r;
            g = color.g;
            b = color.b;
            buffer:set(i,g,r,b);
            buffer = wsFunction.powBuffer(buffer, args);
            ws2812.write(buffer);
            i = i-1;
            if i < 1 then i = _G.leds end
            collectgarbage();
        end)
    else
        tmr.alarm(1, speed, 1, function()
            color = wsFunction.nextColor(step, r, g, b);
            r = color.r;
            g = color.g;
            b = color.b;
            buffer:set(i,g,r,b);
            buffer = wsFunction.powBuffer(buffer, args);
            ws2812.write(buffer);
            i = i+1;
            if i > _G.leds then i = 1 end
            collectgarbage();
        end)
    end;

    connection:send(":-)");
    collectgarbage();
end
