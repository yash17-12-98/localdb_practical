import 'package:flutter/material.dart';

import 'add_item.dart';

class TabViewItem extends StatefulWidget {
  const TabViewItem({Key? key}) : super(key: key);

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("LIST OF ITEMS"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            // Padding(
            //     padding: EdgeInsets.only(right: 20.0),
            //     child: GestureDetector(
            //       onTap: () {},
            //       child: Icon(
            //         Icons.search,
            //         size: 26.0,
            //       ),
            //     )
            // ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AddItem();
                    }));
                  },
                  child: Icon(
                      Icons.add
                  ),
                )
            ),
          ],
          bottom: TabBar(
            onTap: (int index) {
              print('index $index');
            },
            indicatorColor: Colors.white,
            isScrollable: true,
            labelStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width / 27),
            tabs: <Widget>[
              Container(width: 100.0, child: Tab(text: "Items List")),
              Container(width: 100.0, child: Tab(text: "Favourite List")),

            ],
          ),
        ),
      ),
    );
  }
}
