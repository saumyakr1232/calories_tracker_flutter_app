import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_message_model.dart';
import '../services/food_service.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatMessagesNotifier extends _$ChatMessagesNotifier {
  late FoodService _foodService;
  bool _isLoading = false;

  @override
  List<ChatMessageModel> build() {
    _foodService = FoodService();
    return [];
  }

  bool get isLoading => _isLoading;

  void addTextMessage(String text) {
    if (text.isEmpty) return;

    state = [ChatMessageModel.text(text), ...state];
  }

  Future<void> analyzeTextMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message
    addTextMessage(text);
    _isLoading = true;
    ref.notifyListeners();

    try {
      final analysis = await _foodService.analyzeFoodText(text);
      state = [ChatMessageModel.analysis(analysis), ...state];
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      ref.notifyListeners();
    }
  }

  Future<void> analyzeImageMessage(File image) async {
    if (image.path.isEmpty) return;

    // Add user image message
    state = [ChatMessageModel.image(image.path), ...state];
    _isLoading = true;
    ref.notifyListeners();

    try {
      final analysis = await _foodService.analyzeFoodImage(image);
      state = [ChatMessageModel.analysis(analysis), ...state];
    } catch (e) {
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
  if (messages.isEmpty) return false;

  final lastMessage = messages[0];
  if (!lastMessage.isUser) return false;

  // Check if there's a response for the last user message
  if (messages.length >= 2) {
    final secondLastMessage = messages[1];
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
