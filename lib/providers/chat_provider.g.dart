// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoadingHash() => r'32359d429ace8fe743a061bb0da60bb0d59120d2';

/// See also [isLoading].
@ProviderFor(isLoading)
final isLoadingProvider = AutoDisposeProvider<bool>.internal(
  isLoading,
  name: r'isLoadingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsLoadingRef = AutoDisposeProviderRef<bool>;
String _$chatLoadingHash() => r'71d009db19cb84a5b19d16524f589ba79722fc26';

/// See also [chatLoading].
@ProviderFor(chatLoading)
final chatLoadingProvider = AutoDisposeProvider<bool>.internal(
  chatLoading,
  name: r'chatLoadingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatLoadingRef = AutoDisposeProviderRef<bool>;
String _$chatMessagesNotifierHash() =>
    r'7013d3c9616b68f74f7af5d0a95cfc757a012584';

/// See also [ChatMessagesNotifier].
@ProviderFor(ChatMessagesNotifier)
final chatMessagesNotifierProvider = AutoDisposeNotifierProvider<
    ChatMessagesNotifier, List<ChatMessageModel>>.internal(
  ChatMessagesNotifier.new,
  name: r'chatMessagesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatMessagesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatMessagesNotifier = AutoDisposeNotifier<List<ChatMessageModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
