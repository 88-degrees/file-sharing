import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:file_sharing/data/model/receiver_model.dart';
import 'package:file_sharing/shared/widget/os_logo.dart';
import 'package:file_sharing/velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ConfirmConnectionDialogPage extends StatelessWidget {
  const ConfirmConnectionDialogPage({
    super.key,
    required this.receiverModel,
    required this.onCofirmation,
  });

  final ReceiverModel receiverModel;

  final void Function(bool) onCofirmation;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: AlertDialog(
          title: 'Confirm Receiver'.text.isIntrinsic.bold.xl.makeCentered(),
          content: [
            "Receiver Name: "
                .richText
                .center
                .withTextSpanChildren([receiverModel.host.textSpan.bold.make()])
                .isIntrinsic
                .makeCentered(),
            OSLogo(os: receiverModel.os),
            "Receiver IP: "
                .richText
                .center
                .withTextSpanChildren([receiverModel.ip.textSpan.bold.make()])
                .isIntrinsic
                .makeCentered(),
            "Receiver Port: "
                .richText
                .center
                .withTextSpanChildren(
                    [receiverModel.port.toString().textSpan.bold.make()])
                .isIntrinsic
                .makeCentered(),
            "Receiver OS: "
                .richText
                .center
                .withTextSpanChildren([receiverModel.os.textSpan.bold.make()])
                .isIntrinsic
                .makeCentered(),
            "Receiver Version: \n"
                .richText
                .center
                .withTextSpanChildren(
                    [receiverModel.version.textSpan.bold.make()])
                .isIntrinsic
                .makeCentered(),
            "\nwant to connect with you".text.bold.lg.isIntrinsic.make(),
          ].vStack().scrollVertical(),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.back();
                onCofirmation(true);
              },
              child: "Accept".text.green500.isIntrinsic.make(),
            ),
            ElevatedButton(
              onPressed: () {
                context.back();
                onCofirmation(false);
              },
              child: "Reject".text.red500.isIntrinsic.make(),
            )
          ],
        ),
      ),
    );
  }
}
