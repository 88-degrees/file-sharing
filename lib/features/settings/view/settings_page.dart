import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:file_sharing/velocity_x/velocity_x.dart';
import 'package:file_sharing/features/settings/view/widget/about_app_tile.dart';
import 'package:file_sharing/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:file_sharing/l10n/l10n.dart';
import 'package:file_sharing/shared/widget/app_locale_popup.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.l10n.settingsPage.text.make(),
      ),
      bottomNavigationBar: BottomSheet(
        onClosing: () {},
        builder: (context) => const AboutAppTile(),
        enableDrag: false,
        showDragHandle: false,
      ).safeArea(),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: context.l10n.changeLanguage.text.bold.make(),
            trailing: const AppLocalePopUp(),
          ),
          ListTile(
            title: context.l10n.switchTheme.text.bold.make(),
            trailing: const ThemeSegmentedBtn(),
          ),
        ],
      ),
    );
  }
}
