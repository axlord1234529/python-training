function getUserNameById(id_list1,id_list2,data_table,cd) {
    $.ajax({
        url: 'http://127.0.0.1:8000/display/get_users_for_table/',
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