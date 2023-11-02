import 'package:flutter/material.dart';
import 'package:groups/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var loggedUser;
bool? isMe;
final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  TextEditingController inputController = TextEditingController();
  String? texts;

  getUserData() async {
    loggedUser = await _auth.currentUser?.email;
    var currentLogin = await _auth.currentUser?.email;

    currentLogin == loggedUser ? isMe = true : isMe = false;

    print(' Logged USer ==> $loggedUser');
    print('  CurrentUser ==>   $currentLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('GroupGram'),
        backgroundColor: kAppBarColor,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/logo.png'),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                // getUserData();
                _auth.signOut();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessageStream(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => {texts = value},
                      controller: inputController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kAppBarColor)),
                        hintText: 'Enter Message...',
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kAppBarColor),
                          elevation: MaterialStateProperty.all(5)),
                      onPressed: () async {
                        await _fireStore.collection('messages').add({
                          'text': texts,
                          'sender': loggedUser,
                          'createdDate': DateTime.now()
                        });

                        inputController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ]),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('messages')
            .orderBy('createdDate', descending: true)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Text('No Data');
          }
          List<Widget> listSms = [];
          var messages = snapshots.data?.docs;

          // try {

          //   if (!snapshots.hasData) {
          //     return Center(
          //         child: CircularProgressIndicator(
          //             backgroundColor: Colors.blueAccent));
          //   }
          //   for (var sms in messages!) {
          //     var messageData = sms;
          //     var text = messageData['text'] ?? '';
          //     var sender = messageData['sender'] ?? '';
          //     print('text ===> $sender');
          //     if (sender == loggedUser) {
          //       isMe = true;
          //     } else {
          //       isMe = false;
          //     }

          //     var messageWidget = MessageBubble(
          //       text: text,
          //       sender: sender,
          //       currentUser: sender == loggedUser,
          //     );
          //     // listSms.add(messageWidget);
          //   }
          // } catch (e) {
          //   print(e);
          // }

          return Expanded(
            child: ListView.builder(
              itemCount: messages!.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return MessageBubble(
                  text: message['text'] ?? "",
                  sender: message['sender'] ?? '',
                  currentUser: message['sender'] == loggedUser,
                );
              },
            ),
          );

          // return Expanded(
          //   child: ListView(
          //     reverse: true,
          //     children: listSms,
          //   ),
          // );
        });
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.text, required this.sender, required this.currentUser});

  final String text;
  final String sender;
  final bool currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          currentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: currentUser
                ? BorderRadius.circular(30)
                    .copyWith(topRight: Radius.circular(0))
                : BorderRadius.circular(30)
                    .copyWith(topLeft: Radius.circular(0)),
            elevation: 6,
            color: currentUser
                ? kAppBarColor
                : const Color.fromARGB(255, 244, 125, 125),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// class MessageBubble extends StatelessWidget {
//   const MessageBubble({
//     required this.text,
//     required this.sender,
//   });

//   final String text;
//   final String sender;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Material(
//         elevation: 6,
//         color: kAppBarColor,
//         child: Column(
//           children: [
//             Text(text),
//             Text(sender),
//           ],
//         ),
//       ),
//     );
//   }
// }