// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        
        preferredSize: const Size.fromHeight(40.0), 
        child: Container(
          color: const Color.fromARGB(255, 218, 189, 4),
          child: SafeArea(
            child: Center(
              child: Text(
                'Simple',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            )
            ),
        )
      ),
      body: CustomScrollView(
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
              return chatUser();
            },
            childCount: 20,
          ),
          )
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
          // chatUser(),
        ]
      )
    );
  }

  Container SearchLine() {
    return Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(
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
                  // Perform the search here
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        );
  }

  Container chatUser() {
    return Container(
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
                child: Text('useru', ),
              )
            ],
          ),
        );
  }
}