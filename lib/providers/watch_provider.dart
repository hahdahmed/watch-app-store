import 'package:flutter/material.dart';
import 'package:watch_app/models/cart_item.dart';
import 'package:watch_app/models/watchcardmodel.dart';
import 'package:watch_app/services/api_service.dart';

class WatchProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<WatchCardModel> watches = [];
  bool isLoading = false;
  String? errorMessage;

  int selectedCategoryIndex = 0;
  final List<String> categories = const [
    "Smart watch",
    "Casio",
    "Tissot",
    "Seiko",
    "Bremont",
    "Fossil",
  ];

  String searchQuery = "";

  final Set<int> _favoriteIds = {};
  final Map<int, CartItem> _cartItems = {};

  Set<int> get favoriteIds => Set.unmodifiable(_favoriteIds);
  Map<int, CartItem> get cartItems => Map.unmodifiable(_cartItems);

  List<CartItem> get cartItemList => _cartItems.values.toList();

  double get totalCartPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get cartCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> getWatches() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      watches = await apiService.getWatches();
    } catch (e) {
      errorMessage = e.toString();
      watches = ApiService.getFallbackWatches();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(int index) {
    if (selectedCategoryIndex != index) {
      selectedCategoryIndex = index;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  bool isFavorite(int watchId) {
    return _favoriteIds.contains(watchId);
  }

  void toggleFavorite(int watchId) {
    if (_favoriteIds.contains(watchId)) {
      _favoriteIds.remove(watchId);
    } else {
      _favoriteIds.add(watchId);
    }
    notifyListeners();
  }

  void addToCart(WatchCardModel watch) {
    if (_cartItems.containsKey(watch.id)) {
      _cartItems[watch.id]!.quantity += 1;
    } else {
      _cartItems[watch.id] = CartItem(watch: watch, quantity: 1);
    }
    notifyListeners();
  }

  void removeFromCart(int watchId) {
    if (_cartItems.containsKey(watchId)) {
      _cartItems.remove(watchId);
      notifyListeners();
    }
  }

  void updateCartQuantity(int watchId, int quantity) {
    if (_cartItems.containsKey(watchId)) {
      if (quantity <= 0) {
        _cartItems.remove(watchId);
      } else {
        _cartItems[watchId]!.quantity = quantity;
      }
      notifyListeners();
    }
  }

  List<WatchCardModel> get filteredWatches {
    List<WatchCardModel> list = watches;

    if (selectedCategoryIndex > 0 && selectedCategoryIndex < categories.length) {
      final categoryName = categories[selectedCategoryIndex].toLowerCase();
      final categoryFiltered = list.where((watch) {
        return watch.title.toLowerCase().contains(categoryName) ||
            watch.brand.toLowerCase().contains(categoryName) ||
            watch.description.toLowerCase().contains(categoryName);
      }).toList();

      if (categoryFiltered.isNotEmpty) {
        list = categoryFiltered;
      }
    }

    if (searchQuery.isNotEmpty) {
      list = list.where((watch) {
        return watch.title.toLowerCase().contains(searchQuery) ||
            watch.brand.toLowerCase().contains(searchQuery);
      }).toList();
    }

    return list;
  }
}
