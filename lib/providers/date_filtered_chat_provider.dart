import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_message_model.dart';
import '../repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';
import 'selected_date_provider.dart';

part 'date_filtered_chat_provider.g.dart';

/// Provider that returns a stream of chat messages filtered by the selected date
@riverpod
Stream<List<ChatMessageModel>> dateFilteredChatMessages(Ref ref) {
  final selectedDate = ref.watch(selectedDateNotifierProvider);
  debugPrint(
      'dateFilteredChatMessages: Getting message stream for date ${selectedDate.toString()}');
  final chatRepository = ChatRepository();

  // If user is not logged in, return an empty stream
  if (!chatRepository.isUserLoggedIn) {
    debugPrint(
        'dateFilteredChatMessages: User not logged in, returning empty stream');
    return Stream.value([]);
  }

  try {
    debugPrint('dateFilteredChatMessages: Getting stream from repository');
    // Get the stream of messages for the selected date
    final stream = chatRepository.getChatMessagesStreamByDay(selectedDate);
    debugPrint('dateFilteredChatMessages: Returning message stream');
    return stream;
  } catch (e) {
    debugPrint('dateFilteredChatMessages: Error getting message stream: $e');
    // If there's an error, return an empty stream
    return Stream.value([]);
  }
}
