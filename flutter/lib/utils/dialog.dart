import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/pick_image/pick_image_bloc.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/widgets/progress_indicator.dart';

class DialogUtils {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text(message),
            actions: [
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'OK',
                    style: AppTheme.textOutlinedButtonTheme,
                  ))
            ],
          );
        });
  }

  static void showImageSourceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<PickImageBloc>(),
            child: BlocListener<PickImageBloc, PickImageState>(
              listener: (context, state) {
                if (state is UpdateImageSuccesfulState) {
                  Navigator.pop(context);
                }
              },
              child: Dialog(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        child: Text(
                          'Ajouter une photo',
                          style: TextStyle(
                              color: AppColors.charcoalBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const Divider(),
                    BlocBuilder<PickImageBloc, PickImageState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: (state is UpdateImageFromGalleryLoadingState)
                              ? null
                              : () {
                                  context
                                      .read<PickImageBloc>()
                                      .add(ChooseInGaleryEvent());
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is UpdateImageFromGalleryLoadingState)
                                ? const CustomProgressIndicator()
                                : const Text(
                                    'A partir de la galerie',
                                    style: TextStyle(
                                        color: AppColors.secondaryText),
                                  ),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    BlocBuilder<PickImageBloc, PickImageState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: (state is UpdateImageFromCameraLoadingState)
                              ? null
                              : () => context
                                  .read<PickImageBloc>()
                                  .add(TakePhotoEvent()),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 20, left: 8, right: 8),
                            child: (state is UpdateImageFromCameraLoadingState)
                                ? const CustomProgressIndicator()
                                : const Text(
                                    'A partir de l\'appareil photo',
                                    style: TextStyle(
                                        color: AppColors.secondaryText),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
