import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/l10n/l10n.dart';

@RoutePage(
  deferredLoading: true,
)
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      checkUpdateAvailablePod,
      (previous, next) {
        if (next.value != null) {
          ref
              .read(autorouterProvider)
              .navigate(ChangelogRoute(updateModel: next.value));
        }
      },
    );
    return AutoTabsScaffold(
      routes: const [
        SendRoute(),
        ReceiveRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.arrow_upward_outlined),
              label: context.l10n.sendLbl,
            ),
            NavigationDestination(
              icon: const Icon(Icons.arrow_downward_outlined),
              label: context.l10n.receiveLbl,
            ),
          ],
        );
      },
    );
  }
}
