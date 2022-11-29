import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showExitDialog(BuildContext context) {
  showDialog(
    // backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure, you want to exit this app?"),
          actions: [
            ButtonTheme(
              hoverColor: Colors.blue[200],
              child: TextButton(
                  onPressed: () {
                    SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop');
                    // Navigator.pop(context);
                  },
                  child: Text("Yes")),
            ),
            ButtonTheme(
              focusColor: Colors.blue[200],
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            )
          ],
        );
      });
}