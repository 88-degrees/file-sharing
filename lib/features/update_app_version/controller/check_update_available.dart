import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/bootstrap.dart';
import 'package:file_sharing/data/model/update_model.dart';
import 'package:file_sharing/features/settings/controller/current_version_pod.dart';
import 'package:file_sharing/features/update_app_version/controller/check_update_version.dart';
import 'package:file_sharing/shared/helper/version.dart';

final checkUpdateAvailablePod = FutureProvider.autoDispose<UpdateModel?>(
  (ref) async {
    final updateModel = await ref.watch(getUpdateModelPod.future);
    final currentAppVersion =
        (await ref.watch(currentVersionPod.future))!.replaceFirst('v', '');
    final tagname = updateModel.name.replaceFirst('v', '');
    Version currentVersion = Version.parse(currentAppVersion);

    Version latestVersion = Version.parse(tagname);
    talker.debug("$currentVersion $latestVersion");

    /// updatemodel when update available

    if (currentVersion < latestVersion) {
      return updateModel;
    } else {
      return null;
    }
  },
  name: 'checkUpdateAvailablePod',
);
