import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:mobx/mobx.dart';

part 'singup_viewmodel.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store, BaseViewModel {
  late TextEditingController nameController;
  late TextEditingController mailController;
  late TextEditingController idController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> singupFormState;

  @observable
  DateTime _date = DateTime.now();

  DateTime get date => _date;

  String get getDate => formatDate(_date, [dd, '/', mm, '/', yyyy]);

  set date(DateTime date) {
    _date = date;
  }

  void setContext(BuildContext context) => this.viewContext = context;
  void init() {
    nameController = TextEditingController();
    mailController = TextEditingController();
    idController = TextEditingController();
    passwordController = TextEditingController();
    singupFormState = GlobalKey();
  }

  //contorllerleri nerede dispose edeceğim???
  pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1980),
        firstDate: DateTime(1920),
        lastDate: DateTime(2020));
    if (pickedDate != null) _changeDate(pickedDate);
    print(date);
  }

  @action
  void _changeDate(DateTime pickedDate) {
    if (pickedDate != null) {
      date = pickedDate;
    }
  }

  String? emptyCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "This form required!";
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  //register user and put user data to firebaseDb
  Future<String> userRegistration() async {
    if (singupFormState.currentState.validate()) {
      UserDataModel userDataModel = UserDataModel(
          birthDay: getDate.toString(),
          fullName: nameController.text,
          mail: mailController.text);
      String signupResponse = await AuthManager.instance
          .registerUser(userDataModel, passwordController.text);
      //go to splash screen, if signup succesful.
      if (signupResponse
              .compareTo(LocaleKeys.authentication_SIGNUP_SUCCESFUL.locale) ==
          0) {
        await navigation.navigateToPage(path: NavigationConstants.SPLASH_VIEW);
      }
      return signupResponse;
    }
    return LocaleKeys.authentication_FILL_ALL_FIELDS.locale;
  }
}
