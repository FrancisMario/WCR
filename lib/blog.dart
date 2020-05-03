import 'package:flutter/material.dart';
import 'package:wcr/blogTrending.dart';

class Blog extends StatefulWidget{
      @override
      _Blog createState() => _Blog();
}

class _Blog extends State<Blog>{
  @override
  Widget build(BuildContext context) {
    var blog = new BrowseBlogs(UniqueKey());
    return Scaffold(

      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.new_releases),text: "Browse",),
                Tab(icon: Icon(Icons.my_location),text: "Subscription",),
                Tab(icon: Icon(Icons.history),text: "All",),
              ],
            ),
            ),
  
          body: TabBarView(
            children: [
                blog,
                new Text("subscription"),
                new Text("all"),
              ],
          ),
        ),
      ),
    );
  }
}



