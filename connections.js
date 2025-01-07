const config = require('./config/config.json');
const Mongoose = require('mongoose');
const { Pool } = require('pg');

let pgPool

exports.pgConnect = async function pgConnect() {
  if (!pgPool) {
    console.info('Conectando base de datos PostgreSQL...')
    pgPool = new Pool({
      user: config.postgrest.user,
      host: config.postgrest.host,
      database: config.postgrest.database,
      password: config.postgrest.password,
      port: config.postgrest.port,
    })

    pgPool.on('connect', () => {
      console.info('PostgreSQL conectado.')
    })

    pgPool.on('error', (err) => {
      console.error('Error al conectar la base de datos PostgreSQL...', err.message)
      process.exit()
    })
  }
  return pgPool
}

exports.mongoConnect = async function mongoConnect() {
  try {
    console.info('Conectando base de datos MongoDB...')
    await Mongoose.connect(config.mongo, {})
    console.info('MongoDB conectado.')
  } catch (err) {
    console.error('Error al conectar la base de datos MongoDB...', err.message)
    process.exit()
  }
}
