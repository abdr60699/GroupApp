import 'package:flutter/material.dart';

const kAppBarColor = Color.fromARGB(203, 96, 8, 17);
 PreferredSizeWidget kAppBar = AppBar(
      title: Text('GroupGram'),
      backgroundColor: kAppBarColor,
      leading:const Padding(
        padding:  EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/logo.png'),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              
            },
          ),
        )
      ],
    );