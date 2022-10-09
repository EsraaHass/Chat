import 'package:chat/model/my_room.dart';
import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/screens/AddRoom.dart';
import 'package:chat/view/screens/room_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.fill)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Chat App',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddRoom.routeName);
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<MyRoom>>(
              stream: ChatRepository().loadRooms(),
              builder: (buildcontext, snapshot) {
                var data = snapshot.data!.docs.map((e) => e.data()).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12),
                  itemBuilder: (_, index) {
                    return RoomWidget(data[index]);
                  },
                  itemCount: data.length,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
