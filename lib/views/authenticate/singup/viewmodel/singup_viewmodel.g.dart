// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singup_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupViewModel on _SignupViewModelBase, Store {
  late final _$_dateAtom =
      Atom(name: '_SignupViewModelBase._date', context: context);

  @override
  DateTime get _date {
    _$_dateAtom.reportRead();
    return super._date;
  }

  @override
  set _date(DateTime value) {
    _$_dateAtom.reportWrite(value, super._date, () {
      super._date = value;
    });
  }

  late final _$_SignupViewModelBaseActionController =
      ActionController(name: '_SignupViewModelBase', context: context);

  @override
  void _changeDate(DateTime pickedDate) {
    final _$actionInfo = _$_SignupViewModelBaseActionController.startAction(
        name: '_SignupViewModelBase._changeDate');
    try {
      return super._changeDate(pickedDate);
    } finally {
      _$_SignupViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
