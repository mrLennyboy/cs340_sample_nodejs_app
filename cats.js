module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getCats(res, mysql, context, complete) {
        mysql.pool.query("SELECT pet_Id, name, birthday, sex, breed, weight, availability, adoption_fee FROM cats", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
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

