import 'package:chat_app/repository/massage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/const.dart';

class text_massage extends StatefulWidget {
  text_massage(
      {super.key,
      required this.username,
      required this.time,
      required this.massage,
      required this.imageUrl,
      required this.seen,
      required this.massageid,
      required this.able_to_delete,
      required this.chatid});
  String username;
  String time;
  String massage;
  String imageUrl;
  bool seen;
  String massageid;
  bool able_to_delete;
  String chatid;
  @override
  State<text_massage> createState() => _text_massageState();
}

class _text_massageState extends State<text_massage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
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
            //user image
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            ),
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
                  //text massage

                  Container(
                    width: 190.w,
                    height: widget.massage.length > 40
                        ? widget.massage.length * 1.h
                        : 40.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        widget.massage,
                        style: TextStyle(
                            fontSize: 11.sp, fontWeight: FontWeight.bold),
                      ),
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
