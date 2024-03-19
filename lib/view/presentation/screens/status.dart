import 'package:chat_app/repository/status_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../const/const.dart';

class status extends StatefulWidget {
  const status({super.key});
  

  @override
  State<status> createState() => _statusState();
}

class _statusState extends State<status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          // row "status"and add post icon
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Status",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold,color: textcolor),
                ),
              ),
              SizedBox(
                width: 160.w,
              ),
              GestureDetector(
                onTap: () {
                  status_repository.upload_statas_to_storage(1);
                },
                child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: backbackground,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 30.sp,
                      color: textcolor,
                    )),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          // row search bar with sort button
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Container(
                  width: 250.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: backbackground,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: textcolor,
                          ),
                          hintText: "Search..",
                          hintStyle: TextStyle(color: textcolor),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              CircleAvatar(
                  radius: 20.r,
                  backgroundColor: backbackground,
                  child: Icon(
                    Icons.sort,
                    size: 30.sp,
                    color: textcolor,
                  )),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          // list of users image horizontally with name
          Container(
            height: 100.h,
            child:StreamBuilder(
              stream: status_repository.get_status(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: color3,),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed('status_view', extra: (snapshot.data!.docs[index]["id"],snapshot.data!.docs[index]["username"],snapshot.data!.docs[index]["url"],snapshot.data!.docs[index]["time"],snapshot.data!.docs[index]["imageUrl"]));
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(snapshot.data!.docs[index]["imageUrl"]),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              snapshot.data!.docs[index]["username"],
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold,color: textcolor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ),
          // grid view for status
          Expanded(
            child: StreamBuilder(
              stream: status_repository.get_status(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: color3,),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    //childAspectRatio: 0.7,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                      child: GestureDetector(
                        onTap: () {
                           context.goNamed('status_view', extra: (snapshot.data!.docs[index]["id"],snapshot.data!.docs[index]["username"],snapshot.data!.docs[index]["url"],snapshot.data!.docs[index]["time"],snapshot.data!.docs[index]["imageUrl"]));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backbackground,
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.docs[index]["url"]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ).animate(effects: [FadeEffect(duration: Duration(seconds: 1))]),
    );
  }
}
