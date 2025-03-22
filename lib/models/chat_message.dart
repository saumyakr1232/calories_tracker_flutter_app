import 'food_analysis.dart';

enum MessageType {
  text,
  image,
  analysis
}

class ChatMessage {
  final String id;
  final MessageType type;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final FoodAnalysis? analysis;
  final String? imagePath;

  ChatMessage({
    String? id,
    required this.type,
    required this.content,
    required this.isUser,
    DateTime? timestamp,
    this.analysis,
    this.imagePath,
  }) : 
    id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
    timestamp = timestamp ?? DateTime.now();

  bool get hasAnalysis => analysis != null;
  bool get hasImage => imagePath != null;

  factory ChatMessage.text(String message, {bool isUser = true}) {
    return ChatMessage(
      type: MessageType.text,
      content: message,
      isUser: isUser,
    );
  }

  factory ChatMessage.image(String path) {
    return ChatMessage(
      type: MessageType.image,
      content: 'Image uploaded',
      isUser: true,
      imagePath: path,
    );
  }

  factory ChatMessage.analysis(FoodAnalysis analysis) {
    return ChatMessage(
      type: MessageType.analysis,
      content: analysis.description,
      isUser: false,
      analysis: analysis,
    );
  }
}