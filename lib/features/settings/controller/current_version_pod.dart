import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/bootstrap.dart';
import 'package:package_info_plus/package_info_plus.dart';

final currentVersionPod = FutureProvider.autoDispose<String?>((ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  talker.log(packageInfo.toString());
  ref.keepAlive();
  return "v${packageInfo.version}+${packageInfo.buildNumber}";
});
