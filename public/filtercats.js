function filterCats() {
    //get the id of the selected homeworld from the filter dropdown
    var cat_Id = document.getElementById('cats_filter').value
    //construct the URL and redirect to it
    window.location = '/cats/filter/' + parseInt(cat_Id)
}