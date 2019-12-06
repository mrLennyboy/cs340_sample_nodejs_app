module.exports = function () {
    var express = require('express');
    var router = express.Router();

    function getClients(res, mysql, context, complete) {
        mysql.pool.query("SELECT client_Id, first_name, last_name, address, phone_number, email FROM clients", function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.clients = results;
            complete();
        });
    }

    function getClient(res, mysql, context, id, complete) {
        var sql = "SELECT client_Id, first_name, last_name, address, phone_number, email FROM clients WHERE client_Id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.client = results[0];
            complete();
        });
    }

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteclient.js", "filterclients.js", "searchclients.js"];
        var mysql = req.app.get('mysql');
        getClients(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('clients', context);
            }

        }
    });

    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["updateclient.js"];
        var mysql = req.app.get('mysql');
        getClient(res, mysql, context, req.params.id, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.render('update-client', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO clients (first_name, last_name, address, phone_number, email) VALUES (?,?,?,?,?)";
        var inserts = [req.body.first_name, req.body.last_name, req.body.address, req.body.phone_number, req.body.email]
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.redirect('/clients');
            }
        });
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE clients SET first_name=?, last_name=?, address=?, phone_number=?, email=? WHERE client_Id=?";
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
        var sql = "DELETE FROM clients WHERE client_Id = ?";
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