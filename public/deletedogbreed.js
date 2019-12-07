function deleteDogBreed(id) {
    $.ajax({
        url: '/dog_breeds/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};