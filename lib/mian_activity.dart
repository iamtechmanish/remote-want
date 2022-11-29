import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'common_functions.dart';
import 'in_app_web_page.dart';

class MainActivity extends StatefulWidget {


  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  int currentPage = 0 ;

  Color appColor = Color(0xff1267d2);

  late InAppWebViewController homeWebViewController , jobsWebViewController , employersWebviewController ;

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        if(currentPage==0){

          if(await homeWebViewController.canGoBack()) {
            homeWebViewController.goBack();
            return false ;
          }

          showExitDialog(context);
          return false;


        }
        else if(currentPage==1){
          if(await jobsWebViewController.canGoBack()) {
            jobsWebViewController.goBack();
            return false ;
          }
          else {
           setState(() {
             currentPage = 0 ;
           });
           return false ;
          }
        }
        else if(currentPage==2){

          if(await employersWebviewController.canGoBack()) {
            employersWebviewController.goBack();
            return false ;
          }
          else {
            setState(() {
              currentPage = 0 ;
            });
            return false ;
          }
        }
        else {
          showExitDialog(context);
          return false ;
        }


      },
      child: Scaffold(
          body: IndexedStack(
            index: currentPage,
            children: [
              InAppWebPage(url:"https://remotewant.com/", onWebViewCreated: (webViewController){
                homeWebViewController = webViewController ;
              },),
              InAppWebPage(url:"https://remotewant.com/all-jobs/", onWebViewCreated: (webViewController){
                jobsWebViewController = webViewController ;
              },),
              InAppWebPage(url:"https://remotewant.com/employers/", onWebViewCreated: (webViewController){
                employersWebviewController
                = webViewController ;
              },),
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
      ),
    );
  }
}
