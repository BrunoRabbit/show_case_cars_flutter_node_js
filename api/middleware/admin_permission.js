const table_user = require("../routes/user/table_user");

async function isUserAdmin(req, res, next) {
    const foundUser = await table_user.getId(req.userId)
    if(foundUser.isAdmin) {
        return next();
    }
    return res.status(401).send('Unauthorized user');
}

module.exports = isUserAdmin;
