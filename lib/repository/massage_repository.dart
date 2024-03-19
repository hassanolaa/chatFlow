import 'dart:io';
import 'dart:typed_data';
import 'package:chat_app/repository/user_repository/user_repository_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../model/user.dart';

class massage_repository {
  static Future<void> uploadimage(String chatid, int platform) async {
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
              .child("images")
              .child("$uuid.jpg");
          final metadata = SettableMetadata(
            contentType: "image/jpeg",
          );

          print("here is the ref");
          print(fileBytes);
          var uploadTask = await ref.putData(fileBytes!, metadata);
          print("Uploaded image to server");
          //videoUrl = await uploadTask.ref.getDownloadURL();
          sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 1);
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
              .child("images")
              .child("$uuid.jpg");
          final metadata = SettableMetadata(
            contentType: "image/jpeg",
          );

          var uploadTask = await ref.putFile(file!, metadata);
          print("Uploaded image to server");
          sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 1);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> uploadvideo(String chatid, int platform) async {
    if (platform == 0) {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'avi'],
        );
        if (filePickerResult != null) {
          Uint8List? fileBytes = await filePickerResult.files.first.bytes;
          print("Uploaded video to app");
          final uuid = Uuid().v4();
          Reference ref = await FirebaseStorage.instance
              .ref()
              .child("video")
              .child("$uuid.mp4");
          final metadata = SettableMetadata(
            contentType: "video/mp4",
          );

          print("here is the ref");
          print(fileBytes);
          var uploadTask = await ref.putData(fileBytes!, metadata);
          print("Uploaded video to server");
          //videoUrl = await uploadTask.ref.getDownloadURL();
          sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 2);
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'avi'],
        );
        if (filePickerResult != null) {
          File file = File(filePickerResult.files.single.path!);
          final uuid = Uuid().v4();
          Reference ref = await FirebaseStorage.instance
              .ref()
              .child("video")
              .child("$uuid.mp4");
          final metadata = SettableMetadata(
            contentType: "video/mp4",
          );

          var uploadTask = await ref.putFile(file!, metadata);
          print("Uploaded video to server");
          sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 2);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> uploadrecord(
      String chatid, String path, int platform) async {
    if (platform == 0) {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'avi'],
        );
        if (filePickerResult != null) {
          Uint8List? fileBytes = await filePickerResult.files.first.bytes;
          print("Uploaded video to app");
          final uuid = Uuid().v4();
          Reference ref = await FirebaseStorage.instance
              .ref()
              .child("video")
              .child("$uuid.mp4");
          final metadata = SettableMetadata(
            contentType: "video/mp4",
          );

          print("here is the ref");
          print(fileBytes);
          var uploadTask = await ref.putData(fileBytes!, metadata);
          print("Uploaded video to server");
          //videoUrl = await uploadTask.ref.getDownloadURL();
          sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 2);
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        final uuid = Uuid().v4();
        Reference ref = await FirebaseStorage.instance
            .ref()
            .child("records")
            .child("$uuid.m4a");
        final metadata = SettableMetadata(
          contentType: "audio/x-m4a",
        );

        var uploadTask = await ref.putFile(File(path), metadata);
        print("Uploaded video to server");
        sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 4);
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> uploadfile(String chatid, int platform, int type) async {
    if (type == 0) {
      if (platform == 0) {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: [
              'pdf',
            ],
          );
          if (filePickerResult != null) {
            Uint8List? fileBytes = filePickerResult.files.first.bytes;

            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.pdf");
            final metadata = SettableMetadata(
              contentType: "application/pdf",
            );
            var uploadTask = await ref.putData(fileBytes!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      } else {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (filePickerResult != null) {
            File file = File(filePickerResult.files.single.path!);
            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.pdf");
            final metadata = SettableMetadata(
              contentType: "application/pdf",
            );
            var uploadTask = await ref.putFile(file!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      }
    } else if (type == 1) {
      if (platform == 0) {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['docx'],
          );
          if (filePickerResult != null) {
            Uint8List? fileBytes = filePickerResult.files.first.bytes;

            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.docx");
            final metadata = SettableMetadata(
              contentType: "application/docx",
            );
            var uploadTask = await ref.putData(fileBytes!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      } else {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['docx'],
          );
          if (filePickerResult != null) {
            File file = File(filePickerResult.files.single.path!);
            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.docx");
            final metadata = SettableMetadata(
              contentType: "application/docx",
            );
            var uploadTask = await ref.putFile(file!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      }
    } else if (type == 2) {
      if (platform == 0) {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['xlsx'],
          );
          if (filePickerResult != null) {
            Uint8List? fileBytes = filePickerResult.files.first.bytes;

            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.xlsx");
            final metadata = SettableMetadata(
              contentType: "application/xlsx",
            );
            var uploadTask = await ref.putData(fileBytes!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      } else {
        try {
          FilePickerResult? filePickerResult =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['xlsx'],
          );
          if (filePickerResult != null) {
            File file = File(filePickerResult.files.single.path!);
            print("Uploaded Pdf to app");
            final uuid = Uuid().v4();
            Reference ref = await FirebaseStorage.instance
                .ref()
                .child("document")
                .child("$uuid.xlsx");
            final metadata = SettableMetadata(
              contentType: "application/xlsx",
            );
            var uploadTask = await ref.putFile(file!, metadata);
            print("Uploaded Pdf to server");
            sendMessage(chatid, await uploadTask.ref.getDownloadURL(), 3);
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  static Future<void> UploadImage_camera(String chatid) async {
    File? file;
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      file = File(image!.path);
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imgname = basename(image.path);
      var ref = FirebaseStorage.instance.ref(imgname);
      await ref.putFile(file!, metadata);
      print("Uploaded image to server");
      print(await ref.getDownloadURL());
      sendMessage(chatid, await ref.getDownloadURL(), 1);
    }
  }

// create chat between 2 users on firestore
  static Future<void> createChat(
      String chatId, String userId, String otherUserId) async {
    String userName =
        await getUserInfo(userId).then((value) => value.username!);
    String otherUserName =
        await getUserInfo(otherUserId).then((value) => value.username!);
    String image = await getUserInfo(userId).then((value) => value.imageUrl!);
    String otherImage =
        await getUserInfo(otherUserId).then((value) => value.imageUrl!);
    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'chatId': chatId,
      'userId': userId,
      'otherUserId': otherUserId,
      'part': [userId, otherUserId],
      'userName': userName,
      'otherUserName': otherUserName,
      'userImage': image,
      'otherUserImage': otherImage,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

// check if the chat already exist
  static Future<bool> checkChat(String otherUserId) async {
    bool exist = false;
    await FirebaseFirestore.instance
        .collection('chats')
        .where('part', arrayContains: user_repository.getCurrentUser()!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['part'].contains(otherUserId)) {
          exist = true;
        }
      });
    });
    return exist;
  }

  // get chat id
  static Future<String> getChatId(String otherUserId) async {
    String chatId = '';
    await FirebaseFirestore.instance
        .collection('chats')
        .where('part', arrayContains: user_repository.getCurrentUser()!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['part'].contains(otherUserId)) {
          chatId = element.data()['chatId'];
        }
      });
    });
    return chatId;
  }

  // search chat by username
  static Stream<QuerySnapshot> searchChat(String username) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('part', arrayContains: user_repository.getCurrentUser()!.uid)
        .snapshots();
  }

  // send message to firestore
  static Future<void> sendMessage(
      String chatId, String message, int type) async {
    String username = await getUserInfo(user_repository.getCurrentUser()!.uid)
        .then((value) => value.username!);
    String imageUrl = await getUserInfo(user_repository.getCurrentUser()!.uid)
        .then((value) => value.imageUrl!);
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'userId': user_repository.getCurrentUser()!.uid,
      'message': message,
      'username': username,
      'imageUrl': imageUrl,
      'timestamp': DateFormat.Hm('en_US').format(DateTime.now()),
      // 'timestamp': DateTime.now().millisecondsSinceEpoch,
      'type': type,
      'seen': false
    });
    if (type == 0) {
      sendLastMessage(chatId, message);
    } else if (type == 1) {
      sendLastMessage(chatId, "Image");
    } else if (type == 2) {
      sendLastMessage(chatId, "Video");
    } else if (type == 3) {
      sendLastMessage(chatId, "Document");
    } else if (type == 4) {
      sendLastMessage(chatId, "Record");
    }
  }

  // send last message
  static Future<void> sendLastMessage(
    String chatId,
    String message,
  ) async {
    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastmassage': message,
      'lastmassageTime': DateFormat.Hm('en_US').format(DateTime.now()),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // user seen message
  static Future<void> seenMessage(
    String chatId,
  ) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('userId', isNotEqualTo: user_repository.getCurrentUser()!.uid)
        // .where('seen', isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc(element.id)
            .update({
          'seen': true,
        });
      });
    });
  }

  // delete message
  static Future<void> deleteMessage(
    String chatId,
    String messageId,
  ) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  // get messages from firestore
  static Stream<QuerySnapshot> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // get chat list from firestore
  static Stream<QuerySnapshot> getChatList(String userId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('part', arrayContains: userId)
         .orderBy('timestamp',descending: true )
        .snapshots();
  }

 
  // get user info from firestore
  static Future<user> getUserInfo(String userId) async {
    Map<String, dynamic> userInfo = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      userInfo = value.data() as Map<String, dynamic>;
    });
    return user.fromJson(userInfo);
  }

  // get user info from firestore with return type of user class
  static Stream<QuerySnapshot> getUserInfo2(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: userId)
        .snapshots();
  }
}

List<Uint8List> test = [];
