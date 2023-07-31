import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

/// A class to simplify permission requests and checks with additional features.
class EasyPermissionHandler {
  final Permission permission;
  final bool isRequired;
  final Future<bool>? onDeniedForeverFeature;
  final Future<bool>? customDescriptionFuture;
  final VoidCallback onResumed;

  /// Creates an instance of `EasyPermissionHandler`.
  ///
  /// The `permission` parameter is the permission to handle.
  /// The `isRequired` parameter determines if the permission is mandatory or optional.
  /// The `onResumed` parameter is a callback that is called when the app resumes after the permission dialog is shown.
  /// The `customDescriptionFuture` parameter is an optional future to show a custom dialog with permission description.
  /// The `onDeniedForeverFeature` parameter is an optional future to handle permanently denied permissions.
  EasyPermissionHandler({
    required this.permission,
    required this.isRequired,
    required this.onResumed,
    this.customDescriptionFuture,
    this.onDeniedForeverFeature,
  });

  /// Handles the permission based on its status and options set.
  ///
  /// It checks the status of the permission and handles permission scenarios
  /// like granted, limited, denied, and permanently denied based on the options set.
  ///
  /// Returns true if the permission is granted, false otherwise.
  Future<bool> handlePermission() async {
    if (await _permissionGranted || await _permissionLimited) {
      return true;
    } else if (await _permissionDenied) {
      return _handleRequestPermission;
    } else if (onDeniedForeverFeature != null) {
      if (isRequired) {
        return _handleOnDeniedForEver;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// Handles the app resuming after a permission dialog is shown.
  ///
  /// It checks the status of the permission after the app resumes and handles scenarios
  /// like permanently denied, granted, and still denied based on the permission status.
  ///
  /// Returns true if the permission is granted, false otherwise.
  Future<bool> handleOnResumed() async {
    if (await _deniedForever) {
      return _handleOnDeniedForEver;
    } else if (await _permissionGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> get _handleOnDeniedForEver async {
    if (await _deniedForever) {
      final showSettingDialog = await onDeniedForeverFeature;
      if (showSettingDialog ?? false) {
        await openAppSettings();
        onResumed();
      }
      return false;
    } else {
      return true;
    }
  }

  Future<bool> get _handleRequestPermission async {
    if (customDescriptionFuture != null) {
      return _handleDescriptionWidgetAndShowPermission;
    } else {
      return _requestPermission;
    }
  }

  Future<bool> get _requestPermission async {
    final request = await permission.request();
    return request.isGranted || request.isLimited;
  }

  Future<bool> get _handleDescriptionWidgetAndShowPermission async {
    final dialogShowed = await customDescriptionFuture;
    if (dialogShowed ?? false) {
      return _requestPermission;
    } else {
      return false;
    }
  }

  Future<bool> get _permissionDenied => permission.isDenied;

  Future<bool> get _permissionGranted => permission.isGranted;

  Future<bool> get _permissionLimited => permission.isLimited;

  Future<bool> get _deniedForever => permission.isPermanentlyDenied;
}
