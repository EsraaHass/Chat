import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/network/local/database.dart';
import 'package:chat/repository/repository.dart';

class RepositoryImple extends Repository {
  @override
  Future<void> createRoom(MyRoom myRoom) async {
    await MyDatabase.insertRoom(myRoom);
  }

  @override
  Future<List<MyRoom>> getRooms(List<MyRoom> rooms) async {
    rooms = await MyDatabase.loadRooms();
    return rooms;
  }

  @override
  Future<MyUser?> login(String id) async {
    await MyDatabase.retriveUserById(id);
  }

  @override
  register(MyUser myUser) async {
    await MyDatabase.insertUser(myUser);
  }

  @override
  Future<void> sendMessageToAnother(MyRoom myRoom, Message message) async {
    await MyDatabase.sendMessage(myRoom.id ?? '', message);
  }
}
