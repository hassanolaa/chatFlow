import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class user_repository {
// firebase auth sign in
  static Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
  }

  // firebase auth sign up
  static Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      throw e;
    }
  }

  // firebase auth sign out
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // firebase auth get current user
  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // firebase auth reset password
  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // todo: implement google sign in
  // firebase auth google sign in

  // user last seen
  static Future<void> userLastSeen() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .update({'lastseen': DateFormat.Hm('en_US').format(DateTime.now())});
  }

  // get last seen from firestore
  static Future<String> getLastSeen() async {
    String lastSeen = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .get()
        .then((value) {
      lastSeen = value.data()!['lastseen'];
    });
    return lastSeen;
  }

  // get last seen from firestore by username
  static Future<String> getLastSeenByUsername(String username) async {
    String lastSeen = '';
    await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get()
        .then((value) {
      lastSeen = value.docs[0].data()['lastseen'];
    });
    return lastSeen;
  }

  // add user info to firestore
  static Future<void> addUserInfo(String imageUrl, String username, String bio,
      String phone, int age, String gender) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .set({
      'imageUrl': imageUrl,
      'username': username,
      'bio': bio,
      'phone': phone,
      'age': age,
      'gender': gender,
      'id': getCurrentUser()!.uid,
    });
  }

  // get all users from firestore as QuerySnapshot without current user
  static Stream<QuerySnapshot> getAllUsers() {
    return FirebaseFirestore.instance
        .collection('users')
       .where('id', isNotEqualTo: getCurrentUser()!.uid)
        .snapshots();
  }

  // get chatusers from firestore as list of string (user id)
  static Future<List<String>> getChatUsers() async {
    List<String> chatUsers = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .collection('chatusers')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        chatUsers.add(element.data()['userid']);
      });
    });
    print(chatUsers);
    return chatUsers;
  }

  // upload user image to firebase storage

  // get user info from firestore
  static Future<user> getUserInfo() async {
    Map<String, dynamic> userInfo = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .get()
        .then((value) {
      userInfo = value.data() as Map<String, dynamic>;
    });
    return user.fromJson(userInfo);
  }

  // get user info from firestore with return type of user class
}
