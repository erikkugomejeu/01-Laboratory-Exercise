const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('Item "$name" is not on the menu.');
  }
  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) {
  return items.fold(0.0, (sum, item) => sum + item.subtotal);
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  final customerName = customer ?? 'Guest';
  print('Order for $customerName');
  
  for (var item in items) {
    final lineTotal = item.subtotal.toStringAsFixed(2);
    print('${item.qty} x ${item.name.padRight(14)} $lineTotal');
  }

  final sub = total(items);
  print('Subtotal'.padRight(19) + sub.toStringAsFixed(2));

  double finalTotal = sub;
  if (sub >= 300) {
    final discount = sub * 0.10;
    print('${'Discount 10%'.padRight(19)}-${discount.toStringAsFixed(2)}');
    finalTotal = sub - discount;
  }

  print('Total'.padRight(19) + finalTotal.toStringAsFixed(2));
  print('');
}

void main() {
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(order1);

  final order2 = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 2),
  ];
  printReceipt(order2, customer: 'Maria');
}
