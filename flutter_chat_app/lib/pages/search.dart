import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/helper/helperfun.dart';
import 'package:flutter_chat_app/pages/services/database.dart';
import 'helper/constans.dart';
import 'conversation_screen.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
String _myName;
bool haveUserSearched = false;
class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchText_E_C = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.searchByName(searchText_E_C.text).then((val){setState(() {
      searchSnapshot = val;
      print("$searchSnapshot to jest snapshot do luja wafla");
      setState(() {
        haveUserSearched = true;
      });
    });
    });
  }

  Widget searchList(){
    return haveUserSearched ? ListView.builder(
        shrinkWrap: true,
      itemCount: searchSnapshot.documents.length,
        itemBuilder: (context,index){
          return SearchTile(
            searchSnapshot.documents[index].data["name"] ,
            searchSnapshot.documents[index].data["email"],
          );
        }) : Container();
  }


  createChatroomAndStartConversation(String username){
      print('$username TO JEST NICK');
      print('${Constants.myName} TO JEST myname');
      String chatRoomid = getChatRoomId(username, Constants.myName);

      List<String> users = [username, Constants.myName];
      Map<String, dynamic> charRoomMap={
        "users" : users,
        "charoomld": chatRoomid
      };
      DatabaseMethods().createChatRoom(chatRoomid, charRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomIdl: chatRoomid
          )
      ));

  }
  Widget SearchTile(String userName,String userEmail){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical:16 ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(userName),
              Text(userEmail),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap:() {
              createChatroomAndStartConversation(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message"),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Szukaj znajomych"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
              Container(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchText_E_C,
                        decoration: InputDecoration(
                          hintText: "Search username...",
                          hintStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        initiateSearch();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12)),
                    )
                  ],
                ),
              ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}