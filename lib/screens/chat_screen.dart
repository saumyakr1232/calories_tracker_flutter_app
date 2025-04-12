import 'dart:io';
import 'package:calories_tracker_flutter_app/widgets/calories_and_marco_widget.dart';
import 'package:calories_tracker_flutter_app/widgets/one_week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessagesNotifierProvider);
    final isLoading = ref.watch(chatLoadingProvider);
    final textController = TextEditingController();
    final imagePicker = ImagePicker();

    // Dispose controller when no longer needed
    // ref.onDispose(() {
    //   textController.dispose();
    // });

    void handleSubmitted(String text) async {
      if (text.isEmpty) return;

      textController.clear();
      ref.read(chatMessagesNotifierProvider.notifier).analyzeTextMessage(text);
    }

    Future<void> handleImageUpload() async {
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image == null) return;

      ref
          .read(chatMessagesNotifierProvider.notifier)
          .analyzeImageMessage(File(image.path));
    }

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          const WeekCalendar(),
          const SizedBox(height: 8),
          const CaloriesAndMacrosWidget(),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => ChatMessageBubble(
                message: messages[index],
              ),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: handleImageUpload,
                  ),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Describe your food...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: handleSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => handleSubmitted(textController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
