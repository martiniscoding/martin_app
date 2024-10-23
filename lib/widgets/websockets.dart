// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WebSockets extends StatelessWidget {
//   const WebSockets({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WELCOME',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const VoiceToTextScreen(),
//     );
//   }
// }

// class VoiceToTextScreen extends StatefulWidget {
//   const VoiceToTextScreen({Key? key}) : super(key: key);

//   @override
//   State<VoiceToTextScreen> createState() => _VoiceToTextScreenState();
// }

// class _VoiceToTextScreenState extends State<VoiceToTextScreen> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   bool _isListening = false;
//   String _lastWords = '';
//   WebSocketChannel? _channel;
//   final TextEditingController _serverController = TextEditingController(
//     text: 'ws://37.27.1.2:1951/ws/transcribe',
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   @override
//   void dispose() {
//     _channel?.sink.close();
//     _serverController.dispose();
//     super.dispose();
//   }

//   Future<void> _initSpeech() async {
//     await Permission.microphone.request();
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   void _connectWebSocket() {
//     _channel?.sink.close();
//     try {
//       _channel = WebSocketChannel.connect(
//         Uri.parse(_serverController.text),
//       );
//       _channel!.stream.listen(
//         (message) {
//           setState(() {
//             _lastWords = message.toString();
//           });
//         },
//         onError: (error) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('WebSocket error: $error')),
//           );
//         },
//         onDone: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('WebSocket connection closed')),
//           );
//         },
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Connected to WebSocket server')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to connect: $e')),
//       );
//     }
//   }

//   Future<void> _startListening() async {
//     if (_channel == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please connect to WebSocket first')),
//       );
//       return;
//     }

//     await _speechToText.listen(
//       onResult: (result) {
//         setState(() {
//           _lastWords = result.recognizedWords;
//         });
//         if (result.finalResult) {
//           _channel?.sink.add(_lastWords);
//         }
//       },
//     );
//     setState(() {
//       _isListening = true;
//     });
//   }

//   Future<void> _stopListening() async {
//     await _speechToText.stop();
//     setState(() {
//       _isListening = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voice to Text'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _serverController,
//               decoration: const InputDecoration(
//                 labelText: 'ws://37.27.1.2:1951/ws/transcribe',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _connectWebSocket,
//               child: const Text('Connect to WebSocket'),
//             ),
//             const SizedBox(height: 32),
//             Text(
//               _speechEnabled
//                   ? 'Tap the microphone to start listening'
//                   : 'Speech recognition not available',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   _lastWords,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechEnabled
//             ? (_isListening ? _stopListening : _startListening)
//             : null,
//         tooltip: 'Listen',
//         child: Icon(_isListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
// }
