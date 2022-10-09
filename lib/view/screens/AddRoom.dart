import 'package:chat/repository/repository_impl.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view_model/AddRoom_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/categories.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'AddRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends BaseState<AddRoom, AddRoomViewModel>
    implements AddRoomNavigator {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descController = TextEditingController();
  List<RoomCategory> category = RoomCategory.getRoomCategory();
  late RoomCategory selectedCategory;

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel(repository: ChatRepository());
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = category[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.fill)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
            margin: const EdgeInsets.all(25),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            elevation: 30,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Create New Room',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset('images/room_image.png'),
                          TextFormField(
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.bodySmall,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter name room';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: 'Enter  Room Name',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFF797979))),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownButton<RoomCategory>(
                              value: selectedCategory,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 1,
                                color: const Color(0xFF797979),
                              ),
                              items: category.map((category) {
                                return DropdownMenuItem<RoomCategory>(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            height: 48,
                                            width: 48,
                                            'images/${category.imageName}'),
                                      ),
                                      Text(category.name),
                                    ],
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectedCategory = item!;
                                });
                              }),
                          TextFormField(
                            maxLines: 3,
                            minLines: 3,
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.bodySmall,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter description room';
                              }
                              return null;
                            },
                            controller: descController,
                            decoration: InputDecoration(
                                hintText: 'Enter  Room Description',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFF797979))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          createRoom();
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            padding: EdgeInsets.all(15)),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void createRoom() {
    if (formKey.currentState?.validate() == false) return null;

    viewModel.createRoom(
        nameController.text, descController.text, selectedCategory.id);
  }

  @override
  goback() {
    Navigator.pop(context);
  }
}
