import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('文字色変化'),
            value: settings.counterColorChanges,
            onChanged: (bool value) {
              ref.read(settingsProvider.notifier).setCounterColorChanges(value);
            },
          ),
          if (settings.counterColorChanges)
            ListTile(
              title: const Text('文字色変化のしきい値'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController controller = TextEditingController(
                      text: '${settings.counterColorChangesValue}',
                    );

                    // TODO: バリデーションつけて、コンポーネント切り出ししたい
                    return AlertDialog(
                      title: const Text('しきい値'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: controller,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('キャンセル')),
                        TextButton(
                            onPressed: () {
                              ref
                                  .read(settingsProvider.notifier)
                                  .setCounterColorChangesValue(
                                    int.parse(controller.text),
                                  );
                              Navigator.of(context).pop();
                            },
                            child: const Text('決定')),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
