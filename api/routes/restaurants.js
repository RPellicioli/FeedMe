const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');
const dateUtils = require('../utils/date-utils');

//Delete restaurant by id
router.delete('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('DELETE FROM restaurant WHERE id = ?', [req.params.id], (error, rows, fields) => {
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

//Insert an restaurant
router.post('/', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const created = dateUtils.getCurrentDate();
    const query = 'INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `longitude`, `latitude`, `cityId`, `stateId`, `created`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

    connection.query(query, [post.userId, post.name, post.cnpj, post.cep, post.number, post.street, post.complement, post.neighborhood, post.longitude, post.latitude, post.cityId, post.stateId, created], (error, rows, fields) => {
        if (!error) {
            console.log(rows);
            res.status(201).send({ id: rows.insertId });
        }
        else {
            console.log(error);
            res.status(500).send(error);
            next();
        }
    });
});

//Update an restaurant
router.put('/:id', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const updated = dateUtils.getCurrentDate();
    const query = 'UPDATE restaurant SET `name` = ?, `cnpj` = ?, `cep` = ?, `number` = ?, `street` = ?, `complement` = ?, `neighborhood` = ?, `longitude` = ?, `latitude` = ?, `cityId` = ?, `stateId` = ?, `updated` = ? WHERE id = ?';

    connection.query(query, [post.name, post.cnpj, post.cep, post.number, post.street, post.complement, post.neighborhood, post.longitude, post.latitude, post.cityId, post.stateId, updated, req.params.id], (error, rows, fields) => {
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