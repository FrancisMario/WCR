
import 'package:flutter/material.dart';
import 'package:wcr/blog.dart';
import 'package:wcr/blogComponents.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}
class _Home extends State<Home>{

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   List<Widget> _widgetOptions = <Widget>[
    Text("data"),
    Text("data"),
    DetailedBlogView(),
    Blog()
  ];
  

  void _onItemTapped(int index) {
    setState(() {
      print(index.toString() + 'pressed');
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child:_widgetOptions.elementAt(_selectedIndex),
        ),


      bottomNavigationBar:  
        BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text('Live'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            title: Text('Podcast',),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Blogs'),
          ),
        ],
         currentIndex: _selectedIndex,
         selectedItemColor: Colors.red[800],
         onTap: _onItemTapped,
        )
    ); 
  }
}
