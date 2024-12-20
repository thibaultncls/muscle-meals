import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/focus_node_manager.dart';
import 'package:muscle_meals/models/key_manager.dart';
import 'package:muscle_meals/widgets/keyboard_overlay.dart';

part 'focus_event.dart';
part 'focus_state.dart';

class FocusBloc extends Bloc<FocusEvent, FocusState> {
  final FocusNodeManager nodeManager;
  final KeyManager keyManager;
  final BuildContext context;

  FocusBloc(
    this.nodeManager,
    this.keyManager,
    this.context,
  ) : super(FocusInitial()) {
    on<OnFocusEvent>(_onFocus);
    on<OnNextEvent>(_onNext);
    on<OnLastFocusEvent>(_onLast);
  }

  Future<void> _onFocus(OnFocusEvent event, Emitter<FocusState> emit) async {
    if (event.focusNode.hasFocus) {
      emit(HasFocusState());
    } else {
      emit(HasntFocusState());
    }
  }

  Future<void> _onNext(OnNextEvent event, Emitter<FocusState> emit) async {
    final nodeMap = {
      nodeManager.recipeNode: keyManager.prepTimeKey,
      nodeManager.prepTimeNode: keyManager.calorieKey,
      nodeManager.calorieNode: keyManager.macroKey,
      nodeManager.proteinNode: null,
      nodeManager.carbNode: null,
      nodeManager.fatNode: keyManager.ingredientKeys.isNotEmpty
          ? keyManager.ingredientKeys.first
          : null
    };

    final nodes = [
      nodeManager.recipeNode,
      nodeManager.prepTimeNode,
      nodeManager.calorieNode,
      nodeManager.proteinNode,
      nodeManager.carbNode,
      nodeManager.fatNode,
    ];

    for (var i = 0; i < nodes.length; i++) {
      if (nodes[i].hasFocus) {
        final nextNode = i < nodes.length - 1
            ? nodes[i + 1]
            : nodeManager.ingredientNodes.first;
        await _requestFocus(nextNode, nodeMap[nodes[i]]);
        return;
      }

      _loop(nodeManager.ingredientNodes, keyManager.ingredientKeys);

      if (nodeManager.ingredientNodes.last.hasFocus) {
        await _requestFocus(
            nodeManager.stepNodes.first, keyManager.stepKeys.first);
        return;
      }

      _loop(nodeManager.stepNodes, keyManager.stepKeys);

      if (nodeManager.stepNodes.last.hasFocus) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
          KeyboardOverlay.removeOverlay();
        }
      }
    }
  }

  Future<void> _onLast(OnLastFocusEvent event, Emitter<FocusState> emit) async {
    if (event.focusNode == nodeManager.stepNodes.last) {
      emit(LastFocusState());
    }
  }

  Future<void> _scrollable(GlobalKey key) async {
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 200), alignment: .5);
  }

  Future<void> _requestFocus(FocusNode node, [GlobalKey? key]) async {
    if (key != null) {
      await _scrollable(key);
      if (!context.mounted) return;
    }
    FocusScope.of(context).requestFocus(node);
  }

  void _loop(List<FocusNode> nodes, List<GlobalKey> keys) async {
    for (var i = 0; i < nodes.length - 1; i++) {
      final stepNode = nodes[i];
      if (stepNode.hasFocus) {
        await _requestFocus(nodes[i + 1], keys[i + 1]);
        return;
      }
    }
  }
}
