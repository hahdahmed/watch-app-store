import 'package:flutter/material.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/services/api_service.dart';

class WatchProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Watchcardmodel> watches = [];

  bool isLoading = false;

  String? errorMessage;

  Future<void> getWatches() async {
    isLoading = true;
    notifyListeners();

    try {
      watches = await apiService.getWatches();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
