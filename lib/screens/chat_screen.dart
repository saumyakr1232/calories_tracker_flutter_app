import 'dart:io';
import 'package:calories_tracker_flutter_app/widgets/calories_and_marco_widget.dart';
import 'package:calories_tracker_flutter_app/widgets/one_week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/chat_message.dart';
import '../services/food_service.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FoodService _foodService = FoodService();
  final List<ChatMessage> _messages = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    if (text.isEmpty) return;

    _textController.clear();
    ChatMessage message = ChatMessage.text(text);

    setState(() {
      _messages.insert(0, message);
      _isLoading = true;
    });

    try {
      final analysis = await _foodService.analyzeFoodText(text);
      debugPrint("Analysis $analysis");
      setState(() {
        _messages.insert(0, ChatMessage.analysis(analysis));
      });
    } catch (e) {
      debugPrint("$e");

      _showError('Failed to analyze food description');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleImageUpload() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (image == null) return;

    setState(() {
      _messages.insert(0, ChatMessage.image(image.path));
      _isLoading = true;
    });

    try {
      final analysis = await _foodService.analyzeFoodImage(File(image.path));
      setState(() {
        _messages.insert(0, ChatMessage.analysis(analysis));
      });
    } catch (e) {
      _showError('Failed to analyze food image');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          WeekCalendar(),
          const SizedBox(height: 8),
          CaloriesAndMacrosWidget(),
          

          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatMessageBubble(
                message: _messages[index],
              ),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _handleImageUpload,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Describe your food...',
                border: InputBorder.none,
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}