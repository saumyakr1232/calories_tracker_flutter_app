import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_message_model.dart';
import '../services/food_service.dart';
import '../repositories/chat_repository.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatMessagesNotifier extends _$ChatMessagesNotifier {
  late FoodService _foodService;
  late ChatRepository _chatRepository;
  bool _isLoading = false;

  @override
  Future<List<ChatMessageModel>> build() async {
    debugPrint('ChatMessagesNotifier: build method called');
    _foodService = FoodService();
    _chatRepository = ChatRepository();

    // Load chat history from Firestore if user is logged in
    if (_chatRepository.isUserLoggedIn) {
      debugPrint(
          'ChatMessagesNotifier: User is logged in, loading chat history');
      try {
        final messages = await _chatRepository.getChatHistory();
        debugPrint(
            'ChatMessagesNotifier: Loaded ${messages.length} messages from history');
        return messages;
      } catch (e) {
        debugPrint('ChatMessagesNotifier: Error loading chat history: $e');
        // If there's an error loading from Firestore, return empty list
        return [];
      }
    }
    debugPrint(
        'ChatMessagesNotifier: User not logged in, returning empty list');
    return [];
  }

  bool get isLoading => _isLoading;

  Future<void> addTextMessage(String text) async {
    debugPrint('ChatMessagesNotifier: addTextMessage called with: "$text"');
    if (text.isEmpty) return;

    final message = ChatMessageModel.text(text);
    debugPrint(
        'ChatMessagesNotifier: Created text message with ID: ${message.id}');
    state = AsyncValue.data([message, ...state.valueOrNull ?? []]);
    debugPrint('ChatMessagesNotifier: Updated state with new text message');

    // Save to Firestore if user is logged in
    if (_chatRepository.isUserLoggedIn) {
      debugPrint('ChatMessagesNotifier: Saving text message to Firestore');
      try {
        await _chatRepository.saveChatMessage(message);
        debugPrint(
            'ChatMessagesNotifier: Successfully saved text message to Firestore');
      } catch (e) {
        debugPrint(
            'ChatMessagesNotifier: Error saving user text message to Firestore: $e');
        // Continue even if Firestore save fails
      }
    }
  }

  Future<void> analyzeTextMessage(String text) async {
    debugPrint('ChatMessagesNotifier: analyzeTextMessage called with: "$text"');
    if (text.isEmpty) return;

    // Add user message
    await addTextMessage(text);
    _isLoading = true;
    debugPrint('ChatMessagesNotifier: Set loading state to true');
    ref.notifyListeners();

    try {
      debugPrint('ChatMessagesNotifier: Calling food service to analyze text');
      final analysis = await _foodService.analyzeFoodText(text);
      debugPrint(
          'ChatMessagesNotifier: Received analysis result: ${analysis.toString()}');
      final analysisMessage = ChatMessageModel.analysis(analysis);
      debugPrint(
          'ChatMessagesNotifier: Created analysis message with ID: ${analysisMessage.id}');
      state = AsyncValue.data([analysisMessage, ...state.valueOrNull ?? []]);
      debugPrint(
          'ChatMessagesNotifier: Updated state with new analysis message');

      // Save analysis message to Firestore if user is logged in
      if (_chatRepository.isUserLoggedIn) {
        debugPrint(
            'ChatMessagesNotifier: Saving analysis message to Firestore');
        try {
          await _chatRepository.saveChatMessage(analysisMessage);
          debugPrint(
              'ChatMessagesNotifier: Successfully saved analysis message to Firestore');
        } catch (e) {
          debugPrint(
              'ChatMessagesNotifier: Error saving analysis message to Firestore: $e');
          // Continue even if Firestore save fails
        }
      }
    } catch (e) {
      debugPrint('ChatMessagesNotifier: Error analyzing text message: $e');
      // Handle error
    } finally {
      _isLoading = false;
      debugPrint('ChatMessagesNotifier: Set loading state to false');
      ref.notifyListeners();
    }
  }

  Future<void> analyzeImageMessage(File image) async {
    debugPrint(
        'ChatMessagesNotifier: analyzeImageMessage called with image: ${image.path}');
    if (image.path.isEmpty) return;

    // Add user image message
    final imageMessage = ChatMessageModel.image(image.path);
    debugPrint(
        'ChatMessagesNotifier: Created image message with ID: ${imageMessage.id}');
    state = AsyncValue.data([imageMessage, ...state.valueOrNull ?? []]);
    debugPrint('ChatMessagesNotifier: Updated state with new image message');

    // Save image message to Firestore if user is logged in
    if (_chatRepository.isUserLoggedIn) {
      debugPrint('ChatMessagesNotifier: Saving image message to Firestore');
      try {
        await _chatRepository.saveChatMessage(imageMessage);
        debugPrint(
            'ChatMessagesNotifier: Successfully saved image message to Firestore');
      } catch (e) {
        debugPrint(
            'ChatMessagesNotifier: Error saving user image message to Firestore: $e');
        // Continue even if Firestore save fails
      }
    }

    _isLoading = true;
    ref.notifyListeners();

    try {
      final analysis = await _foodService.analyzeFoodImage(image);
      final analysisMessage = ChatMessageModel.analysis(analysis);
      state = AsyncValue.data([analysisMessage, ...state.valueOrNull ?? []]);

      // Save analysis message to Firestore if user is logged in
      if (_chatRepository.isUserLoggedIn) {
        try {
          await _chatRepository.saveChatMessage(analysisMessage);
        } catch (e) {
          debugPrint('Error saving analysis message to Firestore: $e');
          // Continue even if Firestore save fails
        }
      }
    } catch (e) {
      debugPrint('Error analyzing image message: $e');
      // Handle error
    } finally {
      _isLoading = false;
      ref.notifyListeners();
    }
  }
}

@riverpod
bool isLoading(Ref ref) {
  final messages = ref.watch(chatMessagesNotifierProvider);
  // Consider the app is loading if the last message is from the user and there's no response yet
  if (messages.value?.isEmpty ?? true) return false;

  final lastMessage = messages.value![0];
  if (!lastMessage.isUser) return false;

  // Check if there's a response for the last user message
  if ((messages.value?.length ?? 0) >= 2) {
    final secondLastMessage = messages.value?[1];
    if (secondLastMessage == null) {
      return false;
    }
    if (!secondLastMessage.isUser &&
        secondLastMessage.timestamp.isAfter(lastMessage.timestamp)) {
      return false;
    }
  }

  return true;
}

@riverpod
bool chatLoading(Ref ref) {
  final notifier = ref.watch(chatMessagesNotifierProvider.notifier);
  return notifier is AsyncLoading;
}
