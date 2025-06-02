// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../home_screen.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../controllers//app_params/app_params_notifier.dart';
// import 'money_overlay.dart';

Future<void> CalendarAppDialog({
  required BuildContext context,
  required Widget widget,
  double paddingTop = 0,
  double paddingRight = 0,
  double paddingBottom = 0,
  double paddingLeft = 0,
  bool clearBarrierColor = false,
  bool? executeFunctionWhenDialogClose,

  String? from,
}) {
  // ignore: inference_failure_on_function_invocation
  return showDialog(
    context: context,
    barrierColor: clearBarrierColor ? Colors.transparent : Colors.blueGrey.withOpacity(0.3),
    builder: (_) {
      return Container(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight, bottom: paddingBottom, left: paddingLeft),
        child: Dialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: const EdgeInsets.all(30),
          child: widget,
        ),
      );
    },
    // ignore: always_specify_types
  ).then((value) {
    // ignore: use_if_null_to_convert_nulls_to_bools
    if (executeFunctionWhenDialogClose == true) {
      if (from == 'ScheduleInputAlert') {
        // ignore: inference_failure_on_instance_creation, use_build_context_synchronously, always_specify_types
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  });
}
