const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

// Importação das rotas
const eventoRoutes = require('./routes/eventoRoutes');
const authRoutes = require('./routes/authRoutes');
// const outrasRotas = require('./routes/outraRota'); // se necessário

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// Rotas ativas
app.use('/api/eventos', eventoRoutes);
app.use('/api/auth', authRoutes);
// app.use('/api/alguma-coisa', outrasRotas);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
