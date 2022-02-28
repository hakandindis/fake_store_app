import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_app/feature/home/model/product_model.dart';
import 'package:fake_store_app/feature/home/service/home_service.dart';
import 'package:fake_store_app/product/constant/application_constant.dart';
import 'package:collection/collection.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(const HomeState()) {
    initialComplete();
  }

  final HomeService homeService;

  Future<void> initialComplete() async {
    await Future.microtask(() {
      emit(HomeState(isInitial: true));
    });
    await Future.wait([fetchAllItems(), fetchAllCategories()]);
    emit(state.copyWith(selectItems: state.items));
  }

  void selectedCategories(String data) {
    emit(state.copyWith(
        selectItems: state.items
            ?.where((element) => element.category == data)
            .toList()));
  }

  Future<void> fetchNewItems() async {
    // emit(state.copyWith(isLoading: true));
    if (state.isLoading ?? false) {
      return;
    }
    _changeLoading();

    int _pageNumber = state.pageNumber ?? kOne.toInt();
    final response =
        await homeService.fetchAllProducts(count: ++_pageNumber * 5);

    _changeLoading();
    emit(state.copyWith(items: response, pageNumber: _pageNumber));
  }

  Future<void> fetchAllItems() async {
    _changeLoading();
    final response = await homeService.fetchAllProducts();

    emit(state.copyWith(items: response ?? []));
    _changeLoading();
  }

  void updateList(int index) {}

  Future<void> fetchAllCategories() async {
    final response = await homeService.fetchAllCategories();
    emit(state.copyWith(categories: response));
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
