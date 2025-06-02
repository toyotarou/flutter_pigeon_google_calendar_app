import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/controllers_mixin.dart';
import '../extensions/extensions.dart';
import '../pigeons_api/calendar_api.dart';
import 'components/schedule_input_alert.dart';
import 'parts/calendar_app_dialog.dart';
import 'parts/delete_event_confirm.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with ControllersMixin<HomeScreen> {
  List<CalendarEvent> events = <CalendarEvent>[];

  String status = '読み込み中...';

  List<GlobalKey> globalKeyList = <GlobalKey<State<StatefulWidget>>>[];

  ///
  @override
  void initState() {
    super.initState();

    // ignore: always_specify_types
    globalKeyList = List.generate(3000, (int index) => GlobalKey());

    init();
  }

  ///
  Future<void> init() async {
    // final PermissionStatus status = await Permission.calendar.status;

    final PermissionStatus result = await Permission.calendar.request();

    if (!result.isGranted) {
      setState(() => status = 'カレンダー権限が必要です（現在の状態: $result）');

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
            final int year = DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0).year;

            if (year >= 2020) {
              events.add(element);
            }

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
      appBar: AppBar(
        title: const Text('カレンダー予定一覧'),

        actions: <Widget>[
          IconButton(
            onPressed: () {
              // ignore: inference_failure_on_instance_creation, use_build_context_synchronously, always_specify_types
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(Icons.refresh),
          ),

          IconButton(
            onPressed: () {
              CalendarAppDialog(
                context: context,
                widget: const ScheduleInputAlert(),
                executeFunctionWhenDialogClose: true,
                from: 'ScheduleInputAlert',
              );
            },
            icon: const Icon(Icons.input),
          ),
        ],
      ),
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
                const SizedBox(height: 10),

                displayYearList(),

                Expanded(child: displayEventList()),

                const SizedBox(height: 50),
              ],
            ),
    );
  }

  ///
  Widget displayYearList() {
    final List<Widget> list = <Widget>[];

    final List<int> yearList = <int>[];
    for (final CalendarEvent element in events) {
      final int year = DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0).year;

      if (!yearList.contains(year)) {
        yearList.add(year);
      }
    }

    for (final int element in yearList) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () => scrollToIndex(element),

            child: CircleAvatar(child: Text(element.toString(), style: const TextStyle(fontSize: 12))),
          ),
        ),
      );
    }

    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: list),
      ),
    );
  }

  ///
  Widget displayEventList() {
    final List<Widget> list = <Widget>[];

    final CalendarApi api = CalendarApi();

    int keepYear = 0;

    for (final CalendarEvent element in events) {
      final int year = DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0).year;

      if (keepYear != year) {
        list.add(
          Container(
            key: globalKeyList[year],
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('$year'), const SizedBox.shrink()],
              ),
            ),
          ),
        );
      }

      list.add(
        Container(
          width: context.screenSize.width,

          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
          ),

          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(element.title ?? '無題'),
                    Text('開始: ${DateTime.fromMillisecondsSinceEpoch(element.startTimeMillis ?? 0)}'),
                  ],
                ),
              ),

              IconButton(
                onPressed: () async {
                  final bool? confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => DeleteEventConfirmDialog(event: element),
                  );

                  // ignore: use_if_null_to_convert_nulls_to_bools
                  if (confirm == true && element.id != null) {
                    await api.deleteCalendarEvent(element.id!);

                    if (mounted) {
                      // ignore: inference_failure_on_instance_creation, use_build_context_synchronously, always_specify_types
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }
                  }
                },
                icon: Icon(Icons.delete, color: Colors.white.withValues(alpha: 0.4)),
              ),
            ],
          ),
        ),
      );

      keepYear = year;
    }

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 12),
        child: Column(children: list),
      ),
    );
  }

  ///
  Future<void> scrollToIndex(int index) async {
    final BuildContext target = globalKeyList[index].currentContext!;

    await Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 1000));
  }
}
