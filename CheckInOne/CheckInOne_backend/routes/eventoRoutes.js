const express = require('express');
const { listarEventos, criarEvento } = require('../controllers/eventoController');
const { verificarToken, permitirPerfis } = require('../middleware/authMiddleware');

const router = express.Router();

router.get('/', verificarToken, listarEventos);
router.post('/', verificarToken, permitirPerfis('organizador', 'admin'), criarEvento);

module.exports = router;
