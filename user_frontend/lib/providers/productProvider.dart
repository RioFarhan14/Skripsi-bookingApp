import 'package:flutter/material.dart';
import 'package:user_frontend/models/field.dart';
import 'package:user_frontend/services/product-service.dart';

class ProductProvider with ChangeNotifier {
  List<Field> _fields = [];
  bool _isLoading = false;

  List<Field> get fields => _fields;
  bool get isLoading => _isLoading;

  final ProductService _service;

  ProductProvider(this._service);

  Future<void> fetchFields() async {
    _isLoading = true;
    notifyListeners();

    try {
      _fields = await _service.getAllField();
    } catch (e) {
      // Handle error
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}
