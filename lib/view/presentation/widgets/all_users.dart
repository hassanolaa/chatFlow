import 'package:chat_app/const/const.dart';
import 'package:chat_app/repository/massage_repository.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class all_users extends StatefulWidget {
  all_users({
    super.key,
  });

  @override
  State<all_users> createState() => _all_usersState();
}

class _all_usersState extends State<all_users> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backbackground,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Text(
            "All Users",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: user_repository.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async{
                         if( await massage_repository
                              .checkChat(snapshot.data!.docs[index]['id'])){
                            context.goNamed('chat', extra: (
                          await massage_repository.getChatId( snapshot.data!.docs[index]['id']),
                            snapshot.data!.docs[index]['username'],
                            snapshot.data!.docs[index]['imageUrl'],
                            ));
                              }else{
                                massage_repository.createChat(
                                  snapshot.data!.docs[index]['id'],
                                  snapshot.data!.docs[index]['username'],
                                  snapshot.data!.docs[index]['imageUrl'],
                                );
                                context.goNamed('chat', extra: (
                               await   massage_repository.getChatId( snapshot.data!.docs[index]['id']),
                                  snapshot.data!.docs[index]['username'],
                                  snapshot.data!.docs[index]['imageUrl'],
                                  
                           
                           ));
                              }
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['imageUrl']),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              snapshot.data!.docs[index]['username'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
