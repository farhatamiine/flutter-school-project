import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/FacePainter.dart';

class AiPage extends StatefulWidget {
  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  bool loading = true;
  bool processImage = false;
  ui.Image imageToPaint;
  List<Face> _faces;

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void _imageVisionWithDetection(ImageSource imageSource) async {
    setState(() {
      processImage = true;
    });

    //? Get Image From the Gallery
    final imageFile = await ImagePicker.pickImage(
      source: imageSource,
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
      processImage = false;
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
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.images,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    processImage
                        ? SpinKitCircle(
                            size: 30,
                            color: Color(0xff5c6bc0),
                          )
                        : Text(
                            "Select Image Source to begin",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                  ],
                )
              : FittedBox(
                  fit: BoxFit.cover,
                  child: processImage
                      ? SpinKitCircle(
                          size: 30,
                          color: Color(0xff5c6bc0),
                        )
                      : SizedBox(
                          width: imageToPaint.width.toDouble(),
                          height: imageToPaint.height.toDouble(),
                          child: FacePaint(
                            painter: SmilePainter(imageToPaint, _faces),
                          )),
                ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          animatedIconTheme: IconThemeData(size: 22.0),
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
                child: Icon(Icons.image),
                backgroundColor: Color(0xff5c6bc0),
                label: 'Gallery',
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
                onTap: () => _imageVisionWithDetection(ImageSource.gallery)),
            SpeedDialChild(
              child: Icon(Icons.photo_camera),
              backgroundColor: Color(0xff5c6bc0),
              label: 'Camera',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
              onTap: () => _imageVisionWithDetection(ImageSource.camera),
            ),
          ],
        ));
  }
}
