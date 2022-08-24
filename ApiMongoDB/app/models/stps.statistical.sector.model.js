const mongoose = require('mongoose');

const StatisticalSectorSchema = mongoose.Schema({
    year: String,
    month: String,
    salary: Number,
    age: Number,
    gender: String,
    sector_id: Number,
    state_id: Number,
    municipality_id: Number,
}, {
    timestamps: true
});



module.exports = mongoose.model('StatisticalSector', StatisticalSectorSchema);