import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';
import 'package:counter_application/views/components/settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final settings = ref.watch(settingsProvider).requireValue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SettingsTitle('カウンター設定'),
            SwitchListTile(
              secondary: const Icon(Icons.change_circle_outlined),
              title: const Text('文字色変化'),
              value: settings.changeColor,
              onChanged: (bool value) {
                settingsNotifier.setChangeColor(value);
              },
            ),
            if (settings.changeColor)
              ListTile(
                leading: const Icon(Icons.numbers_outlined),
                title: const Text('文字色変化のしきい値'),
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => SetColorChangeValueDialog(
                    initialValue: settings.colorChangeValue,
                  ),
                ),
              ),
            const SettingsTitle('全体設定'),
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('テーマカラー設定'),
              onTap: () => showDialog(
                context: context,
                builder: (_) => const SetThemeColorDialog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
