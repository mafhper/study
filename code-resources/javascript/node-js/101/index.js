const express = require('express');
const app = express();
 
app.get('/', function (req, res) {
  res.send('<h1 style="color: red" >Hello World!</h1>');
});

app.get('/oi', function (req, res) {
  res.send('<h1 style="color: blue" >Olá Mundo</h1>');
});

app.listen(1234)