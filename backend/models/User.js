const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const Recipe = require('./Recipe');
const crypto = require('node:crypto');

const { Schema } = mongoose;

const UserSchema = new Schema({
    email: { 
        type: String, 
        unique: true, 
        lowercase: true, 
        trim: true, 
        required: true
    },
    name: {
        type: String,
        trim: true
    },
    password: {
        type: String, 
        required: true
    },
    resetPasswordToken: String,
    resetPasswordExpires: Date,
    myRecipies: [{type: Schema.ObjectId, ref: 'Recipe'}],
    favoriteRecipies: [{type: Schema.ObjectId, ref: 'Recipe'}],
}, { timestamps: true });

UserSchema.pre('save', async function(next) {
    if (this.isModified('password') || this.isNew) {
        const salt = await bcrypt.genSalt(10);
        this.password = await bcrypt.hash(this.password, salt);
    }
   next();
});

function generateNumericCode(lenght) {
    let code = '';
    for (let i = 0; i < lenght; i++) {
        const randomDigit = crypto.randomInt(0, 10);
        code += randomDigit.toString();
    }
    return code;
}

UserSchema.methods.comparePassword =  function(password) {
    return bcrypt.compare(password, this.password);
};

UserSchema.methods.compareToken = function(resetPasswordToken) {
    return bcrypt.compare(resetPasswordToken, this.resetPasswordToken);
};

UserSchema.methods.generateResetToken = async function()  {
    const token = generateNumericCode(6); // Generate a 6 digit code
    const salt = await bcrypt.genSalt(10);
    this.resetPasswordToken = await bcrypt.hash(token, salt);
    this.resetPasswordExpires = Date.now() + 3600000; // 1 hour
    await this.save();
    return token;
};

module.exports = mongoose.model('User', UserSchema);