// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodLogRepositoryHash() => r'a8fb66c36a2f16e5ad530f99d1af7fc37c00b95f';

/// See also [foodLogRepository].
@ProviderFor(foodLogRepository)
final foodLogRepositoryProvider =
    AutoDisposeProvider<FoodLogRepository>.internal(
  foodLogRepository,
  name: r'foodLogRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodLogRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodLogRepositoryRef = AutoDisposeProviderRef<FoodLogRepository>;
String _$selectedDateFoodLogsHash() =>
    r'6b5c879d70156117f558a026727cfa8260d94ba8';

/// See also [selectedDateFoodLogs].
@ProviderFor(selectedDateFoodLogs)
final selectedDateFoodLogsProvider =
    AutoDisposeFutureProvider<List<FoodAnalysis>>.internal(
  selectedDateFoodLogs,
  name: r'selectedDateFoodLogsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDateFoodLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedDateFoodLogsRef
    = AutoDisposeFutureProviderRef<List<FoodAnalysis>>;
String _$remainingCaloriesHash() => r'0fd100ea05692547dfdf41adcd1ee92349110e39';

/// See also [remainingCalories].
@ProviderFor(remainingCalories)
final remainingCaloriesProvider = AutoDisposeProvider<int>.internal(
  remainingCalories,
  name: r'remainingCaloriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remainingCaloriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemainingCaloriesRef = AutoDisposeProviderRef<int>;
String _$caloriesEntryNotifierHash() =>
    r'7020381ddec6c3233b3329645a3895dd2b51219b';

/// See also [CaloriesEntryNotifier].
@ProviderFor(CaloriesEntryNotifier)
final caloriesEntryNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CaloriesEntryNotifier, CaloriesEntryModel>.internal(
  CaloriesEntryNotifier.new,
  name: r'caloriesEntryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$caloriesEntryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CaloriesEntryNotifier = AutoDisposeAsyncNotifier<CaloriesEntryModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
