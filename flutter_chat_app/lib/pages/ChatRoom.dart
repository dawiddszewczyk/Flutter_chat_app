import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/search.dart';
import 'package:flutter_chat_app/pages/services/database.dart';
import 'Authservice.dart';
import 'helper/constans.dart';
import 'package:flutter_chat_app/pages/helper/helperfun.dart';
import 'conversation_screen.dart';
class Chatrooms extends StatefulWidget {
  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream  chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context,snapshot){
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context,index){
            return ChatRoomsTile(
              userName: snapshot.data.documents[index].data["charoomld"]
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants.myName, ""),
              chatRoomId: snapshot.data.documents[index].data["charoomld"],
            );
        },
      ) : Container();
      },
    );
  }

  void initState(){
    getUserInfo();
    print("${Constants.myName} to moj name z chatroom");
    super.initState();
  }
  


  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      if(this.mounted){
        setState(() {
           chatRoomsStream = value;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              AuthService().signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchScreen()
          ));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatRoomIdl: chatRoomId,
            )
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}