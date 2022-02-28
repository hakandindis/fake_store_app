// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fake_store_app/feature/home/cubit/home_cubit.dart';
import 'package:fake_store_app/feature/home/service/home_service.dart';
import 'package:fake_store_app/product/constant/application_constant.dart';
import 'package:fake_store_app/product/network/product_network_manager.dart';
import 'package:fake_store_app/product/widget/loading_center_widget.dart';
import 'package:fake_store_app/product/widget/product_card.dart';
import 'package:fake_store_app/product/widget/product_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _listenScroll(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().fetchNewItems();
        //print("hakan");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("homeview build method executed");
    return BlocProvider(
      create: (context) => HomeCubit(HomeService(ProductNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          title: _dropdownProject(),
          centerTitle: false,
          actions: [_loadingCenter()],
        ),
        body: _bodyListView(),
      ),
    );
  }

  Widget _dropdownProject() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ProductDropDown(
          items: state.categories ?? [],
          onSelected: (String data) {
            context.read<HomeCubit>().selectedCategories(data);
          },
        );
      },
    );
  }

  Widget _bodyListView() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isInitial) {
          _listenScroll(context);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.selectItems?.length ?? kZero.toInt(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ProductCard(model: state.selectItems?[index]),
                (state.selectItems.isNotNullOrEmpty) &&
                        (index == state.selectItems!.length - 1)
                    ? const LoadingCenter()
                    : const SizedBox.shrink(),
              ],
            );
          },
        );
      },
    );
  }

  Widget _loadingCenter() {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) {
        return state.isLoading ?? false;
      },
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: state ? kOne : kZero,
          duration: context.durationLow,
          child: LoadingCenter(),
        );
      },
    );
  }
}

// class _ProductChangeDropdown extends StatelessWidget {
//   const _ProductChangeDropdown({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//         items: [DropdownMenuItem(child: Text("hakan"), value: '')],
//         onChanged: (String? value) {

//         });
//   }
// }
