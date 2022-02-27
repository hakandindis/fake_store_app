import 'package:fake_store_app/feature/home/service/home_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

void main() {
  late IHomeService homeService;

  setUp(() {
    homeService = HomeService(NetworkManager(
        options: BaseOptions(baseUrl: 'https://fakestoreapi.com/')));
  });

  test("fetchAllProducts - test", () async {
    final response = await homeService.fetchAllProducts();
    expect(response, isNotEmpty);
  });
}
