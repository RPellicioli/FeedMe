const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');
const dateUtils = require('../utils/date-utils');

//Get user by id
router.get('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM user WHERE id = ?', [req.params.id], (error, rows, fields) => {
        if (!error) {
            res.status(200).send(rows[0]);
        }
        else {
            console.log(error);
            res.send(error);
            next();
        }
    });
});

//Get matchs by userId
router.get('/:id/matchs', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT m.id, m.foodId, f.name, f.image FROM `match` AS m LEFT JOIN food AS f ON f.id = m.foodId WHERE userId = ?', [req.params.id], (error, rows, fields) => {
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

//Get restaurant by userId
router.get('/:id/restaurant', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM restaurant WHERE userId = ?', [req.params.id], (error, rows, fields) => {
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

//Delete all matchs by userId
router.delete('/:id/matchs', authService.verifyToken, (req, res, next) => {
    connection.query('DELETE FROM `match` WHERE userId = ?', [req.params.id], (error, rows, fields) => {
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

//Delete user by id
router.delete('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('DELETE FROM user WHERE id = ?', [req.params.id], (error, rows, fields) => {
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

//Insert an user
router.post('/', (req, res, next) => {
    const post = req.body;
    const created = dateUtils.getCurrentDate();
    const query = 'INSERT INTO user(`name`, `email`, `password`, `admin`, `created`) VALUES (?, ?, ?, ?, ?)';

    connection.query(query, [post.name, post.email, post.password, post.admin, created], (error, rows, fields) => {
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

//Update an user
router.put('/:id', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const updated = dateUtils.getCurrentDate();
    const query = 'UPDATE user SET `name` = ?, `email` = ?, `password` = ?, `admin` = ?, `updated` = ?  WHERE id = ?';

    connection.query(query, [post.name, post.email, post.password, post.admin, updated, req.params.id], (error, rows, fields) => {
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