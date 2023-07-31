const CreateTablesUser = require('../routes/user/model_user');
const CreateTablesCar = require('../routes/car/model_car');

CreateTablesUser.sync()
  .then(() => console.log('Tabela user criado com sucesso'))
  .catch(console.log);

CreateTablesCar.sync()
  .then(() => console.log('Tabela car criado com sucesso'))
  .catch(console.log);
