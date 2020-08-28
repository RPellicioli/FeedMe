const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');
const dateUtils = require('../utils/date-utils');

//Get restaurant by id
router.get('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM restaurant WHERE id = ?', [req.params.id], (error, rows, fields) => {
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

//Get schedule by restaurantId
router.get('/:restaurantId/schedule', authService.verifyToken, (req, res, next) => {
    connection.query('SELECT * FROM schedule WHERE restaurantId = ?', [req.params.restaurantId], (error, rows, fields) => {
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

//Insert schedule by restaurantId
router.post('/:restaurantId/schedule', authService.verifyToken, (req, res, next) => {
    const schedules = req.body.schedules;
    
    if(!schedules){
        res.status(500).send("Schedules not be empty");
    }

    connection.query('DELETE FROM schedule WHERE restaurantId = ?', [req.params.restaurantId], (error, rows, fields) => {
        if (!error) {
            let values = [];

            schedules.forEach(s => {
                values.push([
                    s.restaurantId,
                    s.day,
                    s.initialHour,
                    s.finalHour
                ]);
            });

            if(values.length === 0){
                res.status(201).send('successfully');
            }

            const query = 'INSERT INTO schedule(`restaurantId`, `day`, `initialHour`, `finalHour`) VALUES ?';

            connection.query(query, [values], (error, rows, fields) => {
                if (!error) {
                    console.log(rows);
                    res.status(201).send('Insert successfully');
                }
                else {
                    console.log(error);
                    res.status(500).send(error);
                    next();
                }
            });
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