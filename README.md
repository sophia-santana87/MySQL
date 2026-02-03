# MySQL

O objetivo primordial deste modelo é sustentar o fluxo operacional de um e-commerce, priorizando a **disponibilidade de produtos, a venda e a logística de entrega**. Diferente de sistemas focados em gestão financeira complexa, este esquema foi projetado para ser ágil e eficiente no processamento de pedidos.

### Primeiro Exemplo:

* **Foco no Fluxo de Vendas:** A estrutura centraliza-se na conversão da venda, conectando fornecedores e vendedores ao catálogo de produtos de forma direta.
* **Gestão de Estoque Robusta:** Utiliza entidades associativas (`Produto_Estoque`) para garantir que o controle de inventário seja preciso, evitando vendas sem disponibilidade física.
* **Simplificação Cadastral:** Optou-se por uma abordagem pragmática para a gestão de clientes e pagamentos. Em vez de hierarquias complexas de especialização, o modelo utiliza atributos identificadores (como `Tipo_cli`) para agilizar o processo de cadastro e inserção de dados.
* **Rastreabilidade Logística:** O modelo inclui entidades de `Status` e `Entrega` para garantir que, após a venda, o ciclo de vida do pedido seja monitorado até o destino final, cumprindo o requisito essencial de um e-commerce moderno.
* **Normalização de Endereços:** A separação da entidade `Endereço` permite que o sistema gerencie diferentes pontos de origem (vendedores) e destino (clientes) com integridade e sem redundância de dados.

### Segundo Exemplo:
* **Core Bussines: ** Nesse modelo foram abordados somente as entidades requeids pelo usuário, focando exclusivamente nas funções que fossem de acordo com o contexto (Execução de ordens de serviço para uma oficina mecânica).

O modelo apresentado representa um **sistema de gerenciamento de ordens de serviço para uma oficina mecânica**, contemplando clientes, veículos, serviços, peças, equipes mecânicas e o acompanhamento do status das ordens. A modelagem busca organizar as informações de forma estruturada, reduzindo redundâncias e garantindo integridade dos dados.

A entidade **Cliente** armazena os dados pessoais do cliente, sendo identificada unicamente pelo **CPF**, que atua como chave primária. Nela constam informações como nome completo, telefone, e-mail, RG e dados relacionados ao endereço e ao veículo do cliente. Cada cliente pode estar associado a **um ou mais veículos** e também pode possuir **uma ou mais ordens de serviço** ao longo do tempo.

A entidade **Endereço** concentra os dados de localização, como CEP, logradouro, bairro, cidade e UF. Essa separação permite reutilização e melhor organização das informações de endereço, evitando repetição de dados em diferentes registros de clientes.

A entidade **Veículo** é identificada pela **placa**, considerada única, e armazena características do automóvel, como chassi, modelo, ano de fabricação, ano do modelo, cor e tipo. Um veículo pode estar associado a **várias ordens de serviço**, porém cada ordem de serviço refere-se a apenas **um veículo específico**.

A entidade central do modelo é a **Ordem_serviço**, que representa cada atendimento realizado pela oficina. Ela possui informações como data de emissão, data de entrega, descrição do serviço executado e valores totais. Cada ordem de serviço está associada a:

* um **cliente**;
* um **veículo**;
* uma **equipe mecânica** responsável;
* um **status**, que indica a situação atual da ordem (por exemplo, em andamento, finalizada ou aguardando).

A entidade **Status** define os possíveis estados de uma ordem de serviço, contendo uma descrição e um atributo que indica se o status permite ou não o avanço do serviço. Essa separação facilita o controle e a padronização do fluxo das ordens.

A entidade **Equipe_mecânica** representa os grupos responsáveis pela execução dos serviços, contendo informações como código, nome da equipe e especialidade. Uma equipe pode estar associada a **várias ordens de serviço**, enquanto cada ordem é atribuída a apenas uma equipe.

Os **Serviços** oferecidos pela oficina são armazenados em uma entidade própria, contendo nome, descrição, valor unitário da mão de obra e valor dos recursos utilizados. A relação entre **Serviços** e **Ordem_serviço** é do tipo **muitos para muitos**, sendo resolvida pela entidade associativa **Ordens_serviços**, que registra quais serviços foram executados em cada ordem, além do valor total correspondente.

De forma semelhante, a entidade **Peças** armazena as informações das peças utilizadas nos reparos, incluindo nome e valor de compra. A relação entre **Peças** e **Ordem_serviço** também é muitos para muitos e é resolvida pela entidade **Itens_peças**, que registra a quantidade de cada peça utilizada, o preço de revenda e a ordem de serviço à qual a peça está vinculada.
atendendo aos princípios de normalização e integridade referencial.

