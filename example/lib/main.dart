import 'package:easy_permission/easy_permission.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyPermission Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _requestCameraPermission(context);
          },
          child: Text('Request Camera Permission'),
        ),
      ),
    );
  }

  Future<void> _requestCameraPermission(BuildContext context) async {
    EasyPermission permissionModule = EasyPermission(
      permission: Permission.camera,
      isRequired: true,
      onResumed: () {
        print('App resumed after permission dialog.');
      },
      customDescriptionFuture: _showCustomDescriptionDialog(context),
      onDeniedForeverFeature: _handleDeniedForever(),
    );

    bool isGranted = await permissionModule.handlePermission();

    if (isGranted) {
      // Permission is granted. Proceed with camera logic.
      print('Camera permission granted. Proceeding...');
    } else {
      // Permission not granted or required. Handle the case accordingly.
      print('Camera permission not granted or required.');
    }
  }

  Future<bool> _showCustomDescriptionDialog(BuildContext context) async {
    // You can show your custom dialog here and return a Future<bool> to indicate if the dialog was shown.
    // For this example, we'll show a dummy dialog and wait for 2 seconds before returning true.
    bool isDismissed = false;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Camera Permission'),
          content: const Text('We need access to your camera to take photos.'),
          actions: [
            TextButton(
              onPressed: () {
                isDismissed = true;
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    return isDismissed;
  }

  Future<bool> _handleDeniedForever() async {
    // Here you can handle permanently denied permissions, like showing a dialog to open settings.
    // For this example, we'll return true to indicate that the dialog should be shown.

    return true;
  }
}
