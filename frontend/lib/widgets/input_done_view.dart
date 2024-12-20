import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/focus/focus_bloc.dart';
import 'package:muscle_meals/style/colors.dart';

class InputDoneView extends StatelessWidget {
  const InputDoneView({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
        width: double.infinity,
        color: const Color(0xFFD0D3D8),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: CupertinoButton(
              padding:
                  const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
              onPressed: () => context.read<FocusBloc>().add(OnNextEvent()),
              child: BlocBuilder<FocusBloc, FocusState>(
                builder: (context, state) {
                  return Text((state is LastFocusState) ? 'Terminé' : 'Suivant',
                      style: const TextStyle(
                          color: AppColors.blueOcean, fontSize: 18));
                },
              ),
            ),
          ),
        ));
  }
}
