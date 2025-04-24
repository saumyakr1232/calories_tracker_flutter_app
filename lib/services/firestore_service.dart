import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/food_analysis.dart';
import '../models/chat_message_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirestoreService() {
    debugPrint('FirestoreService: Initialized');
    debugPrint('FirestoreService: User logged in: $isUserLoggedIn');
    if (isUserLoggedIn) {
      debugPrint('FirestoreService: Current user ID: $currentUserId');
    }
  }

  // Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Get user document reference
  DocumentReference _userDoc(String userId) => _usersCollection.doc(userId);

  // Get food logs collection for a user
  CollectionReference _foodLogsCollection(String userId) {
    debugPrint(
        'FirestoreService: Accessing food logs collection for user: $userId');
    return _userDoc(userId).collection('food_logs');
  }

  // Get chat messages collection for a user
  CollectionReference _chatMessagesCollection(String userId) {
    debugPrint(
        'FirestoreService: Accessing chat messages collection for user: $userId');
    return _userDoc(userId).collection('chat_messages');
  }

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Check if user is logged in
  bool get isUserLoggedIn => currentUserId != null;

  // Create or update user profile
  Future<void> saveUserData(UserModel user) async {
    debugPrint(
        'FirestoreService: saveUserData called for user ID: ${user.uid}');
    try {
      await _usersCollection
          .doc(user.uid)
          .set(user.toJson(), SetOptions(merge: true));
      debugPrint('FirestoreService: Successfully saved user data');
    } catch (e) {
      debugPrint('FirestoreService: Error saving user data: $e');
      rethrow;
    }
  }

  // Get user data
  Future<UserModel?> getUserData(String userId) async {
    debugPrint('FirestoreService: getUserData called for user ID: $userId');
    try {
      final docSnapshot = await _usersCollection.doc(userId).get();
      debugPrint(
          'FirestoreService: User document exists: ${docSnapshot.exists}');
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final userData =
            UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
        debugPrint('FirestoreService: Successfully retrieved user data');
        return userData;
      }
      debugPrint('FirestoreService: User data not found');
      return null;
    } catch (e) {
      debugPrint('FirestoreService: Error getting user data: $e');
      rethrow;
    }
  }

  // Save food log entry
  Future<DocumentReference> saveFoodLog(FoodAnalysis foodAnalysis) async {
    debugPrint('FirestoreService: saveFoodLog called');
    if (!isUserLoggedIn) {
      debugPrint('FirestoreService: Cannot save food log - user not logged in');
      throw Exception('User not logged in');
    }

    // Ensure timestamp is set
    final analysisWithTimestamp = foodAnalysis.timestamp != null
        ? foodAnalysis
        : FoodAnalysis(
            description: foodAnalysis.description,
            calories: foodAnalysis.calories,
            macronutrients: foodAnalysis.macronutrients,
            micronutrients: foodAnalysis.micronutrients,
            timestamp: DateTime.now(),
          );

    debugPrint(
        'FirestoreService: Saving food log with calories: ${analysisWithTimestamp.calories}');
    try {
      final data = analysisWithTimestamp.toJson();
      data["timestamp"] = Timestamp.fromDate(analysisWithTimestamp.timestamp!);
      final docRef = await _foodLogsCollection(currentUserId!).add(data);
      debugPrint(
          'FirestoreService: Successfully saved food log with ID: ${docRef.id}');
      return docRef;
    } catch (e) {
      debugPrint('FirestoreService: Error saving food log: $e');
      rethrow;
    }
  }

  // Get food logs for a specific day
  Future<List<FoodAnalysis>> getFoodLogsByDay(DateTime date) async {
    debugPrint(
        'FirestoreService: getFoodLogsByDay called for date: ${date.toString()}');
    if (!isUserLoggedIn) {
      debugPrint('FirestoreService: Cannot get food logs - user not logged in');
      throw Exception('User not logged in');
    }

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    debugPrint(
        'FirestoreService: Querying food logs between $startOfDay and $endOfDay');

    try {
      final querySnapshot = await _foodLogsCollection(currentUserId!)
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .get();

      debugPrint(
          'FirestoreService: Retrieved ${querySnapshot.docs.length} food logs for the day');
      final logs = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = (data["timestamp"] as Timestamp).toDate();
        data["timestamp"] = timestamp.toIso8601String();
        return FoodAnalysis.fromJson(data);
      }).toList();

      for (var log in logs) {
        debugPrint(
            'FirestoreService: Food log - ${log.description}, calories: ${log.calories}');
      }

      return logs;
    } catch (e) {
      debugPrint('FirestoreService: Error getting food logs by day: $e');
      rethrow;
    }
  }

  // Get food logs for a specific week
  Future<List<FoodAnalysis>> getFoodLogsByWeek(DateTime date) async {
    debugPrint(
        'FirestoreService: getFoodLogsByWeek called for date: ${date.toString()}');
    if (!isUserLoggedIn) {
      debugPrint('FirestoreService: Cannot get food logs - user not logged in');
      throw Exception('User not logged in');
    }

    // Calculate start and end of week (assuming week starts on Monday)
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final startDate =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endDate = startDate
        .add(const Duration(days: 7))
        .subtract(const Duration(seconds: 1));

    debugPrint(
        'FirestoreService: Querying food logs between $startDate and $endDate');

    try {
      final querySnapshot = await _foodLogsCollection(currentUserId!)
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .get();

      debugPrint(
          'FirestoreService: Retrieved ${querySnapshot.docs.length} food logs for the week');
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = (data["timestamp"] as Timestamp).toDate();
        data["timestamp"] = timestamp.toIso8601String();
        return FoodAnalysis.fromJson(data);
      }).toList();
    } catch (e) {
      debugPrint('FirestoreService: Error getting food logs by week: $e');
      rethrow;
    }
  }

  // Get food logs for a specific month
  Future<List<FoodAnalysis>> getFoodLogsByMonth(DateTime date) async {
    debugPrint(
        'FirestoreService: getFoodLogsByMonth called for date: ${date.toString()}');
    if (!isUserLoggedIn) {
      debugPrint('FirestoreService: Cannot get food logs - user not logged in');
      throw Exception('User not logged in');
    }

    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
            .subtract(const Duration(seconds: 1))
        : DateTime(date.year + 1, 1, 1).subtract(const Duration(seconds: 1));

    debugPrint(
        'FirestoreService: Querying food logs between $startOfMonth and $endOfMonth');

    try {
      final querySnapshot = await _foodLogsCollection(currentUserId!)
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
          .where('timestamp',
              isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
          .get();

      debugPrint(
          'FirestoreService: Retrieved ${querySnapshot.docs.length} food logs for the month');
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = (data["timestamp"] as Timestamp).toDate();
        data["timestamp"] = timestamp.toIso8601String();
        return FoodAnalysis.fromJson(data);
      }).toList();
    } catch (e) {
      debugPrint('FirestoreService: Error getting food logs by month: $e');
      rethrow;
    }
  }

  // Save chat message
  Future<DocumentReference> saveChatMessage(ChatMessageModel message) async {
    debugPrint(
        'FirestoreService: saveChatMessage called with message ID: ${message.id}');
    debugPrint(
        'FirestoreService: Message type: ${message.type}, content: ${message.content}');

    if (!isUserLoggedIn) {
      debugPrint(
          'FirestoreService: Cannot save chat message - user not logged in');
      throw Exception('User not logged in');
    }

    try {
      final data = message.toJson();
      data["timestamp"] = Timestamp.fromDate(message.timestamp);
      // Set isUser to true for user messages
      final docRef = await _chatMessagesCollection(currentUserId!).add(data);
      debugPrint(
          'FirestoreService: Successfully saved chat message with Firestore ID: ${docRef.id}');
      return docRef;
    } catch (e) {
      debugPrint('FirestoreService: Error saving chat message: $e');
      rethrow;
    }
  }

  // Get chat history with pagination
  Future<List<ChatMessageModel>> getChatHistory(
      {int limit = 20, DocumentSnapshot? startAfter}) async {
    debugPrint(
        'FirestoreService: getChatHistory called with limit: $limit, startAfter: ${startAfter != null}');

    if (!isUserLoggedIn) {
      debugPrint(
          'FirestoreService: Cannot get chat history - user not logged in');
      throw Exception('User not logged in');
    }

    try {
      Query query = _chatMessagesCollection(currentUserId!)
          .orderBy('timestamp', descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final querySnapshot = await query.get();
      debugPrint(
          'FirestoreService: Retrieved ${querySnapshot.docs.length} messages from chat history');

      final messages = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = (data["timestamp"] as Timestamp).toDate();
        data["timestamp"] =
            timestamp.toIso8601String(); // Convert DateTime to String
        return ChatMessageModel.fromJson(data);
      }).toList();

      for (var message in messages) {
        debugPrint(
            'FirestoreService: Message ID: ${message.id}, type: ${message.type}, timestamp: ${message.timestamp}');
      }

      return messages;
    } catch (e) {
      debugPrint('FirestoreService: Error getting chat history: $e');
      rethrow;
    }
  }

  // Get chat messages for a specific day
  Future<List<ChatMessageModel>> getChatMessagesByDay(DateTime date) async {
    debugPrint(
        'FirestoreService: getChatMessagesByDay called for date: ${date.toString()}');

    if (!isUserLoggedIn) {
      debugPrint(
          'FirestoreService: Cannot get chat messages - user not logged in');
      throw Exception('User not logged in');
    }

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    debugPrint(
        'FirestoreService: Querying chat messages between $startOfDay and $endOfDay');

    try {
      final querySnapshot = await _chatMessagesCollection(currentUserId!)
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .orderBy('timestamp')
          .get();

      debugPrint(
          'FirestoreService: Retrieved ${querySnapshot.docs.length} chat messages for the day');

      final messages = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = (data["timestamp"] as Timestamp).toDate();
        data["timestamp"] = timestamp.toIso8601String();
        return ChatMessageModel.fromJson(data);
      }).toList();

      for (var message in messages) {
        debugPrint(
            'FirestoreService: Message ID: ${message.id}, type: ${message.type}, timestamp: ${message.timestamp}');
      }

      return messages;
    } catch (e) {
      debugPrint('FirestoreService: Error getting chat messages by day: $e');
      rethrow;
    }
  }

  // Get chat messages stream for a specific day
  Stream<List<ChatMessageModel>> getChatMessagesStreamByDay(DateTime date) {
    debugPrint(
        'FirestoreService: getChatMessagesStreamByDay called for date: ${date.toString()}');
    if (!isUserLoggedIn) {
      debugPrint(
          'FirestoreService: Cannot get chat messages stream - user not logged in');
      return Stream.value([]); // Return an empty stream if not logged in
    }

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    debugPrint(
        'FirestoreService: Querying chat messages between $startOfDay and $endOfDay');

    debugPrint(
        "from ${Timestamp.fromDate(startOfDay)} to ${Timestamp.fromDate(endOfDay)}");
    try {
      final query = _chatMessagesCollection(currentUserId!)
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('timestamp', isLessThan: Timestamp.fromDate(endOfDay))
          .orderBy('timestamp', descending: true);

      return query.snapshots().map((snapshot) {
        debugPrint(
            'FirestoreService: Received ${snapshot.docs.length} chat message snapshots for date ${date.toString()}');
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final timestamp = (data["timestamp"] as Timestamp).toDate();
          data["timestamp"] = timestamp.toIso8601String();
          return ChatMessageModel.fromJson(data);
        }).toList();
      }).handleError((error) {
        debugPrint(
            'FirestoreService: Error in chat messages stream for date ${date.toString()}: $error');
        return []; // Return empty list on error
      });
    } catch (e) {
      debugPrint(
          'FirestoreService: Error creating chat messages stream for date ${date.toString()}: $e');
      return Stream.value([]); // Return an empty stream on error
    }
  }
}
