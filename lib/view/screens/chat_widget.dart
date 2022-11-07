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
      padding: const EdgeInsets.only(left: 70, right: 8, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )),
              child: Text(
                content,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.white),
              )),
          Text(
            textDirection: TextDirection.ltr,
            '${FormateDate.formatMessageDate(dateTime)}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontSize: 11, color: Colors.grey.shade600),
          ),
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
      padding: const EdgeInsets.only(left: 8, right: 70, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            senderName,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: const Color(0XFFF8F8F8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: const Radius.circular(24),
                    bottomLeft: const Radius.circular(24),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: const Color(0XFF787993)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    textDirection: TextDirection.ltr,
                    '${FormateDate.formatMessageDate(dateTime)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 11, color: Colors.grey.shade600),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
