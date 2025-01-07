const express = require('express')
const api = express.Router()

// Controller
const postgrest = require('../controller/PostgrestController')

api.post('/register', async (req, res) => {
  const userData = req.body
  console.log(userData)
  const { success, message } = await postgrest.registerUser(userData)
  // Tratar el JSON que me trae Kevin desde Flutter y guardar esos datos en Postgrest.
  res.status(200).send('Registro completado.')
  
})

api.post('/login', async (req, res) => {
  const userLogin = req.body
  console.log(userLogin)
  // Con el ID del usuario, hacer un query a la base de datos y traer la imagen de la persona en BASE64 y enviarselo a Yesid.
  const { success, message, user} = await postgrest.loginUser(userLogin)

  res.status(200).send('LOGIN correcto.')

})

module.exports = api
