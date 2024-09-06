import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:counter_application/providers.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final csprovider = context.watch<CounterSettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('文字色変化'),
            value: csprovider.counterColorChanges,
            onChanged: (bool value) {
              csprovider.setCounterColorChanges(value);
            },
          ),
          if (csprovider.counterColorChanges)
            ListTile(
              title: const Text('文字色変化のしきい値'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController controller = TextEditingController(
                      text: '${csprovider.counterColorChangesValue}',
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
                              csprovider.setCounterColorChangesValue(
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
