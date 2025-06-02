import 'package:flutter/material.dart';

import '../../pigeons_api/calendar_api.dart';

class DeleteEventConfirmDialog extends StatelessWidget {
  const DeleteEventConfirmDialog({super.key, required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('予定の削除'),
      content: Text('${event.title} を削除しますか？'),
      actions: <Widget>[
        TextButton(child: const Text('キャンセル'), onPressed: () => Navigator.pop(context, false)),
        TextButton(child: const Text('削除'), onPressed: () => Navigator.pop(context, true)),
      ],
    );
  }
}
