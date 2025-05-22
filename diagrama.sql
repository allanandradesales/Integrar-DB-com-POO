

        /* [MUNDO REAL / DOMÍNIO DO PROBLEMA] */
                                 ↓
              ┌────────────────────┐
              │   ENTIDADE         │ ◄──────────── Ex: Cliente, Produto, Pedido
              └────────────────────┘
                         ↓ é modelada como
              ┌────────────────────┐
              │     CLASSE         │ ◄──────────── Ex: class Cliente {...}
              └────────────────────┘
                         ↓ cria
              ┌────────────────────┐
              │    OBJETO          │ ◄──────────── Ex: const cliente1 = new Cliente()
              └────────────────────┘
                         ↕ sinônimo
              ┌────────────────────┐
              │   INSTÂNCIA        │ ◄──────────── Uma instância da classe Cliente
              └────────────────────┘
                         ↓ possui
          ┌────────────┬────────────┬────────────┐
          │ ATRIBUTOS  │ MÉTODOS    │ PROPRIEDADES│
          └────────────┴────────────┴────────────┘
              Ex: nome, cpf       Ex: comprar(), atualizarEmail()

         /*| Mundo Real                              | Termo Técnico                | Exemplo                |
| --------------------------------------- | ---------------------------- | ---------------------- |
| Ideia de um cliente                     | **Entidade**                 | Cliente                |
| Desenho/modelo de um cliente no sistema | **Classe**                   | class Cliente          |
| Um cliente específico                   | **Objeto / Instância**       | `joao = new Cliente()` |
| Nome, CPF, Email do cliente             | **Atributos / Propriedades** | joao.nome = "João"     |
| Ação que o cliente pode fazer           | **Método**                   | joao.comprarProduto()  |


