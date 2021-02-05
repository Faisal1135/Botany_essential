import 'dart:io';

// import 'package:botany_essential/riverpod/providers.dart';
// import 'package:botany_essential/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/all.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:getwidget/components/loader/gf_loader.dart';
// import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class FlowerRecognizer extends StatefulWidget {
  static const routeName = "FlowerRecognizer";
  @override
  _FlowerRecognizerState createState() => _FlowerRecognizerState();
}

class _FlowerRecognizerState extends State<FlowerRecognizer> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;
  var picker = ImagePicker();

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/mobilenet.tflite",
        labels: "assets/labels.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // run prediction using TFLite on given image
  Future predict(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });
  }

  // send image to predict method selected from gallery or camera
  sendImage(File image) async {
    if (image == null) return;
    await predict(image);

    // get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));
  }

  // select image from gallery
  selectFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    sendImage(File(image.path));
  }

  // select image from camera
  selectFromCamera() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(File(image.path));
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(rcg) {
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("Could not recognize",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Prediction: " + _recognitions[0]['label'].toString().toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // gets called every time the widget need to re-render or build
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .85;
      finalH = _imageHeight * ratioH * .50;
    }

//    List<Widget> stackChildren = [];

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Flutter x TF-Lite",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: printValue(_recognitions),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: _image == null
                  ? Center(
                      child: Text("Select image from camera or gallery"),
                    )
                  : Center(
                      child: Image.file(_image,
                          fit: BoxFit.fill, width: finalW, height: finalH)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.redAccent,
                    child: FlatButton.icon(
                      onPressed: selectFromCamera,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.deepPurple,
                      label: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      color: Colors.tealAccent,
                      child: FlatButton.icon(
                        onPressed: selectFromGallery,
                        icon: Icon(
                          Icons.file_upload,
                          color: Colors.white,
                          size: 30,
                        ),
                        color: Colors.blueAccent,
                        label: Text(
                          "Gallery",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
// class FlowerRecognizer extends ConsumerWidget {
//   static const routeName = 'flower recognizer';

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _image = watch(imageNotifer.state);
//     final imageProv = context.read(imageNotifer);
//     final tfmodel = context.read(tfloadModel);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flower Ditection'),
//       ),
//       drawer: AppDrawer(),
//       body: tfmodel.when(
//         data: (str) => ListView(
//           children: [
//             Center(child: Text('Flower Identification')),
//             _image == null
//                 ? FaIcon(
//                     FontAwesomeIcons.tree,
//                     size: 200,
//                   )
//                 : Container(
//                     child: Image.asset(_image.path),
//                     height: MediaQuery.of(context).size.height * 0.4,
//                   ),
//             ButtonBar(
//               alignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RaisedButton.icon(
//                   onPressed: () async {
//                     await imageProv.cropImage(ImageSource.camera);
//                   },
//                   icon: Icon(Icons.camera),
//                   label: Text('Pick From Camera'),
//                 ),
//                 RaisedButton.icon(
//                   onPressed: () async =>
//                       await imageProv.cropImage(ImageSource.gallery),
//                   icon: Icon(Icons.photo_library),
//                   label: Text('Pick From Gallery'),
//                 ),
//                 RaisedButton.icon(
//                   onPressed: () => imageProv.clearImage(),
//                   icon: Icon(Icons.delete),
//                   label: Text('Clear'),
//                 ),
//               ],
//             )
//           ],
//         ),
//         loading: () => GFLoader(
//           type: GFLoaderType.circle,
//         ),
//         error: (e, s) => Text(
//           e.toString() + s.toString(),
//         ),
//       ),
//     );
//   }
// }
