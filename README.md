# MySQL

O objetivo primordial deste modelo é sustentar o fluxo operacional de um e-commerce, priorizando a **disponibilidade de produtos, a venda e a logística de entrega**. Diferente de sistemas focados em gestão financeira complexa, este esquema foi projetado para ser ágil e eficiente no processamento de pedidos.

### Destaques da Modelagem:

* **Foco no Fluxo de Vendas:** A estrutura centraliza-se na conversão da venda, conectando fornecedores e vendedores ao catálogo de produtos de forma direta.
* **Gestão de Estoque Robusta:** Utiliza entidades associativas (`Produto_Estoque`) para garantir que o controle de inventário seja preciso, evitando vendas sem disponibilidade física.
* **Simplificação Cadastral:** Optou-se por uma abordagem pragmática para a gestão de clientes e pagamentos. Em vez de hierarquias complexas de especialização, o modelo utiliza atributos identificadores (como `Tipo_cli`) para agilizar o processo de cadastro e inserção de dados.
* **Rastreabilidade Logística:** O modelo inclui entidades de `Status` e `Entrega` para garantir que, após a venda, o ciclo de vida do pedido seja monitorado até o destino final, cumprindo o requisito essencial de um e-commerce moderno.
* **Normalização de Endereços:** A separação da entidade `Endereço` permite que o sistema gerencie diferentes pontos de origem (vendedores) e destino (clientes) com integridade e sem redundância de dados.

