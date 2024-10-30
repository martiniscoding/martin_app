import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

class WebSocketDemo extends StatefulWidget {
  const WebSocketDemo({Key? key}) : super(key: key);

  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final TextEditingController _messageController = TextEditingController();
  WebSocketChannel? channel;
  List<String> messages = [];
  bool isConnected = false;

  void connectToWebSocket() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://37.27.1.2:1951/ws/transcribe'),
      );

      setState(() {
        isConnected = true;
      });

      // Listen to incoming messages
      channel?.stream.listen(
        (message) {
          setState(() {
            messages.add('Received: $message');
          });
        },
        onDone: () {
          setState(() {
            isConnected = false;
            messages.add('WebSocket connection closed');
          });
        },
        onError: (error) {
          setState(() {
            isConnected = false;
            messages.add('Error: $error');
          });
        },
      );
    } catch (e) {
      setState(() {
        messages.add('Error connecting: $e');
      });
    }
  }

  void sendMessage(String message) {
    if (channel != null && isConnected) {
      channel?.sink.add(message);
      setState(() {
        messages.add('Sent: $message');
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    channel?.sink.close();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Demo'),
        actions: [
          IconButton(
            icon: Icon(isConnected ? Icons.link : Icons.link_off),
            onPressed: isConnected ? null : connectToWebSocket,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                    ),
                    enabled: isConnected,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isConnected
                      ? () => sendMessage(_messageController.text)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
