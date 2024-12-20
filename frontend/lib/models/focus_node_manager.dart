import 'package:flutter/material.dart';

class FocusNodeManager {
  final recipeNode = FocusNode();
  final prepTimeNode = FocusNode();
  final calorieNode = FocusNode();
  final proteinNode = FocusNode();
  final carbNode = FocusNode();
  final fatNode = FocusNode();
  final List<FocusNode> ingredientNodes = [];
  final List<FocusNode> stepNodes = [];

  FocusNodeManager() {
    ingredientNodes.addAll([FocusNode(), FocusNode()]);
    stepNodes.addAll([FocusNode(), FocusNode()]);
  }

  void dispose() {
    recipeNode.dispose();
    prepTimeNode.dispose();
    calorieNode.dispose();
    proteinNode.dispose();
    carbNode.dispose();
    fatNode.dispose();
    for (final node in ingredientNodes) {
      node.dispose();
    }
    for (final node in stepNodes) {
      node.dispose();
    }
  }
}
