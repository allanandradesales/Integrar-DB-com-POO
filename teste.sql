| id\_cliente (PK) | nome        | email                                     |
| ---------------- | ----------- | ----------------------------------------- |
| 1                | João Silva  | [joao@email.com](mailto:joao@email.com)   |
| 2                | Maria Souza | [maria@email.com](mailto:maria@email.com) |





| id\_pedido (PK) | id\_cliente (FK) | data       | total  |
| --------------- | ---------------- | ---------- | ------ |
| 101             | 1                | 2024-05-10 | 250.00 |
| 102             | 2                | 2024-05-11 | 130.00 |


SELECT 
  c.nome,
  p.id_pedido,
  p.total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente;


| Entidade       | Relaciona com...                          | Exemplo de relacionamento           |
| -------------- | ----------------------------------------- | ----------------------------------- |
| `Alunos`       | `Turmas`                                  | Um aluno pertence a uma turma       |
| `Funcionários` | `Departamentos`                           | Um funcionário trabalha em 1 depto  |
| `Produtos`     | `Categorias`                              | Cada produto pertence a 1 categoria |
| `Livros`       | `Autores` (N\:N via tabela intermediária) | Um livro pode ter vários autores    |


