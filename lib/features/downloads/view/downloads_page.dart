import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:file_sharing/l10n/l10n.dart';
import 'package:file_sharing/velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.l10n.downloads.text.make(),
      ),
    );
  }
}
