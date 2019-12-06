module.exports = function () {
    var express = require('express');
    var router = express.Router();

    // get cats
    function getCats(res, mysql, context, complete) {
        mysql.pool.query("SELECT pet_Id, name, birthday, sex, breed, weight, availability, adoption_fee FROM cats", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.cats = results;
            complete();
        });
    }

    // get cat breeds
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

    function getCat(res, mysql, context, id, complete) {
        var sql = "SELECT pet_Id as id, name, birthday, sex, breed, weight, availability, adoption_fee FROM cats WHERE pet_Id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.cat = results[0];
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

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedbreed.js", "updatecat.js"];
        var mysql = req.app.get('mysql');
        getCat(res, mysql, context, req.params.id, complete);
        getCatBreeds(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('update-cat', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.cats)
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

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE cats SET name=?, birthday=?, sex=?, breed=?, weight=?, availability=?, adoption_fee=? WHERE pet_Id=?";
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
        var sql = "DELETE FROM cats WHERE pet_Id = ?";
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
