const Sequelize = require('sequelize')
const instance = require('../../db')

const columns = {
    name: {
        type: Sequelize.STRING,
        allowNull: false
    },
    brand: {
        type: Sequelize.STRING,
        allowNull: false
    },
    model: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    price: {
        type: Sequelize.FLOAT,
        allowNull: false,
    },
    photo: {
        type: Sequelize.STRING,
        allowNull: false,
    }
}

const setts = {
    freezeTableName: true,
    tableName: 'car',
    timestamps: false,
}

module.exports = instance.define('car', columns, setts)