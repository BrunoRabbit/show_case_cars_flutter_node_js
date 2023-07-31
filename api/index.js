const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const config = require('config');
const cors = require('cors');

app.use(cors());
app.use(express.json());
app.use(bodyParser.json());

const routerUser = require('./routes/user/index');
const routerCar = require('./routes/car/index');
const errorsDefault  = require('./errors/errors_messages');

app.use('/api/user', routerUser);
app.use('/api/car', routerCar);

app.use((req, res, next) => {
  res.status(404).send();
});

app.listen(config.get('api.port'), () => console.log(errorsDefault.apiIsWorking));
