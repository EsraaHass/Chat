import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/repository/repository.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/shared/constant/shared_data.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMessage();
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late MyRoom myRoom;
  Repository? repository;

  ChatViewModel({this.repository});

  void sendMessageToAnother(String messageConttent) async {
    if (messageConttent.trim().isEmpty) return;
    Message message = Message(
      id: myRoom.id,
      dateTime: DateTime.now().microsecondsSinceEpoch,
      messageContant: messageConttent,
      senderId: SharedData.myUser?.id,
      senderName: SharedData.myUser?.firstName,
    );
    await repository?.sendMessage(myRoom.id ?? '', message).then((value) {
      // clear the message
      navigator?.clearMessage();
    }).onError((error, stackTrace) {
      navigator?.showMessage('something went wrong, please try again later',
          positiveActionName: 'Try Again', positiveAction: () {
        sendMessageToAnother(messageConttent);
      }, isCancelable: false, negativeActionName: 'No');
    });
  }
}
