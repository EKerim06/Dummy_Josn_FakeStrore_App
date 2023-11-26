// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

/// Home View State
class HomeState extends Equatable {
  ///Home View State constructorf
  const HomeState({
    this.productModel,
    this.isLoading,
    // this.newItems,
    this.pageNumber,
    this.isInit = false,
    this.newItemsLoading,
    this.categories,
  });

  final int? pageNumber;

  final bool isInit;

  final bool? newItemsLoading;

  final ProductModel? productModel;

  final bool? isLoading;

  final List<String>? categories;

  @override
  List<Object?> get props => [
        productModel,
        isLoading,
        pageNumber,
        newItemsLoading,
        categories,
      ];

  ///Home View State copyWith Method
  ///This method is used to copy the current state and change the values
  HomeState copyWith({
    ProductModel? productModel,
    bool? isLoading,
    bool? newItemsLoading,
    int? pageNumber,
    List<String>? categories,
    // ProductModel? newItems,
  }) {
    return HomeState(
      productModel: productModel ?? this.productModel,
      isLoading: isLoading ?? this.isLoading,
      newItemsLoading: newItemsLoading ?? this.newItemsLoading,
      pageNumber: pageNumber ?? this.pageNumber,
      categories: categories ?? this.categories,
    );
  }
}
