function getEdgeInfoById(id_list1,id_list2,data_table) {
    $.ajax({
        url: 'http://127.0.0.1:8000/display/get_edge_info_for_table/',
        data: {
            'id_list1': id_list1,
            'id_list2': id_list2,
        },
        dataType: 'json',
        success: function (data) {
            data_table.data = data;
            data_table.change.emit();
        },
        error: function (error) {
            console.error(error);
        }
    });
}


function getUserInfoById(id_list,data_table) {
    $.ajax({
        url: 'http://127.0.0.1:8000/display/get_user_info_for_table/',
        data: {
            'id_list': id_list
        },
        dataType: 'json',
        success: function (data) {
            data_table.data = data;
            data_table.change.emit();
        },
        error: function (error) {
            console.error(error);
        }
    });
}