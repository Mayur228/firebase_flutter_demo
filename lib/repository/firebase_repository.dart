import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_flutter/login_page/model/user_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<UserData?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return UserData(
        googleUser?.displayName ?? '',
        googleUser?.id ?? '',
        googleUser?.photoUrl ?? '',
        googleUser?.email ?? '',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isSignIn() async {
    try {
      final isSignIn = await GoogleSignIn().isSignedIn();
      if (isSignIn) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> verifyPhone({
  required String phoneNumber,
  required Function(PhoneAuthCredential) verificationCompleted,
  required Function(FirebaseAuthException) verificationFailed,
  required Function(String, int?) codeSent,
  required Function(String) codeAutoRetrievalTimeout,
}) async {
  await _firebaseAuth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: verificationCompleted,
    verificationFailed: verificationFailed,
    codeSent: codeSent,
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  );
}

   Future<UserCredential> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }
}
