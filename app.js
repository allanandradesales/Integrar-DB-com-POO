// app.js
const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const port = 3004;

// Conexão com o banco
const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: 'sua_senha',
  database: 'seu_banco'
};

// Rota para obter as cargas horárias e média
app.get('/cargas', async (req, res) => {
  try {
    const connection = await mysql.createConnection(dbConfig);

    // Maior carga horária - fora do depto Sistemas
    const [maior] = await connection.execute(`
      SELECT MAX(p.carga_horaria) AS maior
      FROM projetos p
      JOIN empregados e ON p.empregado_id = e.id
      JOIN departamentos d ON e.departamento_id = d.id
      WHERE p.nome = 'Informática para todos' AND d.nome <> 'Sistemas'
    `);

    // Menor carga horária - dentro do depto Sistemas
    const [menor] = await connection.execute(`
      SELECT MIN(p.carga_horaria) AS menor
      FROM projetos p
      JOIN empregados e ON p.empregado_id = e.id
      JOIN departamentos d ON e.departamento_id = d.id
      WHERE p.nome = 'Informática para todos' AND d.nome = 'Sistemas'
    `);

    const maiorCarga = maior[0].maior || 0;
    const menorCarga = menor[0].menor || 0;
    const media = (maiorCarga + menorCarga) / 2;

    res.json({
      maiorCarga,
      menorCarga,
      media
    });

    await connection.end();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erro ao buscar os dados' });
  }
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
