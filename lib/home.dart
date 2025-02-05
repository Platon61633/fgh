// import 'package:flutter/foundation.dart';
import 'package:fgh/DB/db_user.dart';
import 'package:fgh/chat.dart';
import 'package:fgh/options/get_users.dart';
import 'package:fgh/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  

  const Home({super.key, required this.email});

  final String email;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future getusers()async{
    return await GetUsers().getUsers().then((r)=>r);
  }

  // List<Map> users = [{"id": '', "name": '', "email": '', "start_dt": '', "last_online_dt": ''}];

  List users = [];

  @override
  void initState() {
    super.initState();

    getusers().then((r)=>
    setState(() {
      users = r;
    })
    );
  }



  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        
        preferredSize: const Size.fromHeight(60.0), 
        child: Container(
          color: const Color.fromARGB(255, 218, 189, 4),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              // height: 100,
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile())), 
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/user.jpg'),
                    )),
                ),
                const Expanded(
                  child: Center(child: Text('Simple', style: TextStyle(fontSize: 20, color: Colors.white),))
                ),
              ]),
          )
            ),
        )
      ),
      body:  users.isEmpty ? const Text('Loading...') : chats()
    );
  }

  CustomScrollView chats() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          floating: true,
          title: SearchLine(),
          automaticallyImplyLeading: false,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return chatUser(users[index]['id'], users[index]['name'], users[index]['last_online_dt']);
          },
          childCount: users.length,
        ),
        )
      ]
    );
  }

  Container SearchLine() {
    return Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(
                fontSize: 14
              ),
              contentPadding: EdgeInsets.all(8),
              // Add a clear button to the search bar
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
              // Add a search icon or button to the search bar
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(users);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        );
  }

  TextButton chatUser(int id, String name, String lastOnline) {
    return TextButton(
      onPressed: ()=>goToChat(id, name, lastOnline),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero
      ),
      child: 
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.3,
              color: Colors.black
            )
          ),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/user.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, ),
              )
            ],
          ),
        )
      );
  }

  void goToChat(int id, String name, String lastOnline) {
      print((id,name, lastOnline, widget.email));
      DB_user.instance.getUser().then((value) {
      print(value);});
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Chat(id: id, name: name, lastOnline: lastOnline, ownEmail: widget.email)),
      );
  }

}