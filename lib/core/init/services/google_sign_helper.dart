import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private() {
    //user change listener!!
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print("signed out stream listener!!!");
        await _deleteUserFromCache();
      } else {
        print("signed in stream listener!!!");
        await _saveUserToCache(user);
      }
    });
  }
  static GoogleSignHelper get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;

  Future<bool> signOut() async {
    try {
      if (_auth.currentUser != null) await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  //enter application via google
  Future<User?> firebaseSigninWithGoogle() async {
    try {
      final GoogleAuthProvider provider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _auth.signInWithProvider(provider);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  //sign with Email and Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        //String tempToken = await user.getIdToken();
        //print(tempToken);
        return user;
      }
      return null;
    } on FirebaseAuthException {
      return null;
    } catch (e) {
      return null;
    }
  }

  //kayıt edip signin oluyor!!!! return UserCredential or error message
  Future<dynamic> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return LocaleKeys.authentication_WEAK_PASSWORD.locale;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return LocaleKeys.authentication_ACCOUNT_ALREADY_EXIST.locale;
      }
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  //helper functions

  Future<void> _saveUserToCache(User user) async {
    var tokenResult = await user.getIdToken();
    await _setSharedPrefToken(tokenResult.toString());
    await _setSharedPrefUid(user.uid.toString());
    await _setSharedPrefRefreshToken(user.refreshToken.toString());
  }

  Future<void> _deleteUserFromCache() async {
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.TOKEN);
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.UID);
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.REFRESHTOKEN);
  }

  Future<void> _setSharedPrefUid(String uid) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.UID, uid);
  }

  Future<void> _setSharedPrefRefreshToken(String refreshToken) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.REFRESHTOKEN, refreshToken);
  }

  Future<void> _setSharedPrefToken(String tokenResult) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.TOKEN, tokenResult.toString());
  }

  Future<String?> changePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      return "password changed!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "error";
    }
  }
}
