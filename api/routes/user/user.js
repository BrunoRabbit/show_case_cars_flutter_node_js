const TableUser = require('./table_user');
const { randomBytes } = require('crypto');
const CryptoJS = require('crypto-js');
const ErrorGenerator = require('../../errors/error_generator');
const errorsDefault = require('../../errors/errors_messages');

function encryptWithSalt(password, salt) {
  return CryptoJS.AES.encrypt(password, salt).toString();
}

function decryptWithSalt(password, salt) {
  const bytes = CryptoJS.AES.decrypt(password, salt);
  return bytes.toString(CryptoJS.enc.Utf8).toString();
}

class User {
  constructor({ id, name, password, email }) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.password = password;
  }

  async create() {
    const salt = randomBytes(16).toString('hex');
    this.validateFields();

    if (this.email) {
      const findUserByEmail = await TableUser.getEmail(this.email, false);

      if (findUserByEmail && findUserByEmail.email === this.email) {
        throw new ErrorGenerator(400, errorsDefault.emailUsed);
      }
    }

    const result = await TableUser.insert({
      name: this.name,
      email: this.email,
      password: encryptWithSalt(this.password, salt),
      salt: salt,
    });

    this.id = result.id;
  }

  async load() {
    const foundUser = await TableUser.getEmail(this.email, true);
    this.validateUser(this.password, foundUser.salt, foundUser.password);
    this.isAdmin = foundUser.isAdmin;
    this.name = foundUser.name;
    this.email = foundUser.email;
    this.password = foundUser.password;
    this.id = foundUser.id;
  }

  async update() {
    const user = await TableUser.getId(this.id);

    if (this.email) {
      const findUserByEmail = await TableUser.getEmail(this.email, false);

      if (findUserByEmail && findUserByEmail.id !== this.id) {
        throw new ErrorGenerator(400, errorsDefault.emailUsed);
      }
    }

    const updatableAttributes = ['name', 'password', 'email'];
    const dataToUpdate = {};

    for (const attribute of updatableAttributes) {
      const value = this[attribute];

      if (value !== undefined) {
        if (!value) {
          dataToUpdate[attribute] = user[attribute];
        } else {
          dataToUpdate[attribute] = value;
        }
        if (attribute === 'password') {
          const passwordHashed = encryptWithSalt(value, user.salt);
          dataToUpdate[attribute] = passwordHashed;
        }
      }
    }
    console.log(dataToUpdate);
    if (!Object.keys(dataToUpdate).length) {
      throw new ErrorGenerator(400, errorsDefault.dataToUpdateNotRecived);
    }

    await TableUser.update(this.id, dataToUpdate);
  }

  remove() {
    return TableUser.remove(this.email);
  }

  validateFields() {
    const fields = ['name', 'password', 'email'];

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
  validateUser(password, salt, passwordHashed) {
    if (password === decryptWithSalt(passwordHashed, salt)) {
      return true;
    } else {
      throw new ErrorGenerator(400, errorsDefault.userLoginFail);
    }
  }
}

module.exports = User;
