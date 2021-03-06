return function (connection, req, args)
    dofile("http/functions.lc")


    local i = 0;
    local r = 1;
    local g = 0;
    local b = 0;


    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);
    --[[buffer:fill(0, 0, 0, 0);]]

    local speed = args.speed;
    local direction = args.direction;
    local step = args.step;
    if speed == nil then speed = 20 end;
    if step == nil then step = 1 end;
    if tonumber(speed)<20 then speed = 20 end;
    speed = tonumber(speed);
    if direction == "1" then
        i = _G.leds;
        tmr.alarm(1, speed, 1, function()

            if(r > 255) then
                r = 0;
                g = 1;
            end

            if(g > 255) then
                g = 0;
                b = 1;
            end


            if(b > 255) then
                b = 0;
                r = 1;
            end

            if(r > 0) then
                r = r+step;
            end


            if(g > 0) then
                g = g+step;
            end


            if(b > 0) then
                b = b+step;
            end

            i = i-1;
            if(i == 0) then
                i = _G.leds;
            end
            buffer:set(i, b, r, g);

            i = i-1;
            if(i == 0) then
                i = _G.leds;
            end
            buffer:set(i, b, r, g);
            buffer = wsFunction.powBuffer(buffer, args);

            ws2812.write(buffer);
            collectgarbage()
        end )


    else

        tmr.alarm(1, speed, 1, function()

            if(r > 255) then
                r = 0;
                g = 1;
            end

            if(g > 255) then
                g = 0;
                b = 1;
            end


            if(b > 255) then
                b = 0;
                r = 1;
            end

            if(r > 0) then
                r = r+step;
            end


            if(g > 0) then
                g = g+step;
            end


            if(b > 0) then
                b = b+step;
            end


            if(i == _G.leds) then
                i = 0;
            end
            i = i+1;
            buffer:set(i, b, r, g);

            if(i == _G.leds) then
                i = 0;
            end
            i = i+1;
            buffer:set(i, b, r, g);
            buffer = wsFunction.powBuffer(buffer, args);

            ws2812.write(buffer);
            collectgarbage()
        end )

    end;

    connection:send(":-)");
    collectgarbage()
end
