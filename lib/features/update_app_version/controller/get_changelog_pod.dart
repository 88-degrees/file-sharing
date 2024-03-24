import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/shared/api_client/dio/dio_client_provider.dart';
import 'package:file_sharing/shared/riverpod_ext/cancel_extensions.dart';

final getChangeLogPod = FutureProvider.autoDispose<String>(
  (ref) async {
    final dio = ref.watch(dioProvider(
        "https://raw.githubusercontent.com/Shreemanarjun/file_sharing/main"));
    final result = await dio.get(
      '/CHANGELOG.md',
      cancelToken: ref.cancelToken(),
    );
    if (result.statusCode == 200) {
      return result.data.toString();
    } else {
      throw "Error getting changelog";
    }
  },
  name: 'getChangeLogPod',
);
