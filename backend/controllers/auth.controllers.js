const User = require('../models/User');
const signInUtils = require('../utils/sign_in.utils');
const tokenUtils = require('../utils/token.utils');

const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        const user = await User.findOne({ email: email });
        if (!user) {
            return res.status(404).json({ message: 'Utilisateur introuvable' });
        }

        const isMatch = await user.comparePassword(password);

        if (isMatch) {
            const accessToken = tokenUtils.generateAccessToken(user);
            const refreshToken = tokenUtils.generateRefreshToken(user);
            return res.status(200).json({ message: 'Login successful', user, accessToken, refreshToken });
        } else {
            return res.status(400).json({ message: 'Mot de passe invalide' });
        }
    } catch(err) {
        return res.status(500).json({ message: 'Erreur serveur', error: err });
    }
};


// http://localhost:3000/register
// params => body : {email, password}
// status code => 200, 400, 500
const register = async (req, res) => {
    const {email, password} = req.body;
    console.log(req.body);

    try {
      const validationResult = signInUtils.validateEmailAndPassword(email, password);

      if (validationResult.isValid) {
        const user = User({
            email: email,
            password: password
        });
        await user.save();

        const accessToken = tokenUtils.generateAccessToken(user);
        const refreshToken = tokenUtils.generateRefreshToken(user);

        res.status(200).json({ message: 'Login successful', user, accessToken, refreshToken });
      } else {
        console.log(validationResult.message);
        res.status(400).json({ message: validationResult.message });
      }
    } catch(err) {
        console.log(`Message d'erreur : ${err}`);
        const errorCode = err['errorResponse']['code'];
        if (errorCode) {
            if (errorCode == 11000) {
                return res.status(500).json({ message: 'Cet email est déjà utilisé' });
            }
        }
        
        return res.status(500).json({ message: 'Erreur serveur', error: err });
        
    }
};

const getUser = async (req, res) => {
    const  user  = req.user;
    const id = user.id;

    try {
        const user = await User.findById(id);

        if (!user) {
            return res.status(404).json({ message: 'Utilisateur non trouvé' });
        }
        
        return res.status(200).json({ message: 'Utilisateur connecté', user });
    } catch (error) {
        return res.status(500).json({ message: `Erreur serveur : ${error}`});
    }
};

module.exports = {
    login,
    register,
    getUser
}