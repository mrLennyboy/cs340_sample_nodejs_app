function updateDog(id) {
    $.ajax({
        url: '/dogs/' + id,
        type: 'PUT',
        data: $('#update-dog').serialize(),
        success: function (result) {
            window.location.replace("./");
        }
    })
};