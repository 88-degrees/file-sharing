import 'package:file_sharing/device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';

typedef ScreenshotProcessor = Future<void> Function(
  BuildContext context,
  DeviceScreenshot screenshot,
);
