import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/medication_service.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:mobx/mobx.dart';

// part file removed to avoid build_runner requirement for now

class AddMedicationViewModel extends _AddMedicationViewModelBase with Store {}

abstract class _AddMedicationViewModelBase extends BaseViewModel {
  String barcodeError = "not valid!";
  late MedicationService _networkServices;
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> medicationFormState;
  DateTime? expiredDate;
  late TextEditingController medicationNameController;
  late TextEditingController companyController;
  late TextEditingController activeIngredientController;
  late TextEditingController barcodeController;

  void setContext(BuildContext context) => this.viewContext = context;

  void init() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    medicationNameController = TextEditingController();
    companyController = TextEditingController();
    barcodeController = TextEditingController();
    activeIngredientController = TextEditingController();
    _networkServices = MedicationService();
    medicationFormState = GlobalKey<FormState>();
  }

  Future<String> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        LocaleKeys.home_CANCEL.locale,
        true,
        ScanMode.QR,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;
  }

  Future<bool> fillCardWithScannedMedication(String barcode) async {
    try {
      expiredDate = _convertQRtoExpiredDate(barcode);
      final String validBarcode = _validBarcode(barcode);
      if (validBarcode.compareTo(barcodeError) != 0) {
        final Response response =
            await _networkServices.getMedicationFromBarcode(validBarcode);
        if (response.statusCode == HttpStatus.ok) {
          final InventoryModel scannedMed =
              InventoryModel.fromMap(response.data);
          scannedMed.expiredDate = expiredDate;
          medicationNameController.text = scannedMed.name ?? '';
          activeIngredientController.text =
              scannedMed.activeIngredient ?? '';
          companyController.text = scannedMed.company ?? '';
          barcodeController.text = scannedMed.barcode ?? '';
          return true;
        }
      }
    } catch (e) {
      final int? statusCode = (e is DioError) ? e.response?.statusCode : null;
      if (statusCode == HttpStatus.serviceUnavailable) {
        final snackBar = SnackBar(
          content: Text("Server Error"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(viewContext!).showSnackBar(snackBar);
        return true;
      } else if (statusCode == HttpStatus.notFound) {
        final snackBar = SnackBar(
          content: Text("Barcode could not be found in the system"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(viewContext!).showSnackBar(snackBar);
        return true;
      }
    }
    return false;
  }

  String _validBarcode(String barcode) {
    if (barcode.length == 13) {
      return barcode;
    } else {
      return _convertQRtoBarcode(barcode);
    }
  }

  String _convertQRtoBarcode(String qr) {
    const String gs = '\x1D';
    if (qr.contains(gs)) {
      final int first = qr.indexOf(gs);
      final int last = qr.lastIndexOf(gs);
      if (first != last) {
        if (qr.substring(first + 1, first + 4).compareTo("010") == 0) {
          final String barcode = qr.substring(first + 4, first + 17);
          return barcode;
        }
      }
    }
    return barcodeError;
  }

  DateTime? _convertQRtoExpiredDate(String qr) {
    const String gs = '\x1D';
    if (qr.contains(gs)) {
      final int first = qr.indexOf(gs);
      final int last = qr.lastIndexOf(gs);
      if (first != last) {
        if (qr.substring(first + 1, first + 4).compareTo("010") == 0) {
          final String skt = qr.substring(last + 3, last + 9);
          final int? year = int.tryParse("20" + skt.substring(0, 2));
          final int? month = int.tryParse(skt.substring(2, 4));
          final int? day = int.tryParse(skt.substring(4, 6));
          if (year == null || month == null || day == null) return null;
          return DateTime.utc(year, month, day);
        }
      }
    }
    return null;
  }

  String? validateBarcode(String? value) {
    try {
      if (value == null) return barcodeError;
      BigInt.parse(value);
      return null;
    } catch (_) {
      return barcodeError;
    }
  }
}
