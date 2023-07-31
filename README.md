# EasyPermissionHandler Plugin v1.0.0

EasyPermissionHandler is a Flutter plugin that simplifies permission requests and checks with additional features, making it easier to handle permissions in your Flutter app.

## Features

- Handles permission requests and checks for a specific permission.
- Allows specifying whether the permission is mandatory or optional.
- Provides options to handle custom description dialogs for permission requests.
- Supports handling permanently denied permissions with customizable callbacks.
- Automatically resumes the app after showing permission dialogs for a better user experience.

## Installation

To use EasyPermissionHandler in your Flutter project, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_permission: ^1.0.0
```

## Usage

1. Import the `easy_permission` package in your Dart file:

```dart
import 'package:easy_permission/easy_permissions_handler.dart';
```

2. Create an instance of `EasyPermissionHandler` with required parameters:

```dart
Future<bool> isGranted() async{
  EasyPermissionHandler(
    permission: Permission.camera,
    isRequired: true,
    onResumed: () {
      // Handle app resuming after permission dialog is shown.
    },
    customDescriptionFuture: _showCustomDescriptionDialog(),
    onDeniedForeverFeature: _handleDeniedForever(),
  ).handlePermission();
}
```

3. Handle the permission based on your requirements:

```dart
Future<void> checkAndRequestPermission() async {
  bool isGranted = await permissionModule.handlePermission();

  if (isGranted) {
    // Permission is granted. Proceed with your app logic.
  } else {
    // Permission not granted or required. Handle the case accordingly.
  }
}
```

4. Optionally, handle the app resuming after permission dialog:

```dart
@override
void onResume() {
  super.onResume();
  permissionModule.handleOnResumed();
}
```

## Note

Make sure to add the required permissions to your AndroidManifest.xml and Info.plist files for Android and iOS, respectively.

For more information, refer to the [permission_handler](https://pub.dev/packages/permission_handler) package documentation.

## Contributions

Contributions are welcome! If you find any issues or want to enhance the functionality of the EasyPermissionHandler plugin, feel free to create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/georgesamirmansour/EasyPermission/blob/master/LICENSE) file for details.

## GitHub

The source code for the EasyPermission plugin can be found on GitHub: [EasyPermission Repository](https://github.com/georgesamirmansour/EasyPermission.git).
```

Please note that the `github` link provided is a placeholder and should be replaced with the actual link to your GitHub repository for the `EasyPermission` plugin.