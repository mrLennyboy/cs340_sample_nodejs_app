/*******************************************************************************
** Author: Alessio Peterson and Jasper Wong
** Program Name: CS340 Final Project
** Course: CS 340-400
** Comment: This code was modified and provided by J.Wolford from instruction
**          materials.
*******************************************************************************/

//Include express to use for webapp
var express = require('express');
var app = express();

//SQL connection to database
var mysql = require('./dbcon.js');
app.set('mysql', mysql);

//Include bodyParser and set express to use it
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));


//Express handlebars as default engine for handing handlebar files
var handlebars = require('express-handlebars').create({
    defaultLayout: 'main',
});
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');

//Assume folder static documents in public
app.use('/static', express.static('public'));

//Set app listening port
app.set('port', process.argv[2]);

app.use('/donors', require('./donors.js'));
app.use('/clients', require('./clients.js'));
app.use('/dog_breed', require('./dog_breed.js'));
app.use('/dogs', require('./dogs.js'));
app.use('/cats', require('./cats.js'));
app.use('/', express.static('public'));

//Error messages
app.use(function (req, res) {
    res.status(404);
    res.render('404');
});

app.use(function (err, req, res, next) {
    console.error(err.stack);
    res.status(500);
    res.render('500');
});

//Message when program called
app.listen(app.get('port'), function () {
    console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
