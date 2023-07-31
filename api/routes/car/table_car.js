const Model = require('./model_car');
const { Sequelize } = require('sequelize');
const ErrorGenerator = require('../../errors/error_generator');
const errorsDefault = require('../../errors/errors_messages');

module.exports = {
  list(filter) {
    const shouldFilter = {
      where: { name: {[Sequelize.Op.like]: `%${filter.name}%`} },
      order: [['price', filter.price]]
    }
    if(!filter.name) {
      delete shouldFilter.where
    }
    if(!filter.price) {
      delete shouldFilter.order
    }
    return Model.findAll(shouldFilter);
  },

  insert(car) {
    return Model.create(car);
  },

  async getId(id) {
    const found = await Model.findOne({
      where: {
        id: id,
      },
    });

    if (!found) {
      throw new ErrorGenerator(400, errorsDefault.veichleNotFound);
    }

    return found;
  },

  update(id, dataToUpdate) {
    return Model.update(dataToUpdate, { where: { id: id } });
  },

  remove(id) {
    return Model.destroy({
      where: { id: id },
    });
  },
};
