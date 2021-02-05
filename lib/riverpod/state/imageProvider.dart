import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotiferProvider extends StateNotifier<File> {
  ImageNotiferProvider() : super(null);
  final _piker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _piker.getImage(source: source);

    if (pickedFile != null) {
      state = File(pickedFile.path);
    }
  }

  clearImage() {
    state = null;
  }

  Future<void> cropImage(ImageSource source) async {
    if (state == null) {
      await getImage(source);
    }
    File cropped = await ImageCropper.cropImage(
      sourcePath: state.path,
    );
    state = cropped ?? state;
  }
}
