const mongoose = require('mongoose');
const { Schema } = mongoose;

const RecipeSchema = new Schema({
    images: [{
        type: String,
    }],
    ingredients: [{
        name: {
            type: String,
            required: true
        },
        quantity: {
            type: String,
            required: true
        }
    }],
    steps: {
        type: [String],
        required: true
    },
    nutrition: {
        calories: {
            type: Number,
            required: true
        },
        proteins: {
            type: Number,
            required: true
        },
        fats: {
            type: Number,
            required: true
        },
        carbohydrates: {
            type: Number,
            required: true
        },
        preparationTime: {
            type: Number
        },
        difficultyLevel: {
            type: Number,
            min: 1,
            max: 3,
            required: true
        }
    }
}, {timestamps: true});

const Recipe = mongoose.model('Recipe', RecipeSchema);

module.exports = Recipe;