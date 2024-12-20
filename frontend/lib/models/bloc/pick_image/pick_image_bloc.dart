import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muscle_meals/models/repository/pick_image_repository.dart';
import 'package:muscle_meals/models/result.dart';

part 'pick_image_event.dart';
part 'pick_image_state.dart';

class PickImageBloc extends Bloc<PickImageEvent, PickImageState> {
  final PickImageRepository _pickImageRepository;
  PickImageBloc(this._pickImageRepository) : super(PickImageInitial()) {
    on<ChooseInGaleryEvent>(_pickImageGallery);

    on<TakePhotoEvent>(_pickImageFromCamera);
  }
  Future<void> _pickImageGallery(
      ChooseInGaleryEvent event, Emitter<PickImageState> emit) async {
    emit(UpdateImageFromGalleryLoadingState());
    final result = await _pickImageRepository.pickImage(ImageSource.gallery);

    if (result is ErrorResult) {
      emit(UpdateImageFailureState());
    } else if (result is SuccessImageResult) {
      emit(UpdateImageSuccesfulState(result.selectedImage));
    }
  }

  Future<void> _pickImageFromCamera(
      TakePhotoEvent event, Emitter<PickImageState> emit) async {
    emit(UpdateImageFromCameraLoadingState());
    final result = await _pickImageRepository.pickImage(ImageSource.camera);

    if (result is ErrorResult) {
      emit(UpdateImageFailureState());
    } else if (result is SuccessImageResult) {
      emit(UpdateImageSuccesfulState(result.selectedImage));
    }
  }
}
