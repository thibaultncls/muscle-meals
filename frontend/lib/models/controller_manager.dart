import 'package:flutter/material.dart';

class ControllerManager {
  final recipeNameController = TextEditingController();
  final prepTimeController = TextEditingController();
  final calorieController = TextEditingController();
  final proteinController = TextEditingController();
  final carbController = TextEditingController();
  final fatController = TextEditingController();
  final List<TextEditingController> ingredientControllers = [];
  final List<TextEditingController> stepControllers = [];

  ControllerManager() {
    ingredientControllers
        .addAll([TextEditingController(), TextEditingController()]);
    stepControllers.addAll([TextEditingController(), TextEditingController()]);
  }

  void dispose() {
    recipeNameController.dispose();
    proteinController.dispose();
    carbController.dispose();
    fatController.dispose();
    for (final controller in ingredientControllers) {
      controller.dispose();
    }
    for (final controller in stepControllers) {
      controller.dispose();
    }
    prepTimeController.dispose();
  }
}
