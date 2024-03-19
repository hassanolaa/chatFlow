import 'package:chat_app/model/user.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../const/const.dart';
import '../widgets/edit_profile.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  user? userr;
  bool loaded = false;
 

  

  @override
  void initState() {
    // TODO: implement initState
    //get();
    
      user_repository.getUserInfo().then((user) => {
            setState(() {
              userr = user;
              print(userr!.username);
              loaded = true;
            }),
          });
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: loaded==false?Center(child: CircularProgressIndicator(
        color: color3,
      )):
      Column(children: [
        SizedBox(
          height: 70.h,
        ),
        // row "profile"and add post icon
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, color: textcolor),
              ),
            ),
            SizedBox(
              width: 100.w,
            ),
            GestureDetector(
              onTap: () {
                print(2222);
                // SmartDialog.show(builder: (_) {
                //   return edit_profile();
                // });
                WoltModalSheet.show<void>(
                  // pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  pageListBuilder: (modalSheetContext) {
                    return [
                      WoltModalSheetPage(
                        child: edit_profile(),
                      ),
                    ];
                  },
                );

                //
              },
              child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: backbackground,
                  child: Icon(
                    Icons.edit,
                    size: 30.sp,
                    color: textcolor,
                  )),
            ),
            SizedBox(
              width: 20.w,
            ),
            CircleAvatar(
                radius: 20.r,
                backgroundColor: backbackground,
                child: Icon(
                  Icons.settings,
                  size: 30.sp,
                  color: textcolor,
                )),
            SizedBox(
              width: 20.w,
            ),
            GestureDetector(
              onTap: () {
                user_repository.signOut();
                GoRouter.of(context).go("/signin");
              },
              child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: backbackground,
                  child: Icon(
                    Icons.logout,
                    size: 30.sp,
                    color: textcolor,
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        // profile image
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(userr!.imageUrl!),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                children: [
                  Text(
                    userr!.username!,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textcolor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Active",
                    style: TextStyle(fontSize: 15.sp, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        // about text
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(
                "About",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textcolor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        // about text
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Text(
            userr!.bio!,
            // "I am a software engineer and I love to code",
            style: TextStyle(fontSize: 15.sp, color: textcolor),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        // phone number text
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(
                "Phone Number",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textcolor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        // phone number text
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.w, right: 20.w),
              child: Text(
                userr!.phone!,
                // "+9234567890",
                style: TextStyle(fontSize: 15.sp, color: textcolor),
              ),
            ),
          ],
        )
      ]
          // )
          ).animate(effects: [FadeEffect(duration: Duration(seconds: 1))]),
    );
  }
}
