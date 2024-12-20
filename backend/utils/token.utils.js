const jwt = require('jsonwebtoken');
require('dotenv').config();

const secretKey = process.env.JWT_SECRET_KEY;

const refreshTokenSecretKey = process.env.JWT_REFRESH_SECRET_KEY;

const generateAccessToken = (user) => {
    return jwt.sign({ id: user._id, email: user.email }, secretKey, { expiresIn: '15min' });
}

const generateRefreshToken = (user) => {
    return jwt.sign({ id: user._id, email: user.email }, refreshTokenSecretKey, { expiresIn: '7d' });
}


module.exports = {  generateAccessToken, generateRefreshToken }
