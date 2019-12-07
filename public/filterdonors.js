function filterDonors() {
    //get the id of the selected homeworld from the filter dropdown
    var homeworld_id = document.getElementById('donors_filter').value
    //construct the URL and redirect to it
    window.location = '/donors/filter/' + parseInt(homeworld_id)
}