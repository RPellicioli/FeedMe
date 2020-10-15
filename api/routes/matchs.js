const express = require('express');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');

//Delete match by id
router.delete('/:id', authService.verifyToken, (req, res, next) => {
    connection.query('DELETE FROM `match` WHERE id = ?', [req.params.id], (error, rows, fields) => {
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

//Insert an match
router.post('/', authService.verifyToken, (req, res, next) => {
    const post = req.body;
    const query = 'INSERT INTO `match`(`userId`, `foodId`) VALUES (?, ?)';
    
    connection.query(query, [post.userId, post.foodId], (error, rows, fields) => {
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

module.exports = router;