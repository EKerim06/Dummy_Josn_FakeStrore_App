import 'package:dummy_json_with_bloc/constant/enum/network_routes.dart';
import 'package:dummy_json_with_bloc/core/model/product_model.dart';
import 'package:dummy_json_with_bloc/product/query/product_query.dart';
import 'package:vexana/vexana.dart';

///
abstract class INetworkService {
  ///Default constructor
  INetworkService({required INetworkManager manager}) : _manager = manager;
  late final INetworkManager _manager;

  ///Fetching all product not query
  Future<ProductModel?>? fetchAllProduct({int count = 10});

  ///Data is come to an end, whereas fetching new data items
  Future<ProductModel?>? fetchNewItems({int count = 10, int skipCount = 15});

  ///Search items. [value] is search value is item default count [count = 10]
  Future<ProductModel?>? searchItems(
    String value, {
    int count = 15,
  });

  ///Fetching categories
  Future<List<String>?> fetchCategories();

  ///Fetching data according to with categories
  Future<ProductModel>? fetchingDataWithCategories(String selectedCategories);
}

///Network data pull service
class NetworkService extends INetworkService {
  ///Default constructor
  NetworkService(
    INetworkManager networkManager,
  ) : super(manager: networkManager);

  @override
  Future<ProductModel?>? fetchAllProduct({int count = 10}) async {
    final data = await _manager.send<ProductModel, ProductModel>(
      NetworkRoutes.products.name,
      parseModel: ProductModel(),
      method: RequestType.GET,
      queryParameters: Map.fromEntries([
        ProductQuery.limit.toMapEntry('$count'),
      ]),
    );

    print(data.data?.products?.length ?? 0);
    return data.data;
  }

  @override
  Future<ProductModel?>? fetchNewItems({
    int count = 10,
    int skipCount = 15,
  }) async {
    final data = await _manager.send<ProductModel, ProductModel>(
      NetworkRoutes.products.name,
      parseModel: ProductModel(),
      method: RequestType.GET,
      queryParameters: Map.fromEntries([
        ProductQuery.limit.toMapEntry('$count'),
        // ProductQuery.skip.toMapEntry('$skipCount'),
      ]),
    );
    print(data.data?.products?.length ?? 0);
    return data.data;
  }

  @override
  Future<ProductModel?>? searchItems(
    String value, {
    int count = 10,
  }) async {
    final data = await _manager.send<ProductModel, ProductModel>(
      '${NetworkRoutes.products.name}/${NetworkRoutes.search.name}?q=$value',
      parseModel: ProductModel(),
      method: RequestType.GET,
      queryParameters: Map.fromEntries([
        ProductQuery.limit.toMapEntry('$count'),
        // ProductQuery.skip.toMapEntry('$count'),
      ]),
    );
    return data.data!;
  }

  @override
  Future<List<String>?> fetchCategories() async {
    final data = await _manager.sendPrimitive<List<dynamic>>(
      '${NetworkRoutes.products.name}/${NetworkRoutes.categories.name}',
    );
    return data is List ? data.map((e) => e.toString()).toList() : null;
  }

  @override
  Future<ProductModel>? fetchingDataWithCategories(
    String selectedCategories,
  ) async {
    final data = await _manager.send<ProductModel, ProductModel>(
      '${NetworkRoutes.products.name}/${NetworkRoutes.category.name}/$selectedCategories',
      parseModel: ProductModel(),
      method: RequestType.GET,
      // queryParameters: Map.fromEntries([
      //   ProductQuery.limit.toMapEntry('$count'),
      // ProductQuery.skip.toMapEntry('$count'),
      // ]),
    );

    return data.data!;
  }
}
