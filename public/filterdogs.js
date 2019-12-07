function filterDogs() {
    //get the id of the selected homeworld from the filter dropdown
    var dog_id = document.getElementById('dogs_filter').value
    //construct the URL and redirect to it
    window.location = '/dogs/filter/' + parseInt(dog_id)
}