const config = require('../config/config.json')
const Redis = require('ioredis')

class ClientRedis {
  constructor () {
    if (ClientRedis.instance) return ClientRedis.instance
    ClientRedis.instance = this
  }

  async redisConnect () {
    console.info('Conectando base de datos Redis...')
    this.client = new Redis(config.redis)

    return new Promise((resolve, reject) => {
      this.client.on('connect', () => {
        console.info('Redis conectado.')
        resolve()
      })

      this.client.on('error', (error) => {
        console.error('Error al conectar la base de datos Redis...', error)
        process.exit()
      })
    })
  }

  async set (key, value, expire) {
    if (expire) return this.client.set(key, value, 'EX', expire)
    return this.client.set(key, value)
  }

  async get (key) {
    try {
      return await this.client.get(key)
    } catch (error) {
      console.error(error)
    }
  }

  async del (key) {
    return this.client.del(key)
  }

  async incr (key) {
    return this.client.incr(key)
  }

  async expTime (key) {
    return this.client.ttl(key)
  }
}

module.exports = ClientRedis
