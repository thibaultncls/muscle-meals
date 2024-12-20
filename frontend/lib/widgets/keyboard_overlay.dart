import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/focus/focus_bloc.dart';
import 'package:muscle_meals/widgets/input_done_view.dart';

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(
    BuildContext context,
  ) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(builder: (builderContext) {
      return Positioned(
          bottom: MediaQuery.of(builderContext).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: BlocProvider.value(
              value: context.read<FocusBloc>(), child: const InputDoneView()));
    });

    overlayState.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
