import 'package:watch_app/models/watchcardmodel.dart';

class CartItem {
  final WatchCardModel watch;
  int quantity;

  CartItem({
    required this.watch,
    this.quantity = 1,
  });

  double get totalPrice => watch.price * quantity;
}
