import 'package:flutter/material.dart';

import 'package:vibration/vibration.dart';
import 'package:provider/provider.dart';

import 'package:counter_application/providers.dart';

import 'package:counter_application/components/counter_components.dart';

import 'package:counter_application/pages/settings_page.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Vibration.vibrate(duration: 100);
          context.read<CounterProvider>().increment();
        },
        onLongPress: () {
          Vibration.vibrate(duration: 100);
          showDialog(
            context: context,
            builder: (_) => const CounterResetDialog(),
          );
        },
        child: const Center(
          child: CounterPanel(),
        ),
      ),
    );
  }
}
