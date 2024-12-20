const express = require('express');
const resetPasswordController = require('../controllers/reset_password.controllers');
const authController = require('../controllers/auth.controllers');
const tokenController = require('../controllers/token.controllers');
const router = express.Router();

// Log and save the user
router.post('/login', authController.login);
router.post('/register', authController.register);

// Request a new password
router.post('/request-password-reset', resetPasswordController.requestPasswordToken);
router.post('/validate-token', resetPasswordController.validateToken);
router.post('/reset-password', resetPasswordController.resetPassword);

// Refresh the token
router.post('/refresh-token', tokenController.refreshToken);

router.get('/user', tokenController.authenticateToken, authController.getUser);



module.exports = router;