import 'package:flutter/material.dart';
import 'package:file_sharing/l10n/l10n.dart';
import 'package:file_sharing/velocity_x/velocity_x.dart';

class StartingServerView extends StatelessWidget {
  const StartingServerView({super.key});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      const CircularProgressIndicator.adaptive().p8(),
      context.l10n.settingUpServer.text.make().objectCenter(),
    ]
        .vStack(
          alignment: MainAxisAlignment.center,
        )
        .safeArea();
  }
}
