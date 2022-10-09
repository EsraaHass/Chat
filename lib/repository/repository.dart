import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository {

   CollectionReference<MyUser> getUserCollection();

  Future<MyUser?> insertUser(MyUser myUser);

  Future<void> deleteRoom(MyRoom myRoom);

  Future<MyUser?> retriveUserById(String id);

  CollectionReference<MyRoom> getRoomCollection();

  Future<void> insertRoom(MyRoom myRoom);

  Stream<QuerySnapshot<MyRoom>> loadRooms();

  CollectionReference<Message> getMessageCollection(String roomId);

  Future<void> sendMessage(String roomId, Message message);
}
