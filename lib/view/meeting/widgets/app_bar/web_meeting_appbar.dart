import 'dart:async';

import 'package:chat_app/view/meeting/widgets/app_bar/recording_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:videosdk/videosdk.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';


import '../../Screens/chat/chat_view.dart';
import '../../Screens/participant/participant_list.dart';
import '../../Screens/screen_share/screen_select_dialog.dart';
import '../../Screens/whiteboard/whiteboard.dart';
import '../../data/api.dart';
import '../../theme/AppColors.dart';
import '../toast.dart';

class WebMeetingAppBar extends StatefulWidget {
  final String token;
  final Room meeting;
  // control states
  final bool isMicEnabled,
      isCamEnabled,
      isLocalScreenShareEnabled,
      isRemoteScreenShareEnabled;
  final String recordingState;

  const WebMeetingAppBar({
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
  State<WebMeetingAppBar> createState() => WebMeetingAppBarState();
}

class WebMeetingAppBarState extends State<WebMeetingAppBar> {
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
         
          



          

          // Mic Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor:Appcolors.primaryColor,
              onTap: () {
                if (widget.isMicEnabled) {
                  widget.meeting.muteMic();
                } else {
                  widget.meeting.unmuteMic();
                }
              },
              child: Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolors.secondaryColor),
                  color:Appcolors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(
                      widget.isMicEnabled ? Icons.mic : Icons.mic_off,
                      size: 25,
                      color: Colors.white,
                    ),
                    PopupMenuButton(
                      position: PopupMenuPosition.over,
                      padding: const EdgeInsets.all(0),
                      color:Appcolors.black800,
                      offset: const Offset(0, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onSelected: (value) {
                        if (value == 'label') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select device')));
                        } else {
                          MediaDeviceInfo deviceInfo = value as MediaDeviceInfo;

                          if (deviceInfo.kind == "audiooutput") {
                            widget.meeting.switchAudioDevice(deviceInfo);
                          } else if (deviceInfo.kind == "audioinput") {
                            widget.meeting.changeMic(deviceInfo);
                          }
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          _buildMeetingPoupItem('label', 'Microphones', null,
                              leadingIcon: const Icon(
                                Icons.mic,
                                color: Color.fromARGB(255, 77, 75, 75),
                              ),
                              textColor: const Color.fromARGB(255, 77, 75, 75)),
                          PopupMenuItem(
                            child: Column(
                                children: widget.meeting
                                    .getMics()
                                    .map(
                                      (e) => _buildMeetingPoupItem(
                                          e, e.label, null),
                                    )
                                    .toList()),
                          ),
                          _buildMeetingPoupItem('label', 'Speakers', null,
                              leadingIcon: const Icon(
                                Icons.volume_up,
                                color: Color.fromARGB(255, 77, 75, 75),
                              ),
                              textColor: const Color.fromARGB(255, 77, 75, 75)),
                          PopupMenuItem(
                            child: Column(
                                children: widget.meeting
                                    .getAudioOutputDevices()
                                    .map(
                                      (e) => _buildMeetingPoupItem(
                                          e, e.label, null),
                                    )
                                    .toList()),
                          )
                        ];
                      },
                    )
                  ],
                ),
              ),
            ),
          ),






          // Camera Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor: Appcolors.primaryColor,
              onTap: () {
                if (widget.isCamEnabled) {
                  widget.meeting.disableCam();
                } else {
                  widget.meeting.enableCam();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolors.secondaryColor),
                  color: Appcolors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(
                      widget.isCamEnabled ? Icons.videocam : Icons.videocam_off,
                      size: 25,
                      color: Colors.white,
                    ),
                    PopupMenuButton(
                      position: PopupMenuPosition.over,
                      padding: const EdgeInsets.all(0),
                      color: Appcolors.black800,
                      offset: const Offset(0, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onSelected: (value) {
                        MediaDeviceInfo camera = value as MediaDeviceInfo;
                        if (camera.deviceId != widget.meeting.selectedCamId) {
                          widget.meeting.changeCam(camera.deviceId);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Column(
                                children: widget.meeting
                                    .getCameras()
                                    .map(
                                      (e) => _buildMeetingPoupItem(
                                          e, e.label, null),
                                    )
                                    .toList()),
                          ),
                        ];
                      },
                    )
                  ],
                ),
              ),
            ),
          ),


         // Screen Share Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor: Appcolors.primaryColor,
              onTap: () {
                if (!widget.isRemoteScreenShareEnabled) {
                  if (!widget.isLocalScreenShareEnabled) {
                    if (!kIsWeb) {
                      selectScreenSourceDialog(context).then((value) => {
                            if (value != null)
                              {widget.meeting.enableScreenShare(value)}
                          });
                    } else {
                      widget.meeting.enableScreenShare();
                    }
                  } else {
                    widget.meeting.disableScreenShare();
                  }
                } else {
                  showSnackBarMessage(
                      message: "Someone is already presenting",
                      context: context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color:Appcolors.secondaryColor),
                  color: Appcolors.primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  widget.isLocalScreenShareEnabled
                      ? "assets/ic_stop_screen_share.svg"
                      : "assets/ic_screen_share.svg",
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Draw control
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor:Appcolors.primaryColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(0.0),
                      content: SizedBox(
                        width: kIsWeb
                            ? MediaQuery.of(context).size.width / 1.3
                            : MediaQuery.of(context).size.width / 1.7,
                        height: kIsWeb
                            ? MediaQuery.of(context).size.height / 1.1
                            : MediaQuery.of(context).size.height / 1.7,
                        child: whiteboard(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolors.secondaryColor),
                  color:Appcolors.primaryColor,
                ),
                padding: const EdgeInsets.all(11),
                child: Icon(
                  Icons.draw,
                  size: 5.sp,
                  color: Colors.white,
                ),
                )
              ),
            ),
        
          

          // Chat Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor:Appcolors.primaryColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(0.0),
                      content: SizedBox(
                        width: kIsWeb
                            ? MediaQuery.of(context).size.width / 2.3
                            : MediaQuery.of(context).size.width / 1.7,
                        height: kIsWeb
                            ? MediaQuery.of(context).size.height / 1.5
                            : MediaQuery.of(context).size.height / 1.7,
                        child: ChatView(meeting: widget.meeting),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolors.secondaryColor),
                  color:Appcolors.primaryColor,
                ),
                padding: const EdgeInsets.all(11),
                child: SvgPicture.asset(
                  "assets/ic_chat.svg",
                  width: 23,
                  height: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Recording Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor: Appcolors.primaryColor,
              onTap: () {
                if (widget.recordingState == "RECORDING_STOPPING") {
                  showSnackBarMessage(
                      message: "Recording is in stopping state",
                      context: context);
                } else if (widget.recordingState == "RECORDING_STARTED") {
                  widget.meeting.stopRecording();
                } else if (widget.recordingState == "RECORDING_STARTING") {
                  showSnackBarMessage(
                      message: "Recording is in starting state",
                      context: context);
                } else {
                  widget.meeting.startRecording();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolors.secondaryColor),
                  color: Appcolors.primaryColor,
                ),
                padding: const EdgeInsets.all(11),
                child: SvgPicture.asset(
                  "assets/ic_recording.svg",
                  width: 23,
                  height: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),



          // Participant Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(12),
              rippleColor:Appcolors.primaryColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(0.0),
                      content: SizedBox(
                        width: kIsWeb
                            ? MediaQuery.of(context).size.width / 2.3
                            : MediaQuery.of(context).size.width / 1.7,
                        height: kIsWeb
                            ? MediaQuery.of(context).size.height / 1.5
                            : MediaQuery.of(context).size.height / 1.7,
                        child: ParticipantList(meeting: widget.meeting),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color:Appcolors.secondaryColor),
                  color: Appcolors.primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              ),
            ),
          ),
         
          // End Call Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PopupMenuButton(
                position: PopupMenuPosition.under,
                padding: const EdgeInsets.all(0),
                color: Appcolors.black800,
                icon: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red),
                      color: Colors.red,
                      shape: BoxShape.rectangle),
                  child: const Icon(
                    Icons.call_end,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                offset: const Offset(0, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) => {
                      if (value == "leave")
                        widget.meeting.leave()
                      else if (value == "end")
                        widget.meeting.end()
                    },
                itemBuilder: (context) => <PopupMenuEntry>[
                      _buildMeetingPoupItem(
                        "leave",
                        "Leave",
                        "Only you will leave the call",
                        leadingIcon: SvgPicture.asset("assets/ic_leave.svg"),
                      ),
                      const PopupMenuDivider(),
                      _buildMeetingPoupItem(
                        "end",
                        "End",
                        "End call for all participants",
                        leadingIcon: SvgPicture.asset("assets/ic_end.svg"),
                      ),
                    ]),
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
