

wsFunction = {}

--[[
-- Умёньшение яркости
-- Используем     buffer = wsFunction.powBuffer(buffer, args);
-- ]]
function wsFunction.powBuffer(buffer, args)
    if tonumber(args.light) > 0 then
        args.light = tonumber(args.light);
        local led_sum = args.light * 255 / _G.led_current_ma;
        local p = buffer:power()
        if p > led_sum then
            buffer:mix(256 * led_sum / p, buffer) -- power is now limited
        end
    end
    return buffer;
end


--[[
-- Получение следующего цвета для радуги
-- ]]

function wsFunction.nextColor(delimiter, r, g, b)
    if (r+delimiter) > 255 then r = 255 end;
    if (g+delimiter) > 255 then g = 255 end;
    if (b+delimiter) > 255 then b = 255 end;

    if r ~= 255 then
        if b ~= 255 then
            g = 255
        end
    end

    if g == 255 then
        if b == 0 then
            r = r + delimiter;
        else
            b = b - delimiter;
        end
    end

    if r > 255 then r = 255 end;
    if b < 0 then b = 0 end;

    if r == 255 then
        if g == 0 then
            b = b + delimiter;
        else
            g = g - delimiter;
        end
    end

    if g < 0 then g = 0 end;
    if b > 255 then b = 255 end;

    if b == 255 then
        if r == 0 then
            g = g + delimiter;
        else
            r = r - delimiter;
        end
    end

    if r > 255 then r = 255 end;
    if g > 255 then g = 255 end;
    if b > 255 then b = 255 end;

    if r < 0 then r = 0 end;
    if g < 0 then g = 0 end;
    if b < 0 then b = 0 end;

    local color = {};
    color.r = r;
    color.g = g;
    color.b = b;

    return color;
end

return wsFunction;


