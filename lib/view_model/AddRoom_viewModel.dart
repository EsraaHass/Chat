import 'package:chat/model/my_room.dart';
import 'package:chat/repository/repository.dart';
import 'package:chat/view/base/base.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  goback();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  Repository? repository;

  AddRoomViewModel({this.repository});

  void createRoom(String name, String desc, String catId) async {
    navigator?.showLoading(message: 'creating room...');
    try {
      MyRoom myRoom = MyRoom(name: name, desc: desc, catId: catId);
      await repository?.insertRoom(myRoom);
      // await MyDatabase.insertRoom(myRoom);
      navigator?.hideLoading();
      navigator?.showMessage('Room Created Successfully',
          positiveActionName: 'Ok', positiveAction: () {
        navigator?.goback;
      }, isCancelable: false);
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('something went wrong, please try again');
    }
  }
}
