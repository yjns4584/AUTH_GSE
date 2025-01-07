const config = require('./config/config.json')
const express = require('express')
const app = express()

app.set('port', config.port || 9010)

app.use(express.json({ limit: '50mb' }))

app.use('/user', require('./routes/user-routes'))
app.use('/auth', require('./routes/auth-routes'))

module.exports = app
