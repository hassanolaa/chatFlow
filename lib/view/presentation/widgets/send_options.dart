import 'package:chat_app/repository/massage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../const/const.dart';

class send_options extends StatefulWidget {
  send_options({super.key, required this.chatid});
  String chatid;

  @override
  State<send_options> createState() => _send_optionsState();
}

class _send_optionsState extends State<send_options> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // camra - photo/video - location - file - contact
        children: [
          // camra - photo/video
          Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: backbackground,
                  child: Icon(Icons.camera_alt, size: 15.sp, color: textcolor),
                ),
                title: Text('Camera',
                    style: TextStyle(color: textcolor, fontSize: 13.sp)),
                onTap: () {
                  print('camera');
                  massage_repository.UploadImage_camera(widget.chatid);
                },
              )),
          // photo/video
          Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: backbackground,
                  child: Icon(Icons.photo, size: 15.sp, color: textcolor),
                ),
                title: Text('Photo & Video',
                    style: TextStyle(color: textcolor, fontSize: 13.sp)),
                onTap: () {
                  print('photo/video');
                  WoltModalSheet.show<void>(
                      // pageIndexNotifier: pageIndexNotifier,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        return [
                          WoltModalSheetPage(
                            child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: backbackground,
                                            child: Icon(Icons.photo,
                                                size: 15.sp, color: textcolor),
                                          ),
                                          title: Text('Photo',
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 13.sp)),
                                          onTap: () {
                                            print('photo');
                                            massage_repository.uploadimage(
                                                widget.chatid, 1);
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: backbackground,
                                            child: Icon(Icons.video_call,
                                                size: 15.sp, color: textcolor),
                                          ),
                                          title: Text('Video',
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 13.sp)),
                                          onTap: () {
                                            print('video');
                                            massage_repository.uploadvideo(
                                                widget.chatid, 1);
                                          },
                                        )),
                                  ],
                                )),
                          ),
                        ];
                      });
                  //massage_repository.uploadimage(widget.chatid,1);
                },
              )),
          // location
          Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: backbackground,
                  child: Icon(Icons.location_on, size: 15.sp, color: textcolor),
                ),
                title: Text('Location',
                    style: TextStyle(color: textcolor, fontSize: 13.sp)),
                onTap: () {
                  print('location');
                },
              )),
          // file
          Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: backbackground,
                  child: Icon(Icons.insert_drive_file,
                      size: 15.sp, color: textcolor),
                ),
                title: Text('File',
                    style: TextStyle(color: textcolor, fontSize: 13.sp)),
                onTap: () {
                  print('file');
                  // massage_repository.uploadfile(widget.chatid,1);
                  WoltModalSheet.show<void>(
                      // pageIndexNotifier: pageIndexNotifier,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        return [
                          WoltModalSheetPage(
                            child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: backbackground,
                                            child: Icon(Icons.picture_as_pdf,
                                                size: 15.sp, color: textcolor),
                                          ),
                                          title: Text('pdf',
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 13.sp)),
                                          onTap: () {
                                            massage_repository.uploadfile(
                                                widget.chatid, 1, 0);
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: backbackground,
                                            child: Icon(Icons.file_present,
                                                size: 15.sp, color: textcolor),
                                          ),
                                          title: Text('word',
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 13.sp)),
                                          onTap: () {
                                             massage_repository.uploadfile(
                                                widget.chatid, 1, 1);
                                          },
                                        )),
                                          Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: backbackground,
                                            child: Icon(Icons.document_scanner_outlined,
                                                size: 15.sp, color: textcolor),
                                          ),
                                          title: Text('excel',
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 13.sp)),
                                          onTap: () {
                                             massage_repository.uploadfile(
                                                widget.chatid, 1, 2);
                                          },
                                        )),
                                  ],
                                )),
                          ),
                        ];
                      });
                },
              )),
        ],
      ),
    );
  }
}
