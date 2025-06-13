const jwt = require('jsonwebtoken');

const verificarToken = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Token não fornecido' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.usuario = decoded;
    next();
  } catch (err) {
    res.status(403).json({ message: 'Token inválido ou expirado' });
  }
};

const permitirPerfis = (...perfisPermitidos) => {
  return (req, res, next) => {
    if (!req.usuario || !perfisPermitidos.includes(req.usuario.perfil)) {
      return res.status(403).json({ message: 'Acesso negado ao perfil atual' });
    }
    next();
  };
};

module.exports = {
  verificarToken,
  permitirPerfis,
};
