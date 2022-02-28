import 'package:fake_store_app/feature/home/service/home_service.dart';
import 'package:fake_store_app/product/network/product_network_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IHomeService homeService;

  setUp(() {
    homeService = HomeService(ProductNetworkManager());
  });

  test("fetchAllProducts - test", () async {
    final response = await homeService.fetchAllProducts();
    expect(response, isNotEmpty);
  });

  test("fetchAllCategories - test", () async {
    final response = await homeService.fetchAllCategories();
    expect(response, isNotEmpty);
  });


}
