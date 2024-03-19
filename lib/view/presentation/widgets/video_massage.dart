import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chat_app/repository/massage_repository.dart';

import '../../../const/const.dart';

class video_massage extends StatefulWidget {
  video_massage(
      {super.key,
      required this.username,
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
  State<video_massage> createState() => _video_massageState();
}

class _video_massageState extends State<video_massage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.network(
        widget.massage);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
     // autoPlay: true,
      allowFullScreen: true,
      autoInitialize: true,
      showControls: true,
      showOptions: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
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
                  //video massage
                  Container(
                    width: 190.w,
                    height: 160.h,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child:AspectRatio(
                          aspectRatio: 100/2,
                          child: Chewie(
                            controller: _chewieController,
                          ),
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
