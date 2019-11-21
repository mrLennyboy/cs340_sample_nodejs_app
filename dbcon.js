var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_wongjasp',
  password        : '8994',
  database        : 'cs340_wongjasp'
});
module.exports.pool = pool;
