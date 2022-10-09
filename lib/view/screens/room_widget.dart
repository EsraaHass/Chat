import 'package:chat/model/my_room.dart';
import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/screens/Chat.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  MyRoom roomCategory;
  ChatRepository chatRepository = ChatRepository();

  RoomWidget(this.roomCategory);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Chat.routeName,
                  arguments: roomCategory);
            },
            child: Image.asset(
              'images/${roomCategory.catId}.jpg',
              height: 120,
              width: 120,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text('${roomCategory.name}'),
          InkWell(
            onTap: () {
              chatRepository.deleteRoom(roomCategory);
            },
            child: const Align(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );
  }
}
