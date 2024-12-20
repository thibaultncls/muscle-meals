import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:muscle_meals/models/result.dart';

class PickImageRepository {
  Future<Result> pickImage(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);

    if (returnedImage == null) {
      return ErrorResult('Aucune photo n\'a été séléctionné');
    }

    final selectedImage = File(returnedImage.path);
    return SuccessImageResult('Image séléctionnée avec succés',
        selectedImage: selectedImage);
  }
}
