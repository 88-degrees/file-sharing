import 'dart:io';
import 'dart:ui';

import 'package:path/path.dart';

import 'processor.dart';

/// Saves the received screenshots to the given [directory].
///
/// The output file image format is `<deviceId>_<timestamp>.<png|bmp>`.
ScreenshotProcessor screenshotAsFiles(Directory directory) {
  return (context, screenshot) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = () {
      if (screenshot.format case ImageByteFormat.png) {
        return '.png';
      } else if (screenshot.format case ImageByteFormat.rawUnmodified || ImageByteFormat.rawRgba) {
        return '.bmp';
      } else if (screenshot.format case ImageByteFormat.rawStraightRgba) {
      }
    }();
    final file = File(
      join(
        directory.path,
        '${screenshot.device.identifier}_$timestamp$extension',
      ),
    );

    await file.writeAsBytes(screenshot.bytes);
  };
}
