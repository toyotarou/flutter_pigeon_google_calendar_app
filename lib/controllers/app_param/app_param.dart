import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_param.freezed.dart';

part 'app_param.g.dart';

@freezed
class AppParamState with _$AppParamState {
  const factory AppParamState({
    @Default('') String selectedStartDate,
    @Default('') String selectedStartTime,
    @Default('') String selectedEndDate,
    @Default('') String selectedEndTime,
  }) = _AppParamState;
}

@Riverpod(keepAlive: true)
class AppParam extends _$AppParam {
  ///
  @override
  AppParamState build() => const AppParamState();

  ///
  void setSelectedStartDate({required String date}) => state = state.copyWith(selectedStartDate: date);

  ///
  void setSelectedStartTime({required String time}) => state = state.copyWith(selectedStartTime: time);

  ///
  void setSelectedEndDate({required String date}) => state = state.copyWith(selectedEndDate: date);

  ///
  void setSelectedEndTime({required String time}) => state = state.copyWith(selectedEndTime: time);
}
