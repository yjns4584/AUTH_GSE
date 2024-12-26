const mongoose = require('mongoose')
const Schema = mongoose.Schema

const facial = new Schema({
  username: {
    type: String,
    required: true,
    unique: true
  },
  facialData: {
    type: Number,
    required: true,
    unique: true
  }
})

module.exports = mongoose.model('facial', facial)