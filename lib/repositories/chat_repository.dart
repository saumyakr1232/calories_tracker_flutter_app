import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message_model.dart';
import '../services/firestore_service.dart';

/// Repository class for handling chat message operations
/// This class provides methods for storing and retrieving chat messages
/// with support for pagination and filtering by date
class ChatRepository {
  final FirestoreService _firestoreService;

  ChatRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Save a chat message to Firestore
  Future<void> saveChatMessage(ChatMessageModel message) async {
    await _firestoreService.saveChatMessage(message);
  }

  /// Get chat history with pagination
  Future<List<ChatMessageModel>> getChatHistory(
      {int limit = 20, DocumentSnapshot? startAfter}) async {
    return await _firestoreService.getChatHistory(
        limit: limit, startAfter: startAfter);
  }

  /// Get chat messages for a specific day
  Future<List<ChatMessageModel>> getChatMessagesByDay(DateTime date) async {
    return await _firestoreService.getChatMessagesByDay(date);
  }

  /// Get chat messages for today
  Future<List<ChatMessageModel>> getTodayMessages() async {
    return await _firestoreService.getChatMessagesByDay(DateTime.now());
  }

  /// Check if user is logged in
  bool get isUserLoggedIn => _firestoreService.isUserLoggedIn;

  /// Get current user ID
  String? get currentUserId => _firestoreService.currentUserId;
}
