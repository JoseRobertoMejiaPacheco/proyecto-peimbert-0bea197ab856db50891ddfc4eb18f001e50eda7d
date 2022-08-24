const StatisticalSector = require('../models/stps.statistical.sector.model.js');

// Create and Save a new StatisticalSector
exports.create = (req, res) => {
    // Validate request
    if (!req.body) {
        return res.status(400).send({
            message: "No puede ser vacío content can not be empty"
        });
    }

    // Create a StatisticalSector
    const statisticalsector = new StatisticalSector({

        year: req.body.year,
        month: req.body.month,
        salary: req.body.salary,
        age: req.body.age,
        gender: req.body.gender,
        sector_id: req.body.sector_id,
        state_id: req.body.state_id,
        municipality_id: req.body.municipality_id

    });

    // Save StatisticalSector in the database
    statisticalsector.save()
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the StatisticalSector."
            });
        });
};

// Retrieve and return all from the database.
exports.findAll = (req, res) => {
    StatisticalSector.find()
        .then(statisticalsectors => {
            res.send(statisticalsectors);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving."
            });
        });
};

// Find a single with a staticalSectorRecId
exports.findOne = (req, res) => {
    StatisticalSector.findById(req.params.staticalSectorRecId)
        .then(statisticalsector => {
            if (!statisticalsector) {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            res.send(statisticalsector);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            return res.status(500).send({
                message: "Error retrieving  with id " + req.params.staticalSectorRecId
            });
        });
};

// Update  identified by the staticalSectorRecId in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
        return res.status(400).send({
            message: "Statisticalsector content can not be empty"
        });
    }

    // Find  and update it with the request body
    StatisticalSector.findByIdAndUpdate(req.params.staticalSectorRecId, {
        year: req.body.year,
        month: req.body.month,
        salary: req.body.salary,
        age: req.body.age,
        gender: req.body.gender,
        sector_id: req.body.sector_id,
        state_id: req.body.state_id,
        municipality_id: req.body.municipality_id
    }, { new: true })
        .then(statisticalsector => {
            if (!statisticalsector) {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            res.send(statisticalsector);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            return res.status(500).send({
                message: "Error updating statisticalsector with id " + req.params.staticalSectorRecId + req.body.year+err
            });
        });
};

// Delete a with the specified staticalSectorRecId in the request
exports.delete = (req, res) => {
    StatisticalSector.findByIdAndRemove(req.params.staticalSectorRecId)
        .then(statisticalsector => {
            if (!statisticalsector) {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            res.send({ message: "Statisticalsector deleted successfully!" });
        }).catch(err => {
            if (err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "Statisticalsector not found with id " + req.params.staticalSectorRecId
                });
            }
            return res.status(500).send({
                message: "Could not delete statisticalsector with id " + req.params.staticalSectorRecId
            });
        });
};
