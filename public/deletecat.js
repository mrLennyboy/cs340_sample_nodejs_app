function deleteCat(id) {
    $.ajax({
        url: '/cats/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};