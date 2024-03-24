import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:file_sharing/core/router/router.gr.dart';
import 'package:file_sharing/l10n/l10n.dart';
import 'package:file_sharing/shared/widget/custom_app_bar.dart';

@RoutePage(
  deferredLoading: true,
)
class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appActions: [
          IconButton(
            onPressed: () {
              context.navigateTo(const DownloadsRoute());
            },
            icon: const Icon(
              Icons.download_outlined,
            ),
            tooltip: context.l10n.actionDownloads,
          ),
          IconButton(
            onPressed: () {
              context.navigateTo(const SettingsRoute());
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: context.l10n.actionSettings,
          ),
        ],
      ),
      body: const AutoRouter(),
    );
  }
}
