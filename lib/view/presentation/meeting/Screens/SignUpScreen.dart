import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../theme/AppColors.dart';
import '../widgets/toast.dart';
import 'SignIn.dart';
import 'joinMeeting.dart';






class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return   
     LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>600){
        return SignUpScreenTop();
      }else{
        return SignUpScreen();
      }
    });
  }
}



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.imgur.com/A48kGmR.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(height: 50.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Container(
                      width: 200.w, height: 130.h,
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://i.imgur.com/YLbdShs.png"))),
                    )
                  ],
                ).animate().fade(duration: 0.5.seconds),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Text(
                      "Your Desecration Of Reality",
                      style: TextStyle(fontSize: 15.0.sp, color: Colors.white),
                    ),
                  ],
                ).animate().fade(duration: 0.5.seconds),
                SizedBox(height: 60.0.h),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Container(
                      width: 190.0.w,
                      height: 50.h,
                      child: TextField(
                        style: TextStyle(color: Colors.white),

                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Email Or Username",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 10.0.sp),
                          hintText: "Email Or Username",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 10.0.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide: BorderSide(
                                color: Appcolors.fontcolor, width: 1.0.w),
                          ),
                          //   contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
                        ),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 1.seconds),
                SizedBox(height: 25.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Container(
                      width: 190.0.w,
                      height: 50.h,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                          obscureText: true,
                        onChanged: (value) {
                          pass = value;
                        },
                        decoration: InputDecoration(
                        
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 10.0.sp),
                          hintText: "Password",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 10.0.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide: BorderSide(
                                color: Appcolors.fontcolor, width: 1.0.w),
                          ),
                          //contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
                        ),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 1.seconds),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    GestureDetector(
                      onTap: () {
                        if (email != null && pass != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoinScreen()));
                        } else {
                          showSnackBarMessage(
                              message:
                                  "Please enter your username and password",
                              context: context);
                        }
                      },
                      child: Container(
                        width: 90.0.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                            child: Text(
                          "Sign UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 2.seconds),
                SizedBox(height: 30.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinScreen()));
                      },
                      child: Container(
                        width: 90.0.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                            child: Text(
                          "As Guest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 2.seconds),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Text(
                      'Already have an Acc ?',
                      style: TextStyle(fontSize: 10.0.sp, color: Colors.white),
                    ),
                    SizedBox(width: 5.0.w),
                    GestureDetector(
                        //   onTap: (){
                        //  Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => SignInScreen()));
                        //   },
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                                              'SignIn now',
                                              style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:11.0.sp,
                            color: Colors.white),
                                            ),
                        )),
                  ],
                ).animate().fade(duration: 3.seconds),
                SizedBox(height: 10.0.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class SignUpScreenTop extends StatefulWidget {
  const SignUpScreenTop({super.key});

  @override
  State<SignUpScreenTop> createState() => _SignUpScreenTopState();
}

class _SignUpScreenTopState extends State<SignUpScreenTop> {
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.imgur.com/A48kGmR.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(height: 50.0.h),
                Row(
                  children: [
                    SizedBox(width: 100.0.w),
                    Container(
                      width: 150.w, height: 130.h,
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://i.imgur.com/YLbdShs.png"))),
                    )
                  ],
                ).animate().fade(duration: 0.5.seconds),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    Text(
                      "Your Desecration Of Reality",
                      style: TextStyle(fontSize: 8.0.sp, color: Colors.white),
                    ),
                  ],
                ).animate().fade(duration: 0.5.seconds),
                SizedBox(height: 60.0.h),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    Container(
                      width: 100.0.w,
                      height: 50.h,
                      child: TextField(
                        style: TextStyle(color: Colors.white),

                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Email Or Username",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 6.0.sp),
                          hintText: "Email Or Username",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 6.0.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide: BorderSide(
                                color: Appcolors.fontcolor, width: 1.0.w),
                          ),
                          //   contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
                        ),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 1.seconds),
                SizedBox(height: 25.0.h),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    Container(
                      width: 100.0.w,
                      height: 50.h,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                          obscureText: true,
                        onChanged: (value) {
                          pass = value;
                        },
                        decoration: InputDecoration(
                        
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 6.0.sp),
                          hintText: "Password",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 6.0.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide: BorderSide(
                                color: Appcolors.fontcolor, width: 1.0.w),
                          ),
                          //contentPadding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
                        ),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 1.seconds),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    GestureDetector(
                      onTap: () {
                        if (email != null && pass != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoinScreen()));
                        } else {
                          showSnackBarMessage(
                              message:
                                  "Please enter your username and password",
                              context: context);
                        }
                      },
                      child: Container(
                        width: 60.0.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                            child: Text(
                          "Sign UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 7.0.sp,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 2.seconds),
                SizedBox(height: 30.0.h),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinScreen()));
                      },
                      child: Container(
                        width: 60.0.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                            child: Text(
                          "As Guest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 7.0.sp,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ).animate().fade(duration: 2.seconds),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    SizedBox(width: 120.0.w),
                    Text(
                      'Already have an Acc ?',
                      style: TextStyle(fontSize: 6.0.sp, color: Colors.white),
                    ),
                    SizedBox(width: 5.0.w),
                    GestureDetector(
                        //   onTap: (){
                        //  Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => SignInScreen()));
                        //   },
                        child: TextButton(
                          onPressed: (){
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          
                          },
                          child: Text(
                                              'SignIn now',
                                              style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:7.0.sp,
                            color: Colors.white),
                                            ),
                        )),
                  ],
                ).animate().fade(duration: 3.seconds),
                SizedBox(height: 10.0.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
