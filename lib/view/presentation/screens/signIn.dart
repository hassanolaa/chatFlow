import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../const/const.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backbackground,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back2.gif"),
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
                  "Sign In",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: textcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
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
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 15.sp, color: color3),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    user_repository.signIn(  emailController.text, passwordController.text);
                  //  user_repository.signIn(  "hassan1234@nnn.com", "123456");
                   
                    if (user_repository.getCurrentUser() != null) {
                      GoRouter.of(context).go("/navi");
                    } else {
                      print("error");  //todo error message
                    }
                  },
                  child: Text(
                    "Sign In",
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
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "----Or----",
                  style: TextStyle(fontSize: 20.sp, color: textcolor),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // google
                ElevatedButton.icon(
                  onPressed: () {
                    //todo: this is google sign in
                  },
                  icon:
                      Icon(Icons.g_mobiledata, size: 40.sp, color: background),
                  label: Text(
                    "Sign In with Google",
                    style: TextStyle(color: background, fontSize: 15.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: color4,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an Account",
                      style: TextStyle(fontSize: 15.sp, color: textcolor),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go("/signup");
                      },
                      child: Text(
                        "Create one",
                        style: TextStyle(fontSize: 15.sp, color: color3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate(effects: [FadeEffect(duration: Duration(seconds: 1))]),
      ),
    );
  }
}

// import 'package:flutter/foundation.dart' show kIsWeb;
// // ...

// class _signInState extends State<signIn> {
//   // ...

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ...
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           final isWeb = kIsWeb && maxWidth > 600;

//           return Container(
//             // ...
//             child: Center(
//               // ...
//               child: Container(
//                 width: isWeb ? maxWidth * 0.4 : maxWidth * 0.9,
//                 height: isWeb ? maxHeight * 0.6 : maxHeight * 0.76,
//                 // ...
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }