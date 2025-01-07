const app = require('./app')

const ClientRedis = require('./helpers/RedisConnection')
const redisClient = new ClientRedis()

require('./connections').mongoConnect().then( () => {
  require('./connections').pgConnect().then(async () => {
    await redisClient.redisConnect()

    app.listen(app.get('port'), () => console.info(`Servicio escuchando en el puerto ${app.get('port')}...`))
  })
})
