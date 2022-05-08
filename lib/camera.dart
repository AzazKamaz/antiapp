import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen>
    with TickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _duration);
    scaleAnimation = _scale.animate(_animationController);
    offsetAnimation = _offset.animate(_animationController);

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  Uint8List? latestPhotoTaken;
  late final AnimationController _animationController;
  final Tween<double> _scale = Tween<double>(begin: 1, end: 0.5);
  final Tween<Offset> _offset =
      Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 1000));
  late final Animation<double> scaleAnimation;
  late final Animation<Offset> offsetAnimation;
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('anticamera'.tr())),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                CameraPreview(_controller),
                AnimatedBuilder(
                  animation: _animationController,
                  child: latestPhotoTaken == null
                      ? const SizedBox()
                      : Image.memory(latestPhotoTaken!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height),
                  builder: (context, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Transform.translate(
                      offset: offsetAnimation.value,
                      child: child!,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await askPermission()) {
            _replacementImage();

            latestPhotoTaken =
                await (await _controller.takePicture()).readAsBytes();
            setState(() {});
            _animationController.forward().then((value) {
              latestPhotoTaken = null;
              _animationController.value = 0;
              setState(() {});
            });
          } else {
            _showMaterialBanner(context);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<bool> askPermission() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      return true;
    } else {
      return false;
    }
  }

  void _replacementImage() async {
    final rawImage =
        (await rootBundle.load('assets/replacement.png')).buffer.asUint8List();

    final AssetEntity? _ = await PhotoManager.editor.saveImage(
      rawImage,
      title: 'temporary.png', // Affects EXIF reading.
      desc: 'antiapp',
    );
  }

  void _showMaterialBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        leading: const Icon(Icons.photo_album),
        content: Text('photo_access_required'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('ok'.tr()),
          ),
          TextButton(
            onPressed: () {
              PhotoManager.openSetting();
            },
            child: Text('open_settings'.tr()),
          ),
        ]));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('display_the_picture'.tr())),
      body: Image.file(File(imagePath)),
    );
  }
}
