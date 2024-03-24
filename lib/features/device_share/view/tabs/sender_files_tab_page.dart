import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/data/model/sender_model.dart';
import 'package:file_sharing/features/device_share/controller/files_list_pods.dart';
import 'package:file_sharing/features/file_download_btn/view/file_download_btn.dart';
import 'package:file_sharing/l10n/l10n.dart';
import 'package:file_sharing/shared/helper/global_helper.dart';
import 'package:file_sharing/shared/riverpod_ext/asynvalue_easy_when.dart';

import 'package:file_sharing/velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SenderFilesTabPage extends ConsumerStatefulWidget {
  final SenderModel senderModel;
  const SenderFilesTabPage({super.key, required this.senderModel});

  @override
  ConsumerState<SenderFilesTabPage> createState() => _SenderFilesTabPageState();
}

class _SenderFilesTabPageState extends ConsumerState<SenderFilesTabPage>
    with GlobalHelper, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final filesAsync = ref.watch(senderfileListPod(widget.senderModel));
    final l10n = context.l10n;
    return filesAsync.easyWhen(
      data: (filePathsModel) {
        return [
          l10n
              .receiveShareFiles(filePathsModel.paths.length)
              .text
              .bold
              .lg
              .make()
              .p4(),
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(senderfileListPod(widget.senderModel));
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 60),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (mcontext, index) {
                  final filepath = filePathsModel.paths[index];
                  return ListTile(
                    title: filepath.file.name.text.xs.make(),
                    subtitle: "size: ${FileSize.getSize(filepath.file.size)}"
                        .toString()
                        .text
                        .xs
                        .make(),
                    trailing: FileDownloadBtn(
                      filepath: filepath,
                    ),
                    isThreeLine: true,
                  );
                },
                itemCount: filePathsModel.paths.length,
              ),
            ),
          )
        ].vStack();
      },
      onRetry: () {
        ref.invalidate(senderfileListPod(widget.senderModel));
      },
    );
  }
}
