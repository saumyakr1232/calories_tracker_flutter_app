import 'dart:io';
import 'package:calories_tracker_flutter_app/widgets/calories_and_marco_widget.dart';
import 'package:calories_tracker_flutter_app/widgets/one_week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/chat_provider.dart';
import '../providers/date_filtered_chat_provider.dart';
import '../providers/selected_date_provider.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('ChatScreen: build method called');
    final selectedDate = ref.watch(selectedDateNotifierProvider);
    debugPrint('ChatScreen: selectedDate = ${selectedDate.toString()}');

    final messagesAsyncValue = ref.watch(dateFilteredChatMessagesProvider);
    debugPrint(
        'ChatScreen: messagesAsyncValue state = ${messagesAsyncValue.toString()}');

    // The loading state is now handled by the AsyncValue from the StreamProvider
    // final isLoading = ref.watch(dateFilteredChatLoadingProvider);
    // debugPrint('ChatScreen: isLoading = $isLoading');

    final textController = TextEditingController();
    final imagePicker = ImagePicker();

    // Dispose controller when no longer needed
    // ref.onDispose(() {
    //   textController.dispose();
    // });

    void handleSubmitted(String text) async {
      debugPrint('ChatScreen: handleSubmitted called with text: "$text"');
      if (text.isEmpty) return;

      textController.clear();
      debugPrint('ChatScreen: Calling analyzeTextMessage');
      ref.read(chatMessagesNotifierProvider.notifier).analyzeTextMessage(text);
    }

    Future<void> handleImageUpload() async {
      debugPrint('ChatScreen: handleImageUpload called');
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      debugPrint('ChatScreen: Image picked: ${image?.path ?? "null"}');
      if (image == null) return;

      debugPrint('ChatScreen: Calling analyzeImageMessage');
      ref
          .read(chatMessagesNotifierProvider.notifier)
          .analyzeImageMessage(File(image.path));
    }

    void showError(String message) {
      debugPrint('ChatScreen: showError called with message: "$message"');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    debugPrint('ChatScreen: Rendering UI components');
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDate.day == DateTime.now().day &&
                selectedDate.month == DateTime.now().month &&
                selectedDate.year == DateTime.now().year
            ? 'Today'
            : 'Chat - ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
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
            child: messagesAsyncValue.when(
              data: (messages) {
                debugPrint(
                    'ChatScreen: messagesAsyncValue.when data callback with ${messages.length} messages');
                if (messages.isEmpty) {
                  debugPrint('ChatScreen: No messages to display');
                  return const Center(
                    child: Text('No messages yet. Start chatting!'),
                  );
                }
                debugPrint(
                    'ChatScreen: Building ListView with ${messages.length} messages');
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ChatMessageBubble(
                    message: messages[index],
                  ),
                );
              },
              loading: () {
                debugPrint(
                    'ChatScreen: messagesAsyncValue.when loading callback');
                // Show loading indicator while waiting for the initial stream data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stackTrace) {
                debugPrint(
                    'ChatScreen: messagesAsyncValue.when error callback: $error');
                debugPrint('ChatScreen: Stack trace: $stackTrace');
                return Center(
                  child: Text('Error loading messages: $error'),
                );
              },
            ),
          ),
          // The LinearProgressIndicator is removed as loading is handled by the .when clause
          // if (isLoading)
          //   const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: LinearProgressIndicator(),
          //   ),
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
