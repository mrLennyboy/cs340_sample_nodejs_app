module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getCats(res, mysql, context, complete) {
        mysql.pool.query("SELECT pet_Id, name, birthday, sex, breed, weight, availability, adoption_fee FROM cats", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.cats = results;  //context.cats, "cats" is what to reference for #each
            complete();
        });
    }

    function getCatBreeds(res, mysql, context, complete) {
        mysql.pool.query("SELECT cat_breed_Id, cat_breed_name FROM cat_breed", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.cat_breed = results;
            complete();
        });
    }

    
    function getACat(res, mysql, context, pet_Id, complete){
        var sql = "SELECT pet_Id, birthday, sex, breed, weight, availability, adoption_fee FROM cats";
        var inserts = [pet_Id];
        mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.cats = results[0];
            complete();
        });
    }

    /* Display one cat for the specific purpose of updating cat */

    router.get('/:pet_Id', function(req, res){
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedplanet.js", "updateperson.js"];
        var mysql = req.app.get('mysql');
        getACat(res, mysql, context, req.params.pet_Id, complete); //seperate from getCats
        getCatBreeds(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('update-cat', context);
            }

        }
    });

     /*Display all cats. Requires web based javascript to delete users with AJAX*/

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletecat.js", "filtercats.js", "searchcats.js"];
        var mysql = req.app.get('mysql');
        getCats(res, mysql, context, complete);
        getCatBreeds(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('cats', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO cats (name, birthday, sex, breed, weight, availability, adoption_fee) VALUES (?,?,?,?, ?, ? ,?)";
        var inserts = [req.body.name, req.body.birthday, req.body.sex, req.body.breed, req.body.weight, req.body.availability, req.body.adoption_fee]
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/cats');
            }
        });
    });

    return router;
}();

