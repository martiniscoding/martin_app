// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceToText extends StatefulWidget {
//   const VoiceToText({super.key});

//   @override
//   State<VoiceToText> createState() => _VoiceToTextState();
// }

// class _VoiceToTextState extends State<VoiceToText> {
  
//   bool _speechEnabled = false;
//   String _wordsSpoken = "";
//   final SpeechToText _speechToText = SpeechToText();
//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//   }

//   void initSpeech() async {
//     try {
//       _speechEnabled = await _speechToText.initialize();
//     } catch (e) {
//       print('Speech initialization : $e');
//     }
//   }

//   void _startListening() async {
//     try {
//       await _speechToText.listen(onResult: _onSpeechResult);
//       setState(() {});
//     } catch (e) {
//       print('start listening : $e');
//     }
//   }

//   void _stopListening() async {
//     try {
//       await _speechToText.stop();
//       setState(() {});
//     } catch (e) {
//       print('stop listening : $e');
//     }
//   }

//   void _onSpeechResult(result) {
//     try {
//       setState(() {
//         _wordsSpoken = '${result.recognizedWords}';
//       });
//     } catch (e) {
//       print('on speech result : $e');
//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: Colors.blue,
//             title: Center(
//               child: Text(
//                 "SPEAK YOUR ADIVCE DOCTOR 💙",
//                 style:
//                     TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
//               ),
//             )),
//         body: Center(
//           child: Column(
//             children: [
//               Container(
//                   child: Text(_speechToText.isListening
//                       ? "WE ARE LISTENING YOU"
//                       : _speechEnabled
//                           ? 'TAP THE MICROPHONE TO START LISTENING...'
//                           : 'SPEECH NOT ENABLED')),
//               Expanded(
//                   child: Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   _wordsSpoken,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ))
//             ],
//           ),
//         ),
//         floatingActionButton: Center(
//           child: FloatingActionButton(
//             onPressed:
//                 _speechToText.isListening ? _stopListening : _startListening,
//             tooltip: 'Listen',
//             child: Icon(
//               _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//               color: Colors.white,
//             ),
//             backgroundColor: Colors.blue,
//           ),
//         ));
//   }
// }
