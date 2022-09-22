import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDatabase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) {
              return MyUser.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyUser, SetOptions) => MyUser.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser myUser) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    await documentRef.set(myUser);
    return myUser;
  }

  static Future<MyUser?> retriveUserById(String id) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(id);
    var result = await documentRef.get();
    return result.data();
  }

  static CollectionReference<MyRoom> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(MyRoom.routeName)
        .withConverter<MyRoom>(
            fromFirestore: (snapshot, options) {
              return MyRoom.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyRoom, SetOptions) => MyRoom.toFireStore());
  }

  static Future<void> insertRoom(MyRoom myRoom) {
    var documentRef = getRoomCollection().doc();
    myRoom.id = documentRef.id;
    var result = documentRef.set(myRoom);
    return result;
  }

  static Future<List<MyRoom>> loadRooms() async {
    var collectionRefer = await getRoomCollection().get();
    var result =
        collectionRefer.docs.map((category) => category.data()).toList();
    return result;
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(MyRoom.routeName)
        .doc(roomId)
        .collection(Message.routeName)
        .withConverter<Message>(
            fromFirestore: (snapshot, options) {
              return Message.fromFireStore(snapshot.data()!);
            },
            toFirestore: (Message, SetOptions) => Message.toFireStore());
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var collectionRefe = getMessageCollection(roomId).doc();
    message.id = collectionRefe.id;

    return collectionRefe.set(message);
  }
}
