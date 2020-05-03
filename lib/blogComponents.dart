import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * class detailed blog view
 */

class DetailedBlogView extends StatelessWidget{
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            // Header details row
            Row(
              children: <Widget>[
                Expanded(child:
                // Blog Logo Box 
                  Container(
                    width: 50,
                    height: 100, 
                    child: Image.network("src"),
                   )
                  ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[Text("NAME")],),
                      Row(children: <Widget>[Text("200 subs")],),
                      Row(children: <Widget>[Text("200 articles")],),
                      Row(children: <Widget>[Text("Mario G")],),
                    ],
                  ),
                )
              ],
            ),
            // Description Details
            Row(children: <Widget>[
              // Description Header 
              Text("Description"),
              // Divider line
              Row(children: <Widget>[
                Expanded(flex:2,child: null),
                Expanded(flex:10,child: Divider()),
                Expanded(flex:2,child: null),
              ],),
              // Description 
              Text("Blog description"),
            ],),

              // Blog Catalog 
                Column(
                  children:<Widget>[
                   Container(alignment:Alignment.center,width: 100,child: Divider(),),
                   Container(alignment:Alignment.center,child: Text("Category"),),
                   Container(alignment:Alignment.center,width: 100,child: Divider(),),
                  ]
                )
              
          ],
        ),
      ),
    );
  }
  
}