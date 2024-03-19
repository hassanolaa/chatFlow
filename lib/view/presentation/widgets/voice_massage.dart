


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:chat_app/repository/massage_repository.dart';

import '../../../const/const.dart';

class voice_massage extends StatefulWidget {
   voice_massage({super.key
  , required this.username,
      required this.time,
      required this.massage,
      required this.imageUrl,
      required this.seen,
      required this.massageid,
      required this.able_to_delete,
      required this.chatid
  
  });
String username;
  String time;
  String massage;
  String imageUrl;
  bool seen;
 String massageid;
  bool able_to_delete;
  String chatid;
  @override
  State<voice_massage> createState() => _voice_massageState();
}

class _voice_massageState extends State<voice_massage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        if (widget.able_to_delete) {
           showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: background,
                title: Text('Delete',style: TextStyle(color: textcolor),),
                content: Text('Do you want to delete this massage?',style: TextStyle(color: textcolor)),
                actions: [
                  TextButton(
                    onPressed: () {
                      massage_repository.deleteMessage(
                          widget.chatid, widget.massageid);
                    },
                    child: Text('Delete',style: TextStyle(color: color2)),
                  ),
                ],
              );
            },
          );
          }
      
      },
      child: Container(
            // text massage with user image and name and time
            width: 70.w,
            // height: 80.h,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                
                //user name and time
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 8.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                                color: textcolor,
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                          width: 90.w,
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                                color: textcolor,

                              fontSize: 8.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.seen
                            ? Icon(
                                Icons.done_all,
                                size: 15.sp,
                                color: color3,
                              )
                            : Icon(
                                Icons.done,
                                size: 15.sp,
                                color: textcolor,
                              ),
                        ],
                      ),
                      //voice massage
                      Container(
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: textcolor, width: 1.w),
                        ),
                        width: 230.w,
                        height: 40.h,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: VoiceMessageView(
                              counterTextStyle: TextStyle(
                                color: textcolor,
                                fontSize: 10.sp,
                              ),
                              innerPadding: 2,
                              circlesColor: textcolor,
                              backgroundColor: background,
                              activeSliderColor: textcolor,
                              size: 30,
                                controller: VoiceController(
                                audioSrc: "https://firebasestorage.googleapis.com/v0/b/hhstudios-4ce70.appspot.com/o/records%2Fsample3.m4a?alt=media&token=86fb2898-092c-4714-acac-5a02056b91c0",
                                maxDuration: const Duration(seconds: 0),
                                isFile: false,
                                onComplete: () {},
                                onPause: () {
                                  print('paused');
                                },
                                onPlaying: () {
                                  print('playing');
                                },
                                onError: (err) {},
                                ),
                              )
    ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}