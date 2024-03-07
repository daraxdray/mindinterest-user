import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:mindintrest_user/core/exception/failure.dart';
import 'package:mindintrest_user/utils/logger.dart';

enum AuthState { loggedIn, loggedOut }

class FBAuth {
  static AuthState checkAuthState() {
    tmiLogger.log(Level.info, FirebaseAuth.instance.currentUser);
    if (FirebaseAuth.instance.currentUser == null) {
      return AuthState.loggedOut;
    } else {
      return AuthState.loggedIn;
    }
  }

  static Future<bool> signInWithCustomToken(
    String customToken,
    FirebaseAuth? firebaseAuth,
  ) async {
    try {
      final userCredential =
          await firebaseAuth!.signInWithCustomToken(customToken);
      return userCredential.user != null;
    } on FirebaseException catch (e) {
      tmiLogger
        ..log(Level.debug, e.message)
        ..log(Level.debug, e.code)
        ..log(Level.debug, e.stackTrace);
      throw ApiFailure('Could not sign in with firebase');
    }
  }
}
