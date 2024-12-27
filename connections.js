const config = require('./config/config.json')
const Mongoose = require('mongoose')
const { Pool } = require('pg')

exports.pgConnect = async function pgConnect() {
  try {
    console.info('Conectando base de datos PostgreSQL...')
    let pool = new Pool({
      user: config.postgrest.user,
      host: config.postgrest.host,
      database: config.postgrest.database,
      password: config.postgrest.password,
      port: config.postgrest.port,
    })
    await pool.connect()
    console.info('Base de datos PostgreSQL conectada.')
  } catch (err) {
    console.error('Error al conectar la base de datos PostgreSQL...', err.message)
    process.exit()
  }
}

exports.mongoConnect = async function mongoConnect() {
	console.info('Conectando base de datos Mongo...')
	await Mongoose.connect(config.mongo, {}).then(() => {
		console.info('Base de datos Mongo conectada.')
	}).catch((err) => {
		console.error('Error al conectar la base de datos Mongo...', err.message)
		process.exit()
	})
}