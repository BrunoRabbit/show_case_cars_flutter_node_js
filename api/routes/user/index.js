const router = require('express').Router();
const User = require('./user');
const jwt = require('jsonwebtoken');
const config = require('config');
const authenticateToken = require('../../middleware/auth_middleware');

router.post('/', async (req, res, next) => {
  try {
    const receiveData = await req.body;
    const user = new User(receiveData);
    await user.create();
    res.status(201).send(user);
  } catch (error) {
    res.status(error.code).json(error)
  }
});

router.post('/login', async (req, res, next) => {
  try {
    const email = await req.body.email;
    const password = await req.body.password;
    const user = new User({ email, password });
    await user.load();
    const token = _createToken(user);

    res.status(200).json({ user, token });
  } catch (error) {
    res.status(error.code).json(error)
  }
});

function _createToken(user) {
  return jwt.sign({ id: user.id }, config.jwt.key_secret, { expiresIn: '2h' });
}

router.put('/:idUser', authenticateToken, async (req, res, next) => {
  try {
    const id = req.params.idUser;
    const receiveData = req.body;
    
    const data = Object.assign({}, receiveData, { id });
    const user = new User(data);
    await user.update();

    res.status(204);
    res.end();
  } catch (error) {
    res.status(error.code).json(error)
  }
});

router.delete('/delete', authenticateToken, async (req, res, next) => {
  try {
    const email = await req.body.email;
    const password = await req.body.password;

    const user = new User({ email, password });
    await user.load();
    await user.remove();

    res.status(204);
    res.end();
  } catch (error) {
    res.status(error.code).json(error)
  }
});

module.exports = router;
