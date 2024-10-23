import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TRANSCRIPTION APP"),
          leading: Icon(CupertinoIcons.home),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            right: 10,
          ),
          child: FloatingActionButton(
            onPressed: () async {
              await Apis.auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: Icon(Icons.add_comment_sharp),
          ),
        ),
        body: StreamBuilder(
            stream: Apis.firestore.collection("users").snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatUserCard(user: list[index]);
                          // return Text('Name : ${list[index]}');
                        });
                  } else {
                    return Text("No connectins found ",
                        style: TextStyle(fontSize: 20));
                  }
              }
            }));
  }
}
