import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final settings = ref.watch(settingsProvider);

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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController controller = TextEditingController(
                        text: '${settings.colorChangeValue}',
                      );

                      // TODO: バリデーションつけて、コンポーネント切り出ししたい
                      return AlertDialog(
                        title: const Text('しきい値'),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: controller,
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('キャンセル')),
                          TextButton(
                              onPressed: () {
                                settingsNotifier.setColorChangeValue(
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
            const SettingsTitle('全体設定'),
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('テーマカラー設定'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('テーマカラー選択'),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          height: 200,
                          child: BlockPicker(
                            availableColors: const [
                              Colors.red,
                              Colors.pink,
                              Colors.purple,
                              Colors.deepPurple,
                              Colors.indigo,
                              Colors.blue,
                              Colors.lightBlue,
                              Colors.cyan,
                              Colors.teal,
                              Colors.green,
                              Colors.lightGreen,
                              Colors.lime,
                              Colors.yellow,
                              Colors.amber,
                              Colors.orange,
                              Colors.deepOrange,
                              Colors.brown,
                            ],
                            pickerColor: settings.themeColor,
                            onColorChanged: (value) {
                              settingsNotifier.setThemeColor(value);
                            },
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('決定'),
                        ),
                      ],
                    );
                  },
                );
              },
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
