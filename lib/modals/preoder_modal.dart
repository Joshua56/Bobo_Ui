

import 'package:bobo_ui/modals/product_modal.dart';

class PreoderModal{
  final String id;
  final List<OderItemModal> orderItems;

  get totalAmount => calcTotalAmount();
  get map => _map();


  PreoderModal({
    this.id = '',
    this.orderItems
  });

  double calcTotalAmount(){
    double total = 0;
    orderItems.forEach((item){
      total += item.totalCost;
    });

    return total;
  }

  List _mapOrderItems(){
    List<Map<String, dynamic>> lst = [];
    orderItems.forEach((item){
      lst.add(
        item.map
      );
    });
    return lst;
  }

  Map<String, dynamic> _map(){
    return {
      'orderItems': _mapOrderItems()
    };
  }
}

class OderItemModal{
  final ProductModal product;
  final int quantity;

  get totalCost => product.price * quantity;
  get map => _map();

  OderItemModal({
    this.product,
    this.quantity
  });

  Map<String, dynamic> _map(){
    return {
      'product': product.map,
      'quantity': quantity,
    };
  }
}
