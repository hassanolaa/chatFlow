import 'package:chat_app/const/const.dart';
import 'package:chat_app/model/chat_route.dart';
import 'package:chat_app/model/status.dart';
import 'package:chat_app/model/status_typedet.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:chat_app/view/presentation/screens/calls.dart';
import 'package:chat_app/view/presentation/screens/chat.dart';
import 'package:chat_app/view/presentation/screens/massages.dart';
import 'package:chat_app/view/presentation/screens/profile.dart';
import 'package:chat_app/view/presentation/screens/signIn.dart';
import 'package:chat_app/view/presentation/screens/signup.dart';
import 'package:chat_app/view/presentation/screens/status.dart';
import 'package:chat_app/view/presentation/screens/status_view.dart';
import 'package:chat_app/view/presentation/screens/user_info.dart';
import 'package:chat_app/view/presentation/widgets/document_view.dart';
import 'package:chat_app/view/presentation/widgets/navi.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // DevicePreview(
     //enabled: !kReleaseMode,
     // builder: (context) =>
   MyApp(),
   //  MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        // here
        routerConfig: router,
      ),
    );
  }

  final GoRouter router = GoRouter(
      initialLocation:
       // '/status_view',
          user_repository.getCurrentUser() != null ? '/navi' : '/signup',
      routes: [
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return const signUp();
          },
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) {
            return const signIn();
          },
        ),
        GoRoute(
          path: '/user-info',
          builder: (context, state) {
            return const user_info();
          },
        ),
        GoRoute(
            path: '/navi',
            builder: (context, state) {
              return const navi();
            },
            routes: [
              //      GoRoute(
              //   path: '/chat',
              //   builder: (context, state) {
              //     return  chat();
              //   },
              // ),
            ]),
        GoRoute(
          name: 'chat',
          path: '/navi/chat',
          builder: (context, state) {
            final (chat_id, username, userimage) = state.extra as chat_route;
            return chat(chatid: chat_id,username: username,userimage: userimage,);
          }, 
        ),
         GoRoute(
          name: 'view',
          path: '/navi/chat/view',
          builder: (context, state) {
           final document_url=state.extra as String;
            return  document_view(document_url: document_url,);
          }, 
        ),
        GoRoute(
          name: 'status_view',
          path: '/status_view',
          builder: (context, state) {
          final status = state.extra as status_route;
            return status_view(status: status);
          },
        ),
      ]);
}
