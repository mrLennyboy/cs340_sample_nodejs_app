var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_peteales',
  password        : '0044',
  database        : 'cs340_peteales'
});
module.exports.pool = pool;
