part of 'pick_image_bloc.dart';

sealed class PickImageState extends Equatable {
  const PickImageState();

  @override
  List<Object> get props => [];
}

final class PickImageInitial extends PickImageState {}

final class UpdateImageFromGalleryLoadingState extends PickImageState {}

final class UpdateImageFromCameraLoadingState extends PickImageState {}

final class UpdateImageSuccesfulState extends PickImageState {
  final File file;

  const UpdateImageSuccesfulState(this.file);

  @override
  List<Object> get props => [file];
}

final class UpdateImageFailureState extends PickImageState {}
