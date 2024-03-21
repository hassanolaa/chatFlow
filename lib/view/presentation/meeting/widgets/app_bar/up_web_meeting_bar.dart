
import 'dart:async';

import 'package:chat_app/view/presentation/meeting/widgets/app_bar/recording_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../Screens/chat/chat_view.dart';
import '../../Screens/participant/participant_list.dart';
import '../../Screens/screen_share/screen_select_dialog.dart';
import '../../data/api.dart';
import '../../theme/AppColors.dart';
import '../toast.dart';

class up_web_meeting_bar extends StatefulWidget {
  final String token;
  final Room meeting;
  // control states
  final bool isMicEnabled,
      isCamEnabled,
      isLocalScreenShareEnabled,
      isRemoteScreenShareEnabled;
  final String recordingState;

  const up_web_meeting_bar({
    Key? key,
    required this.meeting,
    required this.token,
    required this.recordingState,
    required this.isMicEnabled,
    required this.isCamEnabled,
    required this.isLocalScreenShareEnabled,
    required this.isRemoteScreenShareEnabled,
  }) : super(key: key);

  @override
  State<up_web_meeting_bar> createState() => WebMeetingAppBarState();
}

class WebMeetingAppBarState extends State<up_web_meeting_bar> {
  Duration? elapsedTime;
  Timer? sessionTimer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 8.0, 0.0),
      child: Row(
        children: [
          if (widget.recordingState == "RECORDING_STARTING" ||
              widget.recordingState == "RECORDING_STOPPING" ||
              widget.recordingState == "RECORDING_STARTED")
            RecordingIndicator(recordingState: widget.recordingState),
          if (widget.recordingState == "RECORDING_STARTING" ||
              widget.recordingState == "RECORDING_STOPPING" ||
              widget.recordingState == "RECORDING_STARTED")
            SizedBox(width: 20.w,),

            //copy meeting id and timer

          





          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //copy meeting id

                Row(
                  children: [
                    Text(
                      widget.meeting.id,
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                               color: Appcolors.fontcolor

                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Icon(
                          Icons.copy,
                          size: 16,
                          color: Appcolors.fontcolor

                        ),
                      ),
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.meeting.id));
                        showSnackBarMessage(
                            message: "Meeting ID has been copied.",
                            context: context);
                      },
                    ),
                  ],
                ),
                // VerticalSpacer(),
                Text(
                  elapsedTime == null
                      ? "00:00:00"
                      : elapsedTime.toString().split(".").first,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                                        color: Appcolors.fontcolor),
                )
              ],
            ),
          ),


          

          ],
      ),
    );
  }

  Future<void> startTimer() async {
    dynamic session = await fetchSession(widget.token, widget.meeting.id);
    DateTime sessionStartTime = DateTime.parse(session['start']);
    final difference = DateTime.now().difference(sessionStartTime);

    setState(() {
      elapsedTime = difference;
      sessionTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            elapsedTime = Duration(
                seconds: elapsedTime != null ? elapsedTime!.inSeconds + 1 : 0);
          });
        },
      );
    });
    // log("session start time" + session.data[0].start.toString());
  }

  Future<DesktopCapturerSource?> selectScreenSourceDialog(
      BuildContext context) async {
    final source = await showDialog<DesktopCapturerSource>(
      context: context,
      builder: (context) => ScreenSelectDialog(
        meeting: widget.meeting,
      ),
    );
    return source;
  }

  PopupMenuItem<dynamic> _buildMeetingPoupItem(
      dynamic value, String title, String? description,
      {Widget? leadingIcon, Color? textColor}) {
    return PopupMenuItem(
      value: value,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Row(children: [
        leadingIcon ?? const Center(),
        SizedBox(width: 12.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? Colors.white),
              ),
              if (description != null) SizedBox(height: 4.h,),
              if (description != null)
                Text(
                  description,
                  style:  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Appcolors.black900),
                )
            ],
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    if (sessionTimer != null) {
      sessionTimer!.cancel();
    }
    super.dispose();
  }
}
