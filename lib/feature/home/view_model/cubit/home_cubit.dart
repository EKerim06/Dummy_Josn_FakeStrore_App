// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:dummy_json_with_bloc/core/model/product_model.dart';
import 'package:dummy_json_with_bloc/core/service/network_service.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

///Home Cibut
class HomeCubit extends Cubit<HomeState> {
  ///Home Cibut constructor
  HomeCubit(this.networkService) : super(const HomeState(isLoading: false, isInit: true)) {
    initialComplete();
  }

  ///Futured businnes.
  Future<void> initialComplete() async {
    await Future.microtask(() {
      emit(const HomeState(isInit: true));
    });
    await Future.wait<dynamic>([
      fetchCategories(),
      fetchAllProduct(),
    ]);
    // emit(state.copyWith(productModel: state.productModel));
  }

  ///Search
  Future<void> search(String value) async {
    _loadingChange();
    if (value.length > 3) {
      final response = await networkService.searchItems(value);
      emit(state.copyWith(productModel: response));
    }
    _loadingChange();
  }

  ///Network Service
  late final INetworkService networkService;

  ///Fetch All Product
  Future<void> fetchAllProduct() async {
    _loadingChange();
    final response = await networkService.fetchAllProduct();
    emit(state.copyWith(productModel: response));
    _loadingChange();
  }

  void _loadingChange() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }

  void _newItemChangeLoading() {
    emit(state.copyWith(newItemsLoading: !(state.newItemsLoading ?? false)));
  }

  ///next page [10] items
  Future<void> fetchNewItems() async {
    if (state.isLoading ?? false) return;
    _newItemChangeLoading();

    var pageNumber = state.pageNumber ?? 1;
    final skippingCount = pageNumber.isEven ? 10 : 0;
    final response = await networkService.fetchNewItems(
      count: ++pageNumber * 5,
      skipCount: skippingCount,
    );

    emit(state.copyWith(productModel: response, pageNumber: pageNumber));

    _newItemChangeLoading();
  }

  ///Fetching all categories
  Future<void> fetchCategories() async {
    final data = await networkService.fetchCategories();

    emit(state.copyWith(categories: data ?? []));
  }

  ///Fetching data  according to with categories
  Future<void> fetchSelectedCategories(String selectedCategories) async {
    final categories = await networkService.fetchingDataWithCategories(
      selectedCategories,
    );

    emit(state.copyWith(productModel: categories));
  }
}
