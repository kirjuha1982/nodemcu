
$(function(){

    var light = 1000;
    var speed = 10;
    var step = 2;

    var $color = $("#color");
    var $blink = $("#blink");
    var $light = $("#light");
    var $speed = $("#speed");
    var $step = $("#step");

    $light.slider({
        range: "max",
        min: 20,
        max: 2000,
        value: 1000,
        slide: function( event, ui ) {
            light = ui.value;
        }
    });

    $speed.slider({
        range: "max",
        min: 5,
        max: 1000,
        value: 10,
        slide: function( event, ui ) {
            speed = ui.value;
        }
    });

    $step.slider({
        range: "max",
        min: 1,
        max: 30,
        value: 2,
        slide: function( event, ui ) {
            step = ui.value;
        }
    });


    $color.on('change', function(){
       // cl(hexToRgb($(this).val()));


    });


    $("#full-color").on('click', function(){
        var color = hexToRgb($color.val());
        var url = $(this).attr("data-action");
        $.get(url+'.lua', {r:color.r, g:color.g, b:color.b, blink:$blink.val(), light:light, speed:speed, step:step}, function (data) {
            cl(data);
        });
    });



    $(".action").on('click', function () {
        var url = $(this).attr("data-action");
        var color = hexToRgb($color.val());
        if(url){
            $.get(url+'.lua', {r:color.r, g:color.g, b:color.b, blink:$blink.val(), light:light, speed:speed, step:step}, function (data) {
                cl(data);
            });
        }else{
            alert('Проверь урл!');
        }
    });
});


function hexToRgb(hex) {
    var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function(m, r, g, b) {
        return r + r + g + g + b + b;
    });

    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
}

function cl(str) {
    console.log(str)
}