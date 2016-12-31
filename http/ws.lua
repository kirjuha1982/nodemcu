return function (connection, req, args)
    dofile("http/functions.lc")
--[[
    ws2812.init()
    ws2812.write(string.char(255, 0, 0, 255, 0, 0)) -- turn the two first RGB leds to green
]]

    local i = 0;
    local r = 1;
    local g = 0;
    local b = 0;


ws2812.init();

    local buffer = ws2812.newBuffer(_G.leds, 3);
    buffer:fill(0, 0, 0, 0);



    tmr.alarm(1, 100, 1, function()

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
            r = r+4;
        end


        if(g > 0) then
            g = g+4;
        end


        if(b > 0) then
            b = b+4;
        end

        i = i+1;
        buffer:fade(1);
        buffer:set(i, b, r, g);
        buffer = wsFunction.powBuffer(buffer, args);

        ws2812.write(buffer);

        if(i == _G.leds) then
            i = 0;
        end

    end )

    --[[   ws2812.init(ws2812.MODE_DUAL);
       local i = 0;

       tmr.alarm(0, 1000, 1, function()

           if (i == 0) then
               ws2812.write(
                   string.char(255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0),
                   string.char(0, 255, 0, 0, 255, 0, 255, 0, 0, 255, 0, 0)
               )
               i = 1;
           else
               ws2812.write(
                   string.char(0, 255, 0, 0, 255, 0, 255, 0, 0, 255, 0, 0),
                   string.char(255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0)
               )
               i = 0;
           end



       end )]]


    connection:send(":-)");

    --[[local pin = 5
    local status, temp, humi, temp_dec, humi_dec = dht.read(pin)
    if status == dht.OK then
        -- Integer firmware using this example
        connection:send(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d\r\n",
            math.floor(temp),
            temp_dec,
            math.floor(humi),
            humi_dec
        ))

        -- Float firmware using this example
        connection:send("<h2>DHT Temperature:"..temp..";".."Humidity:"..humi.."</h2>");


    elseif status == dht.ERROR_CHECKSUM then
        connection:send( "DHT Checksum error." )
    elseif status == dht.ERROR_TIMEOUT then
        connection:send( "DHT timed out." )
    end]]

end
