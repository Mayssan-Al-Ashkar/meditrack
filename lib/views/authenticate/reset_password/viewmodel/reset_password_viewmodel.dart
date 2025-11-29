import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_viewmodel.g.dart';

class ResetPasswordViewModel = _ResetPasswordViewModelBase
    with _$ResetPasswordViewModel;

abstract class _ResetPasswordViewModelBase with Store, BaseViewModel {
  late GlobalKey<FormState> formResetPasswordState;
  late TextEditingController resetPasswordAgainController;
  late TextEditingController resetPasswordController;

  void setContext(BuildContext context) => this.viewContext = context;
  void init() {
    resetPasswordAgainController = TextEditingController();
    resetPasswordController = TextEditingController();
    formResetPasswordState = GlobalKey();
  }

  @observable
  bool isPasswordVisible = false;
  bool isPasswordVisibleAgain = false;

  @action
  void seePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  String? validatePassword(String? value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || !regExp.hasMatch(value) || value.length < 8) {
      return 'Enter valid password.';
    } else
      return comparePassword(
          resetPasswordController.text, resetPasswordAgainController.text);
    //return null;
  }

  String? comparePassword(String? value, String? newValue) {
    if (value != null && newValue != null && value != newValue)
      return 'Passwords does not match, please enter again.';
    else
      return null;
  }

  void changePassword() async {
    String? result =
        await AuthManager.instance.changePassword(resetPasswordController.text);
    final _snackBar = SnackBar(
      content: Text(result ?? ''),
    );
    ScaffoldMessenger.of(viewContext!).showSnackBar(_snackBar);
    //var x = await AuthManager.instance.setUserData(); ????????????
    // print(x.toString());
    debugPrint(result);
  }

  void navigateLoginPage() {
    navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
  }
}
