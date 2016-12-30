$(function () {

    var url = {};
    url.file_list = "file-list.lua";
    url.file_actions = "file-actions.lua";


    var $main = $("#main");
    var $edit_area = $("#edit-area");
    var $new_file = $("#new-file");



    var $file_name = $("#file_name");
    var $file_type = $("#file_type");
    var $file_content = $("#file_content");
    var $save_document = $("#save_document");

    var editor = ace.edit("file_content");

    setTimeout(function () {
        $edit_area.hide();
    }, 1000);


    function getFileContent(file){
        $.get(url.file_actions, {file:file, actions:"edit"}, function(data){
            $edit_area.fadeIn();
            $new_file.fadeIn();

            if((file.indexOf("http/")+1)>0){
                $file_name.val(file.replace('http/', ''));
                $file_type.val('http');
            }else{
                $file_name.val(file.replace('admin/', ''));
                $file_type.val('admin');
            }
            editor.setValue(data);
        })
    }

    $main.on('click', ".file_edit", function(){
        var file = $(this).attr("data-name");
        if(file){
            getFileContent(file)
        }
        return false;
    });

    $save_document.on('click', function(){
        var name = $file_name.val();
        var type = $file_type.val();
        var content = editor.getValue();
        if(name && content && type){
            $.post(url.file_actions, {actions:"save", name:name, content:content, type:type}, function(data){
                getHttp();
                setTimeout(function () {
                    getAdmin();
                }, 500);
                $edit_area.fadeOut();
                $new_file.fadeIn();
            })
        }

    });


    $new_file.on('click', function () {
        $(this).fadeOut();
        $file_name.val('');
        editor.setValue("");
        $edit_area.fadeIn();
    });


    function getHttp(){
        $("#list_http").parents(".col_block").find(".progress").fadeIn();
       $.get(url.file_list, function(data){
           loadTable(JSON.parse(data), "#list_http");
       });
   }

   function getAdmin(){
       $("#list_admin").parents(".col_block").find(".progress").fadeIn();
       $.get(url.file_list, {type:2}, function(data){
           loadTable(JSON.parse(data), "#list_admin");
       });
   }
    getHttp();
    setTimeout(function () {
        getAdmin();
    }, 500);
    
    
    function loadTable(obj, div_id){
        var block = $(div_id);
        var i = 1;
        block.html('');
        $.each(obj, function (index, item) {
            block.append('<tr><th scope="row">'+i+'</th><td>'+item['name']+'</td> <td>'+formatSizeUnits(item['size'])+'</td><td>' +
                '<a href="#" class="file_edit" data-name="'+item['name']+'"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a> &nbsp;  &nbsp; ' +
                '<a href="#" class="file_delete" data-name="'+item['name']+'"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>' +
                '</td></tr>');
            i++;
        });
        $(div_id).parents(".col_block").find(".progress").fadeOut();
    }


    $main.on('click', ".file_delete", function(){

        var block_id = $(this).parents("tbody").attr("id");
        var file_name = $(this).attr("data-name");

        var del = confirm("Удалить "+file_name+"?");
        if(file_name && del){
            $.get(url.file_actions, {file:file_name, actions:"delete"}, function(data){
                if(data == 1){
                    if(block_id == "list_http"){
                        getHttp();
                    }else{
                        getAdmin();
                    }
                }else{
                    cl(data)
                }

            })
        }
        return false;
    });

});

function cl(str){console.log(str);}
function formatSizeUnits(bytes){
    if      (bytes>=1000000000) {bytes=(bytes/1000000000).toFixed(2)+' GB';}
    else if (bytes>=1000000)    {bytes=(bytes/1000000).toFixed(2)+' MB';}
    else if (bytes>=1000)       {bytes=(bytes/1000).toFixed(2)+' KB';}
    else if (bytes>1)           {bytes=bytes+' bytes';}
    else if (bytes==1)          {bytes=bytes+' byte';}
    else                        {bytes='0 byte';}
    return bytes;
}