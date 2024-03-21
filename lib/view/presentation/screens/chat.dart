import 'package:chat_app/model/chat_route.dart';
import 'package:chat_app/repository/massage_repository.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:chat_app/view/presentation/meeting/Screens/joinMeeting.dart';
import 'package:chat_app/view/presentation/widgets/file_massage.dart';
import 'package:chat_app/view/presentation/widgets/massages_sender.dart';
import 'package:chat_app/view/presentation/widgets/navi.dart';
import 'package:chat_app/view/presentation/widgets/text_massage.dart';
import 'package:chat_app/view/presentation/widgets/voice_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../const/const.dart';
import '../meeting/Screens/SplashScreen.dart';
import '../widgets/image_massage.dart';
import '../widgets/video_massage.dart';

class chat extends StatefulWidget {
  chat(
      {super.key,
      required this.chatid,
      required this.userimage,
      required this.username});
  String chatid;
  String username;
  String userimage;

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  String lastseen = "";

    getlastseen()async{
   lastseen=await user_repository.getLastSeenByUsername(widget.username);
   setState(() {
     
   });
    }


  @override
  void initState() {
    // TODO: implement initState
    massage_repository.seenMessage(widget.chatid);
    getlastseen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backbackground,
      floatingActionButton: massages_sender(
        chatid: widget.chatid,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45.h,
          ),
          // user chat screen
          // row another user name and call icon
          Row(
            children: [
              //back arrow
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/navi');
                  },
                  child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: backbackground,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15.sp,
                        color: textcolor,
                      )),
                ),
              ),
              //user image
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [color1, color3],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight)),
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        widget.userimage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // user name - state
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold,color: color4),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      " Last Seen: $lastseen",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: color3),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 60.w,
              ),
              // call icon
              CircleAvatar(
                  radius: 12.r,
                  backgroundColor: backbackground,
                  child: Icon(
                    Icons.call,
                    size: 20.sp,
                    color: textcolor,
                  )),
              SizedBox(
                width: 20.w,
              ),
              // video call icon
              GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: ((context) =>JoinScreen())));
                },
                child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: backbackground,
                    child: Icon(
                      Icons.videocam,
                      size: 20.sp,
                      color: textcolor,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          // massages
          Expanded(
            child: Container(
                color: backbackground,
                child: StreamBuilder(
                    stream: massage_repository.getMessages(widget.chatid),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (user_repository.getCurrentUser()!.uid ==
                              snapshot.data!.docs[index]['userId']) {
                            if (snapshot.data!.docs[index]["type"] == 0) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 100.w, right: 20.w, bottom: 20.h),
                                  child: text_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: snapshot.data!.docs[index]
                                        ["seen"],
                                        able_to_delete: true,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                1) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 100.w, right: 20.w, bottom: 20.h),
                                  child: image_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: snapshot.data!.docs[index]
                                        ["seen"], able_to_delete: true,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                2) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 100.w, right: 20.w, bottom: 20.h),
                                  child: video_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: snapshot.data!.docs[index]
                                        ["seen"], able_to_delete: true,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                3) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 100.w, right: 20.w, bottom: 20.h),
                                  child: file_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: snapshot.data!.docs[index]
                                        ["seen"], able_to_delete: true,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            }
                            else if (snapshot.data!.docs[index]["type"] ==
                                4) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 100.w, right: 20.w, bottom: 20.h),
                                  child: voice_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: snapshot.data!.docs[index]
                                        ["seen"], able_to_delete: true,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            }
                          } else if (user_repository.getCurrentUser()!.uid !=
                              snapshot.data!.docs[index]['userId']) {
                            if (snapshot.data!.docs[index]["type"] == 0) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 100.w, bottom: 20.h),
                                  child: text_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                        seen:false,
                                        able_to_delete: false,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                1) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 100.w, bottom: 20.h),
                                  child: image_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen:false, able_to_delete: false,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                2) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 100.w, bottom: 20.h),
                                  child: video_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: false,
                                          able_to_delete: false,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            } else if (snapshot.data!.docs[index]["type"] ==
                                3) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 100.w, bottom: 20.h),
                                  child: file_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: false,
                                          able_to_delete: false,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            }else if (snapshot.data!.docs[index]["type"] ==
                                4) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 100.w, bottom: 20.h),
                                  child: voice_massage(
                                    username: snapshot.data!.docs[index]
                                        ['username'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                    time: snapshot.data!.docs[index]
                                        ['timestamp'],
                                    massage: snapshot.data!.docs[index]
                                        ["message"],
                                         seen: false,
                                          able_to_delete: false,
                                        chatid: widget.chatid,
                                        massageid: snapshot.data!.docs[index].id,
                                  ));
                            }
                          }
                        },
                      );
                    })),
          ),
          // send massage
          SizedBox(
            child: Container(
              color: backbackground,
            ),
            height: 100.h,
          ),
        ],
      ).animate(effects: [FadeEffect(duration: Duration(seconds: 1))]),
    );
  }
}
