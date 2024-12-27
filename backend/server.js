const config = require('./config/config.json')
const express = require('express')
const app = express()

const ClientRedis = require('./helper/RedisConnection')
const redisClient = new ClientRedis()

require('./connections').mongoConnect().then( () => {
  require('./connections').pgConnect().then(async () => {
    await redisClient.redisConnect()

    app.use(express.json())

    app.post('/register', (req, res) => {
      const userData = req.body;
      
    })

    app.listen(config.port, () =>
      console.log(`Servicio escuchando en el puerto ${config.port}...`)
    )
  })
})