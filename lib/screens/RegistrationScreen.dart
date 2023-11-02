import 'package:flutter/material.dart';
import 'package:groups/constant/constant.dart';
import 'package:groups/components/ReusableInputField.dart';
import 'package:groups/components/ReusableButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groups/screens/ChatSceeen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _modalProgressHUD = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _modalProgressHUD,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/logo.png'),
                      ),
                    ),
                  ),
                  ReusableInputField(
                    onChange: (value) {
                      email = value;
                      print(value);
                    },
                    labelText: 'Enter Email',
                  ),
                  ReusableInputField(
                    onChange: (value) {
                      password = value;
                    },
                    labelText: 'Enter Password',
                    obscure: true,
                  ),
                  ReusableButton(
                    onPressed: () async {
                      setState(() {
                        _modalProgressHUD = true;
                      });

                      try {
                        var logIn = await _auth.createUserWithEmailAndPassword(
                            email: email!, password: password!);
                        Navigator.pushNamed(context, ChatScreen.id);
                     
                      } catch (e) {
                       
                        var snackBar = const SnackBar(
                          content: Text('Invalid Credentials'),
                          backgroundColor: Color.fromARGB(255, 4, 2, 2),
                          duration: Duration(seconds: 5),
                        );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        

                        print(e);
                      }finally{
                           setState(() {_modalProgressHUD = false;});
                      }
                    },
                    text: "Register",
                    colorBtnBg: kAppBarColor,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
