import 'package:fgh/ip.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Chat extends StatefulWidget {

  final int id;
  final String name;
  final String lastOnline;
  final String ownEmail;

  const Chat({super.key, required this.id, required this.name, required this.lastOnline, required this.ownEmail});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  // bool statusOnline = false;

  IOWebSocketChannel checkOnlineChannel = IOWebSocketChannel.connect('ws://$ip:8080/check_online');
  @override

  // List<User> _users = [];

  void initState() {
    super.initState();
    checkOnlineChannel.sink.add(widget.ownEmail);
    checkOnlineChannel.stream.listen((event) {
      print(event);
    });
  }

  // Future<void> _fetchUsers() async {
    // final userMaps = await DatabaseHelper.instance.queryAllUsers();
  //   setState(() {
  //     _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
  //   });
  // }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              Text(widget.name),
              Text(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.lastOnline)+3*3600000).toString()),

            ]
          ),
        ),
      ),
      body: Text(widget.lastOnline),
      floatingActionButton: FloatingActionButton(onPressed: ()=>{
        checkOnlineChannel.sink.add(widget.ownEmail)

      },
      child: const Text('click'),),
    );
  }

  
}