import 'package:chat/model/message.dart';
import 'package:chat/model/my_room.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository extends Repository {
  @override
  CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) {
              return MyUser.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyUser, SetOptions) => MyUser.toFireStore());
  }

  @override
  Future<MyUser?> insertUser(MyUser myUser) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    await documentRef.set(myUser);
    return myUser;
  }

  @override
  Future<void> deleteRoom(MyRoom myRoom) async {
    var snapshot = await getRoomCollection().doc(myRoom.id);
    return snapshot.delete();
  }

  @override
  Future<MyUser?> retriveUserById(String id) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(id);
    var result = await documentRef.get();
    return result.data();
  }

  @override
  CollectionReference<MyRoom> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(MyRoom.routeName)
        .withConverter<MyRoom>(
            fromFirestore: (snapshot, options) {
              return MyRoom.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyRoom, SetOptions) => MyRoom.toFireStore());
  }

  @override
  Future<void> insertRoom(MyRoom myRoom) {
    var documentRef = getRoomCollection().doc();
    myRoom.id = documentRef.id;
    var result = documentRef.set(myRoom);
    return result;
  }

  @override
  Stream<QuerySnapshot<MyRoom>> loadRooms() {
    var collectionRefer = getRoomCollection().snapshots();
    return collectionRefer;
  }

  @override
  CollectionReference<Message> getMessageCollection(String roomId) {
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

  @override
  Future<void> sendMessage(String roomId, Message message) {
    var collectionRefe = getMessageCollection(roomId).doc();
    message.id = collectionRefe.id;

    return collectionRefe.set(message);
  }
}
