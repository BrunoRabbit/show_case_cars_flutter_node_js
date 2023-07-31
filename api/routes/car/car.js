const TableCar = require('./table_car');
const ErrorGenerator = require('../../errors/error_generator');
const errorsDefault = require('../../errors/errors_messages');

class Car {
  constructor({ id, name, brand, model, photo, price }) {
    this.id = id;
    this.name = name;
    this.brand = brand;
    this.model = model;
    this.photo = photo;
    this.price = price;
  }

  async create() {
    this.validateFields();
    const result = await TableCar.insert({
      name: this.name,
      brand: this.brand,
      model: this.model,
      photo: this.photo,
      price: this.price,
    });

    this.id = result.id;
  }

  async load() {
    const foundCar = await TableCar.getId(this.id);
    this.name = foundCar.name;
    this.brand = foundCar.brand;
    this.model = foundCar.model;
    this.photo = foundCar.photo;
    this.price = foundCar.price;
  }

  async update() {
    const car = await TableCar.getId(this.id);
    const carData = ['name', 'brand', 'model', 'photo', 'price'];
    const dataToUpdate = {};
    
    for (const element of carData) {
      const value = this[element];
      if (value !== undefined && value !== null) {
        dataToUpdate[element] = value;
      }
    }
    if (!Object.keys(dataToUpdate).length) {
      throw new ErrorGenerator(400, errorsDefault.dataToUpdateNotRecived);
    }
  
    await TableCar.update(this.id, dataToUpdate);
  }

  remove() {
    return TableCar.remove(this.id);
  }

  validateFields() {
    const fields = ['name', 'brand', 'model', 'photo', 'price'];

    fields.forEach((field) => {
      const value = this[field];
      if (!value) {
        throw new ErrorGenerator(
          400,
          `${errorsDefault.invalidField}'${field}'`
        );
      }
    });
  }
}

module.exports = Car;
