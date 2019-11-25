function deleteCat(pet_Id) {
    $.ajax({
        url: '/cats/' + pet_Id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};