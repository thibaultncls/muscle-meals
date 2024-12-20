const jwt = require('jsonwebtoken');
const tokenUtils = require('../utils/token.utils');
const User = require('../models/User');
require('dotenv').config();
 

//Midlleware
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ message: 'Token manquant' });
    }

    jwt.verify(token, process.env.JWT_SECRET_KEY, (err, user) => {
        if (err) {
            return res.status(403).json({ message: 'Token invalide' });
        }
        console.log(user);
        req.user = user;
        next();
    });
}

const refreshToken = async (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ message: 'Token de rafraîchissement manquant' });
    }

    jwt.verify(token, process.env.JWT_REFRESH_SECRET_KEY, async (err, user) => {
        if (err) {
            return res.status(403).json({ message: 'Token de rafraîchissement invalide' });
        }
    
    if (user.email == null) {
        return res.status(404).json({ message: `L\'utilisateur n'existe plus, veuillez créer un nouveau compte` });
    }

    delete user.iat;
    delete user.exp;

    const id = user.id;
    const dbUser = await User.findById(id);

    const newAccessToken = tokenUtils.generateAccessToken(dbUser);
    const newRefreshToken = tokenUtils.generateRefreshToken(dbUser);


    res.status(200).json({ 
        message: 'Token rafraîchit', 
        accessToken: newAccessToken, 
        refreshToken: newRefreshToken,
        user: dbUser });
    });
}

module.exports = { authenticateToken,  refreshToken }