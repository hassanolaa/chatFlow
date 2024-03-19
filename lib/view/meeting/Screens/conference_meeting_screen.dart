import 'dart:io';

import 'package:chat_app/view/meeting/Screens/participant/participant_list.dart';
import 'package:chat_app/view/meeting/Screens/views/conference_participant_grid.dart';
import 'package:chat_app/view/meeting/Screens/views/conference_screenshare_view.dart';
import 'package:chat_app/view/meeting/Screens/whiteboard/whiteboard.dart';
import 'package:chat_app/view/meeting/theme/AppColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:videosdk/videosdk.dart';


import '../widgets/app_bar/meeting_action_bar.dart';
import '../widgets/app_bar/up_web_meeting_bar.dart';
import '../widgets/app_bar/web_meeting_appbar.dart';
import '../widgets/toast.dart';
import '../widgets/waiting_to_join.dart';
import 'chat/chat_view.dart';
import 'joinMeeting.dart';

class ConfereneceMeetingScreen extends StatefulWidget {
  final String meetingId, token, displayName;
  final bool micEnabled, camEnabled, chatEnabled;
  const ConfereneceMeetingScreen({
    Key? key,
    required this.meetingId,
    required this.token,
    required this.displayName,
    this.micEnabled = true,
    this.camEnabled = true,
    this.chatEnabled = true,
  }) : super(key: key);

  @override
  State<ConfereneceMeetingScreen> createState() =>
      _ConfereneceMeetingScreenState();
}

class _ConfereneceMeetingScreenState extends State<ConfereneceMeetingScreen> {
  bool isRecordingOn = false;
  bool showChatSnackbar = true;
  String recordingState = "RECORDING_STOPPED";
  // Meeting
  late Room meeting;
  bool _joined = false;

  // Streams
  Stream? shareStream;
  Stream? videoStream;
  Stream? audioStream;
  Stream? remoteParticipantShareStream;

  bool fullScreen = false;

  bool nothide = true;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Create instance of Room (Meeting)
    Room room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: widget.displayName,
      micEnabled: widget.micEnabled,
      camEnabled: widget.camEnabled,
      maxResolution: 'hd',
      multiStream: true,
      defaultCameraIndex: kIsWeb ? 0 : 1,
      notification: const NotificationInfo(
        title: "Video SDK",
        message: "Video SDK is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );

    // Register meeting events
    registerMeetingEvents(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    //Get statusbar height
    final statusbarHeight = MediaQuery.of(context).padding.top;
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: _joined
          ? SafeArea(
              child: Scaffold(
                  floatingActionButton:
                      LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 100.0.dg, right: 100.0.dg),
                        child: Stack(children: [
                          Container(
                            width: 300.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Appcolors.primaryColor,
                            ),
                            child: WebMeetingAppBar(
                              meeting: meeting,
                              token: widget.token,
                              recordingState: recordingState,
                              isMicEnabled: audioStream != null,
                              isCamEnabled: videoStream != null,
                              isLocalScreenShareEnabled: shareStream != null,
                              isRemoteScreenShareEnabled:
                                  remoteParticipantShareStream != null,
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      nothide = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  )))
                        ]),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                  // nothide&&kIsWeb
                  //     ? Padding(
                  //         padding:
                  //             EdgeInsets.only(left: 100.0.dg, right: 100.0.dg),
                  //         child: Stack(children: [
                  //           Container(
                  //             width: 300.w,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color:Appcolors.primaryColor,
                  //             ),
                  //             child: WebMeetingAppBar(
                  //               meeting: meeting,
                  //               token: widget.token,
                  //               recordingState: recordingState,
                  //               isMicEnabled: audioStream != null,
                  //               isCamEnabled: videoStream != null,
                  //               isLocalScreenShareEnabled: shareStream != null,
                  //               isRemoteScreenShareEnabled:
                  //                   remoteParticipantShareStream != null,
                  //             ),
                  //           ),
                  //           Positioned(
                  //               top: 0,
                  //               right: 0,
                  //               child: IconButton(
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       nothide = false;
                  //                     });
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.close,
                  //                     color: Colors.black,
                  //                   )))
                  //         ]),
                  //       )
                  //     : SizedBox(),
                  // Padding(
                  //     padding:
                  //         EdgeInsets.only(left: 100.0.dg, right: 100.0.dg),
                  //     child: Stack(children: [
                  //       Container(
                  //         width: 300.w,
                  //         height: 50.h,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.white,
                  //         ),

                  //       ),
                  //       Positioned(
                  //           top: 0,
                  //           right: 0,
                  //           child: IconButton(
                  //               onPressed: () {
                  //                 setState(() {
                  //                   nothide = false;
                  //                 });
                  //               },
                  //               icon: Icon(
                  //                 Icons.close,
                  //                 color: Colors.black,
                  //               )))
                  //     ]),
                  //   ),
                  backgroundColor: Appcolors.primaryColor,
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      up_web_meeting_bar(
                        meeting: meeting,
                        token: widget.token,
                        recordingState: recordingState,
                        isMicEnabled: audioStream != null,
                        isCamEnabled: videoStream != null,
                        isLocalScreenShareEnabled: shareStream != null,
                        isRemoteScreenShareEnabled:
                            remoteParticipantShareStream != null,
                      ),

                      // // for web
                      // !isWebMobile &&
                      //         (kIsWeb || Platform.isMacOS || Platform.isWindows)
                      //     ? WebMeetingAppBar(
                      //         meeting: meeting,
                      //         token: widget.token,
                      //         recordingState: recordingState,
                      //         isMicEnabled: audioStream != null,
                      //         isCamEnabled: videoStream != null,
                      //         isLocalScreenShareEnabled: shareStream != null,
                      //         isRemoteScreenShareEnabled:
                      //             remoteParticipantShareStream != null,
                      //       ):Container(),
                      //     // : MeetingAppBar(
                      //     //     meeting: meeting,
                      //     //     token: widget.token,
                      //     //     recordingState: recordingState,
                      //     //     isFullScreen: fullScreen,
                      //     //   ),

                      //
                      const Divider(),
                      //

                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Flex(
                          direction: ResponsiveValue<Axis>(context,
                              conditionalValues: [
                                Condition.equals(
                                    name: MOBILE, value: Axis.vertical),
                                Condition.largerThan(
                                    name: MOBILE, value: Axis.horizontal),
                              ]).value!,
                          children: [
                            ConferenseScreenShareView(meeting: meeting),
                            Expanded(
                              child:
                                  ConferenceParticipantGrid(meeting: meeting),
                            ),
                          ],
                        ),
                      )),

                      //   for mobile

                      LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Column(
                            children: [
                              const Divider(),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: !fullScreen
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                secondChild: const SizedBox.shrink(),
                                firstChild: MeetingActionBar(
                                  isMicEnabled: audioStream != null,
                                  isCamEnabled: videoStream != null,
                                  isScreenShareEnabled: shareStream != null,
                                  recordingState: recordingState,
                                  // Called when Call End button is pressed
                                  onCallEndButtonPressed: () {
                                    meeting.end();
                                  },

                                  onCallLeaveButtonPressed: () {
                                    meeting.leave();
                                  },
                                  // Called when mic button is pressed
                                  onMicButtonPressed: () {
                                    if (audioStream != null) {
                                      meeting.muteMic();
                                    } else {
                                      meeting.unmuteMic();
                                    }
                                  },
                                  // Called when camera button is pressed
                                  onCameraButtonPressed: () {
                                    if (videoStream != null) {
                                      meeting.disableCam();
                                    } else {
                                      meeting.enableCam();
                                    }
                                  },

                                  onSwitchMicButtonPressed: (details) async {
                                    List<MediaDeviceInfo> outptuDevice =
                                        meeting.getAudioOutputDevices();
                                    double bottomMargin =
                                        (70.0 * outptuDevice.length);
                                    final screenSize =
                                        MediaQuery.of(context).size;
                                    await showMenu(
                                      context: context,
                                      color: Appcolors.black900,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      position: RelativeRect.fromLTRB(
                                        screenSize.width -
                                            details.globalPosition.dx,
                                        details.globalPosition.dy -
                                            bottomMargin,
                                        details.globalPosition.dx,
                                        (bottomMargin),
                                      ),
                                      items: outptuDevice.map((e) {
                                        return PopupMenuItem(
                                            value: e, child: Text(e.label));
                                      }).toList(),
                                      elevation: 8.0,
                                    ).then((value) {
                                      if (value != null) {
                                        meeting.switchAudioDevice(value);
                                      }
                                    });
                                  },

                                  onChatButtonPressed: () {
                                    setState(() {
                                      showChatSnackbar = false;
                                    });
                                    showModalBottomSheet(
                                      context: context,
                                      constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              statusbarHeight),
                                      isScrollControlled: true,
                                      builder: (context) => ChatView(
                                          key: const Key("ChatScreen"),
                                          meeting: meeting),
                                    ).whenComplete(() => {
                                          setState(() {
                                            showChatSnackbar = true;
                                          })
                                        });
                                  },

                                  // Called when more options button is pressed
                                  onMoreOptionSelected: (option) {
                                    // Showing more options dialog box
                                    if (option == "screenshare") {
                                      if (remoteParticipantShareStream ==
                                          null) {
                                        if (shareStream == null) {
                                          meeting.enableScreenShare();
                                        } else {
                                          meeting.disableScreenShare();
                                        }
                                      } else {
                                        showSnackBarMessage(
                                            message:
                                                "Someone is already presenting",
                                            context: context);
                                      }
                                    } else if (option == "recording") {
                                      if (recordingState ==
                                          "RECORDING_STOPPING") {
                                        showSnackBarMessage(
                                            message:
                                                "Recording is in stopping state",
                                            context: context);
                                      } else if (recordingState ==
                                          "RECORDING_STARTED") {
                                        meeting.stopRecording();
                                      } else if (recordingState ==
                                          "RECORDING_STARTING") {
                                        showSnackBarMessage(
                                            message:
                                                "Recording is in starting state",
                                            context: context);
                                      } else {
                                        meeting.startRecording();
                                      }
                                    } else if (option == "participants") {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: false,
                                        builder: (context) =>
                                            ParticipantList(meeting: meeting),
                                      );
                                    } else if (option == "Draw"){
                                       showModalBottomSheet(
                                        context: context,
                                       constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              statusbarHeight*0.8),
                                        isScrollControlled: true,
                                        builder: (context) =>
                                           whiteboard(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                      // !isWebMobile &&
                      //         (kIsWeb || Platform.isMacOS || Platform.isWindows)
                      //     ? Container()
                      //     : Column(
                      //         children: [
                      //           const Divider(),
                      //           AnimatedCrossFade(
                      //             duration: const Duration(milliseconds: 300),
                      //             crossFadeState: !fullScreen
                      //                 ? CrossFadeState.showFirst
                      //                 : CrossFadeState.showSecond,
                      //             secondChild: const SizedBox.shrink(),
                      //             firstChild: MeetingActionBar(
                      //               isMicEnabled: audioStream != null,
                      //               isCamEnabled: videoStream != null,
                      //               isScreenShareEnabled: shareStream != null,
                      //               recordingState: recordingState,
                      //               // Called when Call End button is pressed
                      //               onCallEndButtonPressed: () {
                      //                 meeting.end();
                      //               },

                      //               onCallLeaveButtonPressed: () {
                      //                 meeting.leave();
                      //               },
                      //               // Called when mic button is pressed
                      //               onMicButtonPressed: () {
                      //                 if (audioStream != null) {
                      //                   meeting.muteMic();
                      //                 } else {
                      //                   meeting.unmuteMic();
                      //                 }
                      //               },
                      //               // Called when camera button is pressed
                      //               onCameraButtonPressed: () {
                      //                 if (videoStream != null) {
                      //                   meeting.disableCam();
                      //                 } else {
                      //                   meeting.enableCam();
                      //                 }
                      //               },

                      //               onSwitchMicButtonPressed: (details) async {
                      //                 List<MediaDeviceInfo> outptuDevice =
                      //                     meeting.getAudioOutputDevices();
                      //                 double bottomMargin =
                      //                     (70.0 * outptuDevice.length);
                      //                 final screenSize =
                      //                     MediaQuery.of(context).size;
                      //                 await showMenu(
                      //                   context: context,
                      //                   color: Appcolors.black900,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(12)),
                      //                   position: RelativeRect.fromLTRB(
                      //                     screenSize.width -
                      //                         details.globalPosition.dx,
                      //                     details.globalPosition.dy -
                      //                         bottomMargin,
                      //                     details.globalPosition.dx,
                      //                     (bottomMargin),
                      //                   ),
                      //                   items: outptuDevice.map((e) {
                      //                     return PopupMenuItem(
                      //                         value: e, child: Text(e.label));
                      //                   }).toList(),
                      //                   elevation: 8.0,
                      //                 ).then((value) {
                      //                   if (value != null) {
                      //                     meeting.switchAudioDevice(value);
                      //                   }
                      //                 });
                      //               },

                      //               onChatButtonPressed: () {
                      //                 setState(() {
                      //                   showChatSnackbar = false;
                      //                 });
                      //                 showModalBottomSheet(
                      //                   context: context,
                      //                   constraints: BoxConstraints(
                      //                       maxHeight: MediaQuery.of(context)
                      //                               .size
                      //                               .height -
                      //                           statusbarHeight),
                      //                   isScrollControlled: true,
                      //                   builder: (context) => ChatView(
                      //                       key: const Key("ChatScreen"),
                      //                       meeting: meeting),
                      //                 ).whenComplete(() => {
                      //                       setState(() {
                      //                         showChatSnackbar = true;
                      //                       })
                      //                     });
                      //               },

                      //               // Called when more options button is pressed
                      //               onMoreOptionSelected: (option) {
                      //                 // Showing more options dialog box
                      //                 if (option == "screenshare") {
                      //                   if (remoteParticipantShareStream ==
                      //                       null) {
                      //                     if (shareStream == null) {
                      //                       meeting.enableScreenShare();
                      //                     } else {
                      //                       meeting.disableScreenShare();
                      //                     }
                      //                   } else {
                      //                     showSnackBarMessage(
                      //                         message:
                      //                             "Someone is already presenting",
                      //                         context: context);
                      //                   }
                      //                 } else if (option == "recording") {
                      //                   if (recordingState ==
                      //                       "RECORDING_STOPPING") {
                      //                     showSnackBarMessage(
                      //                         message:
                      //                             "Recording is in stopping state",
                      //                         context: context);
                      //                   } else if (recordingState ==
                      //                       "RECORDING_STARTED") {
                      //                     meeting.stopRecording();
                      //                   } else if (recordingState ==
                      //                       "RECORDING_STARTING") {
                      //                     showSnackBarMessage(
                      //                         message:
                      //                             "Recording is in starting state",
                      //                         context: context);
                      //                   } else {
                      //                     meeting.startRecording();
                      //                   }
                      //                 } else if (option == "participants") {
                      //                   showModalBottomSheet(
                      //                     context: context,
                      //                     isScrollControlled: false,
                      //                     builder: (context) =>
                      //                         ParticipantList(meeting: meeting),
                      //                   );
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),

// WebMeetingAppBar(
//                               meeting: meeting,
//                               token: widget.token,
//                               recordingState: recordingState,
//                               isMicEnabled: audioStream != null,
//                               isCamEnabled: videoStream != null,
//                               isLocalScreenShareEnabled: shareStream != null,
//                               isRemoteScreenShareEnabled:
//                                   remoteParticipantShareStream != null,
//                             )

                      ///
                    ],
                  )),
            )
          : const WaitingToJoin(),
    );
  }

  void registerMeetingEvents(Room _meeting) {
    // Called when joined in meeting
    _meeting.on(
      Events.roomJoined,
      () {
        setState(() {
          meeting = _meeting;
          _joined = true;
        });

        subscribeToChatMessages(_meeting);
      },
    );

    // Called when meeting is ended
    _meeting.on(Events.roomLeft, (String? errorMsg) {
      if (errorMsg != null) {
        showSnackBarMessage(
            message: "Meeting left due to $errorMsg !!", context: context);
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const JoinScreen()),
          (route) => false);
    });

    // Called when recording is started
    _meeting.on(Events.recordingStateChanged, (String status) {
      showSnackBarMessage(
          message:
              "Meeting recording ${status == "RECORDING_STARTING" ? "is starting" : status == "RECORDING_STARTED" ? "started" : status == "RECORDING_STOPPING" ? "is stopping" : "stopped"}",
          context: context);

      setState(() {
        recordingState = status;
      });
    });

    // Called when stream is enabled
    _meeting.localParticipant.on(Events.streamEnabled, (Stream _stream) {
      if (_stream.kind == 'video') {
        setState(() {
          videoStream = _stream;
        });
      } else if (_stream.kind == 'audio') {
        setState(() {
          audioStream = _stream;
        });
      } else if (_stream.kind == 'share') {
        setState(() {
          shareStream = _stream;
        });
      }
    });

    // Called when stream is disabled
    _meeting.localParticipant.on(Events.streamDisabled, (Stream _stream) {
      if (_stream.kind == 'video' && videoStream?.id == _stream.id) {
        setState(() {
          videoStream = null;
        });
      } else if (_stream.kind == 'audio' && audioStream?.id == _stream.id) {
        setState(() {
          audioStream = null;
        });
      } else if (_stream.kind == 'share' && shareStream?.id == _stream.id) {
        setState(() {
          shareStream = null;
        });
      }
    });

    // Called when presenter is changed
    _meeting.on(Events.presenterChanged, (_activePresenterId) {
      Participant? activePresenterParticipant =
          _meeting.participants[_activePresenterId];

      // Get Share Stream
      Stream? _stream = activePresenterParticipant?.streams.values
          .singleWhere((e) => e.kind == "share");

      setState(() => remoteParticipantShareStream = _stream);
    });

    _meeting.on(
        Events.error,
        (error) => {
              showSnackBarMessage(
                  message: error['name'].toString() +
                      " :: " +
                      error['message'].toString(),
                  context: context)
            });
  }

  void subscribeToChatMessages(Room meeting) {
    meeting.pubSub.subscribe("CHAT", (message) {
      if (message.senderId != meeting.localParticipant.id) {
        if (mounted) {
          if (showChatSnackbar) {
            showSnackBarMessage(
                message: message.senderName + ": " + message.message,
                context: context);
          }
        }
      }
    });
  }

  Future<bool> _onWillPopScope() async {
    meeting.leave();
    return true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
