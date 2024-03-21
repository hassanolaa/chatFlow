import 'package:chat_app/const/const.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/calls.dart';
import '../screens/massages.dart';
import '../screens/profile.dart';
import '../screens/status.dart';


List<Widget> _SelectedTab = [
  massages(),
  status(),
  Container(),
  calls(),
  profile(),
];

class navi extends StatefulWidget {
  const navi({super.key});

  @override
  State<navi> createState() => _naviState();
}

class _naviState extends State<navi> {
  var _selectedTab = _SelectedTab[0];
  int selected = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab[i];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    user_repository.userLastSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedTab,
      floatingActionButton: Container(
          height: 70.h,
          margin: EdgeInsets.only(left: 40, right: 20, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [color1, color2],
            // ),
            image: DecorationImage(
              image: AssetImage('assets/back.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 0;
                    _handleIndexChanged(0);
                  });
                },
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: selected == 0 ? color1 : Colors.transparent,
                    border: Border.all(color: color1, width: 1),
                  ),
                  child: Icon(Icons.chat_bubble_outline,color: color3,),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 1;
                    _handleIndexChanged(1);
                  });
                },
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: selected == 1 ? color1 : Colors.transparent,
                    border: Border.all(color: color1, width: 1),
                  ),
                  child: Icon(Icons.image_outlined,color: color3,),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 2;
                    _handleIndexChanged(2);
                  });
                },
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundColor: color3,
                  child: Icon(Icons.add,color: Colors.black,),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 3;
                    _handleIndexChanged(3);
                  });
                },
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: selected == 3 ? color1 : Colors.transparent,
                    border: Border.all(color: color1, width: 1),
                  ),
                  child: Icon(Icons.call_sharp,color: color3,),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 4;
                    _handleIndexChanged(4);
                  });
                },
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: selected == 4 ? color1 : Colors.transparent,
                    border: Border.all(color: color1, width: 1),
                  ),
                  child: Icon(Icons.person_outline_outlined,color: color3,),
                ),
              ),
            ],
          )
          //  DotNavigationBar(
          //   borderRadius: 20.r,
          //   backgroundColor: Colors.transparent,

          //   currentIndex: _SelectedTab.indexOf(_selectedTab),
          //   onTap: (i) {
          //     _handleIndexChanged(i);
          //   },
          //   // dotIndicatorColor: Colors.black,
          //   items: [
          //     /// Massages
          //     DotNavigationBarItem(
          //       icon: Column(
          //         children: [
          //           Icon(Icons.chat_bubble_outline_outlined),
          //           Text('Massages'),
          //         ],
          //       ),
          //       selectedColor: Colors.purple,
          //     ),

          //     /// Likes
          //     DotNavigationBarItem(
          //        icon: Column(
          //         children: [
          //           Icon(Icons.image_outlined),
          //           Text('Massages'),
          //         ],
          //       ),
          //       selectedColor: Colors.pink,
          //     ),
          //  /// Search
          //     DotNavigationBarItem(
          //       icon:Icon(Icons.add),
          //       selectedColor: Colors.orange,
          //     ),
          //     /// Search
          //     DotNavigationBarItem(
          //       icon: Column(
          //         children: [
          //           Icon(Icons.image_outlined),
          //           Text('Massages'),
          //         ],
          //       ),
          //       selectedColor: Colors.orange,
          //     ),

          //     /// Profile
          //     DotNavigationBarItem(
          //        icon: Column(
          //         children: [
          //           Icon(Icons.image_outlined),
          //           Text('Massages'),
          //         ],
          //       ),
          //       selectedColor: Colors.teal,
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
