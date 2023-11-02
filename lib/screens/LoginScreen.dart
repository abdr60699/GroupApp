import 'package:flutter/material.dart';
import 'package:groups/constant/constant.dart';
import 'package:groups/components/ReusableInputField.dart';
import 'package:groups/components/ReusableButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groups/screens/ChatSceeen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class LoginScreen extends StatefulWidget{
 
 static String id = 'LoginScreen';
@override
State<LoginScreen> createState() =>_LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
 
   FirebaseAuth _auth = FirebaseAuth.instance;
    bool _loadIcon = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loadIcon,
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
                    onChange: (Value){
                      email= Value;
                    },
                    labelText: 'Enter Email',
                  ),
                  ReusableInputField(
                     onChange: (Value){
                      password= Value;
                    },
                    labelText: 'Enter Password',
                    obscure: true,
                  ),
                  ReusableButton(
                    onPressed: ()async{
                      setState(() {
                        _loadIcon = true;
                      });
                      try{
                        await _auth.signInWithEmailAndPassword(email: email!, password: password!);
                        Navigator.pushNamed(context, ChatScreen.id);
                         setState(() {
                            _loadIcon = false;
                         });

                      }
                      catch(e){
                        print(e);
                         setState(() {                     
                            _loadIcon = false;

                         });
                          var snackBar = const SnackBar(
                          content: Text('Invalid Credentials'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    text: "Login",
                    colorBtnBg: Colors.blueAccent,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
