// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_medication_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IntakeMedicationViewModel on _IntakeMedicationViewModelBase, Store {
  late final _$selectedTimeAtom = Atom(
      name: '_IntakeMedicationViewModelBase.selectedTime', context: context);

  @override
  String get selectedTime {
    _$selectedTimeAtom.reportRead();
    return super.selectedTime;
  }

  @override
  set selectedTime(String value) {
    _$selectedTimeAtom.reportWrite(value, super.selectedTime, () {
      super.selectedTime = value;
    });
  }

  late final _$dateAtom =
      Atom(name: '_IntakeMedicationViewModelBase.date', context: context);

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$timesAtom =
      Atom(name: '_IntakeMedicationViewModelBase.times', context: context);

  @override
  int get times {
    _$timesAtom.reportRead();
    return super.times;
  }

  @override
  set times(int value) {
    _$timesAtom.reportWrite(value, super.times, () {
      super.times = value;
    });
  }

  late final _$periodAtom =
      Atom(name: '_IntakeMedicationViewModelBase.period', context: context);

  @override
  String get period {
    _$periodAtom.reportRead();
    return super.period;
  }

  @override
  set period(String value) {
    _$periodAtom.reportWrite(value, super.period, () {
      super.period = value;
    });
  }

  late final _$pickDateAsyncAction =
      AsyncAction('_IntakeMedicationViewModelBase.pickDate', context: context);

  @override
  Future pickDate(BuildContext context) {
    return _$pickDateAsyncAction.run(() => super.pickDate(context));
  }

  late final _$_IntakeMedicationViewModelBaseActionController =
      ActionController(
          name: '_IntakeMedicationViewModelBase', context: context);

  @override
  void incrementTimes(int x) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.incrementTimes');
    try {
      return super.incrementTimes(x);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPeriod(String value) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.setPeriod');
    try {
      return super.setPeriod(value);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTime(TimeOfDay time) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.setSelectedTime');
    try {
      return super.setSelectedTime(time);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTime: ${selectedTime},
date: ${date},
times: ${times},
period: ${period}
    ''';
  }
}
