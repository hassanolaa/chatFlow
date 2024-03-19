import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/model/user.dart';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class status_repository {
  // upload status image to firebase storage
  static Future<void> upload_statas_to_storage(int platform) async {
    if (platform == 0) {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
        );
        if (filePickerResult != null) {
          Uint8List? fileBytes = await filePickerResult.files.first.bytes;
          print("Uploaded image to app");
          final uuid = Uuid().v4();
          Reference ref = await FirebaseStorage.instance
              .ref()
              .child("status")
              .child("$uuid.jpg");
          final metadata = SettableMetadata(
            contentType: "image/jpeg",
          );

          print("here is the ref");
          print(fileBytes);
          var uploadTask = await ref.putData(fileBytes!, metadata);
          print("Uploaded image to server");
          //videoUrl = await uploadTask.ref.getDownloadURL();
          upload_status_to_firestore(await uploadTask.ref.getDownloadURL());

        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
        );
        if (filePickerResult != null) {
          File file = File(filePickerResult.files.single.path!);
          final uuid = Uuid().v4();
          Reference ref = await FirebaseStorage.instance
              .ref()
              .child("status")
              .child("$uuid.jpg");
          final metadata = SettableMetadata(
            contentType: "image/jpeg",
          );

          var uploadTask = await ref.putFile(file!, metadata);
          print("Uploaded image to server");
          upload_status_to_firestore(await uploadTask.ref.getDownloadURL());
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // upload status image to firebase firestore
  static Future<void> upload_status_to_firestore(String url) async {
   user u=await user_repository.getUserInfo();
    try {
      await FirebaseFirestore.instance.collection("status").add({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'username': u.username,
        'imageUrl': u.imageUrl,
        "url": url,
        "time": DateFormat.Hm('en_US').format(DateTime.now()),
      });
    } catch (e) {
      print(e);
    }
  }
  
  // get status from firebase firestore
  static Stream<QuerySnapshot> get_status() {
    return FirebaseFirestore.instance.collection("status").snapshots();
  }



}
