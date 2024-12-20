const User = require('../models/User');
const utils = require('../utils/sign_in.utils');


const requestPasswordToken = async (req, res) => {
    const { email } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ message: 'Utilisateur introuvable' });
        }

        const token = await user.generateResetToken();

        await utils.sendResetEmail(user, token);

        res.status(200).json({ message: 'Code de vérification envoyé' });
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
};

const validateToken = async (req, res) => {
    const { email, token } = req.body;

    try {
        const user = await User.findOne({ 
            email,
            resetPasswordToken: { $exists: true },
            resetPasswordExpires: { $gt: Date.now() }
        });
        
        if (!user) {
            return res.status(404).json({ message: 'Code invalide ou expiré' });
        }

        const isValid = await user.compareToken(token);
        if (isValid) {
            return res.status(200).json({ message: 'Code valide' , user: user});
        }

        return res.status(400).json({ message: 'Code invalide ou expiré' });


    } catch (error) {
        return res.status(500).json({ message: `Erreur serveur ${error}` });
    }
}

const resetPassword = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(404).json({ message: 'Utilisateur introuvable' });
        }

        user.password = password;
        user.resetPasswordExpires = undefined;
        user.resetPasswordToken = undefined;

        await user.save();

        return res.status(200).json({ message: 'Mot de passe modifié' });
    } catch (error) {
        return res.status(500).json({ message: `Erreur serveur ${error}` });
    }
}

module.exports = {
    requestPasswordToken, 
    validateToken,
    resetPassword
}