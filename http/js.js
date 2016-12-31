
$(function(){

    var light = 1000;
    var speed = 10;
    var step = 2;

    var $color = $("#color");
    var $direction = $("#direction");
    var $light = $("#light");
    var $speed = $("#speed");
    var $step = $("#step");
    var $save_list = $("#save_list");
    var $save_button_block = $("#save_button_block");

    var save_list_tpl = $save_list.html();
    $save_list.html('');
    var last_request;

    var tik = 1;

    $light.slider({
        range: "max",
        min: 20,
        max: 3000,
        value: 1500,
        slide: function( event, ui ) {
            light = ui.value;
        }
    });

    $speed.slider({
        range: "max",
        min: 20,
        max: 1000,
        value: 20,
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

    $save_button_block.on('click', function(){
        if(last_request){
            var date = new Date();
            var q_name = date.getMonth() +"/"+date.getDate()+"/"+date.getHours()+'/'+date.getMinutes()+'/'+date.getSeconds();
            q_name = prompt("Как назвать?", q_name);
            var tmp_tpl = $(save_list_tpl);
            tmp_tpl.find(".name").html(q_name);
            tmp_tpl.find(".name").attr("req", last_request);
            $save_list.append("<tr>"+tmp_tpl.html()+"</tr>");
            parseSaveToCookie();
        }
    });

    $("#full-color").on('click', function(){
        var url = $(this).attr("data-action");
        sendRequest(url);
    });

    $(".action").on('click', function () {
        var url = $(this).attr("data-action");
        if(url){
            sendRequest(url);
        }else{
            alert('Проверь урл!');
        }
    });

    loadSaveTable();

    function loadSaveTable(){
        var main_c = getCookie("main");
        cl(main_c);
        deleteCookie("main");
        if(main_c){
            main_c = JSON.parse(main_c);
            cl(main_c)
            var tmp_cookie;
            $.each(main_c, function (i, item) {
                tmp_cookie = getCookie(item);
                cl(tmp_cookie)
                /*tmp_cookie = JSON.parse(tmp_cookie);
               cl(tmp_cookie)*/
               cl(item)
                /*deleteCookie(item);*/
            })
        }
    }


    function parseSaveToCookie(){
        var main_c = getCookie("main");

        deleteCookie("main");

        var i = 1;
        var c_name = '';
        main_c = [];
        $.each($save_list.find('.name'), function(){
            c_name = "wsc"+i;
            setCookie(c_name, JSON.stringify({name:$(this).text(), req:$(this).attr("req")}));
            main_c.push(c_name);
            i++;
        });
        setCookie("main", JSON.stringify(main_c));
        //last_request
    }

    checkGoodRequest();

    function sendRequest(url){
        if(tik != 1)
            return false;
        tik = 0;

        var color = hexToRgb($color.val());
        var request = {r:color.r, g:color.g, b:color.b, direction:$direction.val(), light:light, speed:speed, step:step};
        $.get(url+'.lua', request, function (data) {
            if(data == ":-)"){
                last_request = {
                    url:url,
                    request:request
                };
                last_request = JSON.stringify(last_request);
            }else{
                last_request = '';
            }
            checkGoodRequest();
        });
    }

    function checkGoodRequest(){
        tik = 1;
        if(last_request){
            $save_button_block.fadeIn();
        }else{
            $save_button_block.fadeOut();
        }
    }
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

if (!navigator.cookieEnabled) {
    alert( 'Включите cookie для комфортной работы с этим сайтом' );
}

function getCookie(name) {
    var matches = document.cookie.match(new RegExp(
        "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options) {
    options = options || {};

    var expires = options.expires;

    if (typeof expires == "number" && expires) {
        var d = new Date();
        d.setTime(d.getTime() + expires * 1000);
        expires = options.expires = d;
    }
    if (expires && expires.toUTCString) {
        options.expires = expires.toUTCString();
    }

    value = encodeURIComponent(value);

    var updatedCookie = name + "=" + value;

    for (var propName in options) {
        updatedCookie += "; " + propName;
        var propValue = options[propName];
        if (propValue !== true) {
            updatedCookie += "=" + propValue;
        }
    }

    document.cookie = updatedCookie;
}

function deleteCookie(name) {
    setCookie(name, "", {
        expires: -1
    })
}

window.onbeforeunload = function() {
    return "Не обновляй без нужды. :)";
};