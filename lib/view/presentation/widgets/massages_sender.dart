import 'package:chat_app/repository/massage_repository.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:chat_app/view/presentation/widgets/send_options.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../const/const.dart';
import 'edit_profile.dart';

class massages_sender extends StatefulWidget {
  massages_sender({super.key, required this.chatid});
  String chatid;

  @override
  State<massages_sender> createState() => _massages_senderState();
}

class _massages_senderState extends State<massages_sender> {
  TextEditingController massageController = TextEditingController();
  final record = AudioRecorder();
  bool isRecording = false;
  String path = "";
  String url = "";
  start_record() async {
    final location = await getApplicationDocumentsDirectory();
    if (await record.hasPermission()) {
      await record.start(RecordConfig(),
          path: location.path + Uuid().v4() + 'm4a');
      setState(() {
        isRecording = true;
      });
    }
  }

  stop_record() async {
    String? finalpath = await record.stop();
    setState(() {
      path = finalpath!;
      isRecording = false;
    });
    massage_repository.uploadrecord(widget.chatid, path, 1);
  }

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
          // additional icon
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              onTap: () {
                print('add icon');
                WoltModalSheet.show<void>(
                  // pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  pageListBuilder: (modalSheetContext) {
                    return [
                      WoltModalSheetPage(
                        child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.35,
                            child: send_options(
                              chatid: widget.chatid,
                            )),
                      ),
                    ];
                  },
                );
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: backbackground,
                child: Icon(
                  Icons.add,
                  size: 22.sp,
                  color: textcolor,
                ),
              ),
            ),
          ),
          // send massage
          isRecording == false
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Container(
                    width: 165.w,
                    child: TextFormField(
                      controller: massageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(
                          color: textcolor,
                          fontSize: 15.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Text("Recording..."),
                    SizedBox(
                      width: 100.w,
                    )
                  ],
                ),
          // send icon
          isRecording == false
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      // send massage
                      massage_repository.sendMessage(
                          widget.chatid, massageController.text, 0);
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
                )
              : SizedBox(),
          // emoji icon
          isRecording == false
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      ElegantNotification.info(
	title:  Text("Sorry"),
	description:  Text("This feature coming soon !"),
  
  
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
              : SizedBox(),

          // send voice icon
          isRecording == false
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      start_record();
                    },
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: backbackground,
                      child: Icon(
                        Icons.mic,
                        size: 15.sp,
                        color: textcolor,
                      ),
                    ),
                  ),
                )
              :
              // stop icon
              Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      stop_record();
                    },
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: backbackground,
                      child: Icon(
                        Icons.stop,
                        size: 15.sp,
                        color: textcolor,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
