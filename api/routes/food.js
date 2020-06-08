const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');

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
    const query = 'INSERT INTO food(`userId`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `longitude`, `latitude`, `cityId`, `stateId`, `created`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

    connection.query(query, [post.userId, post.cnpj, post.cep, post.number, post.street, post.complement, post.neighborhood, post.longitude, post.latitude, post.cityId, post.stateId, created], (error, rows, fields) => {
        if (!error) {
            res.status(201).send(rows[0][0]);
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
    const query = 'UPDATE food SET `cnpj` = ?, `cep` = ?, `number` = ?, `street` = ?, `complement` = ?, `neighborhood` = ?, `longitude` = ?, `latitude` = ?, `cityId` = ?, `stateId` = ?, `updated` = ? WHERE id = ?';

    connection.query(query, [post.cnpj, post.cep, post.number, post.street, post.complement, post.neighborhood, post.longitude, post.latitude, post.cityId, post.stateId, updated, req.params.id], (error, rows, fields) => {
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