import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_date_provider.g.dart';

/// Provider that tracks the currently selected date in the app
@riverpod
class SelectedDateNotifier extends _$SelectedDateNotifier {
  @override
  DateTime build() {
    return DateTime.now();
  }

  /// Update the selected date
  void updateSelectedDate(DateTime date) {
    state = date;
  }
}
