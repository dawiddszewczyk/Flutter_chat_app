import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async {
    return await Firestore.instance.collection("users").where("name", isEqualTo: username).getDocuments();

  }
  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        .getDocuments();
  }
  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection("email").where("name", isEqualTo: userEmail).getDocuments();
  }
  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap);
  }
  createChatRoom(String charRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(charRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  addConversationMessages(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }
  getConversationMessages(String chatRoomId)async{
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: true)
        .snapshots();
  }
  getChatRooms(String userName) async{
    return await Firestore.instance.collection("ChatRoom")
        .where("users",arrayContains: userName)
        .snapshots();
  }
}