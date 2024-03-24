import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/data/model/file_paths_model.dart';
import 'package:file_sharing/features/file_download_btn/controller/notifier/file_download_notifier.dart';
import 'package:file_sharing/features/file_download_btn/state/file_download_state.dart';

final fileDownloaderPod = AsyncNotifierProvider.autoDispose
    .family<FileDownloaderNotifier, DownloadState, FilePath>(
        FileDownloaderNotifier.new);
