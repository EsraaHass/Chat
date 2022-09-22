import 'package:chat/model/my_room.dart';
import 'package:chat/network/local/database.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/screens/AddRoom.dart';
import 'package:chat/view/screens/room_widget.dart';
import 'package:chat/view_model/home_viewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  late HomeViewModel viewModel;

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getRooms();
    refershRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
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
                stream: MyDatabase.getRoomCollection().snapshots(),
                builder: (buildcontext, snapshot) {
                  return RefreshIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.white,
                    onRefresh: refershRooms,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12),
                      itemBuilder: (_, index) {
                        return RoomWidget(viewModel.rooms[index]);
                      },
                      itemCount: viewModel.rooms.length,
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refershRooms() async {
    return viewModel.getRooms();
  }
/*
  Expanded(child: Consumer<HomeViewModel>(
                builder: (context,homeviewmodel,_){
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12
                    ),
                    itemBuilder: (_,index){
                      return RoomWidget(homeviewmodel.rooms[index]);
                    },
                    itemCount: homeviewmodel.rooms.length,
                  );
        }
              )
   */
}
