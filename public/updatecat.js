function updateCat(id){
    $.ajax({
        url: '/cats/' + id,
        type: 'PUT',
        data: $('#update-cat').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};
