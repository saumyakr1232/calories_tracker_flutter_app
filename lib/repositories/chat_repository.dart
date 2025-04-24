import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/chat_message_model.dart';
import '../services/firestore_service.dart';

/// Repository class for handling chat message operations
/// This class provides methods for storing and retrieving chat messages
/// with support for pagination and filtering by date
class ChatRepository {
  final FirestoreService _firestoreService;

  ChatRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService() {
    debugPrint('ChatRepository: Initialized with FirestoreService');
    debugPrint('ChatRepository: User logged in: $isUserLoggedIn');
    if (isUserLoggedIn) {
      debugPrint('ChatRepository: Current user ID: $currentUserId');
    }
  }

  /// Get a stream of chat messages for a specific day
  Stream<List<ChatMessageModel>> getChatMessagesStreamByDay(DateTime date) {
    debugPrint(
        'ChatRepository: getChatMessagesStreamByDay called for date: ${date.toString()}');
    try {
      final stream = _firestoreService.getChatMessagesStreamByDay(date);
      debugPrint(
          'ChatRepository: Returning stream for messages on date ${date.toString()}');
      return stream;
    } catch (e) {
      debugPrint('ChatRepository: Error getting messages stream by day: $e');
      // Return an empty stream or a stream with an error event
      return Stream.value([]);
    }
  }

  /// Save a chat message to Firestore
  Future<void> saveChatMessage(ChatMessageModel message) async {
    debugPrint(
        'ChatRepository: saveChatMessage called with message ID: ${message.id}');
    debugPrint(
        'ChatRepository: Message type: ${message.type}, timestamp: ${message.timestamp}');
    try {
      await _firestoreService.saveChatMessage(message);
      debugPrint('ChatRepository: Successfully saved message to Firestore');
    } catch (e) {
      debugPrint('ChatRepository: Error saving message to Firestore: $e');
      rethrow;
    }
  }

  /// Get chat history with pagination
  Future<List<ChatMessageModel>> getChatHistory(
      {int limit = 20, DocumentSnapshot? startAfter}) async {
    debugPrint(
        'ChatRepository: getChatHistory called with limit: $limit, startAfter: ${startAfter != null}');
    try {
      final messages = await _firestoreService.getChatHistory(
          limit: limit, startAfter: startAfter);
      debugPrint(
          'ChatRepository: Retrieved ${messages.length} messages from history');
      return messages;
    } catch (e) {
      debugPrint('ChatRepository: Error getting chat history: $e');
      rethrow;
    }
  }

  /// Get chat messages for a specific day
  Future<List<ChatMessageModel>> getChatMessagesByDay(DateTime date) async {
    debugPrint(
        'ChatRepository: getChatMessagesByDay called for date: ${date.toString()}');
    try {
      final messages = await _firestoreService.getChatMessagesByDay(date);
      debugPrint(
          'ChatRepository: Retrieved ${messages.length} messages for date ${date.toString()}');
      return messages;
    } catch (e) {
      debugPrint('ChatRepository: Error getting messages by day: $e');
      rethrow;
    }
  }

  /// Get chat messages for today
  Future<List<ChatMessageModel>> getTodayMessages() async {
    debugPrint('ChatRepository: getTodayMessages called');
    try {
      final messages =
          await _firestoreService.getChatMessagesByDay(DateTime.now());
      debugPrint(
          'ChatRepository: Retrieved ${messages.length} messages for today');
      return messages;
    } catch (e) {
      debugPrint('ChatRepository: Error getting today messages: $e');
      rethrow;
    }
  }

  /// Check if user is logged in
  bool get isUserLoggedIn => _firestoreService.isUserLoggedIn;

  /// Get current user ID
  String? get currentUserId => _firestoreService.currentUserId;
}
