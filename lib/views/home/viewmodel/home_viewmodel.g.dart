// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewmodel on _HomeViewmodelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeViewmodelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$eventsAtom =
      Atom(name: '_HomeViewmodelBase.events', context: context);

  @override
  Map<DateTime, List<ReminderModel>> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(Map<DateTime, List<ReminderModel>> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$selectedEventsAtom =
      Atom(name: '_HomeViewmodelBase.selectedEvents', context: context);

  @override
  List<ReminderModel> get selectedEvents {
    _$selectedEventsAtom.reportRead();
    return super.selectedEvents;
  }

  @override
  set selectedEvents(List<ReminderModel> value) {
    _$selectedEventsAtom.reportWrite(value, super.selectedEvents, () {
      super.selectedEvents = value;
    });
  }

  late final _$_HomeViewmodelBaseActionController =
      ActionController(name: '_HomeViewmodelBase', context: context);

  @override
  void onDaySelected(DateTime day, DateTime focusedDay) {
    final _$actionInfo = _$_HomeViewmodelBaseActionController.startAction(
        name: '_HomeViewmodelBase.onDaySelected');
    try {
      return super.onDaySelected(day, focusedDay);
    } finally {
      _$_HomeViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPageChanged(DateTime focusedDay) {
    final _$actionInfo = _$_HomeViewmodelBaseActionController.startAction(
        name: '_HomeViewmodelBase.onPageChanged');
    try {
      return super.onPageChanged(focusedDay);
    } finally {
      _$_HomeViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLoading() {
    final _$actionInfo = _$_HomeViewmodelBaseActionController.startAction(
        name: '_HomeViewmodelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_HomeViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
events: ${events},
selectedEvents: ${selectedEvents}
    ''';
  }
}
