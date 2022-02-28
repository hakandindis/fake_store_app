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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService(ProductNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          leading: _dropdownProject(),
          actions: [_loadingCenter()],
        ),
        body: _bodyListView(),
      ),
    );
  }

  Widget _dropdownProject() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ProductDropDown(items: state.categories ?? []);
      },
    );
  }

  Widget _bodyListView() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.items?.length ?? kZero.toInt(),
            itemBuilder: (context, index) => ProductCard(
                  model: state.items?[index],
                ));
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
