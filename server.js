const config = require('./config/config.json')
const express = require('express')
const app = express()
require('./connection').mongoConnect().then(async () => {
  app.listen(config.port, () =>
    console.log(`Servicio escuchando en el puerto ${config.port}...`)
  )
})