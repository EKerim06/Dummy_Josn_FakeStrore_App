// ignore_for_file: lines_longer_than_80_chars

import 'package:dummy_json_with_bloc/core/model/product_model.dart';
import 'package:dummy_json_with_bloc/core/service/network_service.dart';
import 'package:dummy_json_with_bloc/feature/home/view_model/cubit/home_cubit.dart';
import 'package:dummy_json_with_bloc/product/network_manager/product_network_manager.dart';
import 'package:dummy_json_with_bloc/product/widget/custom_dropdownbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

///Home View Page
class HomeView extends StatefulWidget {
  ///Home View Page constructor
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();

  // ignore: unused_element
  void _scrollableControl(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 1) {
        context.read<HomeCubit>().fetchNewItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(NetworkService(ProductNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: _searchText(),
          leading: const _DropDownButton(),
        ),
        body: _bodyListView(),
      ),
    );
  }

  Widget _searchText() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextFormField(
          onFieldSubmitted: (value) => context.read<HomeCubit>().search(value),
          decoration: const InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search),
          ),
        );
      },
    );
  }

  Widget _bodyListView() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) => (state.isInit) ? _scrollableControl(context) : null,
      builder: (context, state) {
        return state.isLoading ?? true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: _scrollController,
                // padding: context.padding.low,

                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                cacheExtent: 2,
                itemCount: state.productModel?.products?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = state.productModel?.products?[index];
                  return Column(
                    children: [
                      _ProductCard(item: item),
                      state.productModel!.products.ext.isNotNullOrEmpty && index == (state.productModel!.products!.length) - 1
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox(),
                    ],
                  );
                },
              );
      },
    );
  }
}

class _DropDownButton extends StatelessWidget {
  const _DropDownButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomDropdownbutton(
          items: state.categories ?? [],
          selectedCategories: (categories) => context.read<HomeCubit>().fetchSelectedCategories,
        );
      },
    );
  }
}

class _ProductCard extends StatefulWidget {
  const _ProductCard({required this.item});
  final Products? item;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Image.network(
          widget.item?.thumbnail ?? '',
          fit: BoxFit.fitWidth,
        ),
        subtitle: Text(
          '${widget.item?.title} \n ${widget.item?.price}',
        ),
        leading: Text('${widget.item?.id}'),
      ),
    );
  }
}
