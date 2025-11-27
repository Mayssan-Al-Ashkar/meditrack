// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordViewModel on _ResetPasswordViewModelBase, Store {
  late final _$isPasswordVisibleAtom = Atom(
      name: '_ResetPasswordViewModelBase.isPasswordVisible', context: context);

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$_ResetPasswordViewModelBaseActionController =
      ActionController(name: '_ResetPasswordViewModelBase', context: context);

  @override
  void seePassword() {
    final _$actionInfo = _$_ResetPasswordViewModelBaseActionController
        .startAction(name: '_ResetPasswordViewModelBase.seePassword');
    try {
      return super.seePassword();
    } finally {
      _$_ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPasswordVisible: ${isPasswordVisible}
    ''';
  }
}
