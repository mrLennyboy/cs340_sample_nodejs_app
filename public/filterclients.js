function filterClients() {
    //get the id of the selected homeworld from the filter dropdown
    var client_id = document.getElementById('clients_filter').value
    //construct the URL and redirect to it
    window.location = '/clients/filter/' + parseInt(client_id)
}