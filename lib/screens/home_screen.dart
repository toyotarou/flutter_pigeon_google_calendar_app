import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../extensions/extensions.dart';
import '../pigeons_api/calendar_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CalendarEvent> events = <CalendarEvent>[];

  String status = '読み込み中...';

  ///
  @override
  void initState() {
    super.initState();

    init();
  }

  ///
  Future<void> init() async {
    final PermissionStatus status = await Permission.calendar.status;

    print('初期状態: $status');

    final PermissionStatus result = await Permission.calendar.request();

    print('リクエスト結果: $result');

    if (!result.isGranted) {
      setState(() => this.status = 'カレンダー権限が必要です（現在の状態: $result）');

      return;
    }

    await loadEvents();
  }

  ///
  Future<void> loadEvents() async {
    try {
      final CalendarApi api = CalendarApi();

      final List<CalendarEvent> eventList = await api.getCalendarEvents();

      setState(() {
        final List<String> eventDateList = <String>[];
        for (final CalendarEvent element in eventList) {
          if (!eventDateList.contains(DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0).toString())) {
            events.add(element);

            eventDateList.add(DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0).toString());
          }
        }

        status = '取得成功';
      });
    } catch (e) {
      setState(() => status = 'エラー: $e');
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('カレンダー予定一覧')),
      body: events.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(status),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final PermissionStatus result = await Permission.calendar.request();
                      if (result.isGranted) {
                        await loadEvents();
                      } else {
                        setState(() => status = 'カレンダー権限が必要です（状態: $result）');
                      }
                    },
                    child: const Text('権限を再リクエスト'),
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                const CircleAvatar(),

                Divider(color: Colors.white.withValues(alpha: 0.2), thickness: 5),

                Expanded(child: displayEventList()),

                const SizedBox(height: 50),
              ],
            ),
    );
  }

  ///
  Widget displayEventList() {
    final List<Widget> list = <Widget>[];

    for (final CalendarEvent element in events) {
      list.add(
        SizedBox(
          width: context.screenSize.width,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(element.title ?? '無題'),
              Text('開始: ${DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0)}'),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
