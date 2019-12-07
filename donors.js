module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getDonors(res, mysql, context, complete) {
        mysql.pool.query("SELECT donor_Id, first_name, last_name, address, phone_number, email FROM donors", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.donors = results;
            complete();
        });
    }

    function getDonor(res, mysql, context, id, complete) {
        var sql = "SELECT donor_Id, first_name, last_name, address, phone_number, email FROM donors WHERE donor_Id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.donor = results[0];
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletedonor.js", "filterdonors.js", "searchdonors.js"];
        var mysql = req.app.get('mysql');
        getDonors(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('donors', context);
            }

        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["updatedonor.js"];
        var mysql = req.app.get('mysql');
        getDonor(res, mysql, context, req.params.id, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('update-donor', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO donors (first_name, last_name, address, phone_number, email) VALUES (?,?,?,?,?)";
        var inserts = [req.body.first_name, req.body.last_name, req.body.address, req.body.phone_number, req.body.email]
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/donors');
            }
        });
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE donors SET first_name=?, last_name=?, address=?, phone_number=?, email=? WHERE donor_Id=?";
        var inserts = [req.body.first_name, req.body.last_name, req.body.address, req.body.phone_number, req.body.email, req.params.id];
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
        var sql = "DELETE FROM donors WHERE donor_Id = ?";
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
