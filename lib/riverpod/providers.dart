import 'package:botany_essential/riverpod/state/imageProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tflite/tflite.dart';

final themeProvider = StateProvider<bool>((ref) {
  return true;
});

final imageNotifer = StateNotifierProvider<ImageNotiferProvider>((ref) {
  return ImageNotiferProvider();
});

final tfloadModel = FutureProvider<String>((ref) async {
  Tflite.close();

  try {
    String res;
    res = await Tflite.loadModel(
      model: "assets/model/mobilenet.tflite",
      labels: "assets/model/labels.txt",
    );
    print(res);
    return res;
  } on PlatformException {
    throw Exception("Failed to load the model");
  }
});
