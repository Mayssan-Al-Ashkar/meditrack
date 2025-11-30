import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_service.dart';
import 'package:medication_app_v0/core/init/services/firebase_services.dart';
import 'package:medication_app_v0/core/init/services/google_sign_helper.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';

class AuthManager {
  static AuthManager? _instance;

  AuthManager._internal() {
    _googleSignHelper = GoogleSignHelper.instance;
    _firebaseService = FirebaseService();
    _preferencesManager = SharedPreferencesManager.instance;
  }

  static AuthManager get instance {
    _instance ??= AuthManager._internal();
    return _instance!;
  }

  late GoogleSignHelper _googleSignHelper;
  late SharedPreferencesManager _preferencesManager;
  late FirebaseService _firebaseService;

    String? get _getUid =>
      _preferencesManager.getStringValue(SharedPreferencesKey.UID);

    String? get _getToken =>
      _preferencesManager.getStringValue(SharedPreferencesKey.TOKEN);

  Future<bool> appAuth(String email, String password) async {
    try {
      if (await _googleSignHelper.signInWithEmailAndPassword(email, password) !=
          null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> googleAuth() async {
    //signin and send the user data to firebase
    try {
      User? googleUser = await _googleSignHelper.firebaseSigninWithGoogle();
      if (googleUser != null) {
        //first signin
        if (await getUserData() == null) {
          UserDataModel userData = UserDataModel(
              birthDay: "",
              fullName: googleUser.displayName,
              mail: googleUser.email);
          setUserData(userData);
        }
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  void signOut() async {
    if (await _googleSignHelper.signOut()) {
      await NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.SPLASH_VIEW);
    }
  }

  Future<UserDataModel?> getUserData() async {
    try {
      if (_getToken != null && _getUid != null) {
        return await _firebaseService.getUserData(_getToken!, _getUid!);
      }
    } catch (e) {}

    return null;
  }

  Future<String?> registerUser(
      UserDataModel userDataModel, String password) async {
    var singupResponse = await _googleSignHelper.signUpWithEmailAndPassword(
      userDataModel.mail ?? '', password);
    if (singupResponse is UserCredential) {
        String? token = await singupResponse.user!.getIdToken();
        if (token != null) {
          bool isSuccess = await _firebaseService.putUserData(
              singupResponse.user!.uid, token, userDataModel);
          if (isSuccess) {
            return LocaleKeys.authentication_SIGNUP_SUCCESFUL.locale;
          } else {
            return LocaleKeys.authentication_SIGNUP_FAILED.locale;
          }
        }
        return LocaleKeys.authentication_SIGNUP_FAILED.locale;
    } else {
      return singupResponse ?? LocaleKeys.authentication_SIGNUP_FAILED.locale;
    }
  }

  Future<bool> setUserData(UserDataModel userData) async {
    if (_getUid != null && _getToken != null) {
      return await _firebaseService.putUserData(_getUid!, _getToken!, userData);
    }
    return false;
  }

  Future<bool> postMedication(InventoryModel data) async {
    if (_getUid != null && _getToken != null) {
      return await _firebaseService.postMedication(_getUid!, _getToken!, data);
    }
    return false;
  }

  Future<List<InventoryModel>> getMedicationList() async {
    if (_getUid != null && _getToken != null) {
      return await _firebaseService.getMedications(_getToken!, _getUid!);
    }
    return [];
  }

  Future deleteMedication(InventoryModel model) async {
    if (_getUid != null && _getToken != null) {
      return await _firebaseService.deleteMedication(_getUid!, _getToken!, model);
    }
    return null;
  }

  Future<String?> changePassword(String newPassword) async {
    return await _googleSignHelper.changePassword(newPassword);
  }
}
