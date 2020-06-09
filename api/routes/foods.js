const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');
const dateUtils = require('../utils/date-utils');

//Get food different listId
router.get('/random', authService.verifyToken, (req, res, next) => {
    var listIds = JSON.parse(req.query.listIds);

    connection.query('SELECT * FROM food WHERE id NOT IN (?)', [listIds], (error, rows, fields) => {
        if (!error) {
            res.status(200).send(rows);
        }
        else {
            console.log(error);
            res.send(error);
            next();
        }
    });
});

//Get food by id
router.get('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM food WHERE userId = ?', [req.params.id], (error, rows, fields) => {
        if (!error) {
            res.status(200).send(rows);
        }
        else {
            console.log(error);
            res.send(error);
            next();
        }
    });
});

//Delete food by id
router.delete('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('DELETE FROM food WHERE id = ?', [req.params.id], (error, rows, fields) => {
        if (!error) {
            res.status(200).send('Deleted successfully.');
        }
        else {
            console.log(error);
            res.status(500).send(error);
            next();
        }
    });
});

//Insert an food
router.post('/', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const created = dateUtils.getCurrentDate();
    const query = 'INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`) VALUES (?, ?, ?, ?, ?, ?, ?)';

    connection.query(query, [post.restaurantId, post.name, post.image, post.price, post.description, post.active, created], (error, rows, fields) => {
        if (!error) {
            res.status(201).send({ id: rows.insertId });
        }
        else {
            console.log(error);
            res.status(500).send(error);
            next();
        }
    });
});

//Update an food
router.put('/:id', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const updated = dateUtils.getCurrentDate();
    const query = 'UPDATE food SET `name` = ?, `price` = ?, `description` = ?, `active` = ?, `updated` = ? WHERE id = ?';

    connection.query(query, [post.name, post.price, post.description, post.active, updated, req.params.id], (error, rows, fields) => {
        if (!error) {
            res.status(200).send('Updated successfully');
        }
        else {
            console.log(error);
            res.status(500).send(error);
            next();
        }
    });
});

module.exports = router;