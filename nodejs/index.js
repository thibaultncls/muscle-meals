const express = require('express');
const tokenController = require('./controllers/token.controllers');
const userRoutes = require('./routes/user.routes');
const { default: mongoose } = require('mongoose');
require('dotenv').config();


const app = express();
const port = process.env.PORT;

app.use(express.json()); // for parsing application/json
app.use(express.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

mongoose.connect('mongodb://localhost/recipies',);

app.use('/', userRoutes);

app.get('/', (req, res) => {
    res.send('Hello World');
});

app.listen(port, () => {
    console.log(`Serveur lancé sur le port ${port}`);
});