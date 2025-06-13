const { db } = require('../models/db');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');

const login = async (req, res) => {
  const { email, senha } = req.body;

  try {
    const [rows] = await db.execute('SELECT * FROM Usuario WHERE email = ?', [email]);
    const user = rows[0];

    if (!user) {
      return res.status(401).json({ message: 'Usuário não encontrado' });
    }

    // Gera hash SHA256 da senha recebida
    const senhaHash = crypto.createHash('sha256').update(senha).digest('hex');

    if (user.senha !== senhaHash) {
      return res.status(401).json({ message: 'Senha incorreta' });
    }

    const token = jwt.sign({ id: user.id_usuario, perfil: user.perfil }, process.env.JWT_SECRET, {
      expiresIn: '1d',
    });

    res.json({ token, perfil: user.perfil });
  } catch (err) {
    res.status(500).json({ error: 'Erro interno', details: err.message });
  }
};

module.exports = { login };
