import 'package:chat_app/view/meeting/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../theme/AppColors.dart';


class JoiningDetails extends StatefulWidget {
  final bool isCreateMeeting;
  final Function onClickMeetingJoin;

  const JoiningDetails(
      {Key? key,
      required this.isCreateMeeting,
      required this.onClickMeetingJoin})
      : super(key: key);

  @override
  State<JoiningDetails> createState() => _JoiningDetailsState();
}

class _JoiningDetailsState extends State<JoiningDetails> {
  String _meetingId = "";
  String _displayName = "";
  String meetingMode = "GROUP";
  List<String> meetingModes = ["ONE_TO_ONE", "GROUP"];
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color:Appcolors.black800),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: meetingMode,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style:  TextStyle(
                  fontWeight: FontWeight.w500,color: Appcolors.fontcolor),
              onChanged: (String? value) {
                setState(() {
                  meetingMode = value!;
                });
              },
              borderRadius: BorderRadius.circular(12),
              dropdownColor: Appcolors.black800,
              alignment: AlignmentDirectional.centerStart,
              items: meetingModes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth:
                          ResponsiveValue<double>(context, conditionalValues: [
                        Condition.equals(name: MOBILE, value: maxWidth / 1.5),
                        Condition.equals(name: TABLET, value: maxWidth / 1.5),
                        Condition.equals(name: DESKTOP, value: 595),
                      ]).value!,
                    ),
                    child: Text(
                      value == "GROUP" ? "Group Call" : "One to One Call",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
                SizedBox(height: 16.h,),

        if (!widget.isCreateMeeting)
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Appcolors.black800),
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              onChanged: ((value) => _meetingId = value),
              decoration: InputDecoration(
                  constraints: BoxConstraints.tightFor(
                    width: ResponsiveValue<double>(context, conditionalValues: [
                      Condition.equals(name: MOBILE, value: maxWidth / 1.3),
                      Condition.equals(name: TABLET, value: maxWidth / 1.3),
                      Condition.equals(name: DESKTOP, value: 640),
                    ]).value!,
                  ),
                  hintText: "Enter meeting code",
                  hintStyle:  TextStyle(
                  color: Appcolors.fontcolor
                  ),
                  border: InputBorder.none),
            ),
          ),
        if (!widget.isCreateMeeting) SizedBox(height: 16.h,),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Appcolors.black800),
          child: TextField(
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontWeight: FontWeight.w500,
                  color: Appcolors.fontcolor

            ),
            onChanged: ((value) => _displayName = value),
            decoration: InputDecoration(
                constraints: BoxConstraints.tightFor(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: maxWidth / 1.3),
                    Condition.equals(name: TABLET, value: maxWidth / 1.3),
                    Condition.equals(name: DESKTOP, value: 640),
                  ]).value!,
                ),
                hintText: "Enter your name",
                hintStyle:  TextStyle(
                  color: Appcolors.fontcolor
                ),
                border: InputBorder.none),
          ),
        ),
        SizedBox(height: 16.h,),
        MaterialButton(
            minWidth: ResponsiveValue<double>(context, conditionalValues: [
              Condition.equals(name: MOBILE, value: maxWidth / 1.3),
              Condition.equals(name: TABLET, value: maxWidth / 1.3),
              Condition.equals(name: DESKTOP, value: 650),
            ]).value!,
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.purple,
            child: Text("Join Meeting", style: TextStyle(fontSize: 16,color: Appcolors.fontcolor)),
            onPressed: () {
              if (_displayName.trim().isEmpty) {
                showSnackBarMessage(
                    message: "Please enter name", context: context);
                return;
              }
              if (!widget.isCreateMeeting && _meetingId.trim().isEmpty) {
                showSnackBarMessage(
                    message: "Please enter meeting id", context: context);
                return;
              }
              widget.onClickMeetingJoin(
                  _meetingId.trim(), meetingMode, _displayName.trim());
            }),
      ],
    );
  }
}
