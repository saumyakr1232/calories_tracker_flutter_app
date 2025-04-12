import 'package:freezed_annotation/freezed_annotation.dart';
import 'food_analysis.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

enum MessageType { text, image, analysis }

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required MessageType type,
    required String content,
    required bool isUser,
    required DateTime timestamp,
    FoodAnalysis? analysis,
    String? imagePath,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.text(String message, {bool isUser = true}) {
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: MessageType.text,
      content: message,
      isUser: isUser,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessageModel.image(String path) {
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: MessageType.image,
      content: 'Image uploaded',
      isUser: true,
      timestamp: DateTime.now(),
      imagePath: path,
    );
  }

  factory ChatMessageModel.analysis(FoodAnalysis analysis) {
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: MessageType.analysis,
      content: analysis.description,
      isUser: false,
      timestamp: DateTime.now(),
      analysis: analysis,
    );
  }
}
