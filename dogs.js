module.exports = function () {
    var express = require('express');
    var router = express.Router();

    // get cats
    function getDogs(res, mysql, context, complete) {
        mysql.pool.query("SELECT pet_Id, name, birthday, sex, breed, weight, availability, adoption_fee FROM dogs", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.dogs = results;
            complete();
        });
    }

    // get cat breeds
    function getDogBreeds(res, mysql, context, complete) {
        mysql.pool.query("SELECT dog_breed_Id, dog_breed_name FROM dog_breed", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.dog_breed = results;
            complete();
        });
    }

    function getDog(res, mysql, context, id, complete) {
        var sql = "SELECT pet_Id as id, name, birthday, sex, breed, weight, availability, adoption_fee FROM dogs WHERE pet_Id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.dog = results[0];
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletedog.js", "filterdogs.js", "searchdogs.js"];
        var mysql = req.app.get('mysql');
        getDogs(res, mysql, context, complete);
        getDogBreeds(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('dogs', context);
            }

        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedbreed.js", "updatedog.js"];
        var mysql = req.app.get('mysql');
        getDog(res, mysql, context, req.params.id, complete);
        getDogBreeds(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('update-dog', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.cats)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO dogs (name, birthday, sex, breed, weight, availability, adoption_fee) VALUES (?,?,?,?, ?, ? ,?)";
        var inserts = [req.body.name, req.body.birthday, req.body.sex, req.body.breed, req.body.weight, req.body.availability, req.body.adoption_fee]
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/dogs');
            }
        });
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE dogs SET name=?, birthday=?, sex=?, breed=?, weight=?, availability=?, adoption_fee=? WHERE pet_Id=?";
        var inserts = [req.body.name, req.body.birthday, req.body.sex, req.body.breed, req.body.weight, req.body.availability, req.body.adoption_fee, req.params.id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.status(200);
                res.end();
            }
        });
    });

    router.delete('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM dogs WHERE pet_Id = ?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(error)
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            } else {
                res.status(202).end();
            }
        })
    })

    return router;
}();