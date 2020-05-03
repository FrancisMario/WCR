import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BrowseBlogs extends StatefulWidget {
  @override
  _BrowseBlogs createState() => _BrowseBlogs();

  BrowseBlogs(Key key): super(key: key);
}

class _BrowseBlogs extends State < BrowseBlogs > {

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List listitems = [];

  Widget screenTitle = Container(
    child:Row(
      children: <Widget>[
        Expanded(child: Column(
          children:<Widget>[ 
            Text("B"),
            Container(child: Divider(),)
          ]
        )),
        Expanded(child: null)
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      scrollDirection: Axis.vertical,
      onRefresh: _onRefresh,
      key: widget.key,
      enablePullDown: true,
      child: Container(
        width: 100,
            child: 
                  ListView.builder(
                    itemCount: listitems.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                        return Sections.fromJson(listitems[Index]);
            },
          ),
      ),
    );
  }

  _onRefresh() async {
    // monitor network fetch
    if (await fetchBrowse()) {
      // if the fetch completed succesfully
      _refreshController.refreshCompleted();
    } else {
      // if the fetch  failed
      _refreshController.refreshFailed();
    }

  }

  Future < bool > fetchBrowse() async {
    print("getting data");
    final response = await http.get('http://192.168.137.1/wcr-api/browse.php')
                      .timeout(Duration(seconds:15),onTimeout: (){

                      });
    print("data is back");
    if (response.statusCode == 200) {  
      print("data is 200");
      // If the server did return a 200 OK response, then parse the JSON.
      var results;
      // checking for malformed json response
      try {
        results = json.decode(response.body);
        setState(() {
          listitems = results;
        });
          print("list is ${listitems.length} long");
          return true;
       
      } catch (e) {
        print("server sent a malformed json response");
        print(response.body);
        return false;
      }
         
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // throw Exception('Failed to load album');
      print("Failed to load album");
      return false;
    }
  }

}



class BlogCard extends StatelessWidget {
  final String id;
  final double width;
  final String title;
  final String image;
  final int subs;
  final List  author;
  final bool stars;

  const BlogCard({
    Key key,
    this.subs,
    this.author,
    this.stars,
    this.id,
    this.title,
    this.image,
    this.width
  }): super(key: key);


  factory BlogCard.fromJson(Map <String, dynamic> json) {
    return BlogCard(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      author: json['author'],
      stars: json['starts'],
      width: json['width'],
      subs: json['subs'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.blueAccent,
          height: 150,
          width: 300,
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: < Widget > [
              Expanded(flex: 5,
                child: Image.network(image,),
              ),
              Expanded(flex: 10,
                //  blog details
                child: Column(children: < Widget > [
                  Expanded(flex: 4, child: Row(
                    children: < Widget > [
                      Text(title)
                    ]
                  )),
                  Expanded(flex: 2, child: Row(
                    children: < Widget > [
                      Text(author[0])
                    ]
                  )),
                  Expanded(flex: 1, child: Row(
                    children: < Widget > [
                      // blogs stats
                      Expanded(child: Text(subs.toString() + 'subs')),
                    ]
                  )),
                ], ),
              )
            ]
          ),
        ),
      ],
    );
  }
}



class Sections extends StatelessWidget {
  final double height;
  final bool hasSeeAllLink;
  final String sectionId;
  final String sectionTitle;
  final List cardlist;
  Sections({this.height, this.hasSeeAllLink, this.sectionId, this.sectionTitle, this.cardlist});


  factory Sections.fromJson(Map json) {
    return Sections(
      height: json['height'],
      hasSeeAllLink: json['hasSeeAllLink'],
      sectionId: json['title'],
      sectionTitle: json['sectionTitle'],
      cardlist: json['cardlist']
    );
  }     

  @override
  Widget build(BuildContext context) {
    int loop = 0;
    return 
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left:10)),
              Container(
                // width: 200,
                child: Divider(),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 200,
                        child: Text(sectionTitle),
                        ),
                    ),
                  ],
                ),  
              Container(
                color: Colors.green,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cardlist.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    print(cardlist[Index]);
                    print(cardlist[Index]['id']);
                    print(cardlist[Index]['author'][0]);
                    return Row(
                      children: <Widget>[
                         Padding(padding: EdgeInsets.only(left:10)),
                         BlogCard.fromJson(cardlist[Index]),
                      ],
                    );
                  },
               ),
              ),
            ],
          );
  }
}


/***
 * TODO
 * - Implement a logging system to track errors
 * - Update Trending Blog UI
 * - Fix server fetches
 * - Fix manual Refresher 
 */