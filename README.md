# show_case_flutter_node_js

[![showcase_cars][node_logo_img]][repo_url]

## Aviso

Antes de começar sua leitura, vale lembrar que esse repositório está dividido em duas branches: "front-end" e "back-end", em cada uma delas você irá encontrar seus respectivos códigos.

### Back-end - NodeJs

O Back-end foi feito com a possibilidade de `escalar`, sempre pensando em uma maneira mais fácil de se comunicar com o Front-end.

Utilizando como back-end `Node.js` e como banco de dados o `MySQL`, e para criar o banco de dados foi utilizado Express.js e Sequelize.

A API é composta de 2 grupos de rotas envolvendo usuários e carros e sempre mantendo uma padronização nos retornos.

Foi utilizado o `token JWT` para restringir ações de usuários e manter os dados mais protegidos. Fora a utilização de criptografia para salvar a senha no banco, e uma hash especial junto a ela. Para a realização da busca de Carros dentro do banco foi feito a busca LIKE, função presente no banco mysql.

## ⚡️ Como utilizar

### Back-end

Clone o repositorio no terminal de sua preferencia e dentro da pasta do projeto mude a branch

- <code>`git clone https://github.com/BrunoRabbit/show_case_cars_flutter_node_js`</code>
- git checkout backend

Inicialize o node_modules

- <code>npm install</code>

Crie o banco de dados com o comando

- <code>node api/db/create_tables.js</code>

## ❗ Observações (Back-end)

Após seguir com as orientações do tópico anterior, é necessário criar o `Administrador`. Sempre o usuario cadastrado será um Adm, para motivos de teste.

## 📝 Métricas concluídas

    ✅ Home page pública exibindo a vitrine de veículos.
    ✅ Os veiculos devem estar em ordem de valor
    ✅ Para cadastro dos veiculos deverá ter um login administrativo com token JWT
    ✅ O admin so pode ser acessado se o usuario conseguir se autenticar
    ✅ Todas as requisicoes privadas de um token valido gerado no login para o funcionamento da requisicao
    ✅ O cadastro de veiculos deverá ser um CRUD
    ✅ O Backend deverá ser uma API Rest
    ✅ Todos os dados devem ser persistidos no banco

## ⭐️ Credits

Feito com ♥ por [Bruno Coelho][author_linkedin].

<!-- Repository -->

[node_logo_img]: https://img.shields.io/badge/Node.js_v18.17.0-43853D?style=for-the-badge&logo=node.js&logoColor=white
[dart_logo_img]: https://img.shields.io/badge/Dart-2.19.4_<_3.0.0-045998?style=for-the-badge&logo=dart
[repo_url]: https://github.com/BrunoRabbit/show_case_cars_flutter_node_js/

<!-- Design company author -->

[company_author]: https://www.kavak.com/br/seminovos

<!-- Flutter app author -->

[author_linkedin]: https://www.linkedin.com/in/bruno-coelho-2337741b5/
[author_github]: https://github.com/BrunoRabbit
