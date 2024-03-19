

import 'package:chat_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class calls extends StatefulWidget {
  const calls({super.key});

  @override
  State<calls> createState() => _callsState();
}

class _callsState extends State<calls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            SizedBox(height: 70.h,),
          // row "calls"and add post icon
          Row(
            
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Calls",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: 170.w,),
               CircleAvatar(
                 radius: 20.r,
                 backgroundColor: backbackground,
                 child: Icon(Icons.camera_alt_outlined,size: 30.sp,color:textcolor, )),
              SizedBox(width: 20.w,),
            
            ],
          ),
          SizedBox(height: 20.h,),
          // recent calls text
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: Text("Recent",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          // listview.builder of recent calls
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(left: 20.w,right: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: AssetImage("assets/images/user.jpg"),
                          ),
                          SizedBox(width: 20.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User Name",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                              Text("Yesterday, 10:00 PM",style: TextStyle(fontSize: 12.sp,color: textcolor),),
                            ],
                          ),
                          SizedBox(width: 100.w,),
                          Icon(Icons.call,color: textcolor,size: 20.sp,)
                        ],
                      ),
                      Divider(color: textcolor,)
                    ],
                  ),
                );
              },
            ),
          )
         
        ],
      ).animate(effects: [ FadeEffect(duration: Duration(seconds: 1))]),
    );
  }
}