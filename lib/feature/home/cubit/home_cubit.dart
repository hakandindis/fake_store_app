import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_app/feature/home/model/product_model.dart';
import 'package:fake_store_app/feature/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(const HomeState()) {
    //Future.microtask(fetchAllItems);
    Future.wait([fetchAllItems(), fetchAllCategories()]);
  }

  final HomeService homeService;

  Future<void> fetchAllItems() async {
    _changeLoading();
    final response = await homeService.fetchAllProducts();

    emit(state.copyWith(items: response ?? []));
    _changeLoading();
  }

  Future<void> fetchAllCategories() async {
    final response = await homeService.fetchAllCategories();
    emit(state.copyWith(categories: response));
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
