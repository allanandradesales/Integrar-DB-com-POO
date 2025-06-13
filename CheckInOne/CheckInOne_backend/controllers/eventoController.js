const { db } = require('../models/db');

const listarEventos = async (req, res) => {
  try {
    const [eventos] = await db.execute('SELECT * FROM Evento ORDER BY data_evento');
    res.json(eventos);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao listar eventos', details: err.message });
  }
};

const criarEvento = async (req, res) => {
  const { nome_evento, data_evento, local } = req.body;
  try {
    const [result] = await db.execute(
      'INSERT INTO Evento (nome_evento, data_evento, local) VALUES (?, ?, ?)',
      [nome_evento, data_evento, local]
    );
    res.status(201).json({ id_evento: result.insertId, nome_evento, data_evento, local });
  } catch (err) {
    res.status(500).json({ error: 'Erro ao criar evento', details: err.message });
  }
};

module.exports = {
  listarEventos,
  criarEvento,
};
