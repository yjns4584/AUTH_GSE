const express = require('express')
const api = express.Router()

api.post('/pdf', async (req, res) => {
  console.log(req.body)
  
  res.status(200).send({data, message: 'Endpoint Auth.'})
})

module.exports = api
