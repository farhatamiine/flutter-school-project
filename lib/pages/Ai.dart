import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/FacePainter.dart';

class AiPage extends StatefulWidget {
  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  bool loading = true;
  ui.Image imageToPaint;
  List<Face> _faces;

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void _imageVisionWithDetection() async {
    //? Get Image From the Gallery
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    //? Pass the image to FirebaseVisionImage
    final image = FirebaseVisionImage.fromFile(imageFile);

    //? Pass the image to FirebaseVision
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          enableLandmarks: true, mode: FaceDetectorMode.accurate),
    );
    final faces = await faceDetector.processImage(image);
    imageToPaint = await _loadImage(imageFile);

    setState(() {
      _faces = faces;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using AI"),
        leading: Icon(FontAwesomeIcons.brain),
      ),
      body: Center(
        child: loading
            ? Text("Press to select an Image")
            : FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: imageToPaint.width.toDouble(),
                  height: imageToPaint.height.toDouble(),
                  child: FacePaint(
                    painter: SmilePainter(imageToPaint, _faces),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Pick an Image',
        onPressed: _imageVisionWithDetection,
        child: Icon(FontAwesomeIcons.camera),
      ),
    );
  }
}
