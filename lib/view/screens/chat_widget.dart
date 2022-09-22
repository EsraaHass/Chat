import 'package:chat/model/message.dart';
import 'package:chat/view/screens/date_utiles.dart';
import 'package:chat/view/shared/constant/shared_data.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  Message message;

  ChatWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.myUser?.id
        ? SendMessag(message.dateTime!, message.messageContant!)
        : RecivedMessag(
            message.senderName!, message.dateTime!, message.messageContant!);
  }
}

class SendMessag extends StatelessWidget {
  String content;

  int dateTime;

  SendMessag(this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )),
              child: Text(
                content,
                style: TextStyle(color: Colors.white),
              )),
          Text('${FormateDate.formatMessageDate(dateTime)}')
        ],
      ),
    );
  }
}

class RecivedMessag extends StatelessWidget {
  String senderName;
  String content;

  int dateTime;

  RecivedMessag(this.senderName, this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color(0XFFF8F8F8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )),
              child: Text(
                content,
                style: TextStyle(color: Color(0XFF787993)),
              )),
          Text('${FormateDate.formatMessageDate(dateTime)}')
        ],
      ),
    );
  }
}
