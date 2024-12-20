import 'package:flutter/material.dart';

class KeyManager {
  final prepTimeKey = GlobalKey();
  final calorieKey = GlobalKey();
  final macroKey = GlobalKey();
  final List<GlobalKey> ingredientKeys = [];
  final List<GlobalKey> stepKeys = [];

  KeyManager() {
    ingredientKeys.addAll([GlobalKey(), GlobalKey()]);
    stepKeys.addAll([GlobalKey(), GlobalKey()]);
  }
}
