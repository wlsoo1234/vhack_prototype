import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({'user': _messageController.text});
        // Simulate bot response
        _messages.add({
          'bot': 'This is a response to: ${_messageController.text}',
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[400], // Gray background as shown in the image
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Chat Bot',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            child: const Text(
              'BACK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                // Handle help button press
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Text(
                'HELP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.containsKey('user');
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message.values.first,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message input area
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            color: Colors.grey[300],
            child: Row(
              children: [
                // Send button (plus icon)
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _sendMessage,
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 8),
                // Text input field
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
