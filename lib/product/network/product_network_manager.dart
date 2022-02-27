import 'package:fake_store_app/product/constant/application_constant.dart';
import 'package:vexana/vexana.dart';

class ProductNetworkManager extends NetworkManager {
  ProductNetworkManager()
      : super(
          options: BaseOptions(baseUrl: ApplicationConstant.instance.baseUrl),
        );
}
