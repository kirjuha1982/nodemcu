return function (connection, req, args)
    dofile("http/functions.lc");

    ws2812.init();


    local r = 0;
    local g = 255;
    local b = 0;
    local color = {};

    local speed = args.speed;
    local step = args.step;

    if speed == nil then speed = 10 end;
    if step == nil then step = 1 end;
    speed = tonumber(speed);
    if speed<20 then speed = 20 end;

    ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);
    buffer:fill(255, 0, 0);
    ws2812.write(buffer);


    local z = 1;


    local up = 1;
    local z;
    tmr.alarm(1, speed, 1, function()
        for i=1, _G.leds do

            if i == 1 then
                z = buffer:get(_G.leds);
                if tonumber(z) == 255 then up = 0 end;
                if tonumber(z) == 0 then up = 1 end;

                if up == 1 then
                    buffer:set(i,(buffer:get(_G.leds)+1));
                end;

                if up == 0 then
                    buffer:set(i,(buffer:get(_G.leds)-1));
                end;
            else
                z = buffer:get(i-1);
                if tonumber(z) == 255 then up = 0 end;
                if tonumber(z) == 0 then up = 1 end;

                if up == 1 then
                    buffer:set(i,(buffer:get(i-1)+1));
                end;

                if up == 0 then
                    buffer:set(i,(buffer:get(i-1)-1));
                end;
            end;



        end
        ws2812.write(buffer);
    end)

    connection:send(":-)");
    collectgarbage();
end
