module.exports = (app) => {
    const statisticalsector = require('../controllers/stps.statistical.sector.controller.js');

    // Create a new StatisticalSector
    app.post('/statisticalsector', statisticalsector.create);

    // Retrieve all StatisticalSector
    app.get('/statisticalsector', statisticalsector.findAll);

    // Retrieve a single StatisticalSector with staticalSectorRecId
    app.get('/statisticalsector/:staticalSectorRecId', statisticalsector.findOne);

    // Update a StatisticalSector with staticalSectorRecId
    app.put('/statisticalsector/:staticalSectorRecId', statisticalsector.update);

    // Delete a StatisticalSector with staticalSectorRecId
    app.delete('/statisticalsector/:staticalSectorRecId', statisticalsector.delete);
}