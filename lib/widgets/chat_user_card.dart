import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/models/chat_user.dart';
import 'package:final_app/screens/chat_screen.dart';
import 'package:final_app/widgets/voicetotext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_app/main.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'websockets.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) =>voicetotext()));
        },
        child: ListTile(
          //profile picture
          //leading: CircleAvatar(child: Icon(CupertinoIcons.person_2)),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * 0.3),
            child: CachedNetworkImage(
              width: mq.height * 0.055,
              height: mq.height * 0.055,

              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person_2)),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about),
          trailing: Text(
            "12:00",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ),
    );
  }
}
