
import 'package:chat_app/const/const.dart';
import 'package:flutter/material.dart';

Widget edit_profile(){
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // circle avatar
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'bio',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      
        
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color3
          ),
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
    ),
  );
}