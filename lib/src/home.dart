import 'package:flutter/material.dart';
import 'package:zds_flutter/zds_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Zeta object contains custom theme data.
    final zeta = Zeta.of(context);
    return Scaffold(
      appBar: ZdsAppBar(
        title: const Text('App template'),
        color: ZdsTabBarColor.basic,
        leading: IconButton(
          icon: Icon(ZdsIcons.menu, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () {},
        ),
        actions: [
          const Text('Dark Mode: '),
          Switch(
            value: zeta.brightness == Brightness.dark,
            onChanged: (x) {
              ZetaProvider.of(context).updateThemeMode(x ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ],
      ),
      floatingActionButton: const ZdsFloatingActionButton(icon: Icon(ZdsIcons.action)),
      body: Center(
        child: ZdsButton.filled(
          onTap: () {},
          child: const Text('Get Started!'),
        ),
      ),
    );
  }
}
