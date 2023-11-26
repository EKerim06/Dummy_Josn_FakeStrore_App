import 'package:dummy_json_with_bloc/constant/applicaton_constant/applicaton_constant.dart';
import 'package:dummy_json_with_bloc/core/model/product_model.dart';
import 'package:vexana/vexana.dart';

///Network Manager Base Options settings.
class ProductNetworkManager extends NetworkManager<ProductModel> {
  ///Network Manager Base Options added baseUrl.
  ProductNetworkManager() : super(options: BaseOptions(baseUrl: ApplicationConstant.instance.baseUrl));
}
