const { pgPool } = require('../db'); // Asegúrate de tener configurado el pool de PostgreSQL
const bcrypt = require('bcrypt');

/**
 * Registra un nuevo usuario en la base de datos PostgreSQL.
 * @param { object } userData Nombre de usuario.
 * @returns {Promise<{ success: boolean, message: string }>} Indica si el registro fue exitoso.
 */
exports.registerUser = async function (userData) {
  try {
    // Encriptar la contraseña antes de guardarla
    const hashedPassword = await bcrypt.hash(userData.password, 10);

    // Inserta el usuario en la base de datos
    const query = `
      INSERT INTO users (usuario, nombre, apellido, nacimiento, tipoCC, Cedula, email, contrasena, telefono)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING id;
    `;
    const values = [userData.usuario, userData.nombre, userData.apellido, userData.nacimiento, userData.tipoCC, userData.cedula, userData.email, hashedPassword, userData.telefono];

    const result = await pgPool.query(query, values);

    if (result.rows.length > 0) {
      return { success: true, message: 'Usuario registrado exitosamente.' };
    } else {
      return { success: false, message: 'No se pudo registrar el usuario.' };
    }
  } catch (error) {
    console.error('Error al registrar el usuario:', error.message);
    return { success: false, message: 'Error al registrar el usuario.' };
  }
};

/**
 * Inicia sesión del usuario validando las credenciales y obteniendo sus datos.
 * @param { string } username Nombre de usuario.
 * @param { string } password Contraseña del usuario.
 * @returns {Promise<{ success: boolean, user: object | null, message: string }>} Resultado del inicio de sesión.
 */
exports.loginUser = async function (username, password) {
  try {
    // Consulta el usuario por nombre de usuario
    const query = `
      SELECT id, username, password, email
      FROM users
      WHERE username = $1;
    `;
    const values = [username];

    const result = await pgPool.query(query, values);

    if (result.rows.length === 0) return { success: false, user: null, message: 'Usuario no encontrado.' };
    

    const user = result.rows[0];

    // Verifica la contraseña
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) return { success: false, user: null, message: 'Contraseña incorrecta.' };
    

    // Elimina la contraseña del objeto antes de retornarlo
    delete user.password;

    return { success: true, user, message: 'Inicio de sesión exitoso.' };
  } catch (err) {
    console.error('Error al iniciar sesión:', err.message);
    return { success: false, user: null, message: 'Error al iniciar sesión.' };
  }
};
