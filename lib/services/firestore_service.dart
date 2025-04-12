import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/food_analysis.dart';
import '../models/chat_message_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Get user document reference
  DocumentReference _userDoc(String userId) => _usersCollection.doc(userId);

  // Get food logs collection for a user
  CollectionReference _foodLogsCollection(String userId) =>
      _userDoc(userId).collection('food_logs');

  // Get chat messages collection for a user
  CollectionReference _chatMessagesCollection(String userId) =>
      _userDoc(userId).collection('chat_messages');

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Check if user is logged in
  bool get isUserLoggedIn => currentUserId != null;

  // Create or update user profile
  Future<void> saveUserData(UserModel user) async {
    await _usersCollection
        .doc(user.uid)
        .set(user.toJson(), SetOptions(merge: true));
  }

  // Get user data
  Future<UserModel?> getUserData(String userId) async {
    final docSnapshot = await _usersCollection.doc(userId).get();
    if (docSnapshot.exists && docSnapshot.data() != null) {
      return UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Save food log entry
  Future<DocumentReference> saveFoodLog(FoodAnalysis foodAnalysis) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

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

    return await _foodLogsCollection(currentUserId!)
        .add(analysisWithTimestamp.toJson());
  }

  // Get food logs for a specific day
  Future<List<FoodAnalysis>> getFoodLogsByDay(DateTime date) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final querySnapshot = await _foodLogsCollection(currentUserId!)
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .where('timestamp', isLessThanOrEqualTo: endOfDay)
        .get();

    return querySnapshot.docs
        .map((doc) => FoodAnalysis.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Get food logs for a specific week
  Future<List<FoodAnalysis>> getFoodLogsByWeek(DateTime date) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    // Calculate start and end of week (assuming week starts on Monday)
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final startDate =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endDate = startDate
        .add(const Duration(days: 7))
        .subtract(const Duration(seconds: 1));

    final querySnapshot = await _foodLogsCollection(currentUserId!)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .where('timestamp', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs
        .map((doc) => FoodAnalysis.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Get food logs for a specific month
  Future<List<FoodAnalysis>> getFoodLogsByMonth(DateTime date) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
            .subtract(const Duration(seconds: 1))
        : DateTime(date.year + 1, 1, 1).subtract(const Duration(seconds: 1));

    final querySnapshot = await _foodLogsCollection(currentUserId!)
        .where('timestamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timestamp', isLessThanOrEqualTo: endOfMonth)
        .get();

    return querySnapshot.docs
        .map((doc) => FoodAnalysis.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Save chat message
  Future<DocumentReference> saveChatMessage(ChatMessageModel message) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    return await _chatMessagesCollection(currentUserId!).add(message.toJson());
  }

  // Get chat history with pagination
  Future<List<ChatMessageModel>> getChatHistory(
      {int limit = 20, DocumentSnapshot? startAfter}) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    Query query = _chatMessagesCollection(currentUserId!)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) =>
            ChatMessageModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Get chat messages for a specific day
  Future<List<ChatMessageModel>> getChatMessagesByDay(DateTime date) async {
    if (!isUserLoggedIn) throw Exception('User not logged in');

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final querySnapshot = await _chatMessagesCollection(currentUserId!)
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .where('timestamp', isLessThanOrEqualTo: endOfDay)
        .orderBy('timestamp')
        .get();

    return querySnapshot.docs
        .map((doc) =>
            ChatMessageModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
