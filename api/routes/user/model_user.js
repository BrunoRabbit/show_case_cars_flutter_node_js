const Sequelize = require('sequelize');
const instance = require('../../db');

const columns = {
  name: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  email: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
  },
  password: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  salt: {
    type: Sequelize.STRING,
    allowNull: true,
  },
  isAdmin: {
    type: Sequelize.BOOLEAN,
    allowNull: true,
    defaultValue: true,
  },
};

const setts = {
  freezeTableName: true,
  tableName: 'user',
  timestamps: false,
};

module.exports = instance.define('user', columns, setts);
