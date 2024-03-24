import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/bootstrap.dart';
import 'package:file_sharing/data/model/file_paths_model.dart';
import 'package:file_sharing/features/file_download_btn/state/file_download_state.dart';

import 'package:hyper_thread_downloader/hyper_thread_downloader.dart';

import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_info/platform_info.dart' as pinfo;

class FileDownloaderNotifier
    extends AutoDisposeFamilyAsyncNotifier<DownloadState, FilePath> {
  // CancelToken _cancelToken = CancelToken();
  // final _dio = Dio();
  final _md = HyperDownload();
  int _taskId = -1;

  Future<Directory> defaultDirectory() async {
    var directory = await pinfo.Platform.I.when(
      android: () async {
        var temp = Directory('/storage/emulated/0/Download/');
        (await temp.exists()) ? temp : await getApplicationDocumentsDirectory();
        return temp;
      },
      iOS: () async => await getApplicationDocumentsDirectory(),
      desktop: () async => await getDownloadsDirectory(),
      orElse: () async => await getTemporaryDirectory(),
    );
    return directory ?? Directory('/');
  }

  ///Make save path depend on platform
  Future<String> getSavePath() async {
    final Directory directory = await defaultDirectory();
    return '${directory.path}${Platform.pathSeparator}${arg.file.name}';
  }

  String get _url => "http://${arg.link}";

  @override
  FutureOr<DownloadState> build(FilePath arg) {
    ref.keepAlive();

    return DownloadState.initial();
  }

  Future<void> startDownload() async {
    try {
      state = AsyncData(DownloadState.downloading());
      final processor = pinfo.Platform.I.numberOfProcessors;
      await _md.startDownload(
          url: _url,
          savePath: await getSavePath(),
          threadCount: processor,
          fileSize: arg.file.size,
          prepareWorking: (done) {},
          downloadingLog: (log) {
            talker.log(log);
          },
          downloadProgress: ({
            required double progress,
            required double speed,
            required double remainTime,
            required int count,
            required int total,
          }) {
            talker.debug(
                "progress : $progress , speed : $speed, time: $remainTime");

            final currentState = state.value;
            if (currentState != null) {
              state = AsyncData(
                currentState.copyWith(
                  progress: Progress(
                    currentProgress: progress,
                    speed: speed,
                    remainTime: remainTime,
                  ),
                ),
              );
            }
          },
          downloadComplete: () {
            state = AsyncData(DownloadState.completed());
          },
          downloadFailed: (String reason) {
            talker.error(reason);
            state = AsyncData(DownloadState.error());
          },
          downloadTaskId: (int id) {
            talker.log('start task id: $id');
            _taskId = id;
          },
          workingMerge: (bool ret) {});
    } catch (e) {
      talker.error("Error downloading file: $e");
    }
  }

  void cancelDownload() {
    _md.taskEnd(id: _taskId);

    state = AsyncData(DownloadState.initial());
  }

  void pauseDownload() {
    _md.stopDownload(id: _taskId);

    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isPaused: true));
    }
  }

  Future<void> resumeDownload() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isPaused: false));
    }

    await startDownload();
  }

  void resetDownload() async {
    // _md.taskEnd(id: _taskId);
    state = AsyncData(DownloadState.initial());
    await startDownload();
  }

  void openFile() async {
    final path = utf8.decode(
      (await getSavePath()).codeUnits,
      allowMalformed: true,
    );
    if (await File(path).exists()) {
      final result = await OpenAppFile.open(
        path,
        locate: true,
      );
      // if there is any error , open the downloaded directory
      if (result.type == ResultType.error) {
        await OpenAppFile.open(
          (await defaultDirectory()).path,
          locate: true,
        );
      }
    } else {
      startDownload();
    }
  }
}
