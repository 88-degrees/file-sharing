import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/data/model/update_model.dart';
import 'package:file_sharing/shared/api_client/dio/dio_client_provider.dart';
import 'package:file_sharing/shared/riverpod_ext/cancel_extensions.dart';

final getUpdateModelPod = FutureProvider.autoDispose<UpdateModel>(
  (ref) async {
    final dio = ref.watch(dioProvider(
        "https://api.github.com/repos/Shreemanarjun/file_sharing"));
    final result = await dio.get(
      '/releases/latest',
      cancelToken: ref.cancelToken(),
    );
    return UpdateModel.fromMap(result.data);
  },
  name: 'getUpdateModelPod',
);
