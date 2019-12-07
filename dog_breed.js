module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getDogBreeds(res, mysql, context, complete) {
        mysql.pool.query("SELECT dog_breed_Id, dog_breed_name FROM dog_breed", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.dog_breeds = results;
            complete();
        });
    }

    function getDogBreed(res, mysql, context, id, complete) {
        var sql = "SELECT dog_breed_Id as id, dog_breed_name, FROM dog_breed WHERE dog_breed_Id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.dog_breed = results[0];
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletedog.js"];
        var mysql = req.app.get('mysql');
        getDogBreeds(res, mysql, context, complete);
        getDogBreed(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('dog_breed', context);
            }

        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedbreed.js", "updatedogbreed.js"];
        var mysql = req.app.get('mysql');
        getDogBreeds(res, mysql, context, req.params.id, complete);
        getDogBreed(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('update-dog_breed', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.cats)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO dog_breed (dog_breed_name) VALUES (?)";
        var inserts = [req.body.dog_breed_name]
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/dog_breed');
            }
        });
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE dog_breed SET dog_breed_name=? WHERE pet_Id=?";
        var inserts = [req.body.dog_breed_name, req.params.id];
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
        var sql = "DELETE FROM dog_breed WHERE dog_breed_Id = ?";
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