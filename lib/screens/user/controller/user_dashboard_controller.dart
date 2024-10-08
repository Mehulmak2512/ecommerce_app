import 'package:ecommerce_app/screens/user/repository/user_product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dashboard_controller.g.dart';

@riverpod
class UserDashboardController extends _$UserDashboardController {
  @override
  Future<List<Map<String, dynamic>>> build() {
    ProductRepository productRepository = ProductRepository();
    return productRepository.allProducts();
  }

  Future<void> getProductList() async {
    ProductRepository productRepository = ProductRepository();
    state = AsyncData( await productRepository.allProducts());
    // log("state -- $state");
    }

}
