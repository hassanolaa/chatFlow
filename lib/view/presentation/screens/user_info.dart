import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../const/const.dart';

class user_info extends StatefulWidget {
  const user_info({super.key});

  @override
  State<user_info> createState() => _user_infoState();
}

class _user_infoState extends State<user_info> {
  bool male = false;
  bool female = false;
  int age = 20;
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backbackground,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.gif"),
            fit: BoxFit.cover,
            // opacity: 0.5,
          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.76,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "User Info",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //profile image
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [color1, color3],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight)),
                  child: Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40.sp,
                      color: background,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // username
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_pin,
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(color: textcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                //bio
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: bio,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.article_outlined),
                      hintText: "Bio",
                      hintStyle: TextStyle(color: textcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),
                // phone and contrary code in row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 60.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: textcolor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            //text field
                            Center(
                          child: TextField(
                            controller: code,
                            decoration: InputDecoration(
                              hintText: "code",
                              hintStyle:
                                  TextStyle(color: textcolor, fontSize: 15.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: TextField(
                          controller: phone,
                          decoration: InputDecoration(
                            hintText: "Phone",
                            hintStyle: TextStyle(color: textcolor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // age slider and male switch
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Age",
                        style: TextStyle(fontSize: 20.sp, color: textcolor),
                      ),
                      Expanded(
                        child: Slider(
                          value: age.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              age = value.toInt();
                            });
                          },
                          min: 0,
                          max: 100,
                          activeColor: color3,
                          inactiveColor: textcolor,
                        ),
                      ),
                      Text(
                        "$age",
                        style: TextStyle(fontSize: 20.sp, color: textcolor),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(fontSize: 20.sp, color: textcolor),
                      ),
                      Switch(
                          activeColor: color3,
                          value: male,
                          onChanged: (value) {
                            setState(() {
                              male = value;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (username.text != "" &&
                        bio.text != "" &&
                        code.text != "" &&
                        phone.text != "" &&
                        (male != false || female != false)) {
                      user_repository.addUserInfo(
                          "",
                          username.text,
                          bio.text,
                          code.text + phone.text,
                          age,
                          male != false ? "male" : "female");
                    }
                    GoRouter.of(context).go("/navi");
                  },
                  child: Text(
                    "Join Us !",
                    style: TextStyle(color: background, fontSize: 20.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: color3,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate(effects: [FadeEffect(duration: Duration(seconds: 1))]),
      ),
    );
  }
}
