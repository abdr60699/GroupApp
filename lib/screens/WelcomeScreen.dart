import 'package:flutter/material.dart';
import 'package:groups/constant/constant.dart';
import 'package:groups/components/ReusableButton.dart';
import 'package:groups/screens/LoginScreen.dart';
import 'package:groups/screens/RegistrationScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

      
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Hero(
                    tag: 'logo',
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      WavyAnimatedText(' GroupGram',
                          textStyle: TextStyle(fontSize: 30))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ReusableButton(
                  text: 'Login',
                  colorBtnBg: Colors.blueAccent,
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginScreen.id)),
              ReusableButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.id),
                text: 'Register',
                colorBtnBg: kAppBarColor,
              ),
              ElevatedButton(
              style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: (){}, child: Text('India'))
            ]),
      ),
    );
  }
}

