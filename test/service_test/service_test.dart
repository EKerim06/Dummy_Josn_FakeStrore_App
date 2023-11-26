import 'package:dummy_json_with_bloc/constant/applicaton_constant/applicaton_constant.dart';
import 'package:dummy_json_with_bloc/core/model/product_model.dart';
import 'package:dummy_json_with_bloc/core/service/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

void main() {
  late final INetworkService networkService;

  setUp(() {
    networkService = NetworkService(
      NetworkManager<ProductModel>(
        options: BaseOptions(
          baseUrl: ApplicationConstant.instance.baseUrl,
        ),
      ),
    );
  });

  test('fetching all product service test', () async {
    final response = await networkService.fetchAllProduct();

    expect(response?.products, isNotEmpty);
  });

  test('fetching count items', () async {
    final response = await networkService.fetchNewItems(count: 20);

    expect(response?.products, isNotEmpty);
  });

  test('fetch all categories', () async {
    final response = await networkService.fetchCategories();

    expect(response, isNotEmpty);
  });

  test('fetching selected categories items', () async {
    final response = await networkService.fetchingDataWithCategories('laptops');

    expect(response?.products, isNotEmpty);
  });
}
