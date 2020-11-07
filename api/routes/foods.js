const express = require('express');
const path = require('path');
const router = express.Router();
const connection = require('../connection');
const authService = require('../services/auth-service');
const dateUtils = require('../utils/date-utils');
const { Storage } = require('@google-cloud/storage');
const Multer = require('multer');

const storage = new Storage({
    projectId: "feedme-287719",
    keyFilename: path.join(__dirname, "../feedme-287719-1a9ae0f6d37b.json")
});

const multer = Multer({
    storage: Multer.memoryStorage(),
    limits: {
        fileSize: 5 * 1024 * 1024 // no larger than 5mb, you can change as needed.
    }
});

const bucket = storage.bucket('feedme-app');

//Get food different listId
router.get('/random', authService.verifyToken, (req, res, next) => {
    const km = 200;
    const lat = Number(req.query.lat);
    const lon = Number(req.query.lon);
    
    // r = D/R = (km/6371km 'tamanho da terra' ) = rad
    let rad = km/6371;
    let latmin = lat - rad;
    let latmax = lat + rad;

    let Δlon = Math.asin(Math.sin(rad) / Math.cos(lat));
    let lonmin = lon + Δlon;
    let lonmax = lon - Δlon;

    let listIds = [];
    let query = 'SELECT f.id, f.restaurantId, f.name as name, r.name as restaurantName, r.street, r.number, r.neighborhood, r.city, r.state, f.image, f.price, f.description, f.active, r.latitude, r.longitude FROM restaurant as r RIGHT JOIN food AS f ON f.restaurantId = r.id WHERE r.latitude BETWEEN ? AND ? AND r.longitude BETWEEN ? AND ?';

    if(req.query.listIds){
        listIds = JSON.parse(req.query.listIds);
        query += ' AND f.id NOT IN (?)';
    }

    connection.query(query, [latmin, latmax, lonmin, lonmax, listIds], (error, rows, fields) => {
        if (!error) {
            let food = { };

            if(rows && rows.length > 0){
                food = rows[Math.floor(Math.random() * rows.length)];
                food['distance'] = Number(calcCrow(lat, lon, food.latitude, food.longitude).toFixed(1));
            }

            res.status(200).send(food);
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
    const lat = Number(req.query.lat);
    const lon = Number(req.query.lon);

    connection.query('SELECT f.id, f.restaurantId, f.name as name, r.name as restaurantName, r.street, r.number, r.neighborhood, r.city, r.state, f.image, f.price, f.description, f.active, r.latitude, r.longitude FROM food as f LEFT JOIN restaurant as r ON r.id = f.restaurantId WHERE f.id = ?', [req.params.id], (error, rows, fields) => {
        if (!error) {
            if(rows && rows.length > 0){
                rows[0]["distance"] = Number(calcCrow(lat, lon, rows[0].latitude, rows[0].longitude).toFixed(1));
                res.status(200).send(rows[0]);
            }
            else{
                res.status(200).send([]);
            }
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
    const query = 'UPDATE food SET `name` = ?, `image` = ?, `price` = ?, `description` = ?, `active` = ?, `updated` = ? WHERE id = ?';

    connection.query(query, [post.name, post.image, post.price, post.description, post.active, updated, req.params.id], (error, rows, fields) => {
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

/**
 * Adding new file to the storage
 */
router.post('/upload', multer.single('file'), (req, res) => {
    let file = req.file;
    let path = req.body.path;

    if (file) {
        uploadImageToStorage(file, path).then((success) => {
            res.status(200).send({
                url: success
            });
        }).catch((error) => {
            console.error(error);
            res.status(500).send(error);
            next();
        });
    }
});

/**
 * Upload the image file to Google Storage
 * @param {File} file object that will be uploaded to Google Storage
 * @param {string} path
 */
const uploadImageToStorage = (file, path) => {
    return new Promise((resolve, reject) => {
        if (!file) {
            reject('No file');
        }

        if(path == null || path == ""){
            path = "foods";
        }

        let newFileName = `${Date.now()}_${file.originalname}`;
        let fileUpload = bucket.file(newFileName);

        const blobStream = fileUpload.createWriteStream({
            metadata: {
                contentType: file.mimetype
            }
        });

        blobStream.on('error', (error) => {
            console.log(error.response);
            reject('Something is wrong! Unable to upload at the moment.');
        });

        blobStream.on('finish', () => {
            const publicUrl = `https://storage.googleapis.com/${bucket.name}/${(encodeURI(fileUpload.name)).replace("\/", "%2F")}`;
            resolve(publicUrl);
        });

        blobStream.end(file.buffer);
    });
}

const calcCrow = (lat1, lon1, lat2, lon2) => {
    var R = 6371; // km
    var dLat = toRad(lat2-lat1);
    var dLon = toRad(lon2-lon1);
    var lat1 = toRad(lat1);
    var lat2 = toRad(lat2);

    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    var d = R * c;
    return d;
}

// Converts numeric degrees to radians
const toRad = (value) => {
    return value * Math.PI / 180;
}

module.exports = router;