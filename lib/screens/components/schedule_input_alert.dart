import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers_mixin.dart';
import '../../extensions/extensions.dart';
import '../../pigeons_api/calendar_api.dart';
import '../parts/error_dialog.dart';

class ScheduleInputAlert extends ConsumerStatefulWidget {
  const ScheduleInputAlert({super.key});

  @override
  ConsumerState<ScheduleInputAlert> createState() => _ScheduleInputAlertState();
}

class _ScheduleInputAlertState extends ConsumerState<ScheduleInputAlert> with ControllersMixin<ScheduleInputAlert> {
  List<FocusNode> focusNodeList = <FocusNode>[];

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();

  ///
  @override
  void initState() {
    super.initState();

    // ignore: always_specify_types
    focusNodeList = List.generate(100, (int index) => FocusNode());
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('スケジュール登録'), SizedBox.shrink()],
              ),
              Divider(color: Colors.white.withValues(alpha: 0.4), thickness: 5),
              _displayInputParts(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            width: context.screenSize.width,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),

                TextField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: 'タイトル',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
                  focusNode: focusNodeList[0],
                  onTap: () => context.showKeyboard(focusNodeList[0]),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: descriptionEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: '内容',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
                  focusNode: focusNodeList[0],
                  onTap: () => context.showKeyboard(focusNodeList[0]),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: locationEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: '場所',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
                  focusNode: focusNodeList[0],
                  onTap: () => context.showKeyboard(focusNodeList[0]),
                ),

                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('START'), SizedBox.shrink()],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _showDP(flag: 'start');
                            },
                            child: Icon(Icons.calendar_month, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                          const SizedBox(width: 10),
                          Text(appParamState.selectedStartDate, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _showTP(flag: 'start');
                            },
                            child: Icon(Icons.timer, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                          const SizedBox(width: 10),
                          Text(appParamState.selectedStartTime, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('END'), SizedBox.shrink()],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _showDP(flag: 'end');
                            },
                            child: Icon(Icons.calendar_month, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                          const SizedBox(width: 10),
                          Text(appParamState.selectedEndDate, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _showTP(flag: 'end');
                            },
                            child: Icon(Icons.timer, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                          const SizedBox(width: 10),
                          Text(appParamState.selectedEndTime, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    _inputSchedule();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                  child: const Text('登録'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _showDP({required String flag}) async {
    final DateTime? selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 360)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black.withOpacity(0.1),
            canvasColor: Colors.black.withOpacity(0.1),
            cardColor: Colors.black.withOpacity(0.1),
            dividerColor: Colors.indigo,
            primaryColor: Colors.black.withOpacity(0.1),
            secondaryHeaderColor: Colors.black.withOpacity(0.1),
            dialogBackgroundColor: Colors.black.withOpacity(0.1),
            primaryColorDark: Colors.black.withOpacity(0.1),
            highlightColor: Colors.black.withOpacity(0.1),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      switch (flag) {
        case 'start':
          appParamNotifier.setSelectedStartDate(date: selectedDate.yyyymmdd);

        case 'end':
          appParamNotifier.setSelectedEndDate(date: selectedDate.yyyymmdd);
      }
    }
  }

  ///
  Future<void> _showTP({required String flag}) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (selectedTime != null) {
      final String time =
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

      switch (flag) {
        case 'start':
          appParamNotifier.setSelectedStartTime(time: time);

        case 'end':
          appParamNotifier.setSelectedEndTime(time: time);
      }
    }
  }

  ///
  Future<void> _inputSchedule() async {
    bool errFlg = false;

    if (titleEditingController.text.trim() == '' ||
        locationEditingController.text.trim() == '' ||
        appParamState.selectedStartDate.trim() == '' ||
        appParamState.selectedStartTime == '') {
      errFlg = true;
    }

    if (errFlg) {
      // ignore: always_specify_types
      Future.delayed(
        Duration.zero,
        () => error_dialog(
          // ignore: use_build_context_synchronously
          context: context,
          title: '登録できません。',
          content: '値を正しく入力してください。',
        ),
      );

      return;
    }

    DateTime start = DateTime.now();
    DateTime end = start.add(const Duration(hours: 1));

    if (appParamState.selectedStartDate != '' && appParamState.selectedStartTime != '') {
      final List<String> exDate = appParamState.selectedStartDate.split('-');
      final List<String> exTime = appParamState.selectedStartTime.split(':');

      start = DateTime(exDate[0].toInt(), exDate[1].toInt(), exDate[2].toInt(), exTime[0].toInt(), exTime[1].toInt());
    }

    if (appParamState.selectedEndDate != '' && appParamState.selectedEndTime != '') {
      final List<String> exDate = appParamState.selectedEndDate.split('-');
      final List<String> exTime = appParamState.selectedEndTime.split(':');

      end = DateTime(exDate[0].toInt(), exDate[1].toInt(), exDate[2].toInt(), exTime[0].toInt(), exTime[1].toInt());
    }

    final CalendarEvent event = CalendarEvent(
      title: titleEditingController.text.trim(),
      description: descriptionEditingController.text.trim(),
      location: locationEditingController.text.trim(),
      startTimeMillis: start.millisecondsSinceEpoch,
      endTimeMillis: end.millisecondsSinceEpoch,
    );

    final CalendarApi api = CalendarApi();

    // ignore: always_specify_types
    await api.addCalendarEvent(event).then((value) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    });
  }
}
