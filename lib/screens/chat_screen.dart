import 'package:flutter/material.dart';
import 'package:right_now/utils/constants.dart'; // Assuming kPrimaryBlue is here

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // For auto-scrolling
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello',
      'time': '09:35',
      'isSent': false,
      'isRead': true,
    },
    {
      'text': 'Did you go through the documents I uploaded yesterday?',
      'time': '09:35',
      'isSent': false,
      'isRead': true,
    },
    {
      'text': 'I\'ll check and get back to you.',
      'time': '09:38',
      'isSent': true,
      'isRead': false,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        'isSent': true,
        'isRead': false,
      });
      _messageController.clear();
    });

    // Auto-scroll to the bottom after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Theming variables for consistency ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBackgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF3F4F6);
    final cardBackgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final sentBubbleColor = kPrimaryBlue;
    final receivedBubbleColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey[400]! : Colors.black54;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryBlue,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(
                  text: message['text'],
                  time: message['time'],
                  isSent: message['isSent'],
                  isRead: message['isRead'],
                  sentBubbleColor: sentBubbleColor,
                  receivedBubbleColor: receivedBubbleColor,
                  subTextColor: subTextColor,
                );
              },
            ),
          ),

          // --- Modern Input Area ---
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBackgroundColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Write a message...',
                      hintStyle: TextStyle(color: subTextColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      isDense: true,
                    ),
                    maxLines: 5,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // Show attachment options
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add, color: subTextColor),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: kPrimaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MODIFICATION: Timestamp and checkmark are now inside the bubble ---
  Widget _buildMessageBubble({
    required String text,
    required String time,
    required bool isSent,
    required bool isRead,
    required Color sentBubbleColor,
    required Color receivedBubbleColor,
    required Color subTextColor,
  }) {
    final bubbleColor = isSent ? sentBubbleColor : receivedBubbleColor;
    final bubbleTextColor = isSent ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87);
    final timeTextColor = isSent ? Colors.white.withOpacity(0.8) : subTextColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isSent ? 20 : 4),
                  bottomRight: Radius.circular(isSent ? 4 : 20),
                ),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // The message text
                    Text(
                      text,
                      style: TextStyle(color: bubbleTextColor, fontSize: 14, height: 1.3),
                    ),
                    const SizedBox(height: 4),
                    // Right-aligned timestamp and checkmark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: TextStyle(fontSize: 11, color: timeTextColor),
                        ),
                        // Read receipt only for sent messages
                        if (isSent) ...[
                          const SizedBox(width: 4),
                          Icon(
                            isRead ? Icons.done_all : Icons.done,
                            size: 16,
                            color: timeTextColor,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
