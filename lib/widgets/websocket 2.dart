import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:web_socket_channel/io.dart';

class AudioRecorderWebSocket extends StatefulWidget {
  @override
  _AudioRecorderWebSocketState createState() => _AudioRecorderWebSocketState();
}

class _AudioRecorderWebSocketState extends State<AudioRecorderWebSocket> {
  final _record = Record();
  final _channel = IOWebSocketChannel.connect('ws://37.27.1.2:1951/ws/transcribe');
  late String _filePath;
  bool _isRecording = false;

  @override
  // void initState() {
  //   super.initState();
  //   _requestPermissions();
  // }

  // Future<void> _requestPermissions() async {
  //   await _record.requestPermission();
  // }

  Future<void> _startRecording() async {
    final tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/recorded_audio.m4a';

    await _record.start(
      path: _filePath,
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      
    );

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _record.stop();
    _sendAudioToWebSocket();

    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _sendAudioToWebSocket() async {
    final file = File(_filePath);
    final bytes = await file.readAsBytes();
    _channel.sink.add(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder WebSocket'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _isRecording ? _stopRecording : _startRecording,
          child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
