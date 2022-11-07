import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/screens/chat_widget.dart';
import 'package:chat/view_model/Chat_viewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends BaseState<Chat, ChatViewModel>
    implements ChatNavigator {
  var contentController = TextEditingController();
  late MyRoom myRoom;

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel(repository: ChatRepository());
  }

  // ChatViewModel chatViewModel = ChatViewModel(repository: ChatRepository());

  @override
  Widget build(BuildContext context) {
    myRoom = ModalRoute.of(context)?.settings.arguments as MyRoom;
    viewModel.myRoom = myRoom;
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Chat App',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Card(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 4),
            elevation: 18,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: initViewModel()
                      .repository
                      ?.getMessageCollection(myRoom.id ?? '')
                      .orderBy('dateTime', descending: false)
                      .snapshots(),

                  builder: (buildContext, asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                          child: Column(
                        children: [
                          Text('something went wrong, please try again later'),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          BeveledRectangleBorder>(
                                      BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                              onPressed: () {
                                initViewModel()
                                    .repository
                                    ?.getMessageCollection(myRoom.id ?? '')
                                    .doc()
                                    .snapshots();
                              },
                              child: Text(
                                'Try Again',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ))
                        ],
                      ));
                    } else if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data = asyncSnapshot.data?.docs
                          .map((message) => message.data())
                          .toList();
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            return ChatWidget(data![index]);
                          },
                          itemCount: data?.length ?? 0);
                    }
                  },
                )),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: contentController,
                        decoration: const InputDecoration(
                            hintText: 'Your Message here',
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2))),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            viewModel
                                .sendMessageToAnother(contentController.text);
                          },
                          child: Row(
                            children: const [
                              Text(
                                'Send',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void clearMessage() {
    contentController.clear();
  }
}
