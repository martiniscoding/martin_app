import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class voicetotext extends StatefulWidget {
  const voicetotext({super.key});

  @override
  State<voicetotext> createState() => _voicetotextState();
}

class _voicetotextState extends State<voicetotext> {
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  final SpeechToText _speechToText = SpeechToText();
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
    ;
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = '${result.recognizedWords}';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                "SPEAK YOUR ADIVCE DOCTOR 💙",
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            )),
        body: Center(
          child: Column(
            children: [
              Container(
                  child: Text(_speechToText.isListening
                      ? "WE ARE LISTENING YOU"
                      : _speechEnabled
                          ? 'TAP THE MICROPHONE TO START LISTENING...'
                          : 'SPEECH NOT ENABLED')),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _wordsSpoken,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: Center(
          child: FloatingActionButton(
            onPressed:
                _speechToText.isListening ? _stopListening : _startListening,
            tooltip: 'Listen',
            child: Icon(
              _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        ));
  }
}
