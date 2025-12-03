// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PharmacyViewModel on _PharmacyViewModelBase, Store {
  late final _$pharmaciesAtom =
      Atom(name: '_PharmacyViewModelBase.pharmacies', context: context);

  @override
  List<Pharmacy> get pharmacies {
    _$pharmaciesAtom.reportRead();
    return super.pharmacies;
  }

  @override
  set pharmacies(List<Pharmacy> value) {
    _$pharmaciesAtom.reportWrite(value, super.pharmacies, () {
      super.pharmacies = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PharmacyViewModelBase.isLoading', context: context);

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

  late final _$getClosestPharmacyAsyncAction = AsyncAction(
      '_PharmacyViewModelBase.getClosestPharmacy',
      context: context);

  @override
  Future<void> getClosestPharmacy() {
    return _$getClosestPharmacyAsyncAction
        .run(() => super.getClosestPharmacy());
  }

  late final _$_PharmacyViewModelBaseActionController =
      ActionController(name: '_PharmacyViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_PharmacyViewModelBaseActionController.startAction(
        name: '_PharmacyViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_PharmacyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pharmacies: ${pharmacies},
isLoading: ${isLoading}
    ''';
  }
}
