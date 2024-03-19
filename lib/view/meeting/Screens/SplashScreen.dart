import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import '../theme/AppColors.dart';
import 'SignUpScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: FlutterSplashScreen.fadeIn(
      duration: Duration(seconds: 3),
          backgroundColor: Appcolors.primaryColor,
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
          },
          childWidget: SizedBox(
            height: 400,
            width: 400,
            child: Image.network("https://i.imgur.com/YLbdShs.png"),
          ),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          nextScreen:SignUp(),
        ),

    );

    //  LayoutBuilder(builder: (context,constraints){
    //   if(constraints.maxWidth>600){
    //     return DeskTopHomeScrren(data: nn);
    //   }else{
    //     return MobileHomeScrren(data: nn,);
    //   }
    // });
  }
}
