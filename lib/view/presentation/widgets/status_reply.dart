import 'package:chat_app/model/status.dart';
import 'package:chat_app/repository/massage_repository.dart';
import 'package:chat_app/view/presentation/screens/status.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../const/const.dart';
import '../../../model/status_typedet.dart';

class status_reply extends StatefulWidget {
  status_reply({super.key, required this.status, required this.id});
  status_model status;
  String id;
  @override
  State<status_reply> createState() => _status_replyState();
}

class _status_replyState extends State<status_reply> {
  TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.08,
      margin: EdgeInsets.only(left: 40, right: 20, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
        // image: DecorationImage(
        //   image: AssetImage('assets/back.gif'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Row(
        children: [
          // send massage

          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 205.w,
              child: TextFormField(
                controller: massageController,
                decoration: InputDecoration(
                  hintText: 'reply to status',
                  hintStyle: TextStyle(
                    color: textcolor,
                    fontSize: 15.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // emoji icon
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: GestureDetector(
              onTap: () {
                ElegantNotification.info(
                  background: backbackground,
                  title: Text(
                    "Sorry",
                    style: TextStyle(color: textcolor),
                  ),
                  description: Text("This feature coming soon !",
                      style: TextStyle(color: textcolor)),
                ).show(context);
              },
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: backbackground,
                child: Icon(
                  Icons.emoji_emotions,
                  size: 15.sp,
                  color: textcolor,
                ),
              ),
            ),
          )
          // send icon
          ,
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: GestureDetector(
              onTap: () async {
                // send massage
                if (await massage_repository.checkChat(widget.id)) {
                  String chatid = await massage_repository.getChatId(widget.id);
                  print(chatid);
                  
                  massage_repository.sendMessage(
                      chatid, massageController.text, 0);
                } else {
                  massage_repository.createChat(
                    Uuid().v4(),
                    FirebaseAuth.instance.currentUser!.uid,
                    widget.id,
                  );
                  String chatid = await massage_repository.getChatId(widget.id);
                  print(chatid);
                  massage_repository.sendMessage(
                      chatid, massageController.text, 0);
                }

                massageController.clear();
              },
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: backbackground,
                child: Icon(
                  Icons.send,
                  size: 15.sp,
                  color: textcolor,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate(effects: [FadeEffect(duration: Duration(seconds: 2))]);
  }
}
