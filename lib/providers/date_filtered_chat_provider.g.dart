// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_filtered_chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dateFilteredChatMessagesHash() =>
    r'eb74472ea344e71e0730e68045659f4d9a37fabd';

/// Provider that returns a stream of chat messages filtered by the selected date
///
/// Copied from [dateFilteredChatMessages].
@ProviderFor(dateFilteredChatMessages)
final dateFilteredChatMessagesProvider =
    AutoDisposeStreamProvider<List<ChatMessageModel>>.internal(
  dateFilteredChatMessages,
  name: r'dateFilteredChatMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dateFilteredChatMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DateFilteredChatMessagesRef
    = AutoDisposeStreamProviderRef<List<ChatMessageModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
