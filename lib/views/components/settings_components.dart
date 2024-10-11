import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';

class SetThemeColorDialog extends ConsumerWidget {
  const SetThemeColorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).requireValue;
    final settingsNotifier = ref.read(settingsProvider.notifier);

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
  }
}

class SetColorChangeValueDialog extends ConsumerStatefulWidget {
  const SetColorChangeValueDialog({super.key, required this.initialValue});

  final int initialValue;

  @override
  ConsumerState<SetColorChangeValueDialog> createState() =>
      _SetColorChangeValueDialogState();
}

class _SetColorChangeValueDialogState
    extends ConsumerState<SetColorChangeValueDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return AlertDialog(
      title: const Text('しきい値'),
      content: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _controller,
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル')),
        TextButton(
            onPressed: () {
              settingsNotifier.setColorChangeValue(
                int.parse(_controller.text),
              );
              Navigator.of(context).pop();
            },
            child: const Text('決定')),
      ],
    );
  }
}
