import 'package:flutter/material.dart';
import 'package:test1/signIn.dart';
import 'package:test1/signUp.dart';

class FirebaseAuthDemo extends StatefulWidget {
  @override
  _FirebaseAuthDemoState createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: OutlineButton(
              onPressed: (){
                _push(context, SignIn());
              },
              child: Text("sign In"),

            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: OutlineButton(
              onPressed: (){
                _push(context, SignUp());
              },
              child: Text("sign Up"),
            ),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget page){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

}
