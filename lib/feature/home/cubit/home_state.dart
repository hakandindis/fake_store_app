part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.items,
    this.selectItems,
    this.isLoading,
    this.categories,
    this.isInitial = false,
    this.pageNumber,
  });

  final List<ProductModel>? items;
  final List<ProductModel>? selectItems;
  final List<String>? categories;
  final bool? isLoading;
  final bool isInitial;

  final int? pageNumber;

  @override
  List<Object?> get props =>
      [items, categories, isLoading, pageNumber, selectItems];

  HomeState copyWith({
    List<ProductModel>? items,
    List<ProductModel>? selectItems,
    List<String>? categories,
    bool? isLoading,
    int? pageNumber,
  }) {
    return HomeState(
      items: items ?? this.items,
      selectItems: selectItems ?? this.selectItems,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
