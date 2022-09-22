import 'package:chat/model/my_room.dart';
import 'package:chat/network/local/database.dart';
import 'package:chat/view/base/base.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<MyRoom> rooms = [];

  void getRooms() async {
    rooms = await MyDatabase.loadRooms();
    notifyListeners();
  }
}
