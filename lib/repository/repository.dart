import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/model/my_user.dart';

abstract class Repository {
  Future<void> createRoom(MyRoom myRoom);

  Future<void> sendMessageToAnother(MyRoom myRoom, Message message);

  Future<List<MyRoom>> getRooms(List<MyRoom> rooms);

  Future<MyUser?> login(String id);

  register(MyUser myUser);
}
