import 'package:chat/view/screens/Chat.dart';
import 'package:chat/model/my_room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  MyRoom roomCategory;

  RoomWidget(this.roomCategory);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Chat.routeName, arguments: roomCategory);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'images/${roomCategory.catId}.jpg',
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: 5,
            ),
            Text('${roomCategory.name}')
          ],
        ),
      ),
    );
  }
}
