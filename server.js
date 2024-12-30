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
      const userData = req.body
      console.log(userData)
      // Tratar el JSON que me trae Kevin desde Flutter y guardar esos datos en Psostgrest.
      res.status(200).send('Registro completado.')
      
    })

    app.post('/login', (req, res) => {
      const userLogin = req.body
      console.log(userLogin)
      // Con el ID del usuario, hacer un query a la base de datos y traer la imagen de la persona en BASE64 y enviarselo a Yesid.

      res.status(200).send('LOGIN correcto.')

    })

    app.listen(config.port, () =>
      console.log(`Servicio escuchando en el puerto ${config.port}...`)
    )
  })
})