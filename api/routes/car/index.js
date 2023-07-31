const router = require('express').Router();
const TableCar = require('./table_car');
const Car = require('./car');
const authenticateToken = require('../../middleware/auth_middleware');
const isUserAdmin = require('../../middleware/admin_permission');

router.get('', async (req, res) => {
  const results = await TableCar.list(req.query ?? {});
  res.status(200).send(results);
});

router.post('', authenticateToken, isUserAdmin, async (req, res, next) => {
  try {
    const receiveData = await req.body;
    const car = new Car(receiveData);
    await car.create();
    res.status(201).send(JSON.stringify(car)).end();
  } catch (error) {
    res.status(error.code).json(error)
  }
});

router.put('/:idCar', authenticateToken, isUserAdmin, async (req, res, next) => {
  try {
    const id = req.params.idCar;
    const receiveData = req.body;
    
    const data = Object.assign({}, receiveData, { id });
    const car = new Car(data);
    await car.update();

    res.status(204).end();
  } catch (error) {
    res.status(error.code).json(error)
  }
});

router.delete('/:idCar', authenticateToken, isUserAdmin, async (req, res, next) => {
  try {
    const id = await req.params.idCar;
    const car = new Car({ id: id });
    await car.load();
    await car.remove();

    res.status(204).end();
  } catch (error) {
    res.status(error.code).json(error)
  }
});

module.exports = router;
