import 'package:ecommerce_app/screens/seller/controller/seller_dashboard_controller.dart';
import 'package:ecommerce_app/screens/user/controller/cart_provider.dart';
import 'package:ecommerce_app/screens/user/repository/user_product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';


@riverpod
class Order extends _$Order {
  @override
  Future<List<Map<String, dynamic>>> build() {
    return getOrderList();
  }
  ProductRepository productRepository = ProductRepository();

  Future<List<Map<String, dynamic>>> getOrderList() {
    final allOrders = productRepository.allOrders();
    return allOrders;
  }
  Future<void> placeOrder({ required List<Map<String, dynamic>> data,required int totalPrice,required int productQuantity}) async {
    await productRepository.placeOrder(data: data,totalPrice: totalPrice, productQuantity: productQuantity ).then((value)  {
      ref.read(cartProvider.notifier).deleteCart();
      ref.read(sellerDashBoardControllerProvider.notifier).updateQuantity(data: data);
    },);
  }
}

@riverpod
class OrderItem extends _$OrderItem {
  @override
  Future<List<Map<String, dynamic>>> build(String orderId) {
    return getOrderItemList(orderId: orderId);
  }

  ProductRepository productRepository = ProductRepository();

  Future<List<Map<String, dynamic>>> getOrderItemList({required String orderId}) async{
    final orderItems = await productRepository.orderItems(orderId: orderId);
    return orderItems;
  }
}