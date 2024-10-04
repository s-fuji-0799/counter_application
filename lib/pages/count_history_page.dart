import 'package:counter_application/components/count_list.dart';
import 'package:flutter/material.dart';

class CountHistoryPage extends StatelessWidget {
  const CountHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カウント履歴'),
      ),
      body: const CountListView(),
    );
  }
}
