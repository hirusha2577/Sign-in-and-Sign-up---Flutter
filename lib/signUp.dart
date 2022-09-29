import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test1/mainPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _displayName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _displayName,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                    ),
                    validator: (String val){
                      if(val.isEmpty){
                        return "Please Enter Name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    validator: (String val){
                      if(val.isEmpty){
                        return "Please Enter Email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "password",
                    ),
                    validator: (String val){
                      if(val.isEmpty){
                        return "Please Enter Password";
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: OutlineButton(
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          await _signUp();
                        }
                      },
                      child: Text("Sign Up"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _signUp() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text))
        .user;
    if(user != null){
      if(!user.emailVerified){
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return MainPage(
          user: user1,
        );
      }));
    }
  }

}
