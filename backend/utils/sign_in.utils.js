const crypto = require('node:crypto');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');
require('dotenv').config();

function validateEmailAndPassword(email, password) {
    // Expression régulière pour valider l'email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    // Expression régulière pour valider le mot de passe
    // Au moins 8 caractères, une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial
    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$/;
  
    if (!emailRegex.test(email)) {
      return { isValid: false, message: 'Invalid email format' };
    }
  
    if (!passwordRegex.test(password)) {
      console.log(password);
      return { isValid: false, message: 'Password must be at least 8 characters long, contain a capital letter, a lowercase letter, a number, and a special character' };
    }
  
    return { isValid: true, message: 'Email and password are valid' };
  }


  const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS
    },
  
  });

  const sendResetEmail = async (user, code) => {
    const mailOption = {
      to: user.email,
      from: process.env.EMAIL_USER,
      subject: 'Code de vérification',
      text: `Votre code de vérification est ${code}.\n\n` +
      `Entrez ce code dans l'application pour vérifier votre identité et modifier votre mot de passe.\n`
    };

    await transporter.sendMail(mailOption);
  };

  

  module.exports = {
    validateEmailAndPassword,
    sendResetEmail,
  }