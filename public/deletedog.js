function deleteDog(id) {
    $.ajax({
        url: '/dogs/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};