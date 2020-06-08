const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');

//Get restaurant by userId
router.get('/user/:userId', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM restaurant WHERE userId = ?', [req.params.userId], (error, rows, fields) => {
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
    const query = 'INSERT INTO restaurant(`userId`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `longitude`, `latitude`, `cityId`, `stateId`, `created`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

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

//Update an restaurant
router.put('/:id', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const updated = dateUtils.getCurrentDate();
    const query = 'UPDATE restaurant SET `cnpj` = ?, `cep` = ?, `number` = ?, `street` = ?, `complement` = ?, `neighborhood` = ?, `longitude` = ?, `latitude` = ?, `cityId` = ?, `stateId` = ?, `updated` = ? WHERE id = ?';

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