function updateDogBreeds(id) {
    $.ajax({
        url: '/dog_breeds/' + id,
        type: 'PUT',
        data: $('#update-dog_breeds').serialize(),
        success: function (result) {
            window.location.replace("./");
        }
    })
};