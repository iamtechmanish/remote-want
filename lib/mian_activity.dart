import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'in_app_web_page.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  int currentPage = 0 ;

  Color appColor = Color(0xff1267d2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: [
            InAppWebPage("https://remotewant.com/"),
            InAppWebPage("https://remotewant.com/all-jobs/"),
            InAppWebPage("https://remotewant.com/employers/"),
          ],
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: currentPage,
          onTap: (index){
          setState(() {
            currentPage = index ;
          });
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
              activeColor: appColor,
            ),
            BottomBarItem(
              icon: Icon(CupertinoIcons.doc_text_search),
              title: Text('Jobs'),
              activeColor: appColor,
            ),
            BottomBarItem(
              icon: Icon(CupertinoIcons.person_2),
              title: Text('Employers'),
              activeColor: appColor,
            ),
          ],
        )
    );
  }
}
