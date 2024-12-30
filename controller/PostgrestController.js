const { pgPool } = require('../db')
const bcrypt = require('bcrypt')

exports.registerUser = async function (userData) {
  try {
    const hashedPassword = await bcrypt.hash(userData.password, 10);

    const query = `
      INSERT INTO users (usuario, nombre, apellido, nacimiento, tipoCC, Cedula, email, contrasena, telefono, img64)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING id;
    `;
    const values = [userData.usuario, userData.nombre, userData.apellido, userData.nacimiento, userData.tipoCC, userData.cedula, userData.email, hashedPassword, userData.telefono, userData.img64]

    const result = await pgPool.query(query, values)

    if (!result.rows.length > 0) return { success: false, message: 'No se pudo registrar el usuario.' }
    return { success: true, message: 'Usuario registrado exitosamente.' }

  } catch (error) {
    console.error('Error al registrar el usuario:', error.message)
    return { success: false, message: 'Error al registrar el usuario.' }
  }
}

exports.loginUser = async function (username, password) {
  try {
    const query = `
      SELECT id, username, password, email
      FROM users
      WHERE username = $1;
    `;
    const values = [username];

    const result = await pgPool.query(query, values);

    if (result.rows.length === 0) return { success: false, user: null, message: 'Usuario no encontrado.' };
    

    const user = result.rows[0];

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) return { success: false, user: null, message: 'Contraseña incorrecta.' };
    

    delete user.password;

    return { success: true, user, message: 'Inicio de sesión exitoso.' };
  } catch (err) {
    console.error('Error al iniciar sesión:', err.message);
    return { success: false, user: null, message: 'Error al iniciar sesión.' };
  }
};
